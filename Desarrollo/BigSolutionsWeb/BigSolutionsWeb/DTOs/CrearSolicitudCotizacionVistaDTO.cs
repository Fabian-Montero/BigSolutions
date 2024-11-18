using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.DTOs
{
    public class CrearSolicitudCotizacionVistaDTO
    {
        public List<Boceto> Bocetos { get; set; }
        public string DescripcionGeneral { get; set; }
        public Moneda Moneda { get; set; }
    }
}
