using BigSolutionsApi.Entidades;
using BigSolutionsApi.Enums;

namespace BigSolutionsApi.DTOs
{
    public class CrearSolicitudCotizacionDTO
    {
        public int IdUsuario { get; set; }
        public string DescripcionGeneral { get; set; }
        public Moneda Moneda { get; set; }
        public List<Boceto> BocetosSeleccionados { get; set; }
    }
}
