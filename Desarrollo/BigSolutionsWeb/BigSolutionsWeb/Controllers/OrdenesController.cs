using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class OrdenesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ClienteConsultarOrdenes()
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

        public IActionResult EditarOrdenCliente()
        {
            return View();
        }


        //Ordenes admin
        public IActionResult ConsultarOrdenesClientesAdmin()
        {
            return View();
        }
        public IActionResult ConsultarOrdenesPendientesClientes()
        {
            return View();
        }

        public IActionResult ConsultarOrdenClienteAdmin()
        {
            return View();
        }

        public IActionResult CrearOrdenClienteAdmin()
        {
            return View();
        }

        public IActionResult EditarOrdenClienteAdmin()
        {
            return View();
        }
        public IActionResult ConsultarOrdenesPendientesCliente()
        {
            return View();
        }
        public IActionResult EditarOrdenPendienteCliente()
        {
            return View();
        }
    }
}
