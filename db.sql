USE [swp-online-shop]
GO
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [FK__Staff__Role__6383C8BA]
GO
ALTER TABLE [dbo].[Slider] DROP CONSTRAINT [FK__Slider__ProductI__628FA481]
GO
ALTER TABLE [dbo].[Settings] DROP CONSTRAINT [FK__Settings__Create__619B8048]
GO
ALTER TABLE [dbo].[ProductDetail] DROP CONSTRAINT [FK__ProductDe__Produ__60A75C0F]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK__Product__Created__5FB337D6]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK__Product__Categor__5EBF139D]
GO
ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK__Post__CategoryID__5DCAEF64]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__Produ__5CD6CB2B]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__Order__5BE2A6F2]
GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK__Order__UserID__5AEE82B9]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK__Cart__UserID__59FA5E80]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK__Cart__ProductDet__59063A47]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__User__Avatar__5812160E]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__User__CreatedAt__571DF1D5]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__User__IsDeleted__5629CD9C]
GO
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF__Staff__Avatar__5535A963]
GO
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF__Staff__CreatedAt__5441852A]
GO
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF__Staff__IsDeleted__534D60F1]
GO
ALTER TABLE [dbo].[Slider] DROP CONSTRAINT [DF__Slider__CreatedA__52593CB8]
GO
ALTER TABLE [dbo].[Slider] DROP CONSTRAINT [DF__Slider__IsDelete__5165187F]
GO
ALTER TABLE [dbo].[Settings] DROP CONSTRAINT [DF__Settings__isDele__5070F446]
GO
ALTER TABLE [dbo].[Settings] DROP CONSTRAINT [DF__Settings__Create__4F7CD00D]
GO
ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF__Role__CreatedAt__4E88ABD4]
GO
ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF__Role__IsDeleted__4D94879B]
GO
ALTER TABLE [dbo].[ProductDetail] DROP CONSTRAINT [DF__ProductDe__Creat__4CA06362]
GO
ALTER TABLE [dbo].[ProductDetail] DROP CONSTRAINT [DF__ProductDe__IsDel__4BAC3F29]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__Product__Created__4AB81AF0]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__Product__Created__49C3F6B7]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__Product__IsDelet__48CFD27E]
GO
ALTER TABLE [dbo].[Post] DROP CONSTRAINT [DF__Post__CreatedAt__47DBAE45]
GO
ALTER TABLE [dbo].[Post] DROP CONSTRAINT [DF__Post__IsDeleted__46E78A0C]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [DF__OrderDeta__Creat__45F365D3]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [DF__OrderDeta__IsDel__44FF419A]
GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF__Order__CreatedAt__440B1D61]
GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF__Order__IsDeleted__4316F928]
GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF__Order__Status__4222D4EF]
GO
ALTER TABLE [dbo].[Feedback] DROP CONSTRAINT [DF__Feedback__Create__412EB0B6]
GO
ALTER TABLE [dbo].[Feedback] DROP CONSTRAINT [DF__Feedback__IsDele__403A8C7D]
GO
ALTER TABLE [dbo].[Category] DROP CONSTRAINT [DF__Category__Create__3F466844]
GO
ALTER TABLE [dbo].[Category] DROP CONSTRAINT [DF__Category__IsDele__3E52440B]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [DF__Cart__CreatedAt__3D5E1FD2]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [DF__Cart__IsDeleted__3C69FB99]
GO
/****** Object:  Index [UQ__User__A9D10534696CEDC0]    Script Date: 6/8/2024 10:36:02 PM ******/
ALTER TABLE [dbo].[User] DROP CONSTRAINT [UQ__User__A9D10534696CEDC0]
GO
/****** Object:  Index [UQ__Staff__A9D105341F7329ED]    Script Date: 6/8/2024 10:36:02 PM ******/
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [UQ__Staff__A9D105341F7329ED]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Staff]') AND type in (N'U'))
DROP TABLE [dbo].[Staff]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Slider]') AND type in (N'U'))
DROP TABLE [dbo].[Slider]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Settings]') AND type in (N'U'))
DROP TABLE [dbo].[Settings]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type in (N'U'))
DROP TABLE [dbo].[Role]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductDetail]') AND type in (N'U'))
DROP TABLE [dbo].[ProductDetail]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Post]') AND type in (N'U'))
DROP TABLE [dbo].[Post]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetail]') AND type in (N'U'))
DROP TABLE [dbo].[OrderDetail]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
DROP TABLE [dbo].[Order]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Feedback]') AND type in (N'U'))
DROP TABLE [dbo].[Feedback]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
DROP TABLE [dbo].[Category]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 6/8/2024 10:36:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cart]') AND type in (N'U'))
DROP TABLE [dbo].[Cart]
GO
USE [master]
GO
/****** Object:  Database [swp-online-shop]    Script Date: 6/8/2024 10:36:02 PM ******/
DROP DATABASE [swp-online-shop]
GO
/****** Object:  Database [swp-online-shop]    Script Date: 6/8/2024 10:36:02 PM ******/
CREATE DATABASE [swp-online-shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'swp-online-shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\swp-online-shop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'swp-online-shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\swp-online-shop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [swp-online-shop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [swp-online-shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [swp-online-shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [swp-online-shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [swp-online-shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [swp-online-shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [swp-online-shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [swp-online-shop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [swp-online-shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [swp-online-shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [swp-online-shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [swp-online-shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [swp-online-shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [swp-online-shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [swp-online-shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [swp-online-shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [swp-online-shop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [swp-online-shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [swp-online-shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [swp-online-shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [swp-online-shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [swp-online-shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [swp-online-shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [swp-online-shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [swp-online-shop] SET RECOVERY FULL 
GO
ALTER DATABASE [swp-online-shop] SET  MULTI_USER 
GO
ALTER DATABASE [swp-online-shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [swp-online-shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [swp-online-shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [swp-online-shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [swp-online-shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [swp-online-shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'swp-online-shop', N'ON'
GO
ALTER DATABASE [swp-online-shop] SET QUERY_STORE = OFF
GO
USE [swp-online-shop]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ProductDetailID] [int] NULL,
	[Quantity] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDetailID] [int] NULL,
	[Rating] [int] NULL,
	[Comment] [text] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Fullname] [varchar](100) NULL,
	[Address] [varchar](255) NULL,
	[Phone] [varchar](20) NULL,
	[Status] [varchar](100) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductDetailID] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[Content] [text] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[imgURL] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[description] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ImageURL] [nvarchar](255) NULL,
	[Size] [varchar](20) NULL,
	[Color] [varchar](50) NULL,
	[Stock] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[price] [float] NULL,
	[discount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NULL,
	[Value] [varchar](150) NULL,
	[Order] [int] NULL,
	[CreatedBy] [int] NULL,
	[isDeleted] [bit] NULL,
	[description] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ProductId] [int] NULL,
	[Notes] [nvarchar](255) NULL,
	[Backlink] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](100) NULL,
	[Fullname] [varchar](100) NULL,
	[Gender] [varchar](10) NULL,
	[Address] [varchar](255) NULL,
	[Phone] [varchar](20) NULL,
	[Role] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[Avatar] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/8/2024 10:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](100) NULL,
	[Fullname] [varchar](100) NULL,
	[Gender] [varchar](10) NULL,
	[Address] [varchar](255) NULL,
	[Phone] [varchar](20) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[Avatar] [text] NULL,
	[ChangeHistory] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, N'Men Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
GO
INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, N'Women Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
GO
INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, N'Kids Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, 1, 5, N'Excellent product!', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, 1, 4, N'Great value, satisfied with purchase.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, 1, 3, N'Instructions a bit confusing.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (4, 1, 5, N'Highly recommend to others!', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (5, 1, 4, N'User-friendly design, easy to use.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (6, 1, 2, N'Missing a small component.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (7, 1, 5, N'Exceeded expectations, very pleased!', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (8, 1, 4, N'Good quality materials, happy with it.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (9, 1, 3, N'Delivery took longer than expected.', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
INSERT [dbo].[Feedback] ([ID], [OrderDetailID], [Rating], [Comment], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (10, 1, 5, N'Absolutely love it!', 0, CAST(N'2024-06-06T23:35:34.503' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (12, 1, N'Great product!', N'I absolutely love this product. Highly recommended!', 0, CAST(N'2024-01-15T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (13, 2, N'Not satisfied', N'The product did not meet my expectations.', 0, CAST(N'2024-01-16T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (14, 3, N'Excellent quality', N'The quality is superb. Will buy again.', 0, CAST(N'2024-01-17T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (15, 1, N'Value for money', N'Great value for the price.', 0, CAST(N'2024-01-18T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (16, 2, N'Not worth it', N'The product broke after a week of use.', 1, CAST(N'2024-01-19T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (17, 3, N'Very happy', N'I am very happy with my purchase.', 0, CAST(N'2024-01-20T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (18, 1, N'Disappointed', N'Did not perform as advertised.', 1, CAST(N'2024-01-21T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (19, 2, N'Good customer service', N'Customer service was very helpful.', 0, CAST(N'2024-01-22T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (20, 3, N'Highly recommend', N'Would highly recommend to others.', 0, CAST(N'2024-01-23T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (21, 1, N'Average product', N'It is an average product for the price.', 0, CAST(N'2024-01-24T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (22, 2, N'Fast shipping', N'The product arrived quickly.', 0, CAST(N'2024-01-25T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (23, 3, N'Terrible experience', N'I had a terrible experience with this product.', 1, CAST(N'2024-01-26T00:00:00.000' AS DateTime), 4, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (24, 3, N'Very durable', N'The product is very durable and long-lasting.', 0, CAST(N'2024-01-27T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (25, 1, N'Poor quality', N'Quality is not as expected.', 1, CAST(N'2024-01-28T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (26, 1, N'Satisfied', N'Overall, I am satisfied with the purchase.', 0, CAST(N'2024-01-29T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (27, 2, N'Excellent choice', N'Excellent choice for the price.', 0, CAST(N'2024-01-30T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (28, 3, N'Not recommended', N'I would not recommend this product.', 1, CAST(N'2024-01-31T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (29, 3, N'Superb', N'The product is superb in every way.', 0, CAST(N'2024-02-01T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (30, 2, N'Okay product', N'It is an okay product, nothing special.', 0, CAST(N'2024-02-02T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (31, 2, N'Will buy again', N'Definitely will buy this product again.', 0, CAST(N'2024-02-03T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (32, 2, N'test2', N'test123123', 0, CAST(N'2024-05-20T19:44:46.490' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (33, 1, N'tesy', N'ádasd', 0, CAST(N'2024-05-22T01:05:52.463' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (34, 1, N'tesyasdasd', N'sdfsdfdsf', 0, CAST(N'2024-05-22T10:16:53.493' AS DateTime), 1, NULL)
GO
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (35, 1, N'hehe', N'asdasdasd', 0, CAST(N'2024-05-22T10:17:50.590' AS DateTime), 1, N'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D')
GO
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (2, 1, N'Men T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (3, 1, N'Men Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (4, 1, N'Men Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (5, 2, N'Women Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (6, 2, N'Women Blouse', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (7, 2, N'Women Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (8, 3, N'Kids T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (9, 3, N'Kids Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (10, 3, N'Kids Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (11, 1, N'Men Sweater', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (12, 1, N'Men Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (13, 2, N'Women T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (14, 2, N'Women Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (15, 3, N'Kids Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (16, 3, N'Kids Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (17, 1, N'Men Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (18, 2, N'Women Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (19, 3, N'Kids Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (20, 1, N'Men Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (21, 2, N'Women Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [description], [CreatedBy]) VALUES (22, 3, N'Kids Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.', NULL)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductDetail] ON 
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (4, 2, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'32', N'Black', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (5, 2, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'34', N'Blue', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (6, 3, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Brown', 20, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (7, 3, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'XL', N'Black', 20, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (8, 4, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'S', N'Red', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (9, 4, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Green', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (10, 5, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'White', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (11, 5, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Blue', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (12, 6, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Black', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (13, 6, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Red', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (14, 7, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Yellow', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (15, 7, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'6', N'Pink', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (16, 8, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Blue', 80, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (17, 8, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'6', N'Green', 80, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (18, 9, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'7', N'Red', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (19, 9, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'8', N'Blue', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (20, 10, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Gray', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (21, 10, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'XL', N'Navy', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (22, 11, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'32', N'Khaki', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (23, 11, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'34', N'Black', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (24, 12, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Pink', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (25, 12, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'White', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (26, 13, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'28', N'Dark Blue', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (27, 13, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'30', N'Light Blue', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (28, 14, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'4', N'Purple', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (29, 14, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Yellow', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (30, 15, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'4', N'Pink', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (31, 15, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'White', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (32, 16, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Black', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (33, 16, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Gray', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (34, 17, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Red', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (35, 17, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'White', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (36, 18, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Blue', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (37, 18, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Pink', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (38, 19, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Black', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (39, 19, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'White', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (40, 20, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Gray', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (41, 20, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Pink', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (42, 21, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'S', N'Yellow', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (43, 21, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Green', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
GO
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (1, N'Admin', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
GO
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (2, N'Marketing', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
GO
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (3, N'Sale', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
GO
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (4, N'Sale leader', 0, CAST(N'2024-05-19T13:48:50.670' AS DateTime))
GO
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (5, N'User', 0, CAST(N'2024-05-19T13:48:59.990' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Settings] ON 
GO
INSERT [dbo].[Settings] ([ID], [Type], [Value], [Order], [CreatedBy], [isDeleted], [description]) VALUES (1, N'Money', N'VND', 1, 1, 0, N'This is a setting')
GO
INSERT [dbo].[Settings] ([ID], [Type], [Value], [Order], [CreatedBy], [isDeleted], [description]) VALUES (2, N'Time', N'24h', 2, 1, 0, N'This is a setting')
GO
SET IDENTITY_INSERT [dbo].[Settings] OFF
GO
SET IDENTITY_INSERT [dbo].[Slider] ON 
GO
INSERT [dbo].[Slider] ([ID], [Title], [ImageURL], [IsDeleted], [CreatedAt], [CreatedBy], [ProductId], [Notes], [Backlink]) VALUES (1, N'Title 1', N'https://img.freepik.com/premium-vector/modern-sale-banner-website-slider-template-design_54925-46.jpg', 0, CAST(N'2024-06-06T00:00:00.000' AS DateTime), 0, NULL, NULL, N'empty')
GO
INSERT [dbo].[Slider] ([ID], [Title], [ImageURL], [IsDeleted], [CreatedAt], [CreatedBy], [ProductId], [Notes], [Backlink]) VALUES (2, N'Title 2', N'https://i.pinimg.com/736x/b6/89/96/b68996b0aeb13339740f961ada455a77.jpg', 0, CAST(N'2024-06-06T00:00:00.000' AS DateTime), 0, NULL, N'', N'empty')
GO
SET IDENTITY_INSERT [dbo].[Slider] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (1, N'a@a.a', NULL, N'John Doe', N'Male', N'1234 Elm Street, Springfield, IL', N'123-456-7890', 1, 1, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (2, N'user2@example.com', N'hashed_password2', N'Jane Doe', N'Female', N'2345 Oak Street, Springfield, IL', N'234-567-8901', 2, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 2, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (3, N'user3@example.com', N'hashed_password3', N'Jim Beam', N'Male', N'3456 Pine Street, Springfield, IL', N'345-678-9012', 3, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 3, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (4, N'user4@example.com', N'hashed_password4', N'Jack Daniels', N'Male', N'4567 Maple Street, Springfield, IL', N'456-789-0123', 4, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 4, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (5, N'user5@example.com', N'hashed_password5', N'Johnny Walker', N'Male', N'5678 Cedar Street, Springfield, IL', N'567-890-1234', 1, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (6, N'user6@example.com', N'hashed_password6', N'Jill Valentine', N'Female', N'6789 Birch Street, Springfield, IL', N'678-901-2345', 2, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 2, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (7, N'user7@example.com', N'hashed_password7', N'Chris Redfield', N'Male', N'7890 Spruce Street, Springfield, IL', N'789-012-3456', 3, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 3, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (8, N'user8@example.com', N'hashed_password8', N'Claire Redfield', N'Female', N'8901 Redwood Street, Springfield, IL', N'890-123-4567', 4, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 4, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (9, N'user9@example.com', N'hashed_password9', N'Leon Kennedy', N'Male', N'9012 Sequoia Street, Springfield, IL', N'901-234-5678', 1, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (10, N'user10@example.com', N'hashed_password10', N'Ada Wong', N'Female', N'0123 Cypress Street, Springfield, IL', N'012-345-6789', 2, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 2, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (11, N'user11@example.com', N'hashed_password11', N'Albert Wesker', N'Male', N'1234 Fir Street, Springfield, IL', N'123-456-7891', 3, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 3, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (12, N'user12@example.com', N'hashed_password12', N'Rebecca Chambers', N'Female', N'2345 Hemlock Street, Springfield, IL', N'234-567-8902', 4, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 4, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (13, N'user13@example.com', N'hashed_password13', N'Barry Burton', N'Male', N'3456 Palm Street, Springfield, IL', N'345-678-9013', 1, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (14, N'user14@example.com', N'hashed_password14', N'Sherry Birkin', N'Female', N'4567 Mahogany Street, Springfield, IL', N'456-789-0124', 2, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 2, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
INSERT [dbo].[Staff] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [Role], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar]) VALUES (15, N'user15@example.com', N'hashed_password15', N'HUNK', N'Male', N'5678 Teak Street, Springfield, IL', N'567-890-1235', 3, 0, CAST(N'2024-05-22T23:21:10.153' AS DateTime), 3, N'https://www.svgrepo.com/show/452030/avatar-default.svg')
GO
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar], [ChangeHistory]) VALUES (1, N'a', N'123456', N'John Doe', N'Male', N'123 Main St', N'1234567890', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg', NULL)
GO
INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy], [Avatar], [ChangeHistory]) VALUES (2, N'user2@example.com', N'pass2', N'Jane Smith', N'Female', N'456 Elm St', N'0987654321', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1, N'https://www.svgrepo.com/show/452030/avatar-default.svg', N'<br><p><strong>21:07 08-06-2024</strong>: email=user2@example.com, fullname=Jane Smith, gender=Female, address=456 Elm St, phone=0987654321</p><br><p><strong>21:16 08-06-2024</strong>: email=user2@example.com, fullname=Jane Smith, gender=Female, address=456 Elm St, phone=0987654321</p>')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__A9D105341F7329ED]    Script Date: 6/8/2024 10:36:02 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D10534696CEDC0]    Script Date: 6/8/2024 10:36:02 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Settings] ADD  DEFAULT ((1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[Settings] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Slider] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Slider] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT ('https://www.svgrepo.com/show/452030/avatar-default.svg') FOR [Avatar]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ('https://www.svgrepo.com/show/452030/avatar-default.svg') FOR [Avatar]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetail] ([ID])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetail] ([ID])
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[ProductDetail]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Settings]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Slider]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([ID])
GO
USE [master]
GO
ALTER DATABASE [swp-online-shop] SET  READ_WRITE 
GO
