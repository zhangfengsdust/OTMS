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
<body style="margin-TOP:50PX" >
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

  <div style="width:200PX;float:right" class="form-group">
    <label for="name"></label>
  </div>

<div id="container" style="min-width: 310px; height: 400px; margin: 100 auto"></div>
<div style="width: 800px; height: 100px"></div>
<div style="margin: 100 auto">
<table id="datatable" class="table table-hover" >
  <caption>任务权值统计</caption>
    <thead>
    <tr><th>姓名</th><th>总权值</th></tr>
    </thead>
    <tbody id="tbody">
    </tbody>
  </table>
  </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/highcharts.js"></script>
<script type="text/javascript">
$(function () {
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
		$("#tbody").empty();
		members = [];
		var type = $("#type").val();
		var year = $("#year").val();
		var half;
		if(year == "全部"){
			half = "全年";
		}
		else{
			half = $("#half").val();
		}
		var url = "${pageContext.request.contextPath}/member.do";
		var args = {"organizationId":"${sessionScope.user.organizationId}","time":new Date(),"action":"seekAllByOrg"};
		$.getJSON(url,args,function(data){
			$.each(data,function(index,content){
				var totalWeight = 0;
				var url2 = "${pageContext.request.contextPath}/execute.do";
				var args2 = {"id":content.id,"type":type,"year":year,"half":half,"time":new Date(),"action":"seekTasksByMember"};
				$.getJSON(url2,args2,function(data2){
					$.each(data2,function(index2,content2){
						if(content2.comments == "完成"){
							var url3 = "${pageContext.request.contextPath}/task.do";
							var args3 = {"id":content2.taskId,"time":new Date(),"action":"seekById"};
							$.getJSON(url3,args3,function(data3){
								totalWeight += data3.weight;							
							})
						}
					})
				})
				var tr = "<tr><td>" + content.name + "</td><td>" + totalWeight + "</td><tr>";
				$("#tbody").append(tr);
				set(content.name,totalWeight);
			})
			charts();
		})
	}
	var members = [];
	function set(name,totalWeight){
		var member = [];
		member.push(name);
		member.push(totalWeight);
		members.push(member);
	}

	function charts(){
		$('#container').highcharts({
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: '已完成任务权值'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            type: 'category',
	            labels: {
	                rotation: -45,
	                style: {
	                    fontSize: '13px',
	                    fontFamily: 'Verdana, sans-serif'
	                }
	            }
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: ''
	            }
	        },
	        legend: {
	            enabled: false
	        },
	        tooltip: {
	            pointFormat: '总权值: <b>{point.y:.1f} </b>'
	        },
	        series: [{
	            name: '总权值',
	            data: members,
	            dataLabels: {
	                enabled: true,
	                rotation: -90,
	                color: '#FFFFFF',
	                align: 'right',
	                format: '{point.y:.1f}', // one decimal
	                y: 10, // 10 pixels down from the top
	                style: {
	                    fontSize: '13px',
	                    fontFamily: 'Verdana, sans-serif'
	                }
	            }
	        }]
	    });
	}
    
});

</script>
</body>
</html>