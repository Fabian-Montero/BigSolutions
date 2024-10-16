namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IFirebaseModel
    {
        public Task<string> GuardarImagen(string carpeta, int id, IFormFile archivoImagen);
        public Task<bool> EliminarImagen(string carpeta, int id);
    }
}
