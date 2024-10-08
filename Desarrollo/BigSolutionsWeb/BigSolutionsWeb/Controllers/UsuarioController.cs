<<<<<<< Updated upstream
﻿using Microsoft.AspNetCore.Mvc;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController : Controller
=======
﻿using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController(IComunesModel iComunesModel, IUsuarioModel iUsuarioModel, IRolModel iRolModel) : Controller
>>>>>>> Stashed changes
    {

        public IActionResult Index()
        {
            return View();
        }
        public IActionResult InicioSesion()
        {
            return View();
        }
<<<<<<< Updated upstream
=======

        [HttpPost]
        public IActionResult InicioSesion(Usuario ent)
        {

            ent.Contrasenna = iComunesModel.Encrypt(ent.Contrasenna!);
            var res = iUsuarioModel.InicioSesion(ent);
            if (res.Codigo == 1)
            {

                var datos = JsonSerializer.Deserialize<Usuario>((JsonElement)res.Contenido!);
                HttpContext.Session.SetString("TOKEN", datos!.Token!);
                HttpContext.Session.SetString("NOMBRE", datos!.NombreCompleto!);
                HttpContext.Session.SetString("ROL", datos!.IdRol.ToString());
                HttpContext.Session.SetString("IDUSUARIO", datos!.UsuarioId.ToString());
                HttpContext.Session.SetString("NOMBREROL", datos!.NombreRol!);

                return RedirectToAction("Index", "Home");

            }
            else
            {
                ViewBag.msj = res.Mensaje;
                return View();
            }
        }


        [HttpGet]
        public IActionResult ConsultarUsuarios()
        {
            var respuesta = iUsuarioModel.Listar();
            if (respuesta.Codigo == 1)
            {
                var usuarios = JsonSerializer.Deserialize<List<Usuario>>((JsonElement)respuesta.Contenido!);
                return View(usuarios);
            }
            else
            {
                return View(new List<Usuario>()); // Devuelve una lista vacía en caso de error
            }
        }







        [HttpGet]
        public IActionResult EditarUsuario(int id)
        {
            var resp = iUsuarioModel.ConsultarUsuarioPorId(id);

            if (resp.Codigo == 1)
            {   
                var datos = JsonSerializer.Deserialize<Usuario>((JsonElement)resp.Contenido!);
                ConsultarTiposRoles();
                return View(datos);  // Pasamos los datos a la vista
            }
            return View(new Usuario());
        }




        [HttpPost]
        public IActionResult EditarUsuario(Usuario ent)
        { 
            long? USUARIOID = HttpContext.Session.GetInt32("USUARIOID");
            // Verificar si el usuario está intentando actualizarse a sí mismo
            if (ent.UsuarioId != (int)USUARIOID)
            {
                var resp = iUsuarioModel.EditarUsuario(ent);
                if (resp.Codigo == 1)
                    return RedirectToAction("ConsultarUsuarios", "Usuario");

                ViewBag.msj = resp.Mensaje;
                ConsultarTiposRoles();
                return RedirectToAction("ConsultarUsuarios", "Usuario");
            }

            // Si es a sí mismo lo redirige a la lista de nuevo
            return RedirectToAction("ConsultarUsuarios", "Usuario");
        }






>>>>>>> Stashed changes
        public IActionResult ConfiguraciondePerfil()
        {
            return View();
        }
        public IActionResult Recuperar()
        {
            return View();
        }
        public IActionResult RecuperarContrasenaCodigo()
        {
            return View();
        }
<<<<<<< Updated upstream
        public IActionResult Registro()
        {
            return View();
        }
        public IActionResult ConsultarUsuariosPrueba()
        {
            return View();
        }
=======
>>>>>>> Stashed changes
        public IActionResult EditarUsuario()
        {
            return View();
        }
        public IActionResult ConsultarClientes()
        {
            return View();
        }
        public IActionResult EditarClientes()
        {
            return View();
        }
        public IActionResult OrdenesPorCliente()
        {
            return View();
        }

        private void ConsultarTiposRoles()
        {
            var roles = iRolModel.ConsultarTiposRoles();
            List<SelectListItem> listaRoles = new List<SelectListItem>();
            listaRoles = JsonSerializer.Deserialize<List<SelectListItem>>((JsonElement)roles.Contenido!)!;
            listaRoles.Insert(0, new SelectListItem { Text = "Seleccione un rol ", Value = "" });

            ViewBag.Roles = listaRoles;
        }
    }
}