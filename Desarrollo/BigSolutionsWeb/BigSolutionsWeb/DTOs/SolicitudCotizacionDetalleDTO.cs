using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.DTOs
{
    public class SolicitudCotizacionDetalleDTO
    {
        public long IdSolicitudCotizacion { get; set; }
        public string Descripcion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string Estado { get; set; }
        public string? NombreCliente { get; set; }
        public Moneda Moneda { get; set; }
        public List<Boceto> Bocetos { get; set; }
    }
}
