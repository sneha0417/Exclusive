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
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
;
 		
 		var accnamess = accnamesss.replace(' ', '%20');

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,aa){
		
		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa);

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
    <td align="right" width="10%">Account</td>
    <td align="left"><input type="text" name="accountss" id="accountss" style="width:80%;"  value='<s:property value="accountss"/>'></td>
    
   <td align="right"  width="14%">Account Name</td>
    <td align="left"  width="30%"><input type="text" name="accnamess" style="width:90%;" id="accnamess" value='<s:property value="accnamess"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table width="100%">
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess" name="datess"  value='<s:property value="datess"/>'></div></td>
    <td align="right" width="10%">&nbsp;</td><td  width="20%"><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()">
</td>
   <td width="10%"></td>
   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   </td>
    <tr>
    </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="Subsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>