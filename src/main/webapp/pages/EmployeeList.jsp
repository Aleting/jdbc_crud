<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="static/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/css/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="static/css/bootstrap/js/bootstrap.min.js"></script>
    <title>首页</title>
    <style type="text/css">
        .btn{
            margin-left: 5px;
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1><em><strong>JDBC-CRUD</strong></em></h1>
    <button type="button" class="btn btn-danger pull-right" data-toggle="modal" data-target="#delete2" id="delete"><span class="glyphicon glyphicon-trash"></span>删除</button>
    <button type="button" class="btn btn-warning pull-right" data-toggle="modal" data-target="#add_update" id="update"><span class="glyphicon glyphicon-pencil"></span>修改</button>
    <button type="button" class="btn pull-right btn-primary" data-toggle="modal" data-target="#add_update" id="add"><span class="glyphicon glyphicon-plus"></span>添加</button>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>编号</th>
            <th>雇员名称</th>
            <th>性别</th>
            <th>年龄</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td><c:out value="${user.id}" /></td>
                <td><c:out value="${user.name}" /></td>
                <td><c:out value="${user.sex}" /></td>
                <td><c:out value="${user.age}" /></td>
                <td width="200px;"><button type="button" class="btn update-btn btn-info" data-toggle="modal" data-target="#add_update" empid="${user.id}"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                <button type="button" class="btn btn-danger delete-btn" data-toggle="modal" empid="${user.id}"><span class="glyphicon glyphicon-trash"></span>删除</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 修改或增加 -->
<div class="modal fade" id="add_update" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="##" onsubmit="false" id="addUpdate">
                    <div class="form-group">
                        <label for="id">id</label>
                        <input type="text" class="form-control" name ="id" id="id" placeholder="请输入需要修改的id" >
                    </div>
                    <div class="form-group">
                        <label for="name">name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="请输入名字">
                    </div>
                    <div class="form-group">
                        <label for="sex">sex</label>
                        <input type="text" class="form-control" name="sex" id="sex" placeholder="请输入性别">
                    </div>
                    <div class="form-group">
                        <label for="age">age</label>
                        <input type="text" class="form-control" name="age" id="age" placeholder="请输入年龄">
                    </div>
                    <button type="submit" class="btn btn-default btn-info" id="submit">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 删除 -->
<div class="modal fade" id="delete2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">Modal title</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="id">id</label>
                    <input type="text" class="form-control" id="delete_id" placeholder="请输入需要修改的id" >
                </div>
                <button type="submit" class="btn btn-default btn-info" id="delete_submit">提交</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    //添加时不能输入id
    $("#add").click(function () {
        $("#id").removeAttr("value");
        $("#id").attr("disabled","");
    });
    //更新时可以输入id
    $("#update").click(function () {
        $("#id").removeAttr("value");
        $("#id").removeAttr("disabled");
    });
    //删除提交
    $("#delete_submit").click(function(){
        var delete_id = $("#delete_id").val();
        $.ajax({
            url:"<%=basePath%>emp?type=delete&delete_id="+delete_id,
            success:function(result){
                window.location.reload();
            }});
    });
    //删除按钮
    $(".delete-btn").click(function () {
        var delete_id = $(this).attr("empid");
        $.ajax({
            url:"<%=basePath%>emp?type=delete&delete_id="+delete_id,
            success:function(result){
                window.location.reload();
            }});
    });
    //修改按钮绑定值
    $(".update-btn").click(function () {
        var update_id = $(this).attr("empid");
        $("#id").attr("value",update_id);
        $("#id").attr("readonly","");
    });
    //添加和修改数据
    $("#submit").click(function () {
        var url;
        if ($("#id").val()==null||$("#id").val()==""){
            url = "<%=basePath%>emp?type=add";
        }else {
            url = "<%=basePath%>emp?type=update"
        }
        $.ajax({
            type: "POST",//方法类型
            url:url,
            data: $('#addUpdate').serialize(),
            success:function(result){
                window.location.reload();
            }});
    })
</script>
</html>