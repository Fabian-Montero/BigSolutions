
using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class OrdenesController(IOrdenModel iOrdenModel, IFirebaseModel iFirebaseModel) : Controller
    {
        [FiltroSesiones]
        [HttpGet]
        public IActionResult ClienteConsultarOrdenes()
        {
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int IdUsuario = int.Parse(IdUsuarioString!);

            var resp = iOrdenModel.ConsultarOrdenesCliente(IdUsuario);

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<Orden>>((JsonElement)resp.Contenido!);
                return View(datos);
            }

            else 
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<Orden>());
            }
        }

        [FiltroSesiones]
        [HttpGet]
        public IActionResult CargarCrearOrdenCliente()
        {
          
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int IdUsuario = int.Parse(IdUsuarioString!);

            var resp = iOrdenModel.CargarCrearOrdenCliente(IdUsuario);

            if (resp.Codigo == 1)
            {

                var crearOrdenClienteDTO = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenClienteDTO>();
                return View(crearOrdenClienteDTO);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las cotizaciones.";
                return View(new CrearOrdenClienteDTO());
            }
        }
        [FiltroSesiones]
        [HttpPost]
        public async Task<IActionResult> CrearOrdenCliente([FromForm] CrearOrdenClienteDTO crearOrdenClienteDTO)
        {
            try
            {
                var idUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
                crearOrdenClienteDTO.IdUsuario = int.Parse(idUsuarioString!);

                if (crearOrdenClienteDTO == null) return BadRequest("El objeto CrearOrdenClienteDTO es nulo.");

                var resp = await iOrdenModel.CrearOrdenCliente(crearOrdenClienteDTO);

                if (resp.Codigo == 1)
                {
                    var respuesta = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenClienteRespuestaDTO>();
                    var idOrden = respuesta.IdOrden;
                    var idComprobante = respuesta.IdComprobante!;

                    if (idComprobante != null)
                    {
                        var rutaComprobante= await iFirebaseModel.GuardarImagen("comprobantes", (int)idComprobante, crearOrdenClienteDTO.ComprobantePago.ArchivoComprobante);
                        ComprobantePago Comprobante = new ComprobantePago();
                        Comprobante.RutaComprobante = rutaComprobante;
                        Comprobante.IdOrdenDetalleComprobantes = (long)idComprobante; 
                        iOrdenModel.ActualizarRutaComprobante(Comprobante);
                    }

                    var rutaOrdenCompra = await iFirebaseModel.GuardarImagen("ordenes-compra", (int)idOrden, crearOrdenClienteDTO.OrdenCompra);
                    CrearOrdenClienteDTO Orden = new CrearOrdenClienteDTO();
                    Orden.RutaOrdenCompra = rutaOrdenCompra;
                    Orden.IdOrden = idOrden;
                    iOrdenModel.ActualizarRutaOrdenCompra(Orden);

                    return Ok("Orden creada y archivos subidos correctamente.");
                }
                else
                {
                    return StatusCode(500, "Error al crear la orden.");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [HttpGet]
        public IActionResult EditarOrdenCliente(int IdOrden)
        {
            var resp = iOrdenModel.CargarEditarOrdenCliente(IdOrden);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<CrearOrdenClienteDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new CrearOrdenClienteDTO());
            }
        }
        [FiltroSesiones]
        [HttpPost]
        public async Task<IActionResult> EditarOrdenCliente([FromForm] CrearOrdenClienteDTO editarOrdenClienteDTO)
        {
            try
            {
                if (editarOrdenClienteDTO == null || editarOrdenClienteDTO.IdOrden == null)
                {
                    return BadRequest("El objeto es nulo o el Id de la orden no está definido.");
                }

                if (editarOrdenClienteDTO.ComprobantePago.ArchivoComprobante != null &&
                    !string.IsNullOrWhiteSpace(editarOrdenClienteDTO.ComprobantePago.DescripcionComprobante))
                {
                    
                    var resp = await iOrdenModel.ActualizarOrdenCliente(editarOrdenClienteDTO);
                    
                    if (resp.Codigo != 1)
                    {
                        return StatusCode(500, $"Error al agregar el comprobante: {resp.Mensaje}");
                    }

                    var respuesta = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenAdminRespuestaDTO>();
                    var idComprobante = respuesta.IdComprobante;


                    var rutasDTO = new ActualizarRutasDTO();

                    // Guardar el comprobante en Firebase
                    rutasDTO.IdOrdenDetalleComprobantes = idComprobante;
                    rutasDTO.RutaComprobante = await iFirebaseModel.GuardarImagen(
                        "comprobantes",
                        (int)idComprobante,
                        editarOrdenClienteDTO.ComprobantePago.ArchivoComprobante
                    );

                    await iOrdenModel.ActualizarRutasArchivos(rutasDTO);
                    return Ok("Comprobante agregado correctamente.");
                }

                return StatusCode(500, $"Error a la hora de editar la orden");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [HttpGet]
        public IActionResult ConsultarOrdenCliente(int IdOrden)
        {
            var resp = iOrdenModel.ConsultarVistaOrden(IdOrden);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<ConsultarVistaOrdenDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new ConsultarVistaOrdenDTO());
            }
        }


        //Ordenes admin
        public IActionResult ConsultarOrdenesClientesAdmin()
        {
            var resp = iOrdenModel.ConsultarOrdenesAdmin();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<Orden>>((JsonElement)resp.Contenido!);
                return View(datos);
            }

            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<Orden>());
            }
        }

        [FiltroAdmin]
        [FiltroSesiones]
        [HttpGet]
        public IActionResult CrearOrdenClienteAdmin()
        {
            var resp = iOrdenModel.CargarCrearOrdenAdmin();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<CrearOrdenAdminDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }

            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new CrearOrdenAdminDTO());
            }
        }

        [FiltroAdmin]
        [FiltroSesiones]
        [HttpPost]
        public async Task<IActionResult> CrearOrdenClienteAdmin([FromForm] CrearOrdenAdminDTO crearOrdenAdminDTO)
        {
            try
            {
                if (crearOrdenAdminDTO == null)
                    return BadRequest("El objeto CrearOrdenAdminDTO es nulo.");

                if (crearOrdenAdminDTO.OrdenCompraArchivo == null)
                    return BadRequest("El archivo de la orden de compra es obligatorio.");

                // Crear la orden y obtener el IdOrden
                var resp = await iOrdenModel.CrearOrdenAdmin(crearOrdenAdminDTO);

                if (resp.Codigo == 0)
                {
                    return StatusCode(500, $"Error al crear la orden: {resp.Mensaje}");
                }

                var respuesta = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenAdminRespuestaDTO>();
                var idOrden = respuesta.IdOrden;
                var idComprobante = respuesta.IdComprobante;

                // Subir los archivos
                var rutasDTO = new ActualizarRutasDTO { IdOrden = idOrden };

                rutasDTO.RutaOrdenCompra = await iFirebaseModel.GuardarImagen(
                    "ordenes-compra",
                    (int)idOrden,
                    crearOrdenAdminDTO.OrdenCompraArchivo
                );

                if (crearOrdenAdminDTO.FacturaVentaArchivo != null)
                {
                    rutasDTO.RutaFacturaVenta = await iFirebaseModel.GuardarImagen(
                        "facturas-venta",
                        (int)idOrden,
                        crearOrdenAdminDTO.FacturaVentaArchivo
                    );
                }

                if (crearOrdenAdminDTO.BoletaEntregaArchivo != null)
                {
                    rutasDTO.RutaBoletaEntrega = await iFirebaseModel.GuardarImagen(
                        "boletas-entrega",
                        (int)idOrden,
                        crearOrdenAdminDTO.BoletaEntregaArchivo
                    );
                }

                if (crearOrdenAdminDTO.ComprobantePago.ArchivoComprobante != null)
                {
                    rutasDTO.RutaComprobante = await iFirebaseModel.GuardarImagen(
                        "comprobantes",
                        (int)idComprobante,
                        crearOrdenAdminDTO.ComprobantePago.ArchivoComprobante
                    );
                }

                // Actualizar rutas de los archivos
                var actualizacionResp = await iOrdenModel.ActualizarRutasArchivos(rutasDTO);

                if (actualizacionResp.Codigo == 1)
                    return Ok("Orden creada y archivos subidos correctamente.");
                else
                    return StatusCode(500, $"Error al actualizar las rutas de los archivos: {actualizacionResp.Mensaje}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroAdmin]
        [FiltroSesiones]
        [HttpGet]
        public IActionResult EditarOrdenClienteAdmin(int IdOrden)
        {

            var resp = iOrdenModel.CargarEditarOrdenAdmin(IdOrden);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<CrearOrdenAdminDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new CrearOrdenAdminDTO());
            }
        }

        [FiltroAdmin]
        [FiltroSesiones]
        [HttpPost]
        public async Task<IActionResult> EditarOrdenClienteAdmin([FromForm] CrearOrdenAdminDTO actualizarOrdenAdminDTO)
        {
            try
            {
                if (actualizarOrdenAdminDTO == null)
                    return BadRequest("El objeto EditarOrdenAdminDTO es nulo.");

                
                var resp = await iOrdenModel.ActualizarOrdenAdmin(actualizarOrdenAdminDTO);

                if (resp.Codigo == 0)
                {
                    return StatusCode(500, $"Error al editar la orden: {resp.Mensaje}");
                }

                
                var respuesta = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenAdminRespuestaDTO>();
                var idOrden = actualizarOrdenAdminDTO.IdOrden.Value;
                var idComprobante = respuesta.IdComprobante;

                // Gestionar archivos
                var rutasDTO = new ActualizarRutasDTO { IdOrden = idOrden };

                if (actualizarOrdenAdminDTO.OrdenCompraArchivo != null)
                {
                    rutasDTO.RutaOrdenCompra = await iFirebaseModel.GuardarImagen(
                        "ordenes-compra",
                        (int)idOrden,
                        actualizarOrdenAdminDTO.OrdenCompraArchivo
                    );
                }

                if (actualizarOrdenAdminDTO.FacturaVentaArchivo != null)
                {
                    rutasDTO.RutaFacturaVenta = await iFirebaseModel.GuardarImagen(
                        "facturas-venta",
                        (int)idOrden,
                        actualizarOrdenAdminDTO.FacturaVentaArchivo
                    );
                }

                if (actualizarOrdenAdminDTO.BoletaEntregaArchivo != null)
                {
                    rutasDTO.RutaBoletaEntrega = await iFirebaseModel.GuardarImagen(
                        "boletas-entrega",
                        (int)idOrden,
                        actualizarOrdenAdminDTO.BoletaEntregaArchivo
                    );
                }

                if (actualizarOrdenAdminDTO.ComprobantePago.ArchivoComprobante != null)
                {
                    rutasDTO.IdOrdenDetalleComprobantes = idComprobante;
                    rutasDTO.RutaComprobante = await iFirebaseModel.GuardarImagen(
                        "comprobantes",
                        (int)idComprobante,
                        actualizarOrdenAdminDTO.ComprobantePago.ArchivoComprobante
                    );
                }

                // Actualizar las rutas de los archivos si hay nuevos archivos
                if (!string.IsNullOrEmpty(rutasDTO.RutaOrdenCompra) ||
                    !string.IsNullOrEmpty(rutasDTO.RutaFacturaVenta) ||
                    !string.IsNullOrEmpty(rutasDTO.RutaBoletaEntrega) ||
                    !string.IsNullOrEmpty(rutasDTO.RutaComprobante))
                {
                    var actualizacionResp = await iOrdenModel.ActualizarRutasArchivos(rutasDTO);

                    if (actualizacionResp.Codigo != 1)
                    {
                        return StatusCode(500, $"Orden editada pero hubo un error al actualizar las rutas de los archivos: {actualizacionResp.Mensaje}");
                    }
                }

                return Ok("Orden editada y archivos gestionados correctamente.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }
        public IActionResult ConsultarOrdenesPendientesCliente()
        {
            var resp = iOrdenModel.ConsultarOrdenesAdmin();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<Orden>>((JsonElement)resp.Contenido!);
                var ordenesPendientes = datos
                    .Where(o => o.Estado != EstadoOrden.Completada && o.Estado != EstadoOrden.Cancelada)
                    .ToList();
                return View(ordenesPendientes);
            }

            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<Orden>());
            }
        }

        public IActionResult ConsultarOrdenClienteAdmin(int IdOrden)
        {
            var resp = iOrdenModel.ConsultarVistaOrden(IdOrden);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<ConsultarVistaOrdenDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new ConsultarVistaOrdenDTO());
            }
        }
        
        
        public IActionResult EditarOrdenPendienteCliente()
        {
            return View();
        }

        public IActionResult ConsultarOrdenesPendientesClientes()
        {
            return View();
        }
    }
}
