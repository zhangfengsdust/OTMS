<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css">

</head>
<jsp:include page="include.jsp"/>
<body style="margin-TOP:50PX">
<div style="float:left;margin:50PX 100PX;width:600PX">
  <form role="form">
   <div style="width:300PX" class="input-group"> 
    <input id="userName" type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
   </div>
   <br>
   <div id="name"></div>
   <div id="organization"></div>
   <br>
  <button type="button" style="width:180px;" class="btn btn-default">添加为管理员</button>
  </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
  $(function(){
	  $("#userName").change(function(){
		  var username = $("#userName").val();
		  username = $.trim(username);
		  var url = "${pageContext.request.contextPath}/member.do";
  		  var args = {"username":username,"action":"seek","time":new Date()};
  		  if(username == ""){
        	  $("#name").empty();
        	  $("#organization").empty();
        	  return;
          }
  		  $.getJSON(url,args,function(data){
  			  if(jQuery.isEmptyObject(data)){
  				  $("#name").empty();
          	      $("#organization").empty();
				  return ;
			  }
			  else{
				  var _url = "${pageContext.request.contextPath}/organization.do";
				  var _args = {"id":data.organizationId,"action":"seekOrganization","time":new Date()};
				  $.getJSON(_url,_args,function(_data){
					  if(jQuery.isEmptyObject(_data)){
						  return ;
					  }
					  $("#name").html("<h4>姓名：" + data.name + "</h4>");
    				  $("#organization").html("<h4>组织：" + _data.name + "</h4>");
				  })
			  }
  		  })
	  })
  
  
	  
    $(":button").click(function(){
		  var username = $("#userName").val();
		  username = $.trim(username);
		  if(username == ""){
			  alert("请输入用户名！");
			  return ;
		  }
		  var url = "${pageContext.request.contextPath}/member.do";
  		  var args = {"username":username,"action":"addAdministrator","time":new Date()};
  		  $.get(url,args,function(data){
  			  if(data==0){
				  alert("该成员不存在！");
				  return ;
			  }
  			  else if(data == 1){
  				alert("添加成功！");
  			  }
  			  else if(data >=2){
  				alert("此用户已经是管理员！");
  			  }
  		  })
	  })
	  
  })
</script>
</body>
</html>