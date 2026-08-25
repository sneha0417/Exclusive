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
	    $("#datess111").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs1() {  
 		
 		var docnoss=document.getElementById("docnosss").value;
 		var tenant=document.getElementById("tenant").value;
 		var pname=document.getElementById("pnames").value;
 		var datess=document.getElementById("datess111").value;
 
 		var refnoss=document.getElementById("searchunitno").value;
 		
 		
 		 
 		var descriptionss=0;
		
	var aa="yes";
		getdata(docnoss,tenant,pname,datess,aa,descriptionss,refnoss);
 

	}
	function getdata(docnoss,tenant,pname,datess,aa,descriptionss,refnoss){ 
		docnoss=encodeURIComponent(docnoss);
		tenant=encodeURIComponent(tenant);
		pname=encodeURIComponent(pname);
		datess=encodeURIComponent(datess);
		aa=encodeURIComponent(aa);
		descriptionss=encodeURIComponent(descriptionss);
		refnoss=encodeURIComponent(refnoss);
		var brhid=$('#brchName').val();
		 $("#refreshdivs111").load('subMastersearch.jsp?docnoss='+docnoss+'&tenant='+tenant+'&pname='+pname+'&datess='+datess+'&aa='+aa+'&descriptions='+descriptionss+'&refnoss='+refnoss+'&brhid='+brhid);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="100%"   >
   <tr>
    <td align="right" width="10%">Doc No</td> 
    <td align="left" width="10%"><input type="text" name="docnosss" id="docnosss"  style="width:90%;" value='<s:property value="docnosss"/>'></td>
    <td align="right" width="10%">Tenant</td>
    <td align="left"  width="30%"><input type="text" name="tenant" id="tenant" style="width:100%;"  value='<s:property value="tenant"/>'></td>
        
      
        
   <td align="left" width="10%" >Property 	</td>
    <td align="left"   width="30%"><input type="text" name="pnames" style="width:91%;" id="pnames" value='<s:property value="pnames"/>'></td>
 </tr>
     
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess111" name="datess111"  value='<s:property value="datess111"/>'></div></td>
    <td align="right">Unit No</td>
 	<td><input type="text" name="searchunitno"  id="searchunitno" value='<s:property value="searchunitno"/>'></td>
       
     <td  width="20%" colspan="2"> &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;<input type="button" name="searchs" id="searchs1" class="myButton" value="Search"  onclick="loadSearchs1()">
</td>
    
    <tr>
    </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
     <div id="refreshdivs111">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
    
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>