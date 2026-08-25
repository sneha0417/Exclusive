<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<style type="text/css">

.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-size:8pt;
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#finsdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", value: null, enableBrowserBoundsDetection: true});
		 $("#stdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search', position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#contractDetailsWindow').jqxWindow({width: '40%', height: '50%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search', position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#contractDetailsWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
	     $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
			 	 
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	   return false;
			  }   
		 });
	     
		 $('#txtclientname').dblclick(function(){
			 accountsSearchContent('clientAccountDetailsSearch.jsp');
	     });
		 
		 $('#txtcontract').dblclick(function(){
			 if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
	     });
		 
		 $('#isproformainv').val(0);
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
	    $('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function funExportBtn(){
			JSONToCSVCon(dataExcelExport, 'ContractPaymentScheduleUpdate', true);
	} 
	
	function getClientAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountsSearchContent('clientAccountDetailsSearch.jsp');
        }
        else{}
        }
	
	function getContract(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
        }
        else{}
        }
	
	function funreload(event){
		
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		 if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  }
		  
	     var branch = document.getElementById("cmbbranch").value;
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var contracttype=$('#cmbcontracttype').val();
		 var contract= $("#txtcontracttrno").val();
		 var clientid=$('#txtclientaccountdocno').val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#contractPaymentScheduleUpdateDiv").load("contractPaymentScheduleUpdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&contracttype="+contracttype+"&contract="+contract+"&clientid="+clientid);
		
		}
	
	function  funClearData(){
		 $('#cmbbranch').val('a');
   	     $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $('#todate').val(new Date());
	     
		 $('#txtclientname').val('');
		 $('#txtclientaccountdocno').val('');
		 $('#cmbcontracttype').val('ALL');
		 $('#txtcontract').val('');
		 $('#txtcontracttrno').val('');
		 $('#txtselectedcontract').val('');
		 $('#txtcntrval').val('');
		 $('#isproformainv').val(0);
		 
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 if (document.getElementById("txtcontract").value == "") {
		        $('#txtcontract').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 $("#contractPaymentScheduleUpdateGridID").jqxGrid('clear');$("#contractPaymentScheduleUpdateGridID").jqxGrid('addrow', null, {});$("#contractPaymentScheduleUpdateGridID").jqxGrid('clearselection');
		 disable();
	}
	
	function disable(){
		$('#installments').val('');$('#paydueafter').val('');$('#cmbpaytype').val('1');$('#finsdate').val(null);$('#stdate').val(new Date());$('#enddate').val(new Date());
		$('#installments').attr('readonly', true);
		$('#paydueafter').attr('readonly', true);
		$('#cmbpaytype').attr('disabled', true);
		$('#btnAdd').attr('disabled', true);
		$('#finsdate').jqxDateTimeInput({disabled: true});
		$('#stdate').jqxDateTimeInput({disabled: true});
		$('#enddate').jqxDateTimeInput({disabled: true});
		$("#paymentDetailsGridID").jqxGrid('clear');$("#paymentDetailsGridID").jqxGrid({ disabled: true});$("#paymentDetailsGridID").jqxGrid('clearselection');
	}
	
	function funPaymentFill(){
		
		var startdate=$("#finsdate").val();
		var enddate=$("#enddate").val();
		var amount=$("#txtcntrval").val();
		var instno=$("#installments").val();
		var cmbpaytype=$("#cmbpaytype").val();
		var paydueafter=$("#paydueafter").val();

		if($('#installments').val()==''){
			   $.messager.alert('Message','Installment is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#paydueafter').val()==''){
			   $.messager.alert('Message','Due After is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#cmbpaytype').val()==''){
			   $.messager.alert('Message','Frequency is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#finsdate').jqxDateTimeInput('getDate')==null){
			   $.messager.alert('Message','First Inst Date is Mandatory.','warning');   
			   return false;
		}
		
		if($('#finsdate').jqxDateTimeInput('getDate')!=null){
		
	  		var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
	  		var status=checkInstdate(date);
	  		
	  		if(status){
	  			
	  			 $("#paymentDetailDiv").load("paymentDetailsGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&paydueafter="+paydueafter+"&gridload=1");
	  		}
	  		
	  	}
	 
	}
	
	function checkInstdate(date){
		 var date1=new Date(date);
		 date1.setHours(0,0,0,0);
		 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
		 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
		 enddate.setHours(0,0,0,0);
		 
		 if(date1<stdate){
			 $.messager.alert('Message','First Inst Date Should not less than Start Date.','warning');   
			 return false;
		 }
		 else if(date1>enddate){
			 $.messager.alert('Message','First Inst Date Should not greater than End Date.','warning');   
			 return false;
		 }
		 
		 else{
			 return true;
		 }
	}
	
	function firstdatechange(){
		
		var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
  		checkInstdate(date);
  		
	  }
	
	function funPaymentUpdate(){
		
		var rows = $("#paymentDetailsGridID").jqxGrid('getrows');
		if(rows.length==0){
			$("#overlay, #PleaseWait").hide();
			 $.messager.alert('Message','Payments are Unavailable.','warning');   
			 return false;
		}
		
		var gridarray=new Array();
		for(var i=0 ; i < rows.length ; i++){
			
		 	   var chks=rows[i].amount;
			   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0.00"){
				
				   var dueafterser="";
				    
				    if (rows[i].terms =="LEGAL DOCUMENT") {
				    	dueafterser=99;
					}
				    if (rows[i].terms =="SERVICE") {
				    	dueafterser=rows[i].service;
					}
				    if (rows[i].terms =="PROFORMA INVOICE") {
				    	dueafterser=98;
				    	document.getElementById("isproformainv").value=1;
					}
				 $('#hiddesc').val(rows[i].desc1);
						    
			     if ($(hiddesc).val().indexOf('"') >= 0) { $(hiddesc).val($(hiddesc).val().replace(/["']/g, ''));};
			      
				   gridarray.push(rows[i].duedate+" :: "+rows[i].amount+" :: "+rows[i].runtotal+" :: "+$(hiddesc).val()+" :: "+rows[i].terms+" :: "+dueafterser+" :: "+rows[i].service+" :: "+rows[i].rowno+" :: "+rows[i].invtrno+" :: ");
			 }
		}
		
			   $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else {
			     		 $("#overlay, #PleaseWait").show();
			     		 var docno=$('#txtselectedcontract').val();
			     		 saveGridData(docno,gridarray);	
			     	}
			 });
		
		
	}
	
	function saveGridData(docno,gridarray) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var docno = items[1];
				
				if(parseInt(val)>0){
					$.messager.alert('Message', ' Updated Successfully.', function(r){
					});
					
					$('#txtselectedcontract').val('');
					$('#txtcntrval').val('');
					$('#isproformainv').val(0);
					disable();funreload(event);
				
				} else {
					$.messager.alert('Message', ' Failed.', function(r){
					});
					$("#overlay, #PleaseWait").hide();
				}
		  }
		}
			
		
	x.open("GET","saveData.jsp?docno="+docno+"&gridarray="+encodeURIComponent(gridarray),true);
	x.send();
	}
	
</script>
</head>
<body onload="getBranch();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmcontractPaymentScheduleUpdate" action="saveContractPaymentScheduleUpdate" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClientAccount(event);"/>
	<input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
    <td align="left"><select id="cmbcontracttype" name="cmbcontracttype" value='<s:property value="cmbcontracttype"/>'>
    <option value="ALL">ALL</option><option value="AMC">AMC</option><option value="SJOB">SJOB</option>
    </select></td></tr>
	<tr><td align="right"><label class="branch">Contract</label></td>
	<td align="left"><input type="text" id="txtcontract" name="txtcontract" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtcontract"/>' onkeydown="getContract(event);"/>
	<input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td></tr>
	<tr><td colspan="2"><fieldset><legend><b><label class="branch">Payment Details</label></b></legend>
	<table width="100%">
    <tr><td align="right"><label class="branch">Installments</label></td>
	<td align="left"><input type="text" id="installments" name="installments" style="width:96%;height:20px;" value='<s:property value="installments"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Due After</label></td>
	<td align="left"><input type="text" id="paydueafter" name="paydueafter" style="width:96%;height:20px;" value='<s:property value="paydueafter"/>'/></td></tr>
	<tr><td align="right"><label class="branch">First Inst.On</label></td>
	<td align="left"><div id="finsdate" name="finsdate" onchange="firstdatechange();" value='<s:property value="finsdate" />'></div></td></tr>
	<tr><td align="right"><label class="branch">Frequency</label></td>
	<td align="left"><select name="cmbpaytype" id="cmbpaytype" style="width:98%;" value='<s:property value="cmbpaytype"/>'>
    <option value="1">DAYS</option><option value="2">MONTHS</option><option value="3">YEAR</option>
    </select></td></tr>
	<tr><td align="right"><label class="branch">Start Date</label></td>
	<td align="left"><div id="stdate" name="stdate" value='<s:property value="stdate" />'></div></td></tr>
	<tr><td align="right"><label class="branch">End Date</label></td>
	<td align="left"><div id="enddate" name="enddate" value='<s:property value="enddate" />'></div></td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtcntrval" name="txtcntrval" style="width:96%;height:20px;" value='<s:property value="txtcntrval"/>'/>
	<input type="hidden" id="txtselectedcontract" name="txtselectedcontract" style="width:96%;height:20px;" value='<s:property value="txtselectedcontract"/>'/>
	<input type="hidden" id="isproformainv" name="isproformainv"  value='<s:property value="isproformainv"/>'/></td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funPaymentFill();">Fill</button></td></tr>
    </table></fieldset>
	</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnPaymentUpdate" name="btnPaymentUpdate" onclick="funPaymentUpdate();">Update</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="contractPaymentScheduleUpdateDiv"><jsp:include page="contractPaymentScheduleUpdateGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="paymentDetailDiv"><jsp:include page="paymentDetailsGrid.jsp"></jsp:include></div>
		<input type="hidden" id="hiddesc" name="hiddesc"  value='<s:property value="hiddesc"/>'/></td></tr>
	</table>
</tr>
</table>

</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>