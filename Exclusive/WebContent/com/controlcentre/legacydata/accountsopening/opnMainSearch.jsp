 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
 
	<script type="text/javascript">

 	function loadSearch() {
 		var accountNo=document.getElementById("txtaccountno").value;
 		var accountName=document.getElementById("txtaccountname").value;
 		var total=document.getElementById("txttotal").value;
	
		getdata(accountNo,accountName,total);

	}
 	
	function getdata(accountNo,accountName,total){
		 $("#refreshdiv").load('opnMainSearchGrid.jsp?accountNo='+accountNo+'&accountName='+accountName.replace(/ /g, "%20")+'&total='+total);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="12%" align="right">A/c No</td>
    <td width="31%"><input type="text" name="txtaccountno" id="txtaccountno" autocomplete="off" value='<s:property value="txtaccountno"/>'></td>
    <td width="15%" align="right">Balance</td>
    <td><input type="text" name="txttotal" id="txttotal" value='<s:property value="txttotal"/>'></td>
    </tr>
    <tr>
    <td width="12%" align="right">A/c Name</td>
    <td colspan="2"><input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" style="width:80%;" value='<s:property value="txtaccountname"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
   <tr>
    <td colspan="4"><div id="refreshdiv"><jsp:include page="opnMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>