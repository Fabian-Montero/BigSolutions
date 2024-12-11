using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.DTOs
{
    public class ConsultarVistaOrdenDTO
    {
        public Orden Orden { get; set; }
        public Cotizacion Cotizacion { get; set; }
        public List<Boceto> Bocetos { get; set; }
        public List<ComprobantePago> Comprobantes { get; set; }
        public List<FacturaPendiente> FacturasPendientes { get; set; }
    }
}
