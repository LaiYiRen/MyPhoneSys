﻿<%@ WebHandler Language="C#" Class="lyr_ByUname_ShopQuantity" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_ByUname_ShopQuantity : IHttpHandler
{
    //实例化对象
    ShopCarts_BLL bll = new ShopCarts_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //用户ID
        string uname = Convert.ToString(context.Request["uname"]);
        //商品总数量
        int quantity = bll.ByUname_ShopQuantity(uname);
       
        //输出数据
        context.Response.Write(quantity);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}