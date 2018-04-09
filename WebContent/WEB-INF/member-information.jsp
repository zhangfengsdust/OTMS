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
    <input id="username" type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
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
		var _args = {"id":data.organizationId,"time":new Date(),"action":"seekOrganization"};
		$.getJSON(_url,_args,function(_data){
			var organizationName;
			var _birthDate;
			if(jQuery.isEmptyObject(_data)){
				organizationName = "无"; 
			}
			else{
				organizationName = _data.name;
			}
			if(data.birthDate == null){
				_birthDate = "";
			}
			else{
				_birthDate = data.birthDate;
			}
			var tr;
			tr = "<tr><td>" + data.id + "</td><td>" + data.username + "</td><td>" + data.password + "</td>"
			     + "<td>" + data.name + "</td><td>" + data.sex + "</td><td>" + _birthDate + "</td>"
			     + "<td>" + data.identityCard + "</td><td>" + data.mobile + "</td><td>" + organizationName + "</td>"
			     + "<td>" + data.totalWeight + "</td>"
			     + "<td><a href='${pageContext.request.contextPath}/member.do?action=update&id=" + data.id + "' class='update'>更新</a></td>"
			     + "<td><a href='#' id='" + data.id + "' class='delete'>删除</a></td>"
			     + "<td><a href='#' id='" + data.id + "' class='set' value='1'>设置</a></td></tr>";
			$("#tbody").append(tr);
			$("tbody tr:last td:eq(12)").find("a").bind("click",function(){
				    if("${sessionScope.user.power}" < 3){
				    	alert("您没有此权限");
				    	return ;
				    }
				    if($(this).attr("value") == "0"){
				    	alert("不能重复设置");
				    	return ;
				    }
					var url = "${pageContext.request.contextPath}/member.do";
					var args = {"id":$(this).attr("id"),"time":new Date(),"action":"setAdministrator"};
					$.get(url,args,function(data){
						alert("设置成功");
					})
					$(this).attr("value","0");
			})
			$("tbody tr:last td:eq(11)").find("a").bind("click",function(){
				var name = $(this).parent().parent().find("td:eq(1)").text();
				var flag = confirm("确定要删除'"+name+"'的信息吗？");
				if(flag == false){
					return false;
				}
				var url = "${pageContext.request.contextPath}/member.do";
				var args = {"id":$(this).attr("id"),"time":new Date(),"action":"deleteMember"};
				var $deleteTr = $(this).parent().parent();
				$.get(url,args,function(data){
					alert("删除成功！");
					$deleteTr.remove();
				})
			})
		})
	}
	
	$("#btn1").click(function(){
		$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var username = $("#username").val();
		username = $.trim(username);
		if(username == ""){
			alert("请输入用户名！");
			return ;
		}
		var url = "${pageContext.request.contextPath}/member.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","username":username,"time":new Date(),"action":"seekMember"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>此成员不存在</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>用户名</th><th>密码</th><th>姓名</th><th>性别</th><th>出生日期</th>"
					+ "<th>身份证</th><th>手机号</th><th>所属组织</th><th>总权值</th>"
					+ "<th>更新成员信息</th><th>删除成员</th><th>设为管理员</th></tr>");
			show(data);
			
		})
	})
	
	$("#btn2").click(function(){
    	$("#thead").empty();
		$("#tbody").empty();
		$("#info").empty();
		var url = "${pageContext.request.contextPath}/member.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","time":new Date(),"action":"seekMembers"};
		$.getJSON(url,args,function(data){
			if(jQuery.isEmptyObject(data)){
				$("#info").html("<font color='red'>没有成员信息</font>");
				return ;
			}
			$("#thead").append("<tr><th>ID</th><th>用户名</th><th>密码</th><th>姓名</th><th>性别</th><th>出生日期</th>"
					+ "<th>身份证</th><th>手机号</th><th>所属组织</th><th>总权值</th>"
					+ "<th>更新成员信息</th><th>删除成员</th><th>设为管理员</th></tr>");
			$.each(data,function(index,content){
				show(content);
			})		
		})
	})
})
</script>
</body>
</html>