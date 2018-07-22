<%@ WebHandler Language="C#" Class="lyr_ShopCarts_ByUname_GetList" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_ShopCarts_ByUname_GetList : IHttpHandler
{
    //实例化对象
    ShopCarts_BLL bll = new ShopCarts_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //用户ID
        string uname = Convert.ToString(context.Request["uname"]);
        List<ShopCarts_Model> list = bll.ByUname_GetList(uname);

        //创建能对数据序列化/反序列化成Json格式的对象
        DataContractJsonSerializer dcj = new DataContractJsonSerializer(list.GetType());

        //将数据转换成Json格式的字符串通过响应流输出到客户端
        dcj.WriteObject(context.Response.OutputStream, list);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}