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

	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno3").value;
			var accountsname=document.getElementById("txtaccountsname3").value;
			var currs=document.getElementById("txtaccountcurrency3").value;
		
			var check ="intrestacc";
	
			getAccountDetails(accountsno,accountsname,currs,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,check){
		 $("#bankdiv").load("bankaccSubgrid.jsp?accountno="+accountsno+'&accountname='+accountsname+'&currency='+currs+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%"><input type="text" name="txtaccountsno3" id="txtaccountsno3" style="width:85%;" value='<s:property value="txtaccountsno3"/>'></td>
    <td width="10%" align="right">Currency</td>
    <td width="27%"><input type="text" name="txtaccountcurrency3" id="txtaccountcurrency3" style="width:50%;" value='<s:property value="txtaccountcurrency3"/>'>
 <%--    <input type="hidden" name="txtdoctypes" id="txtdoctypes" value='<s:property value="txtdoctypes"/>'>
     <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'> --%></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtaccountsname3" id="txtaccountsname3" style="width:80%;" value='<s:property value="txtaccountsname3"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="bankdiv"><jsp:include page="bankaccSubgrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>