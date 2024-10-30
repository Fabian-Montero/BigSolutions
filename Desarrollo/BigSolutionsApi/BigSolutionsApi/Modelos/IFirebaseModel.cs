namespace BigSolutionsApi.Modelos
{
    public interface IFirebaseModel
    {
        Task<string> GuardarImagenBase64EnFirebase(string carpeta, int id, string base64Image);
    }
}
