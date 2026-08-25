<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<div id="header">
<h3>Floor Master</h3>

</div>

<div id="nav">
<table >
<tr><td><input type="button" name="btncompany" class="myButton" value="Floor" style="width:90px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/floormaster/floor.jsp";'></td></tr>
<tr><td><input type="button" name="btnbranch" class="myButton" value="Rack" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/floormaster/rack.jsp";'></td></tr>
<tr><td><input type="button" name="btnlocation" class="myButton" value="Bin" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/floormaster/bin.jsp";'></td></tr>

</table>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='FLR'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
</div>
<div id="comiframe">

	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/floormaster/floor.jsp"></iframe>
</div>
<script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe2]
                    .document.body.scrollHeight;
}
</script>
</div>
</body>
</html>