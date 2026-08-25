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

 	function loadSearch1() {
 		
 		 
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var docno=document.getElementById("docnoss").value;
 		
 		
 		var clmobs=document.getElementById("clmobs").value;
 	
 		var Cl_names = Cl_namess.replace(/ /g, "%20");
 		var Cl_salper=document.getElementById("Cl_salper").value.replace(/ /g, "%20");
 		
	getdata1(Cl_names,docno,clmobs,Cl_salper);
 

	}
	function getdata1(Cl_names,docno,clmobs,Cl_salper){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&docno='+docno+"&clmobs="+clmobs+"&Cl_salper="+Cl_salper);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
    <td align="right" width="10%">Doc No</td>
    <td align="left" width="2%"><input type="text" name="docnoss" id="docnoss"  value='<s:property value="docnoss"/>'></td>
    <td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name</td>
    <td align="left" width="70%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
    </tr>
    <tr>
       <td align="right" width="10%">MOB</td>
           <td align="left" width="2%"><input type="text" name="clmobs" id="clmobs"  value='<s:property value="clmobs"/>'></td>
       
    <td align="left" width="28%" colspan="2">Sales Person&nbsp;
      <input type="text" name="Cl_salper" id="Cl_salper" style="width:50%;" value='<s:property value="Cl_salper"/>'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch1()"></td>
   </tr>
      
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>