
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function() {
	});

	function loadSearch() {
		var property = document.getElementById("txtproperty1").value;
		var tenant = document.getElementById("txttenant1").value;

		getdata(property, tenant);
	}
	function getdata(property, tenant) {
		$("#refreshdiv").load(
				'requestSearchGrid.jsp?id=1&property='
						+ property.replace(/ /g, "%20") + '&tenant='
						+ tenant.replace(/ /g, "%20"));
	}
</script>
<body>
	<div id=search>
		<table width="100%">
			<tr>
				<td width="15%" align="right">Property</td>
				<td><input type="text" name="txtproperty1" id="txtproperty1"
					style="width: 50%" value='<s:property value="txtproperty"/>'></td>
				<td width="15%" align="right">Tenant</td>
				<td><input type="text" name="txttenant1" id="txttenant1"
					style="width: 50%" value='<s:property value="txttenant1"/>'></td>
				<td width="24%" align="center"><input type="button"
					name="btnsearch" id="btnsearch" class="myButton" value="Search"
					onclick="loadSearch();"></td>
			</tr>

			<tr>
				<td colspan="5">
					<div id="refreshdiv">
					
					<jsp:include page="requestSearchGrid.jsp"></jsp:include></div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>