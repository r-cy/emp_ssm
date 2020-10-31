<%@ page import="com.jxd.emp.model.Emp" %><%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/9/18
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工信息修改</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <script src="../../static/layui/layui.js"></script>
</head>
<body>
<div class="layui-row">
    <div class="layui-col-lg4 layui-col-lg-offset4">
        <%--<%
            String uname = (String)session.getAttribute("uname");
        %>
        <h3>欢迎您：<%=uname%></h3>--%>
        <h3>欢迎您：${uname}</h3>
    </div>
</div>

<%--<%
    //在request对象中得到员工对象
    Emp emp = (Emp) request.getAttribute("emp");
%>--%>


<div class="layui-row">
    <div class="layui-col-lg4 layui-col-lg-offset4">
        <h3>编辑员工信息</h3>
        <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
            <legend>员工信息编辑</legend>

            <form id="emp_form" method="post" class="layui-form">
                <div class="layui-form-item"><!--这是一个行区块，代表一个用户信息，代表一个用户信息-->
                    <label class="layui-form-label">员工编号：</label>
                    <div class="layui-input-inline">
                      <%--  <input type="text" name="empno" value="<%=emp.getEmpno()%>" class="layui-input" readonly>--%>
                        <input type="text" name="empno" value="${emp.empno}" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-form-item"><!--这是一个行区块，代表一个用户信息，代表一个用户信息-->
                    <label class="layui-form-label">员工姓名：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ename" value="${emp.ename}" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item"><!--这是一个行区块，代表一个用户信息，代表一个用户信息-->
                    <label class="layui-form-label">员工工作：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="job" value="${emp.job}" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item"><!--这是一个行区块，代表一个用户信息，代表一个用户信息-->
                    <label class="layui-form-label">员工工资：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="sal" value="${emp.sal}" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn" id="btn_ok">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        <button type="button" class="layui-btn layui-btn-primary" id="btn_cancle">取消</button>
                    </div>
                </div>
            </form>
        </fieldset>
        <div style="color:red;">
            ${msg}
        </div>
    </div>
</div>
<script>
    layui.use(['form','layer'], function () {
        var form = layui.form;
        var layer = layui.layer;

        $ = layui.jquery;

        $("#btn_ok").click(function () {
            //以ajax的方式进行提交
            $.ajax({
                url: "editEmp",
                data: $("#emp_form").serialize(),//获取所有的表单数据
                type: "post",
                async: true,
                dataType: "text",
                success: function (e) {
                    //关闭当前的弹出框
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引，parent代表父页面（列表页面）
                    parent.layui.layer.close(index); //再执行关闭
                    //刷新表格数据
                    parent.layui.table.reload("empList");
                    //弹出一个提示信息
                    parent.layui.layer.msg(e);
                },
                error: function (e) {
                    layer.msg("服务器响应失败");
                }
            })

        });

        $("#btn_cancle").click(function () {
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引，parent代表父页面（列表页面）
            parent.layui.layer.close(index); //再执行关闭
            parent.layui.table.reload("empList");
        })
    })
</script>
</body>
</html>
