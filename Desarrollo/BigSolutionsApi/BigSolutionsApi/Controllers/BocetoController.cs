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

namespace BigSolutionsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BocetoController(IConfiguration iConfiguration) : ControllerBase
    {
        [HttpGet]
        //[Authorize]
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

            // Prompt dinámico
            string prompt = $"{ent.ProductPrompt}. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: '{ent.LogoDescription}'. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product's texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.";


            // Configuración de los parámetros para la petición a OpenAI
            var openAiApiKey = iConfiguration.GetSection("OpenAI:ApiKey").Value;
            var requestBody = new
            {
                model = "dall-e-3",
                prompt = prompt,
                n = 1,
                size = "1024x1024"
            };

            // Petición HTTP a OpenAI
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", openAiApiKey);

                var jsonBody = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(jsonBody, Encoding.UTF8, "application/json");

                var openAiResponse = await client.PostAsync("https://api.openai.com/v1/images/generations", content);

                if (openAiResponse.IsSuccessStatusCode)
                {
                    // Manejo de la respuesta de OpenAI
                    var responseContent = await openAiResponse.Content.ReadAsStringAsync();

                    // Deserialización de la respuesta de OpenAI
                    var openAiResult = JsonSerializer.Deserialize<RespuestaOpenAI>(responseContent);

                    if (openAiResult != null && openAiResult.Data != null && openAiResult.Data.Count > 0)
                    {
                        string imageUrl = openAiResult.Data[0].Url;
                        string revisedPrompt = openAiResult.Data[0].RevisedPrompt;

                        // Guardar el boceto en la base de datos si se obtuvo una URL de imagen
                        if (!string.IsNullOrEmpty(imageUrl))
                        {
                            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:SQLServerConnection").Value))
                            {
                                var nuevoBoceto = new Boceto
                                {
                                    IdProducto = ent.ProductId,
                                    IdUsuario = ent.UserId,
                                    FechaCreacion = DateTime.UtcNow,
                                    RutaImagen = imageUrl,
                                    PromptUsado = revisedPrompt ?? prompt // Usa el prompt revisado si está disponible
                                };

                                var query = "INSERT INTO Bocetos (IdProducto, IdUsuario, FechaCreacion, RutaImagen, PromptUsado) VALUES (@IdProducto, @IdUsuario, @FechaCreacion, @RutaImagen, @PromptUsado)";
                                await context.ExecuteAsync(query, nuevoBoceto);

                                resp.Codigo = 1;
                                resp.Mensaje = "Boceto generado y guardado exitosamente.";
                                resp.Contenido = nuevoBoceto;
                                return Ok(resp);
                            }
                        }
                        else
                        {
                            resp.Codigo = 0;
                            resp.Mensaje = "Error al generar la imagen. No se recibió URL de la imagen.";
                            return Ok(resp);
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


    }
}
