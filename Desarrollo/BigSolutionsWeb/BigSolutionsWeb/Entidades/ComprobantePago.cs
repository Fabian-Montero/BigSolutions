using System.Diagnostics.Eventing.Reader;

namespace BigSolutionsWeb.Entidades
{
    public class ComprobantePago
    {
        public long IdOrdenDetalleComprobantes { get; set; }
        public long IdOrden { get; set; }
        public string? RutaComprobante { get; set; }
        public string? DescripcionComprobante { get; set; }
        public DateTime FechaCreacion { get; set; }
        public IFormFile? ArchivoComprobante { get; set; }
    }
}
