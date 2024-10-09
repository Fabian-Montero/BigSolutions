using System.ComponentModel.DataAnnotations;

namespace BigSolutionsWeb.Entidades
{
    public class Cliente
    {
        public long UsuarioId { get; set; }
        [Display(Name = "Identificación")]
        public string Identificacion { get; set; }
        [Display(Name = "Nombre Completo")]
        public string NombreCompleto { get; set; }
        [Display(Name = "Correo Electrónico")]
        public string CorreoElectronico { get; set; }
        [Display(Name = "Rol")]
        public int Rol { get; set; }
        [Display(Name = "Estado")]
        public bool Estado { get; set; }
    }

    public class DetallesCliente
    {
        [Display(Name = "Identificación")]
        public string Identificacion { get; set; }
        [Display(Name = "Nombre Completo")]
        public string NombreCompleto { get; set; }
        [Display(Name = "Correo Electrónico")]
        public string CorreoElectronico { get; set; }
        [Display(Name = "Número Telefónico")]
        public string NumeroTelefono { get; set; }
        [Display(Name = "Dirección Exacta")]
        public string DireccionExacta { get; set; }
        [Display(Name = "Estado")]
        public string Estado { get; set; }
        [Display(Name = "Nombre de la Empresa")]
        public string NombreEmpresa { get; set; }
        [Display(Name = "Es Temporal")]
        public string EsTemporal { get; set; }
        [Display(Name = "Vigencia Temporal")]
        public DateTime VigenciaTemporal { get; set; }
    }
}
