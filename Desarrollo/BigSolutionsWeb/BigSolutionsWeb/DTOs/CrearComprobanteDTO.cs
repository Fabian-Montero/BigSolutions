using BigSolutionsWeb.Entidades;
using System.Drawing;

namespace BigSolutionsWeb.DTOs
{
    public class CrearComprobanteDTO
    {
        public List<Orden>? Ordenes { get; set; }
        public int? IdOrden { get; set; }         // Orden seleccionada.
        public string? DescripcionComprobante { get; set; }
        public IFormFile? ArchivoComprobante { get; set; }

        public string? RutaComprobante { get; set; }
    }
}
