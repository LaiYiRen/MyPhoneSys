/// <reference path="../Scripts/jquery-3.2.1.js" />
//工厂函数
$(function () {
    UserRegister();
})
//1.用户登陆
function UserRegister() {
    //判断用户按下是回车键
    $(document).keydown(function (e) {
        if (e.keyCode == 13) {
            userlogin();
        }
    })
    $("#register").click(function () {
        userRegister();
    });
    function userRegister() {

        var txtUserName = $("#txtUserName").val();//获取账号/手机号码
        var txtPwd = $("#txtPwd").val();//密码
        var txtPwd2 = $("#txtPwd2").val();//确认密码

        login_msg = $("#login_Msg").html("");//清空提示文本
        var login_msg = $("#login_Msg");

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
        if (txtPwd!=txtPwd2) {
            document.getElementById("login_Msg").style.display = "block";
            login_msg.html("<i></i>" + "两次密码输入不一致");
            return;
        }
        var par = "UName=" + txtUserName + "&" + "Pwd=" + txtPwd;
        $.ajax({
            url: "../Handlers/lyr_Register.ashx",
            type: "Get",
            data: par,   //======采用序列化传数据
            async: false, //=====同步数据
            cache: false,//是否缓存
            dataType: "text",//返回数据类型
            success: function (data) {
                if (data=="False") {
                    document.getElementById("login_Msg").style.display = "block";
                    login_msg.html("<i></i>" + "该用户名已经存在");
                }
                else {
                    document.getElementById("login_Msg").style.display = "block";
                    $("#txtUserName").val("");//清空
                    $("#txtPwd").val("");//清空
                    window.location.href = "../lyr_App/lyr_index.html";
                    window.sessionStorage.setItem("uname", txtUserName);
                }
            }
        })
    }
}
