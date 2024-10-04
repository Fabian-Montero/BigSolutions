namespace BigSolutionsWeb.Models.Interfaces
{
    public interface IComunesModel
    {
        string Encrypt(string texto);

        bool ValidarContrasenna(string texto);
    }
}
