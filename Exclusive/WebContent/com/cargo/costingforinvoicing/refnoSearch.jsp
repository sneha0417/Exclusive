 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
 <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<style>
 .myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
}      
</style>
	<script type="text/javascript">
	$(document).ready(function () { 
		   
	});   
  	function loadSearchss() {
 		var docnoss=document.getElementById("docnoss").value;
 		var datess="";
 		var client=document.getElementById("client").value;
		var aa="yes";
		getdatas(docnoss,datess,aa,client);
	}
	function getdatas(docnoss,datess,aa,client){
		 $("#refsearch").load('subrefnosearch.jsp?docnoss='+docnoss+'&datess='+datess+'&aa='+aa+'&client='+client+'&refno='+document.getElementById("refnossss").value+'&mobno='+document.getElementById("mobnos").value);
	}  
</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr ><td></td></tr>
  <tr><td>
  <table width="100%" >
     <tr> 
     <td align="right" width="10%">Job NO</td>
     <td align="left" width="16%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;" value='<s:property value="docnoss"/>'></td>
      <td align="right" width="10%">Ref NO</td>
     <td align="left" width="16%"><input type="text" name="refnossss" id="refnossss"  style="width:90%;" value='<s:property value="refnossss"/>'></td>
     <td align="right" width="10%">MOB NO</td>
     <td align="left" width="16%"><input type="text" name="mobnos" id="mobnos"  style="width:90%;" value='<s:property value="mobnos"/>'></td>
    <%--  <td align="right" width="6%">Date </td>
     <td align="left" width="17%"><div id="datess" name="datess"  value='<s:property value="datess"/>'></div></td>  --%> 
     </tr><tr>
     
     <td width="9%" align="right">Client</td>
     <td  colspan="3"><input type="text" name="client" id="client"  style="width:90%;" value='<s:property value="client"/>'></td>
     <td align="center" width="13%" ><input type="button" name="searchss" id="searchss" class="myButton" value="Search"  onclick="loadSearchss()"></td>
    </tr>
     
 </table>
</td>
<tr>
<td colspan="8" align="right"><div id="refsearch"><jsp:include  page="subrefnosearch.jsp"></jsp:include></div></td>
</tr>
</table>
</div>
</body>
</html>