using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IContabilidadModel
    {
        Respuesta ConsultarFacturas();
        Respuesta CargarAgregarFactura();

        Respuesta AgregarFactura(CrearFacturaDTO Factura);

        Respuesta EliminarFactura(long IdOrden);

        //Comprobantes

        Respuesta ConsultarComprobantes();

        Respuesta CargarAgregarComprobantes();
        Respuesta AgregarComprobante(CrearComprobanteDTO Comprobante);
        Respuesta EliminarComprobante(long IdOrdenDetalleComprobantes);
    }
}
