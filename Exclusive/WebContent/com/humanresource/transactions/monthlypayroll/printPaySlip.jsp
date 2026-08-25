<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>

<style type="text/css">
fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;	
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }
</style>

</head>
<body>
<s:iterator value='#request.PAYSLIP' var="#aa" status="arr">
<form id="frmPaySlipViewer" action="printPaySlipViewer" method="post" autocomplete="off">
<input type="hidden" id="lblallowancecount" name="lblallowancecount" value='<s:property value="lblallowancecount"/>'>
<s:set name="allowancecount" value="lblallowancecount"></s:set>
<table width="100%">
  <tr>
    <td width="75%" height="48"><b><font size="5" face="Helvetica"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></b></td>
    <td width="25%" rowspan="3" align="right"><img src="<%=contextPath%>/icons/epic.jpg" width="150" height="91"  alt=""/></td>
  </tr>
  <tr>
    <td><b><font size="3" face="Helvetica"><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label>&nbsp;- Tel :</font></b>&nbsp;<font size="2" face="Helvetica"><label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></font>&nbsp;<b><font size="3" face="Helvetica">- Fax :</font></b>&nbsp;<font size="2" face="Helvetica"><label name="lblcompfax" id="lblcompfax"><s:property value="lblcompfax"/></label></font></td>
  </tr>
  <tr>
    <td><b><font size="3" face="Helvetica">Branch :</font></b>&nbsp;<font size="2" face="Helvetica"><label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></font>&nbsp;<b><font size="3" face="Helvetica">- Location :</font></b>&nbsp;<font size="2" face="Helvetica"><label id="lbllocation" name="lbllocation"><s:property value="lbllocation"/></label></font></td>
  </tr>
  <tr>
    <td colspan="2"><hr noshade size=1 width="100%"></td>
  </tr>
  <tr>
  	<td colspan="2" align="center"><b><font size="3" face="Helvetica"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
  </tr>
</table><br/>

<fieldset>
<table width="100%">
  <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
    <td width="17%" align="left"><font size="3" face="Helvetica">Employee ID</font></td>
    <td width="23%" align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblemployeeid" name="lblemployeeid"><s:property value="lblemployeeid"/></label></font></td>
    <td width="20%" align="left">&nbsp;<font size="3" face="Helvetica">Employer Name</font></td>
    <td width="40%" align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblemployeename" name="lblemployeename"><s:property value="lblemployeename"/></label></font></td>
  </tr>
  <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
    <td align="left"><font size="3" face="Helvetica">Date of Joining</font></td>
    <td align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblempdateofjoining" name="lblempdateofjoining"><s:property value="lblempdateofjoining"/></label></font></td>
    <td align="left">&nbsp;<font size="3" face="Helvetica">Department</font></td>
    <td align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblempdepartment" name="lblempdepartment"><s:property value="lblempdepartment"/></label></font></td>
  </tr>
  <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
    <td align="left"><font size="3" face="Helvetica">Days worked</font></td>
    <td align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblempdaysworked" name="lblempdaysworked"><s:property value="lblempdaysworked"/></label></font></td>
    <td align="left">&nbsp;<font size="3" face="Helvetica">Designation</font></td>
    <td align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblempdesignation" name="lblempdesignation"><s:property value="lblempdesignation"/></label></font></td>
  </tr>
</table></fieldset><br/>

<table width="100%">
  <tr>
    <td width="56%"><fieldset>
    <table width="100%">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td height="25" colspan="2" align="left"><b><font size="3" face="Helvetica">Earnings</font></b></td>
    </tr>
    <tr><td colspan="2"><hr noshade size=1 width="100%"></td></tr>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningbasic" name="lblearningbasic"><s:property value="lblearningbasic"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningbasicvalue" name="lblearningbasicvalue"><s:property value="lblearningbasicvalue"/></label></font></td>
    </tr>
    <s:if test="#allowancecount>=1">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance0" name="lblearningallowance0"><s:property value="lblearningallowance0"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance0value" name="lblearningallowance0value"><s:property value="lblearningallowance0value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=2">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance1" name="lblearningallowance1"><s:property value="lblearningallowance1"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance1value" name="lblearningallowance1value"><s:property value="lblearningallowance1value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=3">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance2" name="lblearningallowance2"><s:property value="lblearningallowance2"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance2value" name="lblearningallowance2value"><s:property value="lblearningallowance2value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=4">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance3" name="lblearningallowance3"><s:property value="lblearningallowance3"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance3value" name="lblearningallowance3value"><s:property value="lblearningallowance3value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=5">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance4" name="lblearningallowance4"><s:property value="lblearningallowance4"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance4value" name="lblearningallowance4value"><s:property value="lblearningallowance4value"/></label></font></td>
    </tr>
     </s:if>
    <s:if test="#allowancecount>=6">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance5" name="lblearningallowance5"><s:property value="lblearningallowance5"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance5value" name="lblearningallowance5value"><s:property value="lblearningallowance5value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=7">
     <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance6" name="lblearningallowance6"><s:property value="lblearningallowance6"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance6value" name="lblearningallowance6value"><s:property value="lblearningallowance6value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=8">
     <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance7" name="lblearningallowance7"><s:property value="lblearningallowance7"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance7value" name="lblearningallowance7value"><s:property value="lblearningallowance7value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=9">
     <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance8" name="lblearningallowance8"><s:property value="lblearningallowance8"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance8value" name="lblearningallowance8value"><s:property value="lblearningallowance8value"/></label></font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=10">
     <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningallowance9" name="lblearningallowance9"><s:property value="lblearningallowance9"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningallowance9value" name="lblearningallowance9value"><s:property value="lblearningallowance9value"/></label></font></td>
    </tr>
   </s:if>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningovertime" name="lblearningovertime"><s:property value="lblearningovertime"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningovertimevalue" name="lblearningovertimevalue"><s:property value="lblearningovertimevalue"/></label></font></td>
    </tr>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lblearningaddition" name="lblearningaddition"><s:property value="lblearningaddition"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lblearningadditionvalue" name="lblearningadditionvalue"><s:property value="lblearningadditionvalue"/></label></font></td>
    </tr>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td height="20" align="left"><b><font size="2" face="Helvetica">Total Earnings</font></b></td>
      <td height="20" align="right"><b><font size="2" face="Helvetica"><label id="lbltotalearning" name="lbltotalearning"><s:property value="lbltotalearning"/></label></font></b></td>
    </tr>
    </table></fieldset>
    </td>
    
    <td width="2%">&nbsp;</td>
    
    <td width="40%"><fieldset>
    <table width="100%">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td height="25" colspan="2" align="left"><b><font size="3" face="Helvetica">Deductions</font></b></td>
     </tr>
    <tr><td colspan="2"><hr noshade size=1 width="100%"></td></tr>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lbldeductionsloan" name="lbldeductionsloan"><s:property value="lbldeductionsloan"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lbldeductionsloanvalue" name="lbldeductionsloanvalue"><s:property value="lbldeductionsloanvalue"/></label></font></td>
    </tr>
   <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica"><label id="lbldeductionsdeduction" name="lbldeductionsdeduction"><s:property value="lbldeductionsdeduction"/></label></font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica"><label id="lbldeductionsdeductionvalue" name="lbldeductionsdeductionvalue"><s:property value="lbldeductionsdeductionvalue"/></label></font></td>
    </tr>
	<tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
       <td colspan="2">&nbsp;</td>
    </tr>
    <s:if test="#allowancecount>=1">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=2">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=3">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=4">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=5">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=6">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=7">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=8">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=9">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <s:if test="#allowancecount>=10">
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td width="50%" height="20" align="left"><font size="2" face="Helvetica">&nbsp;</font></td>
      <td width="50%" height="20" align="right"><font size="2" face="Helvetica">&nbsp;</font></td>
    </tr>
    </s:if>
    <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
      <td height="20" align="left"><b><font size="2" face="Helvetica">Total Deductions</font></b></td>
      <td height="20" align="right"><b><font size="2" face="Helvetica"><label id="lbltotaldeduction" name="lbltotaldeduction"><s:property value="lbltotaldeduction"/></label></font></b></td>
    </tr>
    </table></fieldset>
    </td>
  </tr>
</table><br/>

<fieldset>
<table width="100%">
  <tr onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">
    <td width="16%" height="25" align="left"><font size="3" face="Helvetica">Gross Salary</font></td>
    <td width="19%" align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblgrosssalary" name="lblgrosssalary"><s:property value="lblgrosssalary"/></label></font></td>
    <td width="17%" align="left"><font size="3" face="Helvetica">G. Deduction</font></td>
    <td width="18%" align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblgrossdeduction" name="lblgrossdeduction"><s:property value="lblgrossdeduction"/></label></font></td>
    <td width="13%" align="left"><font size="3" face="Helvetica">Net Salary</font></td>
    <td width="17%" align="left"><b>:</b>&nbsp;<font size="2" face="Helvetica"><label id="lblnetsalary" name="lblnetsalary"><s:property value="lblnetsalary"/></label></font></td>
  </tr>
</table>
</fieldset>



<s:if test="#arr.index!=#request.PAYSLIP.size-1">
<DIV style="page-break-after:always"></DIV>
</s:if>

</form>
</s:iterator>

</body>
</html>