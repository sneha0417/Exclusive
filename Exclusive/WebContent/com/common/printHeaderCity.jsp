<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<table width="100%" class="normaltable"  style="margin-top:-25px;">
  <tr>
    <td rowspan="6"><img src="<%=contextPath%>/icons/city1header.jpg" width="800" height="91"  alt=""/></td>
  </tr>
  
</table></div>
<div  align="center">
<table > 
<tr>
    <td ><b><font size="5"><label id="lblprintname" name="lblprintname" align="center"><s:property value="lblprintname"/></label></font></b></td>
   <%--  <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td> --%>
  </tr>
  <tr>
    <td ><b><font size="2">TRN:<label id="lblbranchtrno" name="lblbranchtrno" align="center"><s:property value="lblbranchtrno"/></label></font></b></td>
  
  </tr>
  </table>
</div>
</form>
</div>

</body>
</html>
