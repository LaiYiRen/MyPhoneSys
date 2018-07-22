<%@ WebHandler Language="C#" Class="lyr_ShopCartAdd" %>

using System;
using System.Web;
//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_ShopCartAdd : IHttpHandler
{
    //实例化对象
    ShopCarts_BLL bll = new ShopCarts_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //商品id
        int id = Convert.ToInt32(context.Request["id"]);
        //用户ID
        string uname = Convert.ToString(context.Request["uname"]);
        //调用方法
        bool b = bll.ShopCarts_Add(id, uname);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}