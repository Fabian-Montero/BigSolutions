using System.ComponentModel.DataAnnotations;

namespace BigSolutionsWeb.Enums
{
    public enum EstadoOrden
    {
        [Display(Name = "Pendiente de Confirmar")]
        PendienteDeConfirmar = 1,
        [Display(Name = "Aceptada")]
        Aceptada = 2,
        [Display(Name = "En Proceso")]
        EnProceso = 3,
        [Display(Name = "Completada")]
        Completada = 4,
        [Display(Name = "Cancelada")]
        Cancelada = 5
    }
}
