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
		 //document.getElementById("txtdoctypes").value=document.getElementById("formdetailcode").value;
		// document.getElementById("txtsearchtype").value=document.getElementById("txtforsearch").value;
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno1").value;
			var accountsname=document.getElementById("txtaccountsname1").value;
			//var currs=document.getElementById("txtaccountcurrency1").value;
		//	var formcode=document.getElementById("txtdoctypes").value;
		//	var searchtype=document.getElementById("txtsearchtype").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,check);
	}
		
	function getAccountDetails(accountsno,accountsname,check){
		 $("#findiv").load("rcpaccsubsearch.jsp?accountno="+accountsno+'&accountname='+accountsname+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%" >
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="12%"><input type="text" name="txtaccountsno1" id="txtaccountsno1" style="width:85%;" value='<s:property value="txtaccountsno1"/>'></td>
   <td align="left" width="68%"colspan="2">Account Name&nbsp;<input type="text" name="txtaccountsname1" id="txtaccountsname1" style="width:70%;" value='<s:property value="txtaccountsname1"/>'></td>
    
    <td width="10%"  align="center"><input type="button" name="btnAccountSearch1" id="btnAccountSearch1" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
<%--   <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtaccountsname1" id="txtaccountsname1" style="width:80%;" value='<s:property value="txtaccountsname1"/>'></td>
  </tr> --%>
  <tr>
    <td colspan="5"><div id="findiv"><jsp:include page="rcpaccsubsearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>