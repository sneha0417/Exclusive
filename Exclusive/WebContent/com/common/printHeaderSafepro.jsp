 <%@ taglib prefix="s" uri="/struts-tags" %>
 <%@page pageEncoding="utf-8" %>
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
  <table width="100%" border="0" style="font-family: Cambria, 'Hoefler Text', 'Liberation Serif', Times, 'Times New Roman', serif">
  <tr>
  <td  align="center"><h1><b>TAX INVOICE</b></h1></td>
  </tr>
  <tr><td align="center"><b>TRN :&nbsp;<label id="lbltrno" name="lbltrno"><s:property value="lbltrno"/></label></b></td></tr>

  <tr>
    <td colspan="3"><hr></td>
  </tr>
</table>
    
    <div style="background-color:white;"> 
  

    
    </div>

</form>
</div>

</body>
</html>
 