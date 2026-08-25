 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
		
		getdata(clname,mob);
	}
 	
	function getdata(clname,mob){
		 $("#refreshdiv1").load('clientDetailsSearchGrid.jsp?clname='+clname.replace(/ /g, "%20")+'&mob='+mob.replace(/ /g, "%20")+'&check=1');
	}

</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right"><label style="font:10px Tahoma;">Name</label></td>
    <td colspan="2"><input type="text" name="Cl_name" id="Cl_name"  style="width:60%;" value='<s:property value="Cl_name"/>'></td>
  </tr>
  <tr>
    <td align="right"><label style="font:10px Tahoma;">Mobile</label></td>
    <td width="64%"><input type="text" name="Cl_mob" id="Cl_mob" style="width:60%;" value='<s:property value="Cl_mob"/>'></td>
    <td width="31%" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshdiv1"><jsp:include  page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>