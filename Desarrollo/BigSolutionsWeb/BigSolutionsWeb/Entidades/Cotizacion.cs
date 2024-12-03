using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.Entidades
{
    public class Cotizacion
    {
        public int IdCotizacion { get; set; }
        public int IdUsuario { get; set; }
        public int IdSolicitudCotizacion { get; set; }
        public string? RutaCotizacion { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Impuesto { get; set; }
        public decimal Total { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string? PromptUsado { get; set; }

        public int Estado { get; set; }
        public string? Descripcion { get; set; }
        public string? NombreCompleto { get; set; }
        public Moneda? Moneda { get; set; }
    }
}
