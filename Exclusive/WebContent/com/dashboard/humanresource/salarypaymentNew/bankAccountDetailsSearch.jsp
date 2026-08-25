 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadBankSearch() {

 		var bankaccount=document.getElementById("txtbankaccountsno").value;
 		var bankaccountname=document.getElementById("txtbankaccountsname").value;
 		
		getbankdata(bankaccount,bankaccountname);
	}
	function getbankdata(bankaccount,bankaccountname){
		 $("#refreshbankdiv").load('bankAccountDetailsSearchGrid.jsp?bankaccountname='+bankaccountname.replace(/ /g, "%20")+'&bankaccount='+bankaccount+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Account</td>
    <td width="57%"><input type="text" name="txtbankaccountsno" id="txtbankaccountsno" style="width:50%;height:20px;" value='<s:property value="txtbankaccountsno"/>'></td>
    <td width="33%" align="center"><input type="button" name="btnbanksearch" id="btnbanksearch" class="myButton" value="Search"  onclick="loadBankSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtbankaccountsname" id="txtbankaccountsname" style="width:70%;height:20px;" value='<s:property value="txtbankaccountsname"/>'></td>
  </tr>
  <tr>
     <td colspan="3"><div id="refreshbankdiv"><jsp:include page="bankAccountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>