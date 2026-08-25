<% String contextPath=request.getContextPath();%>

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

#comiframe {
	float: right;
	width: 98.5%;
	height: 98%;
	color: #E0ECF8;
}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script>

</head>
<body >
<div id="mainBG" class="homeContent" data-type="background">
<div id="header">
	<h3>Maintenance Master</h3>
</div>
<div id="nav">
<table >
<tr><td><input type="button" name="btngarage" class="myButton" value="Garage" style="width:90px;outline:none;" onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/garage.jsp";'></td></tr>
<tr><td><input type="button" name="btndamage" class="myButton" value="Damage" style="width:90px;" onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/damage.jsp";'></td></tr>
<tr><td><input type="button" name="btnmain" class="myButton" value="Maintenance" style="width:90px" onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp";'></td></tr>
<tr><td><input type="button" name="btncomplaint" class="myButton" value="Complaint" style="width:90px" onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/complaintmaster.jsp";'></td></tr>
</table>

<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='MNT'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
</div>

<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe3" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp"></iframe>
	
</div>
    <div align="right">
      <script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe3]
                    .document.body.scrollHeight;
}
    </script>
    </div>
</div>
</body>
</html>