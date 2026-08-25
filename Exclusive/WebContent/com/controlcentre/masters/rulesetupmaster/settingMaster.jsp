<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
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
	height: 100%;
	width: 9%;
	float: left;
	position: absolute;
}

#comiframe {
	float: right;
	width: 98.5%;
	height: 500px;
	color: #E0ECF8;
}
</style>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<div id="header">
	<h3>Rule Set Up Masters</h3>
</div>
<div id="nav">
<table>
<tr><td><input type="button" name="btnmethod" class="myButton" value="Method Settings" style="width:100%;outline:none;font-size: 12px;" onclick='document.getElementById("iframe4").src="/CarRental/com/controlcentre/masters/rulesetupmaster/methodSettings.jsp";'></td></tr>
<tr><td><input type="button" name="btnratedesc" class="myButton" value="Rate Description" style="width:100%;font-size: 12px;" onclick='document.getElementById("iframe4").src="/CarRental/com/controlcentre/masters/rulesetupmaster/rateDescription.jsp";'></td></tr>
<tr><td><input type="button" name="btnvehsts" class="myButton" value="Vehicle Status" style="width:100%;font-size: 12px;" onclick='document.getElementById("iframe4").src="/CarRental/com/controlcentre/masters/rulesetupmaster/vehicleStatus.jsp";'></td></tr>
<tr><td><input type="button" name="btnvehtran" class="myButton" value="Vehicle Trasactions" style="width:100%;font-size: 12px;" onclick='document.getElementById("iframe4").src="/CarRental/com/controlcentre/masters/rulesetupmaster/vehicleTransaction.jsp";'></td></tr>
</table>
</div>
<div id="comiframe">
    <iframe width="100%" height="100%" id="iframe4" align="right" frameborder="0" marginwidth="150%" scrolling="yes" src="/CarRental/com/controlcentre/masters/rulesetupmaster/methodSettings.jsp"></iframe>
</div>
<script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe4]
                    .document.body.scrollHeight;
}
</script>
</div>
</body>
</html>