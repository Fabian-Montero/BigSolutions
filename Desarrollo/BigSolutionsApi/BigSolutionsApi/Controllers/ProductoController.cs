using BigSolutionsApi.Entidades;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController(IConfiguration iConfiguration) : ControllerBase
    {
        [HttpPost]
        //[Authorize]
        [Route("AgregarProducto")]
        public async Task<IActionResult> AgregarProducto(Producto ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Producto>("AgregarProducto", new
                {
                    ent.IdCategoria,
                    ent.Nombre,
                    ent.Descripcion,
                    ent.Cantidad,
                    ent.Precio
                }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "Eror al registrar el producto";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpGet]
        //[Authorize]
        [Route("ConsultarProductos")]
        public async Task<IActionResult> ConsultarProductos()
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<Producto>("ConsultarProductos", new { }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "No hay productos registrados en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpGet]
        //[Authorize]
        [Route("ConsultarProducto")]
        public async Task<IActionResult> ConsultarProducto(int IdProducto)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Producto>("ConsultarProducto", new { IdProducto }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "No se ha encontrado el producto solicitado";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpPut]
        //[Authorize]
        [Route("ActualizarProducto")]
        public async Task<IActionResult> ActualizarProducto(Producto ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("ActualizarProducto", new
                {
                    ent.IdProducto,
                    ent.IdCategoria,
                    ent.Nombre,
                    ent.Descripcion,
                    ent.Cantidad,
                    ent.Precio,
                    ent.RutaImagen
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

        [HttpPut]
        //[Authorize]
        [Route("ActualizarRutaImagen")]
        public async Task<IActionResult> ActualizarRutaImagen(Producto ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("ActualizarRutaImagenProducto", new { ent.IdProducto, ent.RutaImagen }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "Error al actualizar la ruta de la imagen en la base de datos";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpDelete]
        //[Authorize]
        [Route("EliminarProducto")]
        public async Task<IActionResult> EliminarProducto(int IdProducto)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.ExecuteAsync("EliminarProducto", new { IdProducto }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "Error al eliminar el producto";
                    resp.Contenido = result;
                    return Ok(resp);
                }
            }
        }

        
    }
}
