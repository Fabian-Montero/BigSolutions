using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class ContabilidadController : Controller
    {
        //Facturas Venta
        public IActionResult ConsultarFacturasVenta()
        {
            return View();
        }
        public IActionResult AgregarFacturasVenta()
        {
            return View();
        }

        //Facturas Pendientes
        public IActionResult ConsultarFacturasPendientes()
        {
            return View();
        }
        public IActionResult AgregarFacturasPendientes()
        {
            return View();
        }
        public IActionResult EditarFacturasPendientes()
        {
            return View();
        }

        //Comprobantes de Pago
        public IActionResult ConsultarComprobantesDePago()
        {
            return View();
        }
        public IActionResult AgregarComprobantesDePago()
        {
            return View();
        }
        public IActionResult ComprobantesDePago()
        {
            return View();
        }
    }
}
