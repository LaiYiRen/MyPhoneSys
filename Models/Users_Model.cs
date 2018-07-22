using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    //用户实体类
    public class Users_Model
    {
        public int UserID { get; set; }//用户ID
        public string UName { get; set; }//用户名
        public string Pwd { get; set; }//密 码
        public string Phone { get; set; }//联系电话
        public string Email { get; set; }//邮箱
        public string Sex { get; set; }//性别
        public string Birthday { get; set; }//生日
        public string QQ { get; set; }//QQ
        public string WeiXin { get; set; }//微信
        public string Address { get; set; }//居住地
        public string ShenFenZheng { get; set; }//身份证
        public string RegisTime { get; set; }//注册时间
        public string LastTime { get; set; }//最后一次登录时间
        public bool IsVaild { get; set; }//是否有效
    }
}
