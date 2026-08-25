<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
 
<script>

</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<table width="100%" class="normaltable">
  <tr>
    <td width="25%" rowspan="4"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="45%">&nbsp;</td>
    <td width="30%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
  <tr>
    <td colspan="3"></td>
  </tr>
</table>
</div>

</form>
</div>

</body>
</html>
