 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(document).ready(function () {
/* 		 if(document.getElementById("txtforsearch").value=="2"){
		   document.getElementById("txtatypes").value=document.getElementById("cmbtype").value;
		}
		else if(document.getElementById("txtforsearch").value=="3"){
			   document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;
		}else{
			document.getElementById("txtatypes").value=document.getElementById("cmbtotype").value;
		}
		 document.getElementById("txtdocumenttypes").value=document.getElementById("formdetailcode").value;
		 document.getElementById("txtcreditdebit").value=document.getElementById("txtforsearch").value; */
		 document.getElementById("txtnewdate").value=$('#masterdate').val();
	}); 
	
	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			/* var accounttype=document.getElementById("txtatypes").value;
			var code=document.getElementById("txtdocumenttypes").value;
			var debitcredit=document.getElementById("txtcreditdebit").value; */
			var date=document.getElementById("txtnewdate").value;
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,date,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,date,checked){
		 $("#refreshClientAccountDiv").load("accountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&date='+date+'&check='+checked);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="34%"><input type="text" name="accountsno" id="accountsno" style="width:85%;" value='<s:property value="accountsno"/>'></td>
    <td width="9%" align="right">Currency</td>
    <td width="14%"><input type="text" name="txtcurrencies" id="txtcurrencies" style="width:83%;" value='<s:property value="txtcurrencies"/>'>
    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'></td>
    <td width="8%" align="right">Mobile</td>
    <td width="25%"><input type="text" name="clientmobileno" id="clientmobileno" style="width:85%;" value='<s:property value="clientmobileno"/>'>
    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="4"><input type="text" name="accountsname" id="accountsname" style="width:85%;" value='<s:property value="accountsname"/>'></td>
    <td align="center"><input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search"  onclick="loadClientAccountSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshClientAccountDiv"><jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>