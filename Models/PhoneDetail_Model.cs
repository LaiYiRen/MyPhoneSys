using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //商品详细实体类
    public class PhoneDetail_Model
    {
        public int PhoneDetailID { get; set; }//自增ID
        public int PhoneInfoID { get; set; }//商品ID
        public string PhoneName { get; set; }//商品名称
        public string gaishu { get; set; }//概述
        public string tuji { get; set; }//图集
        public string canshu { get; set; }//参数
    }
}
