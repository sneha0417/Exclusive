 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
 <% String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function () { 
	$("#jqxProductSearch").jqxGrid('clear');
});
	
	function loadProductSearch() {
		var name=document.getElementById("pname").value;
 		var pcode=document.getElementById("pcode").value;
 		var docnos=document.getElementById("docnos").value;
 		var names =name.replace(/ /g, "%20");
 		var aa="yes";
 		
 		getdata(names,pcode,docnos,aa);
	}
		
	function getdata(names,pcode,docnos,aa){
		 $("#refreshProductDetailsDiv").load('productSearchGrid.jsp?name='+names+'&pcode='+pcode+'&docnos='+docnos+'&load='+aa);
    }

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Doc No</td>
    <td width="15%"><input type="text" name="docnos" id="docnos"  style="height:20px;width:100%;" value='<s:property value="docnos"/>'></td>
    <td width="9%" align="right">Product Code</td>
    <td width="15%"><input type="text" name="pcode" id="pcode" style="height:20px;width:100%;" value='<s:property value="pcode"/>'></td>
    <td align="right" width="9%"><label class="branch22">Product Name</label></td>
	<td align="left" width="35%"><input type="text" name="pname" id="pname"  style="height:20px;width:100%;" value='<s:property value="pname"/>'></td>
    <td width="11%" align="center"><input type="button" name="btnProductSearch" id="btnProductSearch" class="myButton" value="Search"  onclick="loadProductSearch();"></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshProductDetailsDiv"><jsp:include page="productSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>