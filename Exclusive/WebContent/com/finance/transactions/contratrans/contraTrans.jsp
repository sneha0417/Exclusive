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

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		 $("#jqxContraTransDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxContraTransDate, #jqxChequeDate, #maindate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxContraTransDate, #jqxChequeDate, #maindate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);
		 
		 $('#accountDetailWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailWindow').jqxWindow('close');
		 
		 $('#jqxContraTransDate').on('change', function (event) {
			 var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(contradate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		     }
		 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
			  $('#txtfromorto').val(2);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
			  $('#txtfromorto').val(3);
			  });  
		 
	});
	
	function AccountSearchContent(url) {
		$('#accountDetailWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailWindow').jqxWindow('setContent', data);
		$('#accountDetailWindow').jqxWindow('bringToFront');
	}); 
	} 
  
	  function getBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var optionsbranch = '<option value="">--Select--</option>';
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#cmbbranch").html(optionsbranch);
					if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					}
				} else {
				}
			}
			x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
			x.send();
		}
	  
		  function getAccounts(){
		  		var x = new XMLHttpRequest();
		  		x.onreadystatechange = function() {
		  			if (x.readyState == 4 && x.status == 200) {
		  				var items = x.responseText;
		  			    $('#txtpdcacno').val(items);
		  		}
		  		}
		  		x.open("GET", "getAccounts.jsp", true);
		  		x.send();
		 }
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
			    	 $('#frmContraTrans input').attr('readonly', false );$('#frmContraTrans select').attr('disabled', false);$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );$('#txtfromaccid').attr('readonly', true );
					 $('#txtfromaccname').attr('readonly', true );$('#txttoaccid').attr('readonly', true );$('#txttoaccname').attr('readonly', true );
					 $('#docno').attr('readonly', true);$('#chckpdc').attr('disabled', false);$('#chckib').attr('disabled', false);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmContraTrans input').attr('readonly', true );
			$('#frmContraTrans select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getBranch();checkIb();checkpdc();
		    
			$('#frmContraTrans input').attr('readonly', false );
			$('#frmContraTrans select').attr('disabled', false);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#cmbbranch').attr('disabled', true);
			$('#docno').attr('readonly', true);
			
			var date = $('#jqxContraTransDate').val();
		    getCurrencyId(date);
			
			if($('#cmbtype').val()=="CASH"){
	    		  $('#txtchequeno').attr('readonly', true);
	    		  $('#chckpdc').attr('disabled', true);
	    	  }
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmContraTrans input').attr('readonly', true );
         	   	$('#frmContraTrans select').attr('disabled', true);
         	    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			 	$('#chckpdc').attr('disabled', true);
   			 	$('#chckib').attr('disabled', true);
			  }
			 else{
				$("#btnvaluechange").hide();
				$('#chckpdc').attr('disabled', false);
			}
			
	 }
	 
	 function funSearchLoad(){
		    changeContent('cotMainSearch.jsp');   
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxContraTransDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmContraTrans').validate({
	                rules: {
	                	txtfromaccid:"required",
		                txtfromamount:{number:true},
		                txttoamount:{number:true},
		                txttoaccid:"required",
	                    txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                	 txtfromaccid:" *",
		                 txtfromamount:{number:"Invalid"},
		                 txttoamount:{number:"Invalid"},
		                 txttoaccid:" *",
	                     txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  
		  	/* Validation */
		    var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(contradate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		    }
			
			ibvalid=document.getElementById("txtibvalidation").value;
			 if(ibvalid==1){
				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
				 return 0;
			 }
			 
			pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
			 if(pdcchequevalid==1){
				 document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
				 return 0;
			 }
			 
		    var drtot = parseFloat(document.getElementById("txtfrombaseamount").value);
	 		var crtot = parseFloat(document.getElementById("txttobaseamount").value);
	 		
	 		if(drtot>crtot || drtot<crtot){
	 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
            return 0;
	 		}
	 		
	 		if(drtot=="" || crtot=="" ){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	              return 0;
		 		}

	 		if(isNaN(drtot) || isNaN(crtot)){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	              return 0;
		 		}
	 		
	 		if(drtot==0 || crtot==0){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		if(drtot==0.0 || crtot==0.0){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		if(drtot==0.00 || crtot==0.00){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	 		
	 		document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
		  $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		  $('#frmContraTrans select').attr('disabled', false);
		    	
	    	return 1;
		} 
	  
	  
	  function setValues(){
		  getBranch();checkIb();checkpdc();
		  
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxContraTransDate').val();
		  getCurrencyId(date);
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxContraTransDate').val()){
			 $("#jqxContraTransDate").jqxDateTimeInput('val', $('#hidjqxContraTransDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			 
		}
	  
	  function funchequedate(){
		  if($('#cmbtype').val()=="BANK"){
			  $('#txtchequeno').attr('readonly', false);
			  $('#chckpdc').attr('disabled', false);
		  }
		  else if($('#cmbtype').val()=="CASH"){
    		  $('#txtchequeno').attr('readonly', true);
    		  $('#chckpdc').attr('disabled', true);
    		  $('#txtchequeno').val('');
    	  }
      }
	  
	  function funCheckIb(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
	  
	  function funCheck(a){
		  if(document.getElementById("chckpdc").checked != false){
		 		 $('#hidchckpdc').val(1);getAccounts();
		  }
		  else{
			  $('#hidchckpdc').val(0);  
		  }
	  }
	  
	  function checkIb(){
			 if(document.getElementById("hidchckib").value==1){
				 document.getElementById("chckib").checked = true;
			 }
			 else if(document.getElementById("hidchckib").value==0){
				document.getElementById("chckib").checked = false;
			  }
			 }
	  
	  function checkpdc(){
			 if(document.getElementById("hidchckpdc").value==1){
				 document.getElementById("chckpdc").checked = true;
			 }
			 else if(document.getElementById("hidchckpdc").value==0){
				document.getElementById("chckpdc").checked = false;
			  }
			 }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
        	  $('#txtfromorto').val(2);  
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
        	  $('#txtfromorto').val(3);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveContraTrans");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function clearClientInfoFrom(){
		  $("#txtfromdocno").val('');$("#txtfromaccid").val('');$("#txtfromaccname").val('');
	  }
	  
	  function clearClientInfoTo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function datechange(){
		  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
			
			if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
		  	   var validibdate=funIBDateInPeriod($('#jqxContraTransDate').val(),$('#cmbbranch').val());
			   if(parseInt(validibdate)==0){
					document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted.";
					return 0;	
		       }
		    }
		  
		  $("#maindate").jqxDateTimeInput('val', date);
		  funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
	  }
	  
</script>

</head>
<body onload="setValues();getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmContraTrans" action="saveContraTrans" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxContraTransDate" name="jqxContraTransDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxContraTransDate"/>'></div>
                <input type="hidden" id="hidjqxContraTransDate" name="hidjqxContraTransDate" value='<s:property value="hidjqxContraTransDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:120px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtcontratransdocno" style="width:120px;" value='<s:property value="txtcontratransdocno"/>' tabindex="-1" readonly/>
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        
        <!-- Payment From Panel -->
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Payment From</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Type</label>
                <select id="cmbtype" name="cmbtype" style="width:80px;" onchange="clearClientInfoFrom();funchequedate();" value='<s:property value="cmbtype"/>'>
                    <option value="CASH">Cash</option>
                    <option value="BANK">Bank</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                
                <div class="input-search-container" style="width: 120px; margin-left: 10px;">
                    <input type="text" id="txtfromaccid" name="txtfromaccid" readonly placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                    <svg class="magnifier-icon" onclick="var d=$('#jqxContraTransDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+'&date='+d); $('#txtfromorto').val(2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="txtfromaccname" name="txtfromaccname" readonly style="flex:1;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" style="width:120px;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxContraTransDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" style="width:120px; text-align:right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();" tabindex="-1"/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px; display:flex; align-items:center; justify-content:flex-end; gap:4px;">
                    <input type="checkbox" id="chckpdc" name="chckpdc" onclick="funCheck();funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> PDC
                </label>
                <input type="hidden" id="hidchckpdc" name="hidchckpdc" value='<s:property value="hidchckpdc"/>'/>
                <input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/>
                
                <label class="lbl-right" style="width:70px;">Cheque No.</label>
                <input type="text" id="txtchequeno" name="txtchequeno" style="width:100px;" value='<s:property value="txtchequeno"/>' />
                
                <label class="lbl-right" style="width:70px; margin-left:auto;">Cheque Date</label>
                <div style="width: 110px;">
                    <div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                </div>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" style="width:120px; text-align:right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:120px; text-align:right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>

        <!-- Payment To Panel -->
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Payment To</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; display:flex; align-items:center; justify-content:flex-end; gap:4px;">
                    <input type="checkbox" id="chckib" name="chckib" onclick="funCheckIb();" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> Inter-Branch
                </label>
                <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Branch</label>
                <select id="cmbbranch" name="cmbbranch" style="width:180px;" value='<s:property value="cmbbranch"/>'>
                    <option value=""></option>
                </select>
                <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:80px;" onchange="clearClientInfoTo();" value='<s:property value="cmbtotype"/>'>
                    <option value="CASH">Cash</option>
                    <option value="BANK">Bank</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
                
                <div class="input-search-container" style="width: 120px; margin-left: 10px;">
                    <input type="text" id="txttoaccid" name="txttoaccid" style="width:100%;" readonly placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                    <svg class="magnifier-icon" onclick="var d=$('#jqxContraTransDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+'&date='+d); $('#txtfromorto').val(3);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="txttoaccname" name="txttoaccname" style="flex:1;" readonly value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" style="width:120px;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxContraTransDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txttorate" name="txttorate" style="width:120px; text-align:right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" style="width:120px; text-align:right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" style="width:120px; text-align:right;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly/>
            </div>
        </div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" name="txtfromorto" id="txtfromorto" value='<s:property value="txtfromorto"/>'>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
        <input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation" value='<s:property value="txtpdcdatevalidation"/>'/>
    </div>

</div>
</form>

<div id="accountDetailWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>