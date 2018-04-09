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
    任务名：<input id="name" type="text" class="form-control" value="${task.name}" aria-describedby="basic-addon1">
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     所需人数（必填）:<input id="peopleNumber" type="text" class="form-control" value="${task.peopleNumber}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
     开始时间 （必填）: <input id="startTime" type="text" class="form-control" value="${task.startTime}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
    结束时间 （必填）: <input id="endTime" type="text" class="form-control" value="${task.endTime}" aria-describedby="basic-addon1"><br>
   </div>
   <br>
    <div style="width:300PX" class="form-group">
    <label for="name">类别</label>
    <select class="form-control" id="type" name="type">
      <option value="监考">监考</option>
      <option value="开会">开会</option>
      <option value="活动">活动</option>
      <option value="审核">审核</option>
      <option value="其他">其他</option>
    </select>
   </div>
   <br>
   <div style="width:300PX" class="input-group"> 
    权值（必填）: <input id="weight" type="text" class="form-control" value="${task.weight}" aria-describedby="basic-addon1"><br>
   </div> 
   <br>
   <div style="width:300PX" class="input-group"> 
    描述（不超过50字）: <textarea id="description" class="form-control" rows="4"  aria-describedby="basic-addon1">${task.description}</textarea><br>
   </div>  
   <br>   
  <button type="button" style="width:60px;" class="btn btn-default">修改</button>
   </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$("#startTime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
$("#endTime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
$(function(){
	$("#type option[value='" + "${task.type}" + "']").attr("selected",true);
	$(":button").click(function(){
		var name = $("#name").val();
		var peopleNumber = $("#peopleNumber").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var type = $("#type").val();
		var weight = $("#weight").val();
		var description = $("#description").val();
		if(peopleNumber == ""){
			alert("人数不能为空");
			return ;
		}
		if(peopleNumber == "0"){
			alert("人数不正确");
			return ;
		}
		if(startTime == ""){
			alert("开始时间不能为空");
			return ;
		}
		if(endTime == ""){
			alert("结束时间不能为空");
			return ;
		}
		if(weight == ""){
			alert("权值不能为空");
			return ;
		}
		var id = "${task.id}";
		var url = "${pageContext.request.contextPath}/task.do";
		var args = {"id":id,"name":name,"peopleNumber":peopleNumber,"startTime":startTime,"endTime":endTime,"weight":weight,"type":type,"description":description,"time":new Date(),"action":"updateTask"};
		$.get(url,args,function(data){
			alert("修改成功");
		})	
	})
})
</script>
</body>
</html>