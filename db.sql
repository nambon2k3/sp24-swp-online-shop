USE [master]
GO
/****** Object:  Database [swp-online-shop]    Script Date: 5/19/2024 1:50:12 PM ******/
CREATE DATABASE [swp-online-shop]
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
/****** Object:  Table [dbo].[Cart]    Script Date: 5/19/2024 1:50:13 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 5/19/2024 1:50:13 PM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 5/19/2024 1:50:13 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 5/19/2024 1:50:13 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 5/19/2024 1:50:13 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 5/19/2024 1:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[Content] [text] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/19/2024 1:50:13 PM ******/
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
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 5/19/2024 1:50:13 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 5/19/2024 1:50:13 PM ******/
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
/****** Object:  Table [dbo].[Slider]    Script Date: 5/19/2024 1:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImageURL] [nvarchar](255) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 5/19/2024 1:50:13 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/19/2024 1:50:13 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, 1, N'Men T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, 1, N'Men Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (4, 1, N'Men Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (5, 2, N'Women Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (6, 2, N'Women Blouse', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (7, 2, N'Women Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (8, 3, N'Kids T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (9, 3, N'Kids Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (10, 3, N'Kids Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (11, 1, N'Men Sweater', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (12, 1, N'Men Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (13, 2, N'Women T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (14, 2, N'Women Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (15, 3, N'Kids Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (16, 3, N'Kids Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (17, 1, N'Men Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (18, 2, N'Women Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (19, 3, N'Kids Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (20, 1, N'Men Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (21, 2, N'Women Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
GO
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (22, 3, N'Kids Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1)
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
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, N'user1', N'pass1', N'John Doe', N'Male', N'123 Main St', N'1234567890', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1)
GO
INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, N'user2', N'pass2', N'Jane Smith', N'Female', N'456 Elm St', N'0987654321', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__A9D10534A141228D]    Script Date: 5/19/2024 1:50:13 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D10534DFDE0780]    Script Date: 5/19/2024 1:50:13 PM ******/
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
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Slider] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Slider] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetail] ([ID])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([OrderDetailID])
REFERENCES [dbo].[OrderDetail] ([ID])
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
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[ProductDetail]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
USE [master]
GO
ALTER DATABASE [swp-online-shop] SET  READ_WRITE 
GO
