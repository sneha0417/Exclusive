 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    $("#datess1").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
	});   
		   
 	function loadSearchs() {
 		var docnoss=document.getElementById("docnoss").value;
 		var typess=document.getElementById("cmbtypess").value.replace(' ', '%20');
 		var clientnamess=document.getElementById("clientnamess").value.replace(' ', '%20');;
 		var datess=document.getElementById("datess1").value;
 		var productss=document.getElementById("productss").value.replace(' ', '%20');;
 		var notess=document.getElementById("notess").value.replace(/ +(?= )/g,'');
		var aa="yes";
		getdata(docnoss,typess,clientnamess,datess,aa,notess,productss);
 

	}
	function getdata(docnoss,typess,clientnamess,datess,aa,notess,productss){
		 $("#refreshdivs").load('Subsearch.jsp?docno='+docnoss+'&type='+typess+'&clientname='+clientnamess+'&date='+datess+'&aa='+aa+'&note='+notess+'&product='+productss);
	}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
 <tr >
 <td>
  <table width="100%" >
   <tr>
    <td align="right" width="6%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;" value='<s:property value="docnoss"/>'></td>
    <td align="right" width="10%">Type</td>
    <td align="left"  width="20%"><select  id="cmbtypess"  name="cmbtypess" style="width:100%;" > 
     <option value="">--Select--</option>
    <option value="S">Sales</option>   
     <option value="P">Purchase</option>
    </select></td>
   	<td align="right"  width="14%">Client Name</td>
    <td align="left" colspan="2" width="30%"><input type="text" name="clientnamess" style="width:91%;" id="clientnamess" value='<s:property value="clientnamess"/>'></td>
   <tr>
   <tr> 
    <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess1" name="datess1"  value='<s:property value="datess1"/>'></div></td>
    <td align="right">Product</td>
    <td align="left"><input type="text" name="productss" style="width:100%;" id="productss" value='<s:property value="productss"/>'></td>
	<td align="right" width="10%">Note</td><td  width="30%" colspan="4"><input type="text" name="notess" style="width:90%;" id="notess" value='<s:property value="notess"/>'></td>
    <td  width="20%"><input type="button" name="btnSearch" id="btnSearch" class="myButton" value="Search"  onclick="loadSearchs()"></td>
   <tr>
  </table>
 </td>
 </tr>
<tr>
 <td colspan="8" align="right">
 	<div id="refreshdivs"><jsp:include  page="Subsearch.jsp"></jsp:include></div>
 </td>
</tr>
</table>
</div>
</body>
</html>