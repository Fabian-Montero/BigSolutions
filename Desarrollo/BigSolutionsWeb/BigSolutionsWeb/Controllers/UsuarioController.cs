using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult InicioSesion()
        {
            return View();
        }

        public IActionResult Registro()
        {
            return View();
        }

        public IActionResult ConsultarUsuariosPrueba()
        {
            return View();
        }
        public IActionResult SinUsuariosRegistrados()
        {
            return View();
        }
        public IActionResult ErrorSQL_Usuarios()
        {
        return View();
        }
        public IActionResult ActualizarGeneral()
        {
            return View();
        }
        public IActionResult ActualizacionExitosa()
        {
            return View();
        }
        public IActionResult Actualizacion_Error_InfoIncompleta()
        {
            return View();
        }
        public IActionResult Actualizacion_ERROR_DatosExistentes()
        {
            return View();
        }
        public IActionResult EliminacionExitosa()
        {
            return View();
        }
    }
}
