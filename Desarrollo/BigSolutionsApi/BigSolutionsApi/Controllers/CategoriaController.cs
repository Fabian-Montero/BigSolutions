using BigSolutionsApi.Entidades;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriaController(IConfiguration iConfiguration) : ControllerBase
    {
        [HttpGet]
        //[Authorize]
        [Route("ConsultarTiposCategorias")]
        public async Task<IActionResult> ConsultarTiposCategorias()
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<SelectListItem>("ConsultarTiposCategorias", new { }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "No hay categorías registradas en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
    }
}
