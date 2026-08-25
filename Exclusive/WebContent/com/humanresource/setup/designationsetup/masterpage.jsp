<!DOCTYPE>
<html>
<head>
<% String contextPath=request.getContextPath();%>
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
    height:50%;
    width:15%;
    float:left;
    position:absolute;
    
 /*    background-color:	#ffc0cb; */
    
    
}

#comiframe
{
float:right;
width:93%;
height:95%;
color:#eeeeee;

}
 
 /*   .myButtons {
	  -moz-box-shadow: 0px -2px 14px -7px #276873;
	-webkit-box-shadow: 0px -2px 14px -7px #276873;  
	box-shadow: 0px -2px 14px -7px #276873;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
	background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
	background-color:#599bb3;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-radius:5px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Verdana;
	font-size:10px;
	padding:5px 10px;
	text-decoration:none;
	   text-shadow:0px 1px 13px #3d768a;  
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
	background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
	background-color:#408c99;
}
.myButtons:active {
	position:relative;
	top:1px;
} 
      */
 
 
    .myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
	background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
	background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
	background-color:#599bb3;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Verdana;
	font-size:10px;
	padding:4px 8px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
	background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
	background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
	background-color:#408c99;
}
.myButtons:active {
	position:relative;
	top:1px;
} 
 
  /*   #ss
{
background-color:	#ffc0cb;
}
   
  */

</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script> 
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background"> 
 
<br> 

<div id="nav">   
<br>
 
<table width="60%" id="ss">  
<tr><td align="center"><input type="button"   class="myButtons" value="GRADE" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/designationsetup/grade.jsp";'></td></tr>

  <tr><td align="center"><input type="button"   class="myButtons" value="QUALIFICATION" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/designationsetup/qualification.jsp";'></td></tr>
 
</table>
</div>
<div id="comiframe">
	<iframe width="99%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/humanresource/setup/designationsetup/grade.jsp";></iframe>
</div>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='HRM'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>


<input type="hidden" id="mode" name="mode"   />



</div>
</body>
</html>