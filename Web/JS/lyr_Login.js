/// <reference path="../Scripts/jquery-3.2.1.js" />
//工厂函数
$(function () {
    UserLogin();//用户登陆
})
//1.用户登陆
function UserLogin() {
    //判断用户按下是回车键
    $(document).keydown(function (e) {
        if (e.keyCode == 13) {
            userlogin();
        }
    })
    $("#btnLogin").click(function () {
        userlogin();
    });
    function userlogin() {
        var txtUserName = $("#txtUserName").val();//获取账号/手机号码
        var txtPwd = $("#txtPwd").val();//密码
        var par = "UName=" + txtUserName;

        var login_msg = $("#login_Msg");
        login_msg = $("#login_Msg").html("");//清空提示文本
        if (txtUserName == "" || txtUserName == null) {
            document.getElementById("login_Msg").style.display = "block";
            login_msg.html("<i></i>" + " 请输入您的账号");
            return;
        }
        if (txtPwd == "" || txtPwd == null) {
            document.getElementById("login_Msg").style.display = "block";
            login_msg.html("<i></i>" + " 请输入您的密码");
            return;
        }

        $.ajax({
            url: "../Handlers/lyr_Login.ashx",
            type: "GET",
            data: par, //采用序列化传数据
            async: false, //同步数据
            cache: false,//是否缓存
            dataType: "json",//返回数据类型
            success: function (data) {              
                if (!isNaN(data)) {
                    document.getElementById("login_Msg").style.display = "block";
                    login_msg.html("<i></i>" + " 用户名或密码不正确");
                    return;
                }
                /*遍历集合*/
                $.each(data, function (index, info) {
                    //判断密码是否相等
                    if (txtPwd != info.Pwd) {
                        document.getElementById("login_Msg").style.display = "block";
                        login_msg.html("<i></i>" + " 用户名或密码不正确");
                    }
                    else {
                        $("#txtUserName").val("");//清空
                        $("#txtPwd").val("");//清空
                        document.getElementById("login_Msg").style.display = "none";
                        //window.location.href = "lyr_index.html?username=" + info.UName/*再原来页面直接跳转*/
                        window.location.href = "../lyr_App/lyr_index.html";
                        window.sessionStorage.setItem("uname",info.UName);
                    }                          
                });    
            }
        })
    }
}
