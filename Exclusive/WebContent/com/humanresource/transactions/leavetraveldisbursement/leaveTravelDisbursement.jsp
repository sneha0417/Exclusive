<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 
		 $("#leaveTravelDisbursementDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#notifyDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#employeeDetailsWindow').jqxWindow('close');
	    
	     $('#txtemployeeid').dblclick(function(){
	 			employeeSearchContent("employeeDetailsSearch.jsp");
		 });
	     
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getLeaveTravelDetails(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var leavesalaryeligibledaysItems = items[0];
  				var leavesalarypostedItems  = items[1];
  				var leavesalarycurrentProvisionItems = items[2];
  				var leavesalarycalculatedItems = items[3];
  				var travelstobepostedItems = items[4];
  			
  			    funRoundAmt(leavesalaryeligibledaysItems,"txtalreadyprovisioneligibledays");
  			    funRoundAmt(leavesalarypostedItems,"txtleavesalaryalreadyprovided");
  			    funRoundAmt(leavesalarycurrentProvisionItems,"txtcurrentprovisioneligibledays");
  			    funRoundAmt(leavesalarycalculatedItems,"txtleavesalarycalculated");
  			    funRoundAmt(travelstobepostedItems,"txttravelalreadyposted");
  			    funRoundAmt(leavesalarycalculatedItems,"txtleavesalarytobepaid");
			    funRoundAmt(travelstobepostedItems,"txttravelcurrentexpenses");
  			    
			    funRoundAmt(parseFloat($('#txtalreadyprovisioneligibledays').val())+parseFloat($('#txtcurrentprovisioneligibledays').val()),"txttotaleligibledays");
			    funRoundAmt(parseFloat($('#txtalreadyprovisioneligibledays').val())+parseFloat($('#txtcurrentprovisioneligibledays').val()),"txtleavesalarypaideligibledays");
			    funRoundAmt(parseFloat($('#txtleavesalarycalculated').val())-parseFloat($('#txtleavesalaryalreadyprovided').val()),"txtleavesalarynettobeprovided");
			    funRoundAmt("0.00","txttravelticketvalue");document.getElementById("txtleavesalarytobepaid").focus();
  			    $("#overlay, #PleaseWait").hide();
  			  
  		}
  		}
  		x.open("GET", "getLeaveTravelDetails.jsp?empid="+a+"&date="+b, true);
  		x.send();
    }
	
	function getLeavePaidEligibleDays(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var leavesalarypaideligibledaysItems = items[0];
  			    
			    funRoundAmt(leavesalarypaideligibledaysItems,"txtleavesalarypaideligibledays");
  			    $("#overlay, #PleaseWait").hide();
  			  
  		}
  		}
  		x.open("GET", "getLeavePaidEligibleDays.jsp?empid="+a+"&leavesalarypaid="+b, true);
  		x.send();
    }
  
	function getAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  				
  				var lsexpensedocNoItems = items[7];
  				var lsexpenseaccountIdItems  = items[8];
  				var lsexpenseaccountItems = items[9];
  				var lsexpenseaccountTypeItems = items[10];
  				var lsexpenseaccountCurIdItems  = items[11];
  				var lsexpenseaccountRateItems = items[12];
  				var lsexpenseaccCurrTypeItems = items[13];
  				
  				var lsprovisiondocNoItems = items[14];
  				var lsprovisionaccountIdItems  = items[15];
  				var lsprovisionaccountItems = items[16];
  				var lsprovisionaccountTypeItems = items[17];
  				var lsprovisionaccountCurIdItems  = items[18];
  				var lsprovisionaccountRateItems = items[19];
  				var lsprovisionaccCurrTypeItems = items[20];
  				
  				var travelexpensedocNoItems = items[21];
  				var travelexpenseaccountIdItems  = items[22];
  				var travelexpenseaccountItems = items[23];
  				var travelexpenseaccountTypeItems = items[24];
  				var travelexpenseaccountCurIdItems  = items[25];
  				var travelexpenseaccountRateItems = items[26];
  				var travelexpenseaccCurrTypeItems = items[27];
  				
  				var travelprovisiondocNoItems = items[28];
  				var travelprovisionaccountIdItems  = items[29];
  				var travelprovisionaccountItems = items[30];
  				var travelprovisionaccountTypeItems = items[31];
  				var travelprovisionaccountCurIdItems  = items[32];
  				var travelprovisionaccountRateItems = items[33];
  				var travelprovisionaccCurrTypeItems = items[34];
  				
  				var lsexpensebalancedocNoItems = items[35];
  				var lsexpensebalanceaccountIdItems  = items[36];
  				var lsexpensebalanceaccountItems = items[37];
  				var lsexpensebalanceaccountTypeItems = items[38];
  				var lsexpensebalanceaccountCurIdItems  = items[39];
  				var lsexpensebalanceaccountRateItems = items[40];
  				var lsexpensebalanceaccCurrTypeItems = items[41];
  			
  			    $('#txtempaccdocno').val(docNoItems);	
  			    $('#txtempaccid').val(accountIdItems);
  			    $('#txtempaccname').val(accountItems);
  			  	$('#txtempaccatype').val(accountTypeItems);
			    $('#txtempacccurid').val(accountCurIdItems);
			    $('#txtempaccrate').val(accountRateItems);
			    $('#txtempacctype').val(accCurrTypeItems);
			    
			    $('#txtlsexpenseaccdocno').val(lsexpensedocNoItems);	
  			    $('#txtlsexpenseaccid').val(lsexpenseaccountIdItems);
  			    $('#txtlsexpenseaccname').val(lsexpenseaccountItems);
  			  	$('#txtlsexpenseaccatype').val(lsexpenseaccountTypeItems);
			    $('#txtlsexpenseacccurid').val(lsexpenseaccountCurIdItems);
			    $('#txtlsexpenseaccrate').val(lsexpenseaccountRateItems);
			    $('#txtlsexpenseacctype').val(lsexpenseaccCurrTypeItems);
			    
			    $('#txtlsprovisionaccdocno').val(lsprovisiondocNoItems);	
  			    $('#txtlsprovisionaccid').val(lsprovisionaccountIdItems);
  			    $('#txtlsprovisionaccname').val(lsprovisionaccountItems);
  			  	$('#txtlsprovisionaccatype').val(lsprovisionaccountTypeItems);
			    $('#txtlsprovisionacccurid').val(lsprovisionaccountCurIdItems);
			    $('#txtlsprovisionaccrate').val(lsprovisionaccountRateItems);
			    $('#txtlsprovisionacctype').val(lsprovisionaccCurrTypeItems);
			    
			    $('#txttravelexpenseaccdocno').val(travelexpensedocNoItems);	
  			    $('#txttravelexpenseaccid').val(travelexpenseaccountIdItems);
  			    $('#txttravelexpenseaccname').val(travelexpenseaccountItems);
  			  	$('#txttravelexpenseaccatype').val(travelexpenseaccountTypeItems);
			    $('#txttravelexpenseacccurid').val(travelexpenseaccountCurIdItems);
			    $('#txttravelexpenseaccrate').val(travelexpenseaccountRateItems);
			    $('#txttravelexpenseacctype').val(travelexpenseaccCurrTypeItems);
			    
			    $('#txttravelprovisionaccdocno').val(travelprovisiondocNoItems);	
  			    $('#txttravelprovisionaccid').val(travelprovisionaccountIdItems);
  			    $('#txttravelprovisionaccname').val(travelprovisionaccountItems);
  			  	$('#txttravelprovisionaccatype').val(travelprovisionaccountTypeItems);
			    $('#txttravelprovisionacccurid').val(travelprovisionaccountCurIdItems);
			    $('#txttravelprovisionaccrate').val(travelprovisionaccountRateItems);
			    $('#txttravelprovisionacctype').val(travelprovisionaccCurrTypeItems);
			    
			    $('#txtlsexpensebalanceaccdocno').val(lsexpensebalancedocNoItems);	
  			    $('#txtlsexpensebalanceaccid').val(lsexpensebalanceaccountIdItems);
  			    $('#txtlsexpensebalanceaccname').val(lsexpensebalanceaccountItems);
  			  	$('#txtlsexpensebalanceaccatype').val(lsexpensebalanceaccountTypeItems);
			    $('#txtlsexpensebalanceacccurid').val(lsexpensebalanceaccountCurIdItems);
			    $('#txtlsexpensebalanceaccrate').val(lsexpensebalanceaccountRateItems);
			    $('#txtlsexpensebalanceacctype').val(lsexpensebalanceaccCurrTypeItems);
			    
  		}
  		}
  		x.open("GET", "getAccounts.jsp?empId="+a+"&date="+b, true);
  		x.send();
    }
	
	function getLastTerminalBenefitsDone(date){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				 items = items.split('***');
			     $('#txtchkgridload').val(items[0]);
			     $('#txtchkdate').val(items[1]);
			     $('#txtchksalarypaid').val(items[3]);
			   
			     document.getElementById("errormsg").innerText="Terminal Benefits done till "+items[2]+".";
			     
			   if(parseInt($('#txtchkdate').val())==0){
				  if(parseInt($('#txtchkgridload').val())==1){
					if(parseInt($('#txtchksalarypaid').val())==0){  
					    
						 $("#overlay, #PleaseWait").show();
						 getLeaveTravelDetails($("#txtemployeedocno").val(),$("#notifyDate").val());
						 getAccounts($("#txtemployeedocno").val(),$("#notifyDate").val());
						  
						 $("#leaveTravelDisbursementGridID").jqxGrid('clear');
						 $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
						 $("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
					   
					    $('#txtchkgridload').val('');
					    $('#txtgridload').val(1);
					 } else {
						$.messager.alert('Message','Payroll Processing Pending.','warning');
						
						$("#leaveTravelDisbursementGridID").jqxGrid('clear');
						$("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
						$("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
						 
						return;
					} 
				  } else if(parseInt($('#txtchkgridload').val())==0) {
						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
						$("#leaveTravelDisbursementGridID").jqxGrid('clear');
						$("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
						$("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
						return;
				 } else if(parseInt($('#txtchkgridload').val())==2) {
					    $.messager.alert('Message','Terminal Benefits Already Done.','warning');
						$("#leaveTravelDisbursementGridID").jqxGrid('clear');
						$("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
						$("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
						return;
					}
			  }else {
						$("#terminationGridID").jqxGrid('clear'); 
			            $("#terminationGridID").jqxGrid('addrow', null, {});
			            $("#terminationAccountsGridID").jqxGrid('clear');
						$("#terminationGridID").jqxGrid({ disabled: true});
						$("#terminationAccountsGridID").jqxGrid({ disabled: true});
					}
				}
			}
			x.open("GET", "getLastTerminalBenefitsDone.jsp?date="+date+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val(), true);
			x.send();
		}
	
     function getEmployeeDetails(event){
        var x= event.keyCode;
        if(x==114){
    	  employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
     }
     
     function partialpaymentcheck(){
 		 if(document.getElementById("chckpartialpayment").checked){
 			 document.getElementById("hidchckpartialpayment").value = 1;
 			 
 			 if(parseFloat($('#txtleavesalarycalculated').val())<parseFloat($("#txtleavesalarytobepaid").val())) {
 				  funRoundAmt(0,"txtleavesalarytobepaid");
 				  $.messager.alert('Message','Leave Salary Paid should not be greater than Leave Salary [Calculated] .','warning');
 				  return;
 			 }
 			
 			 $("#overlay, #PleaseWait").show();
 			 getLeavePaidEligibleDays($("#txtemployeedocno").val(),$("#txtleavesalarytobepaid").val());
 		 }
 		 else{
 			 document.getElementById("hidchckpartialpayment").value = 0;
 			 funRoundAmt(parseFloat($('#txtalreadyprovisioneligibledays').val())+parseFloat($('#txtcurrentprovisioneligibledays').val()),"txtleavesalarypaideligibledays");
 		 }
 	 }
     
     function funLeaveSalaryToBePaid(){
    	  $("#leaveTravelDisbursementGridID").jqxGrid('clear');
		  $("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
		  funRoundAmt(0,"txtdrtotal");
		  funRoundAmt(0,"txtcrtotal");
     }
	
     function funTravelCurrentExpenses() {
		  if(!($('#txttravelticketvalue').val().trim()=="0" || $('#txttravelticketvalue').val().trim()=="0.00" || $('#txttravelticketvalue').val().trim()=="")){
		  	  funRoundAmt((parseFloat($('#txttravelticketvalue').val())-parseFloat($('#txttravelalreadyposted').val())),"txttravelcurrentexpenses");
		  } else {
			  funRoundAmt($('#txttravelalreadyposted').val(),"txttravelcurrentexpenses");
		  }
		  $("#leaveTravelDisbursementGridID").jqxGrid('clear');
		  $("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
	  }
	  
	  function funProcessBtn(){
		  
		  if($('#txtemployeedocno').val()==''){
			  $.messager.alert('Message','Employee is Mandatory.','warning');
			  return;
		  }
		  
	      var paydate = $('#notifyDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  
		  $('#hidchckpartialpayment').val(0);
		  document.getElementById("chckpartialpayment").checked = false;
			
		  var date = $('#notifyDate').val();
		  getLastTerminalBenefitsDone(date);
		  
	  }
	  
	 function funCalculateBtn(){
		  
		  if($('#txtemployeedocno').val()==''){
			  $.messager.alert('Message','Employee is Mandatory.','warning');
			  return;
		  }
	
		  /* if($('#txttravelticketvalue').val().trim()=="0" || $('#txttravelticketvalue').val().trim()=="0.00" || $('#txttravelticketvalue').val().trim()==""){
			  	$.messager.alert('Warning','Enter Ticket Amount to be Calculated.');
			  	document.getElementById("txttravelticketvalue").focus();
				return false;
		  } */
		  
		  if($('#txtleavesalarytobepaid').val()!='' && $('#txttravelcurrentexpenses').val()!=''){
			  
			  $('#btnExcelExporter').hide();
			  $("#leaveTravelDisbursementGridID").jqxGrid('clear');
			  $("#leaveTravelDisbursementGridID").jqxGrid({ disabled: false});
			  
			  if(!($('#txtleavesalarytobepaid').val().trim()=="0" || $('#txtleavesalarytobepaid').val().trim()=="0.00" || $('#txtleavesalarytobepaid').val().trim()=="")){
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {});
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {});
			  }
			  
			  if(!($('#txttravelticketvalue').val().trim()=="0" || $('#txttravelticketvalue').val().trim()=="0.00" || $('#txttravelticketvalue').val().trim()=="")){
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
				  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
			  }
			  
			  var leavesalaryProvision = 0;
			  var leavesalarycalculated=$('#txtleavesalarycalculated').val();
			  var leavesalarytobepaid=$('#txtleavesalarytobepaid').val();
			  var leavesalarypartialpayment=$('#hidchckpartialpayment').val();
			  if(parseInt(leavesalarypartialpayment)==0) {
				  leavesalaryProvision = leavesalarycalculated;
			  } else {
				  leavesalaryProvision = leavesalarytobepaid;
			  }

			  var row=0;
			  var leavesalaryexpense=(parseFloat($('#txtleavesalarytobepaid').val()) + parseFloat($('#txtleavesalarynettobeprovided').val()))-(parseFloat(leavesalaryProvision) + parseFloat($('#txtleavesalarynettobeprovided').val()));
			  if(parseFloat(leavesalaryexpense)>0){
				  leaveexpensedebitamount=leavesalaryexpense;
				  leaveexpensecreditamount="0.00";
				  
			  } else {
				  leaveexpensedebitamount="0.00";
				  leaveexpensecreditamount=parseFloat(leavesalaryexpense)*-1;
			  }
			  
			  var travelticketvalue=$('#txttravelticketvalue').val();
			  if(parseFloat(travelticketvalue)<0){ 
				  travelticketvalue=parseFloat(travelticketvalue)*-1;
			  }
			  
			  var travelalreadyposted=$('#txttravelalreadyposted').val();
			  if(parseFloat(travelalreadyposted)<0){ 
				  travelalreadyposted=parseFloat(travelalreadyposted)*-1;
			  }
			  
			  var travelexpense=(parseFloat($('#txttravelticketvalue').val()) - parseFloat($('#txttravelalreadyposted').val()));
			  if(parseFloat(travelexpense)>0){
				  travelexpensedebitamount=travelexpense;
				  travelexpensecreditamount="0.00";
				  
			  } else {
				  travelexpensedebitamount="0.00";
				  travelexpensecreditamount=parseFloat(travelexpense)*-1;
			  } 
			  
			  if(!($('#txtleavesalarytobepaid').val().trim()=="0" || $('#txtleavesalarytobepaid').val().trim()=="0.00" || $('#txtleavesalarytobepaid').val().trim()=="")){
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "acno", $('#txtempaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "account", $('#txtempaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "codeno", $('#txtempaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "debit", "0.00");
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "credit", $('#txtleavesalarytobepaid').val());
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "acno", $('#txtlsprovisionaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "account", $('#txtlsprovisionaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "codeno", $('#txtlsprovisionaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "debit", leavesalaryProvision);
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "credit", "0.00");
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "acno", $('#txtlsprovisionaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "account", $('#txtlsprovisionaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "codeno", $('#txtlsprovisionaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "debit", "0.00");
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "credit", $('#txtleavesalarynettobeprovided').val());
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 3, "acno", $('#txtlsexpenseaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 3, "account", $('#txtlsexpenseaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 3, "codeno", $('#txtlsexpenseaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 3, "debit", $('#txtleavesalarynettobeprovided').val());		  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 3, "credit", "0.00");
				  
				  if(parseFloat(leavesalaryexpense)!=0){
					  $("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
					  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 4, "acno", $('#txtlsexpensebalanceaccdocno').val());
					  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 4, "account", $('#txtlsexpensebalanceaccid').val());
					  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 4, "codeno", $('#txtlsexpensebalanceaccname').val());
					  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 4, "debit", leaveexpensedebitamount);
					  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 4, "credit", leaveexpensecreditamount);
					  row=1;
				  }
			  
			  } else if($('#txtleavesalarytobepaid').val().trim()=="0" || $('#txtleavesalarytobepaid').val().trim()=="0.00" || $('#txtleavesalarytobepaid').val().trim()=="") {
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "acno", $('#txtempaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "account", $('#txtempaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "codeno", $('#txtempaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "debit", "0.00");
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 0, "credit", travelticketvalue);
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "acno", $('#txttravelprovisionaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "account", $('#txttravelprovisionaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "codeno", $('#txttravelprovisionaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "debit", travelalreadyposted);
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 1, "credit", "0.00");
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "acno", $('#txttravelexpenseaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "account", $('#txttravelexpenseaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "codeno", $('#txttravelexpenseaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "debit", travelexpensedebitamount);
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', 2, "credit", travelexpensecreditamount);
				  
			  }
			  
			  if(!($('#txttravelticketvalue').val().trim()=="0" || $('#txttravelticketvalue').val().trim()=="0.00" || $('#txttravelticketvalue').val().trim()=="")){
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(4)+parseFloat(row) , "acno", $('#txtempaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(4)+parseFloat(row) , "account", $('#txtempaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(4)+parseFloat(row) , "codeno", $('#txtempaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(4)+parseFloat(row) , "debit", "0.00");
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(4)+parseFloat(row) , "credit", travelticketvalue);
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(5)+parseFloat(row) , "acno", $('#txttravelprovisionaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(5)+parseFloat(row) , "account", $('#txttravelprovisionaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(5)+parseFloat(row) , "codeno", $('#txttravelprovisionaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(5)+parseFloat(row) , "debit", travelalreadyposted);
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(5)+parseFloat(row) , "credit", "0.00");
				  
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(6)+parseFloat(row) , "acno", $('#txttravelexpenseaccdocno').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(6)+parseFloat(row) , "account", $('#txttravelexpenseaccid').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(6)+parseFloat(row) , "codeno", $('#txttravelexpenseaccname').val());
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(6)+parseFloat(row) , "debit", travelexpensedebitamount);
				  $("#leaveTravelDisbursementGridID").jqxGrid('setcellvalue', parseFloat(6)+parseFloat(row) , "credit", travelexpensecreditamount);
			  
			  }
			  
			  var rows = $("#leaveTravelDisbursementGridID").jqxGrid('getrows');
	      	  if(parseInt(rows.length)>0) {
	      		
		            var debit1="";var credit1="";
		            var debit=$('#leaveTravelDisbursementGridID').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
		            debit1=(debit.sum).replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		            var credit=$('#leaveTravelDisbursementGridID').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
		            credit1=(credit.sum).replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		            
		            if(!isNaN(debit1)){
		            	funRoundAmt(debit1,"txtdrtotal");
		      		} else {
		      			funRoundAmt("0.00","txtdrtotal");
		      		  }
		 
		          if(!isNaN(credit1)){
		    	        funRoundAmt(credit1,"txtcrtotal");
		      		 } else{
		    	        funRoundAmt("0.00","txtcrtotal");
				    }
	      	  }
     	  
		  } else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
		  
	  }
	  
	 function funReadOnly(){
			$('#frmleaveTravelDisbursement input').attr('readonly', true );
			$("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
			$('#leaveTravelDisbursementDate').jqxDateTimeInput({disabled: true});
			$('#notifyDate').jqxDateTimeInput({disabled: true});
			$('#chckpartialpayment').attr('disabled', true);
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();$('#btnExcelExporter').hide();
		 	$('#frmleaveTravelDisbursement input').attr('readonly', false );
			$("#leaveTravelDisbursementGridID").jqxGrid({ disabled: true});
			$('#leaveTravelDisbursementDate').jqxDateTimeInput({disabled: false});
			$('#notifyDate').jqxDateTimeInput({disabled: false});
			$('#chckpartialpayment').attr('disabled', false);
			
			$('#txtemployeeid').attr('readonly', true );
			$('#txtemployeename').attr('readonly', true );
			$('#txtalreadyprovisioneligibledays').attr('readonly', true );
			$('#txtcurrentprovisioneligibledays').attr('readonly', true );
			$('#txttotaleligibledays').attr('readonly', true );
			$('#txtleavesalarycalculated').attr('readonly', true );
			$('#txtleavesalaryalreadyprovided').attr('readonly', true );
			$('#txtleavesalarynettobeprovided').attr('readonly', true );
			$('#txtleavesalarypaideligibledays').attr('readonly', true );
			$('#txttravelalreadyposted').attr('readonly', true );
			$('#txttravelcurrentexpenses').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#docno').attr('readonly', true );
			
			if ($("#mode").val() == "A") {
				$('#leaveTravelDisbursementDate').val(new Date());
			    $('#notifyDate').val(new Date());
			    $('#hidchckpartialpayment').val(0);
				document.getElementById("chckpartialpayment").checked = false;
				 
				$("#leaveTravelDisbursementGridID").jqxGrid('clear');
				$("#leaveTravelDisbursementGridID").jqxGrid('addrow', null, {}); 
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('ltdMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#leaveTravelDisbursementDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	var rows = $("#leaveTravelDisbursementGridID").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
				var paydate = $('#notifyDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         } 
		         
		         employee=document.getElementById("txtemployeedocno").value;
				 if(employee==""){
					 document.getElementById("errormsg").innerText="Employee is Mandatory.";
					 return 0;
				 }
		         
		         var drtot = parseFloat(document.getElementById("txtdrtotal").value);
			 	 var crtot = parseFloat(document.getElementById("txtcrtotal").value);
			 	 if(drtot>crtot || drtot<crtot){
			 		  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
		              return 0;
			 	 }
			 		
		 		 if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 			  	document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              	return 0;
			 	 }
			 		
			     document.getElementById("errormsg").innerText="";
			    	
	    	    /* Validation Ends*/
	 		   
		         /* Account Details Grid Saving */
		    	 var rows = $("#leaveTravelDisbursementGridID").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chks=rows[i].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
						
					var amount=0,id=1;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 id=-1;
					}
					
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 id=1;
					}
					
					newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
		 		/* Account Details Grid Saving Ends */
		 		
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidleaveTravelDisbursementDate').val()){
				 $("#leaveTravelDisbursementDate").jqxDateTimeInput('val', $('#hidleaveTravelDisbursementDate').val());
			  }
		  
		  if($('#hidnotifyDate').val()){
				 $("#notifyDate").jqxDateTimeInput('val', $('#hidnotifyDate').val());
			  }
		  
		  if(document.getElementById("hidchckpartialpayment").value==1){
	 			 document.getElementById("chckpartialpayment").checked = true;
	 	  }
 		  else if(document.getElementById("hidchckpartialpayment").value==0){
 			document.getElementById("chckpartialpayment").checked = false;
 		  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
	         
			 var indexVal1 = document.getElementById("docno").value;
	         var indexVal2 = document.getElementById("txttrno").value;
	         if(indexVal1>0){
	         	$("#leaveTravelDisbursementDiv").load("leaveTravelDisbursementGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
	         }  
		}	
	  
	  function funExcelExporter(){
			 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	 JSONToCSVCon(data, 'LeaveTravelDisbursement', true);
			 } else {
				 $("#leaveTravelDisbursementGridID").jqxGrid('exportdata', 'xls', 'LeaveTravelDisbursement');
			 }
		 } 
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveLeaveTravelDisbursement");
			     $("#docno").prop("disabled", false);
					  
				 var win= window.open(reurl[0]+"printLeaveTravelDisbursement?trno="+document.getElementById("txttrno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();
						 
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
</script>

<style>
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}

.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmleaveTravelDisbursement" action="saveLeaveTravelDisbursement" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>

<fieldset style="background-color: #EBDEF0;">
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="17%"><div id="leaveTravelDisbursementDate" name="leaveTravelDisbursementDate" value='<s:property value="leaveTravelDisbursementDate"/>'></div>
    <input type="hidden" id="hidleaveTravelDisbursementDate" name="hidleaveTravelDisbursementDate" value='<s:property value="hidleaveTravelDisbursementDate"/>'/></td>
    <td colspan="2" align="right">Calculated UpTo</td>
    <td width="17%"><div id="notifyDate" name="notifyDate" value='<s:property value="notifyDate"/>'></div>
    <input type="hidden" id="hidnotifyDate" name="hidnotifyDate" value='<s:property value="hidnotifyDate"/>'/></td>
    <td width="15%" align="right">Doc No</td>
    <td width="18%"><input type="text" id="docno" name="txtleavetraveldisbursementdocno" value='<s:property value="txtleavetraveldisbursementdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Employee ID</td>
    <td><input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3 to Search" style="width:94%;" onkeydown="getEmployeeDetails(event);" value='<s:property value="txtemployeeid"/>'/></td>
    <td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:94%;" value='<s:property value="txtemployeename"/>' tabindex="-1"/>
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
    
    <td align="right"><button type="button" id="btnProcessing" title="Process"  style="border:none;background:none;" onclick="funProcessBtn();">
      						 <img alt="Process" src="<%=contextPath%>/icons/process2.png" width="16" height="16">
      					</button></td>
                        <td align="center">
                        <button type="button" class="icon" id="btnCalculate" title="Calculate" style="align:right;border:none;background:none;" onclick="funCalculateBtn();">
							<img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
						</button></td>
  <td align="left"><button type="button" class="icon" id="btnExcelExporter" title="Export current Document to Excel" onclick="funExcelExporter();">
      						 <img alt="Export current Document to Excel" src="<%=contextPath%>/icons/excel_new.png">
      					</button></td>
  </tr>
</table>

</fieldset>

<table width="100%">
<tr>
<td width="50%">
<fieldset style="background-color: #ECF8E0;">
<legend><font style="font-family: comic sans ms;font-weight: bold;">Leave Disbursement</font></legend>
<table width="100%">
  <tr>
    <td colspan="2" align="right">Already Provision [Eligible Days]</td>
    <td width="28%"><input type="text" id="txtalreadyprovisioneligibledays" name="txtalreadyprovisioneligibledays" style="width:50%;" value='<s:property value="txtalreadyprovisioneligibledays"/>' tabindex="-1"/></td>
    <td width="24%" align="right">Current [Eligible Days]</td>
    <td width="25%"><input type="text" id="txtcurrentprovisioneligibledays" name="txtcurrentprovisioneligibledays" style="width:50%;" value='<s:property value="txtcurrentprovisioneligibledays"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td colspan="2" align="right">Total [Eligible Days]</td>
    <td><input type="text" id="txttotaleligibledays" name="txttotaleligibledays" style="width:50%;" value='<s:property value="txttotaleligibledays"/>' tabindex="-1"/></td>
    <td align="right">Leave Salary [Calculated]</td>
    <td><input type="text" id="txtleavesalarycalculated" name="txtleavesalarycalculated" style="width:80%;text-align: right;" value='<s:property value="txtleavesalarycalculated"/>' tabindex="-1"/></td>
    </tr>
  <tr>
    <td colspan="2" align="right">Already Posted</td>
    <td><input type="text" id="txtleavesalaryalreadyprovided" name="txtleavesalaryalreadyprovided" style="width:80%;text-align: right;" value='<s:property value="txtleavesalaryalreadyprovided"/>' tabindex="-1"/></td>
    <td align="right">Net to be Posted</td>
    <td><input type="text" id="txtleavesalarynettobeprovided" name="txtleavesalarynettobeprovided" style="width:80%;text-align: right;" value='<s:property value="txtleavesalarynettobeprovided"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td width="9%" align="left"><input type="checkbox" id="chckpartialpayment" name="chckpartialpayment" value="" onchange="partialpaymentcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Partial
                                 <input type="hidden" id="hidchckpartialpayment" name="hidchckpartialpayment" value='<s:property value="hidchckpartialpayment"/>'/></td>
    <td width="14%" align="right">Leave Salary  Paid</td>
    <td><input type="text" id="txtleavesalarytobepaid" name="txtleavesalarytobepaid" style="width:80%;text-align: right;" onblur="funRoundAmt(this.value,this.id);funLeaveSalaryToBePaid();partialpaymentcheck();" value='<s:property value="txtleavesalarytobepaid"/>'/></td>
    <td align="right">Leave Salary  Paid [Eligible Days]</td>
    <td><input type="text" id="txtleavesalarypaideligibledays" name="txtleavesalarypaideligibledays" style="width:50%;" value='<s:property value="txtleavesalarypaideligibledays"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset style="background-color: #F8E0F7;">
<legend><font style="font-family: comic sans ms;font-weight: bold;">Travel Disbursement</font></legend>
<table width="100%">
  <tr>
    <td width="22%" align="right">Ticket Value</td>
    <td width="78%"><input type="text" id="txttravelticketvalue" name="txttravelticketvalue" style="width:30%;text-align: right;" onblur="funRoundAmt(this.value,this.id);funTravelCurrentExpenses();" value='<s:property value="txttravelticketvalue"/>'/></td>
  </tr>
  <tr>
    <td align="right">Already Posted</td>
    <td><input type="text" id="txttravelalreadyposted" name="txttravelalreadyposted" style="width:30%;text-align: right;" value='<s:property value="txttravelalreadyposted"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Current Expenses</td>
    <td><input type="text" id="txttravelcurrentexpenses" name="txttravelcurrentexpenses" style="width:30%;text-align: right;" value='<s:property value="txttravelcurrentexpenses"/>' tabindex="-1"/></td>
  </tr>
</table><br/><br/>
</fieldset>
</td>
</tr></table>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Accounts</font></legend>
<div id="leaveTravelDisbursementDiv"><jsp:include page="leaveTravelDisbursementGrid.jsp"></jsp:include></div>
</fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtgridload" name="txtgridload"  value='<s:property value="txtgridload"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid"  value='<s:property value="txtchksalarypaid"/>'/>
<input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
<input type="hidden" id="txtempaccdocno" name="txtempaccdocno"  value='<s:property value="txtempaccdocno"/>'/>
<input type="hidden" id="txtempaccid" name="txtempaccid"  value='<s:property value="txtempaccid"/>'/>
<input type="hidden" id="txtempaccname" name="txtempaccname"  value='<s:property value="txtempaccname"/>'/>
<input type="hidden" id="txtempaccatype" name="txtempaccatype"  value='<s:property value="txtempaccatype"/>'/>
<input type="hidden" id="txtempacccurid" name="txtempacccurid"  value='<s:property value="txtempacccurid"/>'/>
<input type="hidden" id="txtempaccrate" name="txtempaccrate"  value='<s:property value="txtempaccrate"/>'/>
<input type="hidden" id="txtempacctype" name="txtempacctype"  value='<s:property value="txtempacctype"/>'/>
<input type="hidden" id="txtlsexpenseaccdocno" name="txtlsexpenseaccdocno"  value='<s:property value="txtlsexpenseaccdocno"/>'/>
<input type="hidden" id="txtlsexpenseaccid" name="txtlsexpenseaccid"  value='<s:property value="txtlsexpenseaccid"/>'/>
<input type="hidden" id="txtlsexpenseaccname" name="txtlsexpenseaccname"  value='<s:property value="txtlsexpenseaccname"/>'/>
<input type="hidden" id="txtlsexpenseaccatype" name="txtlsexpenseaccatype"  value='<s:property value="txtlsexpenseaccatype"/>'/>
<input type="hidden" id="txtlsexpenseacccurid" name="txtlsexpenseacccurid"  value='<s:property value="txtlsexpenseacccurid"/>'/>
<input type="hidden" id="txtlsexpenseaccrate" name="txtlsexpenseaccrate"  value='<s:property value="txtlsexpenseaccrate"/>'/>
<input type="hidden" id="txtlsexpenseacctype" name="txtlsexpenseacctype"  value='<s:property value="txtlsexpenseacctype"/>'/>		    
<input type="hidden" id="txtlsprovisionaccdocno" name="txtlsprovisionaccdocno"  value='<s:property value="txtlsprovisionaccdocno"/>'/>
<input type="hidden" id="txtlsprovisionaccid" name="txtlsprovisionaccid"  value='<s:property value="txtlsprovisionaccid"/>'/>
<input type="hidden" id="txtlsprovisionaccname" name="txtlsprovisionaccname"  value='<s:property value="txtlsprovisionaccname"/>'/>
<input type="hidden" id="txtlsprovisionaccatype" name="txtlsprovisionaccatype"  value='<s:property value="txtlsprovisionaccatype"/>'/>
<input type="hidden" id="txtlsprovisionacccurid" name="txtlsprovisionacccurid"  value='<s:property value="txtlsprovisionacccurid"/>'/>
<input type="hidden" id="txtlsprovisionaccrate" name="txtlsprovisionaccrate"  value='<s:property value="txtlsprovisionaccrate"/>'/>
<input type="hidden" id="txtlsprovisionacctype" name="txtlsprovisionacctype"  value='<s:property value="txtlsprovisionacctype"/>'/>
<input type="hidden" id="txttravelexpenseaccdocno" name="txttravelexpenseaccdocno"  value='<s:property value="txttravelexpenseaccdocno"/>'/>
<input type="hidden" id="txttravelexpenseaccid" name="txttravelexpenseaccid"  value='<s:property value="txttravelexpenseaccid"/>'/>
<input type="hidden" id="txttravelexpenseaccname" name="txttravelexpenseaccname"  value='<s:property value="txttravelexpenseaccname"/>'/>
<input type="hidden" id="txttravelexpenseaccatype" name="txttravelexpenseaccatype"  value='<s:property value="txttravelexpenseaccatype"/>'/>
<input type="hidden" id="txttravelexpenseacccurid" name="txttravelexpenseacccurid"  value='<s:property value="txttravelexpenseacccurid"/>'/>
<input type="hidden" id="txttravelexpenseaccrate" name="txttravelexpenseaccrate"  value='<s:property value="txttravelexpenseaccrate"/>'/>
<input type="hidden" id="txttravelexpenseacctype" name="txttravelexpenseacctype"  value='<s:property value="txttravelexpenseacctype"/>'/>
<input type="hidden" id="txttravelprovisionaccdocno" name="txttravelprovisionaccdocno"  value='<s:property value="txttravelprovisionaccdocno"/>'/>
<input type="hidden" id="txttravelprovisionaccid" name="txttravelprovisionaccid"  value='<s:property value="txttravelprovisionaccid"/>'/>
<input type="hidden" id="txttravelprovisionaccname" name="txttravelprovisionaccname"  value='<s:property value="txttravelprovisionaccname"/>'/>
<input type="hidden" id="txttravelprovisionaccatype" name="txttravelprovisionaccatype"  value='<s:property value="txttravelprovisionaccatype"/>'/>
<input type="hidden" id="txttravelprovisionacccurid" name="txttravelprovisionacccurid"  value='<s:property value="txttravelprovisionacccurid"/>'/>
<input type="hidden" id="txttravelprovisionaccrate" name="txttravelprovisionaccrate"  value='<s:property value="txttravelprovisionaccrate"/>'/>
<input type="hidden" id="txttravelprovisionacctype" name="txttravelprovisionacctype"  value='<s:property value="txttravelprovisionacctype"/>'/>
<input type="hidden" id="txtlsexpensebalanceaccdocno" name="txtlsexpensebalanceaccdocno"  value='<s:property value="txtlsexpensebalanceaccdocno"/>'/>
<input type="hidden" id="txtlsexpensebalanceaccid" name="txtlsexpensebalanceaccid"  value='<s:property value="txtlsexpensebalanceaccid"/>'/>
<input type="hidden" id="txtlsexpensebalanceaccname" name="txtlsexpensebalanceaccname"  value='<s:property value="txtlsexpensebalanceaccname"/>'/>
<input type="hidden" id="txtlsexpensebalanceaccatype" name="txtlsexpensebalanceaccatype"  value='<s:property value="txtlsexpensebalanceaccatype"/>'/>
<input type="hidden" id="txtlsexpensebalanceacccurid" name="txtlsexpensebalanceacccurid"  value='<s:property value="txtlsexpensebalanceacccurid"/>'/>
<input type="hidden" id="txtlsexpensebalanceaccrate" name="txtlsexpensebalanceaccrate"  value='<s:property value="txtlsexpensebalanceaccrate"/>'/>
<input type="hidden" id="txtlsexpensebalanceacctype" name="txtlsexpensebalanceacctype"  value='<s:property value="txtlsexpensebalanceacctype"/>'/>	
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div>
</div>	
</div>
</body>
</html>