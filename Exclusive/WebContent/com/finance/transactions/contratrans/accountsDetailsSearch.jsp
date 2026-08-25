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
		document.getElementById("txtfromtypes").value=document.getElementById("cmbtype").value;
		document.getElementById("txttotypes").value=document.getElementById("cmbtotype").value;
		document.getElementById("txtfromto").value=document.getElementById("txtfromorto").value;
		document.getElementById("txtnewdates").value=$('#maindate').val();
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var currs=document.getElementById("txtaccountcurrency").value;
			var fromto=document.getElementById("txtfromto").value;
			var dates=document.getElementById("txtnewdates").value;
			var check = 1;
			var type = "";
			
			if(fromto=="2"){
				type=document.getElementById("txtfromtypes").value;
			}
			else if(fromto=="3"){
				type=document.getElementById("txttotypes").value;
			}
	
			getAccountDetails(accountsno,accountsname,currs,fromto,type,dates,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,fromto,type,dates,check){
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&type='+type+'&fromto='+fromto+'&dates='+dates+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="width:85%;" value='<s:property value="txtaccountsno"/>'></td>
    <td width="10%" align="right">Currency</td>
    <td width="27%"><input type="text" name="txtaccountcurrency" id="txtaccountcurrency" style="width:50%;" value='<s:property value="txtaccountcurrency"/>'>
    <input type="hidden" name="txtfromtypes" id="txtfromtypes" value='<s:property value="txtfromtypes"/>'>
    <input type="hidden" name="txttotypes" id="txttotypes" value='<s:property value="txttotypes"/>'>
    <input type="hidden" name="txtfromto" id="txtfromto" value='<s:property value="txtfromto"/>'>
    <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtaccountsname" id="txtaccountsname" style="width:80%;" value='<s:property value="txtaccountsname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshAccountDetailsDiv"><jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>