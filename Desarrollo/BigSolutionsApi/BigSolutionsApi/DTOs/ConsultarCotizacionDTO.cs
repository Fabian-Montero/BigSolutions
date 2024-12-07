using BigSolutionsApi.Entidades;

namespace BigSolutionsApi.DTOs
{
    public class ConsultarCotizacionDTO
    {
        public Usuario Usuario { get; set; }
        public Cotizacion Cotizacion { get; set; }
        public SolicitudCotizacion SolicitudCotizacion { get; set; }
        public string DescripcionCotizacion { get; set; } = string.Empty;
        public List<BocetoCotizacionDTO> Bocetos { get; set; }

        public decimal Total { get; set; }
        public decimal TotalImpuestos { get; set; }

        public decimal SubTotal { get; set; }
    }
}
