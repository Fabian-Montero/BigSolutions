namespace BigSolutionsWeb.DTOs
{
    public class ActualizarRutasDTO
    {
        public long IdOrden { get; set; }
        public string? RutaOrdenCompra { get; set; }
        public string? RutaFacturaVenta { get; set; }
        public string? RutaBoletaEntrega { get; set; }
        public string? RutaComprobante { get; set; }
        public long? IdOrdenDetalleComprobantes { get; set; }
    }
}
