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
    //商品详细服务类
    public class PhoneDetail_DAL
    {
        //根据商品ID查看详细
        public List<PhoneDetail_Model> PhoneDetail_ById(int id)
        {
            //采用 list 集合存储数据
            List<PhoneDetail_Model> list = new List<PhoneDetail_Model>();
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]{
                new SqlParameter("@id",id),
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("PhoneDetail_ById", ter))
            {
                if (dr.Read())
                {
                    PhoneDetail_Model obj = new PhoneDetail_Model();
                    obj.PhoneDetailID = Convert.ToInt32(dr["PhoneDetailID"]);//自增ID
                    obj.PhoneInfoID = Convert.ToInt32(dr["PhoneInfoID"]);//商品ID
                    obj.PhoneName = Convert.ToString(dr["PhoneName"]);//商品名称
                    obj.gaishu = Convert.ToString(dr["gaishu"]);//概述
                    obj.tuji = Convert.ToString(dr["tuji"]);//图集
                    obj.canshu = Convert.ToString(dr["canshu"]);//参数

                    list.Add(obj);
                }
            }
            return list.ToList();
        }
    }
}
