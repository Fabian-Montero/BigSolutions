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
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace BigSolutionsWeb.Controllers
{
    public class CotizacionesController(ICotizacionesModel iCotizacionesModel, IFirebaseModel iFirebaseModel) : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

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
                //Mensaje de error
                return View(new List<SolicitudCotizacion>());
            }

        }
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
                //Mensaje de error
                return View(new SolicitudCotizacionDetalleDTO());
            }
        }

        public IActionResult ConsultarCotizaciones()
        {
            return View();
        }
        public IActionResult CotizacionesAdministrador()
        {
            return View();
        }
        
  
        public IActionResult AgregarBocetoEditar()
        {
            return View();
        }
        public IActionResult EditarSolicitudCotizacionCliente()
        {
            return View();
        }
        

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
                //Mensaje de error
                return View(new CrearSolicitudCotizacionVistaDTO());
            }
        }

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

        public IActionResult ConsultarCotizacionesCliente()
        {
            return View();
        }


        //Admin
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
                //Mensaje de error
                return View(new List<SolicitudCotizacion>());
            }
        }

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
                //Mensaje de error
                return View(new SolicitudCotizacionDetalleDTO());
            }
        }

        //Cotizaciones

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
                //Mensaje de error
                return View(new SolicitudCotizacionDetalleDTO());
            }
        }
        //Crear el pdf 
        //Subir el pdf y traerse la ruta
        //Crear la cotizacion en la base de datos
        //Si todo sale bien, por medio de transacciones, se descarga el pdf

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

            // Devolver el PDF generado
            return pdf;
        }

        [HttpGet]
        public IActionResult VistaCotizacionPdfPrueba(CrearCotizacionVistaDTO datos)
        {
            return View(datos);
        }
    }
}
