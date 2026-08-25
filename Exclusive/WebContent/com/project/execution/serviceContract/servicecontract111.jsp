<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    height: 550px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function() {
	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#stdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#enddate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#finsdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#serdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
});
function funFocus()
{
	//document.getElementById("txtenquiry").focus();
		
}

function funReadOnly(){
	
}


</script>
</head>

<body>
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmSurveydetails" action="saveSurveydetails" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
		<div class='hidden-scrollbar'>
	<table width="100%">
    <tr>
      <td width="10%" align="right">Date</td>
      <td width="17%"><div id="date" name="date" value='<s:property value="date" />'></div></td>
      <td width="12%" align="right">Ref  No</td>
      <td width="30%"><input type="text" onKeyDown="getEnquiry(event);" name="txtenquiry" placeholder="press F3 for Search" value='<s:property value="txtenquiry" />' id="txtenquiry"></td>
      <td width="18%" align="right">Doc No</td>
      <td width="13%"><input type="text" name="docno" value='<s:property value="docno" />' id="docno" tabindex="-1" readonly></td>
    </tr>
	  <tr>
	    <td colspan="6"><fieldset><legend>Client Details</legend>
        <table width="100%">
  <tr>
    <td width="10%" align="right">Client</td>
    <td width="19%"><input type="text" name="txtclient" id="txtclient" style="width:95%;" value='<s:property value="txtclient" />'></td>
    <td width="10%" align="right">Client Details</td>
    <td width="36%"><input type="text" name="txtclientdet" id="txtclientdet" style="width:90%;" value='<s:property value="txtclientdet" />'></td>
    <td width="12%" align="right">&nbsp;</td>
    <td width="13%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Mobile 1</td>
    <td><input type="text" name="contactnumber" id="contactnumber" style="width:95%;" value='<s:property value="contactnumber" />'></td>
    <td align="right">Mobile 2</td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Mail</td>
    <td><input type="text" name="surveyedby" id="surveyedby" style="width:95%;" onKeyDown="getemployee(event);" placeholder="press F3 for Search" value='<s:property value="surveyedby" />'></td>
    <td align="right">Contact Person</td>
    <td><input type="text" name="txtcontact" id="txtcontact" style="width:90%;" value='<s:property value="txtcontact" />'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

        </fieldset>
        </td>
      </tr>
	  <tr>
	    <td colspan="6"><table width="100%">
  <tr>
    <td width="10%">Ref Type</td>
    <td width="17%"><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="SOR">SOR</option>
      <option value="DEL">DEL</option>
    </select></td>
    <td width="12%">&nbsp;</td>
    <td width="20%"><input type="text" id="rrefno" name="rrefno" style="width:100%;" placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/></td>
    <td width="41%">&nbsp;</td>
  </tr>
  <tr>
    <td>Contract Value</td>
    <td><input type="text" id="txtcntrval" name="txtcntrval" value='<s:property value="txtcntrval"/>'/></td>
    <td>Tax Per</td>
    <td><input type="text" id="txttaxper" name="txttaxper" style="width:100%;"   onKeyDown="getrefno(event);" value='<s:property value="txttaxper"/>'/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="chklegaldoc" id="chklegaldoc" ><label for="chklegaldoc">Legal Document</label></td>
    <td><input type="text" id="temp1" name="temp1" value='<s:property value="temp1"/>'/></td>
    <td><input type="text" id="temp2" name="temp2" value='<s:property value="temp2"/>'/></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>St.Date</td>
    <td><div id="stdate" name="stdate" value='<s:property value="stdate" />'></div></td>
    <td>End Date</td>
    <td><div id="enddate" name="enddate" value='<s:property value="enddate" />'></div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Installments</td>
    <td><input type="text" name="installments" id="installments" value='<s:property value="installments"/>'></td>
    <td>First Inst.On</td>
    <td><div id="finsdate" name="finsdate" value='<s:property value="finsdate" />'></div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Service Start On</td>
    <td><div id="serdate" name="serdate" value='<s:property value="serdate" />'></div></td>
    <td><select name="cmbsrvctype" id="cmbsrvctype"><option value="">--Select--</option></select></td>
    <td><input type="text" name="srvcinterval" id="srvcinterval" value='<s:property value="srvcinterval"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>
      </tr>
      
      <table width="100%">

   <tr>
    <td>
    <fieldset><legend>Site Details</legend>
    <div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
    </fieldset>
    </td>
  </tr> 
  
   <tr>
    <td>
     <fieldset><legend>Payment Details</legend>
     <div id="paydiv"><jsp:include page="paymentGrid.jsp"></jsp:include></div>
     </fieldset></td>
     
  </tr>
 
  <tr>
    <td>
    <fieldset><legend>Service Details</legend>
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
    
  </tr> 
  
  <tr>
    <td>
    <fieldset><legend>Service Scheduler</legend>
    <div id="schediv"><jsp:include page="serviceScheduleGrid.jsp"></jsp:include></div>
     </fieldset></td>
    
  </tr> 
 
 <tr>
 <td>
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
 </td>
 </tr>
</table>
      
      
</table>
</body>
</html>
