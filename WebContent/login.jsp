<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
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
    组织机构任务管理系统
  </div>
  <div class="panel-body">
    <div class="input-group">
      <span style="magin:0px;padding:0px" class="input-group-addon"><img src="${pageContext.request.contextPath}/images/username.jpg" ></span>
      <input id="userName" type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
    </div>
    <br>
    <div class="input-group">
      <span style="magin:0px;padding:0px" class="input-group-addon"><img src="${pageContext.request.contextPath}/images/password.jpg" ></span>
      <input id="passWord" type="password" class="form-control" placeholder="密码" aria-describedby="basic-addon1">
    </div>
    <br>
    <button type="button" style="width:280px;" class="btn btn-default" >登 录</button>
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>

<script type="text/javascript">
    $(function(){  	
    	$(":button").click(function(){
    		var username = $("#userName").val();
    		username = $.trim(username);
    		if(username == ""){
    			alert("用户名不能为空！")
    			return ;
    		}
    		var password = $("#passWord").val();
    		if(password == ""){
    			alert("密码不能为空！")
    			return ;
    		}
    		var url = "${pageContext.request.contextPath}/login.do";
    		var args = {"username":username,"password":password,"time":new Date()};
    		$.get(url,args,function(data){
    			if(data == "true"){
    				window.location.href = "${pageContext.request.contextPath}/redirect.do?action=index";
    			}
    			else{
    				alert("用户不存在或密码错误！");
    			}
    		})
    	})
    })
</script>
</body>
</html>