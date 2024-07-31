using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class BocetoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult ConsultarProductosBoceto()
        {
            return View();
        }

        [HttpGet]
        public IActionResult ConsultarBocetosCliente()
        {
            return View();
        }
    }
}
