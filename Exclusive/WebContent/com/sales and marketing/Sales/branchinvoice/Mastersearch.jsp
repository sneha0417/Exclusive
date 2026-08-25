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
	  $("#qotdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		var qotdate=document.getElementById("qotdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var Cl_enqno=document.getElementById("Cl_enqno").value;
 		var qottype=document.getElementById("qottype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(/ /g, "%20");
 		var Cl_mobnos=document.getElementById("Cl_mobnos").value; 
		
 		var Cl_salper=document.getElementById("Cl_salper").value.replace(/ /g, "%20");
 		
	getdata1(Cl_names,msdocno,Cl_enqno,qotdate,qottype,Cl_mobnos,Cl_salper);
 

	}
	function getdata1(Cl_names,msdocno,Cl_enqno,qotdate,qottype,Cl_mobnos,Cl_salper){
		
		var trans=$("#cmbmodeofpay").val();
		var tranid=0;
		if(trans=='cash'){
		
			tranid=1;
		}
		else if(trans=='credit'){
		
			tranid=2;
		}
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&Cl_enqno='+Cl_enqno+'&qotdate='+qotdate+'&qottype='+qottype+'&tranid='+tranid+"&Cl_mobnos="+Cl_mobnos+"&Cl_salper="+Cl_salper);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"  >
  <tr>
   <td>                         
   <table width="100%"  >
   <tr>
   <td align="right"  width="8%">Doc No</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" width="3%" >Name</td>
    <td align="left" width="40%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
      <td align="right"  width="8%" >Sales Person</td>
      <td align="left" width="20%"><input type="text" name="Cl_salper" id="Cl_salper" value='<s:property value="Cl_salper"/>'>
      
      <input type="hidden" name="Cl_enqno" id="Cl_enqno" value='<s:property value="Cl_enqno"/>'>
      </td>
      </tr>
        <tr>
        <td align="right">Date </td>
    <td align="left" ><div id="qotdate" name="qotdate"  value='<s:property value="qotdate"/>'></div>
    <td width="4%"  align="right"></td><td ><select hidden="true"  name="qottype" id="qottype" style="width:30%;"  value='<s:property value="qottype"/>' >
  <option value="">--select--</option>
  <option value="DIR">DIR</option>
  <option value="SOR">SOR</option>
  <option value="DEL">DEL</option>
   </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MOB&nbsp;<input type="text" name="Cl_mobnos" id="Cl_mobnos" value='<s:property value="Cl_mobnos"/>'>
  &nbsp;&nbsp;&nbsp;&nbsp; <input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
  
  <td>&nbsp;</td>   
  <td>&nbsp;</td>
    <tr>
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