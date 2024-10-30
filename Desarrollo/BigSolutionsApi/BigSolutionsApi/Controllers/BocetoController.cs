using BigSolutionsApi.Entidades;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Text;
using BigSolutionsApi.DTOs;
using Firebase.Auth;
using Firebase.Storage;
using BigSolutionsApi.Modelos;

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BocetoController(IConfiguration iConfiguration, IFirebaseModel iFirebaseModel) : ControllerBase
    {

        //[Authorize]
        [HttpGet]
        [Route("ConsultarProductosCliente")]
        public async Task<IActionResult> ConsultarProductosCliente(string? Busqueda, int NumPagina = 1, int TamannoPagina = 10)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {
                var result = await context.QueryMultipleAsync("ConsultarProductosCliente", new { NumPagina, TamannoPagina, Busqueda, }, commandType: CommandType.StoredProcedure);
                var productos = result.Read<Producto>().ToList();
                var totalProductos = result.ReadSingle<int>();

                if (productos.Count() > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "";
                    resp.Contenido = new { Productos = productos, TotalProductos = totalProductos };
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

        [HttpPost]
        [Route("GenerarBoceto")]
        public async Task<IActionResult> GenerarBoceto(GenerateSketchDTO ent)
        {
            Respuesta resp = new Respuesta();
            string prompt = $"{ent.ProductPrompt}. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: '{ent.LogoDescription}'. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.";

            var openAiApiKey = iConfiguration.GetSection("OpenAI:ApiKey").Value;
            var requestBody = new
            {
                model = "dall-e-3",
                prompt = prompt,
                n = 1,
                size = "1024x1024",
                response_format = "b64_json"
            };

            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", openAiApiKey);
                var jsonBody = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(jsonBody, Encoding.UTF8, "application/json");

                var openAiResponse = await client.PostAsync("https://api.openai.com/v1/images/generations", content);

                if (openAiResponse.IsSuccessStatusCode)
                {
                    var responseContent = await openAiResponse.Content.ReadAsStringAsync();
                    var openAiResult = JsonSerializer.Deserialize<RespuestaOpenAI>(responseContent);

                    if (openAiResult != null && openAiResult.Data != null && openAiResult.Data.Count > 0)
                    {
                        string base64Image = openAiResult.Data[0].b64_json;
                        string revisedPrompt = openAiResult.Data[0].RevisedPrompt;

                        using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                        {
                            var parameters = new DynamicParameters(new
                            {
                                IdProducto = ent.ProductId,
                                IdUsuario = ent.UserId,
                                FechaCreacion = DateTime.UtcNow,
                                PromptUsado = revisedPrompt,
                                PromptOriginal = prompt
                            });
                            parameters.Add("IdBoceto", dbType: DbType.Int32, direction: ParameterDirection.Output);

                            await context.ExecuteAsync("GenerarBoceto", parameters, commandType: CommandType.StoredProcedure);
                            int idBoceto = parameters.Get<int>("IdBoceto");

                            // Subir la imagen a Firebase y actualiza la ruta del boceto
                            var firebaseUrl = await iFirebaseModel.GuardarImagenBase64EnFirebase("bocetos", idBoceto, base64Image);

                            if (!string.IsNullOrEmpty(firebaseUrl))
                            {
                                var result = await context.ExecuteAsync("ActualizarRutaImagenBoceto",
                                    new { IdBoceto = idBoceto, RutaImagen = firebaseUrl },
                                    commandType: CommandType.StoredProcedure);

                                if (result > 0)
                                {
                                    resp.Codigo = 1;
                                    resp.Mensaje = "Boceto generado y guardado exitosamente.";
                                    resp.Contenido = "";
                                }
                                else
                                {
                                    resp.Codigo = 0;
                                    resp.Mensaje = "Error al actualizar la ruta de la imagen en la base de datos.";
                                }
                                return Ok(resp);
                            }
                            else
                            {
                                resp.Codigo = 0;
                                resp.Mensaje = "Error al guardar la imagen en Firebase.";
                                return Ok(resp);
                            }
                        }
                    }
                    else
                    {
                        resp.Codigo = 0;
                        resp.Mensaje = "Formato de respuesta inesperado de OpenAI.";
                        return Ok(resp);
                    }
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "Error al comunicarse con OpenAI para generar la imagen.";
                    return Ok(resp);
                }
            }
        }


        [HttpGet]
        [Route("ConsultarBocetosCliente")]
        public async Task<IActionResult> ConsultarBocetosCliente(int IdUsuario)
        {
            Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {

                var result = await context.QueryAsync<Boceto>("ConsultarBocetosCliente", new { IdUsuario }, commandType: CommandType.StoredProcedure);

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
                    res.Mensaje = "No se encontraron bocetos registrados.";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }

        [HttpGet]
        [Route("ConsultarBocetosAdmin")]
        public async Task<IActionResult> ConsultarBocetosAdmin()
        {
            Respuesta res = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
            {

                var result = await context.QueryAsync<Boceto>("ConsultarBocetosAdmin", commandType: CommandType.StoredProcedure);

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
                    res.Mensaje = "No se encontraron bocetos registrados.";
                    res.Contenido = false;
                    return Ok(res);
                }
            }
        }
    }
}

