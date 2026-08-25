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

<form>
 <div style="background-color:white;">
<table width="100%" class="normaltable" >
  <tr>
    <td width="25%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="34%" rowspan="2">&nbsp;</td>
    <td colspan="2"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td colspan="2"><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><font size="4" style="font-weight: bold; text-align: center;">Tax Invoice</font></td>
    <td width="26%" align="left" style="font-size: x-small"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
    <td width="15%" align="right" style="text-align: right; font-size: x-small;"><strong><span dir="RTL">الهاتف:</span></strong></td>
  </tr>
  <tr>
    <td align="left"><b style="font-size: x-small">Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
    <td align="right" style="text-align: right; font-size: x-small;"><strong><span dir="RTL">فاكس:</span></strong></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><span dir="RTL"><font size="4" style="font-weight: bold; text-align: center;">فاتورة الضريبة</font></span></td>
    <td align="left" style="font-size: x-small"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
    <td align="right" style="text-align: right; font-size: x-small;"><strong><span dir="RTL">ألفرع:</span></strong></td>
  </tr>
  <tr>
    <td align="left"><b style="font-size: x-small">Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" style="font-size: x-small;"><s:property value="lbllocation"/></label></td>
    <td align="right" style="text-align: right; font-size: x-small;"><strong><span dir="RTL">المنطقة:</span></strong></td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
    <td align="left" style="font-size: x-small"><b>TRN :<label id="lblcomptrn" name="lblcomptrn" style="font-size: x-small"><s:property value="lblcomptrn"/></label></b></td>
    <td align="right" style="text-align: right; font-size: x-small;"><strong><span dir="RTL">رقم تسجيل الضريبة:</span></strong></td>
  </tr>
  <tr>
    <td colspan="4"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="4"></td></tr></table>
</div>

</form>
</div>

</body>
</html>
