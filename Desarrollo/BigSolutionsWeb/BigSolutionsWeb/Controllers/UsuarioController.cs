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
    }
}
