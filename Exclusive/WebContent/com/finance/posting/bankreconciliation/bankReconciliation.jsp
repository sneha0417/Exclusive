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
		 $('#btnExcel').attr('disabled', false );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		
		 /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		 $("#jqxBankReconciliationDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $('#txtforsearch').val(2);
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxBankReconciliationDate, #maindate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxBankReconciliationDate, #maindate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);
		
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		
		 $('#jqxBankReconciliationDate').on('change', function (event) {
				var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(reconciledate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		   	  $('#txtforsearch').val(3);
		});	 
		
	});
	
	function accountSearchContent(url){
	  $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
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
 				var optionsbranch = '<option value="a">ALL</option>';
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
 		x.open("GET", <%=contextPath+"/"%>+"com/finance/posting/getBranch.jsp", true);
 		x.send();
 	}
	
	function getLastReconcileDate(reconcileddate,account){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				 items = items.split('***');
 			     $('#txtchkgridload').val(items[2].trim());
 			     if(parseInt(items[2].trim())>=0){
 			    	  funloadappliedgrid();
 			     } else if(parseInt(items[2].trim())<0) {
					  $.messager.alert('Message','Bank Reconcilation done till '+items[1].trim()+'','warning');
					  $("#jqxBankReconciliation").jqxGrid('clear'); 
			          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
			          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
					  return;
				 }
 			     
 			   
 		}
		}
		x.open("GET", "getLastReconciledDate.jsp?reconcileddate="+reconcileddate+'&account='+account, true);
		x.send();
	}
	
	function getAcc(event){
	   var x= event.keyCode;
	   if(x==114){
	 	 accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp");
   	     $('#txtforsearch').val(3);
	      }
	   }
	   
	function funReadOnly(){
		$('#frmBankReconciliation input').attr('readonly', true );
		$('#frmBankReconciliation select').attr('disabled', true);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: true});
	    $("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").hide();
	}
	
	function funRemoveReadOnly(){
		$('#txtforsearch').val(2);		
		getBranch();
	    $('#frmBankReconciliation input').attr('readonly', false );
		$('#frmBankReconciliation select').attr('disabled', false);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
		$('#txtunclrreceipts').attr('readonly', true );
	    $('#txtunclrpayments').attr('readonly', true );
	    $('#txtbookbalance').attr('readonly', true );
	    $('#txtbankbalance').attr('readonly', true );
		$("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").show();
		
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);
	    
		 if ($("#mode").val() == "A") {
			 $('#jqxBankReconciliationDate').val(new Date());
			 document.getElementById("lblformposted").innerText="";
			 $("#jqxBankReconciliation").jqxGrid('clear');
			 $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
		}  
		 
		 if ($("#mode").val() == "E") {
			 $("#jqxBankReconciliation").jqxGrid({ disabled: false});
			  var check = 1;
			  var date=document.getElementById("jqxBankReconciliationDate").value;
			  var accId = document.getElementById("txtdocno").value;
			  var docno = document.getElementById("docno").value;
			  var mode = document.getElementById("mode").value;
			  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check); 
		 }
		
	}
	
	function funSearchLoad(){
	    changeContent('brcnMainSearch.jsp'); 
	}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		$('#jqxBankReconciliationDate').jqxDateTimeInput('focus'); 	    		
	}
	
	function funNotify(){	
	 
	  /* Validation */
		var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(reconciledate);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		}
		
		document.getElementById("errormsg").innerText="";
			
	/* Validation Ends*/
			
		 /*Bank Reconciliation Grid  Saving*/
		 var rows = $("#jqxBankReconciliation").jqxGrid('getrows');
	 		$('#gridlength').val(rows.length);
	 		for(var i=0 ; i < rows.length ; i++){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
				
				var amount;
				if((rows[i].cr!=null) && (rows[i].cr!='undefined') &&  (rows[i].cr!='NaN') && (rows[i].cr!="") && (rows[i].cr!=0)){
					 amount=rows[i].cr;
				}
				if((rows[i].dr!=null) && (rows[i].dr!='undefined') && (rows[i].dr!='NaN') && (rows[i].dr!="") && (rows[i].dr!=0)){
					 amount=rows[i].dr;
				}
					
				newTextBox.val(rows[i].chk+":: "+rows[i].c_date+":: "+amount+":: "+rows[i].tranid+":: "+rows[i].date+":: "+rows[i].doc_no+":: "+rows[i].dtype+":: "+rows[i].chqno+":: "+rows[i].chqdt+":: "+rows[i].dr+":: "+rows[i].cr+":: "+rows[i].ref_detail+":: "+rows[i].description+":: "+rows[i].party);
				newTextBox.appendTo('form');
				
				} 
	 		   /*Bank Reconciliation Grid  Saving Ends*/	
	 		   
	 		   $('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		   	   $('#cmbbranch').attr('disabled', false);
		 	   $('#cmbcurrency').attr('disabled', false);
	 		   
			return 1;
	} 
	
	
	function setValues(){
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);getBranch();
		
		if($('#hidjqxBankReconciliationDate').val()){
			 $("#jqxBankReconciliationDate").jqxDateTimeInput('val', $('#hidjqxBankReconciliationDate').val());
		  }
	 
		if($('#hidmaindate').val()){
			 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
		  }
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );
		  }
		 
		 var accId = document.getElementById("txtdocno").value;
		 if(accId>0){
			 funloadappliedgrid();
		 }
		 
	}
	
	function funloadappliedgrid(){

		$("#jqxBankReconciliation").jqxGrid({ disabled: false});
		  var date=document.getElementById("jqxBankReconciliationDate").value;
		  var accId = document.getElementById("txtdocno").value;
		  var docno = document.getElementById("docno").value;
		  var mode = document.getElementById("mode").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check); 
	}
	
	function funExcelBtn(){
		 JSONToCSVCon(dataExcelExport, 'Bank Reconciliation', true);
	 }
	
	function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			
			 var url=document.URL;
		     var reurl=url.split("saveBankReconciliation");
		     $("#docno").prop("disabled", false);
			
				   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printBankReconciliation?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printBankReconciliation?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	  }
	
	function datechange(){
		  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  $("#jqxBankReconciliation").jqxGrid('clear'); 
          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
          $('#txtbookbalance').val('');$('#txtunclrpayments').val('');$('#txtunclrreceipts').val('');$('#txtbankbalance').val('');
		  
	  }
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmBankReconciliation" action="saveBankReconciliation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxBankReconciliationDate" name="jqxBankReconciliationDate" onchange="datechange();" value='<s:property value="jqxBankReconciliationDate"/>'></div>
                <input type="hidden" id="hidjqxBankReconciliationDate" name="hidjqxBankReconciliationDate" value='<s:property value="hidjqxBankReconciliationDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Branch</label>
            <select id="cmbbranch" name="cmbbranch" style="width:160px;" value='<s:property value="cmbbranch"/>'>
                <option></option>
            </select>
            <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" style="width:120px;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value);">
                <option></option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
            <input type="hidden" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtbankreconciliationdocno" style="width:120px;" value='<s:property value="txtbankreconciliationdocno"/>' tabindex="-1"/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Account</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="var d=$('#jqxBankReconciliationDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountSearchContent('<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date='+d); $('#txtforsearch').val(3);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtaccname" name="txtaccname" style="flex:1; max-width: 280px;" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            
            <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" style="margin-left: 15px;" onclick="getLastReconcileDate($('#jqxBankReconciliationDate').val(),$('#txtdocno').val());">Submit</button>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Applying Details</span>
        <div id="jqxBankReconciliationGrid" class="grid-container">
            <jsp:include page="bankReconciliationGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <div class="middle-panel" style="margin-bottom:0;">
        <span class="middle-panel-title">Summary</span>
        <div class="field-row" style="margin-bottom:0; justify-content:space-between;">
            <div style="display:flex; align-items:center;">
                <label class="lbl-right" style="width:90px;">Book Balance</label>
                <input type="text" id="txtbookbalance" name="txtbookbalance" style="width:120px; text-align: right;" value='<s:property value="txtbookbalance"/>' tabindex="-1" readonly/>
            </div>
            
            <div style="display:flex; align-items:center;">
                <label class="lbl-right" style="width:140px;">Uncleared Payments (+ve)</label>
                <input type="text" id="txtunclrpayments" name="txtunclrpayments" style="width:120px; text-align: right;" value='<s:property value="txtunclrpayments"/>' tabindex="-1" readonly/>
            </div>
            
            <div style="display:flex; align-items:center;">
                <label class="lbl-right" style="width:140px;">Uncleared Receipts (-ve)</label>
                <input type="text" id="txtunclrreceipts" name="txtunclrreceipts" style="width:120px; text-align: right;" value='<s:property value="txtunclrreceipts"/>' tabindex="-1" readonly/>
            </div>
            
            <div style="display:flex; align-items:center;">
                <label class="lbl-right" style="width:110px;">Bank St. Balance</label>
                <input type="text" id="txtbankbalance" name="txtbankbalance" style="width:120px; text-align: right;" value='<s:property value="txtbankbalance"/>' tabindex="-1" readonly/>
            </div>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" name="txtchkgridload" id="txtchkgridload" value='<s:property value="txtchkgridload"/>'>
        <label id="lblformposted" name="lblformposted"><s:property value="lblformposted"/></label>
    </div>

</div>
</form>
    
<div id="accountDetailsFromWindow"><div></div><div></div></div>  

</div>
</body>
</html>