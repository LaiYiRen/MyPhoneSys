<%@ WebHandler Language="C#" Class="lyr_Order_GetList_ByUserId" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_Order_GetList_ByUserId : IHttpHandler
{
    // 实例化对象
    Orders_BLL bll = new Orders_BLL();
    public void ProcessRequest(HttpContext context)
    {
        // 用户Id
        string UserName = Convert.ToString(context.Request["UserName"]);
        List<Orders_Model> list = bll.Order_GetList_ByUserId(UserName);

        // 创建能对数据序列化/反序列化成Json格式的对象
        DataContractJsonSerializer dcj = new DataContractJsonSerializer(list.GetType());

        // 将数据转换成Json格式的字符串通过响应流输出到客户端
        dcj.WriteObject(context.Response.OutputStream, list);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}