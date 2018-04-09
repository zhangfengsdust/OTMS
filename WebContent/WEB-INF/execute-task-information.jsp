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
<div style="float:left;margin:50PX 100PX;width:900PX">
<div style="width:900PX;height:24PX;margin-left:0PX">
  <div style="width:120PX;float:left;margin-left:0PX" class="form-group">
    <label for="name">任务类别</label>
    <select class="form-control" id="type" name="type">
      <option selected="selected" value="全部">全部</option>
      <option value="监考">监考</option>
      <option value="开会">开会</option>
      <option value="活动">活动</option>
      <option value="审核">审核</option>
      <option value="其他">其他</option>
    </select>
  </div>
  <div style="width:120PX;float:left;margin-left:30PX" class="form-group">
    <label for="name">年份</label>
    <select class="form-control" id="year" name="year">
      <option selected="selected" value="全部">全部</option>
      <option value="2015">2015年</option>
      <option value="2016">2016年</option>
      <option value="2017">2017年</option>
    </select>
  </div>
  <div id="add" style="width:120PX;float:left;margin-left:30PX" class="form-group">
  </div>
 </div>

  <div style="width:180PX;float:right" class="input-group"> 
    <input id="taskId" type="text" class="form-control" placeholder="任务ID" aria-describedby="basic-addon1">
    <span class="input-group-btn"><button id="btn2" type="button" style="width:60px;" class="btn btn-default">搜索</button></span>
  </div>
  <div style="width:180PX;float:right;margin-right:30PX" class="input-group"> 
    <input id="memberId" type="text" class="form-control" placeholder="用户ID" aria-describedby="basic-addon1">
    <span class="input-group-btn"><button id="btn1" type="button" style="width:60px;" class="btn btn-default">搜索</button></span>
  </div>

<br>
<div id="info" style="width:200PX"></div>
<br>
<div>
<table class="table table-hover">
  <thead id="thead">
  </thead>
  <tbody id="tbody">
  </tbody>
</table>
</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(function(){
	change();
	$("#year").change(function(){
		if($("#year").val() == "全部"){
			$("#add").empty();
		}
		else{
			$("#add").html("<label for='name'>半年</label>"
			 + "<select class='form-control' id='half' name='half'>"
		      + "<option selected='selected' value='全年'>全年</option>"
		      + "<option value='上半年'>上半年</option>"
		      + "<option value='下半年'>下半年</option>"
		     + "</select>");
			$("#half").change(function(){
				change();
			})
		}
		change();
	})
	$("#type").change(function(){
		change();
	})
	
	function show(data){
		var url2 = "${pageContext.request.contextPath}/member.do";
		var args2 = {"id":data.memberId,"time":new Date(),"action":"seekById"};
		$.getJSON(url2,args2,function(data2){
			var url3 = "${pageContext.request.contextPath}/task.do";
			var args3 = {"id":data.taskId,"time":new Date(),"action":"seekById"};
			$.getJSON(url3,args3,function(data3){
				var tr;
				tr = "<tr><td>" + data.memberId + "</td><td>" + data2.name + "</td><td>" + data.taskId + "</td>"
				     + "<td>" + data3.name + "</td><td>" + data.comments + "</td>"
				     + "<td><a href='#' id='" + data.id + "' class='assess'>完成</a></td></tr>";	     
				$("#tbody").append(tr);
				$("tbody tr:last td:eq(5)").find("a").bind("click",function(){
					if($(this).parent().parent().find("td:eq(4)").text() == "完成"){
						alert("此任务已经评价");
						return ;
					}
					var _url = "${pageContext.request.contextPath}/execute.do";
					var _args = {"id":$(this).attr("id"),"time":new Date(),"action":"assess"};
					$.get(_url,_args,function(_data){
						alert("评价成功");
					})
					$(this).parent().parent().find("td:eq(4)").text("完成");
				})
			})
		})
	}
	
	$("#btn1").click(function(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var memberId = $("#memberId").val();
		if(memberId == ""){
			alert("请输入用户ID！");
			return ;
		}
		var url = "${pageContext.request.contextPath}/execute.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","memberId":memberId,"time":new Date(),"action":"seekByMemberByOrg"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有任务执行信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>用户ID</th><th>用户姓名</th><th>任务ID</th><th>任务名</th><th>执行情况</th><th>评价</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})
		})
	})
	$("#btn2").click(function(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var taskId = $("#taskId").val();
		if(taskId == ""){
			alert("请输入任务ID！");
			return ;
		}
		var url = "${pageContext.request.contextPath}/execute.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","taskId":taskId,"time":new Date(),"action":"seekByTaskByOrg"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有任务执行信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>用户ID</th><th>用户姓名</th><th>任务ID</th><th>任务名</th><th>执行情况</th><th>评价</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})
			
		})
	})

	function change(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var type = $("#type").val();
		var year = $("#year").val();
		var half;
		if(year == "全部"){
			half = "全年";
		}
		else{
			half = $("#half").val();
		}
		var url = "${pageContext.request.contextPath}/execute.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","type":type,"year":year,"half":half,"time":new Date(),"action":"seekBy"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有任务执行信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>用户ID</th><th>用户姓名</th><th>任务ID</th><th>任务名</th><th>执行情况</th><th>评价</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})		
		})
	}
})
</script>
</body>
</html>