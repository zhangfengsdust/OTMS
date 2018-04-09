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
  <div style="width:120PX;float:left;margin-left:80PX" class="form-group">
    <label for="name">年份</label>
    <select class="form-control" id="year" name="year">
      <option selected="selected" value="全部">全部</option>
      <option value="2015">2015年</option>
      <option value="2016">2016年</option>
      <option value="2017">2017年</option>
    </select>
  </div>
  <div id="add" style="width:120PX;float:left;margin-left:80PX" class="form-group">
  </div>
 </div>
  <div style="width:200PX;float:right" class="input-group"> 
    <input id="id" type="text" class="form-control" placeholder="任务ID" aria-describedby="basic-addon1">
    <span class="input-group-btn"><button id="btn" type="button" style="width:60px;" class="btn btn-default">搜索</button></span>
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
		var _url = "${pageContext.request.contextPath}/organization.do";
		var _args = {"id":data.organizationId,"time":new Date(),"action":"seekOrganization"};
		$.getJSON(_url,_args,function(_data){
			var organizationName;
			var assignStatus;
			if(jQuery.isEmptyObject(_data)){
				organizationName = "无"; 
			}
			else{
				organizationName = _data.name;
			}
			if(data.isAssigned == "1"){
				assignStatus = "已分配";
			}
			else if(data.isAssigned == "0"){
				assignStatus = "未分配";
			}
			var tr;
			tr = "<tr><td>" + data.id + "</td><td>" + data.name + "</td><td>" + data.peopleNumber + "</td>"
			     + "<td>" + data.startTime + "</td><td>" + data.endTime + "</td><td>" + data.type + "</td>"
			     + "<td>" + data.weight + "</td><td>" + organizationName + "</td><td>" + data.description + "</td>"
			     + "<td>" + assignStatus + "</td>"
			     + "<td><a href='#' id='" + data.id + "' class='assign' value='" + data.isAssigned + "'>分配</a></td>"
			     + "<td><a href='${pageContext.request.contextPath}/task.do?action=update&id=" + data.id + "' class='update'>更新</a></td>"
			     + "<td><a href='#' id='" + data.id + "' class='delete'>删除</a></td></tr>";	     
			$("#tbody").append(tr);
			$("tbody tr:last td:eq(10)").find("a").bind("click",function(){
				if($(this).attr("value") == "1"){
					alert("此任务已分配");
					return ;
				}
				var url = "${pageContext.request.contextPath}/task.do";
				var args = {"id":$(this).attr("id"),"time":new Date(),"action":"assignTask"};
				$.get(url,args,function(data){
					if(data == "false"){
						alert("人数不足，分配失败");
						return ;
					}
					alert("分配成功");
				})
				$(this).attr("value","1");
				$(this).parent().parent().find("td:eq(9)").text("已分配");
			})
			$("tbody tr:last td:eq(12)").find("a").bind("click",function(){
				var name = $(this).parent().parent().find("td:eq(1)").text();
				var flag = confirm("确定要删除'"+name+"'的信息吗？");
				if(flag == false){
					return false;
				}
				var url = "${pageContext.request.contextPath}/task.do";
				var args = {"id":$(this).attr("id"),"time":new Date(),"action":"deleteTask"};
				var $deleteTr = $(this).parent().parent();
				$.get(url,args,function(data){
					alert("删除成功！");
					$deleteTr.remove();
				})
			})
		})
	}
	
	$("#btn").click(function(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var id = $("#id").val();
		if(id == ""){
			alert("请输入任务ID！");
			return ;
		}
		var url = "${pageContext.request.contextPath}/task.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","id":id,"time":new Date(),"action":"seekTask"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>此任务不存在</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>任务名</th><th>所需人数</th><th>开始时间</th><th>结束时间</th><th>类别</th>"
					+ "<th>权值</th><th>所属组织</th><th>描述</th><th>分配状态</th>"
					+ "<th>分配任务</th><th>更新任务信息</th><th>删除任务</th></tr>");
			show(data);
			
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
		var url = "${pageContext.request.contextPath}/task.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","type":type,"year":year,"half":half,"time":new Date(),"action":"seekTasksBy"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有任务信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>任务名</th><th>所需人数</th><th>开始时间</th><th>结束时间</th><th>类别</th>"
					+ "<th>权值</th><th>所属组织</th><th>描述</th><th>分配状态</th>"
					+ "<th>分配任务</th><th>更新任务信息</th><th>删除任务</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})		
		})
	}
})
</script>
</body>
</html>