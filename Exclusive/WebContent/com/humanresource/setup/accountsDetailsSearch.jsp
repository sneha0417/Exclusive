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
	$(document).ready(function () {}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var check = 1;
			
			getAccountDetails(accountsno,accountsname,check);
	}
		
	function getAccountDetails(accountsno,accountsname,check){
		 $("#refreshAccountDetailsDiv").load("../accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="13%" align="right">Account No.</td>
    <td width="60%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="width:65%;" value='<s:property value="txtaccountsno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="2"><input type="text" name="txtaccountsname" id="txtaccountsname" style="width:75%;" value='<s:property value="txtaccountsname"/>'></td>
  </tr>
   <tr>
    <td colspan="3"><div id="refreshAccountDetailsDiv"><jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</div>
</body>
</html>