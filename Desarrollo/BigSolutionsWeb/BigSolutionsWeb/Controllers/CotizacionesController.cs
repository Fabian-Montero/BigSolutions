using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Rotativa.AspNetCore;
using System.Security.Cryptography;
using System.Text.Json;
using System.Transactions;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class CotizacionesController(ICotizacionesModel iCotizacionesModel, IFirebaseModel iFirebaseModel) : Controller
    {
        public IActionResult Index()
        {
            return View();
        }


        [FiltroSesiones]
        [HttpGet]
        public IActionResult ConsultarSolicitudCotizacionesCliente()
        {
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int UsuarioId = int.Parse(IdUsuarioString!);
            var resp = iCotizacionesModel.ConsultarSolicitudesCotizacionesCliente(UsuarioId);

            if (resp.Codigo == 1)
            {

                var datos = JsonSerializer.Deserialize<List<SolicitudCotizacion>>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<SolicitudCotizacion>());
            }

        }
        [FiltroSesiones]
        [HttpGet]
        public IActionResult ConsultarSolicitudCotizacionCliente(long IdSolicitudCotizacion)
        {
            var resp = iCotizacionesModel.ConsultarDetalleSolicitudCotizacionCliente(IdSolicitudCotizacion);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<SolicitudCotizacionDetalleDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new SolicitudCotizacionDetalleDTO());
            }
        }

        public IActionResult AgregarBocetoEditar()
        {
            return View();
        }
        public IActionResult EditarSolicitudCotizacionCliente()
        {
            return View();
        }

        [FiltroSesiones]
        [HttpGet]
        public IActionResult CrearSolicitudCotizacionCliente()
        {
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int UsuarioId = int.Parse(IdUsuarioString!);
            var resp = iCotizacionesModel.CrearSolicitudCotizacionVista(UsuarioId);

            if (resp.Codigo == 1)
            {
                var solicitudCotizacion = JsonSerializer.Deserialize<CrearSolicitudCotizacionVistaDTO>((JsonElement)resp.Contenido!);
                return View(solicitudCotizacion);

            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new CrearSolicitudCotizacionVistaDTO());
            }
        }
        [FiltroSesiones]
        [HttpPost]
        public IActionResult CrearSolicitudCotizacionCliente([FromBody] CrearSolicitudCotizacionDTO SolicitudCotizacion)
        {
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int UsuarioId = int.Parse(IdUsuarioString!);
            SolicitudCotizacion.IdUsuario = UsuarioId;


            var resp = iCotizacionesModel.CrearSolicitudCotizacion(SolicitudCotizacion);

            if (resp.Codigo == 1)
            {
                return Json(new { success = true, message = "Boceto generado exitosamente." });
            }
            else
            {
                return Json(new { success = false, message = "Datos inválidos" });
            }


        }

        //Admin
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarSolicitudesCotizacionesClientes()
        {
            var resp = iCotizacionesModel.ConsultarSolicitudesCotizacionesAdmin();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<SolicitudCotizacion>>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<SolicitudCotizacion>());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarSolicitudCotizacionClientes(long IdSolicitudCotizacion)
        {
            var resp = iCotizacionesModel.ConsultarDetalleSolicitudCotizacionAdmin(IdSolicitudCotizacion);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<SolicitudCotizacionDetalleDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new SolicitudCotizacionDetalleDTO());
            }
        }

        //Cotizaciones


        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult CrearCotizacionClienteConListaCliente(long IdSolicitudCotizacion)
        {
            var resp = iCotizacionesModel.CrearCotizacionVista(IdSolicitudCotizacion);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<CrearCotizacionVistaDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new CrearCotizacionVistaDTO());
            }
        }
        //Crear el pdf 
        //Subir el pdf y traerse la ruta
        //Crear la cotizacion en la base de datos
        //Si todo sale bien, por medio de transacciones, se descarga el pdf

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> GenerarCotizacion([FromBody] CrearCotizacionVistaDTO datos)
        {
            if (datos == null || datos.SolicitudCotizacion == null)
            {
                return BadRequest("Los datos de la cotización son inválidos.");
            }

            //Esto es temporal, ya que hay un bug con estos atributos
            foreach (var boceto in datos.Bocetos)
            {
                boceto.NombreCategoria ??= "Categoría por defecto";
                boceto.DescripcionUsuario ??= "Descripción no disponible";
                boceto.RutaImagenProducto ??= "ruta/default.png";
            }
            datos.SolicitudCotizacion.Estado = 1;

            // Registrar la cotización en la base de datos
            var resp = iCotizacionesModel.CrearCotizacion(datos);
            if (resp.Codigo != 1)
            {
                return Json(new { success = false, message = "No se pudo registrar la cotización en la base de datos." });
            }

            //Id de la cotizacion insertada
            if (resp.Contenido == null || !long.TryParse(resp.Contenido.ToString(), out var idCotizacion))
            {
                return Json(new { success = false, message = "Error al obtener el ID de la cotización." });
            }


            // Generar el PDF
            var pdf = new ViewAsPdf("VistaCotizacionPdfPrueba", datos)
            {
                FileName = $"Cotizacion_{datos.SolicitudCotizacion.IdSolicitudCotizacion}.pdf",
                PageSize = Rotativa.AspNetCore.Options.Size.A4,
                PageOrientation = Rotativa.AspNetCore.Options.Orientation.Portrait
            };

            //Guardar el PDF Firebase
            string downloadURL = null;

            try
            {
                // Generar el archivo PDF en memoria
                var pdfBytes = await pdf.BuildFile(ControllerContext);

                // Convertir los bytes del PDF a un MemoryStream
                using (var memoryStream = new MemoryStream(pdfBytes))
                {

                    // Guardar el PDF en Firebase en la carpeta "Cotizaciones" con el ID de cotización
                    downloadURL = await iFirebaseModel.GuardarImagen("cotizaciones", (int)idCotizacion, new FormFile(
                        memoryStream, 0, memoryStream.Length, null, pdf.FileName
                    ));
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Error al guardar el PDF en Firebase.", details = ex.Message });
            }

            // Actualizar la ruta del archivo en la base de datos
            try
            {
                var actualizarRuta = iCotizacionesModel.ActualizarRutaCotizacion(idCotizacion, downloadURL);
                if (actualizarRuta.Codigo != 1)
                {
                    return Json(new { success = false, message = "No se pudo actualizar la ruta del archivo PDF en la base de datos." });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Error al actualizar la ruta del archivo en la base de datos.", details = ex.Message });
            }

            // Devuelve la URL del PDF como respuesta
            return Json(new { success = true, pdfUrl = downloadURL });

        }

        [HttpGet]
        public IActionResult VistaCotizacionPdfPrueba(CrearCotizacionVistaDTO datos)
        {
            return View(datos);
        }

        [FiltroSesiones]
        [HttpGet]
        public IActionResult ConsultarCotizaciones()
        {

            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int UsuarioId = int.Parse(IdUsuarioString!);
            var resp = iCotizacionesModel.ConsultarCotizacionesCliente(UsuarioId);

            if (resp.Codigo == 1)
            {

                var datos = JsonSerializer.Deserialize<List<Cotizacion>>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<Cotizacion>());
            }
        }
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult CotizacionesAdministrador()
        {

            var resp = iCotizacionesModel.ConsultarCotizacionesAdmin();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<Cotizacion>>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(new List<SolicitudCotizacion>());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarDetalleCotizacion(long IdCotizacion)
        {
            var resp = iCotizacionesModel.ObtenerDetalleCotizacion(IdCotizacion);

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<ConsultarCotizacionDTO>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return View(null);
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult EditarCotizacion(long IdCotizacion)
        {
            var resp = iCotizacionesModel.ObtenerDetalleCotizacion(IdCotizacion);

            if (resp.Codigo == 1)
            {
               
                var cotizacionExistente = JsonSerializer.Deserialize<ConsultarCotizacionDTO>((JsonElement)resp.Contenido!);

                // Mapear la información de ConsultarCotizacionDTO a CrearCotizacionVistaDTO
                var nuevaCotizacion = new CrearCotizacionVistaDTO
                {
                    Usuario = cotizacionExistente.Usuario,
                    SolicitudCotizacion = new SolicitudCotizacion
                    {
                        IdSolicitudCotizacion = cotizacionExistente.SolicitudCotizacion.IdSolicitudCotizacion,
                        Descripcion = cotizacionExistente.SolicitudCotizacion.Descripcion,
                        Moneda = cotizacionExistente.SolicitudCotizacion.Moneda
                    },
                    Bocetos = cotizacionExistente.Bocetos.Select(b => new BocetoCotizacionDTO
                    {
                        IdBoceto = b.IdBoceto,
                        NombreProducto = b.NombreProducto,
                        PrecioUnitarioColones = b.PrecioUnitarioColones,
                        PrecioUnitarioDolares = b.PrecioUnitarioDolares,
                        Cantidad = b.Cantidad,
                        FechaCreacion = b.FechaCreacion,
                        RutaImagen = b.RutaImagen
                    }).ToList(),
                    SubTotal = cotizacionExistente.SubTotal,
                    TotalImpuestos = cotizacionExistente.TotalImpuestos,
                    Total = cotizacionExistente.Total,
                    DescripcionCotizacion = cotizacionExistente.DescripcionCotizacion
                };

                // Pasar los datos a la vista de crear cotización
                return View("CrearCotizacionClienteConListaCliente", nuevaCotizacion);
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return RedirectToAction("ConsultarCotizaciones");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public async Task<JsonResult> EliminarCotizacion(long IdCotizacion)
        {
            var resp = iCotizacionesModel.EliminarCotizacion(IdCotizacion);

            if (resp.Codigo == 1)
            {
                // Eliminar el archivo de Firebase
                bool imagenEliminada = await iFirebaseModel.EliminarImagen("cotizaciones", (int)IdCotizacion);

                if (imagenEliminada)
                {
                    return Json(new { success = true, message = "La cotización ha sido eliminada correctamente." });
                }
                else
                {
                    return Json(new { success = true, message = "La cotización fue eliminada, pero no se pudo eliminar el archivo en Firebase." });
                }
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar la cotización: " + resp.Mensaje });
            }
        }
    }
}
