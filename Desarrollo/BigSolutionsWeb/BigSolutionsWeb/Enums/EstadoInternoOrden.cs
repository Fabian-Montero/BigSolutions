using System.ComponentModel.DataAnnotations;

namespace BigSolutionsWeb.Enums
{
    public enum EstadoInternoOrden
    {
        [Display(Name = "No Empezada")]
        NoEmpezada = 1,

        [Display(Name = "Comprando Material")]
        ComprandoMaterial = 2,

        [Display(Name = "Pendiente de Bocetos")]
        PendienteBocetos = 3,

        [Display(Name = "Realizando Bocetos")]
        RealizandoBocetos = 4,

        [Display(Name = "Realizando Entrega")]
        RealizandoEntrega = 5,

        [Display(Name = "Terminada")]
        Terminada = 6
    }
}
