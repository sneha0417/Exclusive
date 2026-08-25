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
	 $("#leaveTravelDisbursementsDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var empname=document.getElementById("txtempname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("leaveTravelDisbursementsDate").value;
 		var amount=document.getElementById("txtamount").value;
	
		getdata(empname,docNo,date,amount);
	}
	function getdata(empname,docNo,date,amount){
		 $("#refreshdiv").load('ltdMainSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="leaveTravelDisbursementsDate" name="leaveTravelDisbursementsDate"  value='<s:property value="leaveTravelDisbursementsDate"/>'></div></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtempname" id="txtempname" style="width:100%" value='<s:property value="txtempname"/>'></td>
    <td align="right">Amount</td>
    <td><input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="ltdMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>