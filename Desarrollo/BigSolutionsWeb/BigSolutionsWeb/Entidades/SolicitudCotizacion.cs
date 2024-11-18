using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.Entidades
{
    public class SolicitudCotizacion
    {
        public long IdSolicitudCotizacion { get; set; }
        public int IdUsuario { get; set; }
        public string Descripcion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string Estado { get; set; }
        public string? NombreCliente { get; set; }
        public Moneda? Moneda { get; set; }
    }
}
