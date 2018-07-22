using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// 引用
using Models;
using DAL;

namespace BLL
{
    //订单详细业务逻辑层
    public class OrdersDetail_BLL
    {
        // 实例化对象
        OrdersDetail_DAL dal = new OrdersDetail_DAL();
        /// <summary>
        /// 根据订单号查询订单详细信息
        /// </summary>
        /// <param name="OrderId"></param>
        /// <returns></returns>
        public List<OrdersDetail_Model> OrderDetail_GetList_ByOrderId(int OrderId)
        {
           return dal.OrderDetail_GetList_ByOrderId(OrderId);
        }
    }
}
