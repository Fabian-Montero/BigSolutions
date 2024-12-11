using System.ComponentModel.DataAnnotations;

namespace BigSolutionsWeb.Enums
{
    public enum MetodoPago
    {
        [Display(Name = "Pago Anticipado")]
        PagoAnticipado = 1,
        [Display(Name = "Crédito")]
        Credito = 2,
        [Display(Name = "Parcial 50/50")]
        Parcial5050 = 3
    }
}
