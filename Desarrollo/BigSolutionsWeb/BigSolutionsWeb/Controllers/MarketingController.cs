using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class MarketingController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ConsultarGruposUsuarios() {
            return View();
        }

        public IActionResult ConsultarGrupoUsuarios()
        {
            return View();
        }

        public IActionResult AgregarGrupoUsuarios()
        {
            return View();
        }

        public IActionResult EditarGrupoUsuarios()
        {
            return View();
        }

        //Correos
        public IActionResult ConsultarCorreos()
        {
            return View();
        }

        public IActionResult ConsultarCorreo()
        {
            return View();
        }

        public IActionResult AgregarCorreo()
        {
            return View();
        }


        public IActionResult VistaPreviaCorreo()
        {
            return View();
        }




    }
}
