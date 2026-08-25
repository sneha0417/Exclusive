<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>        
</head>
<sj:head/>

<body>
<div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../header.jsp"></jsp:include><br/>
<div style="width:70%;">
    <fieldset>
    <legend>Cost Centre Master</legend>
<table width="100%">
  <tr>
    <td width="15%"><div align="right">Date</div></td>
    <td colspan="2"><sj:datepicker value="today" id="costCenterDate" name="costCenterDate" displayFormat="dd.mm.yy" label="Today" /></td>
    <td width="18%"><div align="right">Doc No.</div></td>
    <td width="17%"><input type="text" name="docno" style="width:80%" readonly></td>
  </tr>
  <tr>
    <td><div align="right">Cost Group</div></td>
    <td width="16%"><select name="cost_group">
      <option>--Select--</option>
    </select></td>
    <td colspan="3"><input type="text" name="cost_group_name" style="width:50%"></td>
    </tr>
  <tr>
    <td><div align="right">Cost Division</div></td>
    <td><select name="cost_division">
      <option>--Select--</option>
    </select></td>
    <td colspan="3"><input type="text" name="cost_division_name" style="width:50%"></td>
    </tr>
  <tr>
    <td><div align="right">Cost Centre</div></td>
    <td><select name="cost_centre">
      <option>--Select--</option>
    </select></td>
    <td colspan="3"><input type="text" name="cost_centre_name" style="width:50%"></td>
    </tr>
  <tr>
    <td><div align="right">Type</div></td>
    <td colspan="2"><select name="type">
      <option>--Select--</option>
    </select></td>
    <td><div align="right">CE Relation</div></td>
    <td><select name="ce_relation">
      <option>--Select--</option>
    </select></td>
  </tr>
</table>
</fieldset>
</div>
</div>
</body>
</html>