using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using System.Diagnostics.Eventing.Reader;
using System.Net.Http.Headers;

namespace BigSolutionsWeb.Models
{
    public class OrdenModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iAccesor) : IOrdenModel
    {
        

        public Respuesta CargarCrearOrdenCliente(long IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CargarCrearOrdenCliente?IdUsuario=" + IdUsuario;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public async Task<Respuesta> CrearOrdenCliente(CrearOrdenClienteDTO CrearOrdenClienteDTO)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CrearOrdenCliente";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(CrearOrdenClienteDTO);
                var resp = await httpClient.PostAsync(url, body);

                if (resp.IsSuccessStatusCode)
                    return await resp.Content.ReadFromJsonAsync<Respuesta>();
                else
                    return new Respuesta();
            }
        }

        public Respuesta ActualizarRutaComprobante(ComprobantePago ComprobantePago)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ActualizarRutaComprobante";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JsonContent body = JsonContent.Create(ComprobantePago);

                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }

        public Respuesta ActualizarRutaOrdenCompra(CrearOrdenClienteDTO Orden)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ActualizarRutaOrdenCompra";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(Orden);

                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarOrdenesCliente(long IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ConsultarOrdenesCliente?IdUsuario=" + IdUsuario;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarOrdenesAdmin()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ConsultarOrdenesAdmin";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta CargarCrearOrdenAdmin()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CargarCrearOrdenAdmin";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public async Task<Respuesta> CrearOrdenAdmin(CrearOrdenAdminDTO CrearOrdenAdminDTO)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CrearOrdenAdmin";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(CrearOrdenAdminDTO);
                var resp = await httpClient.PostAsync(url, body);

                if (resp.IsSuccessStatusCode)
                    return await resp.Content.ReadFromJsonAsync<Respuesta>();
                else
                    return new Respuesta();
            }
        }

        public async Task<Respuesta> ActualizarRutasArchivos(ActualizarRutasDTO ActualizarRutasDTO)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ActualizarRutasArchivos";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(ActualizarRutasDTO);

                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                {
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                    return new Respuesta();
            }
        }

        public Respuesta CargarEditarOrdenAdmin(int IdOrden)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CargarEditarOrdenAdmin?IdOrden=" + IdOrden;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public async Task<Respuesta> ActualizarOrdenAdmin(CrearOrdenAdminDTO editarOrdenAdminDTO)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ActualizarOrdenAdmin";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(editarOrdenAdminDTO);
                var resp = await httpClient.PutAsync(url, body);

                if (resp.IsSuccessStatusCode)
                    return await resp.Content.ReadFromJsonAsync<Respuesta>();
                else
                    return new Respuesta();
            }
        }

        public Respuesta CargarEditarOrdenCliente(int IdOrden)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/CargarEditarOrdenCliente?IdOrden=" + IdOrden;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public async Task<Respuesta> ActualizarOrdenCliente(CrearOrdenClienteDTO editarOrdenClienteDTO)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ActualizarOrdenCliente";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(editarOrdenClienteDTO);
                var resp = await httpClient.PutAsync(url, body);

                if (resp.IsSuccessStatusCode)
                    return await resp.Content.ReadFromJsonAsync<Respuesta>();
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarVistaOrden(long IdOrden)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Orden/ConsultarVistaOrden?IdOrden=" + IdOrden;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

    }
}
