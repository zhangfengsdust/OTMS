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
  <form role="form" id="form" action="${pageContext.request.contextPath}/task.do">
  <input type="hidden"  name="action" value="addTask">
  <input type="hidden"  id="taskflag" name="taskflag" value="0">
  <div style="width:300PX" class="input-group"> 
    <input id="name" name="name" type="text" class="form-control" placeholder="名称" aria-describedby="basic-addon1">
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <input id="peopleNumber" name="peopleNumber" type="text" class="form-control" placeholder="所需人数(必填)" aria-describedby="basic-addon1"><br>
   </div>
   <div id="info" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="input-group"> 
   <label for="name">开始时间(必选)</label>
      <input id="startTime" name="startTime" type="text" readonly class="form-control form_datetime"><br>
   </div>
   <div id="info2" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="input-group"> 
   <label for="name">结束时间(必选)</label>
     <input id="endTime" name="endTime" type="text" readonly class="form-control form_datetime"><br>
   </div>
   <div id="info3" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="form-group">
    <label for="name">类别</label>
    <select class="form-control" id="type" name="type">
      <option selected="selected" value="监考">监考</option>
      <option value="开会">开会</option>
      <option value="活动">活动</option>
      <option value="审核">审核</option>
      <option value="其他">其他</option>
    </select>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <input id="weight" name="weight" type="text" class="form-control" placeholder="权值(必填)" aria-describedby="basic-addon1"><br>
   </div>
   <div id="info4" style="width:300PX"></div>
   <br>
   <div style="width:300PX" class="input-group"> 
     <textarea id="description" name="description" class="form-control" rows="4" placeholder="描述   不超过50字" aria-describedby="basic-addon1"></textarea><br>
   </div>  
   <br>
  <div style="width:300PX" class="form-group">
    <label for="name">学院(必选)</label>
    <select class="form-control" id="academic" name="academic">
      <option selected="selected" value="请选择">请选择</option>
    </select>
    <div id="info5" style="width:300PX"></div>
    <label for="name">系(必选)</label>
    <select class="form-control" id="department" name="department">
    </select>
    <div id="info6" style="width:300PX"></div>
    </div>
  <button type="button" style="width:60px;" class="btn btn-default">添加</button>
  </form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$("#startTime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
$("#endTime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
$(function(){
	var flag1 = 0;
	var flag2 = 0;
	var flag3 = 0;
	var flag4 = 0;
	var flag5 = 0;
	var flag6 = 0;
	
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
			flag5 = 0;
			$("#info5").html("<font color='red'>*必须选择</font>");
			return ;
		}
		flag5 = 1;
		$("#info5").empty();
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
		    			flag5 = 0;
		    			$("#info5").html("<font color='red'>*必须选择</font>");
		    			return ;
		    		}
		    		flag5 = 1;
		    		$("#info5").empty();
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
			    			flag5 = 0;
			    			$("#info5").html("<font color='red'>*必须选择</font>");
			    			return ;
			    		}
			    		flag5 = 1;
			    		$("#info5").empty();
			    		$("#department").append("<option selected='selected' value='请选择'>请选择</option>");
			    		$("#department").append("<option value='" + data.id + "'>" + data.name + "</option>");
					})
					
					
				})
			}
		})
	}
	
	
	$("#peopleNumber").change(function(){
    		var peopleNumber = $("#peopleNumber").val();
    		peopleNumber = $.trim(peopleNumber);
    		if(peopleNumber == ""){
    			flag1 = 0;
    			$("#info").html("<font color='red'>所需人数不能为空</font>");
    			return ;
    		}
    		flag1 = 1;
    		$("#info").empty();
    	})
    	
    	$("#startTime").change(function(){
    		var startTime = $("#startTime").val();
    		if(startTime == ""){
    			flag2 = 0;
    			$("#info2").html("<font color='red'>开始时间不能为空</font>");
    			return ;
    		}
    		flag2 = 1;
    		$("#info2").empty();
    	})
    	
    	$("#endTime").change(function(){
    		var endTime = $("#endTime").val();
    		if(endTime == ""){
    			flag3 = 0;
    			$("#info3").html("<font color='red'>结束时间不能为空</font>");
    			return ;
    		}
    		flag3 = 1;
    		$("#info3").empty();
    	})
    	
    	$("#weight").change(function(){
    		var weight = $("#weight").val();
    		weight = $.trim(weight);
    		if(weight == ""){
    			flag4 = 0;
    			$("#info4").html("<font color='red'>权值不能为空</font>");
    			return ;
    		}
    		flag4 = 1;
    		$("#info4").empty();
    	})
    	
    	
    	$("#department").change(function(){
        	var id = $("#department").find("option:selected").val();
        	if(id == "请选择"){
        		flag6 = 0;
        		$("#info6").html("<font color='red'>*必须选择</font>");
        		return ;
        	}
        	flag6 = 1;
        	$("#info6").empty();
        })
        $(":button").click(function(){
    		if(flag1 == 0 || flag2 == 0 || flag3 == 0 || flag4 == 0 || flag5 == 0 || flag6 == 0){
    			alert("信息有误，请检查后再次提交！");
    			return false;
    		}
    		else if($("#endTime").val() < $("#startTime").val()){
    			alert("结束时间应大于开始时间");
    			return false;
    		}
    		else {
    			alert("添加成功！");
    			$("#taskflag").val(parseInt(1000000*Math.random()));
    			$("#form").submit();
    			return true;
    		}
    	})
})

</script>
</body>
</html>