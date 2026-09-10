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
		 $("#btnUnclearedChequeSearch").hide();
		
		 /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		 $("#jqxUnclearedChequeProcessingDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxUnclearedChequeProcessFromDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxUnclearedChequeProcessToDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#postingDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", value: null, theme: 'energyblue' });
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxUnclearedChequeProcessingDate, #jqxUnclearedChequeProcessFromDate, #jqxUnclearedChequeProcessToDate, #postingDate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxUnclearedChequeProcessingDate, #jqxUnclearedChequeProcessFromDate, #jqxUnclearedChequeProcessToDate, #postingDate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);
		 
		 var curfromdate= $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxUnclearedChequeProcessFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#jqxUnclearedChequeProcessFromDate').on('change', function (event) {
				var paydate = $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
		 
	});
	
	 function funReadOnly(){
			$('#frmUnclearedChequeProcessing input').attr('readonly', true );
			$('#frmUnclearedChequeProcessing select').attr('disabled', true);
			$('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: true});
			$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: true});
			$('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: true});
			$('#postingDate').jqxDateTimeInput({disabled: true});
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
			$("#jqxBankPayment").jqxGrid({ disabled: true});
			$("#btnUnclearedChequeSearch").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmUnclearedChequeProcessing input').attr('readonly', false );
			$('#frmUnclearedChequeProcessing select').attr('disabled', false);
			$('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: false});
			$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: false});
			$('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: false});
			$('#postingDate').jqxDateTimeInput({disabled: false});
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
			$("#jqxBankPayment").jqxGrid({ disabled: true});
			
			$('#docno').attr('readonly', true);
			$("#btnUnclearedChequeSearch").show();
			
			if ($("#mode").val() == "A") {
				
				 $('#jqxUnclearedChequeProcessingDate').val(new Date());
				 $('#jqxUnclearedChequeProcessFromDate').val(new Date());
				 var curfromdate= $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
			     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			     $('#jqxUnclearedChequeProcessFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			     $('#jqxUnclearedChequeProcessToDate').val(new Date());
			     $('#postingDate').val(null);
				 
				$("#jqxUnclearedChequePayment").jqxGrid('clear'); 
				$("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				$("#jqxBankPayment").jqxGrid('clear');
				$("#jqxBankPayment").jqxGrid('addrow', null, {}); 
			}
			
	 }
	 
	 function funSearchLoad(){
		/* changeContent('cpvMainSearch.jsp'); */ 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
		  
		  /* Validation */
		    var paydate = $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput('getDate');
		    var validdate=funDateInPeriod(paydate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
	    	
			var postdate = $('#postingDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(parseInt(postvaliddate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			var postingdate = $('#postingDate').jqxDateTimeInput('getDate');
			var chequedate=$('#txtchqdt').val();
			// alert(postingdate+"===="+chequedate);
			if(postingdate<chequedate){
				// document.getElementById("errormsg").innerText="Posting Date cannot be less than Cheque Date.";
				// return 0;
			}
			document.getElementById("errormsg").innerText="";
			
	    /* Validation Ends*/
	    		
			 /* Bank Payment Grid  Saving*/
	 		  var rows = $("#jqxBankPayment").jqxGrid('getrows');
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
	 					
	 					var amount,baseamount;
	 					if(rows[i].dr==true){
							 amount=rows[i].amount1;
							 baseamount=rows[i].baseamount1;
						}
						else if(rows[i].dr==false){
							 amount=rows[i].amount1*-1;
							 baseamount=rows[i].baseamount1*-1;
						}
	 					
	 				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].pdc+":: "+rows[i].sr_no);
	 				newTextBox.appendTo('form');
	 				}
			      }
			      $('#gridlength').val(length);
	 	 		/* Bank Payment Grid  Saving Ends*/	 	 
				 
	 		   $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: false});
			   $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: false});
			   $('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: false});
			   $('#postingDate').jqxDateTimeInput({disabled: false});
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  
		  if($('#hidjqxUnclearedChequeProcessingDate').val()){
				 $("#jqxUnclearedChequeProcessingDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessingDate').val());
			  }
		  
		  if($('#hidjqxUnclearedChequeProcessFromDate').val()){
				 $("#jqxUnclearedChequeProcessFromDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessFromDate').val());
			  }
		  
		  if($('#hidjqxUnclearedChequeProcessToDate').val()){
				 $("#jqxUnclearedChequeProcessToDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessToDate').val());
			  }
			  
		  if($('#hidpostingDate').val()){
				 $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  
		  var tranno=document.getElementById("txttrno").value;
		  if(tranno>0){
			  var fromDate = document.getElementById("jqxUnclearedChequeProcessFromDate").value;
			  var toDate = document.getElementById("jqxUnclearedChequeProcessToDate").value;
			  var check =1;
			  var disable=0;
			  $("#unclearedChequeProcessingDiv").load('unclearedChequeProcessingGrid.jsp?fromDate='+fromDate+'&toDate='+toDate+'&check='+check+'&disable='+disable);
		  }
	  }
	  
	  function gridloading(){
		  var fromDate = document.getElementById("jqxUnclearedChequeProcessFromDate").value;
		  var toDate = document.getElementById("jqxUnclearedChequeProcessToDate").value;
		  var type = document.getElementById("cmbtype").value;
		  var check =1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#unclearedChequeProcessingDiv").load('unclearedChequeProcessingGrid.jsp?fromDate='+fromDate+'&toDate='+toDate+'&type='+type+'&check='+check);
	  }
	  
	  function funloadgrid(){
		    var paydate = $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
			
			if($('#cmbtype').val()==""){
				document.getElementById("errormsg").innerText="Type is Mandatory.";
				return 0;
			}
			
			//alert("cmbtype=="+$('#cmbtype').val()+"===");
			
			
			
			
			if(document.getElementById("postingDate").value=="" || document.getElementById("postingDate").value==null){
				   document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
				   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
				   $("#jqxUnclearedChequePayment").jqxGrid('clear');
				   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
				   $("#jqxUnclearedChequePayment").jqxGrid('clear');
				   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				  return 0;
			}
			
			document.getElementById("errormsg").innerText="";
			
		  $("#jqxUnclearedChequePayment").jqxGrid({ disabled: false});
		  $("#jqxBankPayment").jqxGrid('clear');
		  $("#jqxBankPayment").jqxGrid('addrow', null, {});
		  
		  
		  /* if($('#cmbtype').val().trim()=="UCR"){
				
				
				alert("11111");
			$('#jqxUnclearedChequePayment').jqxGrid('hidecolumn', 'dealno');
			
			}
		  alert("33333333"); */
		  gridloading();
		  }
	  
	  function headerbtndisable(){
		  $('#btnEdit').attr('disabled', true);
		  $('#btnDelete').attr('disabled', true);
		  $('#btnSearch').attr('disabled', true);
	  }
	  
	   function datechange(){
		    var date = $('#postingDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
			
		   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
		   $("#jqxUnclearedChequePayment").jqxGrid('clear');
		   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
		   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
		   $("#jqxUnclearedChequePayment").jqxGrid('clear');
		   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
	  }
	  
</script>

</head>
<body onload="setValues();headerbtndisable();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmUnclearedChequeProcessing" action="saveUnclearedChequeProcessing" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Filter Criteria</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:140px;">Uncleared P.D.C From</label>
            <div style="width: 120px;">
                <div id="jqxUnclearedChequeProcessFromDate" name="jqxUnclearedChequeProcessFromDate" value='<s:property value="jqxUnclearedChequeProcessFromDate"/>'></div>
                <input type="hidden" id="hidjqxUnclearedChequeProcessFromDate" name="hidjqxUnclearedChequeProcessFromDate" value='<s:property value="hidjqxUnclearedChequeProcessFromDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">P.D.C. Upto</label>
            <div style="width: 120px;">
                <div id="jqxUnclearedChequeProcessToDate" name="jqxUnclearedChequeProcessToDate" value='<s:property value="jqxUnclearedChequeProcessToDate"/>'></div>
                <input type="hidden" id="hidjqxUnclearedChequeProcessToDate" name="hidjqxUnclearedChequeProcessToDate" value='<s:property value="hidjqxUnclearedChequeProcessToDate"/>'/>
            </div>

            <label class="lbl-right" style="width:60px; margin-left: 15px;">Type</label>
            <select id="cmbtype" name="cmbtype" style="width:100px;" value='<s:property value="cmbtype"/>'>
                <option value="">--Select--</option>
                <option value="UCP">Payment</option>
                <option value="UCR">Receipt</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>

            <label class="lbl-right" style="width:60px; margin-left: 15px;">Posting</label>
            <div style="width: 120px;">
                <div id="postingDate" name="postingDate" onchange="datechange();" onblur="datechange();" value='<s:property value="postingDate"/>'></div>
                <input type="hidden" id="hidpostingDate" name="hidpostingDate" value='<s:property value="hidpostingDate"/>'/>
            </div>

            <button class="myButton" type="button" id="btnUnclearedChequeSearch" name="btnUnclearedChequeSearch" onclick="funloadgrid();" style="margin-left: 15px;">View</button>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Uncleared Cheques</span>
        <div id="unclearedChequeProcessingDiv" class="grid-container">
            <jsp:include page="unclearedChequeProcessingGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Allocation</span>
        <div id="bankPaymentDiv" class="grid-container">
            <jsp:include page="bankPaymentGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:100px; text-align:right;" value='<s:property value="txtdrtotal"/>' readonly tabindex="-1" />
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:100px; text-align:right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div style="display:none;">
        <div id="jqxUnclearedChequeProcessingDate" name="jqxUnclearedChequeProcessingDate" value='<s:property value="jqxUnclearedChequeProcessingDate"/>'></div>
        <input type="hidden" id="hidjqxUnclearedChequeProcessingDate" name="hidjqxUnclearedChequeProcessingDate" value='<s:property value="hidjqxUnclearedChequeProcessingDate"/>'/>
        
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
        <input type="hidden" id="txtchqdt" name="txtchqdt" value='<s:property value="txtchqdt"/>'/>
        <input type="hidden" id="txtchqname" name="txtchqname" value='<s:property value="txtchqname"/>'/>
        <input type="hidden" id="chckpdc" name="chckpdc" value='<s:property value="chckpdc"/>'/>
        <input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        <input type="hidden" id="txtgriddtype" name="txtgriddtype" value='<s:property value="txtgriddtype"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>

</div>
</form>
    
</div>
</body>
</html>