<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<%@ page pageEncoding="utf-8" %>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<% String contextPath=request.getContextPath();%>
	<title>GatewayERP(i)</title>
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
</head>

<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form>
 <div style="background-color:white;">

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 20px">
  <tr>
    <td height="6" colspan="9" align="center" style="height: 3mm;">
    <b><label id="lblcompname1" name="lblcompname1" ><s:property value="lblcompname1"/>EPIC RENT A CAR OWNED BY FARDAN HASSAN ALFARDAN - SOLE PROPRIETORSHIP LLC</label></b></font></td>
  </tr>
  
  <tr>
    <td colspan="9" align="center" style="height: 3mm;"><label style="font-size: 11px;" id="lblcompaddress1" name="lblcompaddress1"><s:property value="lblcompaddress1"/>PO BOX 112768, ABU DHABI AL MAQTA BUILDING 1 / OWNER MOHAMMED SAQAR SAADON AL FAHALI / OTHERS-SHOP NO. 2, UAE</label></td>
  </tr>
  <tr>
  	<td width="13%" rowspan="4"><img src="<%=contextPath%>/icons/epic.jpg" width="134" height="89"  alt=""/></td>
     <td colspan="8" align="left" style="font-size: 10.5px;">
    	Tel  :&nbsp;
    		<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label>
        &nbsp;/  Fax  :&nbsp;
        	<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label>
        &nbsp;/  Branch  :&nbsp;
        	<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label>
        &nbsp;/  Location  :&nbsp;
        	<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label>
    </td>
  </tr>
  
  <tr>
    <td colspan="8" align="left"><b style="margin-left: 120px; font-size: 13px;">TRN :&ensp;<label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></b></td>
  </tr>
  
  <tr>
  	<td width="16%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
  </tr>
  
  <tr>
    <td colspan="8" ><b style="margin-left: 130px"><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
  </tr>
</table>
<hr noshade size=1 width="100%">
</div>
</form>
</div>

</body>
</html>
