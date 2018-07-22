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
    /// <summary>
    /// 购物车服务类
    /// </summary>
    public class ShopCarts_DAL
    {
        /// <summary>
        /// 新增商品到购物车
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Add(int id, string uname)
        {
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]{
                new SqlParameter("@id",id),
                new SqlParameter("@uname",uname)
            };
            return SqlHelper.ExecuteNonQuery("ShopCarts_Add", ter);
        }
        /// <summary>
        /// 查询出属于当前 用户登陆  购物车商品信息
        /// </summary>
        /// <returns></returns>
        public List<ShopCarts_Model> ByUname_GetList(string uname)
        {
            //采用 list 集合存储数据
            List<ShopCarts_Model> list = new List<ShopCarts_Model>();
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@uname",uname)
           };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("ShopCarts_ByUname_GetList", ter))
            {
                while (dr.Read())
                {
                    ShopCarts_Model obj = new ShopCarts_Model();
                    obj.ShopCartsID = Convert.ToInt32(dr["ShopCartsID"]);//自增ID
                    obj.ID = Convert.ToInt32(dr["ID"]);//商品ID
                    obj.Names = Convert.ToString(dr["Names"]);//商品名称
                    obj.Price = Convert.ToDecimal(dr["Price"]);//商品价格
                    obj.Quantity = Convert.ToInt32(dr["Quantity"]);//商品数量
                    obj.Uname = Convert.ToString(dr["Uname"]);//用户ID
                    obj.Img = Convert.ToString(dr["PImage2"]);//商品照片

                    list.Add(obj);
                }
            }
            return list.ToList();
        }

        /// <summary>
        /// 修改属于当前 用户登陆  购物车商品数量
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Update(int id, int quantity, string uname)
        {
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@id",id),
                new SqlParameter("@quantity",quantity),
                new SqlParameter("@uname",uname)
         };
            return SqlHelper.ExecuteNonQuery("ShopCarts_Update", ter);
        }
        /// <summary>
        /// 获取属于当前 用户登陆  购物车商品总数量
        /// </summary>
        /// <returns></returns>
        public int ByUname_ShopQuantity(string uname)
        {
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@uname",uname)
         };
            return (int)SqlHelper.ExecuteScalar("ShopCarts_ByUname_ShopQuantity", ter);
        }

        /// <summary>
        /// 删除属于当前 用户登陆  购物车商品
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Delete(int id, string uname)
        {
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@id",id),
                new SqlParameter("@uname",uname)
         };
            return SqlHelper.ExecuteNonQuery("ShopCarts_Delete", ter);
        }
    }
}
