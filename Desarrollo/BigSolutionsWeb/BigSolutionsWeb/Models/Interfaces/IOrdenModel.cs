using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IOrdenModel
    {
        Respuesta CargarCrearOrdenCliente(long IdUsuario);
        Task<Respuesta> CrearOrdenCliente(CrearOrdenClienteDTO CrearOrdenClienteDTO);
        Respuesta ActualizarRutaComprobante(ComprobantePago ComprobantePago);
        Respuesta ActualizarRutaOrdenCompra(CrearOrdenClienteDTO Orden);

        Respuesta ConsultarOrdenesCliente(long IdUsuario);
        Task<Respuesta> ActualizarOrdenCliente(CrearOrdenClienteDTO editarOrdenClienteDTO);


        Respuesta ConsultarVistaOrden(long IdOrden);
        

        //Admin
        Respuesta ConsultarOrdenesAdmin();

        Respuesta ConsultarOrdenesClienteAdmin(string Identificacion);
        Respuesta CargarCrearOrdenAdmin();
        Task<Respuesta> CrearOrdenAdmin(CrearOrdenAdminDTO CrearOrdenAdminDTO);
        Task<Respuesta> ActualizarRutasArchivos(ActualizarRutasDTO ActualizarRutasDTO);

        Respuesta CargarEditarOrdenAdmin(int IdOrden);
        Task<Respuesta> ActualizarOrdenAdmin(CrearOrdenAdminDTO editarOrdenAdminDTO);
        Respuesta CargarEditarOrdenCliente(int IdOrden);

    }
}
