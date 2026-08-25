<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="jquery.orgchart.css" media="all" rel="stylesheet" type="text/css" />
<%@page import="com.dashboard.humanresource.organogram.ClsorganogramDAO"%>
<% ClsorganogramDAO showDAO = new ClsorganogramDAO(); %>
<% String contextPath=request.getContextPath();%>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="jquery.orgchart.js"></script>
    <script type="text/javascript">
    /* var testData = [
        {id: 1, name: 'My Organization', parent: 0},
        {id: 2, name: 'CEO Office', parent: 1},
        {id: 3, name: 'Division 1', parent: 1},
        {id: 4, name: 'Division 2', parent: 1},
        {id: 6, name: 'Division 3', parent: 1},
        {id: 7, name: 'Division 4', parent: 1},
        {id: 8, name: 'Division 5', parent: 1},
        {id: 5, name: 'Sub Division', parent: 3},
        
    ]; */
    
    
    var testData='<%=showDAO.Loading()%>';
  //  alert(testData);
    testData=JSON.parse(testData);
    
    $(function(){
        org_chart = $('#orgChart').orgChart({
            data: testData,
            showControls: false,
            allowEdit: false,
            onAddNode: function(node){ 
                //log('Created new node on node '+node.data.id);
                org_chart.newNode(node.data.id); 
            },
            onDeleteNode: function(node){
                //log('Deleted node '+node.data.id);
                org_chart.deleteNode(node.data.id); 
            },
            onClickNode: function(node){
                //log('Clicked node '+node.data.id);
            }

        });
    });
    </script>
    <style>
    	.organogram-container{
    		width:98%;
    		height:500px;
    		overflow:auto;
    	}

    </style>
</head>
<body >
	<div class="organogram-container">
		<div id="orgChartContainer">
	    	<div id="orgChart"></div>
	    </div>
	</div>
	
</body>
</html>