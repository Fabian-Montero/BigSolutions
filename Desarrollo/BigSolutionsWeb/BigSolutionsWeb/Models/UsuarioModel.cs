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

        public List<Cliente> ListarClientes()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/ListarClientes";

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<List<Cliente>>().Result!;
                }
                else
                {
                    return new List<Cliente>();
                }
            }
        }

        public List<Cliente> BuscarClientes(string parametroBusqueda)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/BuscarCliente?ParametroBusqueda=" + parametroBusqueda;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<List<Cliente>>().Result!;
                }
                else
                {
                    return new List<Cliente>();
                }
            }
        }

        public string EliminarClientes(string identificacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/EliminarCliente?identificacion=" + identificacion;

                var res = httpClient.DeleteAsync(url).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadAsStringAsync().Result;
                }
                else
                {
                    return "Error al establecer conexion con el api, Eliminar el cliente ";
                }
            }
        }

        public DetallesCliente DetallesClientes(string identificacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/DetallesCliente?identificacion=" + identificacion;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<DetallesCliente>().Result!;
                }
                else
                {
                    return null;
                }

            }
        }
    }
}
