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
	  $("#enqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function enqloadSearch1() {
 		
 		var enqdate=document.getElementById("enqdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var Cl_mobno=document.getElementById("Cl_mobno").value;
 		var enqtype=document.getElementById("enqtype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		
	getdata1(Cl_names,msdocno,Cl_mobno,enqdate,enqtype);
 

	}
	function getdata1(Cl_names,msdocno,Cl_mobno,enqdate,enqtype){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&Cl_mobno='+Cl_mobno+'&enqdate='+enqdate+'&enqtype='+enqtype);
		
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
      <td align="left" width="28%"><input type="text" name="Cl_mobno" id="Cl_mobno" value='<s:property value="Cl_mobno"/>'></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="enqdate" name="enqdate"  value='<s:property value="enqdate"/>'></div>
    <td width="4%"  >Type</td><td ><select  name="enqtype" id="enqtype" style="width:30%;"  value='<s:property value="enqtype"/>' >
  <option value="">--select--</option>
  <option value="general">General</option>
  <option value="client">Client</option>
   </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="enqbtnrasearch" id="enqbtnrasearch" class="myButton" value="Search"  onclick="enqloadSearch1()"></td>
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