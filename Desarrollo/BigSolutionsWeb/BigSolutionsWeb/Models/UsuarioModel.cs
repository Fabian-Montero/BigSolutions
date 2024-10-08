using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

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

        public Respuesta? ConsultarUsuarioPerfil(long idusuario)
        {
            string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/ConsultarUsuarioPerfil?idusuario=" + idusuario;
            var res = httpClient.GetAsync(url).Result;

            if (res.IsSuccessStatusCode)
                return res.Content.ReadFromJsonAsync<Respuesta>().Result;
            else
                return new Respuesta();
        }

        public Respuesta ActualizarPerfilUsuario(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/ActualizarPerfilUsuario";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(ent);
                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        public Respuesta EliminarPerfilUsuario(long UsuarioId)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/EliminarPerfilUsuario?UsuarioId=" + UsuarioId;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.DeleteAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
