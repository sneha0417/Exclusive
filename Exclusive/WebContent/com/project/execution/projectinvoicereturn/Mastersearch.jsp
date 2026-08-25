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
	  $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function invloadSearch1() {
 		
 		var invdate=document.getElementById("invdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var contno=document.getElementById("contno").value;
 		var invtype=document.getElementById("invtype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		
	getdata1(Cl_names,msdocno,contno,invdate,invtype);

	}
 	
	function getdata1(Cl_names,msdocno,contno,invdate,invtype){
		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&contno='+contno+'&invdate='+invdate+'&invtype='+invtype);
		
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
    <td align="right" >Client</td>
    <td align="left" width="55%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" width="12%" >Contract Type</td>
      <td align="left" width="35%"><select  name="invtype" id="invtype" style="width:80%;"  value='<s:property value="invtype"/>' >
  <option value="">----select----</option>
  <option value="AMC">AMC</option>
  <option value="SJOB">SJOB</option>
   </select></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="invdate" name="invdate"  value='<s:property value="invdate"/>'></div>
    <td width="10%" align="right" >Invoice No</td><td ><input type="text" name="contno" id="contno" value='<s:property value="contno"/>'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="invbtnrasearch" id="invbtnrasearch" class="myButton" value="Search"  onclick="invloadSearch1()"></td>
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