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
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var contact=document.getElementById("contact").value;

 	
 		
		getdata(sclname,smob,rno,contact);
 

	}
	  function getdata(sclname,smob,rno,contact){
		  
		
		 $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname.replace(/ /g, "%20")+'&smob='+smob+'&rno='+rno+'&contact='+contact.replace(/ /g, "%20"));
		 

		} 
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="">Name</td>
    <td align="left" width="53%"><input type="text" name="SCl_name" id="SCl_name"  style="width:96.5%;" value='<s:property value="SCl_name"/>'></td>
    <td align="right">MOB</td>
    <td align="left" width="47%"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
 
		
  <table >
  <tr>
 
     <td colspan="2" align="center">Doc NO</td>
    <td align="center" width=><input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
    
   <td width="50%"></td>
    <td align="right">Contact </td>
    
    <td align="left" width="50%"><input type="text" name="contact" id="contact" style="width:96.5%;" value='<s:property value="contact"/>'></td>
    
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="submainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>