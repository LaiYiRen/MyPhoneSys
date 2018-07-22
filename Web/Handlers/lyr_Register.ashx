<%@ WebHandler Language="C#" Class="lyr_Register" %>

using System;
using System.Web;
using Models;//
using BLL;//
using System.Runtime.Serialization.Json;

public class lyr_Register : IHttpHandler
{
    Users_BLL bll = new Users_BLL();
    public void ProcessRequest(HttpContext context)
    {
        Users_BLL b = new Users_BLL();

        Users_Model us = new Users_Model()
        {
            UName = context.Request.Params["UName"],//接收参数值  
            Pwd = context.Request.Params["Pwd"]
        };
        //利用文件流保存  
        context.Response.Write(bll.Users_Register(us));//调用方法
    }
    public bool IsReusable
    {
        get { return false; }
    }
}