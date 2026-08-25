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
 		var brand=document.getElementById("brand").value;
 		var cat=document.getElementById("cat").value;
 		var pcode=document.getElementById("pcode").value;
 		var subcat=document.getElementById("subcat").value;
 		var docnos=document.getElementById("docnos").value;
 		var names =name.replace(/ /g, "%20");
 		var aa="yes";
 		
 		getdata(names,brand,cat,pcode,subcat,docnos,aa);
	}
		
	function getdata(names,brand,cat,pcode,subcat,docnos,aa){
		 $("#refreshProductDetailsDiv").load('productSearchGrid.jsp?name='+names+'&brand='+brand+'&cat='+cat+'&pcode='+pcode+'&subcat='+subcat+'&docnos='+docnos+'&load='+aa);
    }

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
   
   <input type="hidden" name="docnos" id="docnos"  style="height:20px;width:100%;" value='<s:property value="docnos"/>'> 
    <td width="10%" align="right">Product Code</td>
    <td width="20%"><input type="text" name="pcode" id="pcode" style="height:20px;width:100%;" value='<s:property value="pcode"/>'></td>
    <td align="right" width="11%"><label class="branch22">Product Name</label></td>
	<td align="left" width="31%" colspan="1"><input type="text" name="pname" id="pname"  style="height:20px;width:100%;" value='<s:property value="pname"/>'></td>
	<td align="center"><input type="button" name="btnProductSearch" id="btnProductSearch" class="myButton" value="Search"  onclick="loadProductSearch();"></td>
    
  </tr>
  <tr hidden="true">
    <td align="right">Brand</td>
    <td><input type="text" name="brand" id="brand" style="height:20px;width:100%;" value='<s:property value="brand"/>'></td>
    <td align="right">Category</td>
    <td><input type="text" name="cat" id="cat" style="height:20px;width:96.5%;" value='<s:property value="cat"/>'></td>
    <td align="right">Sub Category</td>
    <td><input type="text" id="subcat" name="subcat" style="height:20px;width:100%;" value='<s:property value="subcat"/>'></td>
    
  </tr>
  <tr>
    <td colspan="7"><div id="refreshProductDetailsDiv"><jsp:include page="productSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>