using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class InventarioController : Controller
    {
        public IActionResult ConsultarInventario()
        {
            return View();
        }
        public IActionResult AgregarInventario()
        {
            return View();
        }
        public IActionResult EditarInventario()
        {
            return View();
        }
    }
}
