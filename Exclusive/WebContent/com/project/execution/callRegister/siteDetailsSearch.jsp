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

 	function loadSiteSearch() {

 		var site=document.getElementById("txtsitesname").value;
 		var contract=document.getElementById("txtcontracttrno").value;
 		var check = 1;
 		
		getdata(site,contract,check);
	}
	function getdata(site,contract,check){
		 $("#refreshsitediv").load('siteDetailsSearchGrid.jsp?site='+site.replace(/ /g, "%20")+'&contract='+contract+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right">Site</td>
    <td width="72%"><input type="text" name="txtsitesname" id="txtsitesname" style="width:80%;" value='<s:property value="txtsitesname"/>'></td>
    <td width="23%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSiteSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshsitediv"><jsp:include page="siteDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>