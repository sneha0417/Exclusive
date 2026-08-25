<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 $('#jobnoSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '26%' , title: 'Job No Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobnoSearchWindow').jqxWindow('close');
    
    $("#clientname").dblclick(function(){
    	clientSearchContent("clientSearch.jsp");
    });
    $("#jobno").dblclick(function(){
    	jobnoSearchContent("jobnoSearch.jsp");
    });
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
		clientSearchContent("clientSearch.jsp");
	}
}
function clientSearchContent(url) {
	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}
function searchJobno(){
	var x= event.keyCode;
	if(x==114){
		jobnoSearchContent("jobnoSearch.jsp");
	}
}
function jobnoSearchContent(url) {
	$('#jobnoSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#jobnoSearchWindow').jqxWindow('setContent', data);
	$('#jobnoSearchWindow').jqxWindow('bringToFront');
}); 
}

function funreload(){
	$("#overlay, #PleaseWait").show();
	var barchval = document.getElementById("cmbbranch").value;
   	$("#joblistingdiv").load("joblistingGrid.jsp?id=1&client="+$('#hidcldocno').val()+"&jobno="+$('#jobno').val()+"&barchval="+barchval);
	$("#jqxEstimation").jqxGrid('clear');
	$("#jqxEnquiry").jqxGrid('clear');
}



function funClear(){
	$('#todate').val(new Date());
	var curdate=$('#todate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curdate.setMonth(curdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	$('#clientname').val("");
	$('#hidcldocno').val("");
	$('#jobno').val("");
}

</script>
</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr><td width="20%">
<fieldset style="background: #ECF8E0;">
<table width="100%" cellspacing="3" cellpadding="2">
<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
   <tr>
    <td width="37%" align="right"><label class="branch">Client Name</label></td>
    <td width="63%" align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchClient(event);">
    <input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'></td>
  </tr>
  <tr>
    <td width="37%" align="right"><label class="branch">Job No</label></td>
    <td width="63%" align="left"><input type="text" name="jobno" id="jobno" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchJobno(event);">
    <input type="hidden" name="hidjobno" id="hidjobno"></td>
  </tr>
  <tr><td colspan="2" align="center">
  <input type="button" id="btnClear" class="myButtons" value="Clear" onclick="funClear();" >
  </td></tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</fieldset>
</td>
<td>
<div id="joblistingdiv"><jsp:include page="joblistingGrid.jsp"></jsp:include></div><br>
<div id="enquirydiv"><jsp:include page="enquiryGrid.jsp"></jsp:include></div><br>
<div id="srvcdiv"><jsp:include page="estmgrid.jsp"></jsp:include></div>
</td>
</tr>
<input type="text" name="hiddocno" id="hiddocno" hidden="true" value='<s:property value="hiddocno"/>' >

<div id="clientSearchWindow">
   <div ></div>
</div>

<div id="jobnoSearchWindow">
   <div ></div>
</div>
</div>
</div>
</body>
</html>