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
// 	$(document).ready(function () {
// 	  $("#enqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
// 	}); 

 	function enqloadSearch1() {
 		
 		var msdocno=document.getElementById("productid").value; 
 		
 		 var Cl_names=document.getElementById("name").value;
		
	getdata1(msdocno,Cl_names)


	}
	function getdata1(msdocno,Cl_names){
		

		
		 $("#refreshdivmas").load('adjustmentSearchGrid.jsp?productid='+msdocno+'&Cl_names='+name+'&check=1');
		
		}


	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right" style="font-size:9px;">ProductId</td>
    <td align="left" width="2%"><input type="text" name="productid" id="productid"  value='<s:property value="productid"/>'></td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td align="right" style="font-size:9px;">Name</td>
    <td align="left" width="70%" ><input type="text" name="name" id="name"  style="width:96.5%;" value='<s:property value="name"/>'></td>
     <td width="4%"  ></td><td>
   <input type="button" name="enqbtnrasearch" id="enqbtnrasearch" class="myButton" value="Search"  onclick="enqloadSearch1()"></td>
    
     </tr>
        
        
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="adjustmentSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>