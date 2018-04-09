<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css">

</head>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
    <div class="navbar-header">
        <a class="navbar-brand" href="#">组织机构管理系统</a>
    </div>
    <ul class="nav navbar-nav navbar-right"> 
        <li><a href="${pageContext.request.contextPath}/logout.do"><span class="glyphicon glyphicon-log-out"></span> 注销</a></li> 
        <li><a href="${pageContext.request.contextPath}/redirect.do?action=modify-password"><span class="glyphicon glyphicon-pencil"></span> 修改密码</a></li> 
    </ul> 
    </div>
</nav>

<body style="margin-TOP:50PX;width:1300PX">
<nav style="width:180PX;height:750PX;float:left" class="navbar navbar-default" role="navigation">
  <div class="container-fluid"> 
    <c:if test="${user==null}">
    <jsp:forward page="/login.jsp"></jsp:forward>
    </c:if>
    <c:if test="${user.getPower() >= 1}">
    <div style="height:30PX;" class="navbar-header">
        <a class="navbar-brand" >查看信息</a>
    </div>
    <ul class="nav navbar-nav "> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=user-task-information">查看任务信息</a></li> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=others-task-information">查看他人任务信息</a></li> 
    </ul> 
    </c:if>
    <c:if test="${user.getPower() >= 2}">
    <div style="height:30PX" class="navbar-header">
        <a class="navbar-brand" >管理任务</a>
    </div>
    <ul class="nav navbar-nav ">  
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=add-task">添加任务</a></li>
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=task-information">查看任务信息</a></li> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=execute-task-information">查看分配信息</a></li>
    </ul> 
    <div style="height:30PX" class="navbar-header">
        <a class="navbar-brand" >管理成员</a>
    </div>
    <ul class="nav navbar-nav "> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=add-member">添加成员</a></li> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=member-information">查看成员信息</a></li> 
    </ul> 
    </c:if>
    <c:if test="${user.getPower() >= 3}">
    <div style="height:30PX" class="navbar-header">
        <a class="navbar-brand" >管理管理员</a>
    </div>
    <ul class="nav navbar-nav "> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=add-administrator">添加管理员</a></li> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=administrator-information">查看管理员信息</a></li>
    </ul> 
    <div style="height:30PX" class="navbar-header">
        <a class="navbar-brand" >管理组织</a>
    </div>
    <ul class="nav navbar-nav "> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=add-organization">添加组织</a></li> 
        <li style="height:30PX"><a href="${pageContext.request.contextPath}/redirect.do?action=organization-information">查看组织信息</a></li>
    </ul> 
    </c:if>
  </div>
</nav>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
</body>
</html>