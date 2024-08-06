using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class OrdenesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ConsultarOrdenesCliente()
        {
            return View();
        }

        public IActionResult ConsultarOrdenCliente()
        {
            return View();
        }

        public IActionResult CrearOrdenCliente()
        {
            return View();
        }
    }
}
