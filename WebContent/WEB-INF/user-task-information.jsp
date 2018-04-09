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
  <div style="width:150PX;float:left;margin-left:0PX" class="form-group">
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
  <div style="width:150PX;float:left;margin-left:100PX" class="form-group">
    <label for="name">年份</label>
    <select class="form-control" id="year" name="year">
      <option selected="selected" value="全部">全部</option>
      <option value="2015">2015年</option>
      <option value="2016">2016年</option>
      <option value="2017">2017年</option>
    </select>
  </div>
  <div id="add" style="width:150PX;float:left;margin-left:100PX" class="form-group">
  </div>
  <br>
  <div id="info" style="width:300PX"></div>
  <br>
  <div>
    <table style="word-wrap:break-word; word-break:break-all" class="table table-hover">
      <thead id="thead">
      </thead>
      <tbody id="tbody">
      </tbody>
    </table>
  </div>
  <br>
  <div id="div1" style="float:left;margin:0PX 0PX;width:150PX"></div>
  <div id="div2" style="float:left;margin:0PX 0PX;width:100PX"></div>
  <div id="div3" style="float:left;margin:0PX 0PX;width:150PX"></div>
  <div id="div4" style="float:left;margin:0PX 0PX;width:100PX"></div>
  <div id="div5" style="float:left;margin:0PX 0PX;width:100PX"></div>
  <div id="div6" style="float:left;margin:0PX 0PX;width:100PX"></div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(function(){
	$.ajaxSettings.async = false;
	show();
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
				show();
			})
		}
		show();
	})
	$("#type").change(function(){
		show();
	})
	
	function show(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		$("#div1").empty();
		$("#div2").empty();
		$("#div3").empty();
		$("#div4").empty();
		$("#div5").empty();
		$("#div6").empty();
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
		var args = {"id":"${sessionScope.user.id}","type":type,"year":year,"half":half,"time":new Date(),"action":"seekTasksByMember"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>您没有任务信息</font>");
				return ;
			}
			var finishNum = 0;
			var unFinishNum = 0;
			var totalWeight = 0;
			$("#thead").append("<tr><th>ID</th><th>任务名</th><th>所需人数</th><th>开始时间</th>"
					+"<th>结束时间</th><th>类别</th><th>权值</th><th>所属组织</th>"
					+"<th>描述</th><th>是否完成</th></tr>");
			$.each(data,function(index,_data){
				if(_data.comments == "完成"){
					finishNum++;
				}
				if(_data.comments == "未完成"){
					unFinishNum++;
				}
				var url2 = "${pageContext.request.contextPath}/task.do";
				var args2 = {"id":_data.taskId,"time":new Date(),"action":"seekById"};
				$.getJSON(url2,args2,function(data2){
					if(_data.comments == "完成"){
						totalWeight += data2.weight;
					}
					var url3 = "${pageContext.request.contextPath}/organization.do";
					var args3 = {"id":data2.organizationId,"time":new Date(),"action":"seekOrganization"};
					$.getJSON(url3,args3,function(data3){
						var tr;
						tr = "<tr><td>" + data2.id + "</td><td>" + data2.name + "</td><td>" + data2.peopleNumber + "</td><td>" + data2.startTime + "</td>"
						 + "<td>" + data2.endTime + "</td><td>" + data2.type + "</td><td>" + data2.weight + "</td>"
						 + "<td>" + data3.name + "</td><td>" + data2.description + "</td><td>" + _data.comments + "</td>"
					     + "</tr>";
					    $("#tbody").append(tr);
					})
					
				})
			})
			
			$("#div1").html("<h4>已完成任务：</h4>");
			$("#div2").html("<h4>" + finishNum + "</h4>");
			$("#div3").html("<h4>未完成任务 ：</h4>");
			$("#div4").html("<h4>" + unFinishNum + "</h4>");
			$("#div5").html("<h4>总权值：</h4>");
			$("#div6").html("<h4>" + totalWeight + "</h4>");
			
		})	
	}
})
</script>
</body>
</html>