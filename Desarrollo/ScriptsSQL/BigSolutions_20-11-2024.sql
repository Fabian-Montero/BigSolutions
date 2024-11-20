USE [master]
GO
/****** Object:  Database [BigSolutions]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Boceto]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[IdCategoria] [bigint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Correos_Electronicos]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos_Detalle]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Cotizacion]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizacion](
	[IdCotizacion] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdSolicitudCotizacion] [bigint] NULL,
	[RutaCotizacion] [varchar](max) NULL,
	[SubTotal] [decimal](18, 0) NULL,
	[Impuesto] [decimal](5, 2) NULL,
	[Total] [decimal](18, 0) NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cotizacion_Detalle]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizacion_Detalle](
	[IdCotizacionDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCotizacion] [bigint] NULL,
	[IdBoceto] [bigint] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnitarioColones] [decimal](18, 0) NULL,
	[PrecioUnitarioDolares] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Cotizacion_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdCotizacionDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo_Usuarios]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios_Detalle]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden_Cotizacion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Bocetos]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Comprobantes]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Cotizacion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Factura_Pendiente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 20/11/2024 17:36:54 ******/
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
	[PrecioUnitarioColones] [decimal](18, 0) NULL,
	[PrecioUnitarioDolares] [decimal](18, 0) NULL,
	[PorcentajeVenta] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion_Detalle]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 20/11/2024 17:36:54 ******/
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
SET IDENTITY_INSERT [dbo].[Boceto] OFF
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (1, N'Categoría 1')
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (2, N'Categoría 2')
GO
SET IDENTITY_INSERT [dbo].[Cotizacion] ON 
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (2, 7, 10017, N'', CAST(316 AS Decimal(18, 0)), CAST(41.08 AS Decimal(5, 2)), CAST(357 AS Decimal(18, 0)), CAST(N'2024-11-20T16:38:34.620' AS DateTime), 1, N'sss')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (7, 6, 10016, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F7?alt=media&token=95b6410e-e4ae-4041-bd6b-558dda8e72b9', CAST(2640 AS Decimal(18, 0)), CAST(343.20 AS Decimal(5, 2)), CAST(2983 AS Decimal(18, 0)), CAST(N'2024-11-20T17:21:06.267' AS DateTime), 1, N'sss')
GO
INSERT [dbo].[Cotizacion] ([IdCotizacion], [IdUsuario], [IdSolicitudCotizacion], [RutaCotizacion], [SubTotal], [Impuesto], [Total], [FechaCreacion], [Estado], [Descripcion]) VALUES (8, 7, 10017, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/cotizaciones%2F8?alt=media&token=e2b55a5e-72b9-45f0-8811-57524bb8d183', CAST(308 AS Decimal(18, 0)), CAST(40.04 AS Decimal(5, 2)), CAST(348 AS Decimal(18, 0)), CAST(N'2024-11-20T17:31:51.977' AS DateTime), 1, N'Cotizacion Meli')
GO
SET IDENTITY_INSERT [dbo].[Cotizacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Cotizacion_Detalle] ON 
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (1, 2, 10030, 34, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (2, 2, 10028, 45, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (3, 7, 10020, 312, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (4, 7, 10019, 324, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (5, 7, 10027, 12, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (6, 7, 10026, 12, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (7, 8, 10030, 32, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cotizacion_Detalle] ([IdCotizacionDetalle], [IdCotizacion], [IdBoceto], [Cantidad], [PrecioUnitarioColones], [PrecioUnitarioDolares]) VALUES (8, 8, 10028, 45, CAST(4 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Cotizacion_Detalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (42, 1, N'Botella negra', N'Botella negra de alumio', 45, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F42?alt=media&token=d93d0d44-a399-494c-92a2-e0649d3d2d3e', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting', CAST(2000 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (43, 2, N'Prueba 2', N'Prueba 2', 45, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F43?alt=media&token=a5773c66-f37a-4047-92a8-4a7c5cce4002', N's', CAST(3000 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (45, 1, N'Prueba 3', N'Prueba 3', 45, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F45?alt=media&token=536b8eea-34f5-48c3-8761-f225f7f8c31d', N's', CAST(5000 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (47, 1, N'Prueba 4', N'Prueba 4', 3452, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F47?alt=media&token=8b394ef4-7218-4349-b2cf-79194c667c99', N's', CAST(10000 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (49, 1, N'Prueba 5', N'Prueba 5', 342, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F49?alt=media&token=337344c9-f049-45a9-939e-9f1241b1d07a', N's', CAST(12000 AS Decimal(18, 0)), CAST(24 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [RutaImagen], [Prompt], [PrecioUnitarioColones], [PrecioUnitarioDolares], [PorcentajeVenta]) VALUES (50, 1, N'Prueba 6', N'Prueba 6', 45, N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F50?alt=media&token=3e480f7f-c365-4a76-a883-db819da17b98', N's', CAST(5000 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), CAST(13.00 AS Decimal(5, 2)))
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
SET IDENTITY_INSERT [dbo].[Solicitud_Cotizacion_Detalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (6, 1, N'118560019', N'Fabian Josue Montero Madrigal', N'fabianja0477@gmail.com', N'84955721', N'Vázquez de Coronado, Barrio el Carmen', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-11-17T23:12:57.420' AS DateTime), 41)
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (7, 3, N'402510174', N'Melissa Vargas Gómez', N'mv213845@gmail.com', N'87963587', N'Mercedes Norte, Heredia', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-10-13T11:47:14.553' AS DateTime), 4)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
/****** Object:  Index [IX_Cotizacion]    Script Date: 20/11/2024 17:36:54 ******/
CREATE NONCLUSTERED INDEX [IX_Cotizacion] ON [dbo].[Cotizacion]
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1_2]    Script Date: 20/11/2024 17:36:54 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1_2] ON [dbo].[Usuario]
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 20/11/2024 17:36:54 ******/
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
REFERENCES [dbo].[Categoria] ([IdCategoria])
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
/****** Object:  StoredProcedure [dbo].[ActualizarPerfilUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarProducto]
    @IdProducto BIGINT,
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @PrecioUnitarioColones DECIMAL(18, 0),
	@PrecioUnitarioDolares DECIMAL(18, 0),
	@PorcentajeVenta DECIMAL(5,2),
	@Prompt VARCHAR(MAX),
    @IdCategoria BIGINT,
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
        CategoriaId = @IdCategoria
    WHERE 
        IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaCotizacion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenBoceto]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenProducto]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarProducto]
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @PrecioUnitarioColones DECIMAL(18, 0),
	@PrecioUnitarioDolares DECIMAL(18, 0),
	@Prompt VARCHAR(MAX),
    @IdCategoria BIGINT
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
        @IdCategoria, 
        ''
    );

    SELECT 
        CONVERT(BIGINT, @@IDENTITY) AS IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[CambiarContrasenna]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosAdmin]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosCliente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionAdmin]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionCliente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarPerfilUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProducto]    Script Date: 20/11/2024 17:36:54 ******/
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
    INNER JOIN Categoria C ON C.IdCategoria = P.CategoriaId
    WHERE P.IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 20/11/2024 17:36:54 ******/
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
        Categoria C ON C.IdCategoria = P.CategoriaId;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductosCliente]    Script Date: 20/11/2024 17:36:54 ******/
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
        Categoria C ON C.IdCategoria = P.CategoriaId
		WHERE (@Busqueda IS NULL OR Descripcion LIKE '%' + @Busqueda + '%')
		ORDER BY IdProducto
		OFFSET (@NumPagina - 1) * @TamannoPagina ROWS
		FETCH NEXT @TamannoPagina ROWS ONLY;

	SELECT COUNT(*) AS TotalProductos
    FROM Producto
    WHERE (@Busqueda IS NULL OR Descripcion LIKE '%' + @Busqueda + '%');
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesAdmin]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesCliente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposCategorias]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarTiposCategorias]
AS
BEGIN
    SELECT IdCategoria 'value'
          , Nombre 'text'
      FROM Categoria
END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarTiposRoles]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorId]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearCotizacion]    Script Date: 20/11/2024 17:36:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearCotizacion]
    @IdUsuario BIGINT,
    @IdSolicitudCotizacion BIGINT,
    @RutaCotizacion NVARCHAR(MAX),
    @SubTotal DECIMAL(18, 2),
    @Impuesto DECIMAL(5, 2),
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
/****** Object:  StoredProcedure [dbo].[CrearCotizacionDetalle]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearCotizacionVista]    Script Date: 20/11/2024 17:36:54 ******/
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
    INNER JOIN Categoria c ON p.CategoriaId = c.IdCategoria
    WHERE scd.IdSolicitudCotizacion = @IdSolicitudCotizacion;

END;
GO
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionDetalle]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionVista]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarPerfilUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[GenerarBoceto]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerBocetosPorSolicitud]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerListaUsuarios]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[RecuperaContrasennaCodigo]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[Recuperar]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Detalles_Cliente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 20/11/2024 17:36:54 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarContrasennaActual]    Script Date: 20/11/2024 17:36:54 ******/
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
