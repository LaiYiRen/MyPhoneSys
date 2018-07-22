using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    /// <summary>
    /// 手机信息表
    /// </summary>
    public class PhoneInfo_Model
    {
        public int PhoneInfoID { get; set; }//ID
        public int PhoneTypeID { get; set; }//手机分类ID
        public string PhoneName { get; set; }//手机名称（小米4、红米note3）
        public decimal Price { get; set; }//手机价格
        public string IsXinPin { get; set; }//是否是新品
        public string PImage { get; set; }//手机照片
        public string PImage2 { get; set; }//手机照片2

        //public string JiShenYanSe { get; set; }//机身颜色
        //public string TaoCanLeiXing { get; set; }//套餐类型（套餐一、套餐二、套餐三）
        //public string ShouJiChiCun { get; set; }//手机尺寸
        //public string ShouJiZhongLiang { get; set; }//手机重量
        //public string FenBianLv { get; set; }//分辨率
        //public string PingMuXiangSuMiDu { get; set; }//屏幕像素密度
        //public string SheXiangTouLeiXing { get; set; }//摄像头类型（前置一个、后置两个）
        //public string QianZhiSheXiangTou { get; set; }//前置摄像头
        //public string HouZhiSheXiangTou { get; set; }//后置摄像头
        //public string DianChiRongLiang { get; set; }//电池容量
        //public string DianChiLeiXing { get; set; }//电池类型（不可拆卸）
        //public string HeXinShu { get; set; }//核心数（4核、6核）
        //public string CPUXingHao { get; set; }//CPU型号
        //public string CPUPinLv { get; set; }//CPU频率
        //public string YunXingNeiCun { get; set; }//运行内存（4g、6g）
        //public string ROMRongLiang { get; set; }//存储容量
        //public string ShangShiRiQi { get; set; }//上市日期
        //public string ShouJiLeiXing { get; set; }//手机类型（4G、3G、拍照手机）
        //public string ChuMoPingLeiXing { get; set; }//触摸屏类型
        //public string SIMKa { get; set; }//SIM卡（单卡、双卡）
        //public string CaoZuoXiTong { get; set; }//操作系统
        //public bool IsValid { get; set; }//是否有效
    }
}
