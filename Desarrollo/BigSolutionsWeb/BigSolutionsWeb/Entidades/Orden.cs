using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.Entidades
{
    public class Orden
    {
        public long IdOrden { get; set; }
        public long IdUsuario { get; set; }
        public string? RutaOrdenCompra { get; set; } 
        public string? RutaFacturaVenta { get; set; } 

        public string? NumFacturaVenta { get; set; }
        public string? RutaBoletaEntrega { get; set; } 
        public string Descripcion { get; set; }
        public EstadoOrden Estado { get; set; }
        public MetodoPago MetodoPago { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string? Material { get; set; } 
        public DateTime? FechaEntrega { get; set; } 
        public EstadoInternoOrden? EstadoInterno { get; set; }
        public string? DescripcionInterna { get; set; }
        public string? NombreUsuario { get; set; }
    }


}
