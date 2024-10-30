﻿using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics.Eventing.Reader;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    public class BocetoController(IBocetoModel iBocetoModel) : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult ConsultarProductosBoceto(string? Busqueda, int NumPagina = 1, int TamannoPagina = 5)
        {
            var resp = iBocetoModel.ConsultarProductosCliente(Busqueda, NumPagina, TamannoPagina);

            if (resp.Codigo == 1)
            {
                ViewBag.Busqueda =  Busqueda;
                ViewBag.NumPagina = NumPagina;
                ViewBag.TamannoPagina = TamannoPagina;

                var contenido = ((JsonElement)resp.Contenido).Deserialize<ProductosPaginadosDTO>();

                ViewBag.TotalProductos = contenido.TotalProductos;
                ViewBag.TotalPaginas = (int)Math.Ceiling((double)ViewBag.TotalProductos / ViewBag.TamannoPagina);
                return View(contenido.Productos);
            }
            else
            {
                ViewBag.ErrorMessage = "No se encontraron productos.";
                return View(new List<Producto>());
            }
        }

        [HttpPost]
        public async Task<IActionResult> GenerateSketch([FromForm] GenerateSketchDTO ent)
        {

            /*var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            var IdUsuario = long.Parse(IdUsuarioString);*/



            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            ent.UserId = int.Parse(IdUsuarioString!);

            Respuesta resp = await iBocetoModel.GenerarBoceto(ent);

            if (resp.Codigo == 1)
            {
                return Json(new { success = true, message = "Boceto generado exitosamente." });
            }
            else
            {
                return Json(new { success = false, message = "Datos inválidos" });
            }
            /*if (ModelState.IsValid)
            {
                // Lógica para generar el boceto
                
            }
            else
            {
                
            }*/
        }

        [HttpGet]
        public IActionResult ConsultarBocetosCliente()
        {
            return View();
        }

        [HttpGet]
        public IActionResult ConsultarBocetosAdmin()
        {
            return View();
        }
    }
}
