using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //购物车实体类库
    public class ShopCarts_Model
    {
        public int ShopCartsID { get; set; } //自增ID
        public int ID { get; set; }//商品ID
        public string Names { get; set; }//商品名称
        public decimal Price { get; set; }//商品价格
        public int Quantity { get; set; }//商品数量
        public string Uname { get; set; }//用户ID
        public string Img { get; set; }//商品图片
    }
}
