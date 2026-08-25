<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet" type="text/css"/>

<jsp:include page="../../../../includes.jsp"></jsp:include>
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

.page-header
{ 
    margin: 0px 0 10px !important;
    padding-bottom: 0px !important;
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
<div id="mainBG" class="homeContent" data-type="background">
<div class="page-header">
<h3>Staff Master</h3>
</div>

<div class="container-fluid">
<div class="col-md-2">
<input type="button" name="btnsalesman" class="btn btn-info" value="Salesman" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp";'>
<br/>
<input type="button" name="btnsalesagent" class="btn btn-info" value="Sales Agent" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesAgent.jsp";'>
<br/>
<input type="button" name="btnrentalagent" class="btn btn-info" value="Rental Agent" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'>
<br/>
<input type="button" name="btndriver" class="btn btn-info" value="Driver" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'>
<br/>
<input type="button" name="btncheckin" class="btn btn-info" value="Check In" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/checkin.jsp";'>
<br/>
<input type="button" name="btnstaff" class="btn btn-info" value="Staff" style="width:100%;margin:2px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/staff.jsp";'>
</div>
<div class="col-md-10">
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp"></iframe>
</div>
</div>
</div>



<%-- <div id="nav">
<table >
<tr><td><input type="button" name="btnsalesman" class="myButton" value="Salesman" style="width:90px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp";'></td></tr>
<tr><td><input type="button" name="btnsalesagent" class="myButton" value="Sales Agent" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesAgent.jsp";'></td></tr>
<tr><td><input type="button" name="btnrentalagent" class="myButton" value="Rental Agent" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'></td></tr>
<tr><td><input type="button" name="btndriver" class="myButton" value="Driver" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'></td></tr>
<tr><td><input type="button" name="btncheckin" class="myButton" value="Check In" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/checkin.jsp";'></td></tr>
<tr><td><input type="button" name="btnstaff" class="myButton" value="Staff" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/staff.jsp";'></td></tr>
</table>
</div> --%>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='SAP'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />

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