<%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/10/21
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>批量添加员工</title>
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
    <script src="../../static/layui/layui.js"></script>
</head>
<body>

<script>
    layui.use(['layer'],function () {
        var layer = layui.layer;
        $ = layui.jquery;

        $.ajax({
            url:"addBatch",
            data:'[{"ename":"张阿三","job":"clerk"},{"ename":"李阿四","job":"manager"}]',
            type:"post",
            contentType:"application/json;charset=utf-8",//指明参数类型
            success:function (data) {
                layer.msg(data);
            },
            error:function () {
                layer.msg("服务器响应失败");
            }
        })
    })
</script>
</body>
</html>
