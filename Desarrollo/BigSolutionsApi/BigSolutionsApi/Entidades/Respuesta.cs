namespace BigSolutionsApi.Entidades
{
    public class Respuesta
    {
        public int Codigo { get; set; }
        public string? Mensaje { get; set; }
        public object? Contenido { get; set; }

    }
    public class RespuestaListarClientes
    {
        public string identificacion { get; set; }
        public string NombreCompleto { get; set; }
        public string? CorreoElectronico { get; set; }
        public object? Rol { get; set; }
        public object? Estado { get; set; }
        public long UsuarioId { get; set; }
    }

}
