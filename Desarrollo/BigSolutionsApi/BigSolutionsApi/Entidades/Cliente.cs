namespace BigSolutionsApi.Entidades
{
    public class Cliente
    {
        //public int ID_Cliente { get; set; }

        public long UsuarioId { get; set; }
        public string Identificacion { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public string NumeroTelefono { get; set; }
        public string DireccionExacta { get; set; }
        public bool Estado { get; set; } // TINYINT en SQL es mapeado a abyte en C#
        public string NombreEmpresa { get; set; }
        public int EsTemporal { get; set; } 
        public DateTime? VigenciaTemporal { get; set; }
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
