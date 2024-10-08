using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IUsuarioModel
    {
        Respuesta Registro(Usuario ent);

        Respuesta InicioSesion(Usuario ent);

        Respuesta? ConsultarUsuarioPerfil(long idusuario);

        Respuesta ActualizarPerfilUsuario(Usuario ent);
        Respuesta EliminarPerfilUsuario(long UsuarioId);
    }
}
