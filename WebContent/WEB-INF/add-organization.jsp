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
  <form role="form" id="form" action="${pageContext.request.contextPath}/organization.do">
  <input type="hidden"  name="action" value="addOrganization">
  <input type="hidden"  id="organizationflag" name="organizationflag" value="0">
   <div style="width:300PX" class="input-group"> 
    <input id="name" name="name" type="text" class="form-control" placeholder="组织名(必填)" aria-describedby="basic-addon1">
   </div>
   <div id="info" style="width:300PX"></div>
   <br>
    <div style="width:300PX" class="form-group">
    <label for="name">学院(必选)</label>
    <select class="form-control" id="academic" name="academic">
      <option selected="selected" value="请选择">请选择</option>
      <option value="无">无</option>
    </select>
    <div id="info2" style="width:300PX"></div>
    </div>
  <button type="button" style="width:60px;" class="btn btn-default">添加</button>
</form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(function(){
	var flag1=0;
	var flag2=0;
	var url = "${pageContext.request.contextPath}/organization.do";
	var args = {"parentId":"0","time":new Date(),"action":"seekOrganizations"};
	$.getJSON(url,args,function(data){
		$.each(data,function(index,content){
			$("#academic").append("<option value='" + content.id + "'>" + content.name + "</option>");
		})
	})
	
	$("#name").change(function(){
    		var name = $("#name").val();
    		name = $.trim(name);
    		if(name == ""){
    			flag1 = 0;
    			$("#info").html("<font color='red'>组织名不能为空</font>");
    			return ;
    		}
    		var url = "${pageContext.request.contextPath}/organization.do";
    		var args = {"name":name,"time":new Date(),"action":"seekOrganizationByName"};
    		$.getJSON(url,args,function(data){
    			if(jQuery.isEmptyObject(data)){
    				$("#info").html("<font color='green'>组织名可以使用</font>");
    				flag1 = 1;
  			    }
    			else{
    				$("#info").html("<font color='red'>该组织已存在</font>");
    				flag1 = 0;
    			}
    		})	
    	})
    	
    	$("#academic").change(function(){
    		var parentId = $("#academic").find("option:selected").val();
    		if(parentId == "请选择"){
    			flag2 = 0;
    			$("#info2").html("<font color='red'>*必须选择</font>");
    			return ;
    		}
    		flag2 = 1;
    		$("#info2").empty();
    	})
    	
        
        $(":button").click(function(){
    		if(flag1 == 0 || flag2 == 0){
    			alert("信息有误，请检查后再次提交！");
    			return false;
    		}
    		else {
    			alert("添加成功！");
    			$("#organizationflag").val(parseInt(1000000*Math.random()));
    			$("#form").submit();
    			return true;
    		}
    	})
})
</script>
</body>
</html>