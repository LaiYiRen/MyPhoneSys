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
    //手机信息管理类
    public class PhoneInfo_BLL
    {
        PhoneInfo_DAL dal = new PhoneInfo_DAL();

        /// <summary>
        /// 1.获取所有手机信息
        /// </summary>
        /// <returns></returns>
        public List<PhoneInfo_Model> GetPhoneInfo()
        {
            return dal.GetPhoneInfo();
        }
    }
}
