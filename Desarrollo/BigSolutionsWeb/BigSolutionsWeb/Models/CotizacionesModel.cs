﻿using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

namespace BigSolutionsWeb.Models
{
    public class CotizacionesModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iAccesor) : ICotizacionesModel
    {


        public Respuesta CrearSolicitudCotizacionVista(int IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/CrearSolicitudCotizacionVista?IdUsuario=" + IdUsuario;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

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
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

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
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

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
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

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
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

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
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        //Cotizaciones

        public Respuesta CrearCotizacionVista(long IdSolicitudCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/CrearCotizacionVista?IdSolicitudCotizacion=" + IdSolicitudCotizacion;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta CrearCotizacion(CrearCotizacionVistaDTO cotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/CrearCotizacion";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                JsonContent body = JsonContent.Create(cotizacion);

                var res = httpClient.PostAsync(url, body).Result;

                if (res.IsSuccessStatusCode)
                {
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                }
                else
                {
                    // Registrar detalles del error
                    var errorContent = res.Content.ReadAsStringAsync().Result;
                    Console.WriteLine($"Error Content: {errorContent}");
                    return new Respuesta { Codigo = 0, Mensaje = "Error en la solicitud: " + errorContent };
                }
            }
        }

        public Respuesta ActualizarRutaCotizacion(long idCotizacion, string downloadURL)
        {
            using (httpClient = new HttpClient())
            {

                string url = iConfiguration.GetSection("Llaves:UrlApi").Value
                    + "Cotizacion/ActualizarRutaCotizacion?idCotizacion="
                    + idCotizacion
                    + "&downloadURL=" + Uri.EscapeDataString(downloadURL);
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

        public Respuesta ConsultarCotizacionesAdmin()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarCotizacionesAdmin";
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta ObtenerDetalleCotizacion(long IdCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ObtenerDetalleCotizacion?IdCotizacion=" + IdCotizacion;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        //Cotizaciones Cliente

        public Respuesta ConsultarCotizacionesCliente(long IdUsuario)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/ConsultarCotizacionesUsuario?IdUsuario=" + IdUsuario;
                string token = iAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var res = httpClient.GetAsync(url).Result;

                if (res.IsSuccessStatusCode)
                    return res.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta EliminarCotizacion(long IdCotizacion)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Cotizacion/EliminarCotizacion?IdCotizacion=" + IdCotizacion;
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
