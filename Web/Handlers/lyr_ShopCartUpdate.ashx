<%@ WebHandler Language="C#" Class="lyr_ShopCartUpdate" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_ShopCartUpdate : IHttpHandler
{
    //实例化对象
    ShopCarts_BLL bll = new ShopCarts_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //商品id
        int id = Convert.ToInt32(context.Request["id"]);
        //商品数量
        int quantity = Convert.ToInt32(context.Request["quantity"]);
        //用户ID
        string uname = Convert.ToString(context.Request["uname"]);
        //调用方法
        bool b = bll.ShopCarts_Update(id,quantity,uname);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}