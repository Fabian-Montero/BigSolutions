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
        /*private readonly IConfiguration _configuration;
        private readonly IComunesModel _comunesModel;

        public UsuarioController(IConfiguration iConfiguration, IComunesModel iComunesModel)
        {
            _configuration = iConfiguration;
            _comunesModel = iComunesModel;
        */

        [HttpPost]
        [Route("Registro")]
        [AllowAnonymous]
        public async Task<IActionResult> Registro(Usuario ent)
        {
        Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
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

        //A
        [HttpGet]
        [Route("Listar")]
       
        public async Task<IActionResult> ObtenerUsuarios()
        {
            Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                // Obtener la lista de usuarios usando el procedimiento almacenado
                var result = await context.QueryAsync<Usuario>("ObtenerListaUsuarios", commandType: CommandType.StoredProcedure);

                if (result.Count() > 0)
                {
                    res.Codigo = 1;
                    res.Mensaje = "";
                    res.Contenido = result;
                    return Ok(res);
                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "No se encontraron usuarios registrados.";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        } 
        



      
        [HttpGet]
        [Route("ConsultarUsuarioPorId")]
        public async Task<IActionResult> ConsultarUsuarioPorId(int UsuarioId)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("ConsultarUsuarioPorId", new { UsuarioId }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No se ha encontrado el Usuario solicitado";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
        [HttpPost]
        [Route("EditarUsuario")]
        public async Task<IActionResult> ActualizarProducto(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("EditarUsuario", new
                {
                    ent.UsuarioId,
                    ent.IdRol,
                    ent.Identificacion,
                    ent.NombreCompleto,
                    ent.CorreoElectronico ,
                    ent.Estado
                }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Error al actualizar el producto";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }



    }
}
