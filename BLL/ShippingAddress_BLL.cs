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
    //业务逻辑层
    public class ShippingAddress_BLL
    {
        ShippingAddress_DAL dal = new ShippingAddress_DAL();
        /// <summary>
        /// 根据用户ID查看属于该用户的所有收货地址
        /// </summary>
        /// <param name="uname"></param>
        /// <returns></returns>
        public List<ShippingAddress_Model> ByUname_GetList(string uname)
        {
            return dal.ByUname_GetList(uname);
        }
        /// <summary>
        /// 根据收货地址自增ID查看详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<ShippingAddress_Model> ShippingAddress_ByID(int id)
        {
            return dal.ShippingAddress_ByID(id);
        }
    }
}
