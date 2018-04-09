<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.css" type="text/css">

</head>
<jsp:include page="include.jsp"/>
<body style="margin-TOP:50PX">
<div style="float:left;margin:50PX 100PX;width:600PX">
   <form role="form">
   <div style="width:300PX" class="input-group"> 
         密码：<input id="password" type="text" class="form-control" value="${member.password}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
      姓名：<input id="name" type="text" class="form-control" value="${member.name}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
    <div class="form-group" style="width:200PX">
    <label for="name">性别</label>
    <select class="form-control" id="sex">
      <option value="请选择">请选择</option>
      <option value="男">男</option>
      <option value="女">女</option>
    </select>
    </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <label for="name">出生日期</label>
     <input id="birthDate" value="${member.birthDate}" type="text" readonly class="form-control form_datetime"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     身份证：<input id="identityCard" type="text" class="form-control" value="${member.identityCard}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     手机号：<input id="mobile" type="text" class="form-control" value="${member.mobile}" aria-describedby="basic-addon1"><br>
   </div> 
   <br>
    <div style="width:300PX" class="form-group">
    </div>
  <button type="button" style="width:60px;" class="btn btn-default">修改</button>
  </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$("#birthDate").datetimepicker({format: 'yyyy-mm-dd',minView:'month'});
$(function(){
	if("${member.sex}"==""){
		$("#sex option[value='请选择']").attr("selected",true);
	}
	else if("${member.sex}"=="男"){
		$("#sex option[value='男']").attr("selected",true);
	}
	else if("${member.sex}"=="女"){
		$("#sex option[value='女']").attr("selected",true);
	}
	
	$(":button").click(function(){
		var password = $("#password").val();
		if(password == ""){
			alert("密码不能为空");
			return ;
		}
		var id = "${member.id}";
		var name = $("#name").val();
		var sex = $("#sex").val();
		var birthDate = $("#birthDate").val();
		var identityCard = $("#identityCard").val();
		var mobile = $("#mobile").val();
		var url = "${pageContext.request.contextPath}/member.do";
		var args = {"id":id,"password":password,"name":name,"sex":sex,"birthDate":birthDate,"identityCard":identityCard,"mobile":mobile,"time":new Date(),"action":"updateMember"};
		$.get(url,args,function(data){
			alert("修改成功");
		})	
	})
})
</script>
</body>
</html>