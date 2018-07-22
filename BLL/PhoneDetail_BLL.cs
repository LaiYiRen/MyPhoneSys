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
    public class PhoneDetail_BLL
    {
        //实例化对象
        PhoneDetail_DAL dal = new PhoneDetail_DAL();
        //根据商品ID查看详细
        public List<PhoneDetail_Model> PhoneDetail_ById(int id)
        {
            return dal.PhoneDetail_ById(id);
        }
    }
}
