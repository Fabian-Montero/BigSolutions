using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;

namespace BigSolutionsWeb.Models
{
    public class RolModel(IConfiguration iConfiguration, HttpClient httpClient, IHttpContextAccessor iAccesor) : IRolModel
    {
        public Respuesta ConsultarTiposRoles()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Roles/ConsultarTiposRoles";
                // string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                // httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.GetAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}

