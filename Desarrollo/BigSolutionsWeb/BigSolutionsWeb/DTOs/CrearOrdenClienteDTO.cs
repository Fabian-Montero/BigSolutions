using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;
using System.Diagnostics.Eventing.Reader;

namespace BigSolutionsWeb.DTOs
{
    public class CrearOrdenClienteDTO
    {
        public long? IdOrden {  get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public string? RutaOrdenCompra { get; set; }
        public IFormFile? OrdenCompra { get; set; }
        public MetodoPago MetodoPago { get; set; }
        public ComprobantePago ComprobantePago { get; set; } = new ComprobantePago();
        public List<ComprobantePago> ComprobantesOrden { get; set; } = new List<ComprobantePago>();
        public List<Cotizacion> ListaCotizaciones { get; set; } = new List<Cotizacion>();
        public long IdCotizacion { get; set; }
        public long IdUsuario { get; set; }
    }
}
