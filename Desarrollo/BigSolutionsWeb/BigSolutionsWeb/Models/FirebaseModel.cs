using BigSolutionsWeb.Models.Interfaces;
using Firebase.Auth;
using Firebase.Storage;

namespace BigSolutionsWeb.Models
{
    public class FirebaseModel(IConfiguration iConfiguration) : IFirebaseModel
    {
        string email = iConfiguration.GetSection("FirebaseConfig:Email").Value!;
        string clave = iConfiguration.GetSection("FirebaseConfig:Contrasenna").Value!;
        string ruta = iConfiguration.GetSection("FirebaseConfig:Ruta").Value!;
        string api_key = iConfiguration.GetSection("FirebaseConfig:ApiKey").Value!;

        public async Task<string> GuardarImagen(string carpeta, int id, IFormFile archivoImagen)
        {

            using (Stream imagen = archivoImagen.OpenReadStream())
            {
                var auth = new FirebaseAuthProvider(new FirebaseConfig(api_key));
                var a = await auth.SignInWithEmailAndPasswordAsync(email, clave);

                var cancellation = new CancellationTokenSource();

                var task = new FirebaseStorage(
                    ruta,
                    new FirebaseStorageOptions
                    {
                        AuthTokenAsyncFactory = () => Task.FromResult(a.FirebaseToken),
                        ThrowOnCancel = true
                    })
                .Child(carpeta)
                .Child(id.ToString())
                .PutAsync(imagen, cancellation.Token);

                var downloadURL = await task;

                return downloadURL;
            }
        }

        public async Task<bool> EliminarImagen(string carpeta, int id)
        {
            try
            {
                var auth = new FirebaseAuthProvider(new FirebaseConfig(api_key));
                var a = await auth.SignInWithEmailAndPasswordAsync(email, clave);
                await new FirebaseStorage(
                    ruta,
                    new FirebaseStorageOptions
                    {
                        AuthTokenAsyncFactory = () => Task.FromResult(a.FirebaseToken),
                        ThrowOnCancel = true
                    })
                .Child(carpeta)
                .Child(id.ToString())
                .DeleteAsync();
                return true;
            }
            catch (FirebaseStorageException ex)
            {
                Console.WriteLine($"Error eliminando imagen: {ex.Message}");
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error general: {ex.Message}");
                return false;
            }
        }
    }
}
