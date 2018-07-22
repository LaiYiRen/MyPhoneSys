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
    //数据访问层
   public  class ShippingAddress_DAL
    {
        //根据用户ID查看属于该用户的所有收货地址
        public List<ShippingAddress_Model> ByUname_GetList(string uname)
        {
            //采用 list 集合存储数据
            List<ShippingAddress_Model> list = new List<ShippingAddress_Model>();
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]{
                new SqlParameter("@uname",uname),
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("ShippingAddress_ByUname_GetList", ter))
            {
                while (dr.Read())
                {
                    ShippingAddress_Model obj = new ShippingAddress_Model();
                    obj.ShippingAddressID = Convert.ToInt32(dr["ShippingAddressID"]);//自增ID
                    obj.UName = Convert.ToString(dr["UName"]);//用户ID
                    obj.ShipingPersonName = Convert.ToString(dr["ShipingPersonName"]);//收货人姓名
                    obj.Phone = Convert.ToString(dr["Phone"]);//收货人姓名
                    obj.Address = Convert.ToString(dr["Address"]);//收货地址
                    obj.DetailAddress = Convert.ToString(dr["DetailAddress"]);//收货地址详情
                    obj.YouZhengBianMa = Convert.ToString(dr["YouZhengBianMa"]);//邮政编码

                    list.Add(obj);
                }
            }
            return list.ToList();
        }
        //根据收货地址自增ID查看详情
        public List<ShippingAddress_Model> ShippingAddress_ByID(int id)
        {
            //采用 list 集合存储数据
            List<ShippingAddress_Model> list = new List<ShippingAddress_Model>();
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]{
                new SqlParameter("@id",id),
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("ShippingAddress_ByID", ter))
            {
                if (dr.Read())
                {
                    ShippingAddress_Model obj = new ShippingAddress_Model();
                    obj.ShippingAddressID = Convert.ToInt32(dr["ShippingAddressID"]);//自增ID
                    obj.UName = Convert.ToString(dr["UName"]);//用户ID
                    obj.ShipingPersonName = Convert.ToString(dr["ShipingPersonName"]);//收货人姓名
                    obj.Phone = Convert.ToString(dr["Phone"]);//收货人姓名
                    obj.Address = Convert.ToString(dr["Address"]);//收货地址
                    obj.DetailAddress = Convert.ToString(dr["DetailAddress"]);//收货地址详情
                    obj.YouZhengBianMa = Convert.ToString(dr["YouZhengBianMa"]);//邮政编码

                    list.Add(obj);
                }
            }
            return list.ToList();
        }
    }
}
