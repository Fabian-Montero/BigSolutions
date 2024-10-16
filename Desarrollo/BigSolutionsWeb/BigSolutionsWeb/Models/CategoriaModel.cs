using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using System.Net.Http.Headers;

namespace BigSolutionsWeb.Models
{
    public class CategoriaModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iAccesor) : ICategoriaModel
    {
        public Respuesta ConsultarTiposCategorias()
        {

            using (httpClient = new HttpClient())
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Categoria/ConsultarTiposCategorias";
                //string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                //httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.GetAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();

            }
        }
    }
}
