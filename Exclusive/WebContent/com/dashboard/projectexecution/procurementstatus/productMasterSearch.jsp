 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function loadSearch() {

 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("txtbrandsname").value;
 		var cldocnos=document.getElementById("txtcldocnos").value;
 		var estdates=document.getElementById("txtestdates").value;
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		
		var id="1";
		getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit);
	}
	function getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit){
		 $("#refreshProductDiv").load('productSearch.jsp?productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname+"&gridunit="+gridunit);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="12%" align="right"><label style="font:10px Tahoma;">Product-Id</label></td> <!-- partno -->
    <td colspan="3"><input type="text" name="txtproductsname" id="txtproductsname" style="width:90%" value='<s:property value="txtproductsname"/>'></td>
    <td width="11%" align="right"><label style="font:10px Tahoma;">Brand</label></td>
    <td colspan="2"><input type="text" name="txtbrandsname" id="txtbrandsname" style="width:90%" value='<s:property value="txtbrandsname"/>'>
    <input type="hidden" name="txtcldocnos" id="txtcldocnos" style="width:80%" value='<s:property value="txtcldocnos"/>'>
    <input type="hidden" name="txtestdates" id="txtestdates" style="width:80%" value='<s:property value="txtestdates"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  
  <tr>
  		<td width="18%" align="right"><label style="font:10px Tahoma;">Product Name</label></td>
    	<td colspan="3"><input type="text" name="txtgridprdname" id="txtgridprdname" style="width:90%" value='<s:property value="txtgridprdname"/>'></td>
    	<td width="11%" align="right"><label style="font:10px Tahoma;">Unit</label></td>
    	<td colspan="2"><input type="text" name="txtgridunit" id="txtgridunit" style="width:90%" value='<s:property value="txtgridunit"/>'>
    
  </tr>
  
  <tr>
    <td colspan="8"><div id="refreshProductDiv"><jsp:include  page="productSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>