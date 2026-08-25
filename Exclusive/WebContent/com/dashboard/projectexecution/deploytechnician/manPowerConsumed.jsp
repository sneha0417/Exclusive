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
<% String costtype =request.getParameter("costtype")==null?"0":request.getParameter("costtype").toString().trim();
   String costcode =request.getParameter("costcode")==null?"0":request.getParameter("costcode").toString().trim(); %>
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
		var costtype='<%=costtype%>';
		var costcode='<%=costcode%>';
		$("#manPowerConsumedGridDiv").load("manPowerConsumedGrid.jsp?costtype="+costtype+'&costcode='+costcode+'&check=1');
	}); 

</script>
<body>
<div id=search>
<table width="100%">
		<tr>
			 <td><div id="manPowerConsumedGridDiv"><jsp:include page="manPowerConsumedGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
  </div>
</body>
</html>