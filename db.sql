USE [master]
GO
/****** Object:  Database [swp-online-shop]    Script Date: 6/4/2024 11:07:56 PM ******/
CREATE DATABASE [swp-online-shop]
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
/****** Object:  Table [dbo].[Cart]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 6/4/2024 11:07:56 PM ******/
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
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Slider]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 6/4/2024 11:07:56 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 6/4/2024 11:07:56 PM ******/
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
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, 1, 4, 1, 0, CAST(N'2024-06-04T20:14:59.630' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, 1, 5, 1, 0, CAST(N'2024-06-04T20:15:03.360' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (4, 1, 6, 1, 0, CAST(N'2024-06-04T20:15:11.513' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (5, 1, 7, 1, 0, CAST(N'2024-06-04T20:15:16.227' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (6, 1, 8, 1, 0, CAST(N'2024-06-04T20:15:20.420' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (7, 1, 9, 1, 0, CAST(N'2024-06-04T20:15:23.357' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (8, 1, 10, 1, 0, CAST(N'2024-06-04T20:15:26.860' AS DateTime), 2)
INSERT [dbo].[Cart] ([ID], [UserID], [ProductDetailID], [Quantity], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (9, 1, 11, 1, 0, CAST(N'2024-06-04T20:15:30.263' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, N'Men Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, N'Women Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
INSERT [dbo].[Category] ([ID], [Name], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, N'Kids Clothing', 0, CAST(N'2024-05-19T10:52:57.557' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [UserID], [Fullname], [Address], [Phone], [Status], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, 1, N'nam', N'hn', N'123123', N'shipping', 0, CAST(N'2024-06-04T22:57:59.490' AS DateTime), 1)
INSERT [dbo].[Order] ([ID], [UserID], [Fullname], [Address], [Phone], [Status], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, 1, N'nam2', N'hn', N'123123', N'shipping', 0, CAST(N'2024-06-04T22:58:04.070' AS DateTime), 1)
INSERT [dbo].[Order] ([ID], [UserID], [Fullname], [Address], [Phone], [Status], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (3, 1, N'nam3', N'hn', N'123123', N'shipping', 0, CAST(N'2024-06-04T22:58:08.820' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductDetailID], [IsDeleted], [CreatedAt], [CreatedBy], [quantity]) VALUES (1, 1, 4, 0, CAST(N'2024-06-04T22:59:37.740' AS DateTime), 1, 2)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductDetailID], [IsDeleted], [CreatedAt], [CreatedBy], [quantity]) VALUES (2, 1, 5, 0, CAST(N'2024-06-04T22:59:41.610' AS DateTime), 1, 3)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductDetailID], [IsDeleted], [CreatedAt], [CreatedBy], [quantity]) VALUES (3, 1, 6, 0, CAST(N'2024-06-04T22:59:46.580' AS DateTime), 1, 4)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductDetailID], [IsDeleted], [CreatedAt], [CreatedBy], [quantity]) VALUES (4, 1, 7, 0, CAST(N'2024-06-04T22:59:50.327' AS DateTime), 1, 5)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductDetailID], [IsDeleted], [CreatedAt], [CreatedBy], [quantity]) VALUES (5, 1, 8, 0, CAST(N'2024-06-04T22:59:53.730' AS DateTime), 1, 6)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (12, 1, N'Great product!', N'I absolutely love this product. Highly recommended!', 0, CAST(N'2024-01-15T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (13, 2, N'Not satisfied', N'The product did not meet my expectations.', 0, CAST(N'2024-01-16T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (14, 3, N'Excellent quality', N'The quality is superb. Will buy again.', 0, CAST(N'2024-01-17T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (15, 1, N'Value for money', N'Great value for the price.', 0, CAST(N'2024-01-18T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (16, 2, N'Not worth it', N'The product broke after a week of use.', 1, CAST(N'2024-01-19T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (17, 3, N'Very happy', N'I am very happy with my purchase.', 0, CAST(N'2024-01-20T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (18, 1, N'Disappointed', N'Did not perform as advertised.', 1, CAST(N'2024-01-21T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (19, 2, N'Good customer service', N'Customer service was very helpful.', 0, CAST(N'2024-01-22T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (20, 3, N'Highly recommend', N'Would highly recommend to others.', 0, CAST(N'2024-01-23T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (21, 1, N'Average product', N'It is an average product for the price.', 0, CAST(N'2024-01-24T00:00:00.000' AS DateTime), 3, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (22, 2, N'Fast shipping', N'The product arrived quickly.', 0, CAST(N'2024-01-25T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (23, 3, N'Terrible experience', N'I had a terrible experience with this product.', 1, CAST(N'2024-01-26T00:00:00.000' AS DateTime), 4, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (24, 3, N'Very durable', N'The product is very durable and long-lasting.', 0, CAST(N'2024-01-27T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (25, 1, N'Poor quality', N'Quality is not as expected.', 1, CAST(N'2024-01-28T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (26, 1, N'Satisfied', N'Overall, I am satisfied with the purchase.', 0, CAST(N'2024-01-29T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (27, 2, N'Excellent choice', N'Excellent choice for the price.', 0, CAST(N'2024-01-30T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (28, 3, N'Not recommended', N'I would not recommend this product.', 1, CAST(N'2024-01-31T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (29, 3, N'Superb', N'The product is superb in every way.', 0, CAST(N'2024-02-01T00:00:00.000' AS DateTime), 2, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (30, 2, N'Okay product', N'It is an okay product, nothing special.', 0, CAST(N'2024-02-02T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (31, 2, N'Will buy again', N'Definitely will buy this product again.', 0, CAST(N'2024-02-03T00:00:00.000' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (32, 2, N'test2', N'test123123', 0, CAST(N'2024-05-20T19:44:46.490' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (33, 1, N'tesy', N'ádasd', 0, CAST(N'2024-05-22T01:05:52.463' AS DateTime), 1, N'https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (34, 1, N'tesyasdasd', N'sdfsdfdsf', 0, CAST(N'2024-05-22T10:16:53.493' AS DateTime), 1, NULL)
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (35, 1, N'hehe', N'asdasdasd', 0, CAST(N'2024-05-22T10:17:50.590' AS DateTime), 1, N'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (36, 1, N'hehe', N'a´dasd', 0, CAST(N'2024-05-22T20:36:31.500' AS DateTime), 1, N'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D')
INSERT [dbo].[Post] ([ID], [CategoryID], [Title], [Content], [IsDeleted], [CreatedAt], [CreatedBy], [imgURL]) VALUES (37, 2, N'123123', N'a´dasd', 1, CAST(N'2024-05-22T20:36:52.873' AS DateTime), 1, N'data:image/jpeg;base64,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')
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (2, 1, N'Men T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (3, 1, N'Men Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (4, 1, N'Men Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (5, 2, N'Women Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (6, 2, N'Women Blouse', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (7, 2, N'Women Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (8, 3, N'Kids T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (9, 3, N'Kids Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (10, 3, N'Kids Jacket', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (11, 1, N'Men Sweater', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (12, 1, N'Men Shorts', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (13, 2, N'Women T-Shirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (14, 2, N'Women Jeans', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (15, 3, N'Kids Dress', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (16, 3, N'Kids Skirt', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (17, 1, N'Men Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (18, 2, N'Women Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (19, 3, N'Kids Hat', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (20, 1, N'Men Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (21, 2, N'Women Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
INSERT [dbo].[Product] ([ID], [CategoryID], [Name], [IsDeleted], [CreatedAt], [CreatedBy], [description]) VALUES (22, 3, N'Kids Socks', 0, CAST(N'2024-05-19T10:53:03.030' AS DateTime), 1, N'This is a contemporary clothing store in the heart of downtown that offers chic and stylish clothing for both men and women. From romantic lace and flowy maxi dresses to edgy leather jackets and timeless trench coats, this store has something for everyone.')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductDetail] ON 

INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (4, 2, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'32', N'Black', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (5, 2, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'34', N'Blue', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (6, 3, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Brown', 20, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (7, 3, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'XL', N'Black', 20, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (8, 4, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'S', N'Red', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (9, 4, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Green', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (10, 5, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'White', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (11, 5, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Blue', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (12, 6, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Black', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (13, 6, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Red', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (14, 7, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Yellow', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (15, 7, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'6', N'Pink', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (16, 8, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Blue', 80, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (17, 8, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'6', N'Green', 80, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (18, 9, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'7', N'Red', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (19, 9, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'8', N'Blue', 30, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (20, 10, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Gray', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (21, 10, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'XL', N'Navy', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (22, 11, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'32', N'Khaki', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (23, 11, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'34', N'Black', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (24, 12, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Pink', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (25, 12, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'White', 70, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (26, 13, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'28', N'Dark Blue', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (27, 13, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'30', N'Light Blue', 50, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (28, 14, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'4', N'Purple', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (29, 14, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'Yellow', 40, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (30, 15, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'4', N'Pink', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (31, 15, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'5', N'White', 60, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (32, 16, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Black', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (33, 16, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Gray', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (34, 17, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Red', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (35, 17, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'White', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (36, 18, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Blue', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (37, 18, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'One Size', N'Pink', 100, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (38, 19, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Black', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (39, 19, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'White', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (40, 20, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Gray', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 100, 10)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (41, 20, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'L', N'Pink', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (42, 21, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'S', N'Yellow', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 150, 15)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount]) VALUES (43, 21, N'https://cdn.pixabay.com/photo/2024/05/13/04/47/ai-generated-8758045_640.jpg', N'M', N'Green', 200, 0, CAST(N'2024-05-19T10:54:44.547' AS DateTime), 1, 200, 20)
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (1, N'Admin', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (2, N'Marketing', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (3, N'Sale', 0, CAST(N'2024-05-19T13:48:28.640' AS DateTime))
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (4, N'Sale leader', 0, CAST(N'2024-05-19T13:48:50.670' AS DateTime))
INSERT [dbo].[Role] ([ID], [Name], [IsDeleted], [CreatedAt]) VALUES (5, N'User', 0, CAST(N'2024-05-19T13:48:59.990' AS DateTime))
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (1, N'user1', N'pass1', N'John Doe', N'Male', N'123 Main St', N'1234567890', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [Email], [Password], [Fullname], [Gender], [Address], [Phone], [IsDeleted], [CreatedAt], [CreatedBy]) VALUES (2, N'user2', N'pass2', N'Jane Smith', N'Female', N'456 Elm St', N'0987654321', 0, CAST(N'2024-05-19T10:53:56.770' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__A9D10534753A329D]    Script Date: 6/4/2024 11:07:56 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D105340B285B30]    Script Date: 6/4/2024 11:07:56 PM ******/
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
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
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
