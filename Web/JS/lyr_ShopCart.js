/// <reference path="../Scripts/jquery-3.2.1.js" />
$(function () {
    load_Init(); //初始化
    load_ShopCart_ByUname_GetList();//加载属于当前用户的购物车商品信息
    Login();//用户登陆
    checkbox_SelAll();//全选
    btn_minus();//减少按钮
    btn_add();//增加按钮
    textBox_IsNumber();//文本框
    ShopCarts_SelQuantity(); //获取选中商品总数量
    ShopCarts_Quantity();//获取商品总数量
    ShopCart_Delete();//删除购物车商品
    GoBalanc();//去结算
});
var selShopQuantiy = 0;//统计选中商品数量
var shopAmount = 0;//统计商品总价格
//初始化
function load_Init() {
    //设置用户名
    $("#login").text(window.sessionStorage.getItem("uname"));
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
//加载属于当前用户的购物车商品信息
function load_ShopCart_ByUname_GetList() {
    $.ajax({
        url: "../Handlers/lyr_ShopCarts_ByUname_GetList.ashx",
        type: "post",
        data: {
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
            $(".ShopCart .container .middle").html("");
            $.each(data, function (_index, obj) {
                var str = "";
                str += "<div class='shopitem' pid=" + obj.ShopCartsID + " sid="+obj.ID+">";
                str += "<ul class='ul_list'>";
                str += "<li class='sel'><i class='iconfont checkbox'>&#xe6c4;</i></li>";
                str += "<li class='shopName'>";
                str += "<span class='img'>";
                str += "<img src='" + obj.Img + "' /></span>";
                str += "<span class='name'>" + obj.Names + "</span>";
                str += "</li>";
                str += "<li class='danjia'>￥<span class='price'>" + obj.Price + "</span>元</li>";
                str += "<li class='shuliang'>";
                str += "<div class='count_container' pid=" + obj.ShopCartsID + ">";
                str += "<i class='iconfont minus'>&#xe611;</i><input class='quantity' type='text' value='" + obj.Quantity + "' /><i class='iconfont add'>&#xe62a;</i>";
                str += "</div>";
                str += "</li>";
                str += "<li class='xiaoji'>￥<span class='min_Amount'>" + (obj.Price * obj.Quantity) + "</span>元</li>";
                str += "<li class='caozuo'><i class='iconfont delete' pid=" + obj.ShopCartsID + ">&#xe63d;</i></li>";
                str += "</ul>";
                str += "</div>";
                $(".ShopCart .container .middle").append(str);
            });
        }
    });
    //给复选框绑定单击、划过事件
    load_CheckBox_BindEvent();
}
//给复选框绑定单击、划过事件
function load_CheckBox_BindEvent() {
    //标记初始值为 0
    $(".checkbox").prop("flag", "0");
    //鼠标单击事件
    $(".sel .checkbox").click(function () {
        var flag = $(this).prop("flag");
        if (flag == 1) {
            //标记复选框为不选中状态
            $(this).prop("flag", "0");
            //设置字体颜色并且添加实现延迟效果
            $(this).css("color", "#75757C").css("transition-duration", "0.3s");
            //设置背景颜色并且把边框颜色设为初始值
            $(this).css("background-color", "").css("border-color", "#b0b0b0");

            //如果商品复选框全部选中那么 全选 复选也要选中
            var quantity = $(".sel .checkbox").length;
            var quantity2 = 0;
            $(".sel .checkbox").each(function (_index, obj) {
                if ($(this).prop("flag") == 1) {
                    quantity2++;
                }
            });
            if (quantity == quantity2) {//如果商品全部勾选中那么 全选 复选框为勾选状态
                //标记复选框为选中状态
                $(".selAll .checkbox").prop("flag", "1");
                //设置字体颜色并且添加实现延迟效果
                $(".selAll .checkbox").css("color", "#FFFFFF").css("transition-duration", "0.3s");
                //设置背景颜色并且把边框颜色设为透明色
                $(".selAll .checkbox").css("background-color", "#FF6720").css("border-color", "transparent");
            }
            else if (quantity2 < quantity) {//如果商品复选框勾选数量小于总数量那么 全选 复选框也要取消勾选状态
                //标记 全选 复选框为不选中状态
                $(".selAll .checkbox").prop("flag", "0");
                //设置 全选 复选框背景颜色并且把边框颜色设为初始值
                $(".selAll .checkbox").css("background-color", "").css("border-color", "#b0b0b0");

                //标记 当前 复选框为不选中状态
                $(this).prop("flag", "0");
                //设置字体颜色并且添加实现延迟效果
                $(this).css("color", "#75757C").css("transition-duration", "0.3s");
                //设置背景颜色并且把边框颜色设为初始值
                $(this).css("background-color", "").css("border-color", "#b0b0b0");
            }
            if (quantity2 < 1) {
                //改变去结算按钮颜色并且禁用该按钮
                $(".qujiesuan .jiesuan").prop("disabled", "disabled").css("background-color", "#e0e0e0").css("color", "black");
            }

            //获取选中商品总数量 
            ShopCarts_SelQuantity(this, (parseInt($(this).parent().parent().parent().find(".quantity").val())));

            //单选商品大合计
            ShopCarts_MaxAmount(this);
        }
        else {
            //标记复选框为选中状态
            $(this).prop("flag", "1");
            //设置字体颜色并且添加实现延迟效果
            $(this).css("color", "#FFFFFF").css("transition-duration", "0.3s");
            //设置背景颜色并且把边框颜色设为透明色
            $(this).css("background-color", "#FF6720").css("border-color", "transparent");

            //如果商品复选框全部选中那么 全选 复选也要选中
            var quantity = $(".sel .checkbox").length;
            var quantity2 = 0;
            $(".sel .checkbox").each(function (_index, obj) {
                if ($(this).prop("flag") == 1) {
                    quantity2++;
                }
            });
            if (quantity == quantity2) {//如果商品全部勾选中那么 全选 复选框为勾选状态
                //标记复选框为选中状态
                $(".selAll .checkbox").prop("flag", "1");
                //设置字体颜色并且添加实现延迟效果
                $(".selAll .checkbox").css("color", "#FFFFFF").css("transition-duration", "0.3s");
                //设置背景颜色并且把边框颜色设为透明色
                $(".selAll .checkbox").css("background-color", "#FF6720").css("border-color", "transparent");
            }
            if (quantity2 >= 1) {
                //改变去结算按钮颜色并且启用该按钮
                $(".qujiesuan .jiesuan").prop("disabled", "").css("background-color", "#ff6700").css("color", "white");
            }
            //获取选中商品总数量 
            ShopCarts_SelQuantity(this, (parseInt($(this).parent().parent().parent().find(".quantity").val())));

            //记录数
            huaruQuantity = parseInt($(this).parent().parent().parent().find(".quantity").val());

            //单选商品大合计
            ShopCarts_MaxAmount(this);
        }
    });
    //鼠标划过复选框事件
    $(".checkbox").hover(function () {
        var flag = $(this).prop("flag");
        if (flag == 0) {
            //设置字体颜色并且添加实现延迟效果
            $(this).css("color", "#75757C").css("transition-duration", "0.3s");
        }
    }, function () {
        var flag = $(this).prop("flag");
        if (flag == 0) {
            //设置字体为透明色并且添加实现延迟效果
            $(this).css("color", "transparent").css("transition-duration", "0.3s");
        }
    });
}
//全选
function checkbox_SelAll() {
    $(".selAll .checkbox").click(function () {
        var flag = $(this).prop("flag");
        if (flag == 1) {
            //标记 所有 复选框为不选中状态
            $(".checkbox").prop("flag", "0");
            //设置 其他 复选框字体颜色并且添加实现延迟效果
            $(".checkbox").css("color", "").css("transition-duration", "0.3s");
            //设置 当前 复选框字体颜色并且添加实现延迟效果
            $(this).css("color", "#75757C").css("transition-duration", "0.3s");
            //设置背景颜色并且把边框颜色设为初始值
            $(".checkbox").css("background-color", "").css("border-color", "#b0b0b0");

            //全选获取商品总数量
            ShopCarts_AllQuantity(this);

            //全选商品大合计
            ShopCarts_SelAll_MaxAmount(this);

            //改变去结算按钮颜色并且禁用该按钮
            $(".qujiesuan .jiesuan").prop("disabled", "disabled").css("background-color", "#e0e0e0").css("color", "black");
        }
        else {
            //标记复选框为选中状态
            $(".checkbox").prop("flag", "1");
            //设置字体颜色并且添加实现延迟效果
            $(".checkbox").css("color", "#FFFFFF").css("transition-duration", "0.3s");
            //设置背景颜色并且把边框颜色设为透明色
            $(".checkbox").css("background-color", "#FF6720").css("border-color", "transparent");

            //全选获取商品总数量
            ShopCarts_AllQuantity(this);

            //全选商品大合计
            ShopCarts_SelAll_MaxAmount(this);

            //改变去结算按钮颜色并且启用该按钮
            $(".qujiesuan .jiesuan").prop("disabled", "").css("background-color", "#ff6700").css("color", "white");
        }
    });
}
//文本框
function textBox_IsNumber() {
    //初始化标记
    $(".count_container .quantity").prop("flag", "划出")
    //文本框值变动
    $(".count_container .quantity").change(function () {
        //获取对象
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //判断复选框是否打上勾
        if (parseInt($(this).parent().parent().parent().find(".sel .checkbox").prop("flag")) == 1) {
            //减去鼠标
            selShopQuantiy -= parseInt($(this).prop("oldval"));
            //获取选中商品总数量 
            ShopCarts_SelQuantity(this, parseInt(quantity));
        }
        //已经做了
        parseInt($(this).prop("flag", "划出"));

        //复选框打上勾才可以计算
        if ($(this).parent().parent().parent().find(".sel .checkbox").prop("flag") == 1) {
            var price = parseInt($(this).parent().parent().parent().find(".price").text());
            //减掉小合计价格
            shopAmount -= (price * parseInt($(this).prop("oldval")))
        }
        //商品小合计
        ShopCarts_MinAmount(this);

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
    //鼠标划入
    $(".count_container .quantity").mouseenter(function () {
        //获取对象
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        //做标记
        if ($(this).prop("flag") == "划出") {
            //保存鼠标划入前的值
            $(this).prop("oldval", parseInt(textBox.val()));
            $(this).prop("flag", "划入");
        }

        //判断是否输入的值是否是数字呢
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).prop("oldval")));
        }

        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity()

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
    //鼠标划出
    $(".count_container .quantity").mouseout(function () {
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
}
//减少按钮
function btn_minus() {
    //鼠标单击
    $(".count_container .minus").click(function () {
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (quantity <= 1) {
            return;
        }

        if (parseInt($(this).parent().parent().parent().find(".sel .checkbox").prop("flag")) == 1) {
            //减掉商品数量 
            selShopQuantiy -= parseInt($(this).parent().parent().parent().find(".quantity").val());

            //获取选中商品总数量 
            ShopCarts_SelQuantity(this, (parseInt(quantity) - 1));
        }

        //复选框打上勾才可以计算
        if ($(this).parent().parent().parent().find(".sel .checkbox").prop("flag") == 1) {
            //减掉小合计价格
            shopAmount -= parseInt($(this).parent().parent().parent().find(".min_Amount").text());
        }

        //记录鼠标划入文本框前的值减少1
        var oldval = parseInt($(this).parent().parent().find(".quantity").prop("oldval"));
        oldval--;
        $(this).parent().parent().find(".quantity").prop("oldval", oldval);

        //商品数量减少 1
        quantity--;
        //重新赋值
        textBox.val(quantity);
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //商品小合计
        ShopCarts_MinAmount(this);
    });
    //鼠标划入
    $(".count_container .minus").mouseenter(function () {
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();

        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
    //鼠标划出
    $(".count_container .minus").mouseout(function () {
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
}
//增加按钮
function btn_add() {
    //鼠标单击
    $(".count_container .add").click(function () {
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (quantity >= 999) {
            return;
        }
        if (parseInt($(this).parent().parent().parent().find(".sel .checkbox").prop("flag")) == 1) {
            //减掉商品数量 
            selShopQuantiy -= parseInt($(this).parent().parent().parent().find(".quantity").val());

            //获取选中商品总数量 
            ShopCarts_SelQuantity(this, (parseInt(quantity) + 1));
        }

        //复选框打上勾才可以计算
        if ($(this).parent().parent().parent().find(".sel .checkbox").prop("flag") == 1) {
            //减掉小合计价格
            shopAmount -= parseInt($(this).parent().parent().parent().find(".min_Amount").text());
        }

        //记录鼠标划入文本框前的值增加1
        var oldval = parseInt($(this).parent().parent().find(".quantity").prop("oldval"));
        oldval++;
        $(this).parent().parent().find(".quantity").prop("oldval", oldval);

        //商品数量增加 1
        quantity++;

        //重新赋值
        textBox.val(quantity);
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();
        //商品小合计
        ShopCarts_MinAmount(this);
    });
    //鼠标划入
    $(".count_container .add").mouseenter(function () {
        //获取对象
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
    //鼠标划出
    $(".count_container .add").mouseout(function () {
        //获取对象
        var textBox = $(this).parent().find(".quantity");
        var quantity = textBox.val();
        if (isNaN(quantity)) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        if (quantity < 1 || quantity >= 1000) {
            textBox.val(parseInt($(this).parent().parent().find(".quantity").prop("oldval")));
        }
        //修改购物车商品数量
        ShopCarts_Update(this);
        //获取商品总数量
        ShopCarts_Quantity();

        //去除数值前面的 00000
        textBox.val(parseInt(textBox.val()));
    });
}
//修改购物车商品数量
function ShopCarts_Update(obj) {
    $.ajax({
        url: "../Handlers/lyr_ShopCartUpdate.ashx",
        type: "post",
        data: {
            id: $(obj).parent().attr("pid"),//商品ID
            quantity: parseInt($(obj).parent().find(".quantity").val()),//商品数量
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "json",//返回数据类型
        success: function (data) {
        }
    });
}
//获取商品总数量（Js）
function ShopCarts_Quantity() {
    var quantity = 0;
    $(".count_container .quantity").each(function (_index, obj) {
        quantity += parseInt($(this).val());
    });
    //总共 N 件商品
    $(".shop_Sum_Count").text(quantity);
}
//获取商品总数量2（Sql）
function ShopCarts_Quantity2() {
    $.ajax({
        url: "../Handlers/lyr_ByUname_ShopQuantity.ashx",
        type: "post",
        data: {
            uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
        }, //参数
        async: false, //同步数据
        cache: false,//是否缓存
        dataType: "text",//返回数据类型
        success: function (data) {
            var quantity = parseInt(data);
            //总共 N 件商品
            $(".shop_Sum_Count").text(quantity);
        }
    });
}
//获取选中商品总数量 
function ShopCarts_SelQuantity(obj, quantity) {

    var flag = $(obj).parent().parent().parent().find(".sel .checkbox").prop("flag");

    if (flag == 0) {
        selShopQuantiy -= quantity;
    }
    else if (flag == 1) {
        selShopQuantiy += quantity;
    }
    //总共 N 件商品选中
    $(".sel_Count").text(selShopQuantiy);

    //返回商品件数
    return selShopQuantiy;
}
//全选获取商品总数量
function ShopCarts_AllQuantity(obj, quantity) {
    var flag = $(obj).parent().parent().parent().find(".selAll .checkbox").prop("flag");
    if (flag == 0) {
        //商品数量清空
        selShopQuantiy = 0;
    }
    else if (flag == 1) {
        $(".sel .checkbox").each(function (_index, _obj) {
            //计算勾选中复选框中所有商品数量
            selShopQuantiy += parseInt($(this).parent().parent().parent().find(".quantity").val());
        });
    }
    //总共 N 件商品选中
    $(".sel_Count").text(selShopQuantiy);
}
//商品小合计
function ShopCarts_MinAmount(obj) {
    //获取对象
    var _obj = $(obj).parent().parent().parent();
    //商品价格
    var price = parseInt(_obj.find(".danjia .price").text());
    //商品数量
    var quantity = parseInt(_obj.find(".quantity").val());
    //计算商品价格
    var min_Amount = parseInt((price * quantity));
    //商品小合计
    _obj.find(".xiaoji .min_Amount").text(min_Amount);

    //复选框打上勾才可以计算
    if (_obj.find(".sel .checkbox").prop("flag") == 1) {

        //计算商品总价格
        shopAmount += min_Amount;

        //商品总合计
        $(".Amount").text(shopAmount);
    }
}
//单选商品大合计
function ShopCarts_MaxAmount(obj) {
    //获取对象
    var _obj = $(obj).parent().parent().parent();
    //商品小合计
    var min_Amount = parseInt(_obj.find(".xiaoji .min_Amount").text());
    if (_obj.find(".sel .checkbox").prop("flag") == 0) {
        //计算商品价格
        shopAmount -= min_Amount;
    }
    else if (_obj.find(".sel .checkbox").prop("flag") == 1) {
        //计算商品价格
        shopAmount += min_Amount;
    }

    //商品总合计
    $(".Amount").text(shopAmount);

    //返回选中商品总价格
    return shopAmount;
}
//全选商品大合计
function ShopCarts_SelAll_MaxAmount(obj) {
    //获取对像
    if ($(obj).prop("flag") == 0) {
        //商品大合计清空
        shopAmount = 0;
    }
    else if ($(obj).prop("flag") == 1) {
        //商品大合计清空
        shopAmount = 0;

        //获取所有对象
        $(".xiaoji .min_Amount").each(function (_index, _obj) {
            var min_Amount = parseInt($(_obj).text());
            //计算商品价格
            shopAmount += min_Amount;
        });
    }
    //商品总合计
    $(".Amount").text(shopAmount);
}
//删除购物车商品
function ShopCart_Delete() {
    $(".caozuo .delete").click(function () {
        $.ajax({
            url: "../Handlers/lyr_ShopCarts_Delete.ashx",
            type: "post",
            data: {
                id: parseInt($(this).attr("pid")),//商品自增ID
                uname: (window.sessionStorage.getItem("uname").toString()),//用户ID
            }, //参数
            async: false, //同步数据
            cache: false,//是否缓存
            dataType: "text",//返回数据类型
            success: function (data) {
            }
        });
        //移除已经被删除的商品
        $(this).parent().parent().parent().remove();

        //判断复选框是否打上勾
        if (parseInt($(this).parent().parent().parent().find(".sel .checkbox").prop("flag")) == 1) {

            //减去移除掉商品的数量
            selShopQuantiy -= parseInt($(this).parent().parent().find(".quantity").val());

            //总共 N 件商品选中
            $(".sel_Count").text(selShopQuantiy);

            //获取商品总数量
            ShopCarts_Quantity();
        }
    });
}
//去结算
function GoBalanc() {
    $(".qujiesuan .jiesuan").click(function () {
       
        //改变去结算按钮颜色并且禁用该按钮
        $(this).prop("disabled", "disabled").css("background-color", "#e0e0e0").css("color", "black");

        //采用会话存储商品件数
        window.sessionStorage.setItem("shopQuantity", ShopCarts_SelQuantity());//$(".sel_Count").text()

        //采用会话存储商品总价格
        window.sessionStorage.setItem("shopAmount", ShopCarts_MaxAmount());//$(".Amount").text()

        //存储购物车的数据
        Save_SelShopCarts(this);
        
        //跳转到 立即下单 页面
        window.location.href = "../lyr_App/lyr_ConfirmOrders.html";
    });
}
//存储购物车的数据
function Save_SelShopCarts(obj) {
    //采用数组存储数据
    var arrCartItems = new Array();
    //数组下标
    var i = 0;
    //遍历购物车商品
    $(".sel .checkbox").each(function (_index, _obj) {
        //获取当前对象属性值
        var flag = $(this).prop("flag");
        //筛选打上勾的复选框
        if (flag == 1) {
            //获取包裹住它们的 div 容器对象
            var container = $(_obj).parent().parent().parent();

            //存储N个商品对象
            arrCartItems[i] = {
                "ShoppID": parseInt(container.attr("sid")), //商品ID
                "Price":parseFloat(container.find(".price").text()), //商品价格
                "Quantity": parseInt(container.find(".quantity").val()), //商品数量
            }
            //数组下标增加 1
            i++;
            //alert(arrCartItems[i].ShoppID+" "+arrCartItems[i].Price+" "+arrCartItems[i].Quantity);
        }  
    });
    //思路很简单：JSON对象提供的 stringify 将其他数据类型转化成字符串，再存储到storage中就可以了，拿出来使用的时候用：JSON.parse() 方法重新转成成对象 
    //采用会话存储购物车数据
    window.sessionStorage.setItem("arrCartItems", JSON.stringify(arrCartItems));
    //采用会话存储购物车数组实际长度
    window.sessionStorage.setItem("arrCartItems_length", arrCartItems.length);
}