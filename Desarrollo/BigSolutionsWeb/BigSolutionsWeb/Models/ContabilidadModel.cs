using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using System.Net.Http.Headers;

namespace BigSolutionsWeb.Models
{
    public class ContabilidadModel(IConfiguration iConfiguration, IHttpContextAccessor iAccesor, HttpClient httpClient) : IContabilidadModel
    {

        public Respuesta ConsultarFacturas()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/ConsultarFacturas";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        public Respuesta CargarAgregarFactura()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/CargarAgregarFactura";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta AgregarFactura(CrearFacturaDTO Factura)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/AgregarFactura";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JsonContent body = JsonContent.Create(Factura);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta EliminarFactura(long IdOrden)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/EliminarFactura?IdOrden=" + IdOrden;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.DeleteAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarComprobantes()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/ConsultarComprobantes";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        public Respuesta CargarAgregarComprobantes()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/CargarAgregarComprobantes";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta AgregarComprobante(CrearComprobanteDTO Comprobante)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/AgregarComprobante";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JsonContent body = JsonContent.Create(Comprobante);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta EliminarComprobante(long IdOrdenDetalleComprobantes)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/EliminarComprobante?IdOrdenDetalleComprobantes=" + IdOrdenDetalleComprobantes;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.DeleteAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        
        //Facturas pendientes
        
        public Respuesta ConsultarFacturasPendientes()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/ConsultarFacturasPendientes";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        
        public Respuesta CargarAgregarFacturasPendientes()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/CargarAgregarFacturasPendientes";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        
        public Respuesta AgregarFacturaPendiente(CrearFacturaPendienteDTO FacturaPendiente)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/AgregarFacturaPendiente";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JsonContent body = JsonContent.Create(FacturaPendiente);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarFacturaPendiente(long IdFacturaPendiente)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/ConsultarFacturaPendiente?IdFacturaPendiente=" + IdFacturaPendiente;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ActualizarFacturaPendiente(CrearFacturaPendienteDTO FacturaPendiente)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/ActualizarFacturaPendiente";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JsonContent body = JsonContent.Create(FacturaPendiente);

                var res = httpClient.PutAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
        
        public Respuesta EliminarFacturaPendiente(long IdFacturaPendiente)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Contabilidad/EliminarFacturaPendiente?IdFacturaPendiente=" + IdFacturaPendiente;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.DeleteAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
