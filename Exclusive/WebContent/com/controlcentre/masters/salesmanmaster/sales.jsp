
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<sj:head/>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<%@include file="../../../../header.jsp" %><br/>
<fieldset><legend>Sales Service Details</legend>
<table width="100%" >
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="68%">&nbsp;</td>
    <td width="10%"><div align="right">Doc No</div></td>
    <td width="14%"><div id="mainBG2" class="homeContent" data-type="background">
      <input type="text" name="docno">
    </div></td>
  </tr>
  <tr>
    <td><div align="right">Date</div></td>
    <td><sj:datepicker value="today" id="date1" name="date1" displayFormat="dd.mm.yy" label="Today" />
      <div align="left"></div></td>
    <td>&nbsp;</td>
    <td></td>
  </tr>
  <tr>
    <td><div align="right">Service Type</div></td>
    <td colspan="3"><span class="homeContent">
      <select name="type">
        <option>--Select--</option>
      </select>
    </span></td>
  </tr>
  <tr>
    <td><div align="right">Company</div></td>
    <td colspan="3"><span class="homeContent">
      <input type="text" name="company" style="width:35%;">
    </span></td>
  </tr>
  <tr>
    <td><div align="right">Account</div></td>
    <td colspan="3"><select name="account">
      <option>--Select--</option>
    </select>
      <input type="text" name="accname" style="width:29%;"></td>
  </tr>
  <tr>
    <td><div align="right">Remarks</div></td>
    <td colspan="3"><textarea name="remarks" cols="37.5%"></textarea></td>
  </tr>
</table>
</fieldset>
</div>
</body>
</html>