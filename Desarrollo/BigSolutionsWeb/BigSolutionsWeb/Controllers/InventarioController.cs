using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Configuration;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Text.Json;
using System.Configuration;

namespace BigSolutionsWeb.Controllers
{
    [AutorizacionFiltro]
    public class InventarioController(IProductoModel iProductoModel, ICategoriaModel iCategoriaModel, IFirebaseModel iFirebaseModel) : Controller
    {
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult ConsultarInventario()
        {
            var resp = iProductoModel.ConsultarProductos();

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<List<Producto>>((JsonElement)resp.Contenido!);
                return View(datos);
            }
            else
            {
                return View(new List<Producto>());
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult AgregarInventario()
        {
            ConsultarTiposCategorias();
            return View();
        }
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> AgregarInventario(Producto ent, [FromForm] IFormFile ImagenProducto)
        {
            List<string> extensiones = new List<string>() { ".png", ".jpg", ".PNG", ".JPG"};
            string extension = Path.GetExtension(ImagenProducto.FileName);
            if (!extensiones.Contains(extension))
            {
                ViewBag.msj = "El formato de la imagen no es válido, debe ser uno de los siguientes formatos: " + string.Join(", ", extensiones);
                ConsultarTiposCategorias();
                return View();
            }

            var resp = iProductoModel.AgregarProducto(ent);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<Producto>((JsonElement)resp.Contenido!);
                int idProducto = datos!.IdProducto;

                Producto producto = new Producto();
                producto.RutaImagen = await iFirebaseModel.GuardarImagen("productos", idProducto, ImagenProducto);
                producto.IdProducto = idProducto;

                iProductoModel.ActualizarRutaImagen(producto);

                return RedirectToAction("ConsultarInventario", "Inventario");

            }
            else
            {

                ViewBag.msj = resp.Mensaje;
                return View();
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult EditarInventario(int id)
        {
            var resp = iProductoModel.ConsultarProducto(id);
            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<Producto>((JsonElement)resp.Contenido!);
                ViewBag.RutaImagen = datos!.RutaImagen;
                ConsultarTiposCategorias();
                return View(datos);
            }
            else
            {
                ViewBag.msj = resp.Mensaje;
                ConsultarTiposCategorias();
                return View();
            }
        }
        [FiltroSesiones]
        [FiltroAdmin]
        [HttpPost]
        public async Task<IActionResult> EditarInventario(Producto ent, [FromForm] IFormFile ImagenProducto)
        {
            //Actualiza los datos de la imagen
            if (ImagenProducto != null)
            {
                List<string> extensiones = new List<string>() { ".png", ".jpg", ".PNG", ".JPG" };
                string extension = Path.GetExtension(ImagenProducto.FileName);
                if (!extensiones.Contains(extension))
                {
                    ViewBag.msj = "El formato de la imagen no es válido, debe ser uno de los siguientes formatos: " + string.Join(", ", extensiones);
                    ConsultarTiposCategorias();
                    return View();
                }

                await iFirebaseModel.EliminarImagen("productos", ent.IdProducto);
                ent.RutaImagen = await iFirebaseModel.GuardarImagen("productos", ent.IdProducto, ImagenProducto);
                iProductoModel.ActualizarRutaImagen(ent);
            }

            //Actualiza los demas datos
            var resp = iProductoModel.ActualizarProducto(ent);
            if (resp.Codigo == 1)
            {
                return RedirectToAction("ConsultarInventario", "Inventario");
            }
            else
            {
                ViewBag.msj = resp.Mensaje;
                ConsultarTiposCategorias();
                return View();
            }
        }

        [FiltroSesiones]
        [FiltroAdmin]
        [HttpGet]
        public IActionResult EliminarInventario(int id)
        {
            var resp = iProductoModel.EliminarProducto(id);

            if (resp.Codigo == 1)
            {

                iFirebaseModel.EliminarImagen("productos", id);
                return RedirectToAction("ConsultarInventario", "Inventario");
            }
            else
            {
                ViewBag.msj = resp.Mensaje;
                return RedirectToAction("ConsultarInventario", "Inventario");
            }
        }

        private void ConsultarTiposCategorias()
        {
            var resp = iCategoriaModel.ConsultarTiposCategorias();

            List<SelectListItem> listaCategorias = new List<SelectListItem>();
            listaCategorias = JsonSerializer.Deserialize<List<SelectListItem>>((JsonElement)resp.Contenido!)!;
            listaCategorias.Insert(0, new SelectListItem { Text = "Seleccione una categoría ", Value = "" });

            ViewBag.TiposCategorias = listaCategorias;
        }
    }
}
