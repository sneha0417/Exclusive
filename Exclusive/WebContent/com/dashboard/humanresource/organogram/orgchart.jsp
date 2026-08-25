<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@page import="com.dashboard.humanresource.organogram.ClsorganogramDAO"%>
<% ClsorganogramDAO showDAO = new ClsorganogramDAO(); %>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
	html,body{
		width:100%;
		height:90%;
	}
	
</style>
</head>
<body>
	<div class="orgchart-container" style="width:99%;height:95%;overflow:auto;">
		<div id="chart_div"></div>
	</div>
	
	<script type="text/javascript">
		var jsondata='<%=showDAO.getGoogleOrgChartData()%>';
		jsondata=JSON.parse(jsondata);
		var jscustomarray=new Array();
		
		  google.charts.load('current', {packages:["orgchart"]});
	      google.charts.setOnLoadCallback(drawChart);
		
	      function drawChart() {
	        var data = new google.visualization.DataTable();
	        data.addColumn('string', 'Name');
	        data.addColumn('string', 'Manager');
	        data.addColumn('string', 'ToolTip');
	
	        // For each orgchart box, provide the name, manager, and tooltip to show.
	        /*data.addRows([
				['CHIEF EXECUTIVE OFFICER', '', ''],
				['GENERAL MANAGER','CHIEF EXECUTIVE OFFICER',''],
				['FINANCE CONTROLLER','CHIEF EXECUTIVE OFFICER',''],
				['EXECUTIVE ASSISTANT','CHIEF EXECUTIVE OFFICER',''],
				['FINANCE MANAGER','GENERAL MANAGER',''],
				['PROCUREMENT MANAGER','GENERAL MANAGER',''],
				['IT MANAGER','GENERAL MANAGER',''],
				['SERVICE MANAGER','GENERAL MANAGER',''],
				['HR AND ADMIN MANAGER','GENERAL MANAGER',''],
				['SALES & MARKETING MANAGER','GENERAL MANAGER','']
	        ]);*/
	        var result = Object.keys(jsondata).map(function(key) {
  				return [jsondata[key].name,jsondata[key].parentname,jsondata[key].tooltipname];
			});
			data.addRows(result);
	        /*$.each( jsondata, function( key, value ) {
	        	var eachrow = new Array(jsondata[key].name, jsondata[key].parentname, "");
	        	if(key==0){
	        		alert(typeof(eachrow));
	        	}
				data.addRows(eachrow);
			});*/
	        
	
	        // Create the chart.
	        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
	        // Draw the chart, setting the allowHtml option to true for the tooltips.
	        chart.draw(data, {allowHtml:true});
	      }
	</script>
</body>
</html>