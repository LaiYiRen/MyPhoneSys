using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //订单详细实体类库
    public class OrdersDetail_Model
    {
        public int DetailId { get; set; } //自增ID
        public int OrderId { get; set; }//订单自增D
        public int ShoppID { get; set; }//商品ID
        public decimal Price { get; set; }//商品价格
        public int Quantity { get; set; }//商品数量
        public string CancelTime { get; set; }//订单取消时间
        public bool IsValid { get; set; }//是否完成
        public string ShopName { get; set;}// 商品名称
        public string Image { get; set; }//商品图片
    }
}
