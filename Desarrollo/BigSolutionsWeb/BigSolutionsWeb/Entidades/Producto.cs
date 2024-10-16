﻿namespace BigSolutionsWeb.Entidades
{
    public class Producto
    {
        public int IdProducto { get; set; }
        public int CategoriaId { get; set; }
        public int IdCategoria { get; set; }
        public string? Nombre { get; set; }
        public string? Descripcion { get; set; }
        public int Cantidad { get; set; }
        public float Precio { get; set; }
        public string? RutaImagen { get; set; }
        public string? NombreCategoria { get; set; }
    }
}