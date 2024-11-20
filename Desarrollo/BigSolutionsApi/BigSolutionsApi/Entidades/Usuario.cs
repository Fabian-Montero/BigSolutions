namespace BigSolutionsApi.Entidades
{
    public class Usuario
    {
        public long UsuarioId { get; set; }
        public long IdRol { get; set; }
        public string? Identificacion { get; set; }  
        public string? NombreCompleto { get; set; }
        public string? NombreEmpresa { get; set; }
        public string? CorreoElectronico { get; set; }
        public string? NumeroTelefono { get; set; }
        public string? DireccionExacta { get; set; }
        public string? Contrasenna { get; set; }
        public bool Estado { get; set; }
        public string? Token { get; set; }
        public string? NombreRol { get; set; }
        public bool EsTemporal { get; set; }
        public DateTime VigenciaTemporal { get; set; }

        public string? Codigo { get; set; }

        public string? ConfirmacionContrasenna { get; set; }

        public string? NuevaContrasenna { get; set; }
        public int BocetosGenerados { get; set; }
    }
}
          