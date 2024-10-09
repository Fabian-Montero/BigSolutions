using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IUsuarioModel
    {
        Respuesta Registro(Usuario ent);

        Respuesta InicioSesion(Usuario ent);

        Respuesta Recuperar(Usuario ent);
        Respuesta RecuperaContrasennaCodigo(Usuario ent);
    }
}
