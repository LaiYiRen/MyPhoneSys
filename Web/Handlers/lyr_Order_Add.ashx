<%@ WebHandler Language="C#" Class="lyr_Order_Add" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_Order_Add : IHttpHandler
{
    //实例化对象
    Orders_BLL bll = new Orders_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //订单
        Orders_Model obj = new Orders_Model();
        //用户ID
        obj.UName = Convert.ToString(context.Request["arrOrder[0][UName]"]);
        //收货人姓名
        obj.ConsigneeName = Convert.ToString(context.Request["arrOrder[0][ConsigneeName]"]);
        //手机号码
        obj.Phone = Convert.ToString(context.Request["arrOrder[0][Phone]"]);
        //收货地址
        obj.Address = Convert.ToString(context.Request["arrOrder[0][Address]"]);
        //收货地址详情
        obj.AddressDetail = Convert.ToString(context.Request["arrOrder[0][AddressDetail]"]);
        //邮政编码
        obj.YouZhengBianMa = Convert.ToString(context.Request["arrOrder[0][YouZhengBianMa]"]);
        //商品总价格
        obj.Amount = Convert.ToDecimal(context.Request["arrOrder[0][Amount]"]);

        //订单详细
        List<OrdersDetail_Model> cartItems = new List<OrdersDetail_Model>();
        //存储购物车数组实际长度
        int cartItems_length = Convert.ToInt32(context.Request["arrCartItems_length"]);
        for (int i = 0; i < cartItems_length; i++)
        {
            //对象封装数据
            OrdersDetail_Model od = new OrdersDetail_Model();
            //商品ID
            od.ShoppID = Convert.ToInt32(context.Request["arrCartItems[" + i + "][ShoppID]"]);
            //商品价格
            od.Price = Convert.ToDecimal(context.Request["arrCartItems[" + i + "][Price]"]);
            //商品数量
            od.Quantity = Convert.ToInt32(context.Request["arrCartItems[" + i + "][Quantity]"]);

            //添加到集合存储
            cartItems.Add(od);
        }
        //调用方法
        bll.Order_Add(obj, cartItems);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}