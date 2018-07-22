/// <reference path="../Scripts/jquery-3.2.1.js" />
$(function () {
    loadInit();//初始化   
})
//初始化
function loadInit() {
    //设置用户名
    $("#login").text(window.sessionStorage.getItem("uname"));
    $(".orderDetail").click(open);

}
var count = 0;
function open() {
    
    $(this).parent().parent().parent().find(".p_c_left").find(".ul_list .wuyu").animate({ height: "toggle" });
    $(this).parent().parent().parent().find(".p_c_left").find(".ul_list .wuyule").css("display", "none");
    if (count==1) {
        open2(this);
        count = 0;
        return;
    }
    count++;
}
function open2(wuyu) {
    $(wuyu).parent().parent().parent().find(".p_c_left").find(".ul_list .wuyule").css("display", "block");
}