using BigSolutionsApi.Entidades;

namespace BigSolutionsApi.DTOs
{
    public class CrearSolicitudCotizacionVistaDTO
    {
        public List<Boceto> Bocetos { get; set; }
        public string DescripcionGeneral { get; set; }
    }
}
