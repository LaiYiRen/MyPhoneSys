<%@ WebHandler Language="C#" Class="lyr_Login" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_Login : IHttpHandler
{
    //实例化对象
    Users_BLL bll = new Users_BLL();
    public void ProcessRequest(HttpContext context)
    {
        string UName = context.Request.Params["UName"];//接收参数值  
        Users_Model us = bll.Users_Login(UName);//调用方法
        Common.us = us;//保存用户对象
        //必须使用List要不然对象为空的时候json转换失败（谨记）
        List<Users_Model> list = new List<Users_Model>();
        list.Add(us);
        //把数据转成JSON格式
        DataContractJsonSerializer zer = new DataContractJsonSerializer(list.GetType());
        zer.WriteObject(context.Response.OutputStream, list);
        context.Response.End();

    }
    public bool IsReusable
    {
        get { return false; }
    }
}