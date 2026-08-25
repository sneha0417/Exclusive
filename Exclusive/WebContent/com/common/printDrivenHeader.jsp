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
<table width="100%" class="normaltable">
  <tr>
    <td width="18%" rowspan="4"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="53%">&nbsp;</td>
    <td  width="21%"><font size="2"><b><label id="lblcompname" name="lblcompname"><s:property value="lblcompname"/></label></b></font></td>
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
    <td align="left"><b>GST No. :</b>&nbsp;<label id="lblcstno" name="lblcstno" ><s:property value="lblcstno"/></label></td>
  </tr>
  <tr>
    <td colspan="2"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation"><s:property value="lbllocation"/></label></td>
    <td align="left"><b>PAN No. :</b>&nbsp;<label id="lblpan" name="lblpan" ><s:property value="lblpan"/></label></td>
  </tr>
  <tr>
    <td colspan="2"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></td>
    <td align="left"></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>
</div>    

</form>
</div>

</body>
</html>
