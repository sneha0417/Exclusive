 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#cregdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var clientsname=document.getElementById("txtclientsname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("cregdate").value;
 		var contractstype=document.getElementById("cmbcontractstype").value;
 		var contractsno=document.getElementById("txtcontractsno").value;
 		
		getdata(clientsname,docNo,date,contractstype,contractsno);
	}
	function getdata(clientsname,docNo,date,contractstype,contractsno){
		 $("#refreshdiv").load('cregMainSearchGrid.jsp?clientsname='+clientsname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&regno='+contractsno+'&calltype='+contractstype);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="43%"><div id="cregdate" name="cregdate"  value='<s:property value="cregdate"/>'></div></td>
    <td width="9%" align="right">Doc No</td>
    <td colspan="2" width="20%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="txtclientsname" id="txtclientsname" style="width:100%;" value='<s:property value="txtclientsname"/>'></td>
    <td align="right">Call. Type</td>
    <td><select id="cmbcontractstype" name="cmbcontractstype" style="width:71%;" value='<s:property value="cmbcontractstype"/>'>
      <option value=''>-- Select --</option><option value='1'>Break Down</option><option value='2'>Accident</option>
      <option value='3'>Registration</option><option value='4'>Traffic Inbounding</option><option value='5'>New Enquiry</option>
      <option value='6'>Offhire</option><option value='7'>Other</option></select></td>
      <td width="7%" align="right">Reg No.</td>
    <td width="17%"><input type="text" id="txtcontractsno" name="txtcontractsno" value='<s:property value="txtcontractsno"/>'/></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="cregMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>