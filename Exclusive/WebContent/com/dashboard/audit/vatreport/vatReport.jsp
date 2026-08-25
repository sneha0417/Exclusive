<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	/* document.getElementById("branchlabel").style.display="none";
	document.getElementById("branchdiv").style.display="none"; */
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    $('#nettotal,#totalinput,#totaloutput').val("0");
    
});

function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    $('#nettotal,#totalinput,#totaloutput').val("0");
    var nettotal=parseFloat($('#nettotal').val());
    var branch=$('#cmbbranch').val();
 	funRoundAmt(nettotal,"nettotal");
   	$("#vatoutputdiv").load("vatOutputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
   	$("#vatinputdiv").load("vatInputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
}

function setValues(){
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
}
	
function funExportBtn(){
	JSONToCSVCon(vatinputdata, 'VAT Input Report', true);
	JSONToCSVCon(vatoutputdata, 'VAT Output Report', true);
}
	
function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('select').find('option').prop("selected", false);
	$('#fromdate').jqxDateTimeInput('setDate',new Date());
	$('#todate').jqxDateTimeInput('setDate',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
    $('#nettotal,#totalinput,#totaloutput').val("0");
}
	
</script>
</head>
<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <!-- 
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();">
	</div>
    </td>
	</tr> -->
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><fieldset><legend>Output Tax</legend><div id="vatoutputdiv"><jsp:include page="vatOutputGrid.jsp"></jsp:include></div></fieldset>
			 <fieldset><legend>Input Tax</legend><div id="vatinputdiv"><jsp:include page="vatInputGrid.jsp"></jsp:include></div></fieldset>
			 <div style="text-align:right;margin-right:30px;"><label class="branch" style="background-color:transparent;font-weight:bold;">Net Total</label>&nbsp;&nbsp;<input type="text" name="nettotal" id="nettotal"  value='<s:property value="nettotal"/>' style="text-align:right;height:18px;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></div>
			 </td>
			  <input type="hidden" name="totalinput" id="totalinput" value='<s:property value="totalinput"/>'>
			  <input type="hidden" name="totaloutput" id="totaloutput" value='<s:property value="totaloutput"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientsearchwindow">
<div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</div>
</form>
</body>
</html>