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
 		
 		
 		
 		var Cl_clientsale1=document.getElementById("Cl_clientsale1").value.replace(/ /g, "%20");;
 		
	getdata1(Cl_names,msdocno,Cl_enqno,qotdate,qottype,Cl_mobnos,Cl_clientsale1);
 

	}
	function getdata1(Cl_names,msdocno,Cl_enqno,qotdate,qottype,Cl_mobnos,Cl_clientsale1){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&Cl_enqno='+Cl_enqno+'&qotdate='+qotdate+'&qottype='+qottype+"&Cl_mobnos="+Cl_mobnos+"&Cl_clientsale1="+Cl_clientsale1);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right">Docno</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >Name</td>
    <td align="left" width="70%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
      <td align="right" >MOB</td>
      <td align="left" width="28%"><input type="text" name="Cl_mobnos" id="Cl_mobnos" value='<s:property value="Cl_mobnos"/>'></td>
    
      <td align="left" width="28%"><input type="hidden" name="Cl_enqno" id="Cl_enqno" value='<s:property value="Cl_enqno"/>'></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="qotdate" name="qotdate"  value='<s:property value="qotdate"/>'></div>
    <td width="4%"  >Type</td><td colspan="3"><select  name="qottype" id="qottype" style="width:15%;"  value='<s:property value="qottype"/>' >
  <option value="">--select--</option>
  <option value="DIR">DIR</option>
  <option value="SOR">SOR</option>
   </select>&nbsp; Sales Person&nbsp;<input type="text" name="Cl_clientsale1" id="Cl_clientsale1"  style="width:42%;" value='<s:property value="Cl_clientsale1"/>'>&nbsp;
   <input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
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