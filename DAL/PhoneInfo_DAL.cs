using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//引用
using System.Data;
using System.Data.SqlClient;
using Models;
using DBUtility;

namespace DAL
{
    //手机信息服务类
    public class PhoneInfo_DAL
    {
        /// <summary>
        /// 1.获取所有手机信息
        /// </summary>
        /// <returns></returns>
        public List<PhoneInfo_Model> GetPhoneInfo()
        {
            //采用 list 集合存储数据
            List<PhoneInfo_Model> list = new List<PhoneInfo_Model>();
            using (SqlDataReader dr = SqlHelper.ExecuteReader("PhoneInfo_GetAllPhoneInfo", null))
            {
                while (dr.Read())
                {
                    PhoneInfo_Model obj = new PhoneInfo_Model();

                    obj.PhoneInfoID = Convert.ToInt32(dr["PhoneInfoID"]);//自增ID
                    obj.PhoneTypeID = Convert.ToInt32(dr["PhoneTypeID"]);//品牌分类ID（唯一标识）
                    obj.PhoneName = Convert.ToString(dr["PhoneName"]);//手机名称（小米4、红米note3）
                    obj.Price = Convert.ToDecimal(dr["Price"]);//手机价格
                    obj.IsXinPin = Convert.ToString(dr["IsXinPin"]);//是否是新品
                    obj.PImage = Convert.ToString(dr["PImage"]);//手机照片
                    obj.PImage2 = Convert.ToString(dr["PImage2"]);//手机照片2

                    list.Add(obj);
                }
            }
            return list.ToList();
        }
    }
}

