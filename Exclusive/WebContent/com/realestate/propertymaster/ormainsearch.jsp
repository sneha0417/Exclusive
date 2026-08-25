
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
<link href="<%=contextPath%>/css/body.css" media="screen"
	rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function() {
	});

	function loadSearch() {
		var powner = document.getElementById("txtprimaryowner1").value;
		var address = document.getElementById("txtaddrssss1").value;
		var vndmob = document.getElementById("txtmobile1").value;
		var vndemail = document.getElementById("txtemail1").value;
		getdata(powner, address, vndmob, vndemail);
	}
	function getdata(powner, address, vndmob, vndemail) {
		$("#refreshdiv").load(
				'oSubsearch.jsp?powner='
						+ powner.replace(/ /g, "%20") + '&address=' + address
						+ '&vndmob=' + vndmob + '&vndemail=' + vndemail+'&id=1');
	}
</script>
<body>
	<div id=search>
		<table width="100%">
			<tr>
				<td width="15%" align="right">Primary Owner</td>
				<td colspan="4"><input type="text" name="txtprimaryowner1"
					id="txtprimaryowner1" style="width: 80%"
					value='<s:property value="txtprimaryowner1"/>'></td>
				<td width="24%" align="center"><input type="button"
					name="btnsearch" id="btnsearch" class="myButton" value="Search"
					onclick="loadSearch();"></td>
			</tr>
			<tr>
				<td align="right">Address</td>
				<td width="21%"><input type="text" name="txtaddrssss1"
					id="txtaddrssss1" value='<s:property value="txtaddrssss1"/>'></td>
				<td width="7%" align="right">Mob No.</td>
				<td width="36%"><input type="text" name="txtmobile1"
					id="txtmobile1" value='<s:property value="txtmobile"/>'></td>
				<td width="6%" align="right">email</td>
				<td><input type="text" name="txtemail1" id="txtemail1"
					value='<s:property value="txtemail1"/>'></td>
			</tr>
			<tr>
				<td colspan="6">
					<div id="refreshdiv">
 						 <jsp:include page="oSubsearch.jsp"></jsp:include>  
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>