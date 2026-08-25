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

 		var clientName=document.getElementById("txtpartyname").value;
 		var clientId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var check = 1;
 		
		getdata(clientName,clientId,contactNo,check);
	}
	function getdata(clientName,clientId,contactNo,check){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?clientname='+clientName.replace(/ /g, "%20")+'&clientid='+clientId+'&contactno='+contactNo+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;" value='<s:property value="txtpartyname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right">ID#</td>
    <td width="26%"><input type="text" name="txtpartyid" id="txtpartyid" style="width:70%;" value='<s:property value="txtpartyid"/>'></td>
    <td width="18%" align="right">Contact No.</td>
    <td width="49%"><input type="text" name="txtcontactno" id="txtcontactno" style="width:50%;" value='<s:property value="txtcontactno"/>'></td>   
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>