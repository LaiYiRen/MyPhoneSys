/// <reference path="../Scripts/jquery-3.2.1.min.js" />
var pid;
var username;
$(function () {
    load_Init();//初始化
    load_UserClick(); //设置用户单击 概述、图集、参数
    load_PhoneDetail();//加载商品详情
});
//初始化
function load_Init() {
    //设置用户名
    $("#login").text(window.sessionStorage.getItem("uname"));
    $(".addCart").click(ShopCartAdd);
}
//设置用户单击 概述、图集、参数
function load_UserClick() {
    var li_hover = $(".PhoneShopp .container .p_c_right ul .btnClick");
    var pic = $(".content .container .pic");
    //设置标记为1
    $(".PhoneShopp .container .p_c_right ul .btnClick").first().prop("state", "1");
    li_hover.click(function () {
        pic.eq($(this).index()).stop("true").show().siblings().hide();
        $(this).siblings().find("a").css("color", "#333");
        $(this).siblings().prop("state", "0");
        $(this).find("a").css("color", "#ff6720");
        $(this).prop("state", "1");
        $(this).siblings().last().find("a").css("color", "#FFFFFF");
    });
    li_hover.hover(function () { $(this).find("a").css("color", "#ff6720") }, function () { if ($(this).prop("state") != "1") $(this).find("a").css("color", "#333") });
}
//加载商品详情
function load_PhoneDetail() {
    $.ajax({
        url: "../Handlers/lyr_PhoneDetail.ashx",
        type: "post",
        data: {
            id: parseInt(window.sessionStorage.getItem("id"))//商品ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
            //第一步：找节点具体位置     
            var pic = $(".content .container .pic");
            //清空节点
            $.each(pic, function () { $(this).html("") });
            //第二步：创建节点结构
            $.each(data, function (_index, obj) {
                //修改标题
                $(".PhoneShopp .container .p_c_left  ul li").first().text(obj.PhoneName);
                //往节点追加内容
                pic.eq(0).append("<img src='" + obj.gaishu + "' />");
                pic.eq(1).append("<img src='" + obj.tuji + "' />");
                pic.eq(2).append("<img src='" + obj.canshu + "' />");
            });
        }
    });
}
//添加商品到购物车
function ShopCartAdd() {
    $.ajax({
        url: "../Handlers/lyr_ShopCartAdd.ashx",
        type: "post",
        data: {
            id: parseInt(window.sessionStorage.getItem("id")),//商品ID
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
        }
    });
    //转向我的购物车界面
    window.location.href = "../lyr_App/lyr_ShopCart.html";
}
