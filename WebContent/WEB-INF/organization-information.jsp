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
<div>
  <div style="width:300PX;float:left" class="input-group"> 
    <input id="organizationName" type="text" class="form-control" placeholder="组织名" aria-describedby="basic-addon1">
    <span class="input-group-btn"><button id="btn1" type="button" style="width:60px;" class="btn btn-default">搜索</button></span>
  </div>
  <div style="width:200PX;float:left;margin-left:100PX">
    <button id="btn2" type="button" style="width:120px;" class="btn btn-default">查看全部</button>
  </div>
</div>
<br>
<div id="info" style="width:300PX"></div>
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
	function show(data){
		var _url = "${pageContext.request.contextPath}/organization.do";
		var _args = {"id":data.parentId,"time":new Date(),"action":"seekOrganization"};
		$.getJSON(_url,_args,function(_data){
			var parentName;
			var tr;
			if(jQuery.isEmptyObject(_data)){
				parentName = "无"; 
			}
			else{
				parentName = _data.name;
			}
			tr = "<tr><td>" + data.id + "</td><td>" + data.name + "</td><td>" + parentName + "</td>"
			     + "<td><a href='#' id='" + data.id + "' class='check'>查看</a></td>"
			     + "<td><a href='${pageContext.request.contextPath}/organization.do?action=update&id=" + data.id + "' class='update'>更新</a></td>"
			     + "<td><a href='#' id='" + data.id + "' class='delete'>删除</a></td></tr>";
			$("#tbody").append(tr);
			$("tbody tr:last td:eq(3)").find("a").bind("click",function(){
				    $("#thead").empty();
					$("#tbody").empty();
					$("#info").empty();
					var url = "${pageContext.request.contextPath}/organization.do";
					var args = {"parentId":$(this).attr("id"),"time":new Date(),"action":"seekOrganizations"};
					$.getJSON(url,args,function(data){
						if(jQuery.isEmptyObject(data)){
							$("#info").html("<font color='red'>该组织不存在子组织</font>");
							return ;
						}
						$("#thead").append("<tr><th>ID</th><th>组织名</th><th>所属组织</th><th>查看子组织</th><th>更新组织信息</th><th>删除组织</th></tr>");
						$.each(data,function(index,content){
							show(content);
						})		
					})
			});
			$("tbody tr:last td:eq(5)").find("a").bind("click",function(){
				var name = $(this).parent().parent().find("td:eq(1)").text();
				var flag = confirm("确定要删除'"+name+"'的信息吗？");
				if(flag == false){
					return false;
				}
				var url = "${pageContext.request.contextPath}/organization.do";
				var args = {"id":$(this).attr("id"),"time":new Date(),"action":"deleteOrganization"};
				var $deleteTr = $(this).parent().parent();
				$.get(url,args,function(data){
					if(data == "0"){
						alert("删除成功！");
						$deleteTr.remove();
					}
					else if(data == "1"){
						alert("该组织存在子组织,删除失败！");
					}
					else if(data == "2"){
						alert("该组织存在成员,删除失败！");
					}
					else if(data == "3"){
						alert("该组织存在任务,删除失败！");
					}
				})
			})
		})
	}
	
	$("#btn1").click(function(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var organizationName = $("#organizationName").val();
		organizationName = $.trim(organizationName);
		if(organizationName == ""){
			alert("请输入组织名！");
			return ;
		}
		var url = "${pageContext.request.contextPath}/organization.do";
		var args = {"name":organizationName,"time":new Date(),"action":"seekOrganizationByName"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>此组织不存在</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>组织名</th><th>所属组织</th><th>查看子组织</th><th>更新组织信息</th><th>删除组织</th></tr>");
			show(data);
			
		})
	})
	
	$("#btn2").click(function(){
    	$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var url = "${pageContext.request.contextPath}/organization.do";
		var args = {"parentId":"0","time":new Date(),"action":"seekOrganizations"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有组织信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>组织名</th><th>所属组织</th><th>查看子组织</th><th>更新组织信息</th><th>删除组织</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})		
		})
	})
})
</script>
</body>
</html>