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

 	function loadSearch() {
 		//alert("");
 		var clnames=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var clname = clnames.replace(' ', '%20');
		
	//alert(""+clname);
		getdata(clname,mob);
 

	}
	function getdata(clname,mob){
		
		 $("#refreshdiv1").load('searchClient.jsp?clname='+clname+'&mob='+mob);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td align="right">Name</td>
    <td align="left" width="70%"><input type="text" name="Cl_name" id="Cl_name"  style="width:96.5%;" value='<s:property value="Cl_name"/>'></td>
    <td align="right">MOB</td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
    <tr>
    </table>
    </td>
  </tr>
  
 

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdiv1">
      
   <jsp:include  page="searchClient.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>