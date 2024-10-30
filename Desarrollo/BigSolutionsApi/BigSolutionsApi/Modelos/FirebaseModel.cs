using Firebase.Auth;
using Firebase.Storage;
using Microsoft.Extensions.Configuration;

namespace BigSolutionsApi.Modelos
{
    public class FirebaseModel(IConfiguration iConfiguration) : IFirebaseModel
    {
        public async Task<string> GuardarImagenBase64EnFirebase(string carpeta, int id, string base64Image)
        {
            string email = iConfiguration.GetSection("FirebaseConfig:Email").Value!;
            string clave = iConfiguration.GetSection("FirebaseConfig:Contrasenna").Value!;
            string ruta = iConfiguration.GetSection("FirebaseConfig:Ruta").Value!;
            string api_key = iConfiguration.GetSection("FirebaseConfig:ApiKey").Value!;

            var auth = new FirebaseAuthProvider(new FirebaseConfig(api_key));
            var a = await auth.SignInWithEmailAndPasswordAsync(email, clave);

            // Convertir Base64 a Stream
            byte[] imageBytes = Convert.FromBase64String(base64Image);
            using (MemoryStream imagenStream = new MemoryStream(imageBytes))
            {
                var cancellation = new CancellationTokenSource();
                var task = new FirebaseStorage(
                    ruta,
                    new FirebaseStorageOptions
                    {
                        AuthTokenAsyncFactory = () => Task.FromResult(a.FirebaseToken),
                        ThrowOnCancel = true
                    })
                .Child(carpeta)
                .Child($"{id}.jpg")
                .PutAsync(imagenStream, cancellation.Token);

                var downloadURL = await task;
                return downloadURL;
            }
        }
    }
}
