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
    public class ShopCarts_BLL
    {
        ShopCarts_DAL dal = new ShopCarts_DAL();
        /// <summary>
        /// 添加商品到购物车
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Add(int id, string uname)
        {
            return dal.ShopCarts_Add(id, uname);
        }
        /// <summary>
        /// 查询出属于当前 用户登陆  购物车商品信息
        /// </summary>
        /// <returns></returns>
        public List<ShopCarts_Model> ByUname_GetList(string uname)
        {
            return dal.ByUname_GetList(uname);
        }

        /// <summary>
        /// 修改属于当前 用户登陆  购物车商品数量
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Update(int id, int quantity, string uname)
        {
            return dal.ShopCarts_Update(id, quantity, uname);
        }

        /// <summary>
        /// 获取属于当前 用户登陆  购物车商品总数量
        /// </summary>
        /// <returns></returns>
        public int ByUname_ShopQuantity(string uname)
        {
            return dal.ByUname_ShopQuantity(uname);
        }

        /// <summary>
        /// 删除属于当前 用户登陆  购物车商品
        /// </summary>
        /// <returns></returns>
        public bool ShopCarts_Delete(int id, string uname)
        {
            return dal.ShopCarts_Delete(id,uname);
        }
    }
}

