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
		document.getElementById("txtproductsname").focus();
		document.getElementById("txtcldocnos").value=$('#clientid').val();
		document.getElementById("txtestdates").value=$('#todate').val();
		document.getElementById("txtgridqotservicetypeids").value=$('#txtgridqotservicetypeid').val();
		document.getElementById("txtgridqotscopeids").value=$('#txtgridqotscopeid').val();
	}); 

 	function loadSearch() {

 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("txtbrandsname").value;
 		var cldocnos=document.getElementById("txtcldocnos").value;
 		var estdates=document.getElementById("txtestdates").value;
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		var gridservicetypeid=document.getElementById("txtgridqotservicetypeids").value;
 		var gridscopeid=document.getElementById("txtgridqotscopeids").value;
		
		var id="1";
		getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridservicetypeid,gridscopeid);
	}
	function getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridservicetypeid,gridscopeid){
		 $("#refreshProductDivqot").load('productSearchqot.jsp?productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname.replace(/ /g, "%20")+"&gridunit="+gridunit+"&stypeid="+gridservicetypeid+"&scopeid="+gridscopeid);
		}

	</script>
<body>
<div id=search>
<table width="55%">
  <tr>
    <td width="6%" align="right"><label style="font:10px Tahoma;">Product</label></td> <!-- partno -->
    <td colspan="3"><input type="text" name="txtproductsname" id="txtproductsname" style="width:80%;height:20px;" value='<s:property value="txtproductsname"/>'></td>
    <td width="12%" align="right"><label style="font:10px Tahoma;">Brand</label></td>
    <td colspan="2"><input type="text" name="txtbrandsname" id="txtbrandsname" style="width:80%;height:20px;" value='<s:property value="txtbrandsname"/>'>
    <input type="hidden" name="txtcldocnos" id="txtcldocnos" style="width:80%;height:20px;" value='<s:property value="txtcldocnos"/>'>
    <input type="hidden" name="txtestdates" id="txtestdates" style="width:80%;height:20px;" value='<s:property value="txtestdates"/>'>
    <input type="hidden" name="txtgridqotservicetypeids" id="txtgridqotservicetypeids" style="width:80%;height:20px;" value='<s:property value="txtgridqotservicetypeids"/>'>
    <input type="hidden" name="txtgridqotscopeids" id="txtgridqotscopeids" style="width:80%;height:20px;" value='<s:property value="txtgridqotscopeids"/>'></td>
    <td width="17%" rowspan="2" align="left"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  
  <tr>
  		<td width="6%" align="right"><label style="font:10px Tahoma;">Product Name</label></td>
    	<td colspan="3"><input type="text" name="txtgridprdname" id="txtgridprdname" style="width:80%;height:20px;" value='<s:property value="txtgridprdname"/>'></td>
    	<td width="12%" align="right"><label style="font:10px Tahoma;">Unit</label></td>
    	<td colspan="2"><input type="text" name="txtgridunit" id="txtgridunit" style="width:80%;height:20px;" value='<s:property value="txtgridunit"/>'>
    
  </tr>
  
  <tr>
    <td colspan="8"><div id="refreshProductDivqot"><jsp:include  page="productSearchqot.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>