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

 	function invloadSearch1() {
 		
 
 		var Cl_namess=document.getElementById("Cl_names").value;
 		var contno=document.getElementById("contno").value;
 		var invtype=document.getElementById("invtype").value;
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		
	getdata1(Cl_names,contno,invtype);
 

	}
	function getdata1(Cl_names,contno,invtype){
		
		 $("#refreshdivmas").load('contractsubMastersearch.jsp?Cl_names='+Cl_names+'&contno='+contno+'&invtype='+invtype);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right"><label style="font:10px Tahoma;">Contract No</label></td>
    <td align="left" width="2%" ><input type="text" name="contno" id="contno" style="height:120%;" value='<s:property value="contno"/>'></td>
    <td align="right" ><label style="font:10px Tahoma;">Client</label></td>
    <td align="left" width="30%" ><input type="text" name="Cl_names" id="Cl_names" style="height:120%;width:95%;"  value='<s:property value="Cl_names"/>'></td>
    <td align="right"  ><label style="font:10px Tahoma;">Contract Type</label></td>
      <td align="left"  ><select  name="invtype" id="invtype" style="width:80%;" style="height:120%;"  value='<s:property value="invtype"/>' >
  <option value="">----select----</option>
  <option value="AMC">AMC</option>
  <option value="SJOB">SJOB</option>
   </select></td>
   <td><input type="button" name="invbtnrasearch" id="invbtnrasearch" class="myButton" value="Search"  onclick="invloadSearch1()"></td>
      </tr>
     <!--  
       <tr>
        <td><input type="button" name="invbtnrasearch" id="invbtnrasearch" class="myButton" value="Search"  onclick="invloadSearch1()"></td>
    </tr>
       -->
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="contractsubMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>