<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet"
	type="text/css" />
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>

.page-header {
    /* padding-bottom: 9px; */
    margin: 10px 0 10px !important;
    border-bottom: 1px solid #eee !important;
}
#whole {
	width: 100%;
}

#header {
	background-color: #E0ECF8;
	color: black;
	text-align: left;
	height: 7%;
	width: 3% padding:0px;
}

#nav {
	line-height: 30px;
	background-color: #E0ECF8;
	height: 90.5%;
	width: 5%;
	float: left;
	position: absolute;
}

#comiframe {
	float: right;
	width: 98.5%;
	height: 98%;
	color: #eeeeee;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
	});
</script>
<style>
.hidden-scrollbar {
	overflow: auto;
	height: 550px;
}
</style>
</head>
<body>
	<div id="mainBG" class="homeContent" data-type="background">
	<div class='hidden-scrollbar'>
		<div class="page-header">
			<h4>Property Related Master</h4>		 
		</div>
		<div class="row">
			<div class="col-md-2" style="padding-right:0;">
				<input type="button" name="btntype" class="btn btn-info"
					value="Building" style="width: 100%; margin: 2px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/realestate/propertyrelated/propertyrelatedmaster/building.jsp"'>
				<br /> 
				<input type="button" name="btnbrand" class="btn btn-info"
					value="Property Type" style="width: 100%; margin: 2px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/realestate/propertyrelated/propertyrelatedmaster/typeMaster.jsp"'>
				<br /> 
				<input type="button" name="btnbrand" class="btn btn-info"
					value="Unit Type" style="width: 100%; margin: 2px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/realestate/propertyrelated/propertyrelatedmaster/unittype.jsp"'>
				<br /> 
				<input type="hidden" id="formName" name="formName"
					value="000" /> <input type="hidden" id="formCode" name="formCode"
					value="COM" /> <input type="hidden" id="branchid" name="branchid"
					value='' /> <input type="hidden" id="mode" name="mode" />
			</div>
			<div class="col-md-10">
				<iframe width="100%" height="100%" id="iframe2" align="left"
					frameborder="0" marginwidth="100%" scrolling="no"
					src="<%=contextPath%>/com/realestate/propertyrelated/propertyrelatedmaster/building.jsp"></iframe>
			</div>
		</div>
		<script>
			function resizeIframeToFitContent(iframe) {
				// This function resizes an IFrame object
				// to fit its content.
				// The IFrame tag must have a unique ID attribute.
				iframe.height = document.frames[iframe.iframe2].document.body.scrollHeight;
			}
		</script>
		</div>
	</div>
</body>
</html>