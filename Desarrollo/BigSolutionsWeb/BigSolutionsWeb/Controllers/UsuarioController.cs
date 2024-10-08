using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController(IComunesModel iComunesModel, IUsuarioModel iUsuarioModel) : Controller
    {
        static string? mensaje;
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult Registro()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Registro(Usuario ent)
        {

            //validar contraseña

            if (iComunesModel.ValidarContrasenna(ent.Contrasenna)) {
                ent.Contrasenna = iComunesModel.Encrypt(ent.Contrasenna!);

                var res = iUsuarioModel.Registro(ent);

                if (res.Codigo == 1)
                {
                    return RedirectToAction("InicioSesion", "Usuario");
                }
                else
                {
                    ViewBag.msj = res.Mensaje;
                    return View();
                }
            }
            else
            {
                ViewBag.msj = "La contraseña debe tener mínimo 8 caracteres y una letra mayúscula";
                return View();
            }
        }

        [HttpGet]
        public IActionResult InicioSesion()
        {
            return View();
        }

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
        
        public IActionResult ConsultarUsuariosPrueba()
        {
            return View();
        }
        public IActionResult EditarUsuario()
        {
            return View();
        }
        public IActionResult ConsultarClientes()
        {

            List<Cliente> ListCliente = new List<Cliente>();
            
            ListCliente = iUsuarioModel.ListarClientes();

            ViewBag.Aviso = mensaje;
            mensaje = null;

            // Retornar la vista con la lista de clientes
            return View(ListCliente);
        }

        public IActionResult EliminarClientes(string id)
        {
            mensaje = iUsuarioModel.EliminarClientes(id);
           
            return RedirectToAction("ConsultarClientes");
        }

        public IActionResult DetallesCLiente(string id)
        {
            DetallesCliente detalleCLiente = iUsuarioModel.DetallesClientes(id);

            return View(detalleCLiente);
        }

        public IActionResult BuscarClientes(string ParametroBusqueda)
        {
            List<Cliente> ListCliente = new List<Cliente>();

            //si el campo de busqueda tiene datos cargue la busqueda
            if (ParametroBusqueda != null)
            {
                // Obtener la lista de clientes con el parámetro de búsqueda
                ListCliente = iUsuarioModel.BuscarClientes(ParametroBusqueda);
            }
            else { //Si el campo de busqueda esta vacio, cargue toda la informacion del cliente 
                 ListCliente = iUsuarioModel.ListarClientes();
            }

            ViewBag.Aviso = mensaje;
            mensaje = null;

            // Retornar la vista completa
            return View("ConsultarClientes", ListCliente);
        }

        public IActionResult EditarClientes()
        {
            return View();
        }
        public IActionResult OrdenesPorCliente(string id)
        {
            return View();
        }   
    }
}