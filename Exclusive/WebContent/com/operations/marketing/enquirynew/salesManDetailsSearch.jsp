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
	
 	function loadSearch() {
 		var slnames=document.getElementById("sal_name").value;
 		var mob=document.getElementById("sl_mob").value;
 		var slname = slnames.replace(' ', '%20');
		
		getdatas(slname,mob);
	}
 	
	function getdatas(slname,mob){
		var id=1;
		$("#refreshdiv2").load('salesManDetailsSearchGrid.jsp?slname='+slname+'&mob='+mob+'&id='+id);
	}

</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
  <td><table width="100%">
	    <tr>
	    <td width="3%" align="right"><label style="font:10px Tahoma;">Name</label></td>
	    <td align="left" width="49%"><input type="text" name="sal_name" id="sal_name"  style="width:90%;" value='<s:property value="sal_name"/>'></td>
	    <td width="7%" align="right"><label style="font:10px Tahoma;">MOB</label></td>
	    <td width="22%" align="left"><input type="text" name="sl_mob" id="sl_mob" style="width:90%;" value='<s:property value="sl_mob"/>'></td>
	    <td width="19%" colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
	    <tr>
   </table></td>
   </tr>
  <tr>
    <td><div id="refreshdiv2"><jsp:include  page="salesManDetailsSearchGrid.jsp"></jsp:include> </div></td>
  </tr>
</table>
</div>
</body>
</html>