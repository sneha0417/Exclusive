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

 		var partyname=document.getElementById("txtclname").value;
 		var contactNo=document.getElementById("txtclmob").value;
 		var chk = 1;
 		
		getdata(partyname,contactNo,chk);
	}
	function getdata(partyname,contactNo,chk){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&contactNo='+contactNo+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
  <td width="7%" align="right" style="font-size:9px;">Name</td>
    <td width="36%"><input type="text" name="txtclname" id="txtclname" style="width:95%;height:20px;" value='<s:property value="txtclname"/>'></td>
    <td width="7%" align="right" style="font-size:9px;">MOB</td>
    <td width="20%"><input type="text" name="txtclmob" id="txtclmob" style="width:80%;height:20px;" value='<s:property value="txtclmob"/>'></td>  
    <td width="15%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td> 
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>