﻿using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.DTOs
{
    public class CrearOrdenAdminDTO
    {
        public long? IdOrden { get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public string? RutaOrdenCompra { get; set; }
        public string? RutaFacturaVenta { get; set; }
        public string? RutaBoletaEntrega { get; set; }
        public MetodoPago MetodoPago { get; set; }
        public ComprobantePago ComprobantePago { get; set; } = new ComprobantePago();
        public List<ComprobantePago> ComprobantesOrden { get; set; } = new List<ComprobantePago>();
        public List<Cotizacion> ListaCotizaciones { get; set; } = new List<Cotizacion>();
        public long IdCotizacion { get; set; }
        public long IdUsuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public EstadoOrden EstadoOrden { get; set; }

        //Archivos

        public IFormFile? OrdenCompraArchivo { get; set; }
        public IFormFile? FacturaVentaArchivo { get; set; }
        public IFormFile? BoletaEntregaArchivo { get; set; }

        //Control interno

        public string? Material { get; set; }
        public DateTime? FechaEntrega { get; set; }
        public EstadoInternoOrden? EstadoInternoOrden { get; set; }
        public string? DescripcionInterna { get; set; }
    }
}
