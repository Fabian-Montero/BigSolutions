USE [master]
GO
/****** Object:  Database [BigSolutions]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Boceto]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos_Detalle]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios_Detalle]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden_Cotizacion]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Bocetos]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Comprobantes]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Cotizacion]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Factura_Pendiente]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 30/10/2024 17:28:25 ******/
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
	[Precio] [decimal](18, 0) NOT NULL,
	[RutaImagen] [nvarchar](max) NOT NULL,
	[Prompt] [varchar](max) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 30/10/2024 17:28:25 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion]    Script Date: 30/10/2024 17:28:25 ******/
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
 CONSTRAINT [PK_Solicitud_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitud_Cotizacion_Detalle]    Script Date: 30/10/2024 17:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_Cotizacion_Detalle](
	[IdSolicitudCotizacionDetalle] [bigint] NOT NULL,
	[IdSolicitudCotizacion] [bigint] NOT NULL,
	[IdBoceto] [bigint] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL,
 CONSTRAINT [PK_Solicitud_Cotizacion_Detalle] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacionDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 30/10/2024 17:28:25 ******/
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
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (1, 42, 6, CAST(N'2024-10-30T06:16:42.477' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-fo0aDbPHzg6IGGN6fjup1W2D.png?st=2024-10-30T05%3A16%3A17Z&se=2024-10-30T07%3A16%3A17Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A18%3A06Z&ske=2024-10-31T00%3A18%3A06Z&sks=b&skv=2024-08-04&sig=I%2BgnatL3oU/5xFTSJg4r0tq3vOEoY8c3%2Bgx3gPnb3l8%3D', N'Imagine a cylindrical bottle of minimalist design made of metal, likely aluminum. It has a matte black finish, smooth with no reflectivity. The bottle is free of any labels or logos and has a screw-top cap, also black, with a slightly ribbed edge to provide a strong grip. The bottle is tall and slender, with an elongated and sleek look. Set against a plain white background, the bottle stands out with all its elegancy. The lighting is soft, causing nearly no shadows, except for a faint one at the bottom creating a subtle floating effect. Inscribe on the middle of the bottle is a prominent white-colored hourglass logo, covering approximately 30% of the bottle''s front -- blending neatly with the texture of the bottle, as if printed or embedded onto it, without any 3D or raised effects. Maintain the overall neat and uncluttered aesthetic of the scene with the soft and even lighting, highlighting the bottle, its design, and the logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Reloj de arena en color blanco''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (2, 42, 6, CAST(N'2024-10-30T06:21:49.327' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-yUc8LeQuSGh0hoZ6E5VlHCYm.png?st=2024-10-30T05%3A21%3A34Z&se=2024-10-30T07%3A21%3A34Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A21%3A40Z&ske=2024-10-31T00%3A21%3A40Z&sks=b&skv=2024-08-04&sig=5lRaCthEGM%2B5ykw%2BeE1VmHdbqGXqfaSchTx9pwg2RO0%3D', N'Imagine a tall, cylindrical bottle made of metal, possibly aluminum, with a completely matte black finish. The bottle appears sleek and elongated due to its greater height-to-width ratio. It has a minimalist, elegantly simple design with no labels, and features a screw-top cap that is also black with a slightly ribbed edge for better grip. The bottle stands out against a smooth, plain white background with diffused, soft lighting and a faint, subtle shadow underneath, giving it a slightly floating effect. On the bottle''s surface, imagine a centrally positioned logo depicting a black and white soccer ball. This logo covers approximately 30% of the bottle''s front area. It blends harmoniously with the bottle''s texture, appearing as if printed or embedded directly onto its surface without any three-dimensional or raised effects. The logo, like the bottle, is accentuated with soft, even lighting.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Bola de futbol en color blanco con negro''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (3, 42, 6, CAST(N'2024-10-30T06:25:57.643' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-gOrubAOBLrcRyS20oVprIKFV.png?st=2024-10-30T05%3A26%3A02Z&se=2024-10-30T07%3A26%3A02Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A17%3A08Z&ske=2024-10-31T00%3A17%3A08Z&sks=b&skv=2024-08-04&sig=9N3NcE1zq/sr6z772FwabOHpBbFkeCAoVhP09t9Ej/U%3D', N'Create an image of a tall, slender cylindrical bottle made from aluminum with a completely matte black finish. Its surface is smooth and non-reflective. The bottle lacks labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge for better grip. Against a plain white and smooth background with no noticeable shadows or distractions, place the bottle at the center of the composition. Lighting is soft and even, eliminating almost all shadows and subtly highlighting the matte finish. A faint, diffuse shadow is present at the bottom of the bottle. To further the design, incorporate a logo onto the center of the product. This logo design should be of a white baseball and covers 30% of its front area. Ensure the logo blends with the product''s texture as if printed or embedded directly onto it without any 3D or raised effects and maintains a flat appearance. The final image should have a white, uncluttered background and soft, even lighting that highlights both the product and the logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Bola de baseball blanca''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (4, 42, 6, CAST(N'2024-10-30T06:27:14.847' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-MAaBGEkiDa7ecmm6zhTt70oN.png?st=2024-10-30T05%3A27%3A19Z&se=2024-10-30T07%3A27%3A19Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A14%3A33Z&ske=2024-10-31T00%3A14%3A33Z&sks=b&skv=2024-08-04&sig=MWIogtEFwYmj%2BRNR1FwgK6X7stytoqhCtxMiHYWju/U%3D', N'Visualize a stylish, cylindrical, black matte-finished metal likely aluminum bottle. This is beautifully smooth and non-reflective with no labels or logos and caped with a ribbed edged screw top. This minimalist-designed pool captures elegance in its simplicity and understated looks. Its tall, slender shape defines a sleek and elongated view. The bottle sits at the heart of the composition, unshadowed against a plain white background. A subtlety soft diffuse shadow at the base gives it a touch of floating demeanor, enhancing a professional studio look. Central to the design of the product is the logo of a ''White baseball ball''. This is neatly printed right in the middle, maintaining a flat profile and occupying a prominence of about 30% of the front area. It’s tactically positioned to blend with the bottle''s texture giving it both visibility and aesthetics yet non-distractive allowing for the product''s original design to shine. The serene white backdrop retains focus on the product, eliminating any shadow distractions. A soft even light further accentuates the product and logo, preserving the product’s design as described.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''White baseball ball ''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (5, 42, 6, CAST(N'2024-10-30T06:28:10.960' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-Cvu9C7TLL9jhphtOC7S2Af5Q.png?st=2024-10-30T05%3A28%3A15Z&se=2024-10-30T07%3A28%3A15Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A19%3A30Z&ske=2024-10-31T00%3A19%3A30Z&sks=b&skv=2024-08-04&sig=lu0lJjcJLxLiwJ/z8/NUs2c5OnoWuJpF1Q35Ofh6I2c%3D', N'Design an image of a cylindrical bottle of greater height-to-width ratio made of a non-reflective matte black metal, possibly aluminum, with a smooth surface. The bottle is minimalist with no labels, except for a white minimalistic laptop logo positioned in the center of the product, covering about 30% of its front area. The logo appears as if it''s directly printed or embedded onto the product''s black surface. The product''s screw-top cap is also black with a slightly ribbed edge. The background is a clean and smooth white surface, with a faint diffused shadow underneath the bottle, giving an impression of a slight floating effect. The lighting is soft, evenly illuminating the product and subtly highlighting the matte finish of the bottle and the white laptop logo.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a laptop in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (6, 42, 6, CAST(N'2024-10-30T06:29:47.880' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-6vlUpDLe7pvnykbXPRqrEThm.png?st=2024-10-30T05%3A29%3A52Z&se=2024-10-30T07%3A29%3A52Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A23%3A39Z&ske=2024-10-31T00%3A23%3A39Z&sks=b&skv=2024-08-04&sig=1FSIMyM%2Bt8qd4Gb6G48N9PoNCE8058gfmH5NGJPFj6E%3D', N'Create a sleek and elegant image of a tall, slender, cylindrical bottle made of matte black metal, possibly aluminum. The bottle possesses a smooth, non-reflective surface with a screw-top lid that is also black and has a ribbed edge for improved grip. No labels or logos are apparent, portraying a minimalist and simple aesthetic. The background is plain and white, offering no distractions and making the black bottle the centerpiece. The lighting is subtle and even, rendering almost all shadows void, while casting a faint, diffuse shadow at the bottle''s base, giving it a floating effect. This all conveys a professional studio atmosphere. In the heart of the product, introduce a minimalist koala logo. The logo should be centered and cover nearly 30% of the bottle''s frontal area, ensuring visibility and aesthetical balance without affecting the principal design. The logo should seamlessly blend with the bottle''s texture, as if it was printed or embedded directly on it, with no 3D or raised effects. The logo should have a flat appearance. The background must remain white with no strong shadows or distracting elements, enabling the product and logo to stand out. The illumination must be soft, amplifying both the product and the logo, while staying true to the mentioned design specifics.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Imagen de un koala minimalista ''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (7, 42, 6, CAST(N'2024-10-30T06:30:53.830' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-paqZW5AF2t9S6EPfZxMeGX42.png?st=2024-10-30T05%3A30%3A58Z&se=2024-10-30T07%3A30%3A58Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A17%3A30Z&ske=2024-10-31T00%3A17%3A30Z&sks=b&skv=2024-08-04&sig=xa/bNiMy7tqKO5DOXfLBOoXuICfzrX4PAcOXKvVouSI%3D', N'Create an image that showcases a matte black, cylindrical bottle made of aluminum. The bottle is minimalist with a smooth texture, no labels, and no logos except for a centered white logo of a koala, which covers approximately 30% of its front. It has an elongated and sleek shape with a ribbed screw-top cap, all of which is also black. The image has a plain, non-reflective white background with soft, even lighting and a minimal, almost invisible shadow beneath the bottle that gives it a very subtle floating effect. The combined aesthetics materializes as an understated, professional studio setting and the koala logo must blend smoothly with the bottle''s texture, maintaining a flat appearance, without any three-dimensional or raised effects.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a koala in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (8, 42, 6, CAST(N'2024-10-30T06:33:19.173' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-wq09dKjMqQCOAaTEnFV1SqIh.png?st=2024-10-30T05%3A33%3A23Z&se=2024-10-30T07%3A33%3A23Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A24%3A25Z&ske=2024-10-31T00%3A24%3A25Z&sks=b&skv=2024-08-04&sig=y4Jt6aspjy9RNj7rzzs7Y/PmX7u42Xm9XFqxMNF5TTE%3D', N'Create an image of a sleek, cylindrical, aluminium bottle with a matte black finish. It has a smooth, non-reflective surface, embodying an elegant and minimalist design without any labels. The screw-top cap matches the body, colored black with a slightly ribbed edge for a better grip. The tall, slender shape of the bottle gives it an elongated look. Against a plain, white background, this black bottle stands out prominently. The lighting is soft, evenly cast, and mitigates almost all shadows except for a slightly noticeable diffuse shadow at the bottle''s bottom, suggesting a slight floating effect. Place a flat, white, generic logo at the center of the bottle, covering approximately 30% of its front area. The logo blends seamlessly with the bottle''s texture, as if printed directly on it, without any raised effects. The background remains uncluttered, spotlighting the product and logo interchangeably.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Adidas logo in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (9, 42, 6, CAST(N'2024-10-30T06:34:17.580' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-5rzS7Sgf9uZ22DE0JevroMeo.png?st=2024-10-30T05%3A34%3A22Z&se=2024-10-30T07%3A34%3A22Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A16%3A10Z&ske=2024-10-31T00%3A16%3A10Z&sks=b&skv=2024-08-04&sig=voishilXCM%2BQM7rIghHK3h7IvzYbfbL1/QLjSUj5R%2BY%3D', N'A cylindrical container with a sleek, matte finish, likely made of metal, possibly aluminum. The container is smooth and non-reflective without any labels, showcasing minimalist aesthetics. Its cap is a screw-top, colored black just like the container, with a lightly ribbed edge for better grip. The container boasts a tall, slim silhouette, exuding elegance in its elongated form. It''s placed against a plain, white background that exhibits no noticeable shadows. A soft, evenly distributed light enhances the container''s matte surface. A faint, spread-out shadow underneath the container gives a slight floating effect. Consistent with the product''s design is a general symbol in white, clearly centered and covering roughly 30% of its frontal area. The symbol blends seamlessly with the container''s texture, as if it''s printed or embedded directly on it, maintaining a flat appearance that naturally conforms to the container''s surface. The backdrop of the image is uncluttered white, with the light source capturing both the container and the symbol beautifully.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Nike brand logo in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10, 42, 6, CAST(N'2024-10-30T06:36:22.143' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-b9BjcGYSvjzZPvBblAux5lr8.png?st=2024-10-30T05%3A36%3A26Z&se=2024-10-30T07%3A36%3A26Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A13%3A38Z&ske=2024-10-31T00%3A13%3A38Z&sks=b&skv=2024-08-04&sig=rYbVkkO8lU5CmM/L0iBLbx43X1VY3rldnt6vamoWTME%3D', N'Visualize a cylindrical bottle, made of potentially aluminum, but with a matte black finish. This non-reflective surface manifests an elegant, understated aura. The minimalist aesthetic of the bottle is upheld by the absence of any labels or logos. The bottle is capped with a black, ribbed-edged screw-top aiding better grip. The design is slim and tall, boasting a ratio of height-to-width that gives it an elongated sleekness. A faint and subtle shadow rests beneath, barely noticeable, hinting at a slight floating feel against a totally smooth, white background. In the midst of this minimalist product, incorporate a fitting and generic soccer team logo. This logo should clearly occupy roughly 30% of the front area, blending well into the bottle''s surface as though printed or embedded on it flatly. It should neither overwhelm the original design nor stray from the specified style and finish. The background should remain distraction-free and white, the shadows minimalistic, and the lighting evenly cast to highlight the bottle and logo specifically.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Generic logo of a soccer team''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (11, 42, 6, CAST(N'2024-10-30T06:37:12.173' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-BZoalKQXtcZBDDnXU3KnZjwo.png?st=2024-10-30T05%3A37%3A17Z&se=2024-10-30T07%3A37%3A17Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A19%3A22Z&ske=2024-10-31T00%3A19%3A22Z&sks=b&skv=2024-08-04&sig=jVQxOXkkwXQKYPtmApZCi8lh3BLLsjm7b9SEWHR90XA%3D', N'A sleek, matte black, metallic cylindrical bottle stands majestically against a white, shadowless backdrop. This minimalist designed bottle boasts of a smooth, non-reflective surface and is devoid of any labels. It wears a screw-top cap that is also black, flaunting a ribbed edge for extra grip. The exquisite elongated shape of the bottle, with its heightened length-width ratio, molds an elegant silhouette. Embedded creatively onto the minimalistic bottle, occupying about 30% of its front area, is a beautifully rendered white soccer team logo, which feels naturally printed onto the bottle with a flat and congruent texture. The soft, even lighting nurtures the product and its logo, making them the undeniable protagonists of the composition.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Logo of a soccer team in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (12, 42, 6, CAST(N'2024-10-30T06:38:27.477' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-pKWUZ9r6smKZTUeDtuxKOzDK.png?st=2024-10-30T05%3A38%3A32Z&se=2024-10-30T07%3A38%3A32Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A24%3A00Z&ske=2024-10-31T00%3A24%3A00Z&sks=b&skv=2024-08-04&sig=kZoZTSSJm6AtnJnxGkt9lQhgnzdfC8cp1GtrWVzz1%2BA%3D', N'Envision a cylindrical traditional flask with a matte black finish, preferably made of metallic material, possibly aluminum. The flask possesses a smooth, non-reflective surface, symbolizing elegance and subtlety. It lacks labels or logos, adhering to a minimalist design philosophy. The flask''s top is a screwable cap, also black, exhibiting a faintly ribbed edge to enhance grip. The flask has an extended, slender framework, with a significant height-to-width proportion, imparting a trim and protracted appearance.

The backdrop is simply plain white, perfectly smooth, devoid of perceptible shadows or diversions, letting the black flask dominate the center. The illumination is mild and balanced, essentially nullifying all shadows and emphasizing the matte finish. A gentle, obscure shadow exists at the bottom, contributing to a slight buoyant effect above the white background. This shadow is highly diffused and nearly invisible, reinforcing the illusion of a professional studio environment. 

In the middle of the flask, incorporate a ''Bola de futbol'' inspired logo. The logo should be centrally situated and cover an important space on the flask''s facade, enveloping approximately 30% of its front surface for visibility and aesthetic appeal, without diverting from the initial design. The logo must merge seamlessly with the flask''s texture, appearing as if printed or embedded directly onto it. This achieving without any 3D or elevated effects and sustaining a flat presence that adheres to the flask''s surface, honoring its prescribed style and finish. The image''s setting should be unsullied white, with no stark shadows or distracting components allowing the flask and logo to distinctly feature in the composition. The lighting must remain soft and even, illuminating both the product and the logo without modifying the pre-established design attributes.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Bola de futbol''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (13, 42, 6, CAST(N'2024-10-30T06:39:29.457' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-G8IZHVCcgLo2AXuMhAIoZsoO.png?st=2024-10-30T05%3A39%3A34Z&se=2024-10-30T07%3A39%3A34Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A23%3A29Z&ske=2024-10-31T00%3A23%3A29Z&sks=b&skv=2024-08-04&sig=aQsIB9gawjH4Kx6gOg/Cq4g1ZeYyaeeP0W616mYKQlY%3D', N'Visualize a cylindrical, elegantly understated bottle made of matte black metal, possibly aluminum. The surface is smooth, non-reflective, and devoid of labels, logos or embellishments, following a minimalist and chic style. The cap, identical in color to the bottle, features a screw-top design with a slightly ribbed edge for better handling. The bottle''s design has a high height-to-width ratio, engendering a sleek and elongated aesthetic appeal. In contrast stands a crisp, unblemished white background, bereft of any distracting shadows. The lighting is softly uniform, casting an almost invisible, diffuse shadow at the base of the bottle for a slight levitating effect, a testament to the professional studio setting. Centered on the bottle appears a minimalist white logo of a soccer ball, covering nearly 30% of the bottle''s front surface. This logo seamlessly integrates onto the bottle''s texture, as if directly printed or embedded, with no raised or three-dimensional effects. The resultant image maintains a clean, uncluttered background with mild, even lighting that accentuates both the commercial product and the prominently placed logo while preserving the original design nuances.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Minimalistic soccer ball in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (14, 42, 6, CAST(N'2024-10-30T06:41:46.793' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-5PsRG4UsNgb9mYpWPS8qyLzt.png?st=2024-10-30T05%3A41%3A51Z&se=2024-10-30T07%3A41%3A51Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A17%3A41Z&ske=2024-10-31T00%3A17%3A41Z&sks=b&skv=2024-08-04&sig=3sjL%2BqzOhvnvczk0CnbvYcrUFlRZuoCvUSOZQMtFK%2BA%3D', N'A smooth, non-reflective, metal cylindrical bottle with a matte black finish placed on a plain white backdrop. The bottle showcases a minimalist design aesthetic with an elongated profile, characterized by a greater height-to-width ratio. Its cap, tinted black, features a slightly ribbed edge promoting an easy grip. The screw-top cap shares the same matte finish. On the bottle''s surface, a flat, white, centered logo of a minimalist AK-47 rifle is incorporated, occupying about 30% of the front. The logo should blend in with the bottle surface as if it were printed or embedded onto it, respecting the non-3D aesthetics of the matte finish. The lighting is soft and even, with a faint diffused shadow under the bottle suggesting a professional studio set without overwhelming the product design.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Minimalistic image of a ak-47 in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10002, 42, 6, CAST(N'2024-10-30T16:43:33.383' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-N9Os6XwGPZEPxMB0KPBRNznE.png?st=2024-10-30T15%3A43%3A22Z&se=2024-10-30T17%3A43%3A22Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A22%3A58Z&ske=2024-10-31T00%3A22%3A58Z&sks=b&skv=2024-08-04&sig=O1YH7YZkQBBOWTV40HUjgQOju1lgfWeEky8KR%2Bo5vnk%3D', N'Create an image of a tall, slender, metallic, cylindrical bottle with a matte black finish. The bottle is smooth and non-reflective with no labels or logos, and its screw-top cap is also black with a ribbed edge. The bottle is presented against a plain white, smooth background with soft, even lighting that eliminates most shadows, save for a faint, subtle shadow at the bottom that gives the appearance of floatation. Embedded on the center of this black bottle is a minimalistic, white logo of a tree covering approximately 30% of its front area, blending smoothly with the bottle''s texture as if it is printed directly onto it without any 3D or raised effects.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a tree in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10003, 42, 6, CAST(N'2024-10-30T16:46:47.377' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-p55WLhruCMx59m5mBbewiHJZ.png?st=2024-10-30T15%3A46%3A54Z&se=2024-10-30T17%3A46%3A54Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A38%3A58Z&ske=2024-10-31T00%3A38%3A58Z&sks=b&skv=2024-08-04&sig=fUN8WEyodZPYtutYp%2BM%2BOOPg/hbhKNcZAtFF/kaTO/U%3D', N'Visualize a cylindrical bottle made of metal, possibly aluminum, painted in a completely matte black finish. Its surface is elegant, smooth, and non-reflective with a minimalist design devoid of labels or logos. The screw-top cap is also black, with a ribbed edge for an enhanced grip. The structure of the bottle is tall and slender, attributing to a sleek, elongated look. In contrast, the background is a plain, smooth white surface, with soft, even lighting that eliminates most shadows and subtly highlights the matte finish of the bottle. There is a faint shadow at the bottom to give the bottle a floating effect. The black bottle contrasts beautifully against the white background. In the center of the bottle, apply a white, minimalistic tree logo that covers approximately 30% of the front area and blends well with the texture of the matte black bottle, as if it''s printed or embedded directly onto it, avoiding raised effects.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a tree in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10004, 42, 6, CAST(N'2024-10-30T16:57:25.653' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-oL8iYY8kEjEaNcSPl1CktFxc.png?st=2024-10-30T15%3A57%3A32Z&se=2024-10-30T17%3A57%3A32Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A30%3A23Z&ske=2024-10-31T00%3A30%3A23Z&sks=b&skv=2024-08-04&sig=9OzxCtp4tvf/NRdiYMhWyrR/GoZFnIvNCxOSTAeyd84%3D', N'Create an image of a cylindrical bottle made of matte black aluminum, with a smooth and non-reflective surface. The bottle is minimalist in design with no labels or logos, except for a prominently centered logo depicting a black and white soccer ball. The screw-top cap is also black with a ribbed edge for better grip. The bottle has a tall, slender shape, implying a greater height-to-width ratio for a sleek look. The background is a plain, shadowless white, positioning the black bottle in the center of the composition. The lighting is even and soft, casting a faint, almost unnoticeable shadow that gives the bottle a ''floating'' effect. The soccer ball logo must occupy approximately 30% of the bottle''s front area, seamlessly blending with the product''s texture as if it is printed directly onto the surface, with a flat appearance that respects the bottle''s original style and finish.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Balon de futbol color blanco y negro''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10005, 42, 6, CAST(N'2024-10-30T17:06:07.297' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-7imSSRQlIdUPnl8xHK5IMZ5u.png?st=2024-10-30T16%3A06%3A14Z&se=2024-10-30T18%3A06%3A14Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A17%3A30Z&ske=2024-10-31T00%3A17%3A30Z&sks=b&skv=2024-08-04&sig=G4Zf5Z8b5nIkLtH3F40yUvV3ZrglGGqaXuB1vdIw2d4%3D', N'Visualize an elongated and cylindrical metal bottle painted entirely in a matte black finish. The bottle characteristically possesses a minimalist design devoid of labels and logos. Its screw-top cap mirrors the bottle with a matte black finish and a ribbed edge for easy grip. The bottle boasts a sleek appearance thanks to a higher height-to-width ratio. It is set against a plain and smooth white background where no shadows or other elements interfere with the bottle. Soft and evenly spread lighting illuminates the setup, subtly accentuating the bottle''s matte texture while leaving only a delicate shadow at its base hinting at a floating effect. Over the middle of the bottle, overlay a realistic, white panda logo. The logo should be rendered seamlessly onto the bottle, covering roughly 30% of its front surface, while respecting the original matte finish and texture of the bottle. The final snapshot should emphasize the bottle and logo against the white backdrop, all under soft and even lighting.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Un logo de un panda color blanco estilo realista
''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10006, 42, 6, CAST(N'2024-10-30T17:18:11.507' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-RT7W7C1dm4XaX1U78BFiIrvu.png?st=2024-10-30T16%3A18%3A18Z&se=2024-10-30T18%3A18%3A18Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A22%3A05Z&ske=2024-10-31T00%3A22%3A05Z&sks=b&skv=2024-08-04&sig=9wy24dPySAOF3TWD0zWtK4wDhSRFs5AdG8S9PIlzToE%3D', N'A slender cylindrical bottle made of non-reflective matte black metal, possibly aluminum, standing in the center of a plain white background. The bottle, devoid of any labels, has a minimalist design with a rib-edged black screw-top cap for better grip. It emanates a sense of understated elegance due to its simplicity and tall, sleek shape. The soft, even lighting erases almost all shadows but introduces a diffused, barely noticeable one at the bottom, creating a slight floating effect. On the bottle is a printed, realistic white panda logo that occupies about 30% of the front area, perfectly blended with the bottle''s texture maintaining a flat appearance for a seamless look.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Un logo de un oso pande realista en colo blanco''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10007, 42, 6, CAST(N'2024-10-30T17:19:19.273' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-8p8epLWhJUGmTyO942uhAak4.png?st=2024-10-30T16%3A19%3A26Z&se=2024-10-30T18%3A19%3A26Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A18%3A55Z&ske=2024-10-31T00%3A18%3A55Z&sks=b&skv=2024-08-04&sig=BqkvPTKKHRNevWT1UDDBLrhkQAZku4nwl2c6DA1eOQc%3D', N'Create an image of a cylindrical, metal bottle with a sleek, elongated design and a matte black finish. It has a screw-top cap that is also black, featuring a slightly ribbed edge for better grip. The bottle is minimalistic with no labels or logos, except for a vivid logo of a realistic Japanese tree in white, which is centered and covering approximately 30% of the product''s front area. It must appear as if it is printed or embedded directly onto the bottle''s surface. Surrounding the bottle is a plain, uncluttered, white background with soft, even lighting creating a pleasant aesthetic view.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''Un logo de arbol japones realista en color blanco''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10008, 42, 6, CAST(N'2024-10-30T18:38:41.780' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-z2ysjD9PA2tudWp0DcpxbLuW.png?st=2024-10-30T17%3A38%3A48Z&se=2024-10-30T19%3A38%3A48Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A21%3A24Z&ske=2024-10-31T00%3A21%3A24Z&sks=b&skv=2024-08-04&sig=7dgVPv3fLXbxTHLzVQxYtc9VE6mR04ldPrCIpVHNGVE%3D', N'A tall and slender, cylindrical bottle made of non-reflective matte black metal which could potentially be aluminum. Its surface is ultra-smooth, devoid of any labels or logos, embodying a minimalist aesthetic. The screw-top cap, in matching black, features a slightly ribbed edge for optimal grip. Set against a spotless white backdrop, the black bottle is conspicuous in the frame. The light is gentle and even, putting minimal shadows into play, and underlining the matte quality of the bottle. A diffuse and barely visible shadow under the bottle infers a surreal floating effect, emulating a professional photo studio environment. Centered on the bottle, imagine a simple, white piano logo. Covering roughly 30% of the bottle''s frontal area, the logo isn''t overwhelming but clearly visible. It appears directly onto the bottle''s texture, ensuring a flat and consistent integration with the product''s surface. The ambient brightness illuminates both the product and logo and the scene remains free from potent shadows or potential disturbances.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a piano in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10009, 42, 6, CAST(N'2024-10-30T18:39:38.197' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-M6vHOW4BKoQ986P7TbyteDMS.png?st=2024-10-30T17%3A39%3A45Z&se=2024-10-30T19%3A39%3A45Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A15%3A46Z&ske=2024-10-31T00%3A15%3A46Z&sks=b&skv=2024-08-04&sig=VArDZdHAeHuxriGD1rPb%2BocFksoBZap1k1e1F2Xw3BM%3D', N'Create an image of a cylindrical, metal bottle with a completely matte, non-reflective black finish. This object has an elegant and minimalist design with no labels, logos, or embellishments, maintaining its streamlined and sleek look. Its cap also carries the same matte black finish with a ribbed edge to facilitate grip. The object''s slender and elongated form contains a greater height-to-width ratio, giving it a streamlined and sophisticated appearance. In the center of the body of this object, imprint a minimalistic white logo of a tree accounting for about 30% of its front surface area. This printed or embedded logo should smoothly merge with the object''s texture and maintain a flat appearance. The image''s background should be plain white with a slight diffuse shadow under the bottle, enhancing its floating effect, and it should elude any clutter, strong shadows, or distractions to let the bottle and logo stand out. The lighting on this image should be soft and smooth, eliminating almost all shadows and emphasizing the matte finish of the bottle. The overall composition of this image should follow a professional studio setting and respect all the described details of the object''s design.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic logo of a tree in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
GO
INSERT [dbo].[Boceto] ([IdBoceto], [IdProducto], [IdUsuario], [FechaCreacion], [RutaImagen], [PromptUsado], [PromptOriginal]) VALUES (10010, 42, 6, CAST(N'2024-10-30T18:41:07.107' AS DateTime), N'https://oaidalleapiprodscus.blob.core.windows.net/private/org-pjccHK2ip9Lrf7xkufyJtaeI/user-YQi1DPQiOvyqcla1vpX3UMye/img-Pu8NVYcmIKP6G1QKfrMORHyt.png?st=2024-10-30T17%3A41%3A13Z&se=2024-10-30T19%3A41%3A13Z&sp=r&sv=2024-08-04&sr=b&rscd=inline&rsct=image/png&skoid=d505667d-d6c1-4a0a-bac7-5c84a87759f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-10-30T00%3A23%3A00Z&ske=2024-10-31T00%3A23%3A00Z&sks=b&skv=2024-08-04&sig=cE4RLaPNl6vJSS2W6M2TxYA85RALs%2BdMot3Nj9kO5yw%3D', N'Create an image of a tall, slender cylindrical bottle made of matte black metal, possibly aluminum. The bottle should have a smooth, non-reflective surface, and its design should be minimalist and simple, with no labels or logos other than a centrally-placed white logo representing a minimalistic image of a soccer ball. This logo should occupy approximately 30% of the bottle''s front area and should blend seamlessly with the product''s surface, maintaining a flat appearance that respects the described style and finish of the product. The bottle''s cap should be a black screw-top with a slightly ribbed edge for better grip. The product should be set against a plain white background, free from strong shadows or distractions. There should be a faint, subtle shadow at the bottom of the bottle, providing a slight floating effect. The lighting should be soft and even, emphasising the matte finish of the bottle''s surface and ensuring that both the product and the logo stand out clearly in the composition.', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting. Create an image of the described product, ensuring that the design remains exactly as specified in the description. In the center of the product, incorporate a logo based on the following description: ''A minimalistic image of a soccerball in color white''. The logo should be clearly centered and occupy a prominent space on the product’s surface, covering approximately 30% of its front area to make it visible and aesthetically pleasing, but without overwhelming or distracting from the original design of the product. The logo must blend smoothly with the product''s texture, as if it is printed or embedded directly onto it, avoiding any three-dimensional or raised effects. It is important that the logo maintains a flat appearance and naturally conforms to the surface of the product, respecting its described style and finish. The background of the image should be white and uncluttered, with no strong shadows or distracting elements, allowing the product and logo to stand out clearly in the composition. The lighting should be soft and even, highlighting both the product and the logo without altering the specified design details.')
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
SET IDENTITY_INSERT [dbo].[Boceto] OFF
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (1, N'Categoría 1')
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (2, N'Categoría 2')
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (42, 1, N'Botella negra', N'Botella negra de alumio', 45, CAST(4000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F42?alt=media&token=d93d0d44-a399-494c-92a2-e0649d3d2d3e', N'A cylindrical bottle with a completely matte black finish, likely made of metal, possibly aluminum. The surface is smooth and non-reflective, giving it an elegant, understated appearance. The bottle has no labels or logos, maintaining a minimalist and simple design. The cap is a screw-top and is also black, with a slightly ribbed edge to allow for better grip. The bottle has a tall, slender shape with a greater height-to-width ratio, giving it a sleek and elongated look.

The background is a plain white, completely smooth, with no noticeable shadows or distractions, allowing the black bottle to stand out in the center of the composition. The lighting is soft and even, eliminating almost all shadows and highlighting the matte finish of the bottle’s surface. There is a faint, subtle shadow at the bottom, giving a slight floating effect over the white background. This shadow is very diffuse and barely noticeable, enhancing the impression of a professional studio setting')
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (43, 2, N'Prueba 2', N'Prueba 2', 45, CAST(7000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F43?alt=media&token=a5773c66-f37a-4047-92a8-4a7c5cce4002', NULL)
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (45, 1, N'Prueba 3', N'Prueba 3', 45, CAST(7000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F45?alt=media&token=536b8eea-34f5-48c3-8761-f225f7f8c31d', NULL)
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (47, 1, N'Prueba 4', N'Prueba 4', 3452, CAST(4000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F47?alt=media&token=8b394ef4-7218-4349-b2cf-79194c667c99', NULL)
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (49, 1, N'Prueba 5', N'Prueba 5', 342, CAST(7000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F49?alt=media&token=337344c9-f049-45a9-939e-9f1241b1d07a', NULL)
GO
INSERT [dbo].[Producto] ([IdProducto], [CategoriaId], [Nombre], [Descripcion], [Cantidad], [Precio], [RutaImagen], [Prompt]) VALUES (50, 1, N'Prueba 6', N'Prueba 6', 45, CAST(4000000 AS Decimal(18, 0)), N'https://firebasestorage.googleapis.com/v0/b/big-solutions-b5c73.appspot.com/o/productos%2F50?alt=media&token=3e480f7f-c365-4a76-a883-db819da17b98', NULL)
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
SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (6, 3, N'118560019', N'Fabian Josue Montero Madrigal', N'fabianja0477@gmail.com', N'84955721', N'Vázquez de Coronado, Barrio el Carmen', N'/5F5Nx8xPkN6eXsqH/U92g==', 1, N'Big Solutions', 0, CAST(N'2024-10-03T17:35:14.950' AS DateTime), 30)
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal], [BocetosGenerados]) VALUES (7, 3, N'402510174', N'Melissa Vargas Gómez', N'mv213845@gmail.com', N'87963587', N'Mercedes Norte, Heredia', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-10-13T11:47:14.553' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1_2]    Script Date: 30/10/2024 17:28:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1_2] ON [dbo].[Usuario]
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarPerfilUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 30/10/2024 17:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarProducto]
    @IdProducto BIGINT,
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @Precio DECIMAL(18, 0),
    @IdCategoria BIGINT,
    @RutaImagen NVARCHAR(MAX)
AS
BEGIN
    UPDATE Producto
    SET 
        Nombre = @Nombre,
        Cantidad = @Cantidad,
        Descripcion = @Descripcion,
        Precio = @Precio,
        RutaImagen = @RutaImagen,
        CategoriaId = @IdCategoria
    WHERE 
        IdProducto = @IdProducto;
END;

GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenBoceto]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenProducto]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 30/10/2024 17:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AgregarProducto]
    @Nombre VARCHAR(50),
    @Cantidad INT,
    @Descripcion NVARCHAR(MAX),
    @Precio DECIMAL(18, 0),
    @IdCategoria BIGINT
AS
BEGIN
    INSERT INTO Producto (
        Nombre,
        Cantidad,
        Descripcion,
        Precio,
        CategoriaId,
        RutaImagen
    ) 
    VALUES (
        @Nombre, 
        @Cantidad, 
        @Descripcion, 
        @Precio, 
        @IdCategoria, 
        ''
    );

    SELECT 
        CONVERT(BIGINT, @@IDENTITY) AS IdProducto;
END;

GO
/****** Object:  StoredProcedure [dbo].[CambiarContrasenna]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosAdmin]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosCliente]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarPerfilUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProducto]    Script Date: 30/10/2024 17:28:26 ******/
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
        P.Precio,
        P.RutaImagen,
		P.Prompt,
        P.CategoriaId,
        C.Nombre AS 'NombreCategoria'
    FROM Producto P
    INNER JOIN Categoria C ON C.IdCategoria = P.CategoriaId
    WHERE P.IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 30/10/2024 17:28:26 ******/
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
        P.Precio,
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
/****** Object:  StoredProcedure [dbo].[ConsultarProductosCliente]    Script Date: 30/10/2024 17:28:26 ******/
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
        P.Precio,
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposCategorias]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposRoles]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorId]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarPerfilUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[GenerarBoceto]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerListaUsuarios]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[RecuperaContrasennaCodigo]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[Recuperar]    Script Date: 30/10/2024 17:28:26 ******/
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
	select CorreoElectronico from usuario where CorreoElectronico = @CorreoElectronico
END

GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Detalles_Cliente]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 30/10/2024 17:28:26 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarContrasennaActual]    Script Date: 30/10/2024 17:28:26 ******/
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
