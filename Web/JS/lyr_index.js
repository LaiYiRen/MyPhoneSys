/// <reference path="../Scripts/jquery-3.2.1.js" />
$(function () {
    loadInit();//初始化
    Login();//跳转到用户登陆界面
    GetAllPhoneInfo();//获取所有手机信息
    GetAllPhoneInfo2();//获取所有手机信息2(侧边栏)
})
//初始化
function loadInit() {
    if (window.sessionStorage.getItem("uname")==null) {
        //设置用户名
        $("#login").text("登录");
    }
    else {
        //设置用户名
        $("#login").text(window.sessionStorage.getItem("uname"));
    }
   
    
}
//获取页面传递过来的值
function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = decodeURIComponent(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}
//用户登陆
function Login() {
    $("#login").click(function () {
        if ($("#login").text() == "登录") {
            window.location.href = "../lyr_App/lyr_Login.html";
        }
        else {
            window.location.href = "../lyr_App/lyr_PersonalCenter.html";/*跳转到个人中心*/
            window.sessionStorage.setItem("uname", window.sessionStorage.getItem("uname"));
        }
    });
}
//获取所有手机信息
function GetAllPhoneInfo() {
    $.ajax({
        url: "../Handlers/lyr_index.ashx",
        type: "get",
        //data: par, //采用序列化传数据
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
            //第一步：找节点具体位置
            var x_Phone = $(".nav_main .container ul");
            //第二步：创建节点结构
            var str = "";
            var str2 = "";
            $.each(data, function (_index, obj) {
                //判断手机类型
                if (parseInt(obj.PhoneTypeID) == 1) {
                    str += "<li>";
                    str += "<div>";
                    if (obj.IsXinPin != "") {
                        str += "<button>" + obj.IsXinPin + "</button>";//新品
                    }
                    str += "</div>";
                    str += "<a href='#' pid='" + obj.PhoneInfoID + "'><img src='" + obj.PImage + "'/></a>"; //照片
                    str += "<div><a href='#' pid='" + obj.PhoneInfoID + "'>" + obj.PhoneName + "</a></div>";//手机名称
                    str += "<div><span>" + obj.Price + "</span></div>";//手机价格
                    str += "</li>";
                    str += "<li><b></b></li>";
                }
                else if (parseInt(obj.PhoneTypeID) == 2) {
                    str2 += "<li>";
                    str2 += "<div>";
                    if (obj.IsXinPin != "") {
                        str2 += "<button>" + obj.IsXinPin + "</button>";//新品
                    }
                    str2 += "</div>";
                    str2 += "<a href='#' pid='" + obj.PhoneInfoID + "'><img src='" + obj.PImage + "'/></a>"; //照片
                    str2 += "<div><a href='#' pid='" + obj.PhoneInfoID + "'>" + obj.PhoneName + "</a></div>";//手机名称
                    str2 += "<div><span>" + obj.Price + "</span></div>";//手机价格
                    str2 += "</li>";
                    str2 += "<li><b></b></li>";
                }
            });
            //往节点追加内容
            x_Phone.eq(0).append(str).children().remove("li:last-child");//小米手机
            x_Phone.eq(1).append(str2).children().remove("li:last-child");//红米手机
        }
    });
    a_click();
    //给超链接绑定单击事件
    function a_click() {
        $(".nav_main .container ul li a").click(function () {
            //window.location.href = "lyr_XiaoMix2.html?pid=" + $(this).attr("pid") + "&username=" + uname;//获取当前手机ID并且实现传值
            //跳转到商品详情
           window.location.href = "lyr_PhoneDetail.html";
            //存储商品id
            window.sessionStorage.setItem("id", $(this).attr("pid"));
        });
    }
}
//获取所有手机信息2
function GetAllPhoneInfo2() {
    $.ajax({
        url: "../Handlers/lyr_index.ashx",
        type: "get",
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
            //第一步：找节点具体位置
            var x_Phone = $(".banner .container .b_c_main ul");
            //第二步：创建节点结构
            var str = "";
            var str2 = "";
            $.each(data, function (_index, obj) {
                //判断手机类型
                if (parseInt(obj.PhoneInfoID) <= 6) {
                    str += "<li>";
                    str += "<a href='#' pid='" + obj.PhoneInfoID + "'><img src='" + obj.PImage2 + "'/>"; //照片
                    str += "<span pid='" + obj.PhoneInfoID + "'>" + obj.PhoneName + "</span></a>";//手机名称
                    str += "</li>";
                }
                else if (parseInt(obj.PhoneInfoID) >= 7 && parseInt(obj.PhoneInfoID) <= 12) {
                    str2 += "<li>";
                    str2 += "<a href='#' pid='" + obj.PhoneInfoID + "'><img src='" + obj.PImage2 + "'/>"; //照片
                    str2 += "<span pid='" + obj.PhoneInfoID + "'>" + obj.PhoneName + "</span></a>";//手机名称
                    str2 += "</li>";
                }
            });
            //往节点追加内容
            x_Phone.eq(0).append(str);//第一栏
            x_Phone.eq(1).append(str2);//第二栏
        }
    });
    a_click();
    //给超链接绑定单击事件
    function a_click() {
        $(".banner .container .b_c_main ul li a").click(function () {
            //跳转到商品详情
            window.location.href = "lyr_PhoneDetail.html";
            //存储商品id
            window.sessionStorage.setItem("id", $(this).attr("pid"));
        });
    }
}

