 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
   <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>    --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	 /* $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); */
	}); 

 	function loadgrpSearch() {
		var grpnames=document.getElementById("assgrp_name").value;
 		// var mob=document.getElementById("Cl_mob").value;
 		var grpname = grpnames.replace(' ', '%20');
		 
 	getdata(grpname);
 

	}
	function getdata(grpname){
		
		var id=1;
		//$("#assigndiv").load('assignGroupGrid.jsp?clname='+clname+'&mob='+mob+'&id='+id);
		$("#assigndiv").load('assignGroupGrid.jsp?id='+id+'&grpname='+grpname);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
   <tr >
   <td>
   <table>
   <tr>
    <td align="right"><label class="branch">Group Name</label></td>
    <td align="left" width="70%"><input type="text" name="assgrp_name" id="assgrp_name"  style="width:96.5%;" value='<s:property value="assgrp_name"/>'></td>
   <%--  <td align="right">MOB</td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
     --%>
     <td width="30%" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadgrpSearch();"></td>
    </tr>
    </table>
    </td>
  </tr>
  

  <tr>
    <td colspan="8" align="right">
    
    <div id="assigndiv">
      
   <jsp:include  page="assignGroupGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>