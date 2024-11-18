using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Net.Http;

namespace BigSolutionsWeb.Models
{
    public class CotizacionesModel(HttpClient httpClient, IConfiguration iConfiguration)  : ICotizacionesModel
    {
        

        public Respuesta CrearSolicitudCotizacionVista(int IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/CrearSolicitudCotizacionVista?IdUsuario=" + IdUsuario;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta CrearSolicitudCotizacion(CrearSolicitudCotizacionDTO SolicitudCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/CrearSolicitudCotizacion";

                JsonContent body = JsonContent.Create(SolicitudCotizacion);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarSolicitudesCotizacionesCliente(int IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarSolicitudesCotizacionesCliente?IdUsuario=" + IdUsuario;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarDetalleSolicitudCotizacionCliente(long IdSolicitudCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarDetalleSolicitudCotizacionCliente?IdSolicitudCotizacion=" + IdSolicitudCotizacion;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        //Admin

        public Respuesta ConsultarSolicitudesCotizacionesAdmin()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarSolicitudesCotizacionesAdmin";

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ConsultarDetalleSolicitudCotizacionAdmin(long IdSolicitudCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarDetalleSolicitudCotizacionAdmin?IdSolicitudCotizacion=" + IdSolicitudCotizacion;

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
