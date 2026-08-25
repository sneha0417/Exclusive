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
 		var chk = 1;
 		
		getdata(partyname,chk);
	}
	function getdata(partyname,chk){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" style="font-size:9px;" align="right">Name</td>
    <td width="73%"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;height:20px;" value='<s:property value="txtpartyname"/>'></td>
    <td width="21%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>