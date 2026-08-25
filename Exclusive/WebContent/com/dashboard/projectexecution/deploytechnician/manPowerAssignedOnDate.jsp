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
<% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString().trim();
   String empdocno =request.getParameter("empdocno")==null?"0":request.getParameter("empdocno").toString().trim(); %>
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
		var date='<%=date%>';
		var empdocno='<%=empdocno%>';
		$("#manPowerAssignedOnDateGridDiv").load("manPowerAssignedOnDateGrid.jsp?date="+date+'&empdocno='+empdocno+'&check=1');
	}); 

</script>
<body>
<div id=search>
<table width="100%">
		<tr>
			 <td><div id="manPowerAssignedOnDateGridDiv"><jsp:include page="manPowerAssignedOnDateGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
  </div>
</body>
</html>