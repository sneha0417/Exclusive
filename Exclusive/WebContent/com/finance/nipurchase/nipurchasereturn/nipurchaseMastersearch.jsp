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
 		
 		var docnoss=document.getElementById("docnoss1").value;
 		var accountss=document.getElementById("accountss1").value;
 		var accnamesss=document.getElementById("accnamess1").value;
 		var datess=document.getElementById("datess1").value;
 		var reftypess=document.getElementById("reftypess1").value;
 		var desc=document.getElementById("description1").value;
 		var description=desc.replace(' ','%20');
 		var accnamess = accnamesss.replace(' ', '%20');
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description){
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa+'&description='+description);

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
    <td align="left" width="20%"><input type="text" name="docnoss1" id="docnoss1"  style="width:90%;" value='<s:property value="docnoss1"/>'></td>
    <td align="right" width="10%">Account</td>
    <td align="left"><input type="text" name="accountss1" id="accountss1" style="width:80%;"  value='<s:property value="accountss1"/>'></td>
    
   <td align="right"  width="14%">Account Name</td>
    <td align="left"  width="30%"><input type="text" name="accnamess1" style="width:90%;" id="accnamess1" value='<s:property value="accnamess1"/>'></td>
    
    <tr>
    
    </td>
  </tr>
  <tr>
  <td>
  <!-- <table width="100%"> -->
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess1" name="datess1"  value='<s:property value="datess1"/>'></div></td>

    <td align="right" width="10%">Description</td><td  width="20%"><input type="text" name="description1" style="width:90%;" id="description1" value='<s:property value="description1"/>'></td>
    
     <td  width="20%"><select hidden="true" name="reftypess1" id="reftypess1" style="width:58%;"  value='<s:property value="reftypess1"/>' >
  
   </select>
   
  	<input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()"></td>
    
    
 
    </tr>
    </table>
  </td>



  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="submasterSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>