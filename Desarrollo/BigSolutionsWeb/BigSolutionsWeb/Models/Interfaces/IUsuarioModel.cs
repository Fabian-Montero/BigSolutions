using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IUsuarioModel
    {
        Respuesta Registro(Usuario ent);

        Respuesta InicioSesion(Usuario ent);


        Respuesta Recuperar(Usuario ent);
        Respuesta RecuperaContrasennaCodigo(Usuario ent);

        Respuesta? ConsultarUsuarioPerfil(long idusuario);

        Respuesta ActualizarPerfilUsuario(Usuario ent);
        Respuesta EliminarPerfilUsuario(long UsuarioId);

        List<Cliente> ListarClientes();

        string EliminarClientes(string identificacion);

        List<Cliente> BuscarClientes(string parametroBusqueda);

        DetallesCliente DetallesClientes(string identificacion);
        Respuesta Listar();
        Respuesta ConsultarUsuarioPorId(int id);
        Respuesta EditarUsuario(Usuario ent);
        Respuesta EliminarUsuario(long Id);
        Respuesta CambiarContrasenna(Usuario ent);

    }
}
