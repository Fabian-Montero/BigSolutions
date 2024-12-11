USE [master]
GO
/****** Object:  Database [BigSolutions]    Script Date: 11/12/2024 17:43:12 ******/
CREATE DATABASE [BigSolutions]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BigSolutions', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BigSolutions.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Boceto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Correos_Electronicos_Detalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Cotizacion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Cotizacion_Detalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Grupo_Usuarios_Detalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Orden]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[IdOrden] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[RutaOrdenCompra] [varchar](max) NOT NULL,
	[RutaFacturaVenta] [varchar](max) NULL,
	[RutaBoletaEntrega] [varchar](max) NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Estado] [int] NOT NULL,
	[MetodoPago] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Material] [varchar](max) NULL,
	[FechaEntrega] [datetime] NULL,
	[EstadoInterno] [int] NULL,
	[DescripcionInterna] [varchar](max) NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[IdOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Bocetos]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Bocetos](
	[IdOrdenDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[IdBoceto] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdOrdenDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Comprobantes]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Comprobantes](
	[IdOrdenDetalleComprobantes] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[RutaComprobante] [varchar](max) NOT NULL,
	[DescripcionComprobante] [varchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdOrdenDetalleComprobantes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Cotizacion]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Cotizacion](
	[IdOrdenDetalleCotizacion] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOrdenCotizacion] [bigint] NOT NULL,
	[IdCotizacion] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdOrdenDetalleCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Detalle_Factura_Pendiente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Detalle_Factura_Pendiente](
	[IdFacturaPendiente] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOrden] [bigint] NOT NULL,
	[SubTotal] [decimal](18, 2) NULL,
	[ImpuestoIVA] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFacturaPendiente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdenBackup]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenBackup](
	[IdOrden] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[RutaOrdenCompra] [varchar](max) NOT NULL,
	[RutaFacturaVenta] [varchar](max) NULL,
	[RutaBoletaEntrega] [varchar](max) NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Estado] [int] NOT NULL,
	[MetodoPago] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Material] [varchar](max) NULL,
	[FechaEntrega] [datetime] NULL,
	[EstadoInterno] [varchar](max) NULL,
	[DescripcionInterna] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Rol]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Solicitud_Cotizacion_Detalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  Index [IX_Cotizacion]    Script Date: 11/12/2024 17:43:12 ******/
CREATE NONCLUSTERED INDEX [IX_Cotizacion] ON [dbo].[Cotizacion]
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1_2]    Script Date: 11/12/2024 17:43:12 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1_2] ON [dbo].[Usuario]
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario]    Script Date: 11/12/2024 17:43:12 ******/
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
ALTER TABLE [dbo].[Orden_Detalle_Bocetos]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Bocetos_IdBoceto] FOREIGN KEY([IdBoceto])
REFERENCES [dbo].[Boceto] ([IdBoceto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos] CHECK CONSTRAINT [FK_Orden_Detalle_Bocetos_IdBoceto]
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Bocetos_IdOrden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orden_Detalle_Bocetos] CHECK CONSTRAINT [FK_Orden_Detalle_Bocetos_IdOrden]
GO
ALTER TABLE [dbo].[Orden_Detalle_Comprobantes]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Comprobantes_IdOrden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orden_Detalle_Comprobantes] CHECK CONSTRAINT [FK_Orden_Detalle_Comprobantes_IdOrden]
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Cotizacion_Orden_Cotizacion] FOREIGN KEY([IdOrdenCotizacion])
REFERENCES [dbo].[Orden] ([IdOrden])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion] CHECK CONSTRAINT [FK_Orden_Detalle_Cotizacion_Orden_Cotizacion]
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_OrdenDetalleCotizacion_IdCotizacion] FOREIGN KEY([IdCotizacion])
REFERENCES [dbo].[Cotizacion] ([IdCotizacion])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orden_Detalle_Cotizacion] CHECK CONSTRAINT [FK_OrdenDetalleCotizacion_IdCotizacion]
GO
ALTER TABLE [dbo].[Orden_Detalle_Factura_Pendiente]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Detalle_Factura_Pendiente_Orden] FOREIGN KEY([IdOrden])
REFERENCES [dbo].[Orden] ([IdOrden])
ON DELETE CASCADE
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
/****** Object:  StoredProcedure [dbo].[ActualizarComprobanteAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarComprobanteAdmin]
    @IdOrden BIGINT,
    @DescripcionComprobante VARCHAR(MAX)
AS
BEGIN
    UPDATE Orden_Detalle_Comprobantes
    SET 
        DescripcionComprobante = @DescripcionComprobante
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarOrdenAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarOrdenAdmin]
    @IdOrden BIGINT,
    @Descripcion NVARCHAR(MAX),
    @MetodoPago INT,
    @EstadoOrden INT,
    @Material VARCHAR(MAX),
    @FechaEntrega DATETIME,
    @EstadoInternoOrden INT,
    @DescripcionInterna VARCHAR(MAX)
AS
BEGIN
    UPDATE Orden
    SET 
        Descripcion = @Descripcion,
        MetodoPago = @MetodoPago,
        Estado = @EstadoOrden,
        Material = @Material,
        FechaEntrega = @FechaEntrega,
        EstadoInterno = @EstadoInternoOrden,
        DescripcionInterna = @DescripcionInterna
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarOrdenDetalleCotizacionAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarOrdenDetalleCotizacionAdmin]
    @IdOrden BIGINT,
    @IdCotizacion BIGINT
AS
BEGIN

	UPDATE Orden_Detalle_Cotizacion
	SET 
		IdCotizacion = @IdCotizacion
	WHERE IdOrdenCotizacion = @IdOrden

END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPerfilUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaBoletaEntrega]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarRutaBoletaEntrega]
    @IdOrden BIGINT,
    @RutaBoletaEntrega VARCHAR(MAX)
AS
BEGIN
    UPDATE Orden
    SET RutaBoletaEntrega = @RutaBoletaEntrega
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaComprobante]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutaComprobante]
    @IdOrdenDetalleComprobantes BIGINT,
    @RutaComprobante VARCHAR(MAX)
AS
BEGIN


    UPDATE Orden_Detalle_Comprobantes
    SET RutaComprobante = @RutaComprobante
    WHERE IdOrdenDetalleComprobantes = @IdOrdenDetalleComprobantes;
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaCotizacion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaFacturaVenta]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarRutaFacturaVenta]
    @IdOrden BIGINT,
    @RutaFacturaVenta VARCHAR(MAX)
AS
BEGIN

    UPDATE Orden
    SET RutaFacturaVenta = @RutaFacturaVenta
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenBoceto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaImagenProducto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarRutaOrdenCompra]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutaOrdenCompra]
    @IdOrden BIGINT,
    @RutaOrdenCompra VARCHAR(MAX)
AS
BEGIN
   
    UPDATE Orden
    SET RutaOrdenCompra = @RutaOrdenCompra
    WHERE IdOrden = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRutasArchivos]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRutasArchivos]
    @IdOrden BIGINT,
    @RutaOrdenCompra VARCHAR(MAX),
    @RutaFacturaVenta VARCHAR(MAX),
    @RutaBoletaEntrega VARCHAR(MAX),
    @RutaComprobante NVARCHAR(MAX)
AS
BEGIN
    UPDATE Orden
    SET 
        RutaOrdenCompra = @RutaOrdenCompra,
        RutaFacturaVenta = @RutaFacturaVenta,
        RutaBoletaEntrega = @RutaBoletaEntrega
    WHERE IdOrden = @IdOrden;

	UPDATE Orden_Detalle_Comprobantes
	SET
		RutaComprobante = @RutaComprobante
END;
GO
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CambiarContrasenna]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosAdmin]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosCliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarBocetosOrdenVista]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarBocetosOrdenVista]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        B.IdBoceto,
        B.IdProducto,
        B.IdUsuario,
        B.FechaCreacion,
        B.RutaImagen,
        P.Nombre AS NombreProducto,
        U.NombreCompleto AS NombreUsuario
    FROM Boceto B
    INNER JOIN Producto P ON B.IdProducto = P.IdProducto
    INNER JOIN Usuario U ON B.IdUsuario = U.UsuarioId
    INNER JOIN Orden_Detalle_Bocetos ODB ON ODB.IdBoceto = B.IdBoceto
    WHERE ODB.IdOrden = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarComprobanteOrden]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarComprobanteOrden]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        IdOrdenDetalleComprobantes,
        IdOrden,
        RutaComprobante,
        DescripcionComprobante,
        FechaCreacion
    FROM dbo.Orden_Detalle_Comprobantes
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarComprobantesOrdenVista]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarComprobantesOrdenVista]
    @IdOrden BIGINT
AS
BEGIN
    SELECT *
    FROM dbo.Orden_Detalle_Comprobantes
    WHERE IdOrden = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarComprobantesPorOrden]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarComprobantesPorOrden]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        IdOrdenDetalleComprobantes,
        DescripcionComprobante,
        FechaCreacion,
        RutaComprobante
    FROM Orden_Detalle_Comprobantes
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionesAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionesAdmin]
AS
BEGIN
    SELECT 
        C.IdCotizacion,
        C.IdUsuario,
		U.NombreCompleto as NombreCompleto,
        C.IdSolicitudCotizacion,
        C.RutaCotizacion,
        C.SubTotal,
        C.Impuesto,
        C.Total,
        C.FechaCreacion,
        C.Estado,
        C.Descripcion,
		SC.Moneda
    FROM Cotizacion C
	INNER JOIN Usuario U ON U.UsuarioId = C.IdUsuario
	INNER JOIN Solicitud_Cotizacion SC ON SC.IdSolicitudCotizacion = C.IdSolicitudCotizacion

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionesUsuario]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionesUsuario]
    @IdUsuario INT
AS
BEGIN
    SELECT 
        C.IdCotizacion,
        C.Descripcion,
        C.RutaCotizacion,
        C.FechaCreacion,
		C.IdUsuario,
		SC.Moneda,
		U.NombreCompleto as NombreCompleto
    FROM Cotizacion C
	INNER JOIN Usuario U ON U.UsuarioId = C.IdUsuario
	INNER JOIN Solicitud_Cotizacion SC ON SC.IdSolicitudCotizacion = C.IdSolicitudCotizacion
    WHERE C.IdUsuario = @IdUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionOrdenCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionOrdenCliente]
	@IdOrden INT
AS
BEGIN
    SELECT 
        C.IdCotizacion,
        C.Descripcion,
        C.RutaCotizacion,
        C.FechaCreacion,
		C.IdUsuario,
		SC.Moneda,
		U.NombreCompleto as NombreCompleto
    FROM Orden_Detalle_Cotizacion OC
	INNER JOIN Cotizacion C ON C.IdCotizacion = OC.IdCotizacion
	INNER JOIN Usuario U ON U.UsuarioId = C.IdUsuario
	INNER JOIN Solicitud_Cotizacion SC ON SC.IdSolicitudCotizacion = C.IdSolicitudCotizacion
    WHERE OC.IdOrdenCotizacion = @IdOrden
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionOrdenVista]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionOrdenVista]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        C.IdCotizacion,
        C.IdUsuario,
        U.NombreCompleto AS NombreCompleto,
        C.IdSolicitudCotizacion,
        C.RutaCotizacion,
        C.SubTotal,
        C.Impuesto,
        C.Total,
        C.FechaCreacion,
        C.Estado,
        C.Descripcion,
        SC.Moneda
    FROM Cotizacion C
    INNER JOIN Usuario U ON U.UsuarioId = C.IdUsuario
    INNER JOIN Solicitud_Cotizacion SC ON SC.IdSolicitudCotizacion = C.IdSolicitudCotizacion
    INNER JOIN Orden_Detalle_Cotizacion ODC ON ODC.IdCotizacion = C.IdCotizacion
    WHERE ODC.IdOrdenCotizacion = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCotizacionPorOrden]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCotizacionPorOrden]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        IdCotizacion
    FROM dbo.Orden_Detalle_Cotizacion
    WHERE IdOrdenCotizacion = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDatosOrdenAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarDatosOrdenAdmin]
    @IdOrden BIGINT
AS
BEGIN
  
    SELECT 
        IdOrden,
        IdUsuario,
        RutaOrdenCompra,
        RutaFacturaVenta,
        RutaBoletaEntrega,
        Descripcion,
        Estado as EstadoOrden,
        MetodoPago,
        FechaCreacion,
        Material,
        FechaEntrega,
        EstadoInterno AS EstadoInternoOrden,
        DescripcionInterna
    FROM dbo.Orden
    WHERE IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDatosOrdenCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarDatosOrdenCliente]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        o.IdOrden,
        o.Descripcion,
        o.RutaOrdenCompra,
        o.MetodoPago,
        o.FechaCreacion,
        o.IdUsuario
    FROM Orden o
    WHERE o.IdOrden = @IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionAdmin]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleSolicitudCotizacionCliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarFacturasPendientesOrdenVista]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarFacturasPendientesOrdenVista]
    @IdOrden BIGINT
AS
BEGIN
    SELECT 
        FP.IdFacturaPendiente,
        FP.IdOrden,
        FP.SubTotal,
        FP.ImpuestoIVA,
        FP.Total,
        FP.FechaCreacion
    FROM dbo.Orden_Detalle_Factura_Pendiente FP
    WHERE FP.IdOrden = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarOrdenesAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarOrdenesAdmin]
AS
BEGIN
    SELECT 
        o.IdOrden,
        o.IdUsuario,
        o.RutaOrdenCompra,
        o.RutaFacturaVenta,
        o.RutaBoletaEntrega,
        o.Descripcion,
        o.Estado,
        o.MetodoPago, 
        o.FechaCreacion,
        o.Material,
        o.FechaEntrega,
        o.EstadoInterno,
        o.DescripcionInterna,
        u.NombreCompleto AS NombreUsuario 
    FROM Orden o
    INNER JOIN Usuario u ON o.IdUsuario = u.UsuarioId

END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarOrdenesCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarOrdenesCliente]
    @IdUsuario BIGINT
AS
BEGIN
    SELECT 
        o.IdOrden,
        o.Descripcion,
        o.Estado, 
        o.MetodoPago,
        o.RutaOrdenCompra,
        o.RutaFacturaVenta,
        o.FechaCreacion
    FROM Orden o
    WHERE o.IdUsuario = @IdUsuario
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarOrdenVista]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarOrdenVista]
    @IdOrden BIGINT
AS
BEGIN
    SELECT *
    FROM dbo.Orden
    WHERE IdOrden = @IdOrden;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPerfilUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProducto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarProductosCliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesAdmin]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarSolicitudesCotizacionesCliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposCategorias]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarTiposRoles]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorId]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearComprobanteAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearComprobanteAdmin]
    @IdOrden BIGINT,
    @DescripcionComprobante VARCHAR(MAX),
    @FechaCreacion DATETIME,
    @RutaComprobante VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Orden_Detalle_Comprobantes(
        IdOrden,
        DescripcionComprobante,
        FechaCreacion,
        RutaComprobante
    )
    VALUES (
        @IdOrden,
        @DescripcionComprobante,
        @FechaCreacion,
        @RutaComprobante
    );

    SELECT SCOPE_IDENTITY() AS IdComprobante;
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearComprobanteCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearComprobanteCliente]
    @IdOrden BIGINT,
    @DescripcionComprobante NVARCHAR(MAX),
    @RutaComprobante NVARCHAR(MAX),
	@FechaCreacion datetime
AS
BEGIN
    INSERT INTO Orden_Detalle_Comprobantes(IdOrden, DescripcionComprobante, RutaComprobante, FechaCreacion)
    VALUES (@IdOrden, @DescripcionComprobante, @RutaComprobante, @FechaCreacion);

    SELECT SCOPE_IDENTITY() AS IdComprobante;
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearCotizacion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearCotizacionDetalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearCotizacionVista]    Script Date: 11/12/2024 17:43:12 ******/
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
        u.NumeroTelefono,
		u.NombreEmpresa
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
/****** Object:  StoredProcedure [dbo].[CrearOrdenAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenAdmin]
    @Descripcion VARCHAR(MAX),
    @IdUsuario BIGINT,
    @MetodoPago INT,
    @FechaCreacion DATETIME,
    @RutaOrdenCompra VARCHAR(MAX),
    @Estado INT,
    @Material VARCHAR(MAX),
    @FechaEntrega DATETIME,
    @EstadoInternoOrden INT,
    @DescripcionInterna VARCHAR(MAX)
AS
BEGIN
    INSERT INTO Orden (
        Descripcion,
        IdUsuario,
        MetodoPago,
        FechaCreacion,
        RutaOrdenCompra,
        Estado,
        Material,
        FechaEntrega,
        EstadoInterno,
        DescripcionInterna
    )
    VALUES (
        @Descripcion,
        @IdUsuario,
        @MetodoPago,
        @FechaCreacion,
        @RutaOrdenCompra,
        @Estado,
        @Material,
        @FechaEntrega,
        @EstadoInternoOrden,
        @DescripcionInterna
    );

    SELECT SCOPE_IDENTITY() AS IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearOrdenCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenCliente]
    @Descripcion VARCHAR(MAX),
    @IdUsuario INT,
    @MetodoPago INT,
    @FechaCreacion DATETIME,
	@RutaOrdenCompra VARCHAR(MAX),
	@Estado INT
AS
BEGIN
    INSERT INTO Orden (Descripcion, IdUsuario, MetodoPago, FechaCreacion, RutaOrdenCompra, Estado)
    VALUES (@Descripcion, @IdUsuario, @MetodoPago, @FechaCreacion, @RutaOrdenCompra, @Estado);

    SELECT SCOPE_IDENTITY() AS IdOrden;
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearOrdenDetalleBocetoAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenDetalleBocetoAdmin]
    @IdOrden BIGINT,
    @IdBoceto BIGINT
AS
BEGIN
    INSERT INTO Orden_Detalle_Bocetos (
        IdOrden,
        IdBoceto
    )
    VALUES (
        @IdOrden,
        @IdBoceto
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearOrdenDetalleBocetoCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenDetalleBocetoCliente]
    @IdOrden BIGINT,
    @IdBoceto BIGINT
AS
BEGIN
    INSERT INTO Orden_Detalle_Bocetos (IdOrden, IdBoceto)
    VALUES (@IdOrden, @IdBoceto);
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearOrdenDetalleCotizacionAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenDetalleCotizacionAdmin]
    @IdOrden BIGINT,
    @IdCotizacion BIGINT
AS
BEGIN
    INSERT INTO Orden_Detalle_Cotizacion (
        IdOrdenCotizacion,
        IdCotizacion
    )
    VALUES (
        @IdOrden,
        @IdCotizacion
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearOrdenDetalleCotizacionCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearOrdenDetalleCotizacionCliente]
    @IdOrden BIGINT,
    @IdCotizacion BIGINT
AS
BEGIN
    INSERT INTO Orden_Detalle_Cotizacion(IdOrdenCotizacion, IdCotizacion)
    VALUES (@IdOrden, @IdCotizacion);
END;
GO
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionDetalle]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearSolicitudCotizacionVista]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
		DireccionExacta = @DireccionExacta,
		Estado = @Estado
    WHERE UsuarioId = @UsuarioId;

END

GO
/****** Object:  StoredProcedure [dbo].[EliminarCotizacion]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarCotizacion]
    @IdCotizacion BIGINT
AS
BEGIN
	DELETE FROM Cotizacion_Detalle
    WHERE IdCotizacion = @IdCotizacion;


    DELETE FROM Cotizacion
    WHERE IdCotizacion = @IdCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarPerfilUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[GenerarBoceto]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerBocetosPorCotizacionAdmin]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ObtenerBocetosPorCotizacionAdmin]
    @IdCotizacion BIGINT
AS
BEGIN
	SELECT IdBoceto FROM Cotizacion_Detalle WHERE IdCotizacion = @IdCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerBocetosPorCotizacionCliente]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerBocetosPorCotizacionCliente]
    @IdCotizacion BIGINT
AS
BEGIN
    SELECT IdBoceto FROM Cotizacion_Detalle WHERE IdCotizacion = @IdCotizacion;
END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerBocetosPorSolicitud]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerDetalleCotizacion]    Script Date: 11/12/2024 17:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerDetalleCotizacion]
    @IdCotizacion BIGINT
AS
BEGIN
-- Consulta 1: Información de la Solicitud de Cotización
    SELECT 
        sc.IdSolicitudCotizacion,
        sc.Descripcion,
        sc.FechaCreacion,
		sc.Moneda,
		sc.Estado
    FROM Solicitud_Cotizacion sc
	INNER JOIN Cotizacion c ON c.IdSolicitudCotizacion = sc.IdSolicitudCotizacion
    WHERE sc.IdSolicitudCotizacion = c.IdSolicitudCotizacion;

    -- Consulta 2: Información del Usuario
    SELECT 
        u.UsuarioId,
        u.NombreCompleto,
        u.CorreoElectronico,
        u.NumeroTelefono,
		u.NombreEmpresa
    FROM Usuario u
    INNER JOIN Cotizacion c ON u.UsuarioId = c.IdUsuario
    WHERE c.IdCotizacion = @IdCotizacion;

    -- Consulta 3: Información de la Cotización
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
/****** Object:  StoredProcedure [dbo].[ObtenerListaUsuarios]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[RecuperaContrasennaCodigo]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[Recuperar]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Detalles_Cliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 11/12/2024 17:43:12 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarContrasennaActual]    Script Date: 11/12/2024 17:43:12 ******/
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
