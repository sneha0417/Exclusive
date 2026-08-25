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

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var check=1;
 		
		getdata(partyname,accNo,check);
	}
	function getdata(partyname,accNo,check){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Account</td>
    <td colspan="2"><input type="text" name="txtaccountno" id="txtaccountno" style="width:70%;height:22px;" value='<s:property value="txtaccountno"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right" style="font-size:9px;">Name</td>
    <td width="93%" colspan="3"><input type="text" name="txtpartyname" id="txtpartyname" style="width:65%;height:22px;" value='<s:property value="txtpartyname"/>'></td>   
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="accountsDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>