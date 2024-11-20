using BigSolutionsApi.DTOs;
using BigSolutionsApi.Entidades;
using BigSolutionsApi.Enums;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.Data.SqlClient;
using System.Data;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CotizacionController(IConfiguration iConfiguration) : ControllerBase
    {
        //Cliente
        [HttpGet]
        [Route("CrearSolicitudCotizacionVista")]
        public async Task<IActionResult> CrearSolicitudCotizacionVista(int IdUsuario)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<Boceto>("CrearSolicitudCotizacionVista", new { IdUsuario }, commandType: CommandType.StoredProcedure);

                var bocetos = result.ToList();
                if (bocetos.Count > 0)
                {
                    var solicitudCotizacion = new CrearSolicitudCotizacionVistaDTO
                    {
                        DescripcionGeneral = "",
                        Bocetos = bocetos
                    };
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = solicitudCotizacion;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay bocetos registrados en emste momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
        [HttpPost]
        [Route("CrearSolicitudCotizacion")]
        public async Task<IActionResult> CrearSolicitudCotizacion(CrearSolicitudCotizacionDTO SolicitudCotizacion)
        {
            Respuesta resp = new Respuesta();

            // Se realiza una transaccion para insertar la cotizacion y el detalle los bocetos asociados
            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                connection.Open();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        //Inserta la solicitud de cotización y obtiene el IdSolicitudCotizacion
                        var solicitudCotizacionId = await connection.ExecuteScalarAsync<long>(
                            "CrearSolicitudCotizacion",
                            new
                            {
                                IdUsuario = SolicitudCotizacion.IdUsuario,
                                Descripcion = SolicitudCotizacion.DescripcionGeneral,
                                Moneda = (int)SolicitudCotizacion.Moneda
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        //Inserta cada boceto en la tabla de detalle mediante un ciclo
                        foreach (var boceto in SolicitudCotizacion.BocetosSeleccionados)
                        {
                            await connection.ExecuteAsync(
                                "CrearSolicitudCotizacionDetalle",
                                new
                                {
                                    IdSolicitudCotizacion = solicitudCotizacionId,
                                    IdBoceto = boceto.IdBoceto,
                                    Cantidad = boceto.Cantidad,
                                    DescripcionUsuario = boceto.DescripcionUsuario
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            ); ;
                            ;
                        }

                        // Confirmar la transacción
                        transaction.Commit();

                        resp.Codigo = 1;
                        resp.Mensaje = "Solicitud de cotización creada exitosamente";
                        return Ok(resp);
                    }
                    catch (Exception ex)
                    {
                        // Si algo sale mal cancela la transacción mediante un rollback
                        transaction.Rollback();

                        resp.Codigo = 0;
                        resp.Mensaje = $"Error al crear la solicitud de cotización: {ex.Message}";
                        return Ok(resp);
                    }
                }
            }
        }

        [HttpGet]
        [Route("ConsultarSolicitudesCotizacionesCliente")]
        public async Task<IActionResult> ConsultarSolicitudesCotizacionesCliente(int IdUsuario)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<SolicitudCotizacion>(
                    "ConsultarSolicitudesCotizacionesCliente",
                    new { IdUsuario },
                    commandType: CommandType.StoredProcedure
                );

                // Convertir el campo Moneda de int a enum
                /*foreach (var solicitud in result)
                {
                    solicitud.Moneda = solicitud.Moneda.HasValue
                        ? (Moneda?)solicitud.Moneda.Value
                        : null;
                }*/

                if (result.Any())
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay solicitudes registradas en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpGet]
        [Route("ConsultarDetalleSolicitudCotizacionCliente")]
        public async Task<IActionResult> ConsultarDetalleSolicitudCotizacionCliente(long IdSolicitudCotizacion)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<SolicitudCotizacionDetalleDTO>("ConsultarDetalleSolicitudCotizacionCliente", new { IdSolicitudCotizacion }, commandType: CommandType.StoredProcedure);


                if (result != null)
                {
                    //Solicita los bocetos asociados y lo asocia a la lista de bocetos del DTO a devolver
                    var bocetos = await context.QueryAsync<Boceto>("ObtenerBocetosPorSolicitud", new { IdSolicitudCotizacion }, commandType: CommandType.StoredProcedure);

                    if (bocetos.Count() > 0)
                    {
                        result.Bocetos = bocetos.ToList();

                        resp.Codigo = 1;
                        resp.Mensaje = "";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No hay bocetos asociados a la solicitud en este momento";
                        resp.Contenido = false;
                        return Ok(resp);
                    }

                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay solicitudes registradas en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        //Admin

        [HttpGet]
        [Route("ConsultarSolicitudesCotizacionesAdmin")]
        public async Task<IActionResult> ConsultarSolicitudesCotizacionesAdmin()
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<SolicitudCotizacion>("ConsultarSolicitudesCotizacionesAdmin", commandType: CommandType.StoredProcedure);


                if (result.Count() > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay solicitudes registradas en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpGet]
        [Route("ConsultarDetalleSolicitudCotizacionAdmin")]
        public async Task<IActionResult> ConsultarDetalleSolicitudCotizacionAdmin(long IdSolicitudCotizacion)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<SolicitudCotizacionDetalleDTO>("ConsultarDetalleSolicitudCotizacionAdmin", new { IdSolicitudCotizacion }, commandType: CommandType.StoredProcedure);


                if (result != null)
                {
                    //Solicita los bocetos asociados y lo asocia a la lista de bocetos del DTO a devolver
                    var bocetos = await context.QueryAsync<Boceto>("ObtenerBocetosPorSolicitud", new { IdSolicitudCotizacion }, commandType: CommandType.StoredProcedure);

                    if (bocetos.Count() > 0)
                    {
                        result.Bocetos = bocetos.ToList();

                        resp.Codigo = 1;
                        resp.Mensaje = "";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No hay bocetos asociados a la solicitud en este momento";
                        resp.Contenido = false;
                        return Ok(resp);
                    }

                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay solicitudes registradas en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        //Cotizaciones admin

        [HttpGet]
        [Route("CrearCotizacionVista")]
        public async Task<IActionResult> CrearCotizacionVista(long IdSolicitudCotizacion)
        {
            Respuesta resp = new Respuesta();

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                try
                {
                    var query = "CrearCotizacionVista";
                    var parameters = new { IdSolicitudCotizacion = IdSolicitudCotizacion };

                    //Se hace un QueryMultipleAsync ya que se van a traer un conjunto de resultados para diferentes entidades en un mismo SP 
                    using (var multi = await connection.QueryMultipleAsync(query, parameters, commandType: CommandType.StoredProcedure))
                    {
                        // Leer datos del usuario
                        var usuario = await multi.ReadFirstOrDefaultAsync<Usuario>();
                        if (usuario == null)
                        {
                            resp.Codigo = 0;
                            resp.Mensaje = "No se encontró información del usuario.";
                            return Ok(resp);
                        }

                        // Leer datos de la solicitud de cotización
                        var solicitudCotizacion = await multi.ReadFirstOrDefaultAsync<SolicitudCotizacion>();
                        if (solicitudCotizacion == null)
                        {
                            resp.Codigo = 0;
                            resp.Mensaje = "No se encontró información de la solicitud de cotización.";
                            return Ok(resp);
                        }

                        // Leer datos de los bocetos
                        var bocetos = (await multi.ReadAsync<BocetoCotizacionDTO>()).ToList();

                        //En esta parte se asumen que solo hay dos monedas
                        var moneda = (Moneda)solicitudCotizacion.Moneda;

                        decimal subtotal = bocetos.Sum(b => (moneda == Moneda.Colones ? b.PrecioUnitarioColones : b.PrecioUnitarioDolares) * b.Cantidad);
                        decimal totalImpuestos = bocetos.Sum(b => (b.PorcentajeVenta / 100) * (moneda == Moneda.Colones ? b.PrecioUnitarioColones : b.PrecioUnitarioDolares) * b.Cantidad);
                        decimal total = subtotal + totalImpuestos;

                        // Construir la respuesta
                        var cotizacionVista = new CrearCotizacionVistaDTO
                        {
                            Usuario = usuario,
                            SolicitudCotizacion = solicitudCotizacion,
                            DescripcionCotizacion = "",
                            SubTotal = subtotal,
                            TotalImpuestos = totalImpuestos,
                            Total = total,
                            Bocetos = bocetos
                        };

                        resp.Codigo = 1;
                        resp.Mensaje = "Datos cargados correctamente.";
                        resp.Contenido = cotizacionVista;
                        return Ok(resp);
                    }
                }
                catch (Exception ex)
                {
                    resp.Codigo = 0;
                    resp.Mensaje = $"Error al obtener los datos: {ex.Message}";
                    return StatusCode(500, resp);
                }
            }

        }


        [HttpPost]
        [Route("CrearCotizacion")]
        public async Task<IActionResult> CrearCotizacion(CrearCotizacionVistaDTO cotizacion)
        {
            Respuesta resp = new Respuesta();

            // Validación inicial
            if (cotizacion == null || cotizacion.Usuario == null || cotizacion.Bocetos == null || !cotizacion.Bocetos.Any())
            {
                resp.Codigo = 0;
                resp.Mensaje = "La información de la cotización es inválida.";
                return BadRequest(resp);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Insertar en la tabla Cotizacion y obtener el IdCotizacion
                        var idCotizacion = await connection.ExecuteScalarAsync<long>(
                            "CrearCotizacion",
                            new
                            {
                                IdUsuario = cotizacion.Usuario.UsuarioId,
                                IdSolicitudCotizacion = cotizacion.SolicitudCotizacion.IdSolicitudCotizacion,
                                RutaCotizacion = "",
                                SubTotal = cotizacion.SubTotal,
                                Impuesto = cotizacion.TotalImpuestos,
                                Total = cotizacion.Total,
                                FechaCreacion = DateTime.Now,
                                Estado = 1,
                                Descripcion = cotizacion.DescripcionCotizacion
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        // Insertar cada boceto en la tabla Cotizacion_Detalle
                        foreach (var boceto in cotizacion.Bocetos)
                        {
                            await connection.ExecuteAsync(
                                "CrearCotizacionDetalle",
                                new
                                {
                                    IdCotizacion = idCotizacion,
                                    IdBoceto = boceto.IdBoceto,
                                    Cantidad = boceto.Cantidad,
                                    PrecioUnitarioColones = boceto.PrecioUnitarioColones,
                                    PrecioUnitarioDolares = boceto.PrecioUnitarioDolares
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        // Confirmar la transacción
                        transaction.Commit();

                        resp.Codigo = 1;
                        resp.Mensaje = "Cotización creada exitosamente.";
                        resp.Contenido = idCotizacion;
                        return Ok(resp);
                    }
                    catch (Exception ex)
                    {
                        // Rollback en caso de error
                        transaction.Rollback();

                        resp.Codigo = 0;
                        resp.Mensaje = $"Error al crear la cotización: {ex.Message}";
                        return StatusCode(500, resp);
                    }
                }
            }
        }

        [HttpGet]
        [Route("ActualizarRutaCotizacion")]
        public async Task<IActionResult> ActualizarRutaCotizacion(long idCotizacion, string downloadURL)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("ActualizarRutaCotizacion", new { idCotizacion, downloadURL }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {

                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = "";
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Error al actualizar la ruta del archivo de Cotización";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
    }
}

