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

<script type="text/javascript">
	$(document).ready(function () {}); 

 	function mainloadSearch() {
 		
 		var empnames=document.getElementById("empnames").value;
 		var empids=document.getElementById("empids").value;
 		var docnoss=document.getElementById("docnoss").value;
 		var mobnos=document.getElementById("mobnos").value;	
 		var empns = empnames.replace(/ /g, "%20");

 		getdata(empns,empids,docnoss,mobnos);
	}
 	
	function getdata(empns,empids,docnoss,mobnos){
		 $("#srefreshdiv").load('submainSearch.jsp?empns='+empns+'&empids='+empids+'&docnoss='+docnoss+'&mobnos='+mobnos);
	}
 
</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td>
    <table width="100%">
    <tr>
    <td align="right" width="10%">Name</td> 
    <td align="left" colspan="3"><input type="text" name="empnames" id="empnames"  style="width:99%;" value='<s:property value="empnames"/>'></td>
    <td align="right"  width="7%">Emp ID</td>
    <td align="left" width="27%"><input type="text" name="empids" id="empids" value='<s:property value="empids"/>'></td>
    <tr>
  <tr>
    <td  align="right" width="10%">Doc No</td>
    <td width="24%" align="left"  ><input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
    <td width="10%"   align="right">Mobile</td>
    <td width="12%"  ><input type="text" name="mobnos" id="mobnos" value='<s:property value="mobnos"/>'></td>
    <td  >&nbsp;</td>
    <td align="left"  ><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>
  <tr>
    <td colspan="8" align="right"><div id="srefreshdiv"><jsp:include  page="submainSearch.jsp"></jsp:include> </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>