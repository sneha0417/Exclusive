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
	 	$("#srvedate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var clientsname=document.getElementById("txtclientsname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("srvedate").value;
 		var contractstype=document.getElementById("cmbcontractstype").value;
 		var contractsno=document.getElementById("txtcontractsno").value;
 		var schedulesno=document.getElementById("txtschedulesno").value;
 		
		getdata(clientsname,docNo,date,contractstype,contractsno,schedulesno);
	}
	function getdata(clientsname,docNo,date,contractstype,contractsno,schedulesno){
		 $("#refreshdiv").load('srveMainSearchGrid.jsp?clientsname='+clientsname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&contractstype='+contractstype+'&contractsno='+contractsno+'&schedulesno='+schedulesno);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="19%"><div id="srvedate" name="srvedate"  value='<s:property value="srvedate"/>'></div></td>
    <td width="18%" align="right">Doc No</td>
    <td width="19%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="11%" align="right">Schedule No</td>
    <td width="13%"><input type="text" name="txtschedulesno" id="txtschedulesno" style="width:90%;" value='<s:property value="txtschedulesno"/>'></td>
    <td width="14%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Customer</td>
    <td colspan="2"><input type="text" name="txtclientsname" id="txtclientsname" style="width:100%;" value='<s:property value="txtclientsname"/>'></td>
    <td align="right">Cont. Type</td>
    <td><select id="cmbcontractstype" name="cmbcontractstype" style="width:90%;" value='<s:property value="cmbcontractstype"/>'>
      <option value=''>-- Select --</option><option value='AMC'>AMC</option><option value='SJOB'>SJOB</option><option value='CREG'>Ticket No</option></select></td>
    <td align="right">Contract</td>
    <td><input type="text" id="txtcontractsno" name="txtcontractsno" style="width:90%;" value='<s:property value="txtcontractsno"/>'/></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include page="srveMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>