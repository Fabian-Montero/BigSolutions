using BigSolutionsWeb.Entidades;
using BigSolutionsWeb.Enums;

namespace BigSolutionsWeb.DTOs;

public class CrearFacturaPendienteDTO
{
    public List<Orden>? Ordenes{ get; set; }
    public int? IdOrden {  get; set; } //Orden seleccionada
    
    public long IdFacturaPendiente { get; set; }
    public decimal? Subtotal { get; set; }
    public decimal? ImpuestoIVA { get; set; }
    public decimal? Total { get; set; }
    public Moneda? Moneda { get; set; }
    
    // Propiedades adicionales de la orden
    public string? Descripcion { get; set; }
    public string? Estado { get; set; }
    public DateTime? FechaCreacionOrden { get; set; }
    public string? NumFacturaVenta { get; set; }
    public string? RutaOrdenCompra { get; set; }
    public string? RutaFacturaVenta { get; set; }
    public string? NombreUsuario { get; set; }

}