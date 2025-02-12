using BigSolutionsApi.DTOs;
using BigSolutionsApi.Entidades;
using BigSolutionsApi.Enums;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdenController(IConfiguration iConfiguration) : ControllerBase
    {
        [HttpGet]
        //[Authorize]
        [Route("CargarCrearOrdenCliente")]
        public async Task<IActionResult> CargarCrearOrdenCliente(long IdUsuario)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var cotizaciones = await context.QueryAsync<Cotizacion>(
                        "ConsultarCotizacionesUsuario",
                        new { IdUsuario },
                        commandType: CommandType.StoredProcedure
                    );

                    if (cotizaciones.Count() > 0)
                    {

                        var CrearOrdenClienteDTO = new CrearOrdenClienteDTO
                        {
                            ListaCotizaciones = cotizaciones.ToList()
                        };

                        resp.Codigo = 1;
                        resp.Mensaje = "Ordenes cargadas correctamente.";
                        resp.Contenido = CrearOrdenClienteDTO;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No hay cotizaciones disponibles para este usuario.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Ocurrió un error al cargar las cotizaciones: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        //[Authorize]
        [HttpPost]
        [Route("CrearOrdenCliente")]
        public async Task<IActionResult> CrearOrdenCliente(CrearOrdenClienteDTO CrearOrdenClienteDTO)
        {
            Respuesta resp = new Respuesta();

            if (CrearOrdenClienteDTO == null)
            {
                resp.Codigo = 0;
                resp.Mensaje = "El objeto CrearOrdenClienteDTO es nulo.";
                return BadRequest(resp);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Crear la orden y obtener el IdOrden
                        var idOrden = await connection.ExecuteScalarAsync<long>(
                            "CrearOrdenCliente",
                            new
                            {
                                CrearOrdenClienteDTO.Descripcion,
                                CrearOrdenClienteDTO.IdUsuario,
                                CrearOrdenClienteDTO.MetodoPago,
                                FechaCreacion = DateTime.Now, 
                                RutaOrdenCompra = "",
                                Estado = EstadoOrden.PendienteDeConfirmar,
                                EstadoInterno = EstadoInternoOrden.NoEmpezada
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        ); ;

                        // Crear el comprobante y obtener el IdComprobante
                        long? idComprobante = null;
                        if (CrearOrdenClienteDTO.ComprobantePago.DescripcionComprobante != null && CrearOrdenClienteDTO.ComprobantePago != null)
                        {
                            idComprobante = await connection.ExecuteScalarAsync<long>(
                            "CrearComprobanteCliente",
                            new
                            {
                                IdOrden = idOrden,
                                DescripcionComprobante = CrearOrdenClienteDTO.ComprobantePago.DescripcionComprobante,
                                FechaCreacion = DateTime.Now,
                                RutaComprobante = ""
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                            );
                        }


                        // Insertar cotización detalle
                        await connection.ExecuteAsync(
                            "CrearOrdenDetalleCotizacionCliente",
                            new
                            {
                                IdOrden = idOrden,
                                IdCotizacion = CrearOrdenClienteDTO.IdCotizacion
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        // Insertar bocetos asociados a la cotización
                        var bocetos = await connection.QueryAsync<long>(
                            "ObtenerBocetosPorCotizacionCliente",
                            new { IdCotizacion = CrearOrdenClienteDTO.IdCotizacion },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        foreach (var idBoceto in bocetos)
                        {
                            await connection.ExecuteAsync(
                                "CrearOrdenDetalleBocetoCliente",
                                new { IdOrden = idOrden, IdBoceto = idBoceto },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        // Confirmar la transacción
                        transaction.Commit();

                        var respuestaContenido = new CrearOrdenClienteRespuestaDTO
                        {
                            IdOrden = idOrden,
                            IdComprobante = idComprobante
                        };

                        resp.Codigo = 1;
                        resp.Mensaje = "Orden creada exitosamente.";
                        resp.Contenido = respuestaContenido;
                        return Ok(resp);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        resp.Codigo = 0;
                        resp.Mensaje = $"Error al crear la orden: {ex.Message}";
                        return StatusCode(500, resp);
                    }
                }
            }
        }

        [HttpPut]
        //[Authorize]
        [Route("ActualizarRutaComprobante")]
        public async Task<IActionResult> ActualizarRutaComprobante(ComprobantePago ComprobantePago)
        {
            Respuesta resp = new Respuesta();

            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "ActualizarRutaComprobante",
                        new { ComprobantePago.IdOrdenDetalleComprobantes, ComprobantePago.RutaComprobante },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Ruta del comprobante actualizada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al actualizar la ruta del comprobante en la base de datos.";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al actualizar la ruta del comprobante: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }

        [HttpPut]
        //[Authorize]
        [Route("ActualizarRutaOrdenCompra")]
        public async Task<IActionResult> ActualizarRutaOrdenCompra(CrearOrdenClienteDTO Orden)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "ActualizarRutaOrdenCompra",
                        new { Orden.IdOrden, Orden.RutaOrdenCompra },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Ruta de la orden de compra actualizada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al actualizar la ruta de la orden de compra en la base de datos.";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al actualizar la ruta de la orden de compra: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }

        [HttpGet]
        [Route("ConsultarOrdenesCliente")]
        public async Task<IActionResult> ConsultarOrdenesCliente(long IdUsuario)
        {
            Respuesta resp = new Respuesta();

            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var ordenes = await connection.QueryAsync<Orden>(
                        "ConsultarOrdenesCliente",
                        new { IdUsuario },
                        commandType: CommandType.StoredProcedure
                    );

                    if (ordenes.Count() > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Órdenes consultadas correctamente.";
                        resp.Contenido = ordenes;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron órdenes para este usuario.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las órdenes: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        [HttpGet]
        [Route("ConsultarOrdenesAdmin")]
        public async Task<IActionResult> ConsultarOrdenesAdmin(long IdUsuario)
        {
            Respuesta resp = new Respuesta();

            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var ordenes = await connection.QueryAsync<Orden>(
                        "ConsultarOrdenesAdmin",
                        commandType: CommandType.StoredProcedure
                    );

                    if (ordenes.Count() > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Órdenes consultadas correctamente.";
                        resp.Contenido = ordenes;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron órdenes de clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las órdenes: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        [HttpGet]
        //[Authorize]
        [Route("CargarCrearOrdenAdmin")]
        public async Task<IActionResult> CargarCrearOrdenAdmin()
        {

            Respuesta resp = new Respuesta();

            try
            {
                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var cotizaciones = await context.QueryAsync<Cotizacion>(
                        "ConsultarCotizacionesAdmin",
                        commandType: CommandType.StoredProcedure
                    );

                    if (cotizaciones.Count() > 0)
                    {

                        var CrearOrdenAdminDTO = new CrearOrdenAdminDTO
                        {
                            ListaCotizaciones = cotizaciones.ToList()
                        };

                        resp.Codigo = 1;
                        resp.Mensaje = "Ordenes cargadas correctamente.";
                        resp.Contenido = CrearOrdenAdminDTO;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se econtraron cotizaciones.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Ocurrió un error al cargar las cotizaciones: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        [HttpPost]
        [Route("CrearOrdenAdmin")]
        public async Task<IActionResult> CrearOrdenAdmin(CrearOrdenAdminDTO CrearOrdenAdminDTO)
        {
            Respuesta resp = new Respuesta();

            if (CrearOrdenAdminDTO == null)
            {
                resp.Codigo = 0;
                resp.Mensaje = "El objeto CrearOrdenAdminDTO es nulo.";
                return BadRequest(resp);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Crear la orden y obtener el IdOrden
                        var idOrden = await connection.ExecuteScalarAsync<long>(
                            "CrearOrdenAdmin",
                            new
                            {
                                CrearOrdenAdminDTO.Descripcion,
                                CrearOrdenAdminDTO.IdUsuario,
                                CrearOrdenAdminDTO.MetodoPago,
                                FechaCreacion = DateTime.Now,
                                RutaOrdenCompra = CrearOrdenAdminDTO.RutaOrdenCompra ?? "",
                                Estado = EstadoOrden.PendienteDeConfirmar,
                                Material = CrearOrdenAdminDTO.Material ?? "",
                                FechaEntrega = CrearOrdenAdminDTO.FechaEntrega,
                                EstadoInternoOrden = CrearOrdenAdminDTO.EstadoInternoOrden,
                                DescripcionInterna = CrearOrdenAdminDTO.DescripcionInterna ?? "",
                                NumFacturaVenta = CrearOrdenAdminDTO.NumFacturaVenta
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        ) ;

                        // Crear el comprobante de pago si existe
                        long? idComprobante = null;
                        if (CrearOrdenAdminDTO.ComprobantePago != null)
                        {
                            idComprobante = await connection.ExecuteScalarAsync<long>(
                                "CrearComprobanteAdmin",
                                new
                                {
                                    IdOrden = idOrden,
                                    DescripcionComprobante = CrearOrdenAdminDTO.ComprobantePago.DescripcionComprobante,
                                    FechaCreacion = DateTime.Now,
                                    RutaComprobante = ""
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        // Insertar detalle de la cotización
                        await connection.ExecuteAsync(
                            "CrearOrdenDetalleCotizacionAdmin",
                            new
                            {
                                IdOrden = idOrden,
                                IdCotizacion = CrearOrdenAdminDTO.IdCotizacion
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        // Insertar bocetos asociados a la cotización
                        var bocetos = await connection.QueryAsync<long>(
                            "ObtenerBocetosPorCotizacionAdmin",
                            new { IdCotizacion = CrearOrdenAdminDTO.IdCotizacion },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        foreach (var idBoceto in bocetos)
                        {
                            await connection.ExecuteAsync(
                                "CrearOrdenDetalleBocetoAdmin",
                                new { IdOrden = idOrden, IdBoceto = idBoceto },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        // Confirmar la transacción
                        transaction.Commit();

                        var respuestaContenido = new CrearOrdenAdminRespuestaDTO
                        {
                            IdOrden = idOrden,
                            IdComprobante = idComprobante
                        };

                        resp.Codigo = 1;
                        resp.Mensaje = "Orden creada exitosamente.";
                        resp.Contenido = respuestaContenido;
                        return Ok(resp);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        resp.Codigo = 0;
                        resp.Mensaje = $"Error al crear la orden: {ex.Message}";
                        return StatusCode(500, resp);
                    }
                }
            }
        }

        [HttpPut]
        [Route("ActualizarRutasArchivos")]
        public async Task<IActionResult> ActualizarRutasArchivos([FromBody] ActualizarRutasDTO actualizarRutasDTO)
        {
            Respuesta resp = new Respuesta();

            if (actualizarRutasDTO == null)
            {
                resp.Codigo = 0;
                resp.Mensaje = "El objeto ActualizarRutasDTO es nulo.";
                return BadRequest(resp);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();
                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        if (!string.IsNullOrEmpty(actualizarRutasDTO.RutaOrdenCompra))
                        {
                            await connection.ExecuteAsync(
                                "ActualizarRutaOrdenCompra",
                                new
                                {
                                    IdOrden = actualizarRutasDTO.IdOrden,
                                    RutaOrdenCompra = actualizarRutasDTO.RutaOrdenCompra
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        if (!string.IsNullOrEmpty(actualizarRutasDTO.RutaFacturaVenta))
                        {
                            await connection.ExecuteAsync(
                                "ActualizarRutaFacturaVenta",
                                new
                                {
                                    IdOrden = actualizarRutasDTO.IdOrden,
                                    RutaFacturaVenta = actualizarRutasDTO.RutaFacturaVenta
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        if (!string.IsNullOrEmpty(actualizarRutasDTO.RutaBoletaEntrega))
                        {
                            await connection.ExecuteAsync(
                                "ActualizarRutaBoletaEntrega",
                                new
                                {
                                    IdOrden = actualizarRutasDTO.IdOrden,
                                    RutaBoletaEntrega = actualizarRutasDTO.RutaBoletaEntrega
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        if (!string.IsNullOrEmpty(actualizarRutasDTO.RutaComprobante))
                        {
                            await connection.ExecuteAsync(
                                "ActualizarRutaComprobante",
                                new
                                {
                                    IdOrdenDetalleComprobantes = actualizarRutasDTO.IdOrdenDetalleComprobantes,
                                    RutaComprobante = actualizarRutasDTO.RutaComprobante
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                            );
                        }

                        transaction.Commit();
                        resp.Codigo = 1;
                        resp.Mensaje = "Rutas de los archivos actualizadas correctamente.";
                        return Ok(resp);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        resp.Codigo = 0;
                        resp.Mensaje = $"Error al actualizar las rutas: {ex.Message}";
                        return StatusCode(500, resp);
                    }
                }
            }
        }


        [HttpGet]
        [Route("CargarEditarOrdenAdmin")]
        public async Task<IActionResult> CargarEditarOrdenAdmin(int IdOrden)
        {
            Respuesta resp = new Respuesta();

            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    await connection.OpenAsync();
                    CrearOrdenAdminDTO datosGenerales = new CrearOrdenAdminDTO();

                    // Orden
                    var orden = await connection.QueryFirstOrDefaultAsync(
                        "ConsultarDatosOrdenAdmin",
                        new { IdOrden = IdOrden },
                        commandType: CommandType.StoredProcedure
                    );

                    if (orden == null)
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron datos generales de la orden.";
                        return Ok(resp);
                    }

                    datosGenerales.IdOrden = orden.IdOrden;
                    datosGenerales.IdUsuario = orden.IdUsuario;
                    datosGenerales.RutaOrdenCompra = orden.RutaOrdenCompra;
                    datosGenerales.RutaFacturaVenta = orden.RutaFacturaVenta;
                    datosGenerales.RutaBoletaEntrega = orden.RutaBoletaEntrega;
                    datosGenerales.Descripcion = orden.Descripcion;
                    datosGenerales.EstadoInternoOrden = (EstadoInternoOrden?)orden.EstadoInternoOrden;
                    datosGenerales.MetodoPago = (MetodoPago)orden.MetodoPago;
                    datosGenerales.FechaCreacion = orden.FechaCreacion;
                    datosGenerales.Material = orden.Material;
                    datosGenerales.FechaEntrega = orden.FechaEntrega;
                    datosGenerales.DescripcionInterna = orden.DescripcionInterna;
                    datosGenerales.EstadoOrden = (EstadoOrden)orden.EstadoOrden;
                    datosGenerales.NumFacturaVenta = orden.NumFacturaVenta;

                    // Comprobantes
                    var comprobantes = await connection.QueryAsync<ComprobantePago>(
                        "ConsultarComprobantesPorOrden",
                        new { IdOrden = IdOrden },
                        commandType: CommandType.StoredProcedure
                    );
                    datosGenerales.ComprobantesOrden = comprobantes.ToList();


                    // Cotizacion de la orden
                    var cotizacionOrden = await connection.QueryFirstOrDefaultAsync<long>(
                        "ConsultarCotizacionPorOrden",
                        new { IdOrden = IdOrden },
                        commandType: CommandType.StoredProcedure
                    );
                    if (cotizacionOrden != 0) datosGenerales.IdCotizacion = cotizacionOrden;
                    

                    // Cotizaciones del Usuario
                    var cotizacionesUsuario = await connection.QueryAsync<Cotizacion>(
                        "ConsultarCotizacionesUsuario",
                        new { IdUsuario = datosGenerales.IdUsuario },
                        commandType: CommandType.StoredProcedure
                    );
                    if (cotizacionesUsuario.Any()) datosGenerales.ListaCotizaciones = cotizacionesUsuario.ToList();
                    
                    
                    resp.Codigo = 1;
                    resp.Mensaje = "Datos de la orden cargados correctamente.";
                    resp.Contenido = datosGenerales;

                    return Ok(resp);
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Ocurrió un error al cargar los datos de la orden: {ex.Message}";
                return StatusCode(500, resp);
            }
        }

        [HttpPut]
        [Route("ActualizarOrdenAdmin")]
        public async Task<IActionResult> ActualizarOrdenAdmin(CrearOrdenAdminDTO actualizarOrdenAdminDTO)
        {
            var respuesta = new Respuesta();

            if (actualizarOrdenAdminDTO == null)
            {
                respuesta.Codigo = 0;
                respuesta.Mensaje = "El objeto ActualizarOrdenAdminDTO es nulo.";
                return BadRequest(respuesta);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Actualizar la orden principal
                        await connection.ExecuteAsync(
                            "ActualizarOrdenAdmin",
                            new
                            {
                                IdOrden = actualizarOrdenAdminDTO.IdOrden,
                                Descripcion = actualizarOrdenAdminDTO.Descripcion,
                                MetodoPago = actualizarOrdenAdminDTO.MetodoPago,
                                EstadoOrden = actualizarOrdenAdminDTO.EstadoOrden,
                                Material = actualizarOrdenAdminDTO.Material,
                                FechaEntrega = actualizarOrdenAdminDTO.FechaEntrega,
                                EstadoInternoOrden = actualizarOrdenAdminDTO.EstadoInternoOrden,
                                DescripcionInterna = actualizarOrdenAdminDTO.DescripcionInterna,
                                NumFacturaVenta = actualizarOrdenAdminDTO.NumFacturaVenta
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );

                        long? idComprobante = null;
                        if (actualizarOrdenAdminDTO.ComprobantePago != null && actualizarOrdenAdminDTO.ComprobantePago.DescripcionComprobante != null)
                        {
                            idComprobante = await connection.ExecuteScalarAsync<long>(
                                "CrearComprobanteAdmin",
                                new
                                {
                                    IdOrden = actualizarOrdenAdminDTO.IdOrden,
                                    DescripcionComprobante = actualizarOrdenAdminDTO.ComprobantePago.DescripcionComprobante,
                                    FechaCreacion = DateTime.Now,
                                    RutaComprobante = ""
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                                );
                        }

                        // Cotización
                        await connection.ExecuteAsync(
                            "ActualizarOrdenDetalleCotizacionAdmin",
                            new
                            {
                                IdOrden = actualizarOrdenAdminDTO.IdOrden,
                                IdCotizacion = actualizarOrdenAdminDTO.IdCotizacion
                            },
                            commandType: CommandType.StoredProcedure,
                            transaction: transaction
                        );
                        var respuestaContenido = new CrearOrdenAdminRespuestaDTO
                        {
                            IdOrden = 0,
                            IdComprobante = idComprobante
                        };

                        transaction.Commit();
                        respuesta.Codigo = 1;
                        respuesta.Contenido = respuestaContenido;
                        respuesta.Mensaje = "Orden actualizada exitosamente.";
                        return Ok(respuesta);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        respuesta.Codigo = 0;
                        respuesta.Mensaje = $"Error al actualizar la orden: {ex.Message}";
                        return StatusCode(500, respuesta);
                    }
                }
            }
        }

        [HttpGet]
        [Route("CargarEditarOrdenCliente")]
        public async Task<IActionResult> CargarEditarOrdenCliente(int idOrden)
        {
            Respuesta resp = new Respuesta();

            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    await connection.OpenAsync();
                    CrearOrdenClienteDTO datosOrden = new CrearOrdenClienteDTO();

                    // Orden
                    var orden = await connection.QueryFirstOrDefaultAsync(
                        "ConsultarDatosOrdenCliente",
                        new { IdOrden = idOrden },
                        commandType: CommandType.StoredProcedure
                    );

                    if (orden == null)
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron datos generales de la orden.";
                        return Ok(resp);
                    }

                    datosOrden.IdOrden = orden.IdOrden;
                    datosOrden.Descripcion = orden.Descripcion;
                    datosOrden.RutaOrdenCompra = orden.RutaOrdenCompra;
                    datosOrden.MetodoPago = (MetodoPago)orden.MetodoPago;
                    datosOrden.FechaCreacion = orden.FechaCreacion;
                    datosOrden.IdUsuario = orden.IdUsuario;

                    // Comprobantes
                    var comprobantes = await connection.QueryAsync<ComprobantePago>(
                        "ConsultarComprobantesPorOrden",
                        new { IdOrden = idOrden },
                        commandType: CommandType.StoredProcedure
                    );
                    datosOrden.ComprobantesOrden = comprobantes.ToList();

                    // Cotización 
                    var cotizacionOrden = await connection.QueryFirstOrDefaultAsync<Cotizacion>(
                        "ConsultarCotizacionOrdenCliente",
                        new { IdOrden = idOrden },
                        commandType: CommandType.StoredProcedure
                    );
                    if (cotizacionOrden != null)
                    {
                        datosOrden.ListaCotizaciones.Add(cotizacionOrden);
                    }
                    resp.Codigo = 1;
                    resp.Mensaje = "Datos de la orden cargados correctamente.";
                    resp.Contenido = datosOrden;
                    return Ok(resp);
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Ocurrió un error al cargar los datos de la orden: {ex.Message}";
                return StatusCode(500, resp);
            }
        }

        [HttpPut]
        [Route("ActualizarOrdenCliente")]
        public async Task<IActionResult> ActualizarOrdenCliente(CrearOrdenClienteDTO actualizarOrdenClienteDTO)
        {
            var respuesta = new Respuesta();

            if (actualizarOrdenClienteDTO == null)
            {
                respuesta.Codigo = 0;
                respuesta.Mensaje = "El objeto ActualizarOrdenAdminDTO es nulo.";
                return BadRequest(respuesta);
            }

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        long? idComprobante = null;
                        if (actualizarOrdenClienteDTO.ComprobantePago != null)
                        {
                            idComprobante = await connection.ExecuteScalarAsync<long>(
                                "CrearComprobanteAdmin",
                                new
                                {
                                    IdOrden = actualizarOrdenClienteDTO.IdOrden,
                                    DescripcionComprobante = actualizarOrdenClienteDTO.ComprobantePago.DescripcionComprobante,
                                    FechaCreacion = DateTime.Now,
                                    RutaComprobante = ""
                                },
                                commandType: CommandType.StoredProcedure,
                                transaction: transaction
                                );
                        }

                        var respuestaContenido = new CrearOrdenAdminRespuestaDTO
                        {
                            IdOrden = 0,
                            IdComprobante = idComprobante
                        };

                        transaction.Commit();
                        respuesta.Codigo = 1;
                        respuesta.Contenido = respuestaContenido;
                        respuesta.Mensaje = "Orden actualizada exitosamente.";
                        return Ok(respuesta);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        respuesta.Codigo = 0;
                        respuesta.Mensaje = $"Error al actualizar la orden: {ex.Message}";
                        return StatusCode(500, respuesta);
                    }
                }
            }
        }

        //[Authorize]
        [HttpGet]
        [Route("ConsultarVistaOrden")]
        public async Task<IActionResult> ConsultarVistaOrden(long IdOrden)
        {
            Respuesta resp = new Respuesta();

            using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                try
                {
                    var queryOrden = "ConsultarOrdenVista";
                    var queryCotizacion = "ConsultarCotizacionOrdenVista";
                    var queryBocetos = "ConsultarBocetosOrdenVista";
                    var queryComprobantes = "ConsultarComprobantesOrdenVista";
                    var queryFacturasPendientes = "ConsultarFacturasPendientesOrdenVista";

                    var parameters = new { IdOrden = IdOrden };

                    // Orden
                    var orden = await connection.QueryFirstOrDefaultAsync<Orden>(queryOrden, parameters, commandType: CommandType.StoredProcedure);
                    if (orden == null)
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontró información de la orden.";
                        return Ok(resp);
                    }

                    // Cotización
                    var cotizacion = await connection.QueryFirstOrDefaultAsync<Cotizacion>(queryCotizacion, parameters, commandType: CommandType.StoredProcedure);
                    if (cotizacion == null)
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontró información de la cotización.";
                        return Ok(resp);
                    }

                    // Bocetos
                    var bocetos = (await connection.QueryAsync<Boceto>(queryBocetos, parameters, commandType: CommandType.StoredProcedure)).ToList();

                    // Comprobantes
                    var comprobantes = (await connection.QueryAsync<ComprobantePago>(queryComprobantes, parameters, commandType: CommandType.StoredProcedure)).ToList();

                    // Facturas Pendientes
                    var facturasPendientes = (await connection.QueryAsync<FacturaPendiente>(queryFacturasPendientes, parameters, commandType: CommandType.StoredProcedure)).ToList();

                    // Respuesta
                    var vistaOrden = new ConsultarVistaOrdenDTO
                    {
                        Orden = orden,
                        Cotizacion = cotizacion,
                        Bocetos = bocetos,
                        Comprobantes = comprobantes
                    };

                    resp.Codigo = 1;
                    resp.Mensaje = "Datos cargados correctamente.";
                    resp.Contenido = vistaOrden;
                    return Ok(resp);
                }
                catch (Exception ex)
                {
                    resp.Codigo = 0;
                    resp.Mensaje = $"Error al obtener los datos: {ex.Message}";
                    return StatusCode(500, resp);
                }
            }
        }

    }
}

