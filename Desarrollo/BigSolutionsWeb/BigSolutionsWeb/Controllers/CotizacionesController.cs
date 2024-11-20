using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class CotizacionesController(ICotizacionesModel iCotizacionesModel) : Controller
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
                /*foreach (var solicitud in datos)
                {*/
                    // Validar si Moneda es NULL o no válida
                    /*if (Enum.IsDefined(typeof(Moneda), solicitud.Moneda))
                    {
                        solicitud.Moneda = (Moneda)solicitud.Moneda;
                    }
                    else
                    {
                        solicitud.Moneda = null; // O asigna un valor predeterminado como Moneda.Colones si es necesario
                    }*/
                /*}*/
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
        public IActionResult CrearCotizacionClienteConListaCliente()
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
    }
}
