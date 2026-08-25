 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var name=document.getElementById("name").value;
 		var brand=document.getElementById("brand").value;
 		var cat=document.getElementById("cat").value;
 		var pcode=document.getElementById("pcode").value;
 		var subcat=document.getElementById("subcat").value;
 		
 		var names = name.replace(/ /g, "%20");
 		
 		getdata(names,brand,cat,pcode,subcat);
 

	}
	 function getdata(names,brand,cat,pcode,subcat){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('submainSearch.jsp?name='+names+'&brand='+brand+'&cat='+cat+'&pcode='+pcode+'&subcat='+subcat);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="95%" >
   <tr>
    <td align="left" width="11%">Product Name</td>
    <td align="left" width="31%"><input type="text" name="name" id="name"  style="width:100%;" value='<s:property value="name"/>'></td>
    <td width="14%" align="right"  >&nbsp;&nbsp;&nbsp;Product Code</td>
    <td align="left" width="44%"><input type="text" name="pcode" id="pcode" value='<s:property value="pcode"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
 <tr><td>
		
  <table >
  <tr>
 
<td align="left" width="6%">Brand</td>
    <td align="left" width=21%><input type="text" name="brand" id="brand" value='<s:property value="brand"/>'>
    <td width="1%"></td>
    <td width="8%" align="right">Category</td>
    
    <td align="left" width="20%"><input type="text" name="cat" id="cat" style="width:96.5%;" value='<s:property value="cat"/>'></td>
    <td width="14%" align="right">Sub Category</td>
    <td width="21%" align="left"><input type="text" id="subcat" name="subcat" value='<s:property value="subcat"/>'></td>
   
    
    
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="submainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>