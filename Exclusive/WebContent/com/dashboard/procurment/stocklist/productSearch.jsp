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
<style>
 

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		 
		   
	});   
		   
  	function loadSearchss() { // docnoss prdid prdname
 		
 		var docnoss=document.getElementById("docnoss").value;
 		 
 		var prdid=document.getElementById("prdid").value;
 		var prdname=document.getElementById("prdname").value;
 		
 		 

		
	var aa="yes";
		getdatas(docnoss,prdid,prdname,aa);
 

	}
	function getdatas(docnoss,prdid,prdname,aa){
		
		 
			 $("#refsearch").load('productssubsearch.jsp?docnoss='+docnoss+'&prdid='+prdid+'&prdname='+prdname+'&aa='+aa);
		

		}  
	
	
 
	

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
 
    </td>
  </tr>
  <tr>
  <td>
    
  <table width="100%" >   
  
        <tr> 
       
<%--             <td align="right" width="6%"><label  style="font-size: 10px;" > Doc No</label></</td>
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;height:20px;" value='<s:property value="docnoss"/>'></td> --%>
          <td align="right" width="6%"><label style="font-size: 10px;" > Product</label> </td>
    <td align="left" width="20%"><input type="text" name="prdid" id="prdid"  style="width:90%;height:20px;" value='<s:property value="prdid"/>'></td>  
         <td align="right" width="15%"><label style="font-size: 10px;"> Product Name</label></td>
    <td align="left" width="35%"><input type="text" name="prdname" id="prdname"  style="width:90%;height:20px;" value='<s:property value="prdname"/>'></td>
     
     <td align="right" width="22%" ><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchss()">
     
</td>

 

    </tr> 
    
    </table>
 

    
    <input type="hidden" name="docnoss" id="docnoss"  style="width:90%;height:20px;" value='<s:property value="docnoss"/>'>
    
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refsearch">
      
   <jsp:include  page="productssubsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>