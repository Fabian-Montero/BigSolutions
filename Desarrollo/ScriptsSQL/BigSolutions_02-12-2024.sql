USE [master]
GO
/****** Object:  Database [BigSolutions]    Script Date: 2/12/2024 23:43:42 ******/
CREATE DATABASE [BigSolutions]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BigSolutions', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BigSolutions.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BigSolutions_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BigSolutions_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BigSolutions] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BigSolutions].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BigSolutions] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BigSolutions] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BigSolutions] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BigSolutions] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BigSolutions] SET ARITHABORT OFF 
GO
ALTER DATABASE [BigSolutions] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BigSolutions] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BigSolutions] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BigSolutions] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BigSolutions] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BigSolutions] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BigSolutions] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BigSolutions] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BigSolutions] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BigSolutions] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BigSolutions] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BigSolutions] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BigSolutions] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BigSolutions] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BigSolutions] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BigSolutions] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BigSolutions] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BigSolutions] SET RECOVERY FULL 
GO
ALTER DATABASE [BigSolutions] SET  MULTI_USER 
GO
ALTER DATABASE [BigSolutions] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BigSolutions] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BigSolutions] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BigSolutions] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BigSolutions] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BigSolutions] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BigSolutions', N'ON'
GO
ALTER DATABASE [BigSolutions] SET QUERY_STORE = ON
GO
ALTER DATABASE [BigSolutions] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BigSolutions]
GO
/****** Object:  Table [dbo].[Boceto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Boceto](
	[IdBoceto] [bigint] IDENTITY(1,1) NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[RutaImagen] [varchar](max) NOT NULL,
	[PromptUsado] [varchar](max) NULL,
	[PromptOriginal] [varchar](max) NULL,
 CONSTRAINT [PK_Boceto] PRIMARY KEY CLUSTERED 
(
	[IdBoceto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[CategoriaId] [bigint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Correos_Electronicos]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correos_Electronicos](
	[IdCorreoElectronico] [bigint] NOT NULL,
	[Asunto] [varchar](50) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[CorreoRemitente] [nvarchar](50) NOT NULL,
	[RutaPlantilla] [varchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Correos_Electronicos] PRIMARY KEY CLUSTERED 
(
	[IdCorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Correos_Electronicos_Detalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correos_Electronicos_Detalle](
	[IdCorreoElectronicoDetalle] [bigint] NOT NULL,
	[IdCorreoElectronico] [bigint] NOT NULL,
	[IdGrupoUsuarios] [bigint] NULL,
 CONSTRAINT [PK_Correos_Electronicos_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdCorreoElectronicoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizacion](
	[IdCotizacion] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdSolicitudCotizacion] [bigint] NULL,
	[RutaCotizacion] [varchar](max) NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
	[Impuesto] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cotizacion_Detalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizacion_Detalle](
	[IdCotizacionDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCotizacion] [bigint] NULL,
	[IdBoceto] [bigint] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnitarioColones] [decimal](18, 2) NULL,
	[PrecioUnitarioDolares] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Cotizacion_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdCotizacionDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo_Usuarios]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo_Usuarios](
	[IdGrupoUsuarios] [bigint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Grupo_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdGrupoUsuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo_Usuarios_Detalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo_Usuarios_Detalle](
	[IdGrupoUsuariosDetalle] [bigint] NOT NULL,
	[IdGrupoUsuarios] [bigint] NULL,
	[UsuarioId] [bigint] NULL,
 CONSTRAINT [PK_Grupo_Usuarios_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdGrupoUsuariosDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[IdOrden] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[RutaOrdenCompra] [varchar](max) NOT NULL,
	[RutaFacturaVenta] [varchar](max) NOT NULL,
	[RutaBoletaEntrega] [varchar](max) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[MetodoPago] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Material] [varchar](50) NOT NULL,
	[FechaEntrega] [datetime] NOT NULL,
	[EstadoInterno] [varchar](50) NOT NULL,
	[DescipcionInterna] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[IdOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Cotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Cotizacion](
	[IdOrdenCotizacion] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[IdSolicitudCotizacion] [bigint] NOT NULL,
	[RutaCotizacion] [varchar](max) NOT NULL,
	[SubTotal] [decimal](18, 0) NOT NULL,
	[Impuesto] [decimal](18, 0) NOT NULL,
	[Total] [decimal](18, 0) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Estado] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Orden_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdOrdenCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Bocetos]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Bocetos](
	[IrOrdenDetalle] [bigint] NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[IdBoceto] [bigint] NOT NULL,
 CONSTRAINT [PK_Orden_Detalle_Bocetos] PRIMARY KEY CLUSTERED 
(
	[IrOrdenDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Comprobantes]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Comprobantes](
	[IdOrdenDetalleComprobantes] [bigint] NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[RutaComprobante] [varchar](max) NOT NULL,
	[DescripcionComprobante] [varchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Orden_Detalle_Comprobantes] PRIMARY KEY CLUSTERED 
(
	[IdOrdenDetalleComprobantes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Cotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Cotizacion](
	[IdOrdenDetalleCotizacion] [bigint] NOT NULL,
	[IdOrdenCotizacion] [bigint] NOT NULL,
	[IdBoceto] [bigint] NOT NULL,
 CONSTRAINT [PK_Orden_Detalle_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdOrdenDetalleCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Factura_Pendiente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Factura_Pendiente](
	[IdFacturaPendiente] [bigint] NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[SubTotal] [decimal](18, 0) NOT NULL,
	[ImpuestoIVA] [decimal](18, 0) NOT NULL,
	[Total] [decimal](18, 0) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Orden_Detalle_Factura_Pendiente] PRIMARY KEY CLUSTERED 
(
	[IdFacturaPendiente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[IdProducto] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoriaId] [bigint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[RutaImagen] [nvarchar](max) NOT NULL,
	[Prompt] [varchar](max) NULL,
	[PrecioUnitarioColones] [decimal](18, 2) NULL,
	[PrecioUnitarioDolares] [decimal](18, 2) NULL,
	[PorcentajeVenta] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[IdRol] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitud_Cotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_Cotizacion](
	[IdSolicitudCotizacion] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL,
	[Moneda] [int] NULL,
 CONSTRAINT [PK_Solicitud_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitud_Cotizacion_Detalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_Cotizacion_Detalle](
	[IdSolicitudCotizacionDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdSolicitudCotizacion] [bigint] NOT NULL,
	[IdBoceto] [bigint] NOT NULL,
	[Cantidad] [int] NULL,
	[DescripcionUsuario] [varchar](max) NULL,
 CONSTRAINT [PK_Solicitud_Cotizacion_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacionDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[UsuarioId] [bigint] IDENTITY(1,1) NOT NULL,
	[IdRol] [bigint] NOT NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[NombreCompleto] [varchar](50) NOT NULL,
	[CorreoElectronico] [varchar](50) NOT NULL,
	[NumeroTelefono] [varchar](50) NOT NULL,
	[DireccionExacta] [varchar](50) NOT NULL,
	[Contrasenna] [varchar](max) NOT NULL,
	[Estado] [tinyint] NOT NULL,
	[NombreEmpresa] [varchar](50) NULL,
	[EsTemporal] [bit] NULL,
	[VigenciaTemporal] [datetime] NULL,
	[BocetosGenerados] [int] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Boceto] ON 
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10012, 42, 6, CAST(N'2024-10-30T22:30:03.377' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10012.jpg?alt=media&token=1b8e43c8-099f-4bd1-bea1-e2dcee2a2ea0', N'Imagine a cylindrical bottle of a sleek, elongated design, giving it a sophisticated yet understated appearance. The bottle is made of potentially aluminum, finished with a completely matte black color. It has a smooth, non-reflective surface, lacking any labels or logos, thus exuding a minimalist style. The cap is also black, designed as a screw-top with a slightly ribbed edge to improve grip. Against a plain, white background, this black bottle stands as the centerpiece, accentuated by soft and even lighting that almost erases all shadows. The subtle, barely noticeable shadow underneath gives the bottle a floating effect, suggesting a professional studio setting. On the center of the bottle, picture a minimalistic logo of a white-colored tree, taking up around 30% of the product''s front surface. The logo appears to be directly printed or embedded, seamlessly integrating with the matte texture of the bottle without any raised or 3D effects. Achieve a realistic, high-quality image that highlights the product and its logo, preserving the specific design details.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a tree in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10013, 42, 6, CAST(N'2024-10-30T22:52:38.483' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10013.jpg?alt=media&token=bd43bcf3-ee19-43a0-a878-dc42aabfbb43', N'Generate an image of a cylindrical metallic bottle with a matte black finish. The surface of the bottle should be smooth and non-reflective, and it should not feature any labels or logos, emphasizing a minimalist design. The cap of the bottle should be a black screw-top with a ribbed edge. The bottle should have a tall, slender shape. The background is a plain, smooth white backdrop, with soft, even lighting that eliminates almost all shadows. A subtle, diffuse shadow should appear beneath the bottle. The centerpiece of the image is a minimalistic white logo of a mountain, centered on the bottle and covering approximately 30% of its front surface. The logo should blend naturally with the bottle''s texture, appearing as if it were printed or embedded directly onto its surface. Avoid any raised or three-dimensional effects for the logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a mountain in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10014, 42, 6, CAST(N'2024-10-30T22:55:57.367' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10014.jpg?alt=media&token=9f40a8b0-03ad-4947-b499-f4b294dcf608', N'Create a realistic and high-quality image of a cylindrical bottle crafted from possibly aluminum material with a matte black finish. This bottle sports a minimalist and simple design with no labels, and the smooth, non-reflective texture gives it an understated elegance. It also features a screw-top cap, which is also black and has a slightly ribbed edge to ensure better grip. The body of the bottle portrays a sleek and elongated profile, attributed to its taller height and slender width dimensions. In the middle of the bottle, introduce a simple, centered white logo of a mountain consuming about 30% of the front surface. It should blend naturally with the product, appearing as though it is printed or embedded directly on it without giving off any 3D effects. The backdrop should be a clean white, free of distractions and shadows, making the black bottle stand out. Soft and uniform lighting should be employed to minimize shadows and highlight the matte finish of the bottle. Accentuate a faint and diffuse shadow at the bottom of the bottle to emulate a floating effect and give off a professional studio atmosphere.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a mountain in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10015, 42, 6, CAST(N'2024-10-30T22:59:33.187' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10015.jpg?alt=media&token=90c42492-be6e-48db-a8f4-a8a85856eb9f', N'Generate an image of a cylindrical bottle with a matte black finish, possibly made of metal, like aluminum. The bottle surface is smooth and non-reflective. No labels or logos are present, aside from a minimalistic logo of a mountain in white which is located in the center and covers approximately 30% of the front surface. The bottle and its threaded screw-top cap also black with a ribbed edge, giving a minimalist and simple design. The bottle has a tall and slender shape with a high height-to-width ratio. The whole composition is set against an unblemished white background. The lighting is soft and even, almost completely eliminating shadows, but a faint, subtle shadow under the bottle gives it a floating effect. Although the logo is on the bottle''s surface, it should blend and appear as though it is a part of its unbroken matte black surface.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a mountain in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10016, 42, 6, CAST(N'2024-10-30T23:02:11.343' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10016.jpg?alt=media&token=d2b6ee6c-e87b-4f87-b2b9-0e7a6c14b1dc', N'A highly detailed rendering of a slender, tall, cylindrical bottle with a matte black finish, presumably made from aluminum. The surface appears smooth, non-reflective, and free from any labels or logos, exuding an air of subdued sophistication. Its screw-top cap, also black, features a slightly ribbed edge to ensure better handling. Against a smooth, undisturbed white backdrop, the depth of the black bottle pops out, illuminated by soft, evenly spread lighting that almost completely dissipates any shadow. Yet a faint shadow is seen at the base of the bottle, subtly insinuating an illusion of floating. In the middle of the bottle, there exists a minimalist white logo depicting a bulldog. It''s neatly centered, taking up approximately 30% of the product''s front surface - a balance that makes it stand out without detracting from the overall product design. The logo appears to merge seamlessly with the bottle''s surface, as if it was printed or deeply embedded onto it, without any hint of a 3D effect or raised texture. With the whitewashed, spotlessly clean background and the gentle, uniform lighting, the fine details of the product and logo stay in focus, and the intentional absence of extra shadows further accentuates the aesthetic value.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalist image of a bulldog in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10017, 42, 6, CAST(N'2024-10-30T23:51:20.027' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10017.jpg?alt=media&token=25c16034-feac-42b4-9da9-132b3da4e71a', N'A tall, cylindrical bottle made of possibly aluminum, finished in matte black, with a smooth and non-reflective surface, presenting a minimalist and understated look. The cap, also black, is screw-top with a slightly ribbed edge for better grip. There are no labels or marks except for a centered logo that depicts a white and black soccer ball, taking up around 30% of the product''s front surface, embedded seamlessly into the bottle''s texture. Set against a stark contrast of a smooth white background, lit softly and evenly, casting minimal, faint shadow below the bottle that gives it a slight floating effect, reflecting a polished studio setting.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''Un balon de futbol en color blanco y negro''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10018, 42, 6, CAST(N'2024-10-30T23:53:08.673' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10018.jpg?alt=media&token=e1f35a9a-e8fe-499e-a34e-955498546ca9', N'Visualize a cylindrical bottle, made of matte black finished metal, presumably aluminum. This minimalist, sleek container has an elegant understated appearance, a non-reflective smooth surface without any labels. The bottle''s cap is a screw-top, also in black, with a slightly ribbed edge for improved grip. Its tall, slender shape with a greater height-to-width ratio, gives it a sleek and elongated look. The setting is a plain white, smooth background with soft, even lighting and a slight, barely noticeable shadow at the bottom for a floating effect, resembling a professional studio setting. Incorporate a white logo in the center of the bottle, covering about 30% of its surface. The logo is an image of a soccer ball, centered and visually appealing, blending naturally with the bottle’s texture as if printed or embedded on it. The setting uses a white background with soft, uniform lighting to enhance the bottle’s features.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''An image of a soccerball in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10019, 42, 6, CAST(N'2024-10-31T00:34:30.410' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10019.jpg?alt=media&token=3a1228bd-717c-44e2-983d-15bf58e3c1ab', N'A tall, thin cylindrical bottle made of likely aluminum metal, exuding elegance with its completely matte black finish. The surface is smooth, non-reflective, and without any labels, logos, or adornments maintaining a minimalist design. Its cap is a screw-top, also black with a slightly ribbed edge for grip. The bottle''s Afro-futurist design accentuates its understated sophistication. Nestled on a plain white, distraction-free background, the black bottle takes center stage in this composition where the lighting is gentle and balanced, minimizing shadows and emphasizing the matte texture of the bottle. A soft fade shadow radiates from the bottle''s base, adding depth. In the middle of the bottle, incorporate a logo whose details align with the concept of a ''white soccer ball''. The logo should be centrally positioned, covering around 30% of the bottle''s frontal area- visible and appealing but not intrusive to the original design. It should look naturally integrated with the bottle''s texture as if embossed. Avoid creating 3D effects for a smooth blend. Illuminate the setting uniformly to bring out the best features of the product and the logo, and stash away shadows. Pay close attention to preserving all the design aspects as described.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''Balon de futbol color blanco''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10020, 42, 6, CAST(N'2024-10-31T00:36:11.727' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10020.jpg?alt=media&token=c938af6b-f9d0-40b8-8faa-970348d1c73d', N'Generate a realistic and high-quality image featuring a slender cylindrical bottle made of matte black metal, possibly aluminum. The bottle should have a non-reflective surface, giving it an understated and elegant appearance without any labels or logos, apart from one. The top of the bottle is covered by a screw-top cap, also black, with a ribbed edge for a better grip. The bottle should have a greater height-to-width ratio, giving it a sleek, elongated look. The background should be plain and white, smooth with a subtle shadow at the bottom of the bottle giving it a slight floating effect, and a soft uniform lighting highlighting the matte finish of the surface. The bottle design incorporates a centered logo of a white soccer ball, covering approximately 30% of its front surface, ensuring it does not alter the minimalistic design. This logo appears as if it''s printed directly on the bottle, with a seamless integration devoid of any raised or three-dimensional effects. The overall setting should resemble a professional studio photograph.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''An image of a soccerball in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10021, 42, 6, CAST(N'2024-10-31T00:42:27.810' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10021.jpg?alt=media&token=abbf0385-69a6-4922-b54f-fb12506aee7b', N'Create a realistic depiction of a tall, slender cylindrical bottle with a completely matte, non-reflective black finish that''s likely made of metal, possibly aluminum. The surface is smooth, minimalist, and without labels or logos. The cap is a screw-top, also in black, with a ribbed edge suggesting enhanced grip. The bottle is located in a clean, white background with soft and even lighting that casts a faint, subtle shadow at the bottom, giving a slight floating effect. In the center of the product integrate a white minimalist tree logo that''s perfectly centered, covering 30% of the product’s front surface, without raising or altering the original product''s shape.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''Arbol minimalista color blanco''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10022, 42, 6, CAST(N'2024-11-12T02:20:02.070' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10022.jpg?alt=media&token=66e2baf5-f2b3-4fc7-b37d-484ec1962401', N'A tall cylindrical bottle made of metal, possibly aluminum, with a completely matte and non-reflective black finish. The bottle is minimalist in design with no labels or logos, apart from a central logo of a white tree. This logo covers whereabouts 30% of the front surface of the bottle, integrated seamlessly without any raised effects. Its screw-top cap is also black, featuring slightly ribbed edges for better grip. The entire composition rests against a plain white, smooth background, with the bottle situated centrally. The lighting is even and soft, eliminating most shadows, but for a faint diffuse shadow at the bottle''s base, creating a subtle floating effect. This setup helps to emphasize the bottle''s matte finish and the logo, giving it a professional aesthetic.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a tree in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10023, 42, 6, CAST(N'2024-11-14T00:18:31.580' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10023.jpg?alt=media&token=68a36f27-7d84-4217-8ed9-defbda599fc2', N'Design a cylindrical bottle with a matte black finish, possibly made from aluminum. The overall texture of the bottle is smooth and non-reflective, devoid of any labels or logos, giving it an elegant, minimalist appeal. The cap, also black and adorned with a slightly ribbed edge, is a screw-top design. The tall, slender shape of the bottle provides a sleek, elongated aesthetic. The background is plain white, with the bottle placed at the center. No noticeable shadows or distractions exist in the background. The lighting is evenly diffused, highlighting the matte finish of the bottle and casting a faint shadow underneath the bottle. In the center of the product, display a minimalistic logo of a white cat. The logo should cover around 30% of the product''s front surface, appearing as though it''s either printed or embedded directly onto the bottle. Avoid any three-dimensional effects for the logo. The overall composition should be reminiscent of a professional studio setting.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a white cat''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10024, 42, 6, CAST(N'2024-11-14T00:21:43.940' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10024.jpg?alt=media&token=b47cfbe3-4079-4164-a254-afe2676acc65', N'Generate a realistic, high-quality image of a tall, slender, cylindrical bottle with a smooth, non-reflective matte black finish, likely made of metal, possibly aluminum. The bottle has no labels or logos, maintaining a minimalist and simple design. The screw-top cap is also black and has a slightly ribbed edge for better grip. The background should be plain white, completely smooth, with no noticeable shadows or distractions. The lighting should be soft and even, with a very faint, subtle shadow at the bottle''s base. Integrated into the center of the bottle''s design, include a white minimalistic logo of a cat, covering approximately 30% of the product''s front surface, in a way that feels embedded into the bottle''s texture. The overall lighting should provide a soft, uniform illumination, enhancing the product’s features without increasing shadows, to correctly highlight the product and logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10025, 42, 6, CAST(N'2024-11-14T00:23:45.837' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10025.jpg?alt=media&token=00251d94-81f1-412c-a7f6-daab48cd33e3', N'Visualize a tall, sleek matte black cylindrical bottle made possibly of aluminum. The bottle has an elegant, simple, minimalist design with no labels or logos. The cap is also black, a screw-top variant with a ribbed edge for an improved grip. The bottle is placed against a completely smooth white background with no shadows or distractions. The lighting is soft and even, highlighting the non-reflective aspect of the bottle. To give a slight floating effect over the white background, there''s a subtle diffuse shadow at the base of the bottle. In the center of the bottle, a white minimalistic logo of a guitar is visible. This logo comprises approximately 30% of the front face of the bottle. It appears as if the logo blends naturally with the surface texture, avoiding any raised 3D effects, giving the impression of being printed or embedded directly on the bottle. The overall setting radiates professionalism through its simplicity and attention to design details.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a guitar in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10026, 42, 6, CAST(N'2024-11-14T00:24:39.207' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10026.jpg?alt=media&token=60b05452-18ca-419b-8570-5304a75306a9', N'The image should capture a cylindrical bottle that is crafted from metal, likely aluminum, and given a glossy matte black finish that is smooth and non-reflective, rendering it an elegant appearance. It should bear no labels or logos demonstrating a minimalist design. The cap of the bottle is screw-top, black in color, and its edge is slightly ribbed to allow for a good grip. The bottle''s tall and slender shape with a high height-to-width ratio provides it a sleek, elongated look. Situate the bottle on a plain, smooth white background with no shadows that detract from the object. The lighting should be soft and well-balanced, minimizing shadows and highlighting the matte finish of the bottle''s surface. A faint, subtle shadow at the bottom will give a slight floating effect over the white background and will look very diffuse. In the middle of the bottle, add a minimalistic logo of a white guitar. The logo should be centered and cover approximately 30% of the front surface of the bottle, blending naturally with the bottle''s texture like it''s printed or embedded on it. The background should be kept white, clean, and the lighting should be uniform and soft, aimed at enhancing the product''s features without adding more shadows.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a guitar in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10027, 42, 6, CAST(N'2024-11-14T00:25:23.760' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10027.jpg?alt=media&token=1d977196-d77a-461e-9afb-bf30cc5ebd33', N'Create an image of a tall, slender, matte black cylindrical bottle made of metal, possibly aluminum. This smooth and non-reflective bottle should have a minimalist design without any labels or logos. The cap is a black screw-top with a ribbed edge to provide a better grip. The object is set against a pure white, shadowless background that makes the bottle stand out. A faint, almost unnoticeable shadow under the bottle gives it the illusion of slightly floating. In the middle of the black bottle, design a white logo shaped like a guitar, covering approximately 30% of the bottle''s front surface so it appears centered and prominent yet naturally integrated into the bottle''s texture. Maintain an overall soft and even lighting for a professional studio effect.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a guitar in color white ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10028, 42, 7, CAST(N'2024-11-18T05:23:41.883' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10028.jpg?alt=media&token=12815a13-17d2-46af-bc7a-bb2202850e52', N'Create an image of a tall, slender, cylindrical bottle with a matte black finish, possibly made of metal such as aluminum. The bottle achieves a sleek and elongated look due to its greater height-to-width ratio. Its design is minimalist and simple, with a smooth, non-reflective surface and no labels. The cap is a screw-top, black in color as well, and designed with a slightly ribbed edge for better grip. Positioned at the center of the bottle, include a minimalistic white logo of a mouse and keyboard. This logo should be clearly centered, covering around 30% of the product''s front surface and blending naturally with the product''s texture, as if printed or embedded directly on it. The bottle is dramatically contrasted against a completely smooth, white background. The lighting is soft and even, minimizing shadows and highlighting the matte finish of the bottle. A faint, subtle shadow is located at the bottom of the bottle to suggest a slight floating effect. The entire visual composition should give the impression of a professional studio setting and maintains a realistic, high-quality image of the described product.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a mosuse and keyboard in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10029, 42, 7, CAST(N'2024-11-18T05:24:46.107' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10029.jpg?alt=media&token=00bf0b10-27b0-44e9-a29d-01ce0b03c917', N'Visualize a cylindrical bottle with a completely matte black finish. The bottle, made of metal, possibly aluminum, has a smooth and non-reflective surface, giving it a minimalistic and unadorned appearance. The screw-top cap is also black, with a delicately ribbed edge for grip. The bottle has a tall, slender shape, emphasizing its greater height-to-width ratio and contributing to its sleek and sleek appeal. Depict it against a completely smooth, plain white background to focus attention on the bottle. The shadow beneath the bottle is faint, barely noticeable, creating a subtle floating effect over the pristine white backdrop - a signature of a professional studio setting. In the center of the bottle infuse a minimalist design of a computer keyboard in white color, ensuring it''s centered and covers roughly 30% of the bottle''s front surface. Make sure this logo is seamlessly integrated with the bottle''s texture, not raised or producing a three-dimensional effect. The lighting should be soft, uniform, and shadow-free, emphasizing the matte surface of the bottle and the intricacy of the logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''Una imagen minimalista de un teclado de computadora en color blanco''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10030, 42, 7, CAST(N'2024-11-18T05:25:54.160' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10030.jpg?alt=media&token=e7ae1b65-7603-4f24-bf5b-a33b9db72d40', N'Craft a visually appealing, high-resolution image of a cylindrical aluminum bottle covered in a matte black finish. The bottle surface should be smooth, non-reflective, and free from labels or logos. The cap of the bottle is screw-top and also black, possessing a slightly ribbed texture for a more sophisticated grip. The bottle should exude an elongated, sleek appearance owing to its elevated height-width ratio. Light casts a diffused, faint shadow at the base of the bottle, creating a soft floating effect on a plain, spotless white backdrop devoid of shadows or distractions. Affixed at the center of the bottle surface should be a minimalistic white logo depicting a computer keyboard, blending perfectly with the texture and occupying about 30% of the front surface harmoniously without disrupting the inherent design. The setting should highlight the product and logo while maintaining a consistent lighting effect that accentuates the bottle''s features without casting extra shadows.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a computer keyboard in color white
''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10031, 42, 7, CAST(N'2024-11-19T00:06:23.133' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F10031.jpg?alt=media&token=4a2d11ee-fd79-4c01-9aac-749f86993505', N'Generate an image of a tall, slender cylindrical bottle made of matte black metal, possibly aluminum, standing out against a plain white background. The bottle''s surface is smooth, and non-reflective, lacking any labels or logos, exhibiting a minimalist design. The cap is a screw-top and is also black, with a lightly ribbed edge for better grip. The lighting softly illuminates the scene, casting a faint and subtle shadow at the bottle''s base, contributing to a slight floating effect and a professional studio atmosphere. In the center of the bottle, place a minimalistic, white logo depicting a basketball, occupying nearly 30% of the front surface. The logo should be integrated seamlessly, as if printed right onto the metal surface, without any raised or three-dimensional effects. The background should remain clean and white, with uniform lighting that enhances the product without creating extra shadows.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a basketball ball in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20031, 42, 7, CAST(N'2024-11-26T00:15:39.360' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20031.jpg?alt=media&token=73563958-88e5-41ff-b5b9-5e2fc2c035b5', N'Create an image of a long and thin cylindrical bottle, with proportions leaning towards a greater height-to-width ratio. The material should appear to be matte black metal, likely aluminum, with a smooth and non-reflective surface making for a minimalist and elegant presentation of the bottle. The bottle should have a matching black cap, enhanced with a slightly ribbed edge for improved grip. This bottle has no labels or logos except for a minimal, white cat logo covering approximately 30% of its front surface, applied in a manner that suggests it is embedded directly into the bottle''s texture. The setting of the image should be a clean, white background, thoroughly smooth and with soft, even lighting. There is a faint shadow under the bottle, bringing a subtle sense of depth and a floating effect. Aim for a professional studio effect with diffuse lighting, minimal shadows and a clear focus on the bottle, ensuring that the product retains its sleek, elongated, and minimalist look.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimal image of a cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20032, 42, 7, CAST(N'2024-11-26T01:16:45.697' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20032.jpg?alt=media&token=dbf3c1a7-538e-4875-b693-15b1f1e2271d', N'A cylindrical bottle with a completely matte black finish, possibly constructed from aluminum. Its surface offers no reflection, accentuating the elegance and minimalistic design. The bottle carries no labels or markings, aside from a centered white logo of a minimalist cat which covers approximately 30% of the bottle''s front surface. A black screw-top cap with a slightly ribbed edge sits tightly on the top. The bottle has a tall, slender form that gives a sleek and elongated look. Posed against a plain white, smooth background, a faint shadow gives off a subtle floating effect, hinting at a professional studio setting. Soft even lighting illuminates the bottle''s non-reflective finish whilst minimizing any casting shadows', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20033, 42, 7, CAST(N'2024-12-01T18:50:18.953' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20033.jpg?alt=media&token=453c49a1-24ec-45ee-a39f-4ef3df375883', N'Generate a high-quality, realistic image of a cylindrical bottle with a completely matte black finish, possibly made of aluminum, having a smooth and non-reflective surface. The bottle, sporting an elegant, understated look, does not have any labels or logos and preserves a minimalist design. It is tall and slender, with a screw-top black cap featuring a lightly ribbed edge for a better grip. The bottle is set against a plain, smooth white background devoid of any additional shadows or distractions, making the bottle a stand-out feature. Soft, even lighting eliminates nearly all shadows while a barely noticeable faint shadow at the bottom lends a floating effect. Engraved at the center of the product is a      white minimalistic logo of a lion, covering approximately 30% of the front surface. The logo seamlessly blends with the bottle’s texture, looking as if it were printed directly onto the surface. The background is clean and white, and the lighting is uniform, accentuating the bottle and its design.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a lion in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20034, 42, 7, CAST(N'2024-12-01T18:51:23.577' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20034.jpg?alt=media&token=4d431e74-2cb5-4d1b-8cd6-b2f151c9770c', N'Create a realistic image of a tall, slender, cylindrical metal bottle with a matte black finish, likely made of aluminum. The bottle surface is smooth, non-reflective, and minimalist with no other labels or logos. It has a cap that is a screw-top, matches the body in color and finish, and has a slightly ribbed edge for better grip. The object resides in a professional studio setting on a plain white, smooth background with soft, even lighting that eradicates almost all shadows except a faint diffused one at the bottom. Imprinted on the center of the bottle is a logo featuring an image of a white lion, which covers approximately 30% of the product''s front surface and blends seamlessly with the product''s texture.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic image of a lion in color white
''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20035, 42, 7, CAST(N'2024-12-01T18:52:11.363' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20035.jpg?alt=media&token=4ece7222-b85d-48d6-8803-9db09a4d6b5c', N'An image of a tall and slender cylindrical bottle, possibly made of metal such as aluminium. The bottle exhibits a matte black finish with no distractions from labels or logos, giving it an elegant, minimalist design. The screw-top cap shares the same black color and has a ribbed edge for easier grip. The image is set against a pure white background, an unbroken space without shadows or distractions. Soft, evenly distributed lighting eliminates shadows, emphasizing the non-reflective, understated surface of the bottle. A faint, diffused shadow beneath the bottle subtly suggests a floating effect. Centered on the product is a white logo of a minimalistically designed zebra, which seamlessly integrates with the bottle''s texture without any raised effects. The logo covers approximately 30% of the front area of the product. The lighting and background must enhance the product and logo while maintaining focus on their detailed design.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a zebra in color white ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20036, 51, 7, CAST(N'2024-12-03T05:07:30.813' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20036.jpg?alt=media&token=addb56d9-7570-4696-b9e2-3b6e45730cde', N'Create a vertically oriented rectangular notebook with a natural, eco-friendly, and minimalist aesthetic. The notebook features a smooth, matte finished, light brown kraft paper cover without any logos, patterns or text. There is a vibrant green elastic band running vertically along the right edge, embedded into the notebook board. On the right side of the notebook, there is a pen with matching kraft-colored barrel and green plastic accents that consist of a clip, tip, and central ring. The pen is attached to the notebook by the same green loop. The notebook is slim and appears lightweight, with the binding hidden from view, edges sharp and precisely cut. This suggests a durable and functional construction. Right in the center of the product, embed a minimalistic image of a soccer ball colored in black. Avoid any raised or three-dimensional effects for a seamless integration. Showcase the notebook and pen against a plain white background, with soft, uniform and diffused lighting that creates an even brightness all around, while providing subtle shadows to offer depth. The focus should be on the natural kraft texture of the notebook and the green accents of the elastic band and pen.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a soccer ball in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20037, 51, 7, CAST(N'2024-12-03T05:09:32.183' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20037.jpg?alt=media&token=b7bfdeb7-01ef-4f02-822b-f71e51c03008', N'Generate a vertical image of an eco-friendly rectangular notebook with a minimalist design and a light brown kraft paper cover. The cover is smooth, matte, and free from visible logos or patterns. Along the right edge is a stark green elastic band, approximately 1 cm wide. Attached to the notebook''s side is a pen via a green pen loop. The pen''s barrel matches the kraft color of the notebook and features green plastic accents. The notebook is slim and lightweight with sharp edges. The setting is against a plain white background, highlighting the notebook and pen. The lighting is soft and uniform, casting subtle shadows beneath the pen and on the left side of the notebook. In the middle of the notebook cover, introduce a black-colored soccer ball logo, centered, and covering about 30% of the surface, maintaining a flat appearance as though it is directly printed on the notebook cover, without causing any three-dimensional effects.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a soccer ball in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20038, 51, 7, CAST(N'2024-12-03T05:10:20.303' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20038.jpg?alt=media&token=2a490088-101a-4e90-ae76-1270dae2b889', N'Create an image of a vertical, rectangular notebook with a textured, light brown kraft paper cover that conveys a minimalist, eco-friendly aesthetic. The cover is devoid of any logos or patterns, with the exception of a centered, black logo of a soccer ball, which covers about 30% of the front surface. Running along the right edge is a vibrant green elastic band, providing a contrasting accent to the design. On the right, a pen with a matching kraft-colored barrel and green accents is securely held by a green pen loop. The notebook is slim with hidden binding and sharp edges, suggesting lightweight and durability. The composition takes place against a plain white background with subtle shadows beneath the pen and on the notebook''s left side, under soft, diffused lighting.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a soccer ball in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20039, 51, 7, CAST(N'2024-12-03T05:11:31.447' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20039.jpg?alt=media&token=c6e84c4f-04d5-4abe-a9d8-51c271c475a6', N'Create a vertically oriented rectangular notebook with an eco-friendly feel and a minimalist aesthetic. The notebook cover is crafted from light brown kraft paper with a smooth, matte texture, devoid of any logos or patterns. A vibrant green elastic band precisely 1 cm wide secures the book, contrasting sharply with the notebook''s color. A pen sits on the right side, secured by a green loop. The pen''s barrel is of the same kraft color, highlighted by green accents on the clip, tip, and middle ring. The edges of the notebook are sharply cut with an elastic band stretched tightly across. The image is composed against a flat, texture-free white background. The light used in the setting is soft, even, and diffused, infusing an even brightness across. On the central part of the notebook, embed a white logo of a koala, covering approximately 30% of the front surface. It should appear as though it was printed on the notebook without any 3D effects. The entire composition should be high-quality, focused on the notebook''s eco-friendly and modern design accentuated by the koala logo.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a koala in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20040, 51, 7, CAST(N'2024-12-03T05:13:18.403' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20040.jpg?alt=media&token=fd9be930-7f32-4687-8359-dfdf3c78755d', N'Create an image of a vertical, rectangular notebook with an eco-friendly, minimalist design. The notebook''s cover is made from light brown kraft paper with a smooth, matte finish, devoid of any logos, patterns, or text. Along the right edge is a vibrant, sharp-contrast, green elastic band, about 1cm wide, used to secure the notebook''s pages. A matching kraft-covered pen featuring green plastic accents on the clip, tip, and a central ring is held on the right side via a green pen loop. The product seems slim and portable, with hidden binding, precise sharp edges, and the elastic band tautly stretched across its cover. A black logo of a realistic koala is clearly centered on the cover, covering around 30% of the surface, blending naturally with the notebook''s texture. The whole setting is photographed against a texture-less, plain, white background, with soft, even, diffused lighting creating subtle shadows beneath the pen and the notebook''s left side. The image presents a professional, studio-quality setup, emphasizing the modern, eco-conscious design of the notebook.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic logo of a koala in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20041, 51, 7, CAST(N'2024-12-03T05:14:12.117' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20041.jpg?alt=media&token=08fbe69f-c6f3-4740-92d9-11717acc708e', N'Imagine a vertically aligned rectangular notebook with a kraft paper cover, showcasing an eco-friendly and minimalist aesthetic. The cover boasts a smooth, matte finish sans any visible logos or patterns which enhances its simple design. The notebook adopts a light brown kraft tone without any gloss or reflective surfaces. A green elastic band, about 1 cm in width, runs vertically along the right edge, embedded firmly to hold the notebook’s pages tight. This adds a vivid yet subtle contrast to the natural kraft color. To the side of the notebook, a pen is securely held via a green loop that integrates into the notebook’s design. The pen shares the kraft color of the notebook further affirming the eco-friendly theme and has green plastic accents on the clip, tip, and a central ring. The pen’s design is cylindrical, and its finish is smooth, just like the notebook, suggesting they belong together. Despite being slim, the notebook hints at durability with its sharp edges and a tightly stretched elastic band. Both the notebook and pen are photographed against a plain white texture-less backdrop and under soft, uniform lighting to bring focus to the main subjects. Shadows beneath the pen and on the left side of the notebook provide depth without taking over the image. In the center, imagine a black logo of a koala taking up around 30% of the front surface. The logo is imprinted directly on the product, blending perfectly with the product’s texture. The overall image enhances the notebook''s modern, eco-friendly design while keeping the product as the main subject.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''Logo de un koala en color negro ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20042, 51, 7, CAST(N'2024-12-03T05:16:21.147' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20042.jpg?alt=media&token=af254684-ee77-461a-84ee-d7f09bb8eff5', N'Picture a rectangular vertical notebook with an eco-friendly, minimalist aesthetic. The notebook has a brown kraft paper cover with a smooth, matte texture and no logos or text. A contrasting green elastic band, one centimeter wide, runs vertically along the right edge, firmly holding the pages together. On the right, a pen hangs from a matching green pen loop. This pen echoes the notebook''s design with a kraft-colored barrel and green plastic accents. The notebook seems lightweight and portable, viewed against a clear white background. Soft, even lighting casts small shadows under the pen and to the notebook''s left. Superimposed on the notebook''s center is a white logo: a realistic koala eating leaves surrounded by trees. The logo matches the notebook''s texture as if printed directly onto it. The background is white and evenly lit, putting the product and logo in spotlight while preserving all design specifics.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A really realistic logo of a koala in color white eating leaves surrounded by trees ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20043, 52, 7, CAST(N'2024-12-03T05:19:06.790' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20043.jpg?alt=media&token=a3d0d213-682d-4511-bdb8-66656f740c9b', N'Generate a realistic, high-quality image of a product that is not specified. The image should feature a clear and noticeable logo in the center of the product, covering about 30% of the front surface. The logo should be a black colored cellphone and must blend in naturally with the texture of the product, looking as if it''s printed or embedded directly onto it. Avoid creating any 3D effects. The background of the image should be white and clean, with soft and uniform lighting that amplifies the product''s features without creating extra shadows. Both the product and the logo should be well-highlighted, with every detail in the design perfectly preserved.', N'Promt. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a cellphone in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20044, 52, 7, CAST(N'2024-12-03T05:20:11.873' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20044.jpg?alt=media&token=521d490f-8f81-46c3-87d6-bc8c8e3e2d98', N'A rectangular, beige tote bag made of natural cotton or canvas material with a minimalist, eco-friendly design. The bag has a slightly textured surface characteristic of woven fibers. It features two long, narrow straps of the same material, stitched to the top edge to form durable handles. The bag''s perfect rectangle shape has slightly rounded bottom corners. It is displayed against a plain white background with even, diffused light showing a faint shadow at the base. Placed exactly at the center of the bag, there is a black logo of a cellphone. The logo matches the product''s texture as if printed directly on it, covering around 30% of the bag''s front surface without altering the original design.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a cellphone in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20045, 52, 7, CAST(N'2024-12-03T05:21:28.383' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20045.jpg?alt=media&token=dd34ecb5-c8dd-4ae9-8faf-142e33a259c3', N'Generate a detailed, high-quality image of a rectangular tote bag made from beige cotton or canvas material, designed for eco-friendly use. The bag has a slightly textured surface with no initially visible logos, patterns, or designs. It has two long, narrow straps made of the same fabric, stitched securely to the top edge of the bag. The bag is a perfect rectangle with slightly rounded edges.  However, in the center of the product, present a cleanly applied logo of a realistically drawn black koala, taking up around 30% of the product''s surface. Ensure the product features no unnecessary embellishments and appears against a clean, white background. The lighting should be soft and uniform with a faint shadow at the base, indicative of a professional studio setting.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic logo of a koala in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20046, 52, 7, CAST(N'2024-12-03T05:23:11.293' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20046.jpg?alt=media&token=7d29d729-fc79-4be2-a159-b6bceac7d806', N'Produce an image of a rectangular tote bag fabricated from beige cotton or canvas material, designed to be reusable and eco-friendly. The bag has a subtle texture, reminiscent of woven fibers, and has a minimalist aesthetic, free from any visible patterns or designs. It has two slender straps which are stitched to its top edge, crafted from the same beige fabric as the bag. The bag itself is square with sharp edges, however, its base corners are slightly rounded. The straps are positioned upright for a professional look. In the midst of the product, feature a turtle-shaped logo, ensuring it''s centered and covers about 30% of the product''s front surface to maintain the product''s aesthetic appeal. This logo should appear as though it is printed or embedded right onto the product. Set against a white background, the lighting should be soft and even, avoiding harsh shadows but allowing for a faint one at the base of the bag, lending depth to the composition.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A turtle ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20047, 42, 7, CAST(N'2024-12-03T05:23:56.523' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20047.jpg?alt=media&token=7d71de25-cb6e-42f0-b24a-ba3e6f4d4124', N'Create an image of a cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface should be smooth and non-reflective, projecting an elegant, understated appearance. It should have no labels or logos except a turtle logo that is centrally located and covers approximately 30% of the product''s front surface. The overall design should be minimalist and simple. The cap should be a black screw-top with a slightly ribbed edge for grip. The bottle should be tall and slender, with a greater height-to-width ratio for a sleek, elongated look. The background should be plain white with soft, even lighting, eliminating almost all shadows but including a faint, diffuse shadow underneath the bottle for a floating effect. The high-quality image should emulate a professional studio setting, highlighting the product and logo clearly while preserving all specified design details.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A turtle''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20048, 51, 7, CAST(N'2024-12-03T05:24:57.053' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20048.jpg?alt=media&token=a82b4351-307e-41b6-9939-d77dd94c43e1', N'Create an image of a rectangular, vertical notebook with a light brown, smooth and matte kraft paper cover. The cover is devoid of logos or text, except for a centrally placed logo featuring a turtle surrounded by waves. This logo should be covering approximately 30% of the front surface, blending naturally with the notebook texture. The notebook has a green, tight elastic band running vertically on the right edge. A pen is attached to the right side of the notebook through a green pen loop. The pen has green plastic accents and a kraft-colored barrel similar to the notebook. The products are showcased against a clean, white background with soft, uniform lighting to emphasize their eco-friendly and minimalist design.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A turtle surrounded by waves ''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20049, 52, 7, CAST(N'2024-12-03T05:26:01.330' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20049.jpg?alt=media&token=51929650-a61d-4c9a-8a1d-84d67db8c244', N'Create a realistic image of a rectangular tote bag made of natural beige cotton or canvas. The surface of the bag should be smooth yet slightly textured, with no obvious logos or patterns. It features two long, narrow straps made of the same fabric, securely stitched to the top edge, forming handles suitable for carrying by hand or over the shoulder. The overall shape is a perfect rectangle with slightly rounded corners, embodying a minimalist and functional aesthetic. The bag should be photographed against a plain white background with even, soft lighting, and a faint shadow at the base. Place a centered logo in the shape of a piano on the front of the bag, covering approximately 30% of the product''s surface that melds naturally with the product’s texture for a seamless look. The complete focus is on the product and its reusable and sustainable qualities.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A piano''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20050, 52, 7, CAST(N'2024-12-03T05:27:05.727' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20050.jpg?alt=media&token=b9f7a78c-9679-4c00-a056-4f8d7e2b8d6d', N'Visualize a rectangular beige eco-friendly tote bag, crafted from sturdy but lightweight natural cotton or canvas material. The tote''s surface is smooth with a slight texture characteristic of woven fibers, indicating a durable makeup ideal for transporting daily items or groceries. The bag lacks any visible logos, designs, or patterns, embracing a minimalistic aesthetic. It features two elongated straps of the same beige fabric, looped to form practical handles for shoulder or hand carriage. The stitching is subtly reinforced at strap connections, suggesting durability and attention to quality construction. The bag''s bottom corners are somewhat rounded, offering a touch of organic softness to its otherwise geometrical figure. The bag''s unadorned, simplistic design advocates for practicality and utility over excess embellishments. Place this product against a plain white background and photograph it using carefully diffused, soft, even light to avoid harsh shadows and accurately represent color and texture. On the product''s front surface, in the middle, incorporate a centered piano logo, black in color, covering about 30% of the bag''s area. Ensure the logo appears integrated with the product''s fabric, without a 3D effect. Utilize white background with consistent, soft lighting, emphasizing the product attributes without added shadows. Ensure the product and logo are crisp and clear, maintaining every design detail.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a piano in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20051, 51, 7, CAST(N'2024-12-03T05:27:51.233' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20051.jpg?alt=media&token=c3d1bac3-4878-4bd8-9e00-0e7a159dfa8d', N'A portrait rectangular kraft paper-covered minimalist notebook having a matte finish, with neither text nor logos disturbing its simplicity. A contrasting green elastic band, running vertically on the right side to secure its pages. Attached to this minimalist notebook, a pen held firmly thanks to a seamlessly integrated green loop. The pen, sporting a kraft-colored barrel and green plastic accents from clip to tip, matches the overall eco-friendly aesthetic of the notebook. This slim, sharp-edged notebook lays against a plain, white background under soft, uniform, diffused lighting, resulting in subtle shadows that add depth. The lightning captures its natural texture and resilient structure. Centered on this notebook''s cover, a black coloured realistic piano logo, covering about 30% of the notebook''s front side. The logo merges with the notebook''s texture, giving the impression of being printed directly on the surface, without any 3D effects or raised surfaces. The white background and soft, uniform, diffused lighting allow a spotlight on the product and logo.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic piano in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20052, 52, 7, CAST(N'2024-12-03T05:29:06.643' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20052.jpg?alt=media&token=9737947b-7702-4ba6-9093-cebeebd81e73', N'Illustrate a rectangular tote bag made from beige canvas fabric, embodying an eco-friendly, reusable purpose. The bag has a subtle texture, indicating woven fibers, without any patterns or designs, displaying a clean and minimalist style. It''s lightweight yet durable, suitable for carrying groceries or everyday items. It has two long, narrow, uniform beige straps securely stitched on top, looped to form handles, fit for shoulder carry or by hand. The stitching on the straps is subtle but reinforced. The bag retains a perfect rectangular shape but has slightly rounded corners at the bottom. On a plain, white background, centered, the bag stands with upright straps against soft, even, diffused lighting. A slight shadow at the base adds depth. Superimpose a realistic black piano logo in the center of the bag, scaled to cover about 30% of the front surface. It should appear as though naturally printed on the bag''s fabric without 3D effects. The lighting should avoid extra shadows and skillfully enhance the product''s features.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo a realistic piano in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20053, 52, 7, CAST(N'2024-12-03T05:29:52.517' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20053.jpg?alt=media&token=e3c1705d-7e1f-4f81-90d4-be694879f56a', N'Create a detailed image of a rectangular, beige tote bag crafted from natural cotton or canvas fabric. The bag should have a minimalist aesthetic, characterized by a smooth yet slightly textured surface without any patterns. The bag should demonstrate lightweight durability, suitable for carrying everyday items. The tote bag has two long and narrow straps of the same beige fabric, structurally stitched to the top with subtle reinforcements. The bag''s shape is a perfect rectangle with slightly rounded background corners. The overall design is of high functionality and refreshing simplicity. The bag should be against a plain white background, centrally framed under soft, evenly diffused lighting. A faint shadow at the base gives depth to the image. On this bag, place a logo: a realistic, black-colored piano that covers approximately 30% of the bag''s surface, seamlessly integrated as if printed directly on it while maintaining the product''s original design.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic piano in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20054, 42, 7, CAST(N'2024-12-03T05:30:31.170' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20054.jpg?alt=media&token=c44ae166-a077-4409-bb32-5d7623eb833e', N'A tall, slender cylindrical bottle made of matte black metal, possibly aluminum. The surface texture is smooth and non-reflective, and it has no labels or logos giving it a minimalist and simple design. The cap is a screw-top and is also black, with slightly ribbed edges for a better grip. The white background is smooth, with even lighting and minimal shadow play, accentuating the elegance of the bottle. A white, realistic piano logo is centered on the bottle, covering about 30% of its front surface, blending naturally with the bottle''s texture. The lighting is soft and highlights the matte finish of the bottle and the subtlety of the logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic piano in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20055, 52, 7, CAST(N'2024-12-03T05:32:20.853' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20055.jpg?alt=media&token=c840087b-5013-4b40-8056-bb4ab88dd87b', N'A rectangular tote bag made of beige, natural cotton or canvas material, created for eco-friendly purposes. The bag''s smooth, slightly textured surface has no visible patterns, exhibiting a minimalist aesthetic. It appears lightweight yet resilient, perhaps ideal for carrying everyday items. It features two long, narrow, beige straps stitched to the top edge of the bag, designed for shoulder or hand carry. The stitching is subtle but reinforced, indicating durability. The shape is a perfect rectangle with slightly rounded bottom corners. Presented against a simple white backdrop with soft, diffused light to highlight the bag''s color and texture. A faint shadow can be seen at the base of the bag. In the center, there''s a black, realistic logo of a cat, taking up around 30% of the front surface, seamlessly integrated with the product’s texture.', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic logo of a cat in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20056, 51, 7, CAST(N'2024-12-03T05:33:25.527' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20056.jpg?alt=media&token=b78daab8-9365-4d43-9a15-a6626ceba547', N'Imagine a realistic and detailed image of a vertically oriented rectangular notebook with a light brown kraft paper cover, illustrating a natural, eco-friendly, and minimalist aesthetic. The cover should possess a smooth texture with a matte finish, free from any visible logos, patterns, or text to emphasize simplicity. A green elastic band, approximately 1 centimeter in width, runs vertically along the right edge of the notebook, securing the pages. There should also be a pen attached via a green pen loop at the right side of the notebook. This pen should have a matching kraft-colored barrel with green plastic accents. The notebook appears slim, lightweight, and portable, with precise sharp edges and a durable elastic band. The notebook and pen should be placed against a plain, white background, under soft, uniform and diffused lighting that forms subtle shadows, indicating depth, underneath the pen and on the left side of the notebook. At the center of the notebook, there should be a realistic, white logo of a cat, precisely centered and covering about 30% of the front surface. This logo should seamlessly blend with the notebook’s texture, and it should look as if it was printed directly on the notebook. The lighting and background should enhance the notebook''s features while ensuring that the product and logo remain the focal point in a professional, studio-like setting.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic logo of a cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20057, 51, 7, CAST(N'2024-12-03T05:34:05.473' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20057.jpg?alt=media&token=58e71317-667e-4633-9fd7-cf1004ba27c6', N'An image of a rectangular, vertically oriented notebook with a light brown kraft paper cover. It showcases a natural, eco-friendly, and minimalist aesthetic with a smooth texture and matte finish, devoid of visible logos or patterns. The right edge of the notebook features a green elastic band, embedded to secure the pages. Attached to the right, a pen with matching kraft-colored barrel and green plastic accents sits snugly in a loop. The binding is not visible, underscoring a slim and portable build. Firm edges and a tightly stretched elastic band suggest durability. The notebook rests against a plain white background. Soft, uniform lighting creates a bright visual, with subtle shadows beneath the pen and on the left side of the notebook, lending depth and emphasis on the texture and the green accents. The composition radiates professionalism. In the center of the notebook, a monochrome logo of a cat is clearly visible, seamlessly integrated into the product''s texture and covering approximately 30% of the product''s front surface. The backdrop is clean white, highlighting the notebook and cat logo.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A realistic logo of a cat in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20058, 51, 7, CAST(N'2024-12-03T05:34:56.340' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20058.jpg?alt=media&token=6367c4dd-cc52-42dc-a21f-d6e420d738f1', N'Visualize a vertically oriented rectangular notebook with an eco-friendly design. The cover is made from smooth, matte, light brown kraft paper, devoid of any patterns or text. A green elastic band runs along the right edge, contrasting with the natural tone of the notebook. On the notebook''s right side, secure a pen using a pen loop of the same green hue. The pen''s cylindrical design features a kraft-colored barrel and green plastic accents. The notebook appears slim with hidden binding, hinting at portability and durability. Against a plain white background, under soft, uniform, and diffused lighting, the notebook and pen are the composition''s focus. Incorporate a white cat logo placed centrally on the product. The logo should be noticeable and appealing, covering approximately 30% of the product’s front surface, while blending naturally onto it. The background should maintain its cleanliness, and the lighting should enhance the product without adding extra shadows.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20059, 51, 7, CAST(N'2024-12-03T05:35:46.673' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20059.jpg?alt=media&token=e40c1dd0-4e1b-454e-bd2f-892a78a806e1', N'Create a realistic high-quality image of a vertical rectangular notebook with a kraft paper cover, designed to be natural, eco-friendly, and minimalist. The cover has a smooth, matte finish devoid of logos, patterns, or text. It boasts a clean, uninterrupted light brown color, non-reflective. It''s clasped by a green elastic band running vertically along the right-hand side. Next to the notebook, a pen encased in a green pen loop. The pen is matching the notebook''s color with green plastic accents adorning the clip, tip, and a central ring. The notebook is slim, suggesting a light, portable, and durable build. The product is against a white plain background. Light evenly illuminates the product, with soft shadows adding dimension. In the center of the product, incorporate a cat logo, which matches the product''s texture, and covers approximately 30% of the product''s front surface on a white, clean, subtly illuminated background that highlights the product''s features with emphasized green accents.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A cat''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20060, 51, 7, CAST(N'2024-12-03T05:36:54.527' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20060.jpg?alt=media&token=ddc39105-7ed9-4ab1-b0e1-e73f34e166a0', N'A rectangular, vertical notebook on a clean, white background. The notebook is made of lightweight kraft paper, its cover a light brown tone with a matte finish suggestive of a natural, eco-friendly sentiment. A 1 cm wide green elastic band runs vertically down the right edge, sharply contrasting with the gentle kraft tone, providing a secure hold for the pages within. A pen, sharing the kraft color and featuring green accents, is attached to the right side of the notebook, inside a green pen loop. The pen''s design is cylindrical with a trim of green around its clip, tip and central ring. The product is lightweight, portable with sharp cut edges - promising durability while maintaining a minimalist aesthetic. Outstandingly, on the cover of the notebook is a black, realistic cat logo, placed centrally and covering around 30% of the front surface area. The logo blends naturally with the cover texture, looking as if it was directly printed on it with no 3D effect. The lighting is soft and evenly distributed, accenting the product and logo while casting subtle shadows under the pen and on the left side of the notebook to add depth.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic cat in color black''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20061, 42, 7, CAST(N'2024-12-03T05:37:31.770' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20061.jpg?alt=media&token=1a488950-c0d4-443b-acd6-463b0ddf5586', N'Construct an image of a tall, elegant cylindrical bottle with a matte black finish, likely made of smooth, non-reflective aluminum material. This bottle has an unadorned minimalist and simple design, with no additional labels. Its cap is a screw-top and is also black, slightly ribbed to allow for a better grip. The bottle''s shape is slender with a significant height-to-width ratio, blending chic with understated elegance. Place this bottle against a plain, white background that is smooth and devoid of noticeable shadows, allowing the bottle to be in the spotlight. Incorporate soft, even lighting to eliminate any harsh shadows, accentuating the bottle''s matte-ness. Induce a faint, subtle shadow at the base to create a slight illusion of the bottle floating above the white background, reminiscent of professional studio settings. In the center of the bottle, carefully embed a logo of a realistic white cat, covering about 30% of the front surface. Ensure the logo blends in naturally with the black matte finish as if it is directly printed or engraved onto it. Make sure no three-dimensional effect disrupts this seamless integration. Retain a clean white background with soft, uniform lighting that subtly enhances the product''s features without introducing additional shadows, thus making the black bottle and white logo the primary focus.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic cat in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20062, 42, 7, CAST(N'2024-12-03T05:38:19.467' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20062.jpg?alt=media&token=0286b27e-7436-494a-989d-7a2513853db0', N'Create a 3D image of a tall, slender cylindrical bottle with a matte black finish, possibly made of aluminum, having a smooth, non-reflective surface providing it with an elegant, understated appearance. The bottle is minimalist, with no labels or logos, except for a white tiger logo centered on the bottle''s body. This logo should cover approximately 30% of the surface maintaining the bottle''s original design. The cap of the bottle is a black screw-top with a slightly ribbed edge for better grip. The image setting should be a clean, white background with soft, even lighting, eliminating all shadows. There is a faint, diffuse shadow at the bottom, giving the product a subtle floating effect, and enhancing the impression of a professional studio setting. The tiger logo should appear as if it is printed or embedded directly into the bottle''s surface, avoiding any 3D effects.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic tiger in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (20063, 51, 7, CAST(N'2024-12-03T05:38:55.240' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/bocetos%2F20063.jpg?alt=media&token=84379b0e-c6c8-416a-bdaa-dbfb19783535', N'Generate a photo-realistic depiction of a vertically oriented rectangular notebook with a kraft paper cover, designed with an eco-friendly and minimalist aesthetic. The cover should be smooth, unadorned, and matt, showcasing a light brown kraft tone. The notebook should have a green elasticated band running vertically along the right edge, providing a vibrant accent against the kraft color. On the notebook''s right is a pen held by a green loop, it''s primarily composed of a matching kraft-colored barrel with green accents, aligning the design elements. The slim notebook should display sharp edges and a hidden binding, indicating a lightweight, robust structure. It''s photographed against a plain white background under a diffused, uniform lighting that casts subtle depth-adding shadows on the left side and beneath the pen. In the photograph''s center, superimpose a well-integrated, realistically rendered white tiger logo onto the product, sized roughly at 30% of the front cover''s surface, thus drawing attention without overwhelming its design. Ensure both the notebook and the logo maintain their complex detailing under a soft light that avoids harsh shadows. The overall image should convey professionalism, focusing on the product''s simplicity & eco-conscious concept.', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.. Create a realistic, high-quality image of the described product, ensuring the appearance matches precisely. In the center of the product, incorporate a logo based on the following description: ''A logo of a realistic tiger in color white''. Position the logo so it’s clearly centered, covering approximately 30% of the product’s front surface to be noticeable and visually appealing, without obscuring or altering the original product design. The logo should blend naturally with the product’s texture, as if printed or embedded directly on it. Avoid any raised or three-dimensional effects for a seamless integration. Use a white, clean background with soft, uniform lighting that enhances the product’s features without introducing extra shadows. Highlight the product and logo clearly, preserving all specified design details.')
GO
SET IDENTITY_INSERT [dbo].[Boceto] OFF
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (1, N'Gorras')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (2, N'Mochilas')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (3, N'Bolsos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (4, N'Artículos para paseo')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (5, N'Botellas y más')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (6, N'Tecnología')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (7, N'Audífonos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (8, N'Parlantes')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (9, N'Accesorios tecnológicos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (10, N'Bolígrafos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (11, N'Bolígrafos
metálicos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (12, N'Bolígrafos
plásticos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (13, N'Oficina')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (14, N'Pasa tiempos')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (15, N'Cuidado personal')
GO
INSERT [dbo].[Categoria] ([CategoriaId], [Nombre]) VALUES (16, N'Varios')
GO
SET IDENTITY_INSERT [dbo].[Cotizacion] ON 
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (1, 7, 10019, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F1?alt=media&token=b2ddf2de-f406-40a5-bffb-aba799b969ed', CAST(50000.00 AS Decimal(18, 2)), CAST(6500.00 AS Decimal(18, 2)), CAST(56500.00 AS Decimal(18, 2)), CAST(N'2024-12-01T12:30:15.173' AS DateTime), 1, N'sss')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (2, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F2?alt=media&token=a993b436-e9f4-46f3-ad79-d532bb846ea5', CAST(140.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)), CAST(158.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:01:17.443' AS DateTime), 1, N'Cotizacion de animales generada')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (3, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F3?alt=media&token=30fa5145-c303-497e-8e53-89c37a97b7d4', CAST(100.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(113.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:08:23.407' AS DateTime), 1, N'Cotizacion animales 2')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (4, 6, 10006, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F4?alt=media&token=32155bc0-861d-401b-b275-4db2ee9d581a', CAST(160000.00 AS Decimal(18, 2)), CAST(20800.00 AS Decimal(18, 2)), CAST(180800.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:16:22.667' AS DateTime), 1, N'sss')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (5, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F5?alt=media&token=2feac52b-d49b-4f40-b400-e181f83bf51b', CAST(100.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(113.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:17:22.720' AS DateTime), 1, N'Animales 3')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (6, 7, 10019, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F6?alt=media&token=8f1692af-c7e6-4a3e-a247-394934c162e5', CAST(52000.00 AS Decimal(18, 2)), CAST(6760.00 AS Decimal(18, 2)), CAST(58760.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:19:00.103' AS DateTime), 1, N'Cotizacion teclado prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (7, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F7?alt=media&token=e3ce7d55-dab1-4225-94b8-94f757bf61a1', CAST(100.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(113.00 AS Decimal(18, 2)), CAST(N'2024-12-01T13:25:45.243' AS DateTime), 1, N'Cotizaciones animales 4')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (8, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F8?alt=media&token=e7c590d8-240d-4da2-a62c-726a59024138', CAST(120.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(136.00 AS Decimal(18, 2)), CAST(N'2024-12-01T15:58:31.070' AS DateTime), 1, N'Cotización creada')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (9, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F9?alt=media&token=5c5d00e9-3d30-4ed9-bc54-adbf3b976aad', CAST(120.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(136.00 AS Decimal(18, 2)), CAST(N'2024-12-02T00:55:20.747' AS DateTime), 1, N'Cotizacion prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (10, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F10?alt=media&token=eb51d411-3efa-4c49-9710-ed223d7b38bc', CAST(120.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(136.00 AS Decimal(18, 2)), CAST(N'2024-12-02T01:04:30.640' AS DateTime), 1, N'Prueba 4')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (11, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F11?alt=media&token=ce864cef-6665-4589-8bc7-e91a16fe68fd', CAST(120.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(136.00 AS Decimal(18, 2)), CAST(N'2024-12-02T01:11:56.520' AS DateTime), 1, N'Prueba 5')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (12, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F12?alt=media&token=6c884e1a-fbcc-47f4-be26-63cff451a2c4', CAST(120.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(136.00 AS Decimal(18, 2)), CAST(N'2024-12-02T02:08:08.723' AS DateTime), 1, N'Prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (13, 7, 10020, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F13?alt=media&token=01122fef-0957-44a4-875e-3009917805d2', CAST(120.00 AS Decimal(18, 2)), CAST(15.60 AS Decimal(18, 2)), CAST(135.60 AS Decimal(18, 2)), CAST(N'2024-12-02T02:11:36.130' AS DateTime), 1, N'Prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (14, 6, 10006, N'', CAST(160000.00 AS Decimal(18, 2)), CAST(20800.00 AS Decimal(18, 2)), CAST(180800.00 AS Decimal(18, 2)), CAST(N'2024-12-02T02:20:32.853' AS DateTime), 1, N'Prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (15, 6, 10006, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F15?alt=media&token=e8aa4513-25b0-4c2e-a7bb-7c01e97fab04', CAST(160000.00 AS Decimal(18, 2)), CAST(20800.00 AS Decimal(18, 2)), CAST(180800.00 AS Decimal(18, 2)), CAST(N'2024-12-02T02:24:01.173' AS DateTime), 1, N'Prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (16, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F16?alt=media&token=f4160bae-555e-4d40-9520-7bd7b52af5b1', CAST(120.00 AS Decimal(18, 2)), CAST(15.60 AS Decimal(18, 2)), CAST(135.60 AS Decimal(18, 2)), CAST(N'2024-12-02T02:26:10.583' AS DateTime), 1, N'Prueba')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (17, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F17?alt=media&token=fd7c9c9e-501c-4d9b-854c-465a45536cd7', CAST(156.00 AS Decimal(18, 2)), CAST(20.28 AS Decimal(18, 2)), CAST(176.28 AS Decimal(18, 2)), CAST(N'2024-12-02T02:45:25.570' AS DateTime), 1, N'hklhk')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (18, 7, 10021, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F18?alt=media&token=9d2ca9e6-08fa-4fdf-bb51-66b6f6bdf223', CAST(135.00 AS Decimal(18, 2)), CAST(17.55 AS Decimal(18, 2)), CAST(152.55 AS Decimal(18, 2)), CAST(N'2024-12-02T21:38:58.650' AS DateTime), 1, N'Prueba')
GO
SET IDENTITY_INSERT [dbo].[Cotizacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Cotizacion_Detalle] ON 
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (1, 1, 10031, 10, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (2, 1, 10030, 15, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (3, 2, 20034, 20, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (4, 2, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (5, 3, 20034, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (6, 3, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (7, 4, 10013, 50, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (8, 4, 10020, 30, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (9, 5, 20034, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (10, 5, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (11, 6, 10031, 11, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (12, 6, 10030, 15, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (13, 7, 20034, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (14, 7, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (15, 8, 20034, 25, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (16, 8, 10031, 5, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (17, 9, 20034, 20, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (18, 9, 10031, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (19, 10, 20034, 20, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (20, 10, 10031, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (21, 11, 20034, 20, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (22, 11, 10031, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (23, 12, 20034, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (24, 12, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (25, 13, 20034, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (26, 13, 20035, 15, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (27, 14, 10013, 50, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (28, 14, 10020, 30, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (29, 15, 10013, 50, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (30, 15, 10020, 30, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (31, 16, 20034, 20, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (32, 16, 10031, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (33, 17, 20034, 29, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (34, 17, 10031, 10, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (35, 18, 20034, 20, CAST(4.50 AS Decimal(18, 2)), CAST(4.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (36, 18, 10031, 10, CAST(4.50 AS Decimal(18, 2)), CAST(4.50 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Cotizacion_Detalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (42, 1, N'Botella negra', N'Botella negra de alumio', 45, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F42?alt=media&token=d93d0d44-a399-494c-92a2-e0649d3d2d3e', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting', CAST(2000.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (51, 13, N'Libreta', N'Libreta compacta y elegante, ideal para tomar notas y organizar tus ideas, con papel de alta calidad.', 20, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F54?alt=media&token=45e43eb7-ee9f-4948-8985-33c417cdf346', N'A vertically oriented rectangular notebook with a kraft paper cover, designed to convey a natural, eco-friendly, and minimalist aesthetic. The cover has a smooth texture and a matte finish, free from any visible logos, patterns, or text, emphasizing its simplicity. The notebook features a clean and uninterrupted light brown kraft tone, with no gloss or reflective surfaces. Running vertically along the right edge is a green elastic band, approximately 1 centimeter in width, firmly embedded into the notebook to secure its pages. The band is tight and contrasts sharply with the natural kraft color, adding a vibrant yet subtle accent to the design.

On the right side of the notebook, there is a pen attached via a green pen loop, which is seamlessly integrated into the notebook''s structure. The pen is primarily composed of a matching kraft-colored barrel, maintaining consistency with the notebook''s eco-friendly theme. The pen features green plastic accents, including the clip, tip, and a central ring, which align perfectly with the green of the elastic band. The pen''s design is cylindrical, with a smooth finish, and it fits snugly within the pen loop, ensuring a secure hold.

The notebook appears slim, with the binding hidden from view, suggesting a lightweight and portable build. The edges of the notebook are sharp and precisely cut, while the elastic band stretches tightly across the cover, hinting at durability and functionality. The product is photographed against a plain white background, free of any textures or distractions, ensuring the notebook and pen remain the central focus of the composition.

The lighting is soft, uniform, and diffused, creating an even brightness across the entire product. Subtle shadows are visible beneath the pen and on the left side of the notebook, providing depth without overwhelming the image. The photograph emphasizes the natural kraft texture of the notebook while subtly highlighting the vibrant green accents of the elastic band and pen components. The overall composition exudes a professional, studio-quality setting, drawing attention to the notebook''s eco-conscious and modern design.', CAST(3100.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (52, 4, N'Bolso de manta', N'Bolso de ligero y duradero, perfecto para llevar tus esenciales. Su material es resistente y fácil de limpiar, es una opción cómoda y ecológica. ', 10, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F55?alt=media&token=462c90a9-db90-4208-98f9-340ebf2d0766', N'A rectangular tote bag made of beige fabric, likely a natural cotton or canvas material, designed for reusable and eco-friendly purposes. The bag has a smooth yet slightly textured surface, characteristic of woven fibers, with no visible logos, patterns, or designs, emphasizing a clean and minimalist aesthetic. The fabric appears lightweight yet durable, suggesting it is suitable for carrying everyday items or groceries.

The bag features two long, narrow straps that are securely stitched to the top edge of the bag. The straps are made of the same beige fabric as the body, maintaining uniformity in color and texture. These straps are looped to form handles, designed for carrying the bag over the shoulder or by hand. The stitching at the attachment points of the straps is subtle but reinforced, indicating durability and attention to detail in construction.

The shape of the bag is a perfect rectangle with sharp, clean edges. The bottom corners are slightly rounded, giving a softer, more natural appearance while preserving the geometric structure. The overall design is functional and straightforward, without any unnecessary embellishments, focusing on utility and simplicity.

The bag is photographed against a plain white background with no visible distractions, ensuring the product is the focal point. The lighting is soft, even, and diffused, eliminating harsh shadows and providing an accurate representation of the bag''s color and texture. A faint shadow is visible at the base of the bag, grounding it slightly and adding depth to the composition. The tote bag appears centered in the frame, with the straps upright, suggesting a professional studio setting that highlights the product’s reusable and sustainable nature.', CAST(2550.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(5, 2)))
GO
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 
GO
INSERT [dbo].[Rol] ([IdRol], [Nombre]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Rol] ([IdRol], [Nombre]) VALUES (2, N'Colaborador')
GO
INSERT [dbo].[Rol] ([IdRol], [Nombre]) VALUES (3, N'Cliente')
GO
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Cotizacion] ON 
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10006, 6, N'Cotización en dolares', CAST(N'2024-11-16T20:28:47.340' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10007, 6, N'Cotizacion dolares 2', CAST(N'2024-11-16T20:37:36.707' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10008, 6, N'Cotizacion dolares 3', CAST(N'2024-11-16T20:39:55.220' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10009, 6, N'Prueba cotizacion dolares 3', CAST(N'2024-11-16T20:43:20.500' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10010, 6, N'Cotizacion en dolares', CAST(N'2024-11-16T21:32:17.130' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10011, 6, N'Cotizacion en dolares', CAST(N'2024-11-16T21:34:18.127' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10012, 6, N'Prueba cotizacion colones', CAST(N'2024-11-16T21:39:15.657' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10013, 6, N'Prueba cotización dólares', CAST(N'2024-11-16T21:40:47.510' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10014, 6, N'Prueba', CAST(N'2024-11-16T21:41:57.053' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10015, 6, N'Prueba paginas 1', CAST(N'2024-11-16T22:54:11.470' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10016, 6, N'Prueba meli', CAST(N'2024-11-17T21:44:51.833' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10017, 7, N'Solicitud para el evento del fin de semana', CAST(N'2024-11-17T23:29:16.997' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10018, 7, N'sas', CAST(N'2024-11-20T19:09:20.960' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10019, 7, N'Evento del fin de semana', CAST(N'2024-11-20T20:45:11.940' AS DateTime), 1, 1)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10020, 7, N'Animales', CAST(N'2024-12-01T12:53:11.590' AS DateTime), 1, 2)
GO
INSERT [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion], [IdUsuario], [Descripcion], [FechaCreacion], [Estado], [Moneda]) VALUES (10021, 7, N'Evento diciembre', CAST(N'2024-12-01T15:56:15.613' AS DateTime), 1, 2)
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Cotizacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Cotizacion_Detalle] ON 
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10012, 10006, 10013, 50, N'Montaña con arboles')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10013, 10006, 10020, 30, N'Bola solo color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10014, 10007, 10020, 30, N'En color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10015, 10007, 10021, 20, N'En color blanco logo mas grande')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10016, 10008, 10020, 30, N'En color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10017, 10008, 10021, 20, N'En color blanco logo mas grande')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10018, 10009, 10013, 12, N'aaa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10019, 10009, 10018, 1231, N'AAa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10020, 10010, 10016, 3, N'aa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10021, 10010, 10017, 34, N'aaa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10022, 10011, 10016, 3, N'aa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10023, 10011, 10017, 34, N'aaa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10024, 10012, 10018, 40, N'Bola color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10025, 10012, 10020, 90, N'Bola color blanco y mas grande')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10026, 10013, 10015, 60, N'Montaña con más árboles')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10027, 10014, 10027, 30, N'Guitarra 2')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10028, 10015, 10012, 34, N'aaa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10029, 10015, 10013, 56, N'aaa')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10030, 10015, 10023, 32, N'333')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10031, 10015, 10022, 65, N'333')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10032, 10016, 10020, 312, N'FDAS')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10033, 10016, 10019, 324, N'ASFDAS')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10034, 10016, 10027, 12, N'AFSDA')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10035, 10016, 10026, 12, N'ASDFA')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10036, 10017, 10030, 34, N'El teclado mas realista')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10037, 10017, 10028, 45, N'Solo un mouse')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10038, 10018, 10031, 12, N'ss')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10039, 10018, 10030, 12, N'ss')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10040, 10019, 10031, 10, N'Bola mas grande')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10041, 10019, 10030, 15, N'Teclado realista')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10042, 10020, 20034, 10, N'Leon en color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10043, 10020, 20035, 15, N'Zebra mas realista')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10044, 10021, 20034, 20, N'Leon color blanco')
GO
INSERT [dbo].[Solicitud_Cotizacion_Detalle] ([IdSolicitudCotizacionDetalle], [IdSolicitudCotizacion], [IdBoceto], [Cantidad], [DescripcionUsuario]) VALUES (10045, 10021, 10031, 10, N'Bola mas grande')
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Cotizacion_Detalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (6, 1, N'118560019', N'Fabian Josue Montero Madrigal', N'fabianja0477@gmail.com', N'84955721', N'Vázquez de Coronado, Barrio el Carmen', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-11-17T23:12:57.420' AS DateTime), 41)
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (7, 3, N'402510174', N'Melissa Vargas Gómez', N'mv213845@gmail.com', N'87963587', N'Mercedes Norte, Heredia', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-10-13T11:47:14.553' AS DateTime), 37)
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (8, 2, N'118790289', N'Alonso Salazar Monge', N'asalazar90289@ufide.ac.cr', N'61997966', N'Curridabat, San José', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-12-01T19:20:56.497' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
/****** Object:  Index [IX_Cotizacion]    Script Date: 2/12/2024 23:43:42 ******/
CREATE NONCLUSTERED INDEX [IX_Cotizacion] ON [dbo].[Cotizacion]
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1_2]    Script Date: 2/12/2024 23:43:42 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1_2] ON [dbo].[Usuario]
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 2/12/2024 23:43:42 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Usuario] ON [dbo].[Usuario]
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Boceto]  WITH CHECK ADD  CONSTRAINT [FK_Boceto_Producto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([IdProducto])
GO
ALTER TABLE [dbo].[Boceto] CHECK CONSTRAINT [FK_Boceto_Producto]
GO
ALTER TABLE [dbo].[Boceto]  WITH CHECK ADD  CONSTRAINT [FK_Boceto_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Boceto] CHECK CONSTRAINT [FK_Boceto_Usuario]
GO
ALTER TABLE [dbo].[Correos_Electronicos_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Correos_Electronicos_Detalle_Correos_Electronicos] FOREIGN KEY([IdCorreoElectronico])
REFERENCES [dbo].[Correos_Electronicos] ([IdCorreoElectronico])
GO
ALTER TABLE [dbo].[Correos_Electronicos_Detalle] CHECK CONSTRAINT [FK_Correos_Electronicos_Detalle_Correos_Electronicos]
GO
ALTER TABLE [dbo].[Correos_Electronicos_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Correos_Electronicos_Detalle_Grupo_Usuarios] FOREIGN KEY([IdGrupoUsuarios])
REFERENCES [dbo].[Grupo_Usuarios] ([IdGrupoUsuarios])
GO
ALTER TABLE [dbo].[Correos_Electronicos_Detalle] CHECK CONSTRAINT [FK_Correos_Electronicos_Detalle_Grupo_Usuarios]
GO
ALTER TABLE [dbo].[Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_Solicitud_Cotizacion] FOREIGN KEY([IdSolicitudCotizacion])
REFERENCES [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion])
GO
ALTER TABLE [dbo].[Cotizacion] CHECK CONSTRAINT [FK_Cotizacion_Solicitud_Cotizacion]
GO
ALTER TABLE [dbo].[Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Cotizacion] CHECK CONSTRAINT [FK_Cotizacion_Usuario]
GO
ALTER TABLE [dbo].[Cotizacion_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_Detalle_Boceto] FOREIGN KEY([IdBoceto])
REFERENCES [dbo].[Boceto] ([IdBoceto])
GO
ALTER TABLE [dbo].[Cotizacion_Detalle] CHECK CONSTRAINT [FK_Cotizacion_Detalle_Boceto]
GO
ALTER TABLE [dbo].[Cotizacion_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_Detalle_Cotizacion] FOREIGN KEY([IdCotizacion])
REFERENCES [dbo].[Cotizacion] ([IdCotizacion])
GO
ALTER TABLE [dbo].[Cotizacion_Detalle] CHECK CONSTRAINT [FK_Cotizacion_Detalle_Cotizacion]
GO
ALTER TABLE [dbo].[Grupo_Usuarios_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_Usuarios_Detalle_Grupo_Usuarios] FOREIGN KEY([IdGrupoUsuarios])
REFERENCES [dbo].[Grupo_Usuarios] ([IdGrupoUsuarios])
GO
ALTER TABLE [dbo].[Grupo_Usuarios_Detalle] CHECK CONSTRAINT [FK_Grupo_Usuarios_Detalle_Grupo_Usuarios]
GO
ALTER TABLE [dbo].[Grupo_Usuarios_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_Usuarios_Detalle_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Grupo_Usuarios_Detalle] CHECK CONSTRAINT [FK_Grupo_Usuarios_Detalle_Usuario]
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [FK_Orden_Usuario]
GO
ALTER TABLE [dbo].[Orden_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Cotizacion_Orden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
GO
ALTER TABLE [dbo].[Orden_Cotizacion] CHECK CONSTRAINT [FK_Orden_Cotizacion_Orden]
GO
ALTER TABLE [dbo].[Orden_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Cotizacion_Solicitud_Cotizacion] FOREIGN KEY([IdSolicitudCotizacion])
REFERENCES [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion])
GO
ALTER TABLE [dbo].[Orden_Cotizacion] CHECK CONSTRAINT [FK_Orden_Cotizacion_Solicitud_Cotizacion]
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Bocetos_Boceto] FOREIGN KEY([IdBoceto])
REFERENCES [dbo].[Boceto] ([IdBoceto])
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos] CHECK CONSTRAINT [FK_Orden_Detalle_Bocetos_Boceto]
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Bocetos_Orden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos] CHECK CONSTRAINT [FK_Orden_Detalle_Bocetos_Orden]
GO
ALTER TABLE [dbo].[Orden_Detalle_Comprobantes]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Comprobantes_Orden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
GO
ALTER TABLE [dbo].[Orden_Detalle_Comprobantes] CHECK CONSTRAINT [FK_Orden_Detalle_Comprobantes_Orden]
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Cotizacion_Boceto] FOREIGN KEY([IdBoceto])
REFERENCES [dbo].[Boceto] ([IdBoceto])
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion] CHECK CONSTRAINT [FK_Orden_Detalle_Cotizacion_Boceto]
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Cotizacion_Orden_Cotizacion] FOREIGN KEY([IdOrdenCotizacion])
REFERENCES [dbo].[Orden_Cotizacion] ([IdOrdenCotizacion])
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion] CHECK CONSTRAINT [FK_Orden_Detalle_Cotizacion_Orden_Cotizacion]
GO
ALTER TABLE [dbo].[Orden_Detalle_Factura_Pendiente]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Factura_Pendiente_Orden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
GO
ALTER TABLE [dbo].[Orden_Detalle_Factura_Pendiente] CHECK CONSTRAINT [FK_Orden_Detalle_Factura_Pendiente_Orden]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Categoria] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categoria] ([CategoriaId])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Categoria]
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Cotizacion_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion] CHECK CONSTRAINT [FK_Solicitud_Cotizacion_Usuario]
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Cotizacion_Detalle_Boceto] FOREIGN KEY([IdBoceto])
REFERENCES [dbo].[Boceto] ([IdBoceto])
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion_Detalle] CHECK CONSTRAINT [FK_Solicitud_Cotizacion_Detalle_Boceto]
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Cotizacion_Detalle_Solicitud_Cotizacion] FOREIGN KEY([IdSolicitudCotizacion])
REFERENCES [dbo].[Solicitud_Cotizacion] ([IdSolicitudCotizacion])
GO
ALTER TABLE [dbo].[Solicitud_Cotizacion_Detalle] CHECK CONSTRAINT [FK_Solicitud_Cotizacion_Detalle_Solicitud_Cotizacion]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Rol] ([IdRol])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPerfilUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarPerfilUsuario]
	@NombreCompleto    varchar(255),
	@Identificacion    varchar(12),
	@CorreoElectronico varchar(50),
	@NumeroTelefono    varchar(50),
	@DireccionExacta   varchar(250),
	@UsuarioId BIGINT
AS
BEGIN
	

UPDATE [dbo].[Usuario]
   SET [NombreCompleto] = @NombreCompleto
      ,[Identificacion] = @Identificacion
      ,[CorreoElectronico] = @CorreoElectronico
      ,[NumeroTelefono] = @NumeroTelefono
      ,[DireccionExacta] = @DireccionExacta
 WHERE UsuarioId = @UsuarioId
END


GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarProducto]
    @IdProducto BIGINT,
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @PrecioUnitarioColones DECIMAL(18, 2),
	@PrecioUnitarioDolares DECIMAL(18, 2),
	@PorcentajeVenta DECIMAL(5,2),
	@Prompt VARCHAR(MAX),
    @CategoriaId BIGINT,
    @RutaImagen NVARCHAR(MAX)
AS
BEGIN
    UPDATE Producto
    SET 
        Nombre = @Nombre,
        Cantidad = @Cantidad,
        Descripcion = @Descripcion,
        PrecioUnitarioColones = @PrecioUnitarioColones,
		PrecioUnitarioDolares = @PrecioUnitarioDolares,
		PorcentajeVenta = @PorcentajeVenta,
		Prompt = @Prompt,
        RutaImagen = @RutaImagen,
        CategoriaId = @CategoriaId
    WHERE 
        IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaCotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutaCotizacion]
    @idCotizacion BIGINT,
    @downloadURL NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Cotizacion
    SET RutaCotizacion = @downloadURL
    WHERE IdCotizacion = @idCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenBoceto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutaImagenBoceto]
    @IdBoceto BIGINT,
    @RutaImagen VARCHAR(MAX)
AS
BEGIN
    UPDATE Boceto
    SET RutaImagen = @RutaImagen
    WHERE IdBoceto = @IdBoceto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenProducto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutaImagenProducto]
    @IdProducto BIGINT,
    @RutaImagen NVARCHAR(MAX)
AS
BEGIN
    UPDATE Producto
    SET 
        RutaImagen = @RutaImagen
    WHERE 
        IdProducto = @IdProducto;
END;

GO
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarProducto]
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @PrecioUnitarioColones DECIMAL(18, 2),
	@PrecioUnitarioDolares DECIMAL(18, 2),
	@Prompt VARCHAR(MAX),
    @CategoriaId BIGINT
AS
BEGIN
    INSERT INTO Producto (
        Nombre,
        Cantidad,
        Descripcion,
        PrecioUnitarioColones,
		PrecioUnitarioDolares,
		Prompt,
		PorcentajeVenta,
        CategoriaId,
        RutaImagen
    ) 
    VALUES (
        @Nombre, 
        @Cantidad, 
        @Descripcion, 
        @PrecioUnitarioColones, 
		@PrecioUnitarioDolares,
		@Prompt,
		13.00,
        @CategoriaId, 
        ''
    );

    SELECT 
        CONVERT(BIGINT, @@IDENTITY) AS IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[CambiarContrasenna]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CambiarContrasenna]
	@UsuarioId			BIGINT,
	@NuevaContrasenna	varchar(255)
AS
BEGIN
	UPDATE Usuario
	SET Contrasenna = @NuevaContrasenna
	WHERE	UsuarioId = @UsuarioId
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosAdmin]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarBocetosAdmin]
AS
BEGIN
	SELECT 
        B.IdBoceto,
        B.IdProducto,
        B.IdUsuario,
        B.FechaCreacion,
        B.RutaImagen,
        B.PromptUsado,
        B.PromptOriginal,
        P.Nombre AS NombreProducto,
        U.NombreCompleto AS NombreUsuario
    FROM 
        Boceto B
    INNER JOIN 
        Producto P ON B.IdProducto = P.IdProducto
    INNER JOIN 
        Usuario U ON B.IdUsuario = U.UsuarioId
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosCliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarBocetosCliente]
	@IdUsuario BIGINT
AS
BEGIN
	SELECT 
        B.IdBoceto,
        B.IdProducto,
        B.IdUsuario,
        B.FechaCreacion,
        B.RutaImagen,
        B.PromptUsado,
        B.PromptOriginal,
        P.Nombre AS NombreProducto
    FROM 
        Boceto B
    INNER JOIN 
        Producto P ON B.IdProducto = P.IdProducto
    WHERE 
        B.IdUsuario = @IdUsuario;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionesAdmin]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionesAdmin]
AS
BEGIN
    SELECT 
        IdCotizacion,
        IdUsuario,
		U.NombreCompleto as NombreCompleto,
        IdSolicitudCotizacion,
        RutaCotizacion,
        SubTotal,
        Impuesto,
        Total,
        FechaCreacion,
        C.Estado,
        Descripcion
    FROM Cotizacion C
	INNER JOIN Usuario U ON U.UsuarioId = C.IdUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionesUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionesUsuario]
    @IdUsuario INT
AS
BEGIN
    SELECT 
        IdCotizacion,
        Descripcion,
        RutaCotizacion,
        FechaCreacion
    FROM Cotizacion
    WHERE IdUsuario = @IdUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionAdmin]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarDetalleSolicitudCotizacionAdmin]
    @IdSolicitudCotizacion BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT S.IdSolicitudCotizacion,  
	S.Descripcion, 
	S.FechaCreacion,       
	S.Estado,
	Moneda,
	u.NombreCompleto as 'NombreCliente'
    FROM Solicitud_Cotizacion S
	INNER JOIN Usuario U ON IdUsuario = U.UsuarioId
    WHERE 
        IdSolicitudCotizacion = @IdSolicitudCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionCliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarDetalleSolicitudCotizacionCliente]
    @IdSolicitudCotizacion BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        IdSolicitudCotizacion,
        Descripcion,
        FechaCreacion,
		Moneda,
        Estado 
    FROM 
        dbo.Solicitud_Cotizacion
    WHERE 
        IdSolicitudCotizacion = @IdSolicitudCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPerfilUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarPerfilUsuario] 
@idusuario bigint
AS
BEGIN
    SELECT [UsuarioId]
      ,[NombreCompleto]
      ,[Identificacion]
      ,[CorreoElectronico]
      ,[NumeroTelefono]
      ,[DireccionExacta]
      ,[Contrasenna]
      ,[Estado]
      ,rol.Nombre as NombreRol

  FROM [dbo].[Usuario] users
  inner join  Rol rol on users.IdRol=rol.IdRol

  where users.UsuarioId=@idusuario
END


GO
/****** Object:  StoredProcedure [dbo].[ConsultarProducto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarProducto]
    @IdProducto BIGINT 
AS
BEGIN
    SELECT 
        P.IdProducto,
        P.Nombre,
		P.Cantidad,
        P.Descripcion,
        P.PrecioUnitarioColones,
		P.PrecioUnitarioDolares,
		P.PorcentajeVenta,
        P.RutaImagen,
		P.Prompt,
        P.CategoriaId,
        C.Nombre AS 'NombreCategoria'
    FROM Producto P
    INNER JOIN Categoria C ON C.CategoriaId = P.CategoriaId
    WHERE P.IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarProductos]
AS
BEGIN
    SELECT 
        P.IdProducto,
        P.Nombre,
		P.Cantidad,
        P.Descripcion,
        P.PrecioUnitarioColones,
		P.PrecioUnitarioDolares,
		P.PorcentajeVenta,
        P.RutaImagen,
		P.Prompt,
        P.CategoriaId,
        C.Nombre AS 'NombreCategoria'
    FROM 
        Producto P
    INNER JOIN 
        Categoria C ON C.CategoriaId = P.CategoriaId;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductosCliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarProductosCliente]
	@NumPagina INT,
    @TamannoPagina INT,
    @Busqueda NVARCHAR(100) = NULL
AS
BEGIN
    SELECT 
        P.IdProducto,
        P.Nombre,
		P.Cantidad,
        P.Descripcion,
        P.PrecioUnitarioColones,
        P.RutaImagen,
        P.CategoriaId,
		P.Prompt,
        C.Nombre AS 'NombreCategoria'
    FROM 
        Producto P
    INNER JOIN 
        Categoria C ON C.CategoriaId = P.CategoriaId
		WHERE (@Busqueda IS NULL OR Descripcion LIKE '%' + @Busqueda + '%')
		ORDER BY IdProducto
		OFFSET (@NumPagina - 1) * @TamannoPagina ROWS
		FETCH NEXT @TamannoPagina ROWS ONLY;

	SELECT COUNT(*) AS TotalProductos
    FROM Producto
    WHERE (@Busqueda IS NULL OR Descripcion LIKE '%' + @Busqueda + '%');
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesAdmin]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarSolicitudesCotizacionesAdmin]
AS
BEGIN
    SELECT S.IdSolicitudCotizacion, 
	S.IdUsuario, 
	S.Descripcion, 
	S.FechaCreacion,  
	Moneda,
	S.Estado,
	u.NombreCompleto as 'NombreCliente'
    FROM Solicitud_Cotizacion S
	INNER JOIN Usuario U ON IdUsuario = U.UsuarioId
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesCliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarSolicitudesCotizacionesCliente]
@IdUsuario int
AS
BEGIN
    SELECT IdSolicitudCotizacion, 
	IdUsuario, 
	Descripcion, 
	FechaCreacion,       
	Estado,
	Moneda
    FROM dbo.Solicitud_Cotizacion
    WHERE IdUsuario = @IdUsuario
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTiposCategorias]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarTiposCategorias]
AS
BEGIN
    SELECT CategoriaId 'value'
          , Nombre 'text'
      FROM Categoria
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTiposRoles]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[ConsultarTiposRoles]
AS
BEGIN
    SELECT IdRol 'value'
          ,Nombre 'text'
      FROM Rol
END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorId]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarUsuarioPorId]
    @UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Usuario -- Asegúrate de que este sea el nombre de tu tabla de usuarios
    WHERE UsuarioId = @UsuarioId; -- Suponiendo que UsuarioId es la clave primaria
END

GO
/****** Object:  StoredProcedure [dbo].[CrearCotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearCotizacion]
    @IdUsuario BIGINT,
    @IdSolicitudCotizacion BIGINT,
    @RutaCotizacion NVARCHAR(MAX),
    @SubTotal DECIMAL(18, 2),
    @Impuesto DECIMAL(18, 2),
    @Total DECIMAL(18, 2),
    @FechaCreacion DATETIME,
    @Estado INT,
    @Descripcion NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cotizacion (
        IdUsuario,
        IdSolicitudCotizacion,
        RutaCotizacion,
        SubTotal,
        Impuesto,
        Total,
        FechaCreacion,
        Estado,
        Descripcion
    )
    VALUES (
        @IdUsuario,
        @IdSolicitudCotizacion,
        @RutaCotizacion,
        @SubTotal,
        @Impuesto,
        @Total,
        @FechaCreacion,
        @Estado,
        @Descripcion
    );

    SELECT SCOPE_IDENTITY() AS IdCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearCotizacionDetalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearCotizacionDetalle]
    @IdCotizacion BIGINT,
    @IdBoceto BIGINT,
    @Cantidad INT,
    @PrecioUnitarioColones DECIMAL(18, 2),
    @PrecioUnitarioDolares DECIMAL(18, 2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar el detalle en la tabla Cotizacion_Detalle
    INSERT INTO Cotizacion_Detalle (
        IdCotizacion,
        IdBoceto,
        Cantidad,
        PrecioUnitarioColones,
        PrecioUnitarioDolares
    )
    VALUES (
        @IdCotizacion,
        @IdBoceto,
        @Cantidad,
        @PrecioUnitarioColones,
        @PrecioUnitarioDolares
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearCotizacionVista]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearCotizacionVista]
    @IdSolicitudCotizacion BIGINT
AS
BEGIN
    -- Consulta 1: Información del Usuario
    SELECT 
        u.UsuarioId,
        u.NombreCompleto,
        u.CorreoElectronico,
        u.NumeroTelefono
    FROM Usuario u
    INNER JOIN Solicitud_Cotizacion sc ON u.UsuarioId = sc.IdUsuario
    WHERE sc.IdSolicitudCotizacion = @IdSolicitudCotizacion;

    -- Consulta 2: Información de la Solicitud de Cotización
    SELECT 
        IdSolicitudCotizacion,
        Descripcion,
        FechaCreacion,
		Moneda,
		Estado
    FROM Solicitud_Cotizacion
    WHERE IdSolicitudCotizacion = @IdSolicitudCotizacion;

    -- Consulta 3: Información de los Bocetos
    SELECT 
        scd.IdBoceto,
        scd.Cantidad,
        scd.DescripcionUsuario,
        b.FechaCreacion,
        b.RutaImagen,
        p.IdProducto,
        p.Nombre AS NombreProducto,
        c.Nombre AS NombreCategoria,
        p.PrecioUnitarioColones,
        p.PrecioUnitarioDolares,
		p.PorcentajeVenta,
        p.RutaImagen AS RutaImagenProducto,
        p.Cantidad AS CantidadInventario
    FROM Solicitud_Cotizacion_Detalle scd
    INNER JOIN Boceto b ON scd.IdBoceto = b.IdBoceto
    INNER JOIN Producto p ON b.IdProducto = p.IdProducto
    INNER JOIN Categoria c ON p.CategoriaId = c.CategoriaId
    WHERE scd.IdSolicitudCotizacion = @IdSolicitudCotizacion;

END;
GO
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearSolicitudCotizacion]
    @IdUsuario INT,
    @Descripcion NVARCHAR(MAX),
    @Estado TINYINT = 1, -- Por defecto, estado activo
	@Moneda INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Solicitud_Cotizacion (IdUsuario, Descripcion, FechaCreacion, Estado, Moneda)
    VALUES (@IdUsuario, @Descripcion, GETDATE(), @Estado, @Moneda);

    SELECT 
        CONVERT(BIGINT, @@IDENTITY) AS IdSolicitudCotizacion;
    
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionDetalle]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearSolicitudCotizacionDetalle]
    @IdSolicitudCotizacion BIGINT,
    @IdBoceto BIGINT,
	@Cantidad INT,
	@DescripcionUsuario  VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Solicitud_Cotizacion_Detalle (IdSolicitudCotizacion, IdBoceto, Cantidad, DescripcionUsuario)
    VALUES (@IdSolicitudCotizacion, @IdBoceto,@Cantidad, @DescripcionUsuario);
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionVista]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearSolicitudCotizacionVista]
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        B.IdBoceto,
        B.IdProducto,
        B.IdUsuario,
        B.FechaCreacion,
        B.RutaImagen,
        B.PromptUsado,
        B.PromptOriginal,
		P.Nombre 'NombreProducto'
    FROM 
        Boceto B
	INNER JOIN Producto P ON P.IdProducto = B.IdProducto
    WHERE 
        IdUsuario = @IdUsuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[EditarUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditarUsuario]
    @UsuarioId bigint,
	@IdRol bigint,
	@Identificacion VARCHAR(50),
    @NombreCompleto VARCHAR(100),
    @NombreEmpresa VARCHAR(100),
    
    @NumeroTelefono VARCHAR(15),
    @CorreoElectronico VARCHAR(100),
    
	@DireccionExacta VARCHAR(255),
	@Estado BIT
	
AS
BEGIN
    
    UPDATE Usuario
    SET 
        NombreCompleto = @NombreCompleto,
        NombreEmpresa = @NombreEmpresa,
        Identificacion = @Identificacion,
        NumeroTelefono = @NumeroTelefono,
        CorreoElectronico = @CorreoElectronico,
        IdRol = @IdRol,
		DireccionExacta = @DireccionExacta
    WHERE UsuarioId = @UsuarioId;

END

GO
/****** Object:  StoredProcedure [dbo].[EliminarPerfilUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarPerfilUsuario]
    @UsuarioId BIGINT
AS
BEGIN
        DELETE FROM [dbo].[Usuario]
        WHERE UsuarioId = @UsuarioId;
END


GO
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarProducto]
    @IdProducto BIGINT
AS
BEGIN
    DELETE FROM Producto
    WHERE IdProducto = @IdProducto;
END;

GO
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarUsuario]
@Id bigint
AS
BEGIN

DELETE FROM Usuario
      WHERE UsuarioId = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[GenerarBoceto]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerarBoceto]
    @IdProducto BIGINT,
    @IdUsuario BIGINT,
    @FechaCreacion DATETIME,
    @PromptUsado VARCHAR(MAX) = NULL,
    @PromptOriginal VARCHAR(MAX) = NULL,
    @IdBoceto INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Boceto (IdProducto, IdUsuario, RutaImagen, FechaCreacion, PromptUsado, PromptOriginal)
    VALUES (@IdProducto, @IdUsuario, '',@FechaCreacion, @PromptUsado, @PromptOriginal);

    SET @IdBoceto = SCOPE_IDENTITY(); 

    UPDATE Usuario
    SET BocetosGenerados = ISNULL(BocetosGenerados, 0) + 1
    WHERE UsuarioId = @IdUsuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IniciarSesion]
	@CorreoElectronico			varchar(255),
	@Contrasenna	varchar(255)
AS
BEGIN
	SELECT UsuarioId, Identificacion, NombreCompleto, CorreoElectronico, U.IdRol, Estado, R.Nombre 'NombreRol',EsTemporal, VigenciaTemporal
	FROM Usuario U
	INNER JOIN Rol R ON U.IdRol = R.IdRol
	WHERE	CorreoElectronico = @CorreoElectronico
	AND		Contrasenna = @Contrasenna
	AND		Estado = 1
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerBocetosPorSolicitud]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerBocetosPorSolicitud]
    @IdSolicitudCotizacion BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.IdBoceto,
		b.IdProducto,
        b.RutaImagen,
        p.Nombre AS 'NombreProducto',
        b.FechaCreacion,
        d.DescripcionUsuario ,
        d.Cantidad
		FROM 
        dbo.Solicitud_Cotizacion_Detalle d
    INNER JOIN 
        dbo.Boceto b ON d.IdBoceto = b.IdBoceto
	INNER JOIN 
		Producto p ON  b.IdProducto = p.IdProducto
    WHERE 
        d.IdSolicitudCotizacion = @IdSolicitudCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerDetalleCotizacion]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerDetalleCotizacion]
    @IdCotizacion BIGINT
AS
BEGIN
    -- Consulta 1: Información del Usuario
    SELECT 
        u.UsuarioId,
        u.NombreCompleto,
        u.CorreoElectronico,
        u.NumeroTelefono
    FROM Usuario u
    INNER JOIN Cotizacion c ON u.UsuarioId = c.IdUsuario
    WHERE c.IdCotizacion = @IdCotizacion;

    -- Consulta 2: Información de la Cotización
    SELECT 
        c.IdCotizacion,
        c.Descripcion,
        c.Subtotal,
        c.Impuesto,
        c.Total,
        c.FechaCreacion,
        c.Estado,
		sc.Moneda,
		c.RutaCotizacion
    FROM Cotizacion c
	INNER JOIN Solicitud_Cotizacion sc ON sc.IdSolicitudCotizacion = c.IdSolicitudCotizacion
    WHERE c.IdCotizacion = @IdCotizacion;

    -- Consulta 3: Información de los Bocetos en la Cotización
    SELECT 
        cd.IdBoceto,
        cd.Cantidad,
        b.FechaCreacion,
        b.RutaImagen,
        p.IdProducto,
        p.Nombre AS NombreProducto,
        c.Nombre AS NombreCategoria,
        cd.PrecioUnitarioColones,
        cd.PrecioUnitarioDolares,
        p.PorcentajeVenta,
        p.RutaImagen AS RutaImagenProducto,
        p.Cantidad AS CantidadInventario
    FROM Cotizacion_Detalle cd
    INNER JOIN Boceto b ON cd.IdBoceto = b.IdBoceto
    INNER JOIN Producto p ON b.IdProducto = p.IdProducto
    INNER JOIN Categoria c ON p.CategoriaId = c.CategoriaId
    WHERE cd.IdCotizacion = @IdCotizacion;

END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerListaUsuarios]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerListaUsuarios]
AS
BEGIN
    SET NOCOUNT ON;

    -- Seleccionar todos los usuarios
    SELECT 
		UsuarioId,
        NombreCompleto,
        Identificacion,
        CorreoElectronico,
        NumeroTelefono,
        DireccionExacta,
        NombreEmpresa,
        U.IdRol,
        Estado,
        EsTemporal,
        VigenciaTemporal,
		R.Nombre 'NombreRol'

    FROM 
        dbo.Usuario U
		INNER JOIN Rol R ON U.IdRol = R.IdRol
END

GO
/****** Object:  StoredProcedure [dbo].[RecuperaContrasennaCodigo]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RecuperaContrasennaCodigo]

@Codigo varchar(50),
@HoraActual datetime,
@CorreoElectronico VARCHAR(50),
@Contrasenna VARCHAR(50)
AS
BEGIN

	IF EXISTS (SELECT 1 
               FROM Usuario 
               WHERE Contrasenna = @Codigo 
               AND @HoraActual < VigenciaTemporal 
               AND CorreoElectronico = @CorreoElectronico)
    BEGIN
        
        UPDATE Usuario
        SET 
            Contrasenna = @Contrasenna,
            EsTemporal = 0, 
            VigenciaTemporal = @HoraActual
        WHERE CorreoElectronico = @CorreoElectronico;
END
END

GO
/****** Object:  StoredProcedure [dbo].[Recuperar]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Recuperar] 
	
	@CorreoElectronico varchar(50),
	@CodigoEncriptado varchar(50),
	@EsTemporal BIT,
	@VigenciaTemporal datetime
AS
BEGIN
	IF EXISTS(SELECT 1 from usuario where CorreoElectronico = @CorreoElectronico)
	BEGIN
		UPDATE Usuario SET 
		Contrasenna = @CodigoEncriptado,
		EsTemporal = @EsTemporal,
		VigenciaTemporal = @VigenciaTemporal
		where CorreoElectronico = @CorreoElectronico
	END
	select CorreoElectronico, NombreCompleto from usuario where CorreoElectronico = @CorreoElectronico
END

GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarUsuario]
	@NombreCompleto   varchar(255),
	@Identificacion   varchar(255),
	@CorreoElectronico           varchar(255),
	@NumeroTelefono         varchar(255),
	@DireccionExacta        varchar(255),
	@Contrasenna      varchar(255),
	@NombreEmpresa varchar(255)
AS
BEGIN
	DECLARE @Rol   TINYINT = 3,
            @Estado BIT    = 1,
			@Temporal BIT  = 0
	
	IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE CorreoElectronico = @CorreoElectronico OR Identificacion = @Identificacion)
	BEGIN
		INSERT INTO dbo.Usuario(NombreCompleto, Identificacion, CorreoElectronico, NumeroTelefono, DireccionExacta, Contrasenna,NombreEmpresa, IdRol, Estado, EsTemporal, VigenciaTemporal)
		VALUES(@NombreCompleto, @Identificacion, @CorreoElectronico, @NumeroTelefono, @DireccionExacta, @Contrasenna, @NombreEmpresa, @Rol, @Estado, @Temporal, GETDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Detalles_Cliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_Detalles_Cliente]
(
	@identificacion varchar(100)
)
AS
BEGIN
    BEGIN TRY
        -- Validar si hay clientes registrados
        IF NOT EXISTS (SELECT 1 FROM Usuario)
        BEGIN
            SELECT 'no hay clientes' AS MENSAJE
        END
        
        -- Seleccionar los detalles de los clientes
        SELECT	T0.Identificacion, T0.NombreCompleto, T0.CorreoElectronico, T0.NumeroTelefono  , T0.DireccionExacta, 
				CASE WHEN T0.Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS Estado, T0.NombreEmpresa , 
				CASE WHEN T0.EsTemporal = 1 THEN 'Si' ELSE 'No' END AS EsTemporal , T0.VigenciaTemporal
          FROM Usuario T0
		  WHERE T0.Identificacion = @identificacion
        
    END TRY
    BEGIN CATCH
        -- Manejar cualquier error inesperado
        SELECT 'error inesperado' AS MENSAJE
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_EliminarCliente](
    @ID_Cliente VARCHAR(100) --Recibe la identificacion del cliente 
)
AS
BEGIN
    BEGIN TRY
        -- Validar si el cliente existe
        IF NOT EXISTS (SELECT Identificacion 
						 FROM Usuario 
						WHERE Identificacion = @ID_Cliente)
        BEGIN
            SELECT 'no existe cliente' AS MENSAJE
        END

        -- Eliminar el cliente
        DELETE FROM Usuario
        WHERE Identificacion = @ID_Cliente;

        SELECT 'cliente eliminado correctamente' AS MENSAJE

    END TRY
    BEGIN CATCH
        -- Manejar cualquier error inesperado
        SELECT 'error inesperado' AS MENSAJE
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_ListarClientes] AS
BEGIN
    BEGIN TRY

 -- Validar si hay clientes registrados
        IF NOT EXISTS (SELECT 1 FROM dbo.Usuario)
        BEGIN
            RETURN 'no hay clientes'
        END   
		
-- Selección de clientes
        SELECT T0.Identificacion, T0.UsuarioId, T0.NombreCompleto, T0.CorreoElectronico, T1.Nombre AS Rol, T0.Estado
          FROM dbo.Usuario T0
         INNER JOIN dbo.rol T1 ON T1.IdRol = T0.IdRol
		 WHERE T1.Nombre = 'Cliente' 
    END TRY
    BEGIN CATCH

-- Manejar cualquier error inesperado
        RETURN 'error inesperado'
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[ValidarContrasennaActual]    Script Date: 2/12/2024 23:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidarContrasennaActual]
	@UsuarioId			BIGINT,
	@Contrasenna	varchar(255)
AS
BEGIN
	SELECT UsuarioId
	FROM Usuario 
	WHERE	Contrasenna = @Contrasenna
END
GO
USE [master]
GO
ALTER DATABASE [BigSolutions] SET  READ_WRITE 
GO
