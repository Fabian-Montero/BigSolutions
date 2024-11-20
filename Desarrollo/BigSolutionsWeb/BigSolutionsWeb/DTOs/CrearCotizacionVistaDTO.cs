﻿using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.DTOs
{
    public class CrearCotizacionVistaDTO
    {
        public Usuario Usuario { get; set; }
        public SolicitudCotizacion SolicitudCotizacion { get; set; }
        public string DescripcionCotizacion { get; set; } = string.Empty;
        public List<BocetoCotizacionDTO> Bocetos { get; set; }

        public decimal Total { get; set; }
        public decimal TotalImpuestos { get; set; }

        public decimal SubTotal { get; set; }
    }
}
