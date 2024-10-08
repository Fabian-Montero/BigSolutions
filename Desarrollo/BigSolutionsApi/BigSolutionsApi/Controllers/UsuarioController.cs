using BigSolutionsApi.Entidades;
using BigSolutionsApi.Modelos;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Collections.Generic;
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
        [HttpGet]
        [Route("ListarClientes")]
        public async Task<IActionResult> ListarClientes()
        {
            List<RespuestaListarClientes> res = new List<RespuestaListarClientes>();
            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                // Abre la conexión
                await context.OpenAsync();

                // Llama al procedimiento almacenado
                var result = await context.QueryAsync<Usuario>("SP_ListarClientes", commandType: CommandType.StoredProcedure);
                // Procesa los resultados
                if (result != null && result.Any())
                {
                    foreach (var usuario in result)
                    {
                        res.Add(new RespuestaListarClientes
                        {
                            identificacion = usuario.Identificacion,
                            NombreCompleto = usuario.NombreCompleto,
                            CorreoElectronico = usuario.CorreoElectronico,
                            Rol = usuario.IdRol,
                            Estado = usuario.Estado

                        });
                    }
                }
            }

            return Ok(res);
        }

        //[HttpPost]
        //[Route("ActualizarCliente")]
        //public async Task<IActionResult> ActualizarCliente(Cliente Cliente)
        //{
        //    using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
        //    {
        //        //El rol y el estado se asignan en el procedimiento almacenado
        //        //También se indica que no es una contraseña temporal 
        //        var result = await context.ExecuteAsync("SP_ActualizarCliente", new
        //        {
        //            Cliente.Identificacion,
        //            Cliente.NombreCompleto,
        //            Cliente.CorreoElectronico,
        //            Cliente.NumeroTelefono,
        //            Cliente.DireccionExacta,
        //            Cliente.Estado,
        //            Cliente.NombreEmpresa,
        //            Cliente.EsTemporal,
        //            Cliente.VigenciaTemporal
        //        }, commandType: CommandType.StoredProcedure);
        //    }

        //    return Ok();
        //}

        [HttpDelete]
        [Route("EliminarCliente")]
        public async Task<IActionResult> EliminarCliente(string identificacion)
        {
            string mensaje = string.Empty;
            try
            {
               
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.QueryFirstOrDefaultAsync<string>("SP_EliminarCliente", new
                    {
                        ID_Cliente = identificacion
                    }, commandType: CommandType.StoredProcedure);
                    mensaje = result.ToString();
                }
            }
            catch (Exception ex) { 
            
            }
            return Ok(mensaje);
        }

        [HttpGet]
        [Route("BuscarCliente")]
        public async Task<IActionResult> BuscarCliente(string ParametroBusqueda)
        {
            List<RespuestaListarClientes> res = new List<RespuestaListarClientes>();
            try
            {              
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    // Abre la conexión
                    await context.OpenAsync();

                    var parameters = new { ParametroBusqueda = ParametroBusqueda };

                    // Llama al procedimiento almacenado pasando el parámetro
                    var result = await context.QueryAsync<Usuario>("SP_BuscarCliente", parameters, commandType: CommandType.StoredProcedure);

                    // Procesa los resultados
                    if (result != null && result.Any())
                    {
                        foreach (var usuario in result)
                        {
                            res.Add(new RespuestaListarClientes
                            {
                                identificacion = usuario.Identificacion,
                                NombreCompleto = usuario.NombreCompleto,
                                CorreoElectronico = usuario.CorreoElectronico,
                                Rol = usuario.IdRol,
                                Estado = usuario.Estado
                            });
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {

            }
            return Ok(res);
        }

        [HttpGet]
        [Route("DetallesCliente")]
        public async Task<IActionResult> DetallesClienteCliente(string identificacion)
        {
            DetallesCliente detallesCliente = new DetallesCliente();
            try
            {

                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    // Abre la conexión
                    await context.OpenAsync();

                    var parameters = new { identificacion = identificacion };

                    // Llama al procedimiento almacenado pasando el parámetro
                    var result = await context.QueryAsync<DetallesCliente>("SP_Detalles_Cliente", parameters, commandType: CommandType.StoredProcedure);

                    // Procesa los resultados
                    if (result != null && result.Any())
                    {
                        foreach (var usuario in result)
                        {
                            detallesCliente.Identificacion = usuario.Identificacion;
                            detallesCliente.NombreCompleto = usuario.NombreCompleto;
                            detallesCliente.CorreoElectronico = usuario.CorreoElectronico;
                            detallesCliente.NumeroTelefono = usuario.NumeroTelefono;
                            detallesCliente.DireccionExacta = usuario.DireccionExacta;
                            detallesCliente.Estado = usuario.Estado;
                            detallesCliente.NombreEmpresa = usuario.NombreEmpresa;
                            detallesCliente.EsTemporal = usuario.EsTemporal;
                            detallesCliente.VigenciaTemporal = usuario.VigenciaTemporal;
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {

            }
            return Ok(detallesCliente);
        }
        
    }
}
