<%@ WebHandler Language="C#" Class="lyr_ShippingAddress_ByID" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_ShippingAddress_ByID : IHttpHandler
{
    //实例化对象
    ShippingAddress_BLL bll = new ShippingAddress_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //收货地址自增ID
        int id = Convert.ToInt32(context.Request["id"]);
        List<ShippingAddress_Model> list = bll.ShippingAddress_ByID(id);

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