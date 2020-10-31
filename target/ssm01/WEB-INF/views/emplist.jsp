<%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/9/17
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工信息表</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <script src="../../static/layui/layui.js"></script>
</head>
<body>
<div class="layui-row">
    <div class="layui-col-lg6 layui-col-lg-offset3">
        <h3>欢迎您：${uname}</h3>
    </div>
</div>
<div class="layui-row">
    <div class="layui-col-lg6 layui-col-lg-offset3">
        <div class="layui-row layui-form-item clearfix">
            <div class="layui-input-inline layui-col-lg4">
                <input type="text" class="layui-input" name="filter"
                       id="filter" placeholder="请输入员工姓名">
            </div>
            <div class="layui-input-inline layui-col-lg2">
                <input type="button" value="查询" class="layui-btn" id="btn_query">
            </div>
            <div class="layui-input-inline layui-col-lg6">
                <div class="layui-col-lg4">
                    <input type="button" value="新增" class="layui-btn" id="btn_add">
                </div>
                <div class="layui-col-lg4">
                    <input type="button" value="删除" class="layui-btn" id="btn_del">
                </div>
                <div class="layui-col-lg4">
                    <input type="button" value="编辑" class="layui-btn" id="btn_edit">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-col-lg6 layui-col-lg-offset3">
        <table id="tab"></table>
    </div>
</div>

<%--<div style="display: none" id="div_msg">
    &lt;%&ndash;<%
        String msg = (String)request.getAttribute("msg");
    %>
    <%=msg%>&ndash;%&gt;
    ${msg}
</div>--%>
<%--在隐藏域中设置后台响应回的提示信息，比如新增成功、删除失败--%>
<input type="hidden" value="${msg}" id="msg">

<%--这是新增页面的div--%>
<div id="addEmp" style="display: none">
    <form  id="emp_form" method="post" class="layui-form">
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
                <select name="job">
                    <option value="">请输入员工职位</option>
                    <option value="cleaner">cleaner</option>
                    <option value="server">server</option>
                    <option value="waiter">waiter</option>
                    <option value="player">player</option>
                    <option value="assistant">assistant</option>
                    <option value="chief">chief</option>
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
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="btn_ok">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                <button type="button" class="layui-btn layui-btn-primary" id="btn_cancle">取消</button>
            </div>
        </div>
    </form>
</div>
<script>
    layui.use(['table', 'layer'], function () {
        var table = layui.table;
        var layer = layui.layer;

        $ = layui.jquery;
        table.render({
            id: "empList",
            elem: "#tab",
            height: 500,
            url: "getAllEmp",
            where:{"ename":""},   //后台参数用注解方式，需要加，默认传ename=null
                                        //否则会包参数封装错误
            cols: [[
                {type: "checkbox"},
                //{filed:"index_num",title:"序号",width:50},
                /*field对应的是实体类的属性名*/
                {field: "empno", title: "员工编号", width: 90, align: "center"},
                {field: "ename", title: "员工姓名", width: 90},
                {field: "job", title: "员工工作", width: 120},
                {field: "sal", title: "员工工资", width: 100, align: "right"}
            ]],
            page: true,                      //开启分页
            limits: [5, 10, 15, 20],      //设置用户可选的每页显示条数
            limit: 5                            //默认每页显示的条数
        });

        //给查询按钮添加响应事件
        $("#btn_query").click(function () {
            //获取用户输入的内容
            var filter = $("[name = filter]").val();
            //重载表格
            table.reload("empList", {
                where: {ename: filter}            //ename就是传递到后台的参数名称，就相当于input的name属性
            })
        });

        //新增事件
        $("#btn_add").click(function () {
            //直接跳转到新增界面
            //window.location.href = "addEmp.jsp";

            //使用弹框实现新增功能
            //第一种
            layer.open({
                type:2,        //弹出一个独立的页面时，需要指定类型为2，相当于将页面显示在iframe框中
                title:"新增员工",
                area:[500,500],
                content:"getAddEmp"        //页面路径:Spring中的跳转
            });

        });

        //然后再进行信息的修改操作，修改完成后，保存提交，将数据保存到数据库
        $("#btn_edit").click(function () {
            //首先获取选中项
            var checks = table.checkStatus("empList");          //empList是table对象的id
            if (checks.data.length == 0) {
                layer.msg("请选择要编辑的记录");
                return;
            }
            if (checks.data.length > 1) {
                layer.msg("请选择一条进行编辑");
                return;
            }
            //获取被选中的员工编号
            var empno = checks.data[0].empno;
            /*window.location.href = "getEmpById?empno=" + empno;*/

            //弹框形式打开编辑页面
            layer.open({
                type:2,
                title:"员工信息修改",
                area:[500,500],
                content:"getEmpById?empno=" + empno
            })
        });

        //点击删除按钮后，判断用户是否选择了要删除的记录
        //获取所有要删除记录的编号，一块提交到后台
        //数据库执行delete操作，执行完成后，再次回到表页面，提示信息
        $("#btn_del").click(function () {
                var checks = table.checkStatus("empList");
                if (checks.data.length == 0){
                    layer.msg("请选择要删除的记录")
                    return;
                }

                //请求路径形式 http://localhost:8080/deleteEmp?empno=1&empno=2

                //弹出确认框
            layer.msg("确定要删除所选记录吗？",{
                time:0, //不会自动关闭
                btn:['确定','取消'],
                yes:function () {
                    //点击确定后的操作
                    var empnos = "";
                    var url = "deleteEmp?";
                    for (var i = 0; i < checks.data.length; i++) {
                       /* empnos += checks.data[i].empno;
                        if (i != checks.data.length) {
                            empnos += ",";
                        }*/
                       url +="empno=" + checks.data[i].empno
                        if (i != checks.data.length) {
                            url += "&";
                        }
                    }
                    //访问后台servlet并将数据传递过去
                    /*window.location.href="delEmp?empnos=" + empnos;*/
                    $.ajax({
                        url:url,
                        type:"get",
                        async:true,
                        success:function (e) {
                            //刷新列表页面，同时给出提示信息
                            layui.table.reload("empList")
                            layer.msg("删除成功！")
                        },
                        error:function () {
                            layer.msg("服务器响应失败")
                        }
                    })
                }
            });
        });
       if ($("#msg").val() != "" && $("#msg").val()  != null &&  $("#msg").val() != "null"){
           layer.msg($("#msg").val());
       }
    })
</script>
</body>
</html>
