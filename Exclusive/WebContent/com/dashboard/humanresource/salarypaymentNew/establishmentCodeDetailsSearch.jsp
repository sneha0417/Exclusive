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

 	function loadEstablishmentsCodeSearch() {

 		var establishmentscode=document.getElementById("txtestablishmentscode").value;
 		
		getestablishmentscodedata(establishmentscode);
	}
	function getestablishmentscodedata(establishmentscode){
		 $("#refreshestablishmentcodediv").load('establishmentCodeDetailsSearchGrid.jsp?establishmentscode='+establishmentscode.replace(/ /g, "%20")+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right" style="font-size:9px;">Est.Code</td>
    <td width="63%"><input type="text" name="txtestablishmentscode" id="txtestablishmentscode" style="width:80%;height:20px;" value='<s:property value="txtestablishmentscode"/>'></td>
    <td width="29%" align="center"><input type="button" name="btnestablishmentscodesearch" id="btnestablishmentscodesearch" class="myButton" value="Search"  onclick="loadEstablishmentsCodeSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshestablishmentcodediv"><jsp:include page="establishmentCodeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>