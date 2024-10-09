using BigSolutionsApi.Entidades;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using System.Data;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RolesController(IConfiguration iConfiguration) : ControllerBase
    {
        [HttpGet]
        //[Authorize]
        [Route("ConsultarTiposRoles")]
        public async Task<IActionResult> ConsultarTiposRoles()
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryAsync<SelectListItem>("ConsultarTiposRoles", new { }, commandType: CommandType.StoredProcedure);

                if (result.Count() > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay roles registrados en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
    }
}
