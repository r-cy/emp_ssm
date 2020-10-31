<%--
  Created by IntelliJ IDEA.
  User: cat
  Date: 2020/10/22
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传</title>
</head>
<body>
    <%--multipart/form-data 告诉服务器不要对其编码操作（key-value形式）--%>
<form action="upload" method="post" enctype="multipart/form-data">
    <input type="file" name="txtfile">
    <input type="submit" value="上传">
</form>
</body>
</html>
