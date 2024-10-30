namespace BigSolutionsApi.Entidades
{
    public class Boceto
    {
        public int IdBoceto { get; set; }
        public int IdProducto { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string? RutaImagen { get; set; }
        public string? PromptUsado { get; set; }
    }
}
