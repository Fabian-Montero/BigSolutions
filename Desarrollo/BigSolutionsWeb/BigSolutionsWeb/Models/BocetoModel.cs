using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Net.Http.Headers;
using System.Net.Http;
using BigSolutionsWeb.DTOs;

namespace BigSolutionsWeb.Models
{
    public class BocetoModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iAccesor) : IBocetoModel
    {
        public Respuesta ConsultarProductosCliente(string? busqueda, int numPagina, int tamannoPagina)
        {
            string url = $"{iConfiguration.GetSection("Llaves:UrlApi").Value}Boceto/ConsultarProductosCliente?Busqueda={busqueda}&NumPagina={numPagina}&TamannoPagina={tamannoPagina}";

            /*string token = iAccesor.HttpContext!.Session.GetString("TOKEN")?.ToString();
            if (!string.IsNullOrEmpty(token))
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }*/

            var resp = httpClient.GetAsync(url).Result;
            if (resp.IsSuccessStatusCode)
            {
                return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
            }
            else
            {
                return new Respuesta { Codigo = 0, Mensaje = "Error al consultar productos" };
            }
        }

        public async Task<Respuesta> GenerarBoceto(GenerateSketchDTO ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Boceto/GenerarBoceto";
                /*string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);*/

                JsonContent body = JsonContent.Create(ent);
                var resp = await httpClient.PostAsync(url, body);

                if (resp.IsSuccessStatusCode)
                    return await resp.Content.ReadFromJsonAsync<Respuesta>();
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarBocetosCliente(int IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Boceto/ConsultarBocetosCliente?IdUsuario=" + IdUsuario;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarBocetosAdmin()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Boceto/ConsultarBocetosAdmin";

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
