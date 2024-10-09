using BigSolutionsApi.Entidades;
using System.Security.Claims;

namespace BigSolutionsApi.Modelos
{
    public interface IComunesModel
    {
        public bool EsAdmin(ClaimsPrincipal Usuario);

        public string Encrypt(string texto);
        public string Decrypt(string texto);

        public string GenerarToken(long UsuarioId, long IdRol);

        string GenerarCodigo();

        void EnviarCorreo(string destino, string asunto, string contenido);
    }
}
