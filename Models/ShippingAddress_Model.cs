using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //收货地址实体类库
    public class ShippingAddress_Model
    {
        public int ShippingAddressID { get; set; }//自增ID
        public string UName { get; set; }//用户ID
        public string ShipingPersonName { get; set; }//收货人姓名
        public string Phone { get; set; }//手机号码
        public string Address { get; set; }//收货地址
        public string DetailAddress { get; set; }//收货地址详情
        public string YouZhengBianMa { get; set; }//邮政编码
    }
}
