using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IUsuarioModel
    {
        Respuesta Registro(Usuario ent);
        Respuesta InicioSesion(Usuario ent);
        Respuesta Listar();
        Respuesta ConsultarUsuarioPorId(int id);
        Respuesta EditarUsuario(Usuario ent); 
      
    }
}
