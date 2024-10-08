using BigSolutionsApi.Entidades;
using BigSolutionsApi.Modelos;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Data;
using System.Data.SqlTypes;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController(IConfiguration iConfiguration, IComunesModel iComunesModel) : ControllerBase
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

        //Ver perfil de usuario
        [HttpGet]
        [AllowAnonymous]
        [Route("ConsultarUsuarioPerfil")]
        public async Task<IActionResult> ConsultarUsuarioPerfil(long idusuario)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@idusuario", idusuario);

                var result = (await context.QueryAsync<Usuario>("ConsultarPerfilUsuario", parameters, commandType: System.Data.CommandType.StoredProcedure)).ToList();

                if (result != null && result.Count > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No se ha encontrado la información";
                    return Ok(resp);
                }
            }
        }
        //Actualizar perfil de usuario
        [HttpPut]
        [Authorize]
        [Route("ActualizarPerfilUsuario")]
        public async Task<IActionResult> ActualizarPerfilUsuario(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("ActualizarPerfilUsuario", new
                {
                    ent.NombreCompleto,
                    ent.Identificacion,
                    ent.CorreoElectronico,
                    ent.NumeroTelefono,
                    ent.DireccionExacta,
                    ent.UsuarioId
                }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = true;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Error al actualizar el usuario";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
        //Eliminar perfil de usuario
        [HttpDelete]
        [Authorize]
        [Route("EliminarPerfilUsuario")]
        public async Task<IActionResult> EliminarPerfilUsuario(long UsuarioId)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("EliminarPerfilUsuario", new { UsuarioId }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Eror al eliminar tu perfil";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
    }
}
