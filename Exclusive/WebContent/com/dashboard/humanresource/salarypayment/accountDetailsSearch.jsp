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

 	function loadSearch() {

 		var account=document.getElementById("txtaccountsno").value;
 		var accountname=document.getElementById("txtaccountsname").value;
 		
		getdata(account,accountname);
	}
	function getdata(account,accountname){
		 $("#refreshdiv").load('accountDetailsSearchGrid.jsp?accountname='+accountname.replace(/ /g, "%20")+'&account='+account+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Account</td>
    <td width="57%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="width:50%;height:20px;" value='<s:property value="txtaccountsno"/>'></td>
    <td width="33%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtaccountsname" id="txtaccountsname" style="width:70%;height:20px;" value='<s:property value="txtaccountsname"/>'></td>
  </tr>
  <tr>
     <td colspan="3"><div id="refreshdiv"><jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>