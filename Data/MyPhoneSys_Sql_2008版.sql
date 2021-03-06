USE [master]
GO
/****** Object:  Database [MyPhoneSys]    Script Date: 2018/3/19 22:09:27 ******/
CREATE DATABASE [MyPhoneSys] ON  PRIMARY 
( NAME = N'MyPhoneSys', FILENAME = N'E:\LYR\第三任老师\赖艺仁-MyPhoneSys\MyPhoneSys\Data\MyPhoneSys.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyPhoneSys_log', FILENAME = N'E:\LYR\第三任老师\赖艺仁-MyPhoneSys\MyPhoneSys\Data\MyPhoneSys_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MyPhoneSys] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyPhoneSys].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyPhoneSys] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyPhoneSys] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyPhoneSys] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyPhoneSys] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyPhoneSys] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyPhoneSys] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyPhoneSys] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyPhoneSys] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyPhoneSys] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyPhoneSys] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyPhoneSys] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyPhoneSys] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyPhoneSys] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyPhoneSys] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyPhoneSys] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyPhoneSys] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyPhoneSys] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyPhoneSys] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyPhoneSys] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyPhoneSys] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyPhoneSys] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyPhoneSys] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyPhoneSys] SET RECOVERY FULL 
GO
ALTER DATABASE [MyPhoneSys] SET  MULTI_USER 
GO
ALTER DATABASE [MyPhoneSys] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyPhoneSys] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyPhoneSys', N'ON'
GO
USE [MyPhoneSys]
GO
/****** Object:  UserDefinedFunction [dbo].[Create_Order_NO]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	赖艺仁	<Author,,Name>
-- Create date: 2018-01-09 <Create Date, ,>
-- Description:	生成订单 <Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Create_Order_NO]
(
	
)
returns varchar(20)
as
begin
	--设变量
declare @order varchar(20)
declare @count int

--获取当前日期
set @order ='LYR-'+convert(varchar(10),getdate(),120)+'-'--(112:2018109) (120:2018-01-09)

--获取当前日期的订单数
select @count=count(*) from Orders 
where datediff(day,OrderTime,getdate())=0 --条件判断是否是同一天
set @count=@count+1 --默认从 1 开始

--处理订单序号长度
if(len(@count)=1)
	begin
			set @order+='00'+convert(varchar(50),@count)
	end
else if(len(@count)=2)
    begin
	        set @order+='0'+convert(varchar(50),@count)		
    end
else
	begin
			set @order+=convert(varchar(50),@count)
	end

return @order  --返回订单号
end

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[DetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ShoppID] [int] NULL,
	[Price] [decimal](10, 2) NULL,
	[Quantity] [int] NULL,
	[CancelTime] [datetime] NULL,
	[IsValid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [varchar](30) NOT NULL,
	[UName] [varchar](255) NULL,
	[ConsigneeName] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [varchar](255) NULL,
	[AddressDetail] [varchar](555) NULL,
	[YouZhengBianMa] [varchar](120) NULL,
	[Amount] [decimal](10, 2) NULL,
	[OrderTime] [varchar](255) NULL,
	[OrderState] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneDetail]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneDetail](
	[PhoneDetailID] [int] IDENTITY(1,1) NOT NULL,
	[PhoneInfoID] [int] NULL,
	[gaishu] [varchar](255) NULL,
	[tuji] [varchar](255) NULL,
	[canshu] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PhoneDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneInfo]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneInfo](
	[PhoneInfoID] [int] IDENTITY(1,1) NOT NULL,
	[PhoneTypeID] [int] NULL,
	[PhoneName] [varchar](68) NULL,
	[Price] [decimal](10, 2) NULL,
	[IsXinPin] [varchar](20) NULL,
	[PImage] [varchar](max) NULL,
	[PImage2] [varchar](max) NULL,
	[JiShenYanSe] [varchar](68) NULL,
	[TaoCanLeiXing] [varchar](68) NULL,
	[ShouJiChiCun] [varchar](68) NULL,
	[ShouJiZhongLiang] [varchar](68) NULL,
	[FenBianLv] [varchar](68) NULL,
	[PingMuXiangSuMiDu] [varchar](68) NULL,
	[SheXiangTouLeiXing] [varchar](68) NULL,
	[QianZhiSheXiangTou] [varchar](68) NULL,
	[HouZhiSheXiangTou] [varchar](68) NULL,
	[DianChiRongLiang] [varchar](68) NULL,
	[DianChiLeiXing] [varchar](68) NULL,
	[HeXinShu] [varchar](68) NULL,
	[CPUXingHao] [varchar](68) NULL,
	[CPUPinLv] [varchar](68) NULL,
	[YunXingNeiCun] [varchar](68) NULL,
	[ROMRongLiang] [varchar](68) NULL,
	[ShangShiRiQi] [varchar](68) NULL,
	[ShouJiLeiXing] [varchar](68) NULL,
	[ChuMoPingLeiXing] [varchar](68) NULL,
	[SIMKa] [varchar](68) NULL,
	[CaoZuoXiTong] [varchar](68) NULL,
	[IsValid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PhoneInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneType](
	[PhoneTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PName] [varchar](68) NULL,
PRIMARY KEY CLUSTERED 
(
	[PhoneTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingAddress]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingAddress](
	[ShippingAddressID] [int] IDENTITY(1,1) NOT NULL,
	[UName] [varchar](68) NULL,
	[ShipingPersonName] [varchar](68) NULL,
	[Phone] [varchar](68) NULL,
	[Address] [varchar](520) NULL,
	[DetailAddress] [varchar](268) NULL,
	[YouZhengBianMa] [varchar](68) NULL,
PRIMARY KEY CLUSTERED 
(
	[ShippingAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShopCarts]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShopCarts](
	[ShopCartsID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[Names] [varchar](max) NULL,
	[Price] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
	[Uname] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ShopCartsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UName] [varchar](68) NOT NULL,
	[Phone] [varchar](68) NULL,
	[Email] [varchar](68) NULL,
	[Pwd] [varchar](68) NOT NULL,
	[HeadImage] [varchar](68) NULL,
	[CName] [varchar](68) NULL,
	[Sex] [varchar](68) NULL,
	[Birthday] [varchar](68) NULL,
	[QQ] [varchar](68) NULL,
	[WeiXin] [varchar](68) NULL,
	[ShenFenZheng] [varchar](68) NULL,
	[Address] [varchar](368) NULL,
	[RegisTime] [varchar](68) NULL,
	[LastTime] [varchar](68) NULL,
	[IsVaild] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (118, 20, 4, CAST(1399.00 AS Decimal(10, 2)), 1, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (119, 21, 8, CAST(599.00 AS Decimal(10, 2)), 2, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (120, 21, 11, CAST(999.00 AS Decimal(10, 2)), 1, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (121, 21, 10, CAST(899.00 AS Decimal(10, 2)), 1, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (122, 21, 9, CAST(699.00 AS Decimal(10, 2)), 1, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (123, 21, 2, CAST(1999.00 AS Decimal(10, 2)), 3, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (124, 21, 3, CAST(2299.00 AS Decimal(10, 2)), 1, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (125, 22, 2, CAST(1999.00 AS Decimal(10, 2)), 11, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (126, 22, 3, CAST(2299.00 AS Decimal(10, 2)), 24, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (127, 22, 5, CAST(1499.00 AS Decimal(10, 2)), 12, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (128, 23, 4, CAST(1399.00 AS Decimal(10, 2)), 4, NULL, NULL)
INSERT [dbo].[OrderDetail] ([DetailId], [OrderId], [ShoppID], [Price], [Quantity], [CancelTime], [IsValid]) VALUES (129, 23, 1, CAST(3299.00 AS Decimal(10, 2)), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [OrderNo], [UName], [ConsigneeName], [Phone], [Address], [AddressDetail], [YouZhengBianMa], [Amount], [OrderTime], [OrderState]) VALUES (20, N'LYR-2018-03-12-001', N'小赖', N'顽皮红红', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456', CAST(1399.00 AS Decimal(10, 2)), N'03 12 2018 10:01AM', 0)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [UName], [ConsigneeName], [Phone], [Address], [AddressDetail], [YouZhengBianMa], [Amount], [OrderTime], [OrderState]) VALUES (21, N'LYR-2018-03-12-002', N'小赖', N'睡猪珍珍', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456', CAST(12091.00 AS Decimal(10, 2)), N'03 12 2018 10:01AM', 0)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [UName], [ConsigneeName], [Phone], [Address], [AddressDetail], [YouZhengBianMa], [Amount], [OrderTime], [OrderState]) VALUES (22, N'LYR-2018-03-12-003', N'小赖', N'风流倜傥宣霖', N'12345678910', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456', CAST(95153.00 AS Decimal(10, 2)), N'03 12 2018  7:45PM', 0)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [UName], [ConsigneeName], [Phone], [Address], [AddressDetail], [YouZhengBianMa], [Amount], [OrderTime], [OrderState]) VALUES (23, N'LYR-2018-03-19-001', N'小赖', N'帅帅的小赖', N'13126032004', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456', CAST(8895.00 AS Decimal(10, 2)), N'03 19 2018  3:01PM', 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[PhoneDetail] ON 

INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (1, 1, N'../Images/小米商品/手机详细/小米Mix2/01.png', N'../Images/小米商品/手机详细/小米Mix2/02.png', N'../Images/小米商品/手机详细/小米Mix2/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (2, 2, N'../Images/小米商品/手机详细/小米Note3/01.png', N'../Images/小米商品/手机详细/小米Note3/02.png', N'../Images/小米商品/手机详细/小米Note3/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (3, 3, N'../Images/小米商品/手机详细/小米6/01.png', N'../Images/小米商品/手机详细/小米6/02.png', N'../Images/小米商品/手机详细/小米6/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (4, 4, N'../Images/小米商品/手机详细/小米Max2/01.png', N'../Images/小米商品/手机详细/小米Max2/02.png', N'../Images/小米商品/手机详细/小米Max2/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (5, 5, N'../Images/小米商品/手机详细/小米5X/01.png', N'../Images/小米商品/手机详细/小米5X/02.png', N'../Images/小米商品/手机详细/小米5X/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (6, 6, N'../Images/小米商品/手机详细/红米5/01.png', N'../Images/小米商品/手机详细/红米5/02.png', N'../Images/小米商品/手机详细/红米5/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (7, 7, N'../Images/小米商品/手机详细/红米5/01.png', N'../Images/小米商品/手机详细/红米5/02.png', N'../Images/小米商品/手机详细/红米5/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (8, 8, N'../Images/小米商品/手机详细/红米5A/01.png', N'../Images/小米商品/手机详细/红米5A/02.png', N'../Images/小米商品/手机详细/红米5A/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (9, 9, N'../Images/小米商品/手机详细/红米Note5A标准版/01.png', N'../Images/小米商品/手机详细/红米Note5A标准版/02.png', N'../Images/小米商品/手机详细/红米Note5A标准版/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (10, 10, N'../Images/小米商品/手机详细/红米Note5A增强版/01.png', N'../Images/小米商品/手机详细/红米Note5A增强版/02.png', N'../Images/小米商品/手机详细/红米Note5A增强版/03.png')
INSERT [dbo].[PhoneDetail] ([PhoneDetailID], [PhoneInfoID], [gaishu], [tuji], [canshu]) VALUES (11, 11, N'../Images/小米商品/手机详细/红米Note4X/01.png', N'../Images/小米商品/手机详细/红米Note4X/02.png', N'../Images/小米商品/手机详细/红米Note4X/03.png')
SET IDENTITY_INSERT [dbo].[PhoneDetail] OFF
SET IDENTITY_INSERT [dbo].[PhoneInfo] ON 

INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (1, 1, N'小米MIX2', CAST(3299.00 AS Decimal(10, 2)), N'新品', N'../Images/首页/nav_子菜单/小米手机/01.png', N'../Images/首页/侧边列表/手机电话卡/01.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (2, 1, N'小米Note3', CAST(1999.00 AS Decimal(10, 2)), N'新品', N'../Images/首页/nav_子菜单/小米手机/02.png', N'../Images/首页/侧边列表/手机电话卡/02.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (3, 1, N'小米6', CAST(2299.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/小米手机/03.png', N'../Images/首页/侧边列表/手机电话卡/03.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (4, 1, N'小米Max 2', CAST(1399.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/小米手机/04.png', N'../Images/首页/侧边列表/手机电话卡/04.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (5, 1, N'小米5X', CAST(1499.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/小米手机/05.png', N'../Images/首页/侧边列表/手机电话卡/05.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (6, 2, N'红米5', CAST(799.00 AS Decimal(10, 2)), N'新品', N'../Images/首页/nav_子菜单/红米手机/01.png', N'../Images/首页/侧边列表/手机电话卡/06.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (7, 2, N'红米5 Plus', CAST(999.00 AS Decimal(10, 2)), N'新品', N'../Images/首页/nav_子菜单/红米手机/02.png', N'../Images/首页/侧边列表/手机电话卡/2-01.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (8, 2, N'红米5A', CAST(599.00 AS Decimal(10, 2)), N'新品', N'../Images/首页/nav_子菜单/红米手机/03.png', N'../Images/首页/侧边列表/手机电话卡/2-02.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (9, 2, N'红米Note 5A标准版', CAST(699.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/红米手机/04.png', N'../Images/首页/侧边列表/手机电话卡/2-03.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (10, 2, N'红米Note 5A高配版', CAST(899.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/红米手机/05.png', N'../Images/首页/侧边列表/手机电话卡/2-04.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PhoneInfo] ([PhoneInfoID], [PhoneTypeID], [PhoneName], [Price], [IsXinPin], [PImage], [PImage2], [JiShenYanSe], [TaoCanLeiXing], [ShouJiChiCun], [ShouJiZhongLiang], [FenBianLv], [PingMuXiangSuMiDu], [SheXiangTouLeiXing], [QianZhiSheXiangTou], [HouZhiSheXiangTou], [DianChiRongLiang], [DianChiLeiXing], [HeXinShu], [CPUXingHao], [CPUPinLv], [YunXingNeiCun], [ROMRongLiang], [ShangShiRiQi], [ShouJiLeiXing], [ChuMoPingLeiXing], [SIMKa], [CaoZuoXiTong], [IsValid]) VALUES (11, 2, N'红米Note 4X', CAST(999.00 AS Decimal(10, 2)), N'', N'../Images/首页/nav_子菜单/红米手机/06.png', N'../Images/首页/侧边列表/手机电话卡/2-05.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PhoneInfo] OFF
SET IDENTITY_INSERT [dbo].[PhoneType] ON 

INSERT [dbo].[PhoneType] ([PhoneTypeID], [PName]) VALUES (1, N'小米手机')
INSERT [dbo].[PhoneType] ([PhoneTypeID], [PName]) VALUES (2, N'红米手机')
INSERT [dbo].[PhoneType] ([PhoneTypeID], [PName]) VALUES (3, N'红米手机2')
SET IDENTITY_INSERT [dbo].[PhoneType] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddress] ON 

INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (1, N'小赖', N'帅帅的小赖', N'13126032004', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (2, N'红红', N'顽皮红红', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (3, N'珍珍', N'睡猪珍珍', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (4, N'小赖', N'顽皮红红', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (5, N'小赖', N'睡猪珍珍', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (6, N'红红', N'帅帅的小赖', N'13126032004', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (7, N'红红', N'睡猪珍珍', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (8, N'珍珍', N'顽皮红红', N'18718337767', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (9, N'珍珍', N'帅帅的小赖', N'13126032004', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (10, N'小赖', N'风流倜傥宣霖', N'12345678910', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (11, N'红红', N'风流倜傥宣霖', N'12345678910', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
INSERT [dbo].[ShippingAddress] ([ShippingAddressID], [UName], [ShipingPersonName], [Phone], [Address], [DetailAddress], [YouZhengBianMa]) VALUES (12, N'珍珍', N'风流倜傥宣霖', N'12345678910', N'广东省珠海市斗门区白蕉镇', N'珠海市斗门区白蕉镇南方IT学院', N'123456')
SET IDENTITY_INSERT [dbo].[ShippingAddress] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UName], [Phone], [Email], [Pwd], [HeadImage], [CName], [Sex], [Birthday], [QQ], [WeiXin], [ShenFenZheng], [Address], [RegisTime], [LastTime], [IsVaild]) VALUES (1, N'小赖', N'13126032004', N'2445881204@qq.com', N'2580', NULL, NULL, N'男', N'1997-03-07', N'2445881204', N'LYR3028', N'440921199703076532', N'广东省茂名市信宜市合水镇', N'12 27 2017 11:23AM', N'尚未登陆……', 1)
INSERT [dbo].[Users] ([UserID], [UName], [Phone], [Email], [Pwd], [HeadImage], [CName], [Sex], [Birthday], [QQ], [WeiXin], [ShenFenZheng], [Address], [RegisTime], [LastTime], [IsVaild]) VALUES (2, N'顽皮红', N'18718337767', N'1374702542@qq.com', N'520', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'12 27 2017 11:23AM', N'尚未登陆……', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__B6DEAEE91DE57479]    Script Date: 2018/3/19 22:09:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[UName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Order_Add]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	赖艺仁	<Author,,Name>
-- Create date: 2018-01-09 <Create Date,,>
-- Description:	添加订单 <Description,,>
-- =============================================
CREATE procedure [dbo].[Order_Add]
	@UName varchar(255),--用户ID
    @ConsigneeName varchar(50),--收货人姓名
    @Phone varchar(50), --手机号码
    @Address varchar(255),--收货地址
    @AddressDetail varchar(555),--收货地址详情
    @YouZhengBianMa varchar(120),--邮政编码
    @Amount decimal(10,2)-- 总金额
as
begin

insert Orders(OrderNo,UName,ConsigneeName,Phone,Address,AddressDetail,YouZhengBianMa,Amount,OrderTime,OrderState)
values(dbo.Create_Order_NO(),@UName,@ConsigneeName,@Phone,@Address,@AddressDetail,@YouZhengBianMa,@Amount,getdate(),0)
select @@identity --返回当前自增ID	
   
end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetail_Add]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	赖艺仁	<Author,,Name>
-- Create date: 2018-01-09 <Create Date,,>
-- Description:	添加订单明细 <Description,,>
-- =============================================
CREATE procedure [dbo].[OrderDetail_Add] 
    @OrderId int,--订单ID
    @ShoppID int,--商品ID
    @Price decimal(10,2),--商品价格
    @Quantity int--商品数量
as
begin
      --添加订单详情
	  insert into OrderDetail(OrderId,ShoppID,Price,Quantity)
	  select @OrderId,@ShoppID,@Price,@Quantity
	  
	  --同时删除清空购物车相对应的商品
	  Delete ShopCarts where ShopCarts.ID=@ShoppID  
end
GO
/****** Object:  StoredProcedure [dbo].[PhoneDetail_ById]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 根据商品ID查看详细图集 <description,,>
-- =============================================
CREATE procedure [dbo].[PhoneDetail_ById]
@id int
as
begin
	 select a.*,b.PhoneName from PhoneDetail a left join PhoneInfo b on a.PhoneInfoID=b.PhoneInfoID where a.PhoneInfoID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[PhoneInfo_GetAllPhoneInfo]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 获取所有手机信息 <description,,>
-- =============================================
create procedure [dbo].[PhoneInfo_GetAllPhoneInfo]
as
begin
	 select * from PhoneInfo
end
GO
/****** Object:  StoredProcedure [dbo].[PhoneType_GetAllPhoneType]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 获取所有手机类型信息 <description,,>
-- =============================================
CREATE procedure [dbo].[PhoneType_GetAllPhoneType]
as
begin
	 select * from PhoneType
end
GO
/****** Object:  StoredProcedure [dbo].[ShippingAddress_ByID]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 根据收货地址自增ID查看详情 <description,,>
-- =============================================
CREATE procedure [dbo].[ShippingAddress_ByID]
@id int
as
begin
	 select* from ShippingAddress where ShippingAddressID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[ShippingAddress_ByUname_GetList]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 根据用户ID查看属于该用户的所有收货地址 <description,,>
-- =============================================
CREATE procedure [dbo].[ShippingAddress_ByUname_GetList]
@uname varchar(255)
as
begin
	 select * from ShippingAddress where UName=@uname
end


GO
/****** Object:  StoredProcedure [dbo].[ShopCarts_Add]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShopCarts_Add]
@id int,
@uname varchar(max)
AS
BEGIN
    --如果商品已经存在那么数量增加 1
    if(exists(select * from ShopCarts where ShopCarts.id=@id and ShopCarts.uname=@uname))
	begin
	      update ShopCarts set ShopCarts.quantity+=1 where ShopCarts.id=@id and ShopCarts.uname=@uname
	end
	else 
	begin
	        declare @name varchar(max)
	        declare @price decimal
			declare @quantity int
			set @quantity=1
			select top 1 @name=PhoneName,@price=Price from PhoneInfo where PhoneInfoID=@id
			insert ShopCarts values(@id,@name,@price,@quantity,@uname)
	end
   
END
GO
/****** Object:  StoredProcedure [dbo].[ShopCarts_ByUname_GetList]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 通过用户ID查询出所有属于该用户的商品信息 <description,,>
-- =============================================
CREATE procedure [dbo].[ShopCarts_ByUname_GetList]
@uname varchar(max)
as
begin
	 select ShopCarts.*,PhoneInfo.PImage2 from ShopCarts left join PhoneInfo on ShopCarts.id=PhoneInfo.PhoneInfoID where ShopCarts.uname=@uname
end
GO
/****** Object:  StoredProcedure [dbo].[ShopCarts_ByUname_ShopQuantity]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- author:  赖艺仁	<author,,name>
-- create date: 2017-12-27 <create date,,>
-- description: 通过用户ID查询出所有属于该用户的商品数量 <description,,>
-- =============================================
CREATE procedure [dbo].[ShopCarts_ByUname_ShopQuantity]
@uname varchar(max)
as
begin
	 select top 1 sum(ShopCarts.quantity) from ShopCarts where ShopCarts.uname=@uname
end
GO
/****** Object:  StoredProcedure [dbo].[ShopCarts_Delete]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: 删除商品 <Description,,>
-- =============================================
create PROCEDURE [dbo].[ShopCarts_Delete]
@id int,
@uname varchar(max)
AS
BEGIN
	  Delete ShopCarts where ShopCarts.ShopCartsID=@id and ShopCarts.uname=@uname
END

GO
/****** Object:  StoredProcedure [dbo].[ShopCarts_Update]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: 修改商品数量 <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShopCarts_Update]
@id int,
@quantity int,
@uname varchar(max)
AS
BEGIN
	   update ShopCarts set ShopCarts.quantity=@quantity where ShopCarts.ShopCartsID=@id and ShopCarts.uname=@uname
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Login]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  赖艺仁	<Author,,Name>
-- Create date: 2017-11-20 <Create Date,,>
-- Description: 用户登录 <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Login]
@UName varchar(68)
AS
BEGIN
	 select * from Users u where
	 u.UName=@UName or u.Phone=@UName or u.Email=@UName and u.IsVaild=1
END
GO
/****** Object:  StoredProcedure [dbo].[Users_Register]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:用户注册	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_Register]
	@UserName varchar(20),
	@Pwd varchar(20)
AS
BEGIN 
		insert into Users(UName,Pwd)values(@UserName,@Pwd)
END



GO
/****** Object:  StoredProcedure [dbo].[Users_UserInfo_ById]    Script Date: 2018/3/19 22:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  赖艺仁	<Author,,Name>
-- Create date: 2018-03-12 <Create Date,,>
-- Description: 查询用户基本资料 <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Users_UserInfo_ById]
@UName varchar(68)
AS
BEGIN
	 select * from Users u where
	 u.UName=@UName or u.Phone=@UName or u.Email=@UName and u.IsVaild=1
END
GO
USE [master]
GO
ALTER DATABASE [MyPhoneSys] SET  READ_WRITE 
GO
