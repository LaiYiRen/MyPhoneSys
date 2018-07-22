<%@ WebHandler Language="C#" Class="lyr_index" %>

using System;
using System.Web;
//引用
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_index : IHttpHandler
{
    PhoneInfo_BLL bll = new PhoneInfo_BLL();

    public void ProcessRequest(HttpContext context)
    {
        List<PhoneInfo_Model> list = bll.GetPhoneInfo();

        //创建能对数据序列化/反序列化成Json格式的对象
        DataContractJsonSerializer dcj = new DataContractJsonSerializer(list.GetType());
        //将数据转换成Json格式的字符串通过响应流输出到客户端
        dcj.WriteObject(context.Response.OutputStream, list);
    }
    public bool IsReusable
    {
        get { return false; }
    }
}