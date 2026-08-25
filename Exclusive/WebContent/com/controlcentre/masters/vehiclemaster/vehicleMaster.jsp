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
<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO(); %>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
		$('#leasecdwdiv').hide();
		var cdwstatus='<%=cdwdao.getActiveStatus()%>';
		if(cdwstatus=="1"){
			$('#leasecdwdiv').show();
		}
		else{
			$('#leasecdwdiv').hide();
		}
	});
	</script>
</head>
<body >
<div id="mainBG" class="homeContent" data-type="background">
<div id="header">
	<h3>Vehicle Master</h3>
</div>
<div id="nav">
<table >
		<tr><td><input type="button" name="btnbrand" class="myButton" value="Brand" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp";'></td></tr>
		<tr><td><input type="button" name="btnmodel" class="myButton" value="Model" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/modelnew.jsp";'></td></tr>
		<tr><td><input type="button" name="btnauthority" class="myButton" value="Authority" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/authority.jsp";'></td></tr>
		<tr><td><input type="button" name="btnplatecode" class="myButton" value="Plate Code" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/plateCode.jsp";'></td></tr>
		<tr><td><input type="button" name="btngroup" class="myButton" value="Group" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/group.jsp";'></td></tr>
		<tr><td><input type="button" name="btndealer" class="myButton" value="Dealer" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/dealer.jsp";'></td></tr>
		<tr><td><input type="button" name="btnfinance" class="myButton" value="Financier" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/financier.jsp";'></td></tr>
		<tr><td><input type="button" name="btninsurance" class="myButton" value="Insurance" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/insurance.jsp";'></td></tr>
		<tr><td><input type="button" name="btncolor" class="myButton" value="Color" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/color.jsp";'></td></tr>
		<!-- <tr><td><input type="button" name="btnvehicle" class="myButton" value="Vehicle" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehicle/vehicle2.jsp";'></td></tr> -->
		<tr><td><input type="button" name="btnunit" class="myButton" value="Unit" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/unit.jsp";'></td></tr>
		<tr><td><input type="button" name="btnspecs" class="myButton" value="Specification" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/specification.jsp";'></td></tr>
		<tr><td><input type="button" id="btnproject" name="btnproject" class="myButton" value="Project" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/project.jsp";'></td></tr>
		<div id="leasecdwdiv">
		<tr><td><input type="button" id="btnleasecdw" name="btnleasecdw" class="myButton" value="Lease CDW" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/leasecdw.jsp";'></td></tr>
		<tr><td><input type="button" id="btnsecuritypass" name="btnsecuritypass" class="myButton" value="Security Pass" style="width:90px; text-align: center;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/securityPass.jsp";'></td></tr>
		<tr><td><input type="button" name="btnyom" class="myButton" value="Yom" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/yom.jsp";'></td></tr>
		<tr><td><input type="button" name="btnvehtype" class="myButton" value="Vehicle Type" style="width:90px;" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/vehType.jsp";'></td></tr>
		</div> 
</table>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='veh'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
</div>
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe1" align="right" frameborder="0" marginwidth="100%" scrolling="yes" src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp"></iframe>
	 

</div>

<script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe1]
                    .document.body.scrollHeight;
}
</script>
</div>
</body>
</html>