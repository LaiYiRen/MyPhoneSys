create database MyPhoneSys on
(
   name='MyPoneSys',
   filename='D:\LYR\第三任老师\赖艺仁-MyPhoneSys\MyPhoneSys\Data\MyPoneSys.mdf'
)
create table Users--用户表
(
	UserID int primary key identity,        --用户ID
	UName varchar(68)unique not null,       --账号（唯一标识）
    Phone varchar(68),                      --联系电话
	Email varchar(68),                      --邮箱
	Pwd varchar(68)not null,                --密码
    HeadImage varchar(68),                  --头像     
    CName varchar(68),                      --昵称 
    Sex varchar(68),                        --性别
    Birthday varchar(68),                   --生日 
    QQ varchar(68),                         --QQ
    WeiXin varchar(68),                     --微信
    ShenFenZheng varchar(68),               --身份证
    [Address] varchar(368),                 --居住地
    RegisTime varchar(68),                  --注册时间
	LastTime varchar(68),                   --最近一次登录时间
	IsVaild bit,                            --是否有效
)
insert Users(UName,Phone,Email,Pwd,RegisTime,LastTime,IsVaild)values('小赖','13126032004','2445881204@qq.com','2580',getdate(),'尚未登陆……',1)
insert Users(UName,Phone,Email,Pwd,RegisTime,LastTime,IsVaild)values('红红','18718337767','1374702542@qq.com','520',getdate(),'尚未登陆……',1)

create table ShippingAddress--收货地址
(
   ShippingAddressID int primary key identity, --ID
   UName varchar(68),                          --账号（唯一标识）
   ShipingPersonName varchar(68),              --收货人姓名
   Phone varchar(68),                          --手机号码
   Address varchar(520),                       --收货地址
   DetailAddress varchar(268),                 --详细地址
   YouZhengBianMa varchar(68),                 --邮政编码
)

insert ShippingAddress values('小赖','帅帅的小赖','13126032004','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('小赖','顽皮红红','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('小赖','珍珍','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('小赖','宣霖','12345678910','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')


insert ShippingAddress values('红红','顽皮红红','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('红红','帅帅的小赖','13126032004','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('红红','珍珍','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('红红','宣霖','12345678910','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')


insert ShippingAddress values('珍珍','珍珍','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456');
insert ShippingAddress values('珍珍','顽皮红红','18718337767','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('珍珍','帅帅的小赖','13126032004','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')
insert ShippingAddress values('珍珍','宣霖','12345678910','广东省珠海市斗门区白蕉镇','珠海市斗门区白蕉镇南方IT学院','123456')

select * from ShippingAddress



create table PhoneType--手机类型表
(
	PhoneTypeID int primary key identity,      --ID
	PName varchar(68),                         --分类名称
)
insert PhoneType values('小米手机')
insert PhoneType values('红米手机')
insert PhoneType values('红米手机2')
select * from PhoneType

create table PhoneInfo--手机信息表
(
	PhoneInfoID int primary key identity,    --ID
	PhoneTypeID int,                          --品牌分类ID（唯一标识）
	PhoneName varchar(68),                    --手机名称（小米4、红米note3）
    Price decimal(10,2),                      --手机价格
	IsXinPin varchar(20),                     --是否是新品
	PImage varchar(max),                      --手机照片
	PImage2 varchar(max),                      --手机照片2
	JiShenYanSe varchar(68),                  --机身颜色
	TaoCanLeiXing varchar(68),                --套餐类型（套餐一、套餐二、套餐三）
    ShouJiChiCun varchar(68),                 --手机尺寸
	ShouJiZhongLiang varchar(68),             --手机重量
	FenBianLv varchar(68),                    --分辨率
    PingMuXiangSuMiDu varchar(68),            --屏幕像素密度
	SheXiangTouLeiXing varchar(68),           --摄像头类型（前置一个、后置两个）
	QianZhiSheXiangTou varchar(68),           --前置摄像头
	HouZhiSheXiangTou varchar(68),            --后置摄像头
	DianChiRongLiang varchar(68),             --电池容量
	DianChiLeiXing varchar(68),               --电池类型（不可拆卸）
	HeXinShu varchar(68),                     --核心数（4核、6核）
	CPUXingHao varchar(68),                   --CPU型号
	CPUPinLv varchar(68),                     --CPU频率
	YunXingNeiCun varchar(68),                --运行内存（4g、6g）
	ROMRongLiang varchar(68),                 --存储容量
	ShangShiRiQi varchar(68),                 --上市日期
	ShouJiLeiXing varchar(68),                --手机类型（4G、3G、拍照手机）
	ChuMoPingLeiXing varchar(68),             --触摸屏类型
	SIMKa varchar(68),                        --SIM卡（单卡、双卡）
	CaoZuoXiTong varchar(68),                 --操作系统
	IsValid bit                               --是否有效
)
--小米手机系列
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'小米MIX2',3299,'新品','../Images/首页/nav_子菜单/小米手机/01.png','../Images/首页/侧边列表/手机电话卡/01.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'小米Note3',1999,'新品','../Images/首页/nav_子菜单/小米手机/02.png','../Images/首页/侧边列表/手机电话卡/02.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'小米6',2299,'','../Images/首页/nav_子菜单/小米手机/03.png','../Images/首页/侧边列表/手机电话卡/03.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'小米Max 2',1399,'','../Images/首页/nav_子菜单/小米手机/04.png','../Images/首页/侧边列表/手机电话卡/04.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'小米5X',1499,'','../Images/首页/nav_子菜单/小米手机/05.png','../Images/首页/侧边列表/手机电话卡/05.png')

--红米手机系列
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米5',799,'新品','../Images/首页/nav_子菜单/红米手机/01.png','../Images/首页/侧边列表/手机电话卡/06.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米5 Plus',999,'新品','../Images/首页/nav_子菜单/红米手机/02.png','../Images/首页/侧边列表/手机电话卡/2-01.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米5A',599,'新品','../Images/首页/nav_子菜单/红米手机/03.png','../Images/首页/侧边列表/手机电话卡/2-02.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米Note 5A标准版',699,'','../Images/首页/nav_子菜单/红米手机/04.png','../Images/首页/侧边列表/手机电话卡/2-03.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米Note 5A高配版',899,'','../Images/首页/nav_子菜单/红米手机/05.png','../Images/首页/侧边列表/手机电话卡/2-04.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'红米Note 4X',999,'','../Images/首页/nav_子菜单/红米手机/06.png','../Images/首页/侧边列表/手机电话卡/2-05.png')

select * from PhoneInfo
drop table PhoneInfo

create table PhoneDetail
(
	PhoneDetailID int primary key identity,    --ID
	PhoneInfoID int,                           --手机ID
    gaishu varchar(255),                       --概述
	tuji varchar(255),                         --图集
	canshu varchar(255),                       --参数
)
drop table PhoneDetail
insert PhoneDetail values(1,'../Images/小米商品/手机详细/小米Mix2/01.png','../Images/小米商品/手机详细/小米Mix2/02.png','../Images/小米商品/手机详细/小米Mix2/03.png')
insert PhoneDetail values(2,'../Images/小米商品/手机详细/小米Note3/01.png','../Images/小米商品/手机详细/小米Note3/02.png','../Images/小米商品/手机详细/小米Note3/03.png')
insert PhoneDetail values(3,'../Images/小米商品/手机详细/小米6/01.png','../Images/小米商品/手机详细/小米6/02.png','../Images/小米商品/手机详细/小米6/03.png')
insert PhoneDetail values(4,'../Images/小米商品/手机详细/小米Max2/01.png','../Images/小米商品/手机详细/小米Max2/02.png','../Images/小米商品/手机详细/小米Max2/03.png')
insert PhoneDetail values(5,'../Images/小米商品/手机详细/小米5X/01.png','../Images/小米商品/手机详细/小米5X/02.png','../Images/小米商品/手机详细/小米5X/03.png')

insert PhoneDetail values(6,'../Images/小米商品/手机详细/红米5/01.png','../Images/小米商品/手机详细/红米5/02.png','../Images/小米商品/手机详细/红米5/03.png')
insert PhoneDetail values(7,'../Images/小米商品/手机详细/红米5/01.png','../Images/小米商品/手机详细/红米5/02.png','../Images/小米商品/手机详细/红米5/03.png')
insert PhoneDetail values(8,'../Images/小米商品/手机详细/红米5A/01.png','../Images/小米商品/手机详细/红米5A/02.png','../Images/小米商品/手机详细/红米5A/03.png')
insert PhoneDetail values(9,'../Images/小米商品/手机详细/红米Note5A标准版/01.png','../Images/小米商品/手机详细/红米Note5A标准版/02.png','../Images/小米商品/手机详细/红米Note5A标准版/03.png')
insert PhoneDetail values(10,'../Images/小米商品/手机详细/红米Note5A增强版/01.png','../Images/小米商品/手机详细/红米Note5A增强版/02.png','../Images/小米商品/手机详细/红米Note5A增强版/03.png')
insert PhoneDetail values(11,'../Images/小米商品/手机详细/红米Note4X/01.png','../Images/小米商品/手机详细/红米Note4X/02.png','../Images/小米商品/手机详细/红米Note4X/03.png')

select * from PhoneDetail

create table PhonePingJia--手机评价
(
	PhonePingJiaID int primary key identity,  --ID
    PhoneDetailID int,                        --手机ID
	UName varchar(68),                        --谁评价的
	JiShenYanSe varchar(68),                  --机身颜色
	TaoCanLeiXing varchar(68),                --套餐类型
	PingJiaNeiRong varchar(168),              --评价内容
	PingJiaImage varchar(368),                --评价照片
	PingJiaShiJian varchar(68),               --评价时间
)
create table ShopCarts --临时购物车
(
    ShopCartsID int primary key identity,
	ID int, --手机id
	Names varchar(max),--手机名           
	Price decimal,--价格               
	Quantity int,--数量
	Uname varchar(max),--用户ID                      
)
drop table ShopCarts

Create table Orders --订单表
(
    OrderId int primary key identity(1,1),--订单ID
    OrderNo varchar(30) not null,--单号
    UName varchar(255),--用户ID
    ConsigneeName varchar(50),--收货人姓名
    Phone varchar(50), --手机号码
    Address varchar(255),--收货地址
    AddressDetail varchar(555),--收货地址详情
    YouZhengBianMa varchar(120),--邮政编码
    Amount decimal(10,2),-- 总金额
    OrderTime varchar(255),--下单时间 
    OrderState int, --(-1,订单取消，0，新订单，1，运输中,2已完成)
	IsPayment bit default 0 not null,--是否付款
)
drop table Orders

insert Orders values('001','小赖','帅帅的小赖','13126032004','广东省','珠海市斗门区','123456',500,0)

Create table OrderDetail--订单明细表
(
    DetailId int primary key identity(1,1),--订单明细ID
    OrderId int,--订单ID
    ShoppID int,--商品ID
    Price decimal(10,2),--价格
    Quantity int,--数量
    CancelTime datetime,--取消时间 
    IsValid bit --是否完成 
)
drop table OrderDetail
