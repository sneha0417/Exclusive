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
	  $("#pjivinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function pjivloadSearch1() {
 		
 		var pjivinvdate=document.getElementById("pjivinvdate").value;
 		 var pjivCl_namess=document.getElementById("pjivCl_names").value;
 		var pjivcontno=document.getElementById("pjivcontno").value;
 		var pjivinvtype=document.getElementById("pjivinvtype").value;
 		var pjivmsdocno=document.getElementById("pjivmsdocno").value; 
 		var pjivCl_names = pjivCl_namess.replace(' ', '%20');
 		
	getdata1(pjivCl_names,pjivmsdocno,pjivcontno,pjivinvdate,pjivinvtype);

	}
 	
	function getdata1(pjivCl_names,pjivmsdocno,pjivcontno,pjivinvdate,pjivinvtype){
		
		 $("#refreshpjivdiv").load('pjivSubMastersearch.jsp?pjivCl_names='+pjivCl_names+'&pjivmsdocno='+pjivmsdocno+'&pjivcontno='+pjivcontno+'&pjivinvdate='+pjivinvdate+'&pjivinvtype='+pjivinvtype);
		
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
    <td align="left" width="2%"><input type="text" name="pjivmsdocno" id="pjivmsdocno"  value='<s:property value="pjivmsdocno"/>'></td>
    <td align="right" >Client</td>
    <td align="left" width="55%" ><input type="text" name="pjivCl_names" id="pjivCl_names"  style="width:96.5%;" value='<s:property value="pjivCl_names"/>'></td>
    <td align="right" width="12%" >Contract Type</td>
      <td align="left" width="35%"><select  name="pjivinvtype" id="pjivinvtype" style="width:80%;"  value='<s:property value="pjivinvtype"/>' >
  <option value="">----select----</option>
  <option value="AMC">AMC</option>
  <option value="SJOB">SJOB</option>
   </select></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="pjivinvdate" name="pjivinvdate"  value='<s:property value="pjivinvdate"/>'></div>
    <td width="10%" align="right" >Contract No</td><td ><input type="text" name="pjivcontno" id="pjivcontno" value='<s:property value="pjivcontno"/>'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="invbtnrasearch" id="invbtnrasearch" class="myButton" value="Search"  onclick="pjivloadSearch1()"></td>
    </tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshpjivdiv">
      
   <jsp:include  page="pjivSubMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>