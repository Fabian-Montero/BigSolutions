using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.DTOs
{
    public class CrearFacturaDTO
    {
        public List<Orden>? Ordenes{ get; set; }
        public int? IdOrden {  get; set; } //Orden seleccionada
        public  string? NumFacturaVenta { get; set; }
        public string? RutaFacturaVenta { get; set; }

        public IFormFile? FacturaVentaArchivo { get; set; }

    }
}
