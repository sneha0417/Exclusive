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

 		var groupname=document.getElementById("txtgroupname").value;
 		
 		
		getdata(partyname);
	}
	function getdata(partyname){
		 $("#zonediv").load('zoneDetailsSearchGrid.jsp?atype=AR&partyname='+groupname.replace(/ /g, "%20"));
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Group Code</td>
    <td colspan="2"><input type="text" name="txtgroupname" id="txtgroupname" style="width:100%;height:20px;" value='<s:property value="txtgroupname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  
  <tr>
    <td colspan="5"><div id="zonediv"><jsp:include page="zoneDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>