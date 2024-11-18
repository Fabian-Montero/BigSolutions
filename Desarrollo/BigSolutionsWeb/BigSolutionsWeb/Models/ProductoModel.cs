using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using System.Net.Http.Headers;

namespace BigSolutionsWeb.Models
{
    public class ProductoModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iAccesor) : IProductoModel
    {
        public Respuesta ConsultarProductos()
        {

            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Producto/ConsultarProductos";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.GetAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();

            }
        }
        public Respuesta AgregarProducto(Producto ent)
        {
            using (httpClient)
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Producto/AgregarProducto";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(ent);


                var resp = httpClient.PostAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }
        public Respuesta ActualizarRutaImagen(Producto ent)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Producto/ActualizarRutaImagen";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(ent);


                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }
        public Respuesta ConsultarProducto(int IdProducto)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Producto/ConsultarProducto?IdProducto=" + IdProducto;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.GetAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }
        public Respuesta ActualizarProducto(Producto ent)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Producto/ActualizarProducto";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(ent);


                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }
        public Respuesta EliminarProducto(int IdProducto)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("LLaves:UrlApi").Value + "Producto/EliminarProducto?IdProducto=" + IdProducto;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var resp = httpClient.DeleteAsync(url).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                {
                    return new Respuesta();
                }
            }
        }
    }
}
