namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IFirebaseModel
    {
        public Task<string> GuardarImagen(string carpeta, int id, IFormFile archivoImagen);
        public Task<bool> EliminarImagen(string carpeta, int id);

        public Task<string> GuardarImagenString(string carpeta, string id, IFormFile archivoImagen);

        public Task<bool> EliminarImagenString(string carpeta, string id);

    }
}
