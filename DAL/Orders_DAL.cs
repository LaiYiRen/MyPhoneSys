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
    //订单数据访问层
    public class Orders_DAL
    {
        /// <summary>
        /// 新增订单并且新增订单详情
        /// </summary>
        /// <returns></returns>
        public void Order_Add(Orders_Model obj, List<OrdersDetail_Model> cartItems)
        {
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]{
                new SqlParameter("@UName",obj.UName),//用户ID
                new SqlParameter("@ConsigneeName",obj.ConsigneeName),//收货人姓名
                new SqlParameter("@Phone",obj.Phone),//手机号码
                new SqlParameter("@Address",obj.Address),//收货地址
                new SqlParameter("@AddressDetail",obj.AddressDetail),//收货地址详情
                new SqlParameter("@YouZhengBianMa",obj.YouZhengBianMa),//邮政编码
                new SqlParameter("@Amount",obj.Amount),//总金额
            };
            //通过sql @@identity 全局变量 --得到刚刚上面订单表添加数据成功后的自增ID
            object OrderID = SqlHelper.ExecuteScalar("Order_Add", ter);//添加订单，获取订单ID

            //如果对象不为空的话
            if (OrderID != null)
            {
                //遍历购物车中每一件商品
                foreach (var item in cartItems)
                {
                    SqlParameter[] ter2 = new SqlParameter[]{
                        new SqlParameter("@OrderId",Convert.ToInt32(OrderID)),//订单自增ID
                        new SqlParameter("@ShoppID",item.ShoppID),//商品ID
                        new SqlParameter("@Price",item.Price),//商品价格
                        new SqlParameter("@Quantity",item.Quantity),//商品数量
                    };
                    //添加订单详细
                    SqlHelper.ExecuteNonQuery("OrderDetail_Add", ter2);
                }
            }
        }
        /// <summary>
        /// 查询全部订单信息
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public List<Orders_Model> Order_GetList_ByUserId(string UserName)
        {
            // 采用 list 集合存储数据
            List<Orders_Model> list = new List<Orders_Model>();
            // 采用数组存储参数
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@UserName",UserName)
            };
            using (SqlDataReader dr=SqlHelper.ExecuteReader("Order_GetList_ByUserId", param))
            {
                while (dr.Read())
                {
                    Orders_Model model = new Orders_Model();
                    model.OrderId = Convert.ToInt32(dr["OrderId"]);
                    model.OrderNo = Convert.ToString(dr["OrderNo"]);
                    model.Amount = Convert.ToDecimal(dr["Amount"]);
                    model.IsPayment = Convert.ToBoolean(dr["IsPayment"]);
                    model.OrderTime = Convert.ToDateTime(dr["OrderTime"]).ToString("yyyy-MM-dd");
                    list.Add(model);
                }
            }
            return list;
        }
    }
}
