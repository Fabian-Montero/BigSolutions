namespace BigSolutionsWeb.Entidades
{
    public class FacturaPendiente
    {
        public long IdFacturaPendiente { get; set; }
        public long IdOrden { get; set; }
        public decimal SubTotal { get; set; }
        public decimal ImpuestoIVA { get; set; }
        public decimal Total { get; set; }
        public DateTime FechaCreacion { get; set; }
    }
}
