using BigSolutionsWeb.Models.Interfaces;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace BigSolutionsWeb.Models
{
    public class ComunesModel(IConfiguration iConfiguration) : IComunesModel
    {
        string SecretKey = iConfiguration.GetSection("Llaves:SecretKey").Value!;
        public string Encrypt(string texto)
        {
            byte[] iv = new byte[16];
            byte[] array;

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(SecretKey);
                aes.IV = iv;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter streamWriter = new StreamWriter(cryptoStream))
                        {
                            streamWriter.Write(texto);
                        }

                        array = memoryStream.ToArray();
                    }
                }
            }

            return Convert.ToBase64String(array);
        }

        public bool ValidarContrasenna(string texto)
        {
            string reg = @"^(?=.*[A-Z]).{8,}$";
            return Regex.IsMatch(texto, reg);
        }
    }
}
