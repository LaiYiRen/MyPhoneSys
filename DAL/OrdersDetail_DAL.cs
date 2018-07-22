using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//引用
using System.Data.SqlClient;
using DBUtility;
using Models;
using DAL;

namespace DAL
{
    //订单详细数据访层
    public class OrdersDetail_DAL
    {
        /// <summary>
        /// 根据订单号查询订单详细信息
        /// </summary>
        /// <param name="OrderId"></param>
        /// <returns></returns>
        public List<OrdersDetail_Model> OrderDetail_GetList_ByOrderId(int OrderId)
        {
            // 采用 list 集合存储数据
            List<OrdersDetail_Model> list = new List<OrdersDetail_Model>();
            // 采用参数数组存储参数
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@OrderId",OrderId),
            };
            // 采用 using 回收资源
            using (SqlDataReader sdr=SqlHelper.ExecuteReader("OrderDetail_GetList_ByOrderId", param))
            {
                // 使用 while 循环读取数据
                while (sdr.Read())
                {
                    OrdersDetail_Model model = new OrdersDetail_Model();
                    model.DetailId = Convert.ToInt32(sdr["DetailId"]);// 订单详细Id
                    model.OrderId = Convert.ToInt32(sdr["OrderId"]);// 订单Id
                    model.ShoppID = Convert.ToInt32(sdr["ShoppID"]);// 商品Id
                    model.ShopName = Convert.ToString(sdr["PhoneName"]);// 商品名称
                    model.Price = Convert.ToDecimal(sdr["Price"]);// 商品价格
                    model.Quantity = Convert.ToInt32(sdr["Quantity"]);// 商品数量
                    model.Image = Convert.ToString(sdr["PImage"]);// 商品图片
                    list.Add(model);// 添加到集合中
                }
            }
            return list;// 返回数据
        }
    }
}
