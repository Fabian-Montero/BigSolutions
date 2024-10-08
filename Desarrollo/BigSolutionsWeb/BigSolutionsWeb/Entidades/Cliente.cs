namespace BigSolutionsWeb.Entidades
{
    public class Cliente
    {
        public string Identificacion { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public int Rol { get; set; }
        public bool Estado { get; set; }
    }

    public class DetallesCliente
    {
        public string Identificacion { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public string NumeroTelefono { get; set; }
        public string DireccionExacta { get; set; }
        public string Estado { get; set; }
        public string NombreEmpresa { get; set; }
        public string EsTemporal { get; set; }
        public DateTime VigenciaTemporal { get; set; }
    }
}
