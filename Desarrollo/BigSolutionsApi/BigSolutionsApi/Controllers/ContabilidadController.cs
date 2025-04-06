using BigSolutionsApi.DTOs;
using BigSolutionsApi.Entidades;
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
    public class ContabilidadController(IConfiguration iConfiguration) : ControllerBase
    {
        /*[Authorize]*/
        [HttpGet]
        [Route("ConsultarFacturas")]
        public async Task<IActionResult> ConsultarFacturas()
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var facturas = await connection.QueryAsync<FacturaDTO>(
                        "ConsultarFacturas",
                        commandType: CommandType.StoredProcedure
                    );

                    if (facturas.Count() > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Facturas consultadas correctamente.";
                        resp.Contenido = facturas;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron facturas de los clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las facturas: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        /*[Authorize]*/
        [HttpGet]
        [Route("CargarAgregarFactura")]
        public async Task<IActionResult> AgregarFactura()
        {
            //Mostar todas la ordenes (que no tienen factura)
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var ordenes = await connection.QueryAsync<Orden>(
                        "ConsultarOrdenesSinFactura",
                        commandType: CommandType.StoredProcedure
                    );

                    var Factura = new CrearFacturaDTO()
                    {
                        Ordenes = ordenes.ToList()
                    };

                    if (ordenes.Count() > 0)
                    {

                        resp.Codigo = 1;
                        resp.Mensaje = "Órdenes consultadas correctamente.";
                        resp.Contenido = Factura;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron órdenes de los clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las facturas: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        /*[Authorize]*/
        [HttpPost]
        [Route("AgregarFactura")]
        public async Task<IActionResult> AgregarFactura(CrearFacturaDTO Factura)
        {
            //Agregar factura a la orden
            Respuesta resp = new Respuesta();

            try
            {
                using (var context =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "AgregarFactura",
                        new { Factura.IdOrden, Factura.RutaFacturaVenta, Factura.NumFacturaVenta },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Factura agregada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al agregar la factura en la base de datos.";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al agregar la factura: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }

        [HttpDelete]
        //[Authorize]
        [Route("EliminarFactura")]
        public async Task<IActionResult> EliminarFactura(long IdOrden)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var context =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync("EliminarFactura", new { IdOrden },
                        commandType: CommandType.StoredProcedure);

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al eliminar la factura";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al eliminar la factura: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }
        //Comprobantes


        /*[Authorize]*/
        [HttpGet]
        [Route("ConsultarComprobantes")]
        public async Task<IActionResult> ConsultarComprobantes()
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var facturas = await connection.QueryAsync<ComprobantePago>(
                        "ConsultarComprobantes",
                        commandType: CommandType.StoredProcedure
                    );

                    if (facturas.Count() > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Comprobantes consultados correctamente.";
                        resp.Contenido = facturas;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron comprobantes de los clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las comprobantes: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        [HttpGet]
        [Route("CargarAgregarComprobantes")]
        public async Task<IActionResult> CargarAgregarComprobante()
        {

            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var ordenes = await connection.QueryAsync<Orden>(
                        "ConsultarOrdenesAdmin",
                        commandType: CommandType.StoredProcedure
                    );

                    var Comprobante = new CrearComprobanteDTO()
                    {
                        Ordenes = ordenes.ToList()
                    };

                    if (ordenes.Count() > 0)
                    {

                        resp.Codigo = 1;
                        resp.Mensaje = "Órdenes consultadas correctamente.";
                        resp.Contenido = Comprobante;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron órdenes de los clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las facturas: {ex.Message}";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        /*[Authorize]*/
        [HttpPost]
        [Route("AgregarComprobante")]
        public async Task<IActionResult> AgregarComprobante(CrearComprobanteDTO Comprobante)
        {
            //Agregar factura a la orden
            Respuesta resp = new Respuesta();

            try
            {
                using (var context =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "AgregarComprobante",
                        new
                        {
                            Comprobante.IdOrden, Comprobante.RutaComprobante, Comprobante.DescripcionComprobante,
                            FechaCreacion = DateTime.Now
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Comprobante agregada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al agregar el comprobante en la base de datos.";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al agregar el comprobante: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }

        [HttpDelete]
        //[Authorize]
        [Route("EliminarComprobante")]
        public async Task<IActionResult> EliminarComprobante(long IdOrdenDetalleComprobantes)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var context =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync("EliminarComprobante", new { IdOrdenDetalleComprobantes },
                        commandType: CommandType.StoredProcedure);

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al eliminar el comprobante";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al eliminar el comprobante: {ex.Message}";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }

        //Facturas pendientes
        
        //[Authorize]
        [HttpGet]
        [Route("ConsultarFacturasPendientes")]
        public async Task<IActionResult> ConsultarFacturasPendientes()
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var facturas = await connection.QueryAsync<FacturaPendiente>(
                        "ConsultarFacturasPendientes",
                        commandType: CommandType.StoredProcedure
                    );

                    if (facturas.Count() > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Facturas pendientes consultadas correctamente.";
                        resp.Contenido = facturas;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron facturas pendientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar las facturas pendientes";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }


        [HttpGet]
        [Route("CargarAgregarFacturasPendientes")]
        public async Task<IActionResult> CargarAgregarFacturasPendientes()
        {

            Respuesta resp = new Respuesta();
            try
            {
                using (var connection =
                       new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    //cargar ordenes que no tienen facturas pendientes
                    var ordenes = await connection.QueryAsync<Orden>(
                        "ConsultarOrdenesSinFacturasPendintes",
                        commandType: CommandType.StoredProcedure
                    );

                    var FacturaPendiente = new CrearFacturaPendienteDTO()
                    {
                        Ordenes = ordenes.ToList()
                    };

                    if (ordenes.Count() > 0)
                    {

                        resp.Codigo = 1;
                        resp.Mensaje = "Órdenes consultadas correctamente.";
                        resp.Contenido = FacturaPendiente;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontraron órdenes de los clientes.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error interno al consultar las facturas pendientes";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }

        //[Authorize]
        [HttpPost]
        [Route("AgregarFacturaPendiente")]
        public async Task<IActionResult> AgregarFacturaPendiente(CrearFacturaPendienteDTO FacturaPendiente)
        {
            Respuesta resp = new Respuesta();

            try
            {
                // Validar que el objeto y sus campos obligatorios no sean nulos.
                if (FacturaPendiente == null 
                    || FacturaPendiente.IdOrden == null 
                    || !FacturaPendiente.Subtotal.HasValue 
                    || !FacturaPendiente.ImpuestoIVA.HasValue 
                    || !FacturaPendiente.Total.HasValue)
                {
                    return BadRequest("Todos los campos son obligatorios.");
                }

                using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await context.ExecuteAsync(
                        "AgregarFacturaPendiente",
                        new
                        {
                            IdOrden = FacturaPendiente.IdOrden,
                            Subtotal = FacturaPendiente.Subtotal.Value,
                            ImpuestoIVA = FacturaPendiente.ImpuestoIVA.Value,
                            Total = FacturaPendiente.Total.Value
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Factura pendiente agregada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al agregar la factura pendiente en la base de datos.";
                        resp.Contenido = false;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = 0;
                resp.Mensaje = $"Error interno al agregar la factura pendiente";
                resp.Contenido = false;
                return StatusCode(500, resp);
            }
        }
        
        //[Authorize]
        [HttpGet]
        [Route("ConsultarFacturaPendiente")]
        public async Task<IActionResult> ConsultarFacturaPendiente(long IdFacturaPendiente)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await connection.QueryFirstOrDefaultAsync<CrearFacturaPendienteDTO>(
                        "ConsultarFacturaPendiente",
                        new { IdFacturaPendiente = IdFacturaPendiente },
                        commandType: CommandType.StoredProcedure
                    );
            
                    if (result != null)
                    {
                        // Ya no es necesario consultar la orden por separado, pues ya viene 
                        // toda la información integrada en el resultado de la consulta
                
                        resp.Codigo = 1;
                        resp.Mensaje = "Factura pendiente consultada correctamente.";
                        resp.Contenido = result;
                        return Ok(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontró la factura pendiente.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al consultar la factura pendiente";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }
        
        [HttpPut]
        [Route("ActualizarFacturaPendiente")]
        public async Task<IActionResult> ActualizarFacturaPendiente([FromBody] CrearFacturaPendienteDTO FacturaPendiente)
        {
            Respuesta resp = new Respuesta();
            try
            {
                if (FacturaPendiente == null
                    || FacturaPendiente.IdFacturaPendiente <= 0
                    || FacturaPendiente.IdOrden == null
                    || FacturaPendiente.Subtotal == null
                    || FacturaPendiente.ImpuestoIVA == null
                    || FacturaPendiente.Total == null)
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Todos los campos son obligatorios.";
                    resp.Contenido = null;
                    return BadRequest(resp);
                }

                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var parameters = new
                    {
                        IdFacturaPendiente = FacturaPendiente.IdFacturaPendiente,
                        IdOrden = FacturaPendiente.IdOrden,
                        Subtotal = FacturaPendiente.Subtotal,
                        ImpuestoIVA = FacturaPendiente.ImpuestoIVA,
                        Total = FacturaPendiente.Total
                    };

                    var result = await connection.QueryFirstOrDefaultAsync<dynamic>(
                        "ActualizarFacturaPendiente",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    if (result != null)
                    {
                        resp.Codigo = result.Codigo;
                        resp.Mensaje = result.Mensaje;
                        resp.Contenido = null;

                        if (resp.Codigo == 1)
                        {
                            return Ok(resp);
                        }
                        else
                        {
                            return BadRequest(resp);
                        }
                    }
                    else
                    {
                        resp.Codigo = -1;
                        resp.Mensaje = "No se recibió respuesta del servidor.";
                        resp.Contenido = null;
                        return StatusCode(500, resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error al actualizar la factura pendiente:";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }
        
        [HttpDelete]
        [Route("EliminarFacturaPendiente")]
        public async Task<IActionResult> EliminarFacturaPendiente(long IdFacturaPendiente)
        {
            Respuesta resp = new Respuesta();
            try
            {
                using (var connection = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                {
                    var result = await connection.ExecuteAsync(
                        "EliminarFacturaPendiente", 
                        new { IdFacturaPendiente },
                        commandType: CommandType.StoredProcedure
                    );
            
                    if (result > 0)
                    {
                        resp.Codigo = 1;
                        resp.Mensaje = "Factura pendiente eliminada correctamente.";
                        resp.Contenido = null;
                        return Ok(resp);
                    }
                    else if (result == 0)
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "No se encontró la factura pendiente.";
                        resp.Contenido = null;
                        return NotFound(resp);
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Error al eliminar la factura pendiente.";
                        resp.Contenido = null;
                        return StatusCode(500, resp);
                    }
                }
            }
            catch (Exception ex)
            {
                resp.Codigo = -1;
                resp.Mensaje = $"Error interno al eliminar la factura pendiente";
                resp.Contenido = null;
                return StatusCode(500, resp);
            }
        }
    }
}

