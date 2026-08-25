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
	    $("#datess11").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs1() {  
 		
 		var docnoss=document.getElementById("docnosss").value;
 		var accountss=document.getElementById("owner").value.replace(' ', '%20');
 		var accnamesss=document.getElementById("pname").value;
 		var datess=document.getElementById("datess11").value;
 
 		var refnoss=0;
 		
 		
 		var accnamess = accnamesss.replace(' ', '%20');
 		var descriptionss=document.getElementById("descriptionss1").value.replace(/ +(?= )/g,'');
		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa,descriptionss,refnoss);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,aa,descriptionss,refnoss){
		
		 $("#refreshdivs11").load('psubsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa+'&descriptions='+descriptionss+'&refnoss='+refnoss);

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
    <td align="left" width="20%"><input type="text" name="docnosss" id="docnosss"  style="width:90%;" value='<s:property value="docnosss"/>'></td>
    <td align="right" width="10%">Owner</td>
    <td align="left"  width="20%"><input type="text" name="owner" id="owner" style="width:100%;"  value='<s:property value="owner"/>'></td>
    
   <td align="right"  width="14%">Property Name	</td>
    <td align="left" colspan="2" width="30%"><input type="text" name="pname" style="width:91%;" id="pname" value='<s:property value="pname"/>'></td>
    
    <tr>
     
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess11" name="datess11"  value='<s:property value="datess11"/>'></div></td>
    
   <%--   <td align="right"  >Mobile</td>
    <td align="left"   ><input type="text" name="refnoss" style="width:100%;" id="refnoss" value='<s:property value="refnoss"/>'></td> --%>
    
      <td align="right" width="10%">Remarks</td><td  width="30%" colspan="4"><input type="text" name="descriptionss1" style="width:90%;" id="descriptionss1" value='<s:property value="descriptionss1"/>'></td>
     <td  width="20%"><input type="button" name="searchs" id="searchs1" class="myButton" value="Search"  onclick="loadSearchs1()">
</td>
    
    <tr>
    </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
     <div id="refreshdivs11">
      
   <jsp:include  page="psubsearch.jsp"></jsp:include> 
    
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>