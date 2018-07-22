using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//引用
using Models;
using DAL;

namespace BLL
{
    // 订单业务逻辑层
    public class Orders_BLL
    {
        // 实例化对象
        Orders_DAL dal = new Orders_DAL();
        /// <summary>
        /// 新增订单并且新增订单详情
        /// </summary>
        /// <returns></returns>
        public void Order_Add(Orders_Model obj, List<OrdersDetail_Model> cartItems)
        {
            dal.Order_Add(obj, cartItems);
        }
        /// <summary>
        /// 查询全部订单信息
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public List<Orders_Model> Order_GetList_ByUserId(string UserName)
        {
            return dal.Order_GetList_ByUserId(UserName);
        }
    }
}
