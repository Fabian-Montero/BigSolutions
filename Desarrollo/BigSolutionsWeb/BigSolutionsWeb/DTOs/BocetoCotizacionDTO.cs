namespace BigSolutionsWeb.DTOs
{
    public class BocetoCotizacionDTO
    {
        //Solicitud Cotizacion detalle
        public long IdBoceto { get; set; }
        public int Cantidad { get; set; }
        public string DescripcionUsuario { get; set; }


        //Boceto
        public DateTime FechaCreacion { get; set; }
        public string RutaImagen { get; set; }

        //Producto

        public long IdProducto { get; set; }
        public string NombreProducto { get; set; }
        public string NombreCategoria { get; set; }
        public decimal PrecioUnitarioColones { get; set; }
        public decimal PrecioUnitarioDolares { get; set; }

        public decimal PorcentajeVenta { get; set; }
        public string RutaImagenProducto { get; set; }
        public int CantidadInventario { get; set; }
    }
}
