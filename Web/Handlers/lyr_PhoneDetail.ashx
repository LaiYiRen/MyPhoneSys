<%@ WebHandler Language="C#" Class="lyr_PhoneDetail" %>

using System;
using System.Web;

// 引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_PhoneDetail : IHttpHandler
{   // 实例化对象
    PhoneDetail_BLL bll = new PhoneDetail_BLL();
    public void ProcessRequest(HttpContext context)
    {
        // 商品id
        int id = Convert.ToInt32(context.Request["id"]);
        List<PhoneDetail_Model> list = bll.PhoneDetail_ById(id);
        // 序列化成JSON格式并且输出
        DataContractJsonSerializer zer = new DataContractJsonSerializer(list.GetType());
        zer.WriteObject(context.Response.OutputStream, list);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}