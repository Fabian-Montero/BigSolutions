namespace BigSolutionsWeb.Entidades
{
    public class Boceto
    {
        public int IdBoceto { get; set; }
        public int IdProducto { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string? RutaImagen { get; set; }
        public string? PromptUsado { get; set; }
        public string? PromptOriginal { get; set; }

        public string? NombreProducto { get; set; }
        public string? NombreUsuario { get; set; }

        public string? DescripcionUsuario { get; set; }
        public int Cantidad { get; set; }
    }
}
