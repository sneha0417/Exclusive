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
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	<%-- String a=<% String contextPatht=request.getContextPath();%>
	 --%>
	</script>
</head>
<body>

<div id="mainBG" class="homeContent" data-type="background">
<h3>Related Master</h3>


<div id="nav">
<table >
<%-- <tr><td><input type="button" name="btnsalesman" class="myButton" value="Salesman" style="width:90px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp";'></td></tr>
<tr><td><input type="button" name="btnsalesagent" class="myButton" value="Sales Agent" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesAgent.jsp";'></td></tr>
<tr><td><input type="button" name="btnrentalagent" class="myButton" value="Rental Agent" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'></td></tr>
<tr><td><input type="button" name="btndriver" class="myButton" value="Driver" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'></td></tr> --%>
<tr><td><input type="button" name="btnservice" class="myButton" value="ServiceType" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/servicetype.jsp";'></td></tr>
<tr><td><input type="button" name="btnvisa" class="myButton" value="VisaType" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/visatype.jsp";'></td></tr>
<tr><td><input type="button" name="btnnation" class="myButton" value="Nation" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/nationtype.jsp";'></td></tr>
<tr><td><input type="button" name="btnroom" class="myButton" value="RoomType" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/roomtype.jsp";'></td></tr>
<%-- <tr><td><input type="button" hidden="true" name="btnpackage" class="myButton" value="PackageType" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/packagetype.jsp";'></td></tr> --%>
<tr><td><input type="button" name="btntour" class="myButton" value="TourType" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/tourtype.jsp";'></td></tr>
<tr><td><input type="button" name="btnhotel" class="myButton" value="Hotel" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/hoteltype.jsp";'></td></tr>
<tr><td><input type="button" name="btnpricecategory" class="myButton" value="PriceCategory" style="width:100px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/priceCategory.jsp";'></td></tr>

</table>
</div>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='SERT'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/relatedmaster/servicetype.jsp"></iframe>
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