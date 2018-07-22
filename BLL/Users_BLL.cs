using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using DAL;

namespace BLL
{
    /// <summary>
    /// 用户业务类
    /// </summary>
    public class Users_BLL
    {
        //实例化对象
        Users_DAL dal = new Users_DAL();
        /// <summary>
        /// 1、用户登陆
        /// </summary>
        /// <param name="UName"></param>
        /// <returns></returns>
        public Users_Model Users_Login(string UName)
        {
            return dal.Users_Login(UName);
        }
        /// <summary>
        /// 2.用户注册
        /// </summary>
        /// <param name="us"></param>
        /// <returns></returns>
        public bool Users_Register(Users_Model us)
        {
            return dal.Users_Register(us);
        }
        /// <summary>
        /// 3、查询当前用户基本资料
        /// </summary>
        /// <param name="UName"></param>
        /// <returns></returns>
        public Users_Model Users_UserInfo_ById(string UName)
        {
            return dal.Users_UserInfo_ById(UName);
        }
    }
}
