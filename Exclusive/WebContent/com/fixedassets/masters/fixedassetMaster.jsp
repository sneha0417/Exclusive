<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/main.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" rel="stylesheet" type="text/css"/>

<jsp:include page="../../../includes.jsp"></jsp:include>

<style>
#whole
{
width:100%;
}
#header
{
background-color: #E0ECF8;
color:black;
text-align:left;
height:7%;
width:3%
padding:0px;
}
#nav
{
   line-height:30px;
    background-color: #E0ECF8;
    height:90.5%;
    width:5%;
    float:left;
    position:absolute;
    
    
}

#comiframe
{
float:right;
width:98.5%;
height:98%;
color:#eeeeee;

}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script>
</head>
<body>
<div class="container-fluid">
<div class="page-header">
<h3>Fixed Asset  Master</h3> 
</div>
<div class="col-md-1">
 
<input type="button" name="btnfgm" class="btn btn-info" value="Group Master" style="width:100px;outline:none;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp";'>
<input type="button" name="btnflm" class="btn btn-info" value="Loc. Master" style="width:100px;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/locationMaster.jsp";'>
<%-- <tr><td><input type="button" name="btnrentalagent" class="myButton" value="Rental Agent" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'></td></tr>
<tr><td><input type="button" name="btndriver" class="myButton" value="Driver" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'></td></tr>
<tr><td><input type="button" name="btncheckin" class="myButton" value="Check In" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/checkin.jsp";'></td></tr>
<tr><td><input type="button" name="btnstaff" class="myButton" value="Staff" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/staff.jsp";'></td></tr>
 --%> 
</div>

<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='SAP'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
<div class="col-md-11">
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp"></iframe>
</div>
</div>
<!-- <script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe2]
                    .document.body.scrollHeight;
}
</script> -->

</div>
</body>
</html>