using BigSolutionsApi.Entidades;
using BigSolutionsApi.Modelos;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Hosting;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlTypes;
using Microsoft.AspNetCore.Identity;
using System.Diagnostics.Contracts;
using System.Runtime.CompilerServices;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController(IConfiguration iConfiguration, IComunesModel iComunesModel, IHostEnvironment iHost)
        : ControllerBase
    {
        [HttpPost]
        [Route("Registro")]
        [AllowAnonymous]
        public async Task<IActionResult> Registro(Usuario ent)
        {
            Respuesta res = new Respuesta();

            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "RegistrarUsuario",
                        new
                        {
                            ent.Identificacion,
                            ent.NombreCompleto,
                            ent.CorreoElectronico,
                            ent.NumeroTelefono,
                            ent.DireccionExacta,
                            ent.Contrasenna,
                            ent.NombreEmpresa
                        },
                        commandType: CommandType.StoredProcedure
                    );

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
            catch (SqlException ex)
            {
                // 2627 y 2601 se utilizan cuando se viola un índice único o una restricción UNIQUE
                if (ex.Number == 2627 || ex.Number == 2601)
                {
                    res.Codigo = 0;
                    res.Mensaje = "Este usuario ya se encuentra registrado en el sistema.";
                    res.Contenido = false;
                    return Ok(res);
                }
                else
                {
                    // Otros errores de SQL
                    res.Codigo = 0;
                    res.Mensaje = "Error de SQL al registrar el usuario";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
            catch (Exception ex)
            {
                // Cualquier otra excepción no relacionada con SQL
                res.Codigo = 0;
                res.Mensaje = "Error general al registrar el usuario";
                res.Contenido = false;
                return Ok(res);
            }
        }

        [AllowAnonymous]
        [HttpPost]
        [Route("IniciarSesion")]
        public async Task<IActionResult> IniciarSesion(Usuario ent)
        {
            Respuesta res = new Respuesta();

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
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

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
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
            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
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


        //Ver perfil de usuario
        [HttpGet]
        [Authorize]
        [AllowAnonymous]
        [Route("ConsultarUsuarioPerfil")]
        public async Task<IActionResult> ConsultarUsuarioPerfil(long idusuario)
        {
            Respuesta resp = new Respuesta();

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@idusuario", idusuario);

                var result = (await context.QueryAsync<Usuario>("ConsultarPerfilUsuario", parameters,
                    commandType: System.Data.CommandType.StoredProcedure)).ToList();

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

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
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

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                // Cambiar el estado a inactivo (no se elimina por completo);
                var result = await context.ExecuteAsync("EliminarPerfilUsuario", new { UsuarioId },
                    commandType: CommandType.StoredProcedure);

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

        [HttpGet]
        [Authorize]
        [Route("ListarClientes")]
        public async Task<IActionResult> ListarClientes()
        {
            List<RespuestaListarClientes> res = new List<RespuestaListarClientes>();
            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                // Abre la conexión
                await context.OpenAsync();

                // Llama al procedimiento almacenado
                var result =
                    await context.QueryAsync<Usuario>("SP_ListarClientes", commandType: CommandType.StoredProcedure);
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
                            Estado = usuario.Estado,
                            UsuarioId = usuario.UsuarioId

                        });
                    }
                }
            }

            return Ok(res);
        }

        [HttpGet]
        [Authorize]
        [Route("DetallesCliente")]
        public async Task<IActionResult> DetallesClienteCliente(string identificacion)
        {
            DetallesCliente detallesCliente = new DetallesCliente();
            try
            {

                using (var context =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    // Abre la conexión
                    await context.OpenAsync();

                    var parameters = new { identificacion = identificacion };

                    // Llama al procedimiento almacenado pasando el parámetro
                    var result = await context.QueryAsync<DetallesCliente>("SP_Detalles_Cliente", parameters,
                        commandType: CommandType.StoredProcedure);

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

        //A
        [HttpGet]
        [Authorize]
        [Route("Listar")]

        public async Task<IActionResult> ObtenerUsuarios()
        {
            Respuesta res = new Respuesta();

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                // Obtener la lista de usuarios usando el procedimiento almacenado
                var result =
                    await context.QueryAsync<Usuario>("ObtenerListaUsuarios", commandType: CommandType.StoredProcedure);

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
        [Authorize]
        [Route("ConsultarUsuarioPorId")]
        public async Task<IActionResult> ConsultarUsuarioPorId(int UsuarioId)
        {
            Respuesta resp = new Respuesta();

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("ConsultarUsuarioPorId", new { UsuarioId },
                    commandType: CommandType.StoredProcedure);

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

        [HttpPut]
        [Authorize]
        [Route("EditarUsuario")]
        public async Task<IActionResult> EditarUsuario(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context =
                   new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("EditarUsuario", new
                {
                    ent.UsuarioId,
                    ent.IdRol,
                    ent.Identificacion,
                    ent.NombreCompleto,
                    ent.NombreEmpresa,
                    ent.NumeroTelefono,
                    ent.CorreoElectronico,
                    ent.DireccionExacta,
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
                    resp.Mensaje = "Error al actualizar el usuario";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpDelete]
        [Authorize]
        [Route("EliminarUsuario")]
        public async Task<IActionResult> EliminarUsuario(long Id)
        {
            var resp = new Respuesta();

            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    // Ejecuta tu SP de eliminación
                    var result = await context.ExecuteAsync(
                        "EliminarUsuario",
                        new { Id },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        // Eliminación exitosa
                        resp.Codigo = 1;
                        resp.Mensaje = "OK";
                        resp.Contenido = result;
                    }
                    else
                    {
                        
                        resp.Codigo = 0;
                        resp.Mensaje = "No se pudo eliminar el usuario. Se recomienda inactivar.";
                        resp.Contenido = false;
                    }
                }
            }
            catch (SqlException ex)
            {
                // Número 547 es típico de violación de FK en SQL Server.
                if (ex.Number == 547)
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "El usuario tiene datos asociados. Se recomienda inactivar.";
                    resp.Contenido = false;
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Error SQL al eliminar el usuario: " + ex.Message;
                    resp.Contenido = false;
                }
            }
            catch (Exception ex)
            {
                // Cualquier otro tipo de excepción
                resp.Codigo = 0;
                resp.Mensaje = "Error general al eliminar el usuario: " + ex.Message;
                resp.Contenido = false;
            }
            return Ok(resp);
        }

        [HttpPut]
        [Authorize]
        [Route("CambiarContrasenna")]
        //[AllowAnonymous]
        public async Task<IActionResult> CambiarContrasenna(Usuario ent)
        {
            /* Validar que la vieja contra sea igual
             Validar que la nueva contraseña sea igual a la segunda nueva contraseña
             Validar los estandares de seguridad*/

            Respuesta res = new Respuesta();
            var HoraActual = DateTime.Now;
            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync("ValidarContrasennaActual", new
                {
                    ent.UsuarioId,
                    ent.Contrasenna
                }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    if (ent.NuevaContrasenna.Equals(ent.ConfirmacionContrasenna))
                    {
                        if (iComunesModel.ValidarContrasenna(ent.NuevaContrasenna))
                        {

                            var result2 = await context.ExecuteAsync("CambiarContrasenna", new
                            {
                                ent.UsuarioId,
                                ent.NuevaContrasenna
                            }, commandType: CommandType.StoredProcedure);
                            if (result2 > 0)
                            {
                                res.Codigo = 1;
                                res.Mensaje = "";
                                res.Contenido = result2;
                                return Ok(res);
                            }
                            else
                            {
                                res.Codigo = 0;
                                res.Mensaje = "Eror al actualizar la nueva contraseña";
                                res.Contenido = false;
                                return Ok(res);
                            }

                        }
                        else
                        {
                            res.Codigo = 0;
                            res.Mensaje = "La contraseña debe tener mínimo 8 caracteres y una letra mayúscula";
                            res.Contenido = false;
                            return Ok(res);
                        }

                    }
                    else
                    {
                        res.Codigo = 0;
                        res.Mensaje = "La nueva contraseña y su confirmación no coinciden";
                        res.Contenido = false;
                        return Ok(res);
                    }

                }
                else
                {
                    res.Codigo = 0;
                    res.Mensaje = "La contraseña ingresada no corresponde a su contraseña actual";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }
    }
}
