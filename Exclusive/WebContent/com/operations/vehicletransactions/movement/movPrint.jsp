<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }

 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
body {
    background-color: white;
}
</style> 
<script type="text/javascript">
$(document).ready(function ()
		 {
document.getElementById("collectionfield").style.display="none";
document.getElementById("deliveryfield").style.display="none";
if(document.getElementById("lblhiddelivery").innerText=="1"){
	document.getElementById("deliveryfield").style.display="block";	
}
if(document.getElementById("lblhidcollection").innerText=="1"){
	document.getElementById("collectionfield").style.display="block";	
}
		 }); 
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmMovementPrint").submit(); 
	
}
</script>
</head>
<body onload="" bcolor="white">
<div id="mainBG" class="homeContent" data-type="background"  style="background-color:white;">
<form id="frmMovementPrint" action="printMovement" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<fieldset>
<legend><b>Opening Details</b></legend>

<table width="100%" >
<tr>
<td width="100%">
<table width="100%"  >
<tr>
<td align="left" width="156">Branch</td ><td align="left" width="168">:&nbsp;<label id="lblopenbranch" name="lblopenbranch"><s:property value="lblopenbranch"/></label></td>
<td align="left" width="92">Location</td>
<td align="left" width="242">:&nbsp;<label name="lblopenlocation" id="lblopenlocation"><s:property value="lblopenbranch"/></label></td>
<td align="left" width="115">&nbsp;</td>
<td align="left" width="176">&nbsp;</td>
<td align="left" width="87">Doc No </td>
<td align="left" width="208">:&nbsp;
  <label id="lbldocno" name="lbldocno">
    <s:property value="lbldocno"/>
  </label></td>
</tr>
<tr>
<td align="left">Fleet NO </td><td align="left">:&nbsp;<label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label></td>
<td align="right">&nbsp;</td><td align="left">&nbsp;</td>
<td align="right">&nbsp;</td>
<td align="left">&nbsp;</td>
<td align="left">Date</td>
<td align="left">:&nbsp;
  <label id="lbldate" name="lbldate">
    <s:property value="lbldate"/>
  </label></td>

</tr>
<tr>
  <td align="left">Fleet Details</td>
  <td colspan="5" align="left">:&nbsp;<label name="lblfleetdetails" id="lblfleetdetails"><s:property value="lblfleetdetails"/></label></td>
  <td align="left">Mov Type </td>
  <td align="left">:&nbsp;
    <label id="lblmovtype" name="lblmovtype">
      <s:property value="lblmovtype"/>
    </label></td>
  </tr>
<tr>
<td align="left">Date Out </td><td align="left">:&nbsp;<label id="lbldateout" name="lbldateout"><s:property value="lbldateout"/></label></td>
<td align="left">Time Out</td><td align="left">:&nbsp;<label id="lbltimeout" name="lbltimeout"><s:property value="lbltimeout"/></label></td>
<td align="left">KM Out</td>
<td align="left">:&nbsp;
  <label id="lblkmout" name="lblkmout">
    <s:property value="lblkmout"/>
  </label></td>
<td align="left">Fuel Out </td>
<td align="left">:&nbsp;
  <label id="lblfuelout" name="lblfuelout">
    <s:property value="lblfuelout"/>
  </label></td>

</tr>
<tr>
  <td align="left">Garage</td><td align="left">:&nbsp;
    <label id="lblgaragename" name="lblgaragename" >
      <s:property value="lblgaragename"/>
    </label></td>
  <td align="left">Driver</td>
  <td align="left">:&nbsp;
    <label name="lblopendriver" id="lblopendriver">
      <s:property value="lblopendriver"/>
    </label></td>
  <td align="left">Staff</td>
  <td align="left">:&nbsp;
    <label name="lblopenstaff" id="lblopenstaff">
      <s:property value="lblopenstaff"/>
    </label></td>
  <td align="left">User</td>
  <td align="left">:&nbsp;
    <label id="lblopenuser" name="lblopenuser">
      <s:property value="lblopenuser"/>
    </label></td>
</tr>
<tr><td align="left">Remarks</td>
	<td align="left"  colspan="7">:&nbsp;<label id="lblopenremarks" name="lblopenremarks"><s:property value="lblopenremarks"/></label></td>
</tr>
</table>

</td>

<td width="0%">&nbsp;</td>
</table>
</fieldset>

<table width="100%">
<tr>
<td>
  <fieldset id="deliveryfield" ><legend><b>Delivery Details</b></legend>
  <table width="100%">
  <tr>
    <td align="left" width="12%">Date</td><td align="left" width="41%">:&nbsp;<label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></td>
    <td align="left" width="9%">Time</td><td align="left" width="38%">:&nbsp;<label id="lbldeltime" name="lbldeltime"><s:property value="lbldeltime"/></label></td>
  </tr>
  <tr>
  <td align="left">KM</td><td align="left">:&nbsp;<label id="lbldelkm" name="lbldelkm">
    <s:property value="lbldelkm"/>
  </label></td>
  <td align="left">Fuel</td><td align="left">:&nbsp;<label id="lbldelfuel" name="lbldelfuel"><s:property value="lbldelfuel"/>
  </label>
    </td>
  </tr>
  </table>
  </fieldset>
</td>
</table>
</fieldset>
<div id="collectionfield">
<fieldset  ><legend><b>Collection Details</b></legend>
<table width="100%" >
<tr>
  <td align="left" width="12%">Date</td><td align="left" width="41%">:&nbsp;<label id="lblcoldate" name="lblcoldate">
    <s:property value="lblcoldate"/>
  </label></td>
  <td align="left" width="9%">Time</td><td align="left" width="38%">:&nbsp;<label id="lblcoltime" name="lblcoltime"><s:property value="lblcoltime"/>
  </label></td>
</tr>
<tr>
<td align="left">KM</td><td align="left">:&nbsp;<label id="lblcolkm" name="lblcolkm">
  <s:property value="lblcolkm"/>
</label></td>
<td align="left">Fuel</td><td align="left">:&nbsp;<label id="lblcolfuel" name="lblcolfuel"><s:property value="lblcolfuel"/></label></td>
</tr>
</table>
</fieldset>
</div>
<fieldset>
<legend><b>Closing Details</b></legend>

<table width="100%" >
<tr>
<td width="100%">
<table width="100%"  >
<tr>
<td align="left" width="151">Branch</td ><td align="left" width="171">:&nbsp;<label id="lblclosebranch" name="lblclosebranch"><s:property value="lblclosebranch"/></label></td>
<td align="left" width="92">Location</td>
<td align="left" width="243">:&nbsp;<label name="lblcloselocation" id="lblcloselocation"><s:property value="lblcloselocation"/></label></td>
<td align="left" width="122">&nbsp;</td>
<td align="left" width="175">&nbsp;</td>
<td align="left" width="92">&nbsp;</td>
<td align="left" width="198">&nbsp;</td>
</tr>
<tr>
<td align="left">Date In </td><td align="left">:&nbsp;
  <label id="lblclosedate" name="lblclosedate">
    <s:property value="lblclosedate"/>
  </label></td>
<td align="left">Time In</td><td align="left">:&nbsp;
  <label id="lblclosetime" name="lblclosetime">
    <s:property value="lblclosetime"/>
  </label></td>
<td align="left">KM</td>
<td align="left">:&nbsp;
  <label id="lblclosekm" name="lblclosekm">
    <s:property value="lblclosekm"/>
  </label></td>
<td align="left">Fuel </td>
<td align="left">:&nbsp;
  <label id="lblclosefuel" name="lblclosefuel">
    <s:property value="lblclosefuel"/>
  </label></td>

</tr>
<tr>
  <td align="left">Garage</td><td align="left">:&nbsp;
    <label id="lblclosegarage" name="lblclosegarage">
      <s:property value="lblclosegarage"/>
    </label></td>
  <td align="left">Driver</td><td align="left">:&nbsp;
    <label id="lblclosedriver" name="lblclosedriver">
      <s:property value="lblclosedriver"/>
    </label></td>
  <td align="left">Staff</td>
  <td align="left">:&nbsp;
    <label id="lblclosestaff" name="lblclosestaff">
      <s:property value="lblclosestaff"/>
    </label></td>
  <td align="left">User</td>
  <td align="left">:&nbsp;
    <label name="lblcloseuser" id="lblcloseuser">
      <s:property value="lblcloseuser"/>
    </label></td>
  
</tr>
<tr>
  <td align="left">Accident Details</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="lblaccdetails" name="lblaccdetails">
      <s:property value="lblaccdetails"/>
    </label></td>
  <td align="left"> Accident Fines</td>
  <td align="left">:&nbsp;
    <label name="lblaccfines" id="lblaccfines">
      <s:property value="lblaccfines"/>
    </label></td>
  <td align="left">Total Km</td>
  <td align="left">:&nbsp;
    <label name="lbltotalkm" id="lbltotalkm">
      <s:property value="lbltotalkm"/>
    </label></td>
</tr>
<tr><td align="left">Remarks</td>
	<td align="left" colspan="7">:&nbsp;<label id="lblcloseremarks" name="lblcloseremarks"><s:property value="lblcloseremarks"/></label></td>
</tr>
</table>

</td>

<td width="0%">&nbsp;</td>
</table>
</fieldset>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<label id="lblhiddelivery" name="lblhiddelivery" hidden="true"><s:property value="lblhiddelivery"/></label>
<label id="lblhidcollection" name="lblhidcollection" hidden="true"><s:property value="lblhidcollection"/></label>
</form>
</div>
</body>
</html>
