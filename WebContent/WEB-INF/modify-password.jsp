<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css">

<style>  
body{  
margin-left:auto;  
margin-right:auto; 
margin-TOP:100PX; 
width:22em;  
}
</style>

</head>
<body>
    
<div class="panel panel-default">
  <div style="text-align:center;margin:0 auto" class="panel-heading">
    修改密码
  </div>
  <div class="panel-body">
    <div class="input-group">
      <span class="input-group-addon"></span>
      <input id="passWord1" type="password" class="form-control" placeholder="旧密码" aria-describedby="basic-addon1">
    </div>
    <br>
    <div class="input-group">
      <span class="input-group-addon"></span>
      <input id="passWord2" type="password" class="form-control" placeholder="新密码" aria-describedby="basic-addon1">
    </div>
    <br>
    <div class="input-group">
      <span class="input-group-addon"></span>
      <input id="passWord3" type="password" class="form-control" placeholder="再次输入新密码" aria-describedby="basic-addon1">
    </div>
    <br>
    <button type="button" style="width:280px;" class="btn btn-default">确定修改</button>
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
  $(function(){
	  if("${sessionScope.user}" == ""){
		  alert("登录超时，请重新登陆。");
		  window.location.href = "login.jsp";
		  return ;
	  }
	  $(":button").click(function(){ 
		  var password1 = $("#passWord1").val();
		  if("${sessionScope.user}" == ""){
			  alert("登录超时，请重新登陆。");
			  window.location.href = "login.jsp";
			  return ;
		  }
		  else if("${sessionScope.user.password}" != password1){
			  alert("旧密码错误！");
			  return ;
		  }

          var password2 = $("#passWord2").val();
		  if(password2 == ""){
			  alert("新密码不能为空！");
			  return ;
		  }
          
		  var password3 = $("#passWord3").val();
		  if(password2 != password3){
			  alert("两次密码不一致！");
			  return ;
		  }
          var url = "${pageContext.request.contextPath}/member.do";
		  var args = {"id":"${sessionScope.user.id}","password":password2,"time":new Date(),"action":"modifyPassword"};
		  $.get(url,args,function(data){
			  if(data == "true"){
				  alert("修改成功！");
				  setTimeout("location.href='${pageContext.request.contextPath}/redirect.do?action=index'", 500);
			  }
			  else{
				  alert("登录超时！");
				  window.location.href = "login.jsp";
			  }
		  })
	  })
  })
</script>
</body>
</html>