<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../css/myButton.css" rel="stylesheet" type="text/css"/>
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

</head>

<body>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<h3>Transport Master</h3>
<div id="nav">
<table >
<tr><td><input type="button" name="btnmode" class="myButton" value="Mode" style="width:90px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/cargo/transportmasters/mode.jsp";'></td></tr>
<tr><td><input type="button" name="btnsubmode" class="myButton" value="Sub Mode" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/cargo/transportmasters/subMode.jsp";'></td></tr>
<tr><td><input type="button" name="btnshipment" class="myButton" value="Shipment" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/cargo/transportmasters/shipment.jsp";'></td></tr>
<tr><td><input type="button" name="btnservicetype" class="myButton" value="Service Type" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/cargo/transportmasters/serviceType.jsp";'></td></tr>
<tr><td><input type="button" name="btnterms" class="myButton" value="Terms" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/cargo/transportmasters/terms.jsp";'></td></tr>
</table>
</div>

<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='CTM'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />

<div id="comiframe">
    <iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/cargo/transportmasters/mode.jsp"></iframe>
</div>





</body>
</html>