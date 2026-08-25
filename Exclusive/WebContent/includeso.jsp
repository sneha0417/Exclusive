<html>
<%
	String contextPath = request.getContextPath();
%>
<head>

<link href="<%=contextPath%>/css/body.css" media="screen"
	rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/jqx.base.css" rel="stylesheet"
	type="text/css" />
<link href="<%=contextPath%>/css/table.css" rel="stylesheet"
	type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" media="screen"
	rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/jqx.mobile.css" media="screen"
	rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/jqx.energyblue.css" media="screen"
	rel="stylesheet" type="text/css" />
 <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
<!-- <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

<link rel="stylesheet" 
  href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
 
<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
 -->
 <link href="https://cdn.jsdelivr.net/npm/select2@4.0.12/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.0.12/dist/js/select2.min.js"></script>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
	
<script type="text/javascript" src="<%=contextPath%>/js/jqxcore.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/demos.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxcalendar.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxmenu.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxtabs.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxbuttons.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxscrollbar.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.selection.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.columnsresize.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.edit.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.sort.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.pager.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.filter.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.grouping.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxdata.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxpanel.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxlistbox.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxdropdownlist.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxcheckbox.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxtooltip.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxwindow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxtree.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.aggregates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxexpander.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.easyui.min.js"></script>

<script type="text/javascript" src="<%=contextPath%>/js/jqxdatatable.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxtreegrid.js"></script>

<%-- <script type="text/javascript" src="<%=contextPath%>/js/alert/jquery-1.4.4.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/alert/jquery.easyui.min.js"></script>--%>

<script type="text/javascript"
	src="<%=contextPath%>/js/jqxchart.core.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxdraw.js"></script>
<%--<script type="text/javascript" src="<%=contextPath%>/js/jqxslider.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxradiobutton.js"></script> --%>

<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/css/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/css/icon.css">

<%--       <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/bootstrap.min.css"> --%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/css/main.css">

<script type="text/javascript"
	src="<%=contextPath%>/js/additional-methods.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.validate.min.js"></script>

<script type="text/javascript" src="<%=contextPath%>/js/pace.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxdata.export.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jqxgrid.export.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jqxinput.js"></script>

<%-- 	<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.js"></script> --%>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/main.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/exportExcel.js"></script>
</head>
</html>
