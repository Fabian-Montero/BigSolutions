﻿using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Models.Interfaces;

using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Text.Json;

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

        public Respuesta Listar()
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/Listar";
               
                var res = httpClient.GetAsync(url).Result;

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


        public Respuesta ConsultarUsuarioPorId(int UsuarioId)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/ConsultarUsuarioPorId?UsuarioId=" + UsuarioId;

                var res = httpClient.GetAsync(url).Result;

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

        public Respuesta EditarUsuario(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Usuario/EditarUsuario";

                var res = httpClient.GetAsync(url).Result;
                JsonContent body = JsonContent.Create(ent);

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

    }
}