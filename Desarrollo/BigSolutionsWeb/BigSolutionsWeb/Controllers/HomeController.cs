using BigSolutionsWeb.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [FiltroSesiones]
        [HttpGet]
        [AutorizacionFiltro]
        public IActionResult Index()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
