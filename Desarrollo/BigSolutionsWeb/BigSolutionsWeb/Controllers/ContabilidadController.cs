using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class ContabilidadController(IContabilidadModel iContabilidadModel, IFirebaseModel iFirebaseModel) : Controller
    {
        //Facturas Venta

        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarFacturasVenta()
        {
            var resp = iContabilidadModel.ConsultarFacturas();

            if (resp.Codigo == 1)
            {
                var facturas = ((JsonElement)resp.Contenido).Deserialize<List<FacturaDTO>>();
                return View(facturas);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las facturas.";
                return View(new List<FacturaDTO>());
            }
        }

        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarFacturasVenta()
        {
            var resp = iContabilidadModel.CargarAgregarFactura();

            if (resp.Codigo == 1)
            {
                var facturas = ((JsonElement)resp.Contenido).Deserialize<CrearFacturaDTO>();
                return View(facturas);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las órdenes.";
                return View(new CrearFacturaDTO());
            }
        }

        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarFacturasVenta(CrearFacturaDTO Factura)
        {
            try
            {
                if (Factura == null || Factura.IdOrden == null || Factura.FacturaVentaArchivo == null || string.IsNullOrEmpty(Factura.NumFacturaVenta))
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Subir la factura a Firebase
                var rutaFacturaVenta = await iFirebaseModel.GuardarImagen(
                    "facturas-venta",
                    (int)Factura.IdOrden,
                    Factura.FacturaVentaArchivo
                );

                Factura.RutaFacturaVenta = rutaFacturaVenta;

                // Guardar factura en la base de datos
                var resp = iContabilidadModel.AgregarFactura(Factura);

                if (resp.Codigo == 1)
                {
                    return Ok("Factura creada exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al crear la factura: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public async Task<JsonResult> EliminarFactura(long IdOrden)
        {
            var resp = iContabilidadModel.EliminarFactura(IdOrden);

            if (resp.Codigo == 1)
            {
                // Eliminar el archivo de Firebase
                bool imagenEliminada = await iFirebaseModel.EliminarImagen("facturas-venta", (int)IdOrden);

                if (imagenEliminada)
                {
                    return Json(new { success = true, message = "La factura ha sido eliminada correctamente." });
                }
                else
                {
                    return Json(new { success = true, message = "La factura fue eliminada, pero no se pudo eliminar el archivo." });
                }
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar la factura: " + resp.Mensaje });
            }
        }

        //Comprobantes de Pago
        public IActionResult ConsultarComprobantesDePago()
        {
            var resp = iContabilidadModel.ConsultarComprobantes();

            if (resp.Codigo == 1)
            {
                var comprobantes = ((JsonElement)resp.Contenido).Deserialize<List<ComprobantePago>>();
                return View(comprobantes);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar los comprobantes.";
                return View(new List<FacturaDTO>());
            }
        }

        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarComprobantesDePago()
        {
            var resp = iContabilidadModel.CargarAgregarComprobantes();

            if (resp.Codigo == 1)
            {
                var comprobantes = ((JsonElement)resp.Contenido).Deserialize<CrearComprobanteDTO>();
                return View(comprobantes);
            }
            else
            {
                ViewBag.ErrorMessage = "No se pudieron cargar las órdenes.";
                return View(new CrearComprobanteDTO());
            }
        }

        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarComprobantesDePago(CrearComprobanteDTO Comprobante)
        {
            try
            {
                if (Comprobante == null || Comprobante.IdOrden == null || Comprobante.ArchivoComprobante == null || string.IsNullOrEmpty(Comprobante.DescripcionComprobante))
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                // Subir el comprobante a Firebase
                var rutaComprobante = await iFirebaseModel.GuardarImagen(
                    "comprobantes-pago",
                    (int)Comprobante.IdOrden,
                    Comprobante.ArchivoComprobante
                );

                Comprobante.RutaComprobante = rutaComprobante;

                // Guardar el comprobante en la base de datos
                var resp = iContabilidadModel.AgregarComprobante(Comprobante);

                if (resp.Codigo == 1)
                {
                    return Ok("Comprobante de pago registrado exitosamente.");
                }
                else
                {
                    return StatusCode(500, $"Error al registrar el comprobante de pago: {resp.Mensaje}");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno del servidor: {ex.Message}");
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public async Task<JsonResult> EliminarComprobante(long IdOrdenDetalleComprobantes, long IdOrden)
        {
            var resp = iContabilidadModel.EliminarComprobante(IdOrdenDetalleComprobantes);

            if (resp.Codigo == 1)
            {
                // Eliminar el archivo de Firebase
                bool imagenEliminada = await iFirebaseModel.EliminarImagen("comprobantes-pago", (int)IdOrden);

                if (imagenEliminada)
                {
                    return Json(new { success = true, message = "El comprobante ha sido eliminado correctamente." });
                }
                else
                {
                    return Json(new { success = true, message = "El comprobante fue eliminado, pero no se pudo eliminar el archivo." });
                }
            }
            else
            {
                return Json(new { success = false, message = "Error al eliminar el comprobante: " + resp.Mensaje });
            }
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
    }
}
