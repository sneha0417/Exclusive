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
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>

.branch22 {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}


</style>

<%String frm = request.getParameter("frm")==null?"0":request.getParameter("frm");  %> 


	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		var name=document.getElementById("pname").value;
 		var brand=document.getElementById("brand").value;
 		var cat=document.getElementById("cat").value;
 		var pcode=document.getElementById("pcode").value;
 		var subcat=document.getElementById("subcat").value;
 		var docnos=document.getElementById("docnos").value;
 		var names =name.replace(/ /g, "%20");
 		var aa="yes";
 		 
 		var frm='<%=frm%>';
 		
 		getdata(names,brand,cat,pcode,subcat,docnos,aa,frm);
	}
	 function getdata(names,brand,cat,pcode,subcat,docnos,aa,frm){
		 $("#srefreshdiv").load('<%=contextPath%>/com/productsearch/subSearch.jsp?name='+names+'&brand='+brand+'&cat='+cat+'&pcode='+pcode+'&subcat='+subcat+'&docnos='+docnos+'&load='+aa+'&frm='+frm);
        		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"   >
  <tr >
 
   <td align="right" width="8%" ><label class="branch22">Doc No</label></td>   
    <td align="left" width="21%"><input type="text" name="docnos" id="docnos"  style="height:20px;width:100%;" value='<s:property value="docnos"/>'></td>
     <td width="10%" align="right"  ><label class="branch22">Product Code</label></td>
    <td align="left" width="20%"><input type="text" name="pcode" id="pcode" style="height:20px;width:100%;" value='<s:property value="pcode"/>'></td>
    
    <td align="right" width="11%"><label class="branch22">Product Name</label></td>
    <td align="left" width="31%" colspan="2"><input type="text" name="pname" id="pname"  style="height:20px;width:100%;" value='<s:property value="pname"/>'></td>
   
    </tr>
     
  <tr>
 
<td align="right" width="6%"><label class="branch22">Brand</label></td>
    <td align="left" width=21%><input type="text" name="brand" id="brand" style="height:20px;width:100%;" value='<s:property value="brand"/>'>
     
    <td width="10%" align="right"><label class="branch22">Category</label></td>
    
    <td align="left" width="11%"><input type="text" name="cat" id="cat" style="height:20px;width:96.5%;" value='<s:property value="cat"/>'></td>
    <td width="11%" align="right"><label class="branch22">Sub Category</label></td>
    <td width="21%" align="left"><input type="text" id="subcat" name="subcat" style="height:20px;width:100%;" value='<s:property value="subcat"/>'></td>
   
    
    
    <td  align="center"> <input type="button" style="height:20px;" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
   
     
    
    <div id="srefreshdiv">
      
   <jsp:include  page="subSearch.jsp"></jsp:include> 
   
   </div>
 
  </div>
</body>
</html>