<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="../../../../css/btn btn-info.css" rel="stylesheet"
	type="text/css" /> -->
	<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
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

/* #nav {
	line-height: 30px;
	background-color: #E0ECF8;
	height: 90.5%;
	width: 5%;
	float: left;
	position: absolute;
} */

/* #comiframe {
	float: right;
	width: 98.5%;
	height: 98%;
	color: #eeeeee;
} */
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

</head>
<body>
	<div id="mainBG" class="homeContent" data-type="background">
		<div class="page-header">
			<h3>Product Related Master</h3>

		</div>

		<div id="nav">
		 
			<input type="hidden" id="formName" name="formName" value="000" /> <input
				type="hidden" id="formCode" name="formCode" value="COM" /> <input
				type="hidden" id="branchid" name="branchid" value='' /> 
				<input type="hidden" id="mode" name="mode"  />
		</div>
		
		<div class="row"> 
		<div class="col-md-2">
		<input type="button" name="btntype" class="btn btn-info"
						value="Type" style="width: 100%;margin:3px; outline: none;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/typeMaster.jsp";'>
						<br>
						<input type="button" name="btnbrand" class="btn btn-info"
						value="Brand" style="width: 100%;margin:3px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/brand.jsp";'>
						<br>
						<input type="button" name="btncategory" class="btn btn-info"
						value="Category" style="width: 100%;;margin:3px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/Category.jsp";'>
						<br>
						<input type="button" name="btnscategory" class="btn btn-info"
						value="Subcategory" style="width: 100%;margin:3px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/SubCategory.jsp";'>
						<br>
						<input type="button" name="btndept" class="btn btn-info"
						value="Department" style="width: 100%;margin:3px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/deptMaster.jsp";'>
						<br>
						<input type="button" name="btnunit" class="btn btn-info"
						value="Unit" style="width: 100%;margin:3px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/unit.jsp";'>
						
		</div>
		<div class="col-md-10" id="comiframe">

			<iframe width="100%" height="100%" id="iframe2" align="right"
				frameborder="0" marginwidth="100%" scrolling="no"
				src="<%=contextPath%>/com/controlcentre/settings/productsettings/typeMaster.jsp"></iframe>
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
</body>
</html>