using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Net.Http;

namespace BigSolutionsWeb.Models
{
    public class UsuarioModel(IConfiguration iConfiguration, HttpClient httpClient, IHttpContextAccessor iAccesor) : IUsuarioModel
    {
        public Respuesta Registro(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/Registro";

                JsonContent body = JsonContent.Create(ent);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                {
                    return new Respuesta();
                }
            }
        }

        public Respuesta InicioSesion(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/IniciarSesion";

                JsonContent body = JsonContent.Create(ent);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                {
                    return new Respuesta();
                }
            }
        }

        public Respuesta Recuperar(Usuario ent) {

            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/Recuperar";

                JsonContent body = JsonContent.Create(ent);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
                
            }
        }

        public Respuesta RecuperaContrasennaCodigo(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/RecuperaContrasennaCodigo";

                JsonContent body = JsonContent.Create(ent);

                var res = httpClient.PutAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
