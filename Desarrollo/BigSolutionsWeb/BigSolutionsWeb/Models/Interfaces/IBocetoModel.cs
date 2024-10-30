using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IBocetoModel
    {
        Respuesta ConsultarProductosCliente(string Busqueda, int NumPagina, int TamannoPagina);

        Task<Respuesta> GenerarBoceto(GenerateSketchDTO ent);

        Respuesta ConsultarBocetosCliente(int UsuarioId);
        Respuesta ConsultarBocetosAdmin();
    }
}
