/// <reference path="../Scripts/jquery-3.2.1.min.js" />
$(function () {
    load_Init();// 初始化
    load_UserInfoById();// 加载属于当前用户的基本资料
    load_OrderGetListByUserId();// 加载订单信息
});
// 初始化
function load_Init() {
    // 设置用户名
    $("#login").text(window.sessionStorage.getItem("uname"));
}
// 加载属于当前用户的基本资料
function load_UserInfoById() {
    $.ajax({
        url: "../Handlers/lyr_PersonalCenter_UserInfo_ById.ashx",
        type: "post",
        data: {
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, // 参数
        async: false, // 同步数据
        cache: false,// 是否缓存
        dataType: "json",// 返回数据类型
        success: function (obj) {
            // 清空 html
            $(".wodeziliao").html("");
            // 声明一个变量
            var str = "";
            // 节点结构
            str += "<ul class='ul_list'>";
            str += "<li>姓名：<span>" + obj.UName + "</span></li>";
            str += "<li>电话：<span>" + obj.Phone + "</span></li>";
            str += "<li>邮箱：<span>" + obj.Email + "</span></li>";
            str += "<li>性别：<span>" + obj.Sex + "</span></li>";
            str += "<li>生日：<span>" + obj.Birthday + "</span></li>";
            str += "<li>QQ：<span>" + obj.QQ + "</span></li>";
            str += "<li>微信：<span>" + obj.WeiXin + "</span></li>";
            str += "<li>身份证：<span>" + obj.ShenFenZheng + "</span></li>";
            str += "<li>家庭住址：<span>" + obj.Address + "</span></li>";
            str += "<li>注册时间：<span>" + obj.RegisTime + "</span></li>";
            str += "</ul>";
            // 追加内容
            $(".wodeziliao").append(str);
        }
    });
}
// 加载订单信息
function load_OrderGetListByUserId() {
    $(".wodedingdanStart").click(function () {
        $.ajax({
            url: "../Handlers/lyr_Order_GetList_ByUserId.ashx",
            type: "post",
            data: {
                UserName: (window.sessionStorage.getItem("uname").toString()),//用户ID
            }, //参数
            async: false, //同步数据
            cache: false,//是否缓存
            dataType: "json",//返回数据类型
            success: function (data) {
                // 清空 html
                $("#wodedingdan-right").html("");
                // 声明一个变量
                var str = "";
                $.each(data, function (index, obj) {
                    // 节点结构
                    str += "<ul class='ul_list'>";
                    str += "<div class='order-item'>";
                    str += "<div class='order-title'>";
                    str += "<h3>" + obj.OrderTime + "</h3>";
                    str += "</div>";
                    str += "<div class='order-content'>";
                    str += "<ul class='ul_list clearFloat'>";
                    str += "<li>外观</li>";
                    str += "<li>名称</li>";
                    str += "<li>数量</li>";
                    str += "<li>小计</li>";
                    str += "</ul>";
                    str += load_OrderDetails(obj.OrderId);// 参数1：节点结构；参数2：订单Id  
                    str += "</div>";
                    str += "<div class='order-operate'><span>总价:<span>￥" + obj.Amount + "元</span></span> </div>";
                    str += "</div>";
                });
                // 追加内容
                $("#wodedingdan-right").append(str); // 加载订单详细信息
            }
        });
    });
}
// 加载订单详细信息
function load_OrderDetails(OrderId) {
    var str = "";
    $.ajax({
        url: "../Handlers/lyr_OrderDetail_GetList_ByOrderId.ashx",
        type: "post",
        data: {
            OrderId: OrderId,// 订单Id
        }, // 参数
        async: false, // 同步数据
        cache: false,// 是否缓存
        dataType: "json",// 返回数据类型
        success: function (data) {
            // 遍历
            $.each(data, function (index, obj2) {
                str += "<ul class='ul_list clearFloat'>";
                str += "<li class='img'>";
                str += "<img src='" + obj2.Image + "' /></li>";
                str += "<li>" + obj2.ShopName + "</li>";
                str += "<li>" + obj2.Quantity + "</li>";
                str += "<li class='price'>￥" + (obj2.Price * obj2.Quantity) + "元</li>";
                str += "</ul>";
            });
        }
    });
    return str;
}