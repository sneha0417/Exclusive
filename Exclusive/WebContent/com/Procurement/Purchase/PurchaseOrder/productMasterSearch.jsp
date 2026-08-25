 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
 <%
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
String accdocno=request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();


String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

 // System.out.println("===============dates===================="+dates);
 
// System.out.println("===============cmbbilltype===================="+cmbbilltype);
 

%>
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
		/* document.getElementById("txtcldocnos").value=$('#clientid').val();
		document.getElementById("txtestdates").value=$('#date').val();
		document.getElementById("txtgridscopeids").value=$('#txtgridscopeid').val();
		document.getElementById("txtgridscopeproducts").value=$('#txtgridscopeproduct').val(); */
	}); 

 	function loadSearch() {

 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("jqxBrandInput").value;
 		var cldocnos=0;/* document.getElementById("txtcldocnos").value; */
 		var estdates=0;/* document.getElementById("txtestdates").value; */
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		var gridscategory=document.getElementById("txtgridscategory").value;
		var gridssubcategory=document.getElementById("jqxSubCategoryInput").value;
 		var gridscopeid=0;/* document.getElementById("txtgridscopeids").value; */
 		var gridscopeproduct=0;/* document.getElementById("txtgridscopeproducts").value; */
 		
 		var reqmasterdocno='<%=reqmasterdocno%>';
 		var dtype='<%=dtype%>';
 		var accdocno='<%=accdocno%>';
 		var dates='<%=dates%>';
 		var cmbbilltype='<%=cmbbilltype%>';
		var id="1";
		getdata(reqmasterdocno,dtype,accdocno,dates,cmbbilltype,productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridscategory,gridssubcategory,gridscopeid,gridscopeproduct);
	}
	function getdata(reqmasterdocno,dtype,accdocno,dates,cmbbilltype,productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridscategory,gridssubcategory,gridscopeid,gridscopeproduct){
		
		$("#refreshProductDiv").load('productSearch.jsp?reqmasterdocno='+reqmasterdocno.replace(/ /g, "%20")+'&dtype='+dtype.replace(/ /g, "%20")+'&accdocno='+accdocno.replace(/ /g, "%20")+'&dates='+dates.replace(/ /g, "%20")+'&cmbbilltype='+cmbbilltype.replace(/ /g, "%20")+'&productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname.replace(/ /g, "%20")+"&gridunit="+gridunit+"&gridcategory="+gridscategory.replace(/ /g, "%20")+"&gridssubcategory="+gridssubcategory.replace(/ /g, "%20")+"&scopeid="+gridscopeid+"&scopeproduct="+gridscopeproduct);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right">Product</td> <!-- partno -->
    <td width="13%"><input type="text" name="txtproductsname" id="txtproductsname" style="width:90%" value='<s:property value="txtproductsname"/>'></td>
    <td width="11%" align="right">Product Name</td>
    <td width="30%"><input type="text" name="txtgridprdname" id="txtgridprdname" style="width:80%" value='<s:property value="txtgridprdname"/>'></td>
    <td width="12%" align="right">Brand</td>
    <td width="18%"><div id="brandDiv"><jsp:include page="brandInputSearch.jsp"></jsp:include></div>
    <input type="hidden" name="txtcldocnos" id="txtcldocnos" style="width:80%" value='<s:property value="txtcldocnos"/>'>
    <input type="hidden" name="txtestdates" id="txtestdates" style="width:80%" value='<s:property value="txtestdates"/>'>
    <input type="hidden" name="txtgridscopeids" id="txtgridscopeids" style="width:80%" value='<s:property value="txtgridscopeids"/>'>
    <input type="hidden" name="txtgridscopeproducts" id="txtgridscopeproducts" style="width:80%" value='<s:property value="txtgridscopeproducts"/>'></td>
    <td width="18%" rowspan="2" align="left"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Unit</td>
    <td><input type="text" name="txtgridunit" id="txtgridunit" style="width:80%" value='<s:property value="txtgridunit"/>'>
    <td align="right">Category</td>
    <td><input type="text" name="txtgridscategory" id="txtgridscategory" style="width:70%" value='<s:property value="txtgridscategory"/>'></td>
    <td align="right">Sub Category</td>
    <td><div id="subCategoryDiv"><jsp:include page="subCategoryInputSearch.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshProductDiv"><jsp:include  page="productSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>