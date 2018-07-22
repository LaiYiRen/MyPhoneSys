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
    //手机类型服务类
    public class PhoneType_DAL
    {
        /// <summary>
        /// 1.获取所有手机类型信息
        /// </summary>
        /// <returns></returns>
        public List<PhoneType_Model> GetPhoneType()
        {
            //采用 list 集合存储数据
            List<PhoneType_Model> list = new List<PhoneType_Model>();
            using (SqlDataReader dr = SqlHelper.ExecuteReader("PhoneType_GetAllPhoneType", null))
            {
                while (dr.Read())
                {
                    PhoneType_Model obj = new PhoneType_Model();
                    obj.PhoneTypeID = Convert.ToInt32(dr["PhoneTypeID"]);//自增ID
                    obj.PName = Convert.ToString(dr["PName"]);//手机分类名称

                    list.Add(obj);
                }
            }
            return list.ToList();
        }
    }
}
