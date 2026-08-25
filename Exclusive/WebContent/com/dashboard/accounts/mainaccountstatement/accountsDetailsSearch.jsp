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
	$(document).ready(function () {
 		document.getElementById("txtatype").value=$('#cmbtype').val();
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var atype=document.getElementById("txtatype").value;
 		var chk = 1;
 		
		getdata(atype,partyname,accNo,chk);
	}
 	
	function getdata(atype,partyname,accNo,chk){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?atype='+atype+'&partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Account</td>
    <td width="18%"><input type="text" name="txtaccountno" id="txtaccountno" style="width:90%;height:20px;" value='<s:property value="txtaccountno"/>'>
    <input type="hidden" name="txtatype" id="txtatype" style="height:20px;" value='<s:property value="txtatype"/>'></td>
    <td width="4%" align="right" style="font-size:9px;">Name</td>
    <td width="53%"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;height:20px;" value='<s:property value="txtpartyname"/>'></td>
    <td width="19%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="accountsDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>