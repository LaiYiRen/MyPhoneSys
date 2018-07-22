<%@ WebHandler Language="C#" Class="lyr_PersonalCenter_UserInfo_ById" %>

using System;
using System.Web;

//引用命名空间
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using Models;
using BLL;

public class lyr_PersonalCenter_UserInfo_ById : IHttpHandler
{
    //实例化对象
    Users_BLL bll = new Users_BLL();
    public void ProcessRequest(HttpContext context)
    {
        //用户ID
        string uname = Convert.ToString(context.Request["uname"]);
        Users_Model userInfo = bll.Users_UserInfo_ById(uname);
        //序列化成JSON格式并且输出
        DataContractJsonSerializer zer = new DataContractJsonSerializer(userInfo.GetType());
        zer.WriteObject(context.Response.OutputStream, userInfo);
        context.Response.End();
    }
    public bool IsReusable
    {
        get { return false; }
    }
}