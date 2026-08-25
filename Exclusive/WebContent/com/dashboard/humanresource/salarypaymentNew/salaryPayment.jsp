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

.mySaveButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77d42a), color-stop(1, #5cb811));
	background:-moz-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-webkit-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-o-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-ms-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:linear-gradient(to bottom, #77d42a 5%, #5cb811 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77d42a', endColorstr='#5cb811',GradientType=0);
	background-color:#77d42a;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #268a16;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px -1px 0px #aade7c;
}
.mySaveButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cb811), color-stop(1, #77d42a));
	background:-moz-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-webkit-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-o-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-ms-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:linear-gradient(to bottom, #5cb811 5%, #77d42a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cb811', endColorstr='#77d42a',GradientType=0);
	background-color:#5cb811;
}
.mySaveButton:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		
		 /* Searching Window */
     	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#accountDetailsWindow').jqxWindow('close');
  		 
  		 $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#establishedCodeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtaccount').dblclick(function(){
	    	 accountSearchContent("accountDetailsSearch.jsp");
		 });
	     
	     $('#txtbankaccount').dblclick(function(){
	    	 accountSearchContent("bankAccountDetailsSearch.jsp");
		 });
	     
	     $('#txtestablishmentcode').dblclick(function(){
	    	 establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
		 });
	     
	     $("#salaryPaymentDetailsGridID").jqxGrid({ height: 532 });
	     $('#salaryPaymentDetailsGridID').jqxGrid({ selectionmode: 'singlerow'});
	     $("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	     $('#btnSaveSalaryPayment').attr('disabled', true );
	     $('#btnSifSalaryPayment').attr('disabled', true );
	     $('#date').jqxDateTimeInput({disabled: true});
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function establishedCodeSearchContent(url) {
	 	$('#establishedCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
		$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						funreload(event);
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	
	function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
				
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
	
	function getSalesAgent() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesAgentItems = items[0].split(",");
				var salesAgentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesAgentItems.length; i++) {
					 optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
							+ salesAgentItems[i] + '</option>';
				}
				$("select#cmbempagentid").html(optionssalesagent);
				
			} else {
			}
		}
		x.open("GET", "getSalesAgent.jsp", true);
		x.send();
	}
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("accountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getBankAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("bankAccountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getEstablishmentCode(event){
        var x= event.keyCode;
        if(x==114){
        	establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
        }
        else{}
        }

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#txtestablishmentcode').val('');
	    $('#txtaccount').val('');$('#txtaccountname').val('');$('#txtaccountdocno').val('');$('#date').val(new Date());$('#hiddate').val('');
	    $('#cmbempcategory').val('');$('#cmbempagentid').val('');
	    $('#txtbankaccount').val('');$('#txtbankaccountname').val('');$('#txtbankaccountdocno').val('');
	    $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
	    $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	    $("#postedSalaryGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: true});
	    $('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
	    
		if (document.getElementById("txtaccount").value == "") {
	        $('#txtaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtaccountname').attr('placeholder', 'Employee Name');
	    }
		
		if (document.getElementById("txtbankaccountdocno").value == "") {
	        $('#txtbankaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtbankaccountname').attr('placeholder', 'Bank Account');
	    }
		
		if (document.getElementById("txtestablishmentcode").value == "") {
	        $('#txtestablishmentcode').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var category = $('#cmbempcategory').val();
		 var agent = $('#cmbempagentid').val();
		 var establishmentcode = $('#txtestablishmentcode').val();
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 $('#btnSifSalaryPayment').attr('disabled', true );
		 $('#date').val(new Date());$('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
		 $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');
		 $("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
		 $("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: true});$('#txtselectedemployees').val('');
		 $("#postedSalaryDiv").load("postedSalaryGrid.jsp?branchval="+branchval+'&year='+year+'&month='+month+'&category='+category+'&agent='+agent+'&establishmentCode='+establishmentcode.replace(/ /g, "%20")+'&check=1');
	}
	
	function funCalculate(){
	
		/* if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }*/
		
		if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		if($('#txtaccountdocno').val()==''){
			 $.messager.alert('Message','Please Choose a Payable Account & Then Calculate.','warning');
			 return 0;
		 } 
		funsaveGrid();
		
		var rows = $('#salaryPaymentJVGridID').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#salaryPaymentJVGridID").jqxGrid('clear');
			$('#txtselectedemployees').val('');
		} 
		
		$("#overlay, #PleaseWait").show();
		
		$("#salaryPaymentJVGridID").jqxGrid({ disabled: false});
		
		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
		
		if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var selectedrows=$("#salaryPaymentDetailsGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var i=0;var tempemp="",tempemp1="";
        var j=0,k=0;
	    for (i = 0; i < rows.length; i++){
				if(selectedrows[j]==i){
					
					if(i==0){
						tempemp=rows[i].empdocno;
						
						k=1;
					}
					else{
						if(k==0){
							tempemp=rows[i].empdocno;
							k=1;
						} else {
							tempemp=tempemp+","+rows[i].empdocno;
						}
					}
					tempemp1=tempemp;
					
				j++; 
			  }
            }
	     $('#txtselectedemployees').val(tempemp1);
		
	     var year = $('#cmbyear').val();
  		 var month = $('#cmbmonth').val();
  		 var bankaccount = $('#txtaccountdocno').val();
  		 var employees = $('#txtselectedemployees').val();
  		 var paymentPosting = $('#date').val();
  		
  		 $("#overlay, #PleaseWait").show();
  		 $("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: false});
  		 $('#btnSaveSalaryPayment').attr('disabled', false );
  		 var gridsavecheck = $('#hidgridsavecheck').val();
  		 if(gridsavecheck!='0'){      
  			 $("#JVTDiv").load("salaryPaymentJVGrid.jsp?year="+year+'&month='+month+'&bankaccount='+bankaccount+'&employees='+employees+'&paymentPosting='+paymentPosting+'&check=1'); 
  		 }  
	}
	
	function funNotify(){	
    	
		   var rows = $('#salaryPaymentJVGridID').jqxGrid('getrows');
	       var rowlength= rows.length;
		   if(rowlength==0){
				$.messager.alert('Message','Please Calculate & Save Again. ','warning');
				return 0;
		   } 
		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Salary Payment Grid  Saving*/
			 	var rows = $("#salaryPaymentJVGridID").jqxGrid('getrows');
			 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].docno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
							var amount="0",baseamount="0",id="1";
							if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
								 amount=rows[i].credit*-1;
								 baseamount=rows[i].baseamount*-1;
								 id=-1;
							}
							
							if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
								 amount=rows[i].debit;
								 baseamount=rows[i].baseamount;
								 id=1;
							}
								
				    newTextBox.val(rows[i].docno+"::"+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+baseamount+":: "+amount+":: 0::"+id+":: 0:: 0");
				    newTextBox.appendTo('form');
				 }
				}
	 		 	$('#gridlength').val(length);
			 	/* Salary Payment Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardSalaryPayment").submit();
			 
	 		 }
	 		});
		 
		return 1;
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
		 }
	}
	
	function funExportBtn(){
		JSONToCSVCon(data1, 'SalaryPayment', true);
	} 
	
	function funWPSFormat(){
		
		if($('#txtestablishmentcode').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Establishment Code is Mandatory.','warning');
			 return 0;
		 }
		
		if($('#txtbankaccountdocno').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Bank Account is Mandatory.','warning');
			 return 0;
		 }
		
		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
		if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
			$.messager.alert('Warning','Please Submit & Click again.');
			return false;
		}
		
		JSONToSIFCon(dataSIF, 'SalaryPayment', true);
	}
	function funsaveGrid(){

		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');

		var selectedrows=$("#salaryPaymentDetailsGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		var tempemp="",tempnetsalary="",temppaid="",tempbalance="",temptbpaid="";
		var i=0;  
		var tempemp1="";
		var tempnetsalary1="";
		var temppaid1="",tempbalance1="",temptbpaid1="";  
		        var j=0,k=0;
			    for (i = 0; i < rows.length; i++){
						if(selectedrows[j]==i){
							
							if(i==0){
								tempemp=rows[i].empdocno;
								tempnetsalary=rows[i].netsalary;
								temppaid=rows[i].paid;
								tempbalance=rows[i].balance;
								temptbpaid=rows[i].tbpaid;  
								
								k=1;
							}
							else{
								if(k==0){
									tempemp=rows[i].empdocno;
									tempnetsalary=rows[i].netsalary;
								    temppaid=rows[i].paid;
									tempbalance=rows[i].balance;
									temptbpaid=rows[i].tbpaid; 
									
									k=1;
								} else {
									tempemp=tempemp+","+rows[i].empdocno;
									tempnetsalary=tempnetsalary+","+rows[i].netsalary;
									temppaid=temppaid+","+rows[i].paid;
									tempbalance=tempbalance+","+rows[i].balance;
									temptbpaid=temptbpaid+","+rows[i].tbpaid;
								}
							}
							tempemp1=tempemp;
							tempnetsalary1=tempnetsalary;
							temppaid1=temppaid;
							tempbalance1=tempbalance;
							temptbpaid1=temptbpaid;
							
						j++; 
					  }
		            }
					$('#txtselectedempdocno').val(tempemp1);
					$('#txtselectednetsal').val(tempnetsalary1);
					$('#txtselectedpaid').val(temppaid1);
					$('#txtselectedbalnce').val(tempbalance1);
					$('#txtselectedtbpaid').val(temptbpaid1);    
					
					savegriddata($('#txtselectedempdocno').val(),$('#txtselectednetsal').val(),$('#txtselectedpaid').val(),$('#txtselectedbalnce').val(),$('#txtselectedtbpaid').val());		
		}
	function savegriddata(txtselectedempdocno,txtselectednetsal,txtselectedpaid,txtselectedbalnce,txtselectedtbpaid)
	{
	    var x=new XMLHttpRequest();
	    x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	   {
	    var items=x.responseText;
	   if(parseInt(items)>=1)
	   {
		document.getElementById("hidgridsavecheck").value='1';      
	    $('#txtselectedempdocno').val(""); $('#txtselectednetsal').val(""); $('#txtselectedpaid').val(""); $('#txtselectedbalnce').val(""); $('#txtselectedtbpaid').val("");
	   } else{
		   document.getElementById("hidgridsavecheck").value='0';
	  }
	 }  
	}                                                                                                                                  
	  x.open("GET","savedata.jsp?txtselectedempdocno="+txtselectedempdocno+"&txtselectednetsal="+txtselectednetsal+"&txtselectedpaid="+txtselectedpaid+"&txtselectedbalnce="+txtselectedbalnce+"&txtselectedtbpaid="+txtselectedtbpaid+"&year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val(),true);
	  x.send();
	}
</script>
</head>
<body onload="getBranch();setValues();getYear();getPayrollCategory();getSalesAgent();">
<form id="frmDashboardSalaryPayment" action="saveDashboardSalaryPayment" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td align="right"><label class="branch">Year</label></td>
     <td align="left"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Month</label></td>
     <td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Agent Id</label></td>
	 <td align="left"><select id="cmbempagentid" style="width:80%;" name="cmbempagentid"  value='<s:property value="cmbempagentid"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td align="left"><select id="cmbempcategory" style="width:80%;" name="cmbempcategory"  value='<s:property value="cmbempcategory"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Est.Code</label></td>
     <td align="left"><input type="text" id="txtestablishmentcode" name="txtestablishmentcode" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtestablishmentcode"/>'  onkeydown="getEstablishmentCode(event);"/></td></tr>
	 <tr><td align="right"><label class="branch">Payable</label></td>
     <td align="left"><input type="text" id="txtaccount" name="txtaccount" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccount"/>'  onkeydown="getAccount(event);"/>
     <input type="hidden" id="txtaccountdocno" name="txtaccountdocno" value='<s:property value="txtaccountdocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtaccountname" name="txtaccountname" readonly="readonly" placeholder="Payable Account" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtaccountname"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Payment</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>
     <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
     <tr><td colspan="2"><div id="postedSalaryDiv"><jsp:include page="postedSalaryGrid.jsp"></jsp:include></div></td></tr>
     <tr><td align="right"><label class="branch">Bank</label></td>
     <td align="left"><input type="text" id="txtbankaccount" name="txtbankaccount" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtbankaccount"/>'  onkeydown="getBankAccount(event);"/>
     <input type="hidden" id="txtbankaccountdocno" name="txtbankaccountdocno" value='<s:property value="txtbankaccountdocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtbankaccountname" name="txtbankaccountname" readonly="readonly" placeholder="Bank Account" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtbankaccountname"/>'/></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <input type="button" class="myButton" id="btnSifSalaryPayment" name="btnSifSalaryPayment" value="WPS Format" onclick="funWPSFormat();">
	 <input type="button" class="mySaveButton" id="btnSaveSalaryPayment" name="btnSaveSalaryPayment" value="Save" onclick="funNotify();"></td></tr>
     <tr><td colspan="2">&nbsp;<input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
     <input type="hidden" name="txtselectedempdocno" id="txtselectedempdocno" style="width:100%;height:20px;" value='<s:property value="txtselectedempdocno"/>'>
  <input type="hidden" name="txtselectednetsal" id="txtselectednetsal" style="width:100%;height:20px;" value='<s:property value="txtselectednetsal"/>'>
   <input type="hidden" name="txtselectedpaid" id="txtselectedpaid" style="width:100%;height:20px;" value='<s:property value="txtselectedpaid"/>'>
    <input type="hidden" name="txtselectedbalnce" id="txtselectedbalnce" style="width:100%;height:20px;" value='<s:property value="txtselectedbalnce"/>'>
	 <input type="hidden" name="txtselectedtbpaid" id="txtselectedtbpaid" style="width:100%;height:20px;" value='<s:property value="txtselectedtbpaid"/>'>
     <input type="hidden" name="hidgridsavecheck" id="hidgridsavecheck" style="width:100%;height:20px;" value='<s:property value="hidgridsavecheck"/>'>
     <input type="hidden" name="txtdrtotal" id="txtdrtotal" style="width:100%;height:20px;" value='<s:property value="txtdrtotal"/>'>
     <input type="hidden" name="txtcrtotal" id="txtcrtotal" style="width:100%;height:20px;" value='<s:property value="txtcrtotal"/>'>
     <input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
     <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'></td></tr>
	 </table>
	 </fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="salaryPaymentDetailsDiv"><jsp:include page="salaryPaymentGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="JVTDiv" hidden="true"><jsp:include page="salaryPaymentJVGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>

</div>
<div id="accountDetailsWindow">
   <div></div>
</div>
<div id="establishedCodeDetailsWindow">
   <div></div>
</div>
</div> 
</form>
</body>
