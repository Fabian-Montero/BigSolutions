using BigSolutionsApi.Entidades;

namespace BigSolutionsApi.DTOs
{
    public class CrearComprobanteDTO
    {
        public List<Orden>? Ordenes { get; set; } 
        public int? IdOrden { get; set; }         // Orden seleccionada.
        public string? DescripcionComprobante { get; set; }
        
        public string? RutaComprobante { get; set; }
    }
}
