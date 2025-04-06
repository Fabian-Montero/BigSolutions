using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class ContabilidadController(IContabilidadModel iContabilidadModel, IFirebaseModel iFirebaseModel) : Controller
    {
        //Facturas Venta

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarFacturasVenta()
        {
            var resp = iContabilidadModel.ConsultarFacturas();

            if (resp.Codigo == 1)
            {
                var facturas = ((JsonElement)resp.Contenido).Deserialize<List<FacturaDTO>>();
                return View(facturas);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las facturas.";
                return View(new List<FacturaDTO>());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarFacturasVenta()
        {
            var resp = iContabilidadModel.CargarAgregarFactura();

            if (resp.Codigo == 1)
            {
                var facturas = ((JsonElement)resp.Contenido).Deserialize<CrearFacturaDTO>();
                return View(facturas);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las órdenes.";
                return View(new CrearFacturaDTO());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarFacturasVenta(CrearFacturaDTO Factura)
        {
            try
            {
                if (Factura == null || Factura.IdOrden == null || Factura.FacturaVentaArchivo == null || string.IsNullOrEmpty(Factura.NumFacturaVenta))
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Subir la factura a Firebase
                var rutaFacturaVenta = await iFirebaseModel.GuardarImagen(
                    "facturas-venta",
                    (int)Factura.IdOrden,
                    Factura.FacturaVentaArchivo
                );

                Factura.RutaFacturaVenta = rutaFacturaVenta;

                // Guardar factura en la base de datos
                var resp = iContabilidadModel.AgregarFactura(Factura);

                if (resp.Codigo == 1)
                {
                    return Ok("Factura creada exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al crear la factura: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public async Task<JsonResult> EliminarFactura(long IdOrden)
        {
            var resp = iContabilidadModel.EliminarFactura(IdOrden);

            if (resp.Codigo == 1)
            {
                // Eliminar el archivo de Firebase
                bool imagenEliminada = await iFirebaseModel.EliminarImagen("facturas-venta", (int)IdOrden);

                if (imagenEliminada)
                {
                    return Json(new { success = true, message = "La factura ha sido eliminada correctamente." });
                }
                else
                {
                    return Json(new { success = true, message = "La factura fue eliminada, pero no se pudo eliminar el archivo." });
                }
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar la factura: " + resp.Mensaje });
            }
        }

        //Comprobantes de Pago
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarComprobantesDePago()
        {
            var resp = iContabilidadModel.ConsultarComprobantes();

            if (resp.Codigo == 1)
            {
                var comprobantes = ((JsonElement)resp.Contenido).Deserialize<List<ComprobantePago>>();
                return View(comprobantes);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar los comprobantes.";
                return View(new List<ComprobantePago>());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarComprobantesDePago()
        {
            var resp = iContabilidadModel.CargarAgregarComprobantes();

            if (resp.Codigo == 1)
            {
                var comprobantes = ((JsonElement)resp.Contenido).Deserialize<CrearComprobanteDTO>();
                return View(comprobantes);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las órdenes.";
                return View(new CrearComprobanteDTO());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarComprobantesDePago(CrearComprobanteDTO Comprobante)
        {
            try
            {
                if (Comprobante == null || Comprobante.IdOrden == null || Comprobante.ArchivoComprobante == null || string.IsNullOrEmpty(Comprobante.DescripcionComprobante))
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Subir el comprobante a Firebase
                var rutaComprobante = await iFirebaseModel.GuardarImagen(
                    "comprobantes-pago",
                    (int)Comprobante.IdOrden,
                    Comprobante.ArchivoComprobante
                );

                Comprobante.RutaComprobante = rutaComprobante;

                // Guardar el comprobante en la base de datos
                var resp = iContabilidadModel.AgregarComprobante(Comprobante);

                if (resp.Codigo == 1)
                {
                    return Ok("Comprobante de pago registrado exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al registrar el comprobante de pago: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public async Task<JsonResult> EliminarComprobante(long IdOrdenDetalleComprobantes, long IdOrden)
        {
            var resp = iContabilidadModel.EliminarComprobante(IdOrdenDetalleComprobantes);

            if (resp.Codigo == 1)
            {
                // Eliminar el archivo de Firebase
                bool imagenEliminada = await iFirebaseModel.EliminarImagen("comprobantes-pago", (int)IdOrden);

                if (imagenEliminada)
                {
                    return Json(new { success = true, message = "El comprobante ha sido eliminado correctamente." });
                }
                else
                {
                    return Json(new { success = true, message = "El comprobante fue eliminado, pero no se pudo eliminar el archivo." });
                }
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar el comprobante: " + resp.Mensaje });
            }
        }
        
        //Facturas Pendientes
        
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarFacturasPendientes()
        {
            var resp = iContabilidadModel.ConsultarFacturasPendientes();

            if (resp.Codigo == 1)
            {
                var comprobantes = ((JsonElement)resp.Contenido).Deserialize<List<FacturaPendiente>>();
                return View(comprobantes);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las facturas pendientes.";
                return View(new List<FacturaPendiente>());
            }
        }
        
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarFacturasPendientes()
        {
            var resp = iContabilidadModel.CargarAgregarFacturasPendientes();

            if (resp.Codigo == 1)
            {
                var facturaPendiente = ((JsonElement)resp.Contenido).Deserialize<CrearFacturaPendienteDTO>();
                return View(facturaPendiente);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las órdenes.";
                return View(new CrearFacturaPendienteDTO());
            }
        }
        
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarFacturaPendiente(CrearFacturaPendienteDTO FacturaPendiente)
        {
            try
            {
                if (FacturaPendiente == null 
                    || FacturaPendiente.IdOrden == null 
                    || FacturaPendiente.Subtotal == null 
                    || FacturaPendiente.ImpuestoIVA == null 
                    || FacturaPendiente.Total == null)
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Guardar la factura pendiente en la base de datos
                var resp = iContabilidadModel.AgregarFacturaPendiente(FacturaPendiente);

                if (resp.Codigo == 1)
                {
                    return Ok("Factura pendiente registrada exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al registrar la factura pendiente: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult EditarFacturasPendientes(long id)
        {
            var resp = iContabilidadModel.ConsultarFacturaPendiente(id);

            if (resp.Codigo == 1)
            {
                var facturaPendiente = ((JsonElement)resp.Contenido).Deserialize<CrearFacturaPendienteDTO>();
                return View(facturaPendiente);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudo cargar la factura pendiente.";
                return View(new CrearFacturaPendienteDTO());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public IActionResult EditarFacturaPendiente(CrearFacturaPendienteDTO FacturaPendiente)
        {
            try
            {
                if (FacturaPendiente == null
                    || FacturaPendiente.IdFacturaPendiente <= 0
                    || FacturaPendiente.IdOrden == null
                    || FacturaPendiente.Subtotal == null
                    || FacturaPendiente.ImpuestoIVA == null
                    || FacturaPendiente.Total == null)
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Actualizar la factura pendiente en la base de datos
                var resp = iContabilidadModel.ActualizarFacturaPendiente(FacturaPendiente);

                if (resp.Codigo == 1)
                {
                    return Ok("Factura pendiente actualizada exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al actualizar la factura pendiente: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor");
            }
        }
        
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public JsonResult EliminarFacturaPendiente(long IdFacturaPendiente)
        {
            var resp = iContabilidadModel.EliminarFacturaPendiente(IdFacturaPendiente);
    
            if (resp.Codigo == 1)
            {
                return Json(new { success = true, message = "La factura pendiente ha sido eliminada correctamente." });
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar la factura pendiente: " + resp.Mensaje });
            }
        }
    }
}
