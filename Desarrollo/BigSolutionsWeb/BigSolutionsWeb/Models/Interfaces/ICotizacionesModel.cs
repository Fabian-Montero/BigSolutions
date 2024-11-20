using BigSolutionsWeb.DTOs;
using BigSolutionsWeb.Entidades;

namespace BigSolutionsWeb.Models.Interfaces
{
    public interface ICotizacionesModel
    {
        Respuesta CrearSolicitudCotizacionVista(int IdUsuario);
        Respuesta CrearSolicitudCotizacion(CrearSolicitudCotizacionDTO SolicitudCotizacion);
        Respuesta ConsultarSolicitudesCotizacionesCliente(int IdUsuario);
        Respuesta ConsultarDetalleSolicitudCotizacionCliente(long IdSolicitudCotizacion);
        Respuesta ConsultarSolicitudesCotizacionesAdmin();
        Respuesta ConsultarDetalleSolicitudCotizacionAdmin(long IdSolicitudCotizacion);
        Respuesta CrearCotizacionVista(long IdSolicitudCotizacion);
        Respuesta CrearCotizacion(CrearCotizacionVistaDTO cotizacion);
        Respuesta ActualizarRutaCotizacion(long idCotizacion, string downloadURL);
    }
}
