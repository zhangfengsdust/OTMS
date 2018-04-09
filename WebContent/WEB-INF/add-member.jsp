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
<form role="form" id="form" action="${pageContext.request.contextPath}/member.do">
<input type="hidden"  name="action" value="addMember">
<input type="hidden"  id="memberflag" name="memberflag" value="0">
  <div style="width:300PX" class="input-group"> 
    <input id="userName" name="userName" type="text" class="form-control" placeholder="用户名(必填)" aria-describedby="basic-addon1">
   </div>
   <div id="info" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <input id="passWord" name="passWord" type="text" class="form-control" placeholder="密码(必填)" aria-describedby="basic-addon1"><br>
   </div>
   <div id="info4" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="input-group"> 
      <input id="name" name="name" type="text" class="form-control" placeholder="姓名" aria-describedby="basic-addon1"><br>
   </div>
   <br>
    <div class="form-group" style="width:200PX">
    <label for="name">性别</label>
    <select class="form-control" id="sex" name="sex">
      <option selected="selected" value="请选择">请选择</option>
      <option value="男">男</option>
      <option value="女">女</option>
    </select>
    </div>
   <br>
   <div style="width:300PX" class="input-group"> 
   <label for="name">出生日期</label>
     <input id="birthDate" name="birthDate" type="text" readonly class="form-control form_datetime"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <input id="identityCard" name="identityCard" type="text" class="form-control" placeholder="身份证" aria-describedby="basic-addon1"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <input id="mobile" name="mobile" type="text" class="form-control" placeholder="手机号" aria-describedby="basic-addon1"><br>
   </div> 
   <br>
    <div style="width:300PX" class="form-group">
    <label for="name">学院(必选)</label>
    <select class="form-control" id="academic" name="academic">
      <option selected="selected" value="请选择">请选择</option>
    </select>
    <div id="info2" style="width:300PX"></div>
    <label for="name">系(必选)</label>
    <select class="form-control" id="department" name="department">
    </select>
    <div id="info3" style="width:300PX"></div>
    </div>
  <button type="button" style="width:60px;" class="btn btn-default">添加</button>
  </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$("#birthDate").datetimepicker({format: 'yyyy-mm-dd',minView:'month'});
    $(function(){
    	var flag1 = 0;
    	var flag2 = 0;
    	var flag3 = 0;
    	var flag4 = 0;
		if("${sessionScope.user.power}" == 3){
			var url = "${pageContext.request.contextPath}/organization.do";
			var args = {"parentId":"0","time":new Date(),"action":"seekOrganizations"};
			$.getJSON(url,args,function(data){
				$.each(data,function(index,content){
					$("#academic").append("<option value='" + content.id + "'>" + content.name + "</option>");
				})
			})
			$("#academic").change(function(){
    		$("#department").empty();
    		var parentId = $("#academic").find("option:selected").val();
    		if(parentId == "请选择"){
    			flag2 = 0;
    			$("#info2").html("<font color='red'>*必须选择</font>");
    			return ;
    		}
    		flag2 = 1;
    		$("#info2").empty();
    		$("#department").append("<option selected='selected' value='请选择'>请选择</option>");
    		$("#department").append("<option value='无'>无</option>");
    		var url2 = "${pageContext.request.contextPath}/organization.do";
    		var args2 = {"parentId":parentId,"time":new Date(),"action":"seekOrganizations"};
    		$.getJSON(url2,args2,function(data2){
    			$.each(data2,function(index,content){
    				$("#department").append("<option value='" + content.id + "'>" + content.name + "</option>")
    			})
    		})
    	})
		}
		else if("${sessionScope.user.power}" == 2){
			var url = "${pageContext.request.contextPath}/organization.do";
			var args = {"id":"${sessionScope.user.organizationId}","time":new Date(),"action":"seekOrganization"};
			$.getJSON(url,args,function(data){
				if(data.parentId == 0){
					$("#academic").append("<option value='" + data.id + "'>" + data.name + "</option>");
					$("#academic").change(function(){
			    		$("#department").empty();
			    		var parentId = $("#academic").find("option:selected").val();
			    		if(parentId == "请选择"){
			    			flag2 = 0;
			    			$("#info2").html("<font color='red'>*必须选择</font>");
			    			return ;
			    		}
			    		flag2 = 1;
			    		$("#info2").empty();
			    		$("#department").append("<option selected='selected' value='请选择'>请选择</option>");
			    		$("#department").append("<option value='无'>无</option>");
			    		var url2 = "${pageContext.request.contextPath}/organization.do";
			    		var args2 = {"parentId":parentId,"time":new Date(),"action":"seekOrganizations"};
			    		$.getJSON(url2,args2,function(data2){
			    			$.each(data2,function(index,content){
			    				$("#department").append("<option value='" + content.id + "'>" + content.name + "</option>")
			    			})
			    		})
			    	})
				}
				else{
					var url2 = "${pageContext.request.contextPath}/organization.do";
					var args2 = {"id":data.parentId,"time":new Date(),"action":"seekOrganization"};
					$.getJSON(url2,args2,function(data2){
						$("#academic").append("<option value='" + data2.id + "'>" + data2.name + "</option>");
						$("#academic").change(function(){
							$("#department").empty();
				    		var parentId = $("#academic").find("option:selected").val();
				    		if(parentId == "请选择"){
				    			flag2 = 0;
				    			$("#info2").html("<font color='red'>*必须选择</font>");
				    			return ;
				    		}
				    		flag2 = 1;
				    		$("#info2").empty();
				    		$("#department").append("<option selected='selected' value='请选择'>请选择</option>");
				    		$("#department").append("<option value='" + data.id + "'>" + data.name + "</option>");
						})
						
						
					})
				}
			})
		}
    	$("#userName").change(function(){
    		var username = $("#userName").val();
    		username = $.trim(username);
    		if(username == ""){
    			flag1 = 0;
    			$("#info").html("<font color='red'>用户名不能为空</font>");
    			return ;
    		}
    		var url = "${pageContext.request.contextPath}/member.do";
    		var args = {"username":username,"time":new Date(),"action":"seek"};
    		$.getJSON(url,args,function(data){
    			if(jQuery.isEmptyObject(data)){
    				$("#info").html("<font color='green'>用户名可以使用</font>");
    				flag1 = 1;
  			    }
    			else{
    				$("#info").html("<font color='red'>该用户已存在</font>");
    				flag1 = 0;
    			}
    		})	
    	})
    	
    	$("#department").change(function(){
        	var id = $("#department").find("option:selected").val();
        	if(id == "请选择"){
        		flag3 = 0;
        		$("#info3").html("<font color='red'>*必须选择</font>");
        		return ;
        	}
        	flag3 = 1;
        	$("#info3").empty();
        })
        
        $("#passWord").change(function(){
        	var password = $("#passWord").val();
    		if(password == ""){
    			flag4 = 0;
    			$("#info4").html("<font color='red'>密码不能为空</font>");
    			return ;
    		}
    		flag4 = 1;
    		$("#info4").empty();
        })
        
		$(":button").click(function(){
    		if(flag1 == 0 || flag2 == 0 || flag3 == 0 || flag4 == 0){
    			alert("信息有误，请检查后再次提交！");
    			return false;
    		}
    		else {
    			alert("添加成功！");
    			$("#memberflag").val(parseInt(1000000*Math.random()));
    			$("#form").submit();
    			return true;
    		}
    	})
    })
</script>
</body>
</html>