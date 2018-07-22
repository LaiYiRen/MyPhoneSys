/// <reference path="../Scripts/jquery-3.2.1.min.js" />
$(function () {
    load_Init();//初始化
    load_ShippingAddress_ByUname_GetList(); //加载属于当前用户的所有收货地址
    Login();//用户登陆
    ConfirmOrders(); //立即下单
});
//初始化
function load_Init() {
    //设置用户名
    $("#login").text(window.sessionStorage.getItem("uname"));

    //设置商品件数
    $(".shopQuantity").text(window.sessionStorage.getItem("shopQuantity"));
    //设置商品总价格
    $(".shopAmount").text(window.sessionStorage.getItem("shopAmount"));

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
//加载属于当前用户的所有收货地址
function load_ShippingAddress_ByUname_GetList() {
    $.ajax({
        url: "../Handlers/lyr_ShippingAddress_ByUname_GetList.ashx",
        type: "post",
        data: {
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
            $(".MyOrder-container-middle .middle-left").html("");
            $.each(data, function (_index, _obj) {
                var str = "";

                str += "<dl class='dl_list' aid='" + _obj.ShippingAddressID + "'>";
                str += "<dt>" + _obj.ShipingPersonName + "</dt>";
                str += "<dd>" + _obj.Phone + "</dd>";
                str += "<dd>" + _obj.Address + "</dd>";
                str += "<dd>" + _obj.DetailAddress + "</dd>";
                str += "<dd>" + _obj.YouZhengBianMa + "</dd>";
                str += "</dl>";

                $(".MyOrder-container-middle .middle-left").append(str);
            });
        }
    });
    //加载 div_Address 鼠标划入、划出、单击事件
    load_hover_click();
}
//加载 div_Address 鼠标划入、划出、单击事件
function load_hover_click() {
    //查找
    var dl = $(".middle-left dl");
    //标记
    dl.prop("falg", "0");
    dl.eq(0).prop("falg", "1");
    //鼠标单击
    dl.click(function () {
        //标记
        $(this).prop("falg", "1").siblings("dl").prop("falg", "0");
        $(this).css("background-color", "#ff6700").css("color", "white").siblings("dl").css("background-color", "white").css("color", "black");

        //鼠标单击获取收货地址内容
        load_AddressTool_click(this);
    });
    //鼠标划入、划出
    dl.hover(function () {
        if (parseInt($(this).prop("falg")) == 0) {
            $(this).css("background-color", "#f0f0f0f0").css("color", "red").css("transition-duration", "0.3s");
        }
    }, function () {
        if (parseInt($(this).prop("falg")) == 0) {
            $(this).css("background-color", "white").css("color", "black").css("transition-duration", "0.3s");
        }
    });
}
//鼠标单击获取收货地址内容
function load_AddressTool_click(obj) {
    //alert($(".middle-right-middle .left li:even").length);
    $.ajax({
        url: "../Handlers/lyr_ShippingAddress_ByID.ashx",
        type: "post",
        data: {
            id: parseInt($(obj).attr("aid")),//收货地址自增ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {  
            $.each(data, function (_index, _obj) {

                //获取对象
                var address_Obj = $(".middle-right-middle .left li:odd");
                address_Obj.eq(0).text(_obj.ShipingPersonName);
                address_Obj.eq(1).text(_obj.Phone);
                address_Obj.eq(2).text(_obj.Address);
                address_Obj.eq(3).text(_obj.DetailAddress);
                address_Obj.eq(4).text(_obj.YouZhengBianMa);

            });
        }
    });
}
//立即下单
function ConfirmOrders() {
    //鼠标单击
    $(".ConfirmOrders").click(function () {
        //获取收货地址对象
        var address_Obj = $(".middle-right-middle .left li:odd");
        //接收数组对象
        var arrCartItems = window.sessionStorage.getItem("arrCartItems");

        //购物车数据实际长度
        var arrCartItems_length = window.sessionStorage.getItem("arrCartItems_length");
        //对象数组
        var arrOrder = new Array();
        arrOrder = [{
            "UName": window.sessionStorage.getItem("uname").toString(), //用户ID
            "ConsigneeName": address_Obj.eq(0).text(),//收货人姓名
            "Phone": address_Obj.eq(1).text(),//手机号码
            "Address": address_Obj.eq(2).text(),//收货地址
            "AddressDetail": address_Obj.eq(3).text(),//收货地址详情
            "YouZhengBianMa": address_Obj.eq(4).text(),//邮政编码
            "Amount": $(".shopAmount").last().text(),//商品总金额
        }];
        $.ajax({
            url: "../Handlers/lyr_Order_Add.ashx",
            type: "post",
            data: {
                arrOrder: arrOrder,//订单
                arrCartItems:JSON.parse(arrCartItems),//订单详细（重新转换成对象）
                arrCartItems_length: arrCartItems_length,//购物车数据实际长度
            }, //参数
            async: false, //同步数据
            cache: false,//是否缓存
            dataType: "json",//返回数据类型
            success: function (data) {
            }
        });       
        //清空临时存储购物车数据
        window.sessionStorage.removeItem("arrCartItems");

        alert("下单成功！");

        //转向支付订单界面
        window.location.href = "../lyr_App/lyr_PaymentOrders.html";
    });
}