USE [master]
GO
/****** Object:  Database [Nike]    Script Date: 24/01/2024 9:10:34 SA ******/
CREATE DATABASE [Nike]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Nike', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.THANHTOAN\MSSQL\DATA\Nike.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Nike_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.THANHTOAN\MSSQL\DATA\Nike_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Nike] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Nike].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Nike] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Nike] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Nike] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Nike] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Nike] SET ARITHABORT OFF 
GO
ALTER DATABASE [Nike] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Nike] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Nike] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Nike] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Nike] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Nike] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Nike] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Nike] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Nike] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Nike] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Nike] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Nike] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Nike] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Nike] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Nike] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Nike] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Nike] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Nike] SET RECOVERY FULL 
GO
ALTER DATABASE [Nike] SET  MULTI_USER 
GO
ALTER DATABASE [Nike] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Nike] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Nike] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Nike] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Nike] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Nike] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Nike', N'ON'
GO
ALTER DATABASE [Nike] SET QUERY_STORE = ON
GO
ALTER DATABASE [Nike] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Nike]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] NOT NULL,
	[CatName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProId] [int] IDENTITY(1,1) NOT NULL,
	[ProName] [nvarchar](50) NULL,
	[ProImage] [nvarchar](100) NULL,
	[ProPrice] [decimal](15, 3) NULL,
	[TypeOf] [nvarchar](10) NULL,
	[CategoryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Product_Category]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Create Product_Category View 
Create view [dbo].[Product_Category] as
Select ProId, ProName, ProImage, ProPrice, TypeOf, Category.CategoryId, CatName
From Product inner join Category on Product.CategoryId=Category.CategoryId
GO
/****** Object:  Table [dbo].[Role]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] NOT NULL,
	[RoleName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[UserEmail] [nvarchar](100) NULL,
	[UserPassword] [varchar](255) NULL,
	[RoleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[User_Role]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create view [dbo].[User_Role] as
Select UserId, UserName, UserPassword, [User].RoleId
From [User] inner join [Role] on [User].RoleID = Role.RoleID
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[SummaryContent] [nvarchar](2000) NULL,
	[BlogAvata] [nvarchar](255) NULL,
	[Content] [ntext] NULL,
	[AuthorId] [int] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderName] [nvarchar](50) NULL,
	[OrderDate] [date] NULL,
	[PaymentType] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](100) NULL,
	[CustomerPhone] [nvarchar](15) NULL,
	[CustomerEmail] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](250) NULL,
	[CustomerNote] [nvarchar](2000) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 24/01/2024 9:10:34 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [float] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (0, N'Swiper')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (1, N'Hoodies')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (2, N'Shorts')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (3, N'Jackets')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (4, N'Tracksuits')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (5, N'Shoes')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (6, N'Socks')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (7, N'T-shirts')
INSERT [dbo].[Category] ([CategoryId], [CatName]) VALUES (8, N'Trousers')
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (1, N'Air Force 1', N'/images/swiper/air-force1.jpg', CAST(1450.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (2, N'Air Joden 1', N'/images/swiper/air-jordan1.jpg', CAST(1970.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (3, N'Air Max', N'/images/swiper/air-max.jpg', CAST(2450.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (4, N'Metcon', N'/images/swiper/metcon.jpg', CAST(2100.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (5, N'Nike Blazer', N'/images/swiper/nike-blazer.jpg', CAST(1970.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (6, N'Pegasus Running', N'/images/swiper/pegasus-running.jpg', CAST(1240.000 AS Decimal(15, 3)), N'Unisex', 0)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (7, N'Cozy Nike', N'/images/hoodies/hoodie1.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (8, N'Warm Nike', N'/images/hoodies/hoodie2.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Women', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (9, N'Soft Nike', N'/images/hoodies/hoodie3.jpg', CAST(1790.000 AS Decimal(15, 3)), N'Women', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (10, N'Comfy Nike', N'/images/hoodies/hoodie4.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (11, N'Casual Nike', N'/images/hoodies/hoodie5.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (12, N'Stylish Nike', N'/images/hoodies/hoodie6.jpg', CAST(2190.000 AS Decimal(15, 3)), N'Unisex', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (13, N'Fashionable Nike', N'/images/hoodies/hoodie7.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (14, N'Trendy Nike', N'/images/hoodies/hoodie8.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Women', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (15, N'Chic Nike', N'/images/hoodies/hoodie9.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Unisex', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (16, N'Modern Nike', N'/images/hoodies/hoodie10.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (17, N'Cool Nike', N'/images/hoodies/hoodie11.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (18, N'Casual Nike', N'/images/hoodies/hoodie12.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Men', 1)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (19, N'Casual Nike', N'/images/shorts/short1.jpg', CAST(890.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (20, N'Sporty Nike', N'/images/shorts/short2.jpg', CAST(950.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (21, N'Comfy Nike', N'/images/shorts/short3.jpg', CAST(890.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (22, N'Stylish Nike', N'/images/shorts/short4.jpg', CAST(990.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (23, N'Chic Nike', N'/images/shorts/short5.jpg', CAST(950.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (24, N'Trendy Nike', N'/images/shorts/short6.jpg', CAST(990.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (25, N'Modern Nike', N'/images/shorts/short7.jpg', CAST(950.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (26, N'Fashionable Nike', N'/images/shorts/short8.jpg', CAST(990.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (27, N'Elegant Nike', N'/images/shorts/short9.jpg', CAST(950.000 AS Decimal(15, 3)), N'Unisex', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (28, N'Urban Nike', N'/images/shorts/short10.jpg', CAST(890.000 AS Decimal(15, 3)), N'Women', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (29, N'Cool Nike', N'/images/shorts/short11.jpg', CAST(990.000 AS Decimal(15, 3)), N'Men', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (30, N'Casual Nike', N'/images/shorts/short12.jpg', CAST(890.000 AS Decimal(15, 3)), N'Women', 2)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (31, N'Stylish Nike', N'/images/jackets/jacket1.jpg', CAST(2450.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (32, N'Elegant Nike', N'/images/jackets/jacket2.jpg', CAST(2550.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (33, N'Sporty Nike', N'/images/jackets/jacket3.jpg', CAST(2650.000 AS Decimal(15, 3)), N'Kids', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (34, N'Classic Nike', N'/images/jackets/jacket4.jpg', CAST(2350.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (35, N'Casual Nike', N'/images/jackets/jacket5.jpg', CAST(2450.000 AS Decimal(15, 3)), N'Women', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (36, N'Chic Nike', N'/images/jackets/jacket6.jpg', CAST(2550.000 AS Decimal(15, 3)), N'Women', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (37, N'Modern Nike', N'/images/jackets/jacket7.jpg', CAST(2650.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (38, N'Trendy Nike', N'/images/jackets/jacket8.jpg', CAST(2350.000 AS Decimal(15, 3)), N'Unisex', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (39, N'Fashionable Nike', N'/images/jackets/jacket9.jpg', CAST(2450.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (40, N'Urban Nike', N'/images/jackets/jacket10.jpg', CAST(2550.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (41, N'Cool Nike', N'/images/jackets/jacket11.jpg', CAST(2650.000 AS Decimal(15, 3)), N'Kids', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (42, N'Casual Nike', N'/images/jackets/jacket12.jpg', CAST(2200.000 AS Decimal(15, 3)), N'Men', 3)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (43, N'Sporty Nike', N'/images/tracksuits/tracksuit1.jpg', CAST(2790.000 AS Decimal(15, 3)), N'Unisex', 4)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (44, N'Casual Nike', N'/images/tracksuits/tracksuit2.jpg', CAST(2690.000 AS Decimal(15, 3)), N'Kids', 4)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (45, N'Chic Nike', N'/images/tracksuits/tracksuit3.jpg', CAST(2990.000 AS Decimal(15, 3)), N'Kids', 4)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (46, N'Stylish Nike', N'/images/tracksuits/tracksuit4.jpg', CAST(2890.000 AS Decimal(15, 3)), N'Unisex', 4)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (47, N'Casual Nike', N'/images/shoes/shoe1.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (48, N'Sporty Nike', N'/images/shoes/shoe2.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (49, N'Comfy Nike', N'/images/shoes/shoe3.jpg', CAST(1790.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (50, N'Stylish Nike', N'/images/shoes/shoe4.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (51, N'Chic Nike', N'/images/shoes/shoe5.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (52, N'Trendy Nike', N'/images/shoes/shoe6.jpg', CAST(2190.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (53, N'Modern Nike', N'/images/shoes/shoe7.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (54, N'Fashionable Nike', N'/images/shoes/shoe8.jpg', CAST(2190.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (55, N'Elegant Nike', N'/images/shoes/shoe9.jpg', CAST(1990.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (56, N'Urban Nike', N'/images/shoes/shoe10.jpg', CAST(1890.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (57, N'Cool Nike	', N'/images/shoes/shoe11.jpg', CAST(2090.000 AS Decimal(15, 3)), N'Unisex', 5)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (58, N'Casual Nike', N'/images/socks/sock1.jpg', CAST(150.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (59, N'Sporty Nike', N'/images/socks/sock2.jpg', CAST(120.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (60, N'Chic Nike', N'/images/socks/sock3.jpg', CAST(180.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (61, N'Stylish Nike', N'/images/socks/sock4.jpg', CAST(160.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (62, N'Trendy Nike', N'/images/socks/sock5.jpg', CAST(130.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (63, N'Elegant Nike', N'/images/socks/sock6.jpg', CAST(170.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (64, N'Casual Nike', N'/images/socks/sock7.jpg', CAST(140.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (65, N'Sporty Nike', N'/images/socks/sock8.jpg', CAST(160.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (66, N'Chic Nike', N'/images/socks/sock9.jpg', CAST(190.000 AS Decimal(15, 3)), N'Unisex', 6)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (67, N'Casual Nike', N'/images/t-shirts/t-shirt1.jpg', CAST(350.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (68, N'Sporty Nike', N'/images/t-shirts/t-shirt2.jpg', CAST(390.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (69, N'Comfy Nike', N'/images/t-shirts/t-shirt3.jpg', CAST(320.000 AS Decimal(15, 3)), N'Unisex', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (70, N'Stylish Nike', N'/images/t-shirts/t-shirt4.jpg', CAST(420.000 AS Decimal(15, 3)), N'Women', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (71, N'Chic Nike', N'/images/t-shirts/t-shirt5.jpg', CAST(390.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (72, N'Trendy Nike', N'/images/t-shirts/t-shirt6.jpg', CAST(450.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (73, N'Modern Nike', N'/images/t-shirts/t-shirt7.jpg', CAST(420.000 AS Decimal(15, 3)), N'Unisex', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (74, N'Fashionable Nike', N'/images/t-shirts/t-shirt8.jpg', CAST(450.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (75, N'Elegant Nike', N'/images/t-shirts/t-shirt9.jpg', CAST(390.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (76, N'Urban Nike', N'/images/t-shirts/t-shirt10.jpg', CAST(350.000 AS Decimal(15, 3)), N'Men', 7)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (77, N'Casual Nike', N'/images/trousers/trouser1.jpg', CAST(550.000 AS Decimal(15, 3)), N'Women', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (78, N'Sporty Nike', N'/images/trousers/trouser2.jpg', CAST(590.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (79, N'Comfy Nike', N'/images/trousers/trouser3.jpg', CAST(520.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (80, N'Stylish Nike', N'/images/trousers/trouser4.jpg', CAST(620.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (81, N'Chic Nike', N'/images/trousers/trouser5.jpg', CAST(590.000 AS Decimal(15, 3)), N'Women', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (82, N'Trendy Nike', N'/images/trousers/trouser6.jpg', CAST(650.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (83, N'Modern Nike', N'/images/trousers/trouser7.jpg', CAST(620.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (84, N'Fashionable Nike', N'/images/trousers/trouser8.jpg', CAST(650.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (85, N'Elegant Nike', N'/images/trousers/trouser9.jpg', CAST(590.000 AS Decimal(15, 3)), N'Unisex', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (86, N'Urban Nike', N'/images/trousers/trouser10.jpg', CAST(550.000 AS Decimal(15, 3)), N'Unisex', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (87, N'Cool Nike', N'/images/trousers/trouser10.jpg', CAST(550.000 AS Decimal(15, 3)), N'Men', 8)
INSERT [dbo].[Product] ([ProId], [ProName], [ProImage], [ProPrice], [TypeOf], [CategoryId]) VALUES (88, N'Casual Nike', N'/images/trousers/trouser10.jpg', CAST(550.000 AS Decimal(15, 3)), N'Men', 8)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (0, N'Customer')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [UserEmail], [UserPassword], [RoleId]) VALUES (7, N'123', NULL, NULL, 1)
INSERT [dbo].[User] ([UserId], [UserName], [UserEmail], [UserPassword], [RoleId]) VALUES (8, N'123', NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD FOREIGN KEY([AuthorId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
USE [master]
GO
ALTER DATABASE [Nike] SET  READ_WRITE 
GO
