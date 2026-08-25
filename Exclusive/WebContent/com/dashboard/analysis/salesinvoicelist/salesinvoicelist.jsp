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
</style>

<script type="text/javascript">

$(document).ready(function () {
	   setType(null);
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",disabled:true});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",disabled:true});
	 $('#clientwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#clientsearchwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientsearchwindow').jqxWindow('close');
	   $('#salesagentwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#salesagentwindow').jqxWindow('close');
	   $('#rentalagentwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#rentalagentwindow').jqxWindow('close');
	   $('#brandwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   $('#clientcat').dblclick(function(){
		    $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientcatSearchContent('clientCatSearch.jsp?id=1', $('#clientwindow'));
		});
	   
	   $('#client').dblclick(function(){
		    $('#clientsearchwindow').jqxWindow('open');
		$('#clientsearchwindow').jqxWindow('focus');
		 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
		});
	  
	   $('#salesagent').dblclick(function(){
		    $('#salesagentwindow').jqxWindow('open');
		$('#salesagentwindow').jqxWindow('focus');
		 salesagentSearchContent('salesAgentSearch.jsp?id=1', $('#salesagentwindow'));
		});
	   
	   $('#rentalagent').dblclick(function(){
		    $('#rentalagentwindow').jqxWindow('open');
		$('#rentalagentwindow').jqxWindow('focus');
		 rentalagentSearchContent('rentalAgentSearch.jsp?id=1', $('#rentalagentwindow'));
		});
	   $('#brand').dblclick(function(){
		    $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));
		});
	  
	   $('#model').dblclick(function(){
		   if(document.getElementById("brand").value==""){
			   $.messager.alert('Warning','Please Select Brand');
			   return false;
		   } 
		   $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1&brand='+document.getElementById("hidbrand").value, $('#brandwindow'));
		});
	   
	   $('#group').dblclick(function(){
		    $('#groupwindow').jqxWindow('open');
		$('#groupwindow').jqxWindow('focus');
		 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));
		});
	   $('#yom').dblclick(function(){
		    $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
		});
	   
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
       setCheckBoxes();
});


function getClient(event){
	 var x= event.keyCode;
   if(x==114){
   	  $('#clientsearchwindow').jqxWindow('open');
 		$('#clientsearchwindow').jqxWindow('focus');
 		 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
   }
   else{
    }
}


function getClientcat(event){
	 var x= event.keyCode;
  if(x==114){
  	  $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientcatSearchContent('clientCatSearch.jsp?id=1', $('#clientwindow'));
  }
  else{
   }
}

function getSalesAgent(event){
	 var x= event.keyCode;
  if(x==114){
	  $('#salesagentwindow').jqxWindow('open');
		$('#salesagentwindow').jqxWindow('focus');
		 salesagentSearchContent('salesAgentSearch.jsp?id=1', $('#salesagentwindow'));
  }
  else{
   }
}

function getRentalAgent(event){
	 var x= event.keyCode;
 if(x==114){
	  $('#rentalagentwindow').jqxWindow('open');
		$('#rentalagentwindow').jqxWindow('focus');
		 rentalagentSearchContent('rentalAgentSearch.jsp?id=1', $('#rentalagentwindow'));
 }
 else{
  }
}
function getBrand(event){
	 var x= event.keyCode;
if(x==114){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));
}
else{
 }
}


function getModel(event){
	if(document.getElementById("brand").value==""){
		   $.messager.alert('Warning','Please Select Brand');
		   return false;
	   } 
	var x= event.keyCode;
if(x==114){
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1&brand='+document.getElementById("hidbrand").value, $('#brandwindow'));
}
else{
}
}

function getGroup(event){
	 var x= event.keyCode;
if(x==114){
	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));
}
else{
}
}
function getYom(event){
	 var x= event.keyCode;
if(x==114){
	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}
else{
}
}

function setCheckBoxes(){
	if(document.getElementById("chkbrand").checked==true){
		document.getElementById("hidchkbrand").value="1";
	}
	else{
		document.getElementById("hidchkbrand").value="0";
	}
	if(document.getElementById("chkmodel").checked==true){
		document.getElementById("hidchkmodel").value="1";
	}
	else{
		document.getElementById("hidchkmodel").value="0";
	}
	if(document.getElementById("chkgroup").cheked==true){
		document.getElementById("hidchkgroup").value="1";
	}
	else{
		document.getElementById("hidchkgroup").value="0";
	}
	if(document.getElementById("chkyom").checked==true){
		document.getElementById("hidchkyom").value="1";
	}
	else{
		document.getElementById("hidchkyom").value="0";
	}
	if(document.getElementById("chkclientcat").checked==true){
		document.getElementById("hidchkclientcat").value="1";
	}
	else{
		document.getElementById("hidchkclientcat").value="0";
	}
	if(document.getElementById("chkclient").checked==true){
		document.getElementById("hidchkclient").value="1";
	}
	else{
		document.getElementById("hidchkclient").value="0";
	}
	if(document.getElementById("chksalesagent").checked==true){
		document.getElementById("hidchksalesagent").value="1";
	}
	else{
		document.getElementById("hidchksalesagent").value="0";
	}
	if(document.getElementById("chkrentalagent").checked==true){
		document.getElementById("hidchkrentalagent").value="1";
	}
	else{
		document.getElementById("hidchkrentalagent").value="0";
	}
}

function clientcatSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientsearchwindow').jqxWindow('setContent', data);

}); 
}

function salesagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#salesagentwindow').jqxWindow('setContent', data);

}); 
}

function rentalagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#rentalagentwindow').jqxWindow('setContent', data);

}); 
}
function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
	 var branch = document.getElementById("cmbbranch").value;
     var clientcat=document.getElementById("hidclientcat").value;
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
     var chkbrand=document.getElementById("hidchkbrand").value;
     var chkmodel=document.getElementById("hidchkmodel").value;
     var chkgroup=document.getElementById("hidchkgroup").value;
     var chkyom=document.getElementById("hidchkyom").value;
     var client=document.getElementById("hidclient").value;
     var salesagent=document.getElementById("hidsalesagent").value;
     var rentalagent=document.getElementById("hidrentalagent").value;
     var brand=document.getElementById("hidbrand").value;
     var model=document.getElementById("hidmodel").value;
     var group=document.getElementById("hidgroup").value;
     var yom=document.getElementById("hidyom").value;
	var chkclient=document.getElementById("hidchkclient").value;
	var chkclientcat=document.getElementById("hidchkclientcat").value;
	var chksalesagent=document.getElementById("hidchksalesagent").value;
	var chkrentalagent=document.getElementById("hidchkrentalagent").value;
     if(document.getElementById("hidrdobetweendates").value=="0" && document.getElementById("hidrdomonthwise").value=="0"){
    	 $.messager.alert('Warning','Monthwise/Period is Mandatory');
    	 return false;
     }
     if(document.getElementById("hidrdobetweendates").value=="1"){
    	
    	 $("#salesinvoicediv").load("salesInvListGrid.jsp?branch="+branch+"&clientcat="+clientcat+"&fromdate="+fromdate+"&todate="+todate+"&chkbrand="+chkbrand+"&chkmodel="+chkmodel+"&chkgroup="+chkgroup+"&chkyom="+chkyom+"&chkclientcat="+chkclientcat+"&chkclient="+chkclient+"&chksalesagent="+chksalesagent+"&chkrentalagent="+chkrentalagent+"&client="+client+"&salesagent="+salesagent+"&rentalagent="+rentalagent+"&brand="+brand+"&model="+model+"&group="+group+"&yom="+yom+"&id=1"); 
     }
	 // 
	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	}
	function funExportBtn(){
		 $("#salesInvListGrid").jqxGrid('exportdata', 'xls', 'Sales Invoices');
		 //alert(invoicedata);
	   // window.open('data:application/vnd.ms-excel,' + invoicedata);
	    //e.preventDefault();
	    
		
	}
	function setType(value){
		if(value=="dates"){
			$('#fromdate').jqxDateTimeInput({disabled:false});
			$('#todate').jqxDateTimeInput({disabled:false});
			document.getElementById("hidrdobetweendates").value="1";
			document.getElementById("hidrdomonthwise").value="0";
		}
		else if(value=="monthwise"){
			if($('#fromdate').jqxDateTimeInput('disabled')==false){
				$('#fromdate').jqxDateTimeInput({disabled:true});
				$('#todate').jqxDateTimeInput({disabled:true});
				document.getElementById("hidrdobetweendates").value="1";
				document.getElementById("hidrdomonthwise").value="0";
			
			}
		}
		else{
			
			document.getElementById("hidrdobetweendates").value="0";
			document.getElementById("hidrdomonthwise").value="0";
		}
	}
		
	function setGrouping(value){
		document.getElementById("hidchkclientcat").value="0";
		document.getElementById("hidchkclient").value="0";
		document.getElementById("hidchksalesagent").value="0";
		document.getElementById("hidchkrentalagent").value="0";
		document.getElementById("hidchkbrand").value="0";
		document.getElementById("hidchkmodel").value="0";
		document.getElementById("hidchkgroup").value="0";
		document.getElementById("hidchkyom").value="0";
		document.getElementById("chkclientcat").checked=false;
		document.getElementById("chkclient").checked=false;
		document.getElementById("chksalesagent").checked=false;
		document.getElementById("chkrentalagent").checked=false;
		document.getElementById("chkbrand").checked=false;
		document.getElementById("chkmodel").checked=false;
		document.getElementById("chkgroup").checked=false;
		document.getElementById("chkyom").checked=false;
		if(value=="fleetwise"){
			$('#fleetwisefield').prop('disabled',false);
			$('#docwisefield').prop('disabled',true);
			document.getElementById("hidfleetwise").value="1";
			document.getElementById("hiddocwise").value="0";
		}
		else if(value=="docwise"){
			$('#fleetwisefield').prop('disabled',true);
			$('#docwisefield').prop('disabled',false);
			document.getElementById("hiddocwise").value="1";
			document.getElementById("hidfleetwise").value="0";
		}
		else{
			document.getElementById("hiddocwise").value="0";
			document.getElementById("hidfleetwise").value="0";
		}
		
	}
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('input[type=radio]').prop("checked", false);
		$('input:checkbox').removeAttr('checked');
		$('input[type=text]').prop("placeholder", "Press F3 to Search");
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" action="saveSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="36%" align="right"><label class="branch">From Date</label></td><td width="64%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
<tr><td colspan="2" align="center"><input type="radio" name="rdotype" id="rdomonthwise" value="monthwise" onchange="setType(this.value);">&nbsp;<label class="branch">Monthwise</label>&nbsp;
<input type="radio" name="rdotype" id="rdobetweendates" value="dates" onchange="setType(this.value);">&nbsp;<label class="branch">Period</label>
</td></tr>
<input type="hidden" name="hidrdomonthwise" id="hidrdomonthwise">
<input type="hidden" name="hidrdobetweendates" id="hidrdobetweendates">
<input type="hidden" name="hidfleetwise" id="hidfleetwise">
<input type="hidden" name="hiddocwise" id="hiddocwise">
<input type="hidden" name="hidyom" id="hidyom">
<tr>
  <td colspan="2">
  <table width="100%">
        <tr>
          <td width="50%" >
          <fieldset id="fleetwisefield"><legend><input type="radio" name="rdogrouping" id="rdofleetwise" onChange="setGrouping(this.value);" value="fleetwise">
          <label for="rdofleetwise" class="branch">Fleet Wise</label></legend>
          <table width="100%">
            <tr>
              <td><input type="checkbox" name="chkbrand" id="chkbrand" onchange="setCheckBoxes();">
                <label for="chkbrand2" class="branch"> Brand</label></td>
            
            </tr>
            <tr>
              <td><input type="checkbox" name="chkmodel" id="chkmodel" onChange="setCheckBoxes();">
                <label for="chkmodel4" class="branch">Model</label></td>
             
            </tr>
            <tr>
              <td><input type="checkbox" name="chkgroup" id="chkgroup" onChange="setCheckBoxes();">
                <label for="chkgroup3" class="branch">Group</label></td>
              
            </tr>
            <tr>
              <td><input type="checkbox" name="chkyom" id="chkyom" onChange="setCheckBoxes();">
                <label for="chkyom4" class="branch">YOM</label></td>
             
            </tr>
          </table>
          </fieldset>
          </td>
          <td width="50%" >
          <fieldset id="docwisefield"><legend><input type="radio" name="rdogrouping" id="rdodocwise" value="docwise" onChange="setGrouping(this.value)">
          <label for="rdodocwise" class="branch">Doc Wise</label></legend>
          <table width="100%">
            <tr>
              <td><span class="branch">
                <input type="checkbox" name="chkclientcat" id="chkclientcat" onchange="setCheckBoxes();">
              </span><span class="branch">
              <label for="chkclientcat4" class="branch">Client Category </label>
              </span></td>
            </tr>
            <tr>
              <td><input type="checkbox" name="chkclient" id="chkclient" onChange="setCheckBoxes();" >
                <label for="chkclient" class="branch">Client</label></td>
            </tr>
            <tr>
              <td><input type="checkbox" name="chksalesagent" id="chksalesagent" onchange="setCheckBoxes();">
                <label for="chksalesagent" class="branch">Sales Agent</label></td>
            </tr>
            <tr>
              <td><input type="checkbox" name="chkrentalagent" id="chkrentalagent" onChange="setCheckBoxes();">
                <label for="chkrentalagent" class="branch">Rental Agent</label></td>
            </tr>
          </table>
          </fieldset>
          </td>
        </tr>
    <input type="hidden" name="hidchkclientcat" id="hidchkclientcat">
    <input type="hidden" name="hidchkclient" id="hidchkclient">
    <input type="hidden" name="hidchksalesagent" id="hidchksalesagent">
    <input type="hidden" name="hidchkrentalagent" id="hidchkrentalagent">
    <input type="hidden" name="hidchkyom" id="hidchkyom">
    <input type="hidden" name="hidchkbrand" id="hidchkbrand">
    <input type="hidden" name="hidchkmodel" id="hidchkmodel">
    <input type="hidden" name="hidchkgroup" id="hidchkgroup">
</table>  
  </td>
</tr>
<tr>
  <td align="right"><label class="branch">Client Category</label></td>
  <td align="left"><input type="text" name="clientcat" id="clientcat" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getClientcat(event);"></td>
  </tr>
  <tr>
  <td align="right"><label class="branch">Client </label></td>
  <td align="left"><input type="text" name="client" id="client" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getClient(event);"></td>
  </tr> 
  <tr>
  <td align="right"><label class="branch">Sales Agent</label></td>
  <td align="left"><input type="text" name="salesagent" id="salesagent" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getSalesAgent(event);"></td>
  </tr> 
  <tr>
  <td align="right"><label class="branch">Rental Agent</label></td>
  <td align="left"><input type="text" name="rentalagent" id="rentalagent" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getRentalAgent(event);"></td>
  </tr> 
   <tr>
  <td align="right"><label class="branch">Brand</label></td>
  <td align="left"><input type="text" name="brand" id="brand" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getBrand(event);"></td>
  </tr>
   <tr>
  <td align="right"><label class="branch">Model</label></td>
  <td align="left"><input type="text" name="model" id="model" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getModel(event);"></td>
  </tr>
   <tr>
  <td align="right"><label class="branch">Group</label></td>
  <td align="left"><input type="text" name="group" id="group" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getGroup(event);"></td>
  </tr>
<tr>
  <td align="right"><label class="branch">YOM</label></td>
  <td align="left"><input type="text" name="yom" id="yom" readonly placeholder="Press F3 to Search" style="height:17px;" onkeydown="getYom(event);"></td>
  </tr>  
   <input type="hidden" name="hidbrand" id="hidbrand" value='<s:property value="hidbrand"/>'>
  <input type="hidden" name="hidmodel" id="hidmodel" value='<s:property value="hidmodel"/>'>
  <input type="hidden" name="hidgroup" id="hidgroup" value='<s:property value="hidgroup"/>'>
<input type="hidden" name="hidclientcat" id="hidclientcat" value='<s:property value="hidclientcat"/>'>
<input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
<input type="hidden" name="hidsalesagent" id="hidsalesagent" value='<s:property value="hidsalesagent"/>'>
<input type="hidden" name="hidrentalagent" id="hidrentalagent" value='<s:property value="hidrentalagent"/>'>
		
	<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="salesinvoicediv"><jsp:include page="salesInvListGrid.jsp"></jsp:include></div> </td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="clientsearchwindow">
<div></div>
</div>
<div id="salesagentwindow">
<div></div>
</div>
<div id="rentalagentwindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="groupwindow">
<div></div>
</div>
<div id="yomwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>