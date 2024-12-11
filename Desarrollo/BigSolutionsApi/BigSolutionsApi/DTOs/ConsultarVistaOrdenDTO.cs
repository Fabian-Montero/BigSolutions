using BigSolutionsApi.Entidades;

namespace BigSolutionsApi.DTOs
{
    public class ConsultarVistaOrdenDTO
    {
        public Orden Orden { get; set; }
        public Cotizacion Cotizacion { get; set; }
        public List<Boceto> Bocetos { get; set; } = new List<Boceto>();
        public List<ComprobantePago> Comprobantes { get; set; } = new List<ComprobantePago>();
        public List<FacturaPendiente> FacturasPendientes { get; set; } = new List<FacturaPendiente>();
    }
}
