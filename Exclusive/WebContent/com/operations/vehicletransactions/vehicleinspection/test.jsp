<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
</head>

<body>
<table width="100%" >
  <tr>
    <td width="37%" height="104"><fieldset>
          <legend>Existing</legend>
          <div id="existingdiv">
           <jsp:include page="existingGrid.jsp"></jsp:include> 
          </div>
        </fieldset></td>
    <td width="38%"><fieldset>
          <legend>New</legend>
          <div id="newdiv">
            <jsp:include page="newgrid.jsp"></jsp:include>
          </div>
        </fieldset></td>
    <td width="25%" rowspan="3"><fieldset style="height=100%;width=100%;">
    <img id="prevImage" src="<%=contextPath%>/icons/gatewaybg.png" alt="Image" height="100%" width="100%"/>
    </fieldset></td>
  </tr>
  <tr>
    <td height="17" colspan="2" align="right">Chargeable Amount
          <input type="text" name="amount" id="amount" value='<s:property value="amount"/>'>
        </td>
  </tr>
  <tr>
    <td height="25" colspan="2"><fieldset>
      <legend>Accidents</legend>
      <table width="100%">
        <tr>
          <td width="2%" height="26" align="right">Date</td>
          <td width="6%" align="left"><div id="accdate" name="accdate"  value='<s:property value="accdate"/>'></div></td>
          <input type="hidden" name="hidaccdate" id="hidaccdate"  value='<s:property value="hidaccdate"/>'>
          <td width="6%" align="right">Police Report</td>
          <td width="8%" align="left"><input type="text" name="prcs" id="prcs"  value='<s:property value="prcs"/>'></td>
          <td width="6%" align="right">Collection Date</td>
          <td width="7%" align="left"><div id="collectdate" name="collectdate"  value='<s:property value="collectdate"/>'></div></td>
          <input type="hidden" name="hidcollectdate" id="hidcollectdate"  value='<s:property value="hidcollectdate"/>'>
          <td width="3%" align="right">Place</td>
          <td width="9%" align="left"><input type="text" name="accplace" id="accplace"  value='<s:property value="accplace"/>'></td>
          <td width="3%" align="right">Fines</td>
          <td width="10%" align="left"><input type="text" name="accfines" id="accfines"  value='<s:property value="accfines"/>' onblur="checkAccidents();"></td>
          <td width="3%" align="right">Claim</td>
          <td width="8%"><select name="cmbclaim" id="cmbclaim">
            <option value="">--Select--</option><option value=1>Own</option><option value=0>Third Party</option>
            </select></td>
          <td width="4%" align="right">Remarks</td>
          <td width="25%" align="left"><input type="text" name="accremarks" id="accremarks" value='<s:property value="accremarks"/>' style="width:100%;" onblur="funFocusGrid();"></td>
          <input type="hidden" name="hidcmbclaim" id="hidcmbclaim"  value='<s:property value="hidcmbclaim"/>'>
          </tr> 
        </table>
      </fieldset></td>
  </tr>
</table>
</body>
</html>
