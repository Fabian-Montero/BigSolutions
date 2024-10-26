using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IProductoModel
    {
        Respuesta ConsultarProductos();
        Respuesta AgregarProducto(Producto ent);
        Respuesta ActualizarRutaImagen(Producto ent);
        Respuesta ConsultarProducto(int IdProducto);
        Respuesta ActualizarProducto(Producto ent);
        Respuesta EliminarProducto(int IdProducto);
    }
}
