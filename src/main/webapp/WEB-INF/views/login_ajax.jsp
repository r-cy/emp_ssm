<%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/9/17
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <script src="../../static/layui/layui.js"></script>
</head>
<body>
<div class="layui-row">
    <div class="layui-col-lg4 layui-col-lg-offset4">
        <h3>欢迎访问员工管理系统</h3>
        <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
            <legend>用户登录</legend>

            <form id="form_login" class="layui-form">
                <div class="layui-form-item"><!--这是一个行区块，代表一个用户信息，代表一个用户信息-->
                    <label class="layui-form-label">用户名：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="uname" placeholder="请输入用户名" name="uname" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码：</label>
                    <div class="layui-input-inline">
                        <input type="password" id="pwd" name="pwd" lay-verify="pass" placeholder="请输入密码" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="button" id="sub_login" class="layui-btn" lay-submit="" lay-filter="demo1">登录</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </fieldset>

        <div style="color:red;">
            ${requestScope.msg}
        </div>
    </div>
</div>

<script>
    layui.use(['form'],function () {
        var form = layui.form;
        $ = layui.jquery;

        //提交按钮的点击事件
        $("#sub_login").click(function () {
            //以ajax方式提交请求
            $.ajax({
                url:"login_ajax",
                //01.以json形式传递数据
                data:{uname:$("#uname").val(),pwd:$("#pwd").val()},
                //02.如果表单项过多，可以使用表单序列化的方式进行传参
                data:$("#form_login").serialize(),
                type:"get",
                success:function (data) {
                    alert(data);
                },
                error:function () {
                    alert("服务器响应失败")
                }

            })
        })
    })
</script>
</body>
</html>
