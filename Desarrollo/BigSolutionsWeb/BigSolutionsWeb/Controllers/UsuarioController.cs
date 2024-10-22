using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Server.Kestrel.Core.Features;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Net.Http;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController(IComunesModel iComunesModel, IUsuarioModel iUsuarioModel, IRolModel iRolModel) : Controller
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

            if (iComunesModel.ValidarContrasenna(ent.Contrasenna))
            {
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

        [HttpGet]
        public IActionResult Salir()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("InicioSesion", "Usuario");
        }

        [HttpGet]
        public IActionResult ConfiguraciondePerfil()
        {
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            var IdUsuario = long.Parse(IdUsuarioString);
            var respuesta = iUsuarioModel.ConsultarUsuarioPerfil(IdUsuario);

            if (respuesta!.Codigo == 1)
            {
                try
                {
                    var jsonElement = (JsonElement)respuesta.Contenido!;
                    var jsonString = jsonElement.GetRawText();


                    var usuarios = JsonSerializer.Deserialize<List<Usuario>>(jsonString);

                    if (usuarios != null && usuarios.Count > 0)
                    {
                        var usuario = usuarios[0];
                        return View(usuario);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                catch (JsonException ex)
                {
                    ViewBag.MsjPantalla = ex;
                    return RedirectToAction("Error", "Home");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public IActionResult ConfiguraciondePerfil(Usuario entidad)
        {
            var idUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            var idUsuario = long.Parse(idUsuarioString!);
            entidad.UsuarioId = idUsuario;

            var resp = iUsuarioModel.ActualizarPerfilUsuario(entidad);

            if (resp.Codigo == 1)
            {
                HttpContext.Session.SetString("NOMBRE", entidad.NombreCompleto!);
                ViewBag.msj = resp.Mensaje;
            }

            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult EliminarPerfilUsuario(long UsuarioId)
        {

            var resp = iUsuarioModel.EliminarPerfilUsuario(UsuarioId);

            if (resp.Codigo == 1)
            {
                return RedirectToAction("InicioSesion", "Usuario");
            }
            else
            {
                ViewBag.MsjPantalla = resp.Mensaje;
                return RedirectToAction("ConfiguraciondePerfil", "Usuario");
            }

        }
        [HttpGet]
        public IActionResult Recuperar()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Recuperar(Usuario ent)
        {
            var res = iUsuarioModel.Recuperar(ent);
            if (res.Codigo == 1)
            {
                return RedirectToAction("RecuperarContrasenaCodigo", "Usuario", new { correo = ent.CorreoElectronico });
            }
            else
            {
                ViewBag.msj = "El correo electrónico ingresado no corresponde a ningún usuario registrado";
                return View();
            }
        }
        [HttpGet]
        public IActionResult RecuperarContrasenaCodigo(string correo)
        {
            ViewBag.Correo = correo;
            return View();
        }

        [HttpPost]
        public IActionResult RecuperarContrasenaCodigo(Usuario ent)
        {
            if (ent.Contrasenna.Equals(ent.ConfirmacionContrasenna))
            {
                if (iComunesModel.ValidarContrasenna(ent.Contrasenna))
                {
                    //validar el codigo
                    ent.Codigo = iComunesModel.Encrypt(ent.Codigo);
                    ent.Contrasenna = iComunesModel.Encrypt(ent.Contrasenna);
                    ent.ConfirmacionContrasenna = null;
                    var res = iUsuarioModel.RecuperaContrasennaCodigo(ent);
                    if (res.Codigo == 1)
                        return RedirectToAction("InicioSesion", "Usuario");
                   
                    ViewBag.msj = res.Mensaje;
                    return View();  
                }
                else {
                    ViewBag.msj = "La contraseña debe tener mínimo 8 caracteres y una letra mayúscula";
                    return View();
                }
            }
            else
            {
                ViewBag.msj = "Ambas contraseñas deben coincidir";
                return View();
            }
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

        //A
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
                return View(new List<Usuario>());
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
                ConsultarTiposEstados();
                return View(datos);
            }
            return View(new Usuario());
        }

        [HttpPost]
        public IActionResult EditarUsuario(Usuario ent)
        {

            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            var IdUsuario = long.Parse(IdUsuarioString);
            
            // Verificar si el usuario está intentando actualizarse a sí mismo
            if (ent.UsuarioId != IdUsuario)
            {
                var resp = iUsuarioModel.EditarUsuario(ent);
                if (resp.Codigo == 1)
                    return RedirectToAction("ConsultarUsuarios", "Usuario");

                ViewBag.msj = resp.Mensaje;
                ConsultarTiposRoles();
                ConsultarTiposEstados();
                return View();
            }

            // Si es a sí mismo lo redirige a la lista de nuevo
            ViewBag.msj = "No puede editar su propia información desde este apartado";
            ConsultarTiposRoles();
            ConsultarTiposEstados();
            return View();
        }

        [HttpGet]
        //[FiltroSesiones]
        public IActionResult EliminarUsuario(long id)
        {

            var resp = iUsuarioModel.EliminarUsuario(id);
            
            if (resp.Codigo == 1)
            {
                return RedirectToAction("ConsultarUsuarios", "Usuario");
            }
            else
            {
                ViewBag.msj = resp.Mensaje;
                return RedirectToAction("ConsultarUsuarios", "Usuario");
            }

        }

        [HttpGet]
        public IActionResult CambiarContrasenna() 
        {
            return View();
        }
        [HttpPost]
        public IActionResult CambiarContrasenna(Usuario ent)
        {
            ent.Contrasenna = iComunesModel.Encrypt(ent.Contrasenna);
            ent.NuevaContrasenna = iComunesModel.Encrypt(ent.NuevaContrasenna);
            ent.ConfirmacionContrasenna = iComunesModel.Encrypt(ent.ConfirmacionContrasenna);
            var IdUsuarioString = HttpContext.Session.GetString("IDUSUARIO");
            ent.UsuarioId = long.Parse(IdUsuarioString!);
            
            var resp = iUsuarioModel.CambiarContrasenna(ent);
            if (resp.Codigo == 1)
            {
                return RedirectToAction("Index", "Home");
            }
            else 
            {
                ViewBag.msj = resp.Mensaje;
                return View();
            }
        }


        private void ConsultarTiposRoles()
        {
            var roles = iRolModel.ConsultarTiposRoles();
            List<SelectListItem> listaRoles = new List<SelectListItem>();
            listaRoles = JsonSerializer.Deserialize<List<SelectListItem>>((JsonElement)roles.Contenido!)!;
            listaRoles.Insert(0, new SelectListItem { Text = "Seleccione un rol ", Value = "" });

            ViewBag.Roles = listaRoles;
        }

        private void ConsultarTiposEstados()
        {
            List<SelectListItem> listaEstados = new List<SelectListItem>();
            listaEstados.Add(new SelectListItem { Text = "Seleccione un estado", Value = "" });
            listaEstados.Add(new SelectListItem { Text = "Activo", Value = true.ToString() });
            listaEstados.Add(new SelectListItem { Text = "Inactivo", Value = false.ToString() });

            ViewBag.Estados = listaEstados;
        }

    }
}