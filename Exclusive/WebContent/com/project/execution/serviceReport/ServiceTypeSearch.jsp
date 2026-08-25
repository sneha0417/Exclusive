 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadServicesSearchGrid() {
			var services=document.getElementById("txtservicesdetails").value;
			var items=document.getElementById("txtitemsdetails").value;
			var contractno=document.getElementById("txtcontracttrno").value;
			
			var dtype=document.getElementById("hidcmbcontracttype").value;
			
			var check = 1;
	
			getServicesDetails(services,items,contractno,check,dtype);
	}
		
	function getServicesDetails(services,items,contractno,check,dtype) {
		 $("#ServiceTypeDiv").load("ServiceTypeSearchGrid.jsp?services="+services.replace(/ /g, "%20")+'&items='+items.replace(/ /g, "%20")+'&contractno='+contractno+'&check='+check+'&dtype='+dtype);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="15%" align="right">Services</td>
    <td width="35%"><input type="text" name="txtservicesdetails" id="txtservicesdetails" style="width:90%;" value='<s:property value="txtservicesdetails"/>'></td>
    <td width="5%" align="right">Items</td>
    <td width="29%"><input type="text" name="txtitemsdetails" id="txtitemsdetails" style="width:90%;" value='<s:property value="txtitemsdetails"/>'></td>
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadServicesSearchGrid();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="ServiceTypeDiv"><jsp:include page="ServiceTypeSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>