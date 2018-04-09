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
        组织名： <input id="name" type="text" class="form-control" value="${organization.name}" aria-describedby="basic-addon1">
   </div>
   <br>
   <br>
  <button type="button" style="width:60px;" class="btn btn-default">修改</button>
  </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(function(){
	function update(name){
		var url = "${pageContext.request.contextPath}/organization.do";
		var args = {"name":name,"id":"${organization.id}","parentId":"${organization.parentId}","time":new Date(),"action":"updateOrganization"};
		$.get(url,args,function(data){
			
		})
	}
	$(":button").click(function(){
		var name = $("#name").val();
		name = $.trim(name);
		if(name == ""){
			alert("组织名不能为空");
			return ;
		}
		var url = "${pageContext.request.contextPath}/organization.do";
		var args = {"name":name,"time":new Date(),"action":"seekOrganizationByName"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				alert("修改成功");
				update(name)
			}
			else if(data.name == "${organization.name}"){
				alert("修改成功");
				update(name);
			}
			else{
				alert("该组织已存在");
			}
		})	
	})
})
</script>
</body>
</html>