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