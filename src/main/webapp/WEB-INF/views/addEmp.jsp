<%--
  Created by IntelliJ IDEA.
  User: My
  Date: 2020/9/17
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增员工信息</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <script src="../../static/layui/layui.js"></script>
</head>
<body>
<div class="layui-col-lg4 layui-col-lg-offset4">
    <h3>欢迎您：${uname}
    </h3>
</div>
<div class="layui-row">
    <div class="layui-col-lg4 layui-col-lg-offset4">
        <h3>新增员工信息</h3>
        <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
            <legend>员工信息</legend>

            <form id="emp_form" method="post" class="layui-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">员工姓名：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ename" lay-verify="title" autocomplete="off" placeholder="请输入员工姓名"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">员工职位：</label>
                    <div class="layui-input-inline">
                        <select name="job" id="job">
                            <option value="">请选择职位</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">员工月薪：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="sal" autocomplete="off" placeholder="请输入员工月薪"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">所属部门：</label>
                    <div class="layui-input-inline">
                        <select name="deptno" id="dept">
                            <option value="">请选择部门</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <%--将btn声明为普通按钮，我们自定义点击事件--%>
                        <button type="button" class="layui-btn" id="btn_ok">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        <button type="button" class="layui-btn layui-btn-primary" id="btn_cancle">取消</button>
                    </div>
                </div>
            </form>
        </fieldset>
        <div style="color: red">
            ${msg}
        </div>
    </div>
</div>

<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        var layer = layui.layer;
        $ = layui.jquery;

        $.ajax({
            url: "getAllDept",
            type: "get",
            async: true,
            dataType: "json",     //后台给我们的是部门对象集合，在后台会以jsonArray的方式进行传输
            success: function (list) {          //list代表后台传递的json数组
                //遍历list集合，根据集合中的信息给select下拉框添加option选项
                var $obj = $("#dept");
                //遍历集合
                $.each(list,function (index,depts) {    //index 代表下标，depts代表每一个部门对象
                    var $option = $("<option value='" + depts.deptno + "'>" + depts.dname + "</option>");
                    $obj.append($option);
                });
                //对表单进行渲染
                form.render();
            },
            error: function () {
                layer.msg("服务器响应失败！！！")
            }
        });
        $.ajax({
            url: "getAllJob",
            type: "get",
            async: true,
            dataType: "json",
            success: function (list) {
                //遍历list集合，根据集合中的信息给select下拉框添加option选项
                var $obj = $("#job");
                //遍历集合
                $.each(list,function (index,jobs) {    //index 代表下标，depts代表每一个部门对象
                    var $option = $("<option value='" + jobs.job + "'>" + jobs.job + "</option>");
                    $obj.append($option);
                });
                //对表单进行渲染
                form.render();
            },
            error: function () {
                layer.msg("服务器响应失败！！！")
            }
        });

        $("#btn_ok").click(function () {
            //以ajax的方式进行提交
            $.ajax({
                url: "addEmp",
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
            //关闭当前的弹出框
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引，parent代表父页面（列表页面）
            parent.layui.layer.close(index); //再执行关闭
            //刷新表格数据
            parent.layui.table.reload("empList");
        })

    })
</script>

</body>
</html>
