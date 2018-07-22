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
    //手机类型服务类
    public class PhoneType_BLL
    {
        PhoneType_DAL dal = new PhoneType_DAL();

        /// <summary>
        /// 1.获取所有手机类型信息
        /// </summary>
        /// <returns></returns>
        public List<PhoneType_Model> GetPhoneType()
        {
            return dal.GetPhoneType();
        }
    }
}
