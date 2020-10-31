<%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/10/22
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>头像上传</title>
    <script src="../../static/layui/layui.js"></script>
</head>
<body>
<%--用于显示图片--%>
<div id="show_img"></div>
<%--用于存储图片的路径--%>
<input type="hidden" id="imgPath">

<form id="form_img" enctype="multipart/form-data">
    <input id="photo" type="file" name="photo" style="display: none">
    <button type="button" onclick="javascript:$('#photo').click()">上传</button>
    <button type="button" id="btn_del">删除</button>
</form>

<script>
    layui.use(['layer'],function () {
        var layer = layui.layer;
        $ = layui.jquery;

        //如果选择了图片，input发生了变化，那么直接提交图片信息
        $("#photo").change(function () {
            if ($(this).val() == ""){
                layer.msg("请选择要上传的图片");
                return;
            }
            //获取表单中要上传的数据
            var formData = new FormData($("#form_img")[0]);
            $.ajax({
                url:"imgUpload",
                data:formData,
                type:"post",
                cache:false,
                contentType:false,  //告诉服务器数据的编码方式
                processData:false,  //避免jQuery对formData进行额外的处理
                dataType:"text",    //后台响应为字符串，后台响应字符串设置为text。或者不设置。如果响应的是json数据，name必须设置该属性为json
                success:function (data) {
                    //data是后台图片存储的路径
                    //在div中显示图片
                    var imgObj = $("<img src='${pageContext.request.contextPath}/images/" + data + "'width='100px'>");
                    $("#show_img").append(imgObj);
                    //$("#show_img").html(imgObj);

                    //存储文件名称
                    $("#imgPath").val(data);
                },
                error:function () {
                    layer.msg("图片上传失败");
                }
            })
        });

        //删除图片操作
        $("#btn_del").click(function () {
            //移除img标签
            //向后台发送请求，移除图片资源
            $.ajax({
                url:"delImg",
                data:{imgName:$("#imgPath").val()},
                type:"get",
                success:function (data) {
                    layer.msg("删除成功");
                    $("img").remove();
                    //删除成功过后，清除input的图片信息
                    $("#photo").val("");
                },
                error:function () {
                    layer.msg("删除失败");
                }
            })
        })

    })
</script>
</body>
</html>
