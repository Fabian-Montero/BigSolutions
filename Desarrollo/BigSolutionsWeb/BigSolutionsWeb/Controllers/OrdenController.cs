using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class OrdenController(IOrdenModel iOrdenModel) : Controller
    {
        [FiltroSesiones]
        [HttpGet]
        public IActionResult CargarCrearOrdenCliente()
        {
            // Llamar al API para obtener el DTO

            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            int IdUsuario = int.Parse(IdUsuarioString!);


            var resp = iOrdenModel.CargarCrearOrdenCliente(IdUsuario);

            if (resp.Codigo == 1)
            {
                // Deserializar el contenido como CrearOrdenClienteDTO
                var crearOrdenClienteDTO = ((JsonElement)resp.Contenido).Deserialize<CrearOrdenClienteDTO>();

                return View(crearOrdenClienteDTO);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las cotizaciones.";
                return View(new CrearOrdenClienteDTO());
            }
        }
    }
}
