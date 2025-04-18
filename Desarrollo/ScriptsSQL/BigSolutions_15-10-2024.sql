USE [master]
GO
/****** Object:  Database [BigSolutions]    Script Date: 15/10/2024 21:41:57 ******/
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
/****** Object:  Table [dbo].[Boceto]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Boceto](
	[IdBoceto] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[RutaImagen] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Boceto] PRIMARY KEY CLUSTERED 
(
	[IdBoceto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos_Detalle]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios_Detalle]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[IdOrden] [bigint] NOT NULL,
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
/****** Object:  Table [dbo].[Orden_Cotizacion]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Cotizacion](
	[IdOrdenCotizacion] [bigint] NOT NULL,
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
/****** Object:  Table [dbo].[Orden_Detalle_Bocetos]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Comprobantes]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Cotizacion]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Orden_Detalle_Factura_Pendiente]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 15/10/2024 21:41:58 ******/
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
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_Cotizacion](
	[IdSolicitudCotizacion] [bigint] NOT NULL,
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion_Detalle]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 15/10/2024 21:41:58 ******/
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
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (1, N'Categoría 1')
GO
INSERT [dbo].[Categoria] ([IdCategoria], [Nombre]) VALUES (2, N'Categoría 2')
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
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal]) VALUES (6, 3, N'118560019', N'Fabian Josue Montero Madrigal', N'fabianja0477@gmail.com', N'84955721', N'Vázquez de Coronado, Barrio el Carmen', N'/5F5Nx8xPkN6eXsqH/U92g==', 1, N'Big Solutions', 0, CAST(N'2024-10-03T17:35:14.950' AS DateTime))
GO
INSERT [dbo].[Usuario] ([UsuarioId], [IdRol], [Identificacion], [NombreCompleto], [CorreoElectronico], [NumeroTelefono], [DireccionExacta], [Contrasenna], [Estado], [NombreEmpresa], [EsTemporal], [VigenciaTemporal]) VALUES (7, 3, N'402510174', N'Melissa Vargas Gómez', N'mv213845@gmail.com', N'87963587', N'Mercedes Norte, Heredia', N'ZwTqxXck2S9uh2OqY/xA3g==', 1, N'Big Solutions', 0, CAST(N'2024-10-13T11:47:14.553' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1_2]    Script Date: 15/10/2024 21:41:58 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1_2] ON [dbo].[Usuario]
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarPerfilUsuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenProducto]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarPerfilUsuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProducto]    Script Date: 15/10/2024 21:41:58 ******/
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
        P.CategoriaId,
        C.Nombre AS 'NombreCategoria'
    FROM Producto P
    INNER JOIN Categoria C ON C.IdCategoria = P.CategoriaId
    WHERE P.IdProducto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 15/10/2024 21:41:58 ******/
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
        P.CategoriaId,
        C.Nombre AS 'NombreCategoria'
    FROM 
        Producto P
    INNER JOIN 
        Categoria C ON C.IdCategoria = P.CategoriaId;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTiposCategorias]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposRoles]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorId]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarUsuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarPerfilUsuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IniciarSesion]
	@CorreoElectronico			varchar(50),
	@Contrasenna	varchar(50)
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
/****** Object:  StoredProcedure [dbo].[ObtenerListaUsuarios]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[RecuperaContrasennaCodigo]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[Recuperar]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 15/10/2024 21:41:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarUsuario]
	@NombreCompleto   varchar(255),
	@Identificacion   varchar(12),
	@CorreoElectronico           varchar(50),
	@NumeroTelefono         varchar(50),
	@DireccionExacta        varchar(250),
	@Contrasenna      varchar(12),
	@NombreEmpresa varchar(50)
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
/****** Object:  StoredProcedure [dbo].[SP_Detalles_Cliente]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 15/10/2024 21:41:58 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 15/10/2024 21:41:58 ******/
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
USE [master]
GO
ALTER DATABASE [BigSolutions] SET  READ_WRITE 
GO
