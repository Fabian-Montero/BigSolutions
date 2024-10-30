using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.DTOs
{
    public class ProductosPaginadosDTO
    {
        public List<Producto> Productos { get; set; } = new List<Producto>();
        public int TotalProductos { get; set; }
    }
}
