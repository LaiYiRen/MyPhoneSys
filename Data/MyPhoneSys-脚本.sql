create database MyPhoneSys on
(
   name='MyPoneSys',
   filename='D:\LYR\��������ʦ\������-MyPhoneSys\MyPhoneSys\Data\MyPoneSys.mdf'
)
create table Users--�û���
(
	UserID int primary key identity,        --�û�ID
	UName varchar(68)unique not null,       --�˺ţ�Ψһ��ʶ��
    Phone varchar(68),                      --��ϵ�绰
	Email varchar(68),                      --����
	Pwd varchar(68)not null,                --����
    HeadImage varchar(68),                  --ͷ��     
    CName varchar(68),                      --�ǳ� 
    Sex varchar(68),                        --�Ա�
    Birthday varchar(68),                   --���� 
    QQ varchar(68),                         --QQ
    WeiXin varchar(68),                     --΢��
    ShenFenZheng varchar(68),               --���֤
    [Address] varchar(368),                 --��ס��
    RegisTime varchar(68),                  --ע��ʱ��
	LastTime varchar(68),                   --���һ�ε�¼ʱ��
	IsVaild bit,                            --�Ƿ���Ч
)
insert Users(UName,Phone,Email,Pwd,RegisTime,LastTime,IsVaild)values('С��','13126032004','2445881204@qq.com','2580',getdate(),'��δ��½����',1)
insert Users(UName,Phone,Email,Pwd,RegisTime,LastTime,IsVaild)values('���','18718337767','1374702542@qq.com','520',getdate(),'��δ��½����',1)

create table ShippingAddress--�ջ���ַ
(
   ShippingAddressID int primary key identity, --ID
   UName varchar(68),                          --�˺ţ�Ψһ��ʶ��
   ShipingPersonName varchar(68),              --�ջ�������
   Phone varchar(68),                          --�ֻ�����
   Address varchar(520),                       --�ջ���ַ
   DetailAddress varchar(268),                 --��ϸ��ַ
   YouZhengBianMa varchar(68),                 --��������
)

insert ShippingAddress values('С��','˧˧��С��','13126032004','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('С��','��Ƥ���','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('С��','����','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('С��','����','12345678910','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')


insert ShippingAddress values('���','��Ƥ���','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('���','˧˧��С��','13126032004','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('���','����','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('���','����','12345678910','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')


insert ShippingAddress values('����','����','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456');
insert ShippingAddress values('����','��Ƥ���','18718337767','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('����','˧˧��С��','13126032004','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')
insert ShippingAddress values('����','����','12345678910','�㶫ʡ�麣�ж������׽���','�麣�ж������׽����Ϸ�ITѧԺ','123456')

select * from ShippingAddress



create table PhoneType--�ֻ����ͱ�
(
	PhoneTypeID int primary key identity,      --ID
	PName varchar(68),                         --��������
)
insert PhoneType values('С���ֻ�')
insert PhoneType values('�����ֻ�')
insert PhoneType values('�����ֻ�2')
select * from PhoneType

create table PhoneInfo--�ֻ���Ϣ��
(
	PhoneInfoID int primary key identity,    --ID
	PhoneTypeID int,                          --Ʒ�Ʒ���ID��Ψһ��ʶ��
	PhoneName varchar(68),                    --�ֻ����ƣ�С��4������note3��
    Price decimal(10,2),                      --�ֻ��۸�
	IsXinPin varchar(20),                     --�Ƿ�����Ʒ
	PImage varchar(max),                      --�ֻ���Ƭ
	PImage2 varchar(max),                      --�ֻ���Ƭ2
	JiShenYanSe varchar(68),                  --������ɫ
	TaoCanLeiXing varchar(68),                --�ײ����ͣ��ײ�һ���ײͶ����ײ�����
    ShouJiChiCun varchar(68),                 --�ֻ��ߴ�
	ShouJiZhongLiang varchar(68),             --�ֻ�����
	FenBianLv varchar(68),                    --�ֱ���
    PingMuXiangSuMiDu varchar(68),            --��Ļ�����ܶ�
	SheXiangTouLeiXing varchar(68),           --����ͷ���ͣ�ǰ��һ��������������
	QianZhiSheXiangTou varchar(68),           --ǰ������ͷ
	HouZhiSheXiangTou varchar(68),            --��������ͷ
	DianChiRongLiang varchar(68),             --�������
	DianChiLeiXing varchar(68),               --������ͣ����ɲ�ж��
	HeXinShu varchar(68),                     --��������4�ˡ�6�ˣ�
	CPUXingHao varchar(68),                   --CPU�ͺ�
	CPUPinLv varchar(68),                     --CPUƵ��
	YunXingNeiCun varchar(68),                --�����ڴ棨4g��6g��
	ROMRongLiang varchar(68),                 --�洢����
	ShangShiRiQi varchar(68),                 --��������
	ShouJiLeiXing varchar(68),                --�ֻ����ͣ�4G��3G�������ֻ���
	ChuMoPingLeiXing varchar(68),             --����������
	SIMKa varchar(68),                        --SIM����������˫����
	CaoZuoXiTong varchar(68),                 --����ϵͳ
	IsValid bit                               --�Ƿ���Ч
)
--С���ֻ�ϵ��
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'С��MIX2',3299,'��Ʒ','../Images/��ҳ/nav_�Ӳ˵�/С���ֻ�/01.png','../Images/��ҳ/����б�/�ֻ��绰��/01.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'С��Note3',1999,'��Ʒ','../Images/��ҳ/nav_�Ӳ˵�/С���ֻ�/02.png','../Images/��ҳ/����б�/�ֻ��绰��/02.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'С��6',2299,'','../Images/��ҳ/nav_�Ӳ˵�/С���ֻ�/03.png','../Images/��ҳ/����б�/�ֻ��绰��/03.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'С��Max 2',1399,'','../Images/��ҳ/nav_�Ӳ˵�/С���ֻ�/04.png','../Images/��ҳ/����б�/�ֻ��绰��/04.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(1,'С��5X',1499,'','../Images/��ҳ/nav_�Ӳ˵�/С���ֻ�/05.png','../Images/��ҳ/����б�/�ֻ��绰��/05.png')

--�����ֻ�ϵ��
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����5',799,'��Ʒ','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/01.png','../Images/��ҳ/����б�/�ֻ��绰��/06.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����5 Plus',999,'��Ʒ','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/02.png','../Images/��ҳ/����б�/�ֻ��绰��/2-01.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����5A',599,'��Ʒ','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/03.png','../Images/��ҳ/����б�/�ֻ��绰��/2-02.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����Note 5A��׼��',699,'','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/04.png','../Images/��ҳ/����б�/�ֻ��绰��/2-03.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����Note 5A�����',899,'','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/05.png','../Images/��ҳ/����б�/�ֻ��绰��/2-04.png')
insert PhoneInfo(PhoneTypeID,PhoneName,Price,IsXinPin,PImage,PImage2) values(2,'����Note 4X',999,'','../Images/��ҳ/nav_�Ӳ˵�/�����ֻ�/06.png','../Images/��ҳ/����б�/�ֻ��绰��/2-05.png')

select * from PhoneInfo
drop table PhoneInfo

create table PhoneDetail
(
	PhoneDetailID int primary key identity,    --ID
	PhoneInfoID int,                           --�ֻ�ID
    gaishu varchar(255),                       --����
	tuji varchar(255),                         --ͼ��
	canshu varchar(255),                       --����
)
drop table PhoneDetail
insert PhoneDetail values(1,'../Images/С����Ʒ/�ֻ���ϸ/С��Mix2/01.png','../Images/С����Ʒ/�ֻ���ϸ/С��Mix2/02.png','../Images/С����Ʒ/�ֻ���ϸ/С��Mix2/03.png')
insert PhoneDetail values(2,'../Images/С����Ʒ/�ֻ���ϸ/С��Note3/01.png','../Images/С����Ʒ/�ֻ���ϸ/С��Note3/02.png','../Images/С����Ʒ/�ֻ���ϸ/С��Note3/03.png')
insert PhoneDetail values(3,'../Images/С����Ʒ/�ֻ���ϸ/С��6/01.png','../Images/С����Ʒ/�ֻ���ϸ/С��6/02.png','../Images/С����Ʒ/�ֻ���ϸ/С��6/03.png')
insert PhoneDetail values(4,'../Images/С����Ʒ/�ֻ���ϸ/С��Max2/01.png','../Images/С����Ʒ/�ֻ���ϸ/С��Max2/02.png','../Images/С����Ʒ/�ֻ���ϸ/С��Max2/03.png')
insert PhoneDetail values(5,'../Images/С����Ʒ/�ֻ���ϸ/С��5X/01.png','../Images/С����Ʒ/�ֻ���ϸ/С��5X/02.png','../Images/С����Ʒ/�ֻ���ϸ/С��5X/03.png')

insert PhoneDetail values(6,'../Images/С����Ʒ/�ֻ���ϸ/����5/01.png','../Images/С����Ʒ/�ֻ���ϸ/����5/02.png','../Images/С����Ʒ/�ֻ���ϸ/����5/03.png')
insert PhoneDetail values(7,'../Images/С����Ʒ/�ֻ���ϸ/����5/01.png','../Images/С����Ʒ/�ֻ���ϸ/����5/02.png','../Images/С����Ʒ/�ֻ���ϸ/����5/03.png')
insert PhoneDetail values(8,'../Images/С����Ʒ/�ֻ���ϸ/����5A/01.png','../Images/С����Ʒ/�ֻ���ϸ/����5A/02.png','../Images/С����Ʒ/�ֻ���ϸ/����5A/03.png')
insert PhoneDetail values(9,'../Images/С����Ʒ/�ֻ���ϸ/����Note5A��׼��/01.png','../Images/С����Ʒ/�ֻ���ϸ/����Note5A��׼��/02.png','../Images/С����Ʒ/�ֻ���ϸ/����Note5A��׼��/03.png')
insert PhoneDetail values(10,'../Images/С����Ʒ/�ֻ���ϸ/����Note5A��ǿ��/01.png','../Images/С����Ʒ/�ֻ���ϸ/����Note5A��ǿ��/02.png','../Images/С����Ʒ/�ֻ���ϸ/����Note5A��ǿ��/03.png')
insert PhoneDetail values(11,'../Images/С����Ʒ/�ֻ���ϸ/����Note4X/01.png','../Images/С����Ʒ/�ֻ���ϸ/����Note4X/02.png','../Images/С����Ʒ/�ֻ���ϸ/����Note4X/03.png')

select * from PhoneDetail

create table PhonePingJia--�ֻ�����
(
	PhonePingJiaID int primary key identity,  --ID
    PhoneDetailID int,                        --�ֻ�ID
	UName varchar(68),                        --˭���۵�
	JiShenYanSe varchar(68),                  --������ɫ
	TaoCanLeiXing varchar(68),                --�ײ�����
	PingJiaNeiRong varchar(168),              --��������
	PingJiaImage varchar(368),                --������Ƭ
	PingJiaShiJian varchar(68),               --����ʱ��
)
create table ShopCarts --��ʱ���ﳵ
(
    ShopCartsID int primary key identity,
	ID int, --�ֻ�id
	Names varchar(max),--�ֻ���           
	Price decimal,--�۸�               
	Quantity int,--����
	Uname varchar(max),--�û�ID                      
)
drop table ShopCarts

Create table Orders --������
(
    OrderId int primary key identity(1,1),--����ID
    OrderNo varchar(30) not null,--����
    UName varchar(255),--�û�ID
    ConsigneeName varchar(50),--�ջ�������
    Phone varchar(50), --�ֻ�����
    Address varchar(255),--�ջ���ַ
    AddressDetail varchar(555),--�ջ���ַ����
    YouZhengBianMa varchar(120),--��������
    Amount decimal(10,2),-- �ܽ��
    OrderTime varchar(255),--�µ�ʱ�� 
    OrderState int, --(-1,����ȡ����0���¶�����1��������,2�����)
	IsPayment bit default 0 not null,--�Ƿ񸶿�
)
drop table Orders

insert Orders values('001','С��','˧˧��С��','13126032004','�㶫ʡ','�麣�ж�����','123456',500,0)

Create table OrderDetail--������ϸ��
(
    DetailId int primary key identity(1,1),--������ϸID
    OrderId int,--����ID
    ShoppID int,--��ƷID
    Price decimal(10,2),--�۸�
    Quantity int,--����
    CancelTime datetime,--ȡ��ʱ�� 
    IsValid bit --�Ƿ���� 
)
drop table OrderDetail
