
<%
	String contextPath = request.getContextPath();
%>

<!DOCTYPE>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
html,body {
	overflow: hidden;
}

#whole {
	width: 100%;
}

#header {
	text-align: left;
	height: 4.5%;
	width: 15%;
	padding: 0px;
}

#nav {
	line-height: 30px;
	height: 90.5%;
	width: 9%;
	float: left;
	position: absolute;
}

/* #comiframe {
	float: right;
	width: 98.5%;
	height: 98%;
	color: #E0ECF8;
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
			<h3>Area Master</h3>
		</div>
		<div id="nav">

			<input type="hidden" id="formName" name="formName" value='000' /> <input
				type="hidden" id="formCode" name="formCode" value='COM' /> <input
				type="hidden" id="branchid" name="branchid" value='' /> <input
				type="hidden" id="mode" name="mode" />
		</div>

		<div class="row">
			<div class="col-md-2">
				<input type="button" name="btnbrand" class="btn btn-info" value="Region"
					style="width: 100%;    margin: 3px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/areamaster/region.jsp";'>
					<br>
				<input type="button" name="btnmodel" class="btn btn-info"
					value="Country" style="width: 100%;    margin: 3px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/areamaster/country.jsp";'>
					<br>
				<input type="button" name="btnauthority" class="btn btn-info"
					value="State/Province" style="width: 100%;    margin: 3px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/areamaster/city.jsp";'>
					<br>
				<input type="button" name="btnplatecode" class="btn btn-info"
					value="City" style="width: 100%;    margin: 3px;"
					onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/areamaster/area.jsp";'>

			</div>
			<div class="col-md-10" id="comiframe">
				<iframe width="100%" height="100%" id="iframe2" align="right"
					frameborder="0" marginwidth="100%" scrolling="yes"
					src="<%=contextPath%>/com/controlcentre/settings/areamaster/region.jsp"></iframe>


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