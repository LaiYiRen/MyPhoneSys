using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //订单实体类库
    public class Orders_Model
    {
        public int OrderId { get; set; } //自增ID
        public string OrderNo { get; set; }//订单号
        public string UName { get; set; }//用户ID
        public string ConsigneeName { get; set; }//收货人姓名
        public string Phone { get; set; }//手机号码
        public string Address { get; set; }//收货地址
        public string AddressDetail { get; set; }//收货地址详情
        public string YouZhengBianMa { get; set; }//邮政编码
        public decimal Amount { get; set; }//商品总金额
        public string OrderTime { get; set; }//订单时间
        public string OrderState { get; set; }//订单状态

        public bool IsPayment { get; set; }// 是否付款
    }
}
