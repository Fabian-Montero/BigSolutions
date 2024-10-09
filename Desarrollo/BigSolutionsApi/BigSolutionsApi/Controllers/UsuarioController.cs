using BigSolutionsApi.Entidades;
using BigSolutionsApi.Modelos;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Hosting;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Data;
using System.Data.SqlTypes;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController(IConfiguration iConfiguration, IComunesModel iComunesModel, IHostEnvironment iHost) : ControllerBase
    {

        [HttpPost]
        [Route("Registro")]
        [AllowAnonymous]
        public async Task<IActionResult> Registro(Usuario ent)
        {
            Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                //El rol y el estado se asignan en el procedimiento almacenado
                //También se indica que no es una contraseña temporal 
                var result = await context.ExecuteAsync("RegistrarUsuario", new
                {
                    ent.Identificacion,
                    ent.NombreCompleto,
                    ent.CorreoElectronico,
                    ent.NumeroTelefono,
                    ent.DireccionExacta,
                    ent.Contrasenna,
                    ent.NombreEmpresa
                }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    res.Codigo = 1;
                    res.Mensaje = "";
                    res.Contenido = result;
                    return Ok(res);
                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "Error al registrar el usuario en la base de datos";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }

        [AllowAnonymous]
        [HttpPost]
        [Route("IniciarSesion")]
        public async Task<IActionResult> IniciarSesion(Usuario ent)
        {
            Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("IniciarSesion", new
                {
                    ent.CorreoElectronico,
                    ent.Contrasenna
                }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    result.Token = iComunesModel.GenerarToken(result.UsuarioId, result.IdRol);

                    res.Codigo = 1;
                    res.Mensaje = "";
                    res.Contenido = result;
                    return Ok(res);
                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "Error al iniciar sesión con el usuario";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }

        [AllowAnonymous]
        [HttpPost]
        [Route("Recuperar")]
        public async Task<IActionResult> Recuperar(Usuario ent)
        {
            Respuesta res = new Respuesta();

            string Codigo = iComunesModel.GenerarCodigo();
            string CodigoEncriptado = iComunesModel.Encrypt(Codigo);
            bool EsTemporal = true;
            DateTime VigenciaTemporal = DateTime.Now.AddMinutes(10);

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                //Buscar al usuario por el correo, cambia la contrasenna por el codigo encriptado generado, es contrasenna temporal, agrega la vigencia temporal del codigo
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("Recuperar", new
                {
                    ent.CorreoElectronico,
                    CodigoEncriptado,
                    EsTemporal,
                    VigenciaTemporal
                }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    //Enviar el correo

                    var ruta = Path.Combine(iHost.ContentRootPath, "FormatoCorreo.html");
                    var html = System.IO.File.ReadAllText(ruta);

                    html = html.Replace("@@Nombre", result.NombreCompleto);
                    html = html.Replace("@@Contrasenna", Codigo);
                    html = html.Replace("@@Vencimiento", VigenciaTemporal.ToString("dd/MM/yyyy HH:mm"));

                    iComunesModel.EnviarCorreo(result.CorreoElectronico!, "Recuperar Acceso Sistema", html);

                    res.Codigo = 1;
                    res.Mensaje = "";
                    res.Contenido = result;
                    return Ok(res);
                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "El correo electrónico ingresado no corresponde a ningún usuario registrado";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }

        [HttpPut]
        [Route("RecuperaContrasennaCodigo")]
        [AllowAnonymous]
        public async Task<IActionResult> RecuperaContrasennaCodigo(Usuario ent)
        {
            Respuesta res = new Respuesta();
            var HoraActual = DateTime.Now;
            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("RecuperaContrasennaCodigo", new
                {
                    ent.Codigo,
                    HoraActual,
                    ent.CorreoElectronico,
                    ent.Contrasenna
                }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    res.Codigo = 1;
                    res.Mensaje = "";
                    res.Contenido = result;
                    return Ok(res);
                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "El código no es válido, intente nuevamente con otro código";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }

    }
}
