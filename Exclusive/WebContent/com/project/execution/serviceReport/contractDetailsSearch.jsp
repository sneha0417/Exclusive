 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath(); %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

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

<% String docnoss=request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
	
<script type="text/javascript">

	$(document).ready(function () {});   
		   
  	function loadContractSearch() {
 		
  		var contracttype=document.getElementById("cmbcontracttype").value;
  		var customerdocno=document.getElementById("txtcustomerdocno").value;
  		var schedlno=document.getElementById("txtschedlno").value;
 		var contractno=document.getElementById("txtcontractnos").value;
 		var sites=document.getElementById("txtsites").value;
 		var branch=document.getElementById("brchName").value;
 		
		getdatas(contracttype,customerdocno,schedlno,contractno,sites,branch);
	}
  	
	function getdatas(contracttype,customerdocno,schedlno,contractno,sites,branch){

		$("#refContractSearchDiv").load("contractDetailsSearchGrid.jsp?search=yes&contracttype="+contracttype+"&customerdocno="+customerdocno+"&schedlno="+schedlno+"&contractno="+contractno+"&sites="+sites.replace(/ /g, "%20")+"&branch="+branch+"&chk=1");
		 
	}  
	
</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Schedule No</td>
    <td width="42%"><input type="text" name="txtschedlno" id="txtschedlno"  style="width:90%;" value='<s:property value="txtschedlno"/>'></td>
    <td width="16%" align="right">Contract No</td>
    <td width="34%"><input type="text" name="txtcontractnos" id="txtcontractnos"  style="width:90%;" value='<s:property value="txtcontractnos"/>'></td>
  </tr>
  <tr>
    <td align="right">Site</td>
    <td colspan="2"><input type="text" name="txtsites" id="txtsites"  style="width:85%;" value='<s:property value="txtsites"/>'></td>
    <td align="center"><input type="button" name="searchss" id="searchss" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
  </tr>
  <tr>
    <td colspan="4"><div id="refContractSearchDiv"><jsp:include  page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>