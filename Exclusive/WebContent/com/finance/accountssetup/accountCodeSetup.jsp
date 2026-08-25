<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<%@ taglib prefix="s" uri="/struts-tags"%>
 <s:head/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		$("#date1").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
	});
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<%@include file="../../../header.jsp" %><br/>
<fieldset><legend>Account Code Setup Info</legend>
<table width="100%" >
  <tr>
    <td width="11%"><div align="right">Date</div></td>
    <td width="48%"><div id="date1" name="date1" value='<s:property value="date1"/>'></div></td>
    <td width="15%"><div align="right">Doc No</div></td>
    <td width="13%"><span class="homeContent">
      <input type="text" name="docno">
    </span></td>
    <td width="3%"><div align="right"><span class="homeContent">
      <input type="checkbox" name="chk1" value="all">
    </span></div></td>
    <td width="10%">All</td>
  </tr>
</table>
</fieldset>
</div>
</body>
</html>
