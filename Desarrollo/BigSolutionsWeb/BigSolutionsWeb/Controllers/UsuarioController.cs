using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using System.Text.Json;

namespace BigSolutionsWeb.Controllers
{
    public class UsuarioController(IComunesModel iComunesModel, IUsuarioModel iUsuarioModel) : Controller
    {
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
    }
}