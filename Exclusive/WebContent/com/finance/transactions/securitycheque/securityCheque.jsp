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
		 $("#jqxSecurityChequeDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxValidUpTo").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxSecurityChequeDate, #maindate, #jqxChequeDate, #jqxValidUpTo").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxSecurityChequeDate, #maindate, #jqxChequeDate, #jqxValidUpTo").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
	});
	
	function accountFromSearchContent(url) {
	    $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
	}); 
	}

	function accountToSearchContent(url) {
		 	$('#accountDetailsToWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function SecurityChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', true );
			$('#frmSecurityCheque select').attr('disabled', true);
			$('#chckchqdate').attr('disabled', true);
			$('#chckamount').attr('disabled', true);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', false );
			$('#frmSecurityCheque select').attr('disabled', false);
			$('#chckchqdate').attr('disabled', false);
			$('#chckamount').attr('disabled', false);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxSecurityChequeDate').val(new Date());
			}		
	 }
	 
	 function funSearchLoad(){
		 changeContent('secMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
		  $('#jqxSecurityChequeDate').jqxDateTimeInput('focus'); 
	    }
	 
	   $(function(){
	        $('#frmSecurityCheque').validate({
	                rules: {
	                txtfromaccid:"required",
					txtremarks:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
					 txtremarks: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		 		$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
		 		$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		 		$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			    $('#frmSecurityCheque select').attr('disabled', false); 
		 		
				var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(date);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
				document.getElementById("errormsg").innerText="";
	    		
				return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxSecurityChequeDate').val()){
				 $("#jqxSecurityChequeDate").jqxDateTimeInput('val', $('#hidjqxSecurityChequeDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#hidjqxValidUpTo').val()){
				 $("#jqxValidUpTo").jqxDateTimeInput('val', $('#hidjqxValidUpTo').val());
			  }
		  
		  if(document.getElementById("hidchckchqdate").value==1){
	 			 document.getElementById("chckchqdate").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckchqdate").value==0){
	 			document.getElementById("chckchqdate").checked = false;
	 		 }
		  
		  if(document.getElementById("hidchckamount").value==1){
	 			 document.getElementById("chckamount").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckamount").value==0){
	 			document.getElementById("chckamount").checked = false;
	 		 }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			SecurityChequePrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funchequedate(){
	      var chequedate = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var chequeDates =new Date(chequedate).setDate(chequedate.getDate()+1); 
		  $('#jqxChequeDate').jqxDateTimeInput('setDate', new Date(chequeDates));
		  
		  var validupto = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var validuptos =new Date(validupto).setDate(chequedate.getDate()+1); 
		  $('#jqxValidUpTo').jqxDateTimeInput('setDate', new Date(validuptos));
     }
	 	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function checkChequeDate(){
	 		 if(document.getElementById("chckchqdate").checked){
	 			 document.getElementById("hidchckchqdate").value = 1;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	 		 }
	 		 else{
	 			 document.getElementById("hidchckchqdate").value = 0;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 		 }
	 	 }
	  
	  function checkAmount(){
		  if(document.getElementById("chckamount").checked){
	 			 document.getElementById("hidchckamount").value = 1;
	 			 $('#txtamount').attr('readonly', false );
	 		 }
	 		 else{
	 			 document.getElementById("hidchckamount").value = 0;
	 			 $('#txtamount').attr('readonly', true );
	 		 }
	  }
	  
	  function datechange(){
		  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSecurityCheque" action="saveSecurityCheque" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxSecurityChequeDate" name="jqxSecurityChequeDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxSecurityChequeDate"/>'></div>
                <input type="hidden" id="hidjqxSecurityChequeDate" name="hidjqxSecurityChequeDate" value='<s:property value="hidjqxSecurityChequeDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtsecuritychequedocno" value='<s:property value="txtsecuritychequedocno"/>' tabindex="-1" style="width:120px;" readonly />
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Cheque Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Paid To</label>
            <select id="cmbtotype" name="cmbtotype" style="width:80px;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                <option value="AP">AP</option>
                <option value="AR">AR</option>
                <option value="GL">GL</option>
            </select>
            <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/> 
            
            <div class="input-search-container" style="width: 150px; margin-left:10px;">
                <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                <svg class="magnifier-icon" onclick="var d=$('#jqxSecurityChequeDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountToSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbtotype').val()+'&date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' style="flex:1;" tabindex="-1" readonly />
            <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Bank</label>
            <div class="input-search-container" style="width: 150px;">
                <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="var d=$('#jqxSecurityChequeDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountFromSearchContent('<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' style="flex:1;" tabindex="-1" readonly />
            <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Cheque Name</label>
            <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Cheque No.</label>
            <input type="text" id="txtchequeno" name="txtchequeno" style="width:150px;" onchange="funchequedate();" value='<s:property value="txtchequeno"/>' />
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Valid Up To</label>
            <div style="width: 120px;">
                <div id="jqxValidUpTo" name="jqxValidUpTo" value='<s:property value="jqxValidUpTo"/>'></div>
                <input type="hidden" id="hidjqxValidUpTo" name="hidjqxValidUpTo" value='<s:property value="hidjqxValidUpTo"/>'/>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px; display:flex; align-items:center; justify-content:flex-end; gap:4px;">
                <input type="checkbox" id="chckchqdate" name="chckchqdate" onchange="checkChequeDate();" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> Cheque Date
            </label>
            <input type="hidden" id="hidchckchqdate" name="hidchckchqdate" value='<s:property value="hidchckchqdate"/>'/>
            
            <div style="width: 120px;">
                <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
            </div>

            <label class="lbl-right" style="width:100px; margin-left:auto; display:flex; align-items:center; justify-content:flex-end; gap:4px;">
                <input type="checkbox" id="chckamount" name="chckamount" onchange="checkAmount();" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> Amount
            </label>
            <input type="hidden" id="hidchckamount" name="hidchckamount" value='<s:property value="hidchckamount"/>'/>
            
            <input type="text" id="txtamount" name="txtamount" style="width:120px; text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" />
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Remarks</label>
            <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>' style="flex:1;" />
        </div>
    </div>

    <!-- Hidden Inputs Required by Backend -->
    <div style="display:none;">
        <input type="hidden" id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>'/>
        <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
        <input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>

        <input type="hidden" id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>'/>
        <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
        <input type="hidden" id="txttorate" name="txttorate" value='<s:property value="txttorate"/>'/>
            
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
    </div>

</div>
</form>  
				
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div>

</div>
</body>
</html>