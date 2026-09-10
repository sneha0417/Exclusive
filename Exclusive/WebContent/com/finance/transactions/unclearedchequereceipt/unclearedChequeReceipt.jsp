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
		 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});		 
		
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxUnclearedChequeReceiptDate, #jqxChequeDate, #maindate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxUnclearedChequeReceiptDate, #jqxChequeDate, #maindate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);

		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#unclearedChequeReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unclearedChequeReceiptGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#jqxUnclearedChequeReceiptDate').on('change', function (event) {
				 var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(bankpaydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
			 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  	 
	});
	
	function unclearedChequeSearchContent(url) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('setContent', data);
		$('#unclearedChequeReceiptGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
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
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function unclearedChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmUnclearedChequeReceipt input').attr('readonly', true );
			$('#frmUnclearedChequeReceipt select').attr('disabled', true);
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmUnclearedChequeReceipt input').attr('readonly', false );
			$('#frmUnclearedChequeReceipt select').attr('disabled', false);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});
		
			var date = $('#jqxUnclearedChequeReceiptDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmUnclearedChequeReceipt input').attr('readonly', true );
   			    $('#frmUnclearedChequeReceipt select').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			    $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxUnclearedChequeReceiptDate').val(new Date());
				$("#jqxUnclearedChequeReceipt").jqxGrid('clear'); 
				$("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('ucrMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  /* Validations */
	   $(function(){
	        $('#frmUnclearedChequeReceipt').validate({
	                rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true},
	                txttoamount:{number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"},
	                 txttoamount:{number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  /* Validation */
		    var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(bankpaydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			currency=document.getElementById("cmbfromcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
			 
			 currencyto=document.getElementById("cmbtocurrency").value;
			 acnoto=document.getElementById("txttoaccid").value;
			 if(currencyto=="" && acnoto!=""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
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
	    
	    	/* Uncleared Cheque Receipt Grid  Saving*/
	 		  var rows = $("#jqxUnclearedChequeReceipt").jqxGrid('getrows');
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
	 						 amount=rows[i].amount1*-1;
	 						 baseamount=rows[i].rate*rows[i].amount1*-1;
	 					}
	 					else if(rows[i].dr==false){
	 						 amount=rows[i].amount1;
	 						 baseamount=rows[i].rate*rows[i].amount1;
	 					}
	 					
	 				newTextBox.val(rows[i].docno+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+rows[i].dr+":: "+amount+":: "+rows[i].description+":: "+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
	 				newTextBox.appendTo('form');
	 				}
			      }
			      $('#gridlength').val(length);
	 	 		   /* Uncleared Cheque Receipt Grid  Saving Ends*/	 
	 				 
	 				 $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			         
			         if ($("#mode").val() == "E") {
			         	 $('#frmUnclearedChequeReceipt select').attr('disabled', false); 
			         }
	 				 
	    		return 1;
		} 
	  
	  function setValues(){
		  
		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxUnclearedChequeReceiptDate').val();
		  getCurrencyId(date);
		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxUnclearedChequeReceiptDate').val()){
				 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeReceiptDate').val());
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
			 
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
	         $("#jqxUnclearedChequeReceiptGrid").load("unclearedChequeReceiptGrid.jsp?txtunclearedchequereceiptdocno2="+indexVal);
			 }
		}
	  
	  function funwarningopen(){
		  $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', false);$('#txtfromaccname').attr('readonly', false);$('#txtfromamount').attr('readonly', false);$('#txtchequeno').attr('readonly', false);
					 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', false);$('#txttoaccname').attr('readonly', false);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', true);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', true);$('#txttobaseamount').attr('readonly', true);
				     $('#txtchequename').attr('readonly', false);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
					 $('#frmUnclearedChequeReceipt select').attr('disabled', false);$("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});  
			    }
			   });
	  }
	  
	  function getDrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,dr1=0.0;
        	    var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
    	        var rowlength= rows.length;
        		for(var i=0;i<=rowlength-1;i++) {
        		
        		var value = rows[i].dr;
                var baseamount = rows[i].baseamount1;
                
                if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
	              if(value==true){
                	   if(!isNaN(baseamount)){
                	      cr=cr+baseamount;
                	   }else if(isNaN(baseamount)){
                  		 baseamount=0.00;
                  		 cr=cr+baseamount;
                  	   }
                   }
                   else{
                	   if(!isNaN(baseamount)){
                    	 	dr=dr+baseamount;
                  	   }else if(isNaN(baseamount)){
                  		    baseamount=0.00;
                  		 	dr=dr+baseamount;
                  	   }
                     }
        	       }
        		}
        		
        		if(!isNaN(fromamount)){
                    dr1=parseFloat(dr) + parseFloat(fromamount);
                    funRoundAmt(dr1,"txtdrtotal");
               	 }
		  }
		  else if(isNaN(fromamount)){
		  	$('#txtdrtotal').val(0.00);
		  	$('#txtfromamount').val(0.00);
		  }
	  }
	  
	  function getCrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,cr1=0.0;
  	      var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
	      var rowlength= rows.length;
	 		for(var i=0;i<=rowlength-1;i++) {
	 		
	 		  var value = rows[i].dr;
	         var baseamount = rows[i].baseamount1;
	         
	         if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
	            if(value==true){
	          	   if(!isNaN(baseamount)){
	          	      cr=cr+baseamount;
	          	   }else if(isNaN(baseamount)){
	            		 baseamount=0.00;
	            		 cr=cr+baseamount;
	            	   }
	             }
	             else{
	          	   if(!isNaN(baseamount)){
	               	 	dr=dr+baseamount;
	             	   }else if(isNaN(baseamount)){
	             		    baseamount=0.00;
	             		 	dr=dr+baseamount;
	             	   }
	               }
	 	       }
	 		}
	 		
	 		if(!isNaN(toamount)){
                cr1=parseFloat(cr) + parseFloat(toamount);
                funRoundAmt(cr1,"txtcrtotal");
             }
	      }
		  else if(isNaN(toamount)){
			$('#txtcrtotal').val(0.00);
			$('#txttoamount').val(0.00);
		}
	  } 
	  	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
          }
	  
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			unclearedChequePrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	      }
	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function datechange(){
		  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }

	  
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUnclearedChequeReceipt" action="saveUnclearedChequeReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxUnclearedChequeReceiptDate" name="jqxUnclearedChequeReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequeReceiptDate"/>'></div>
                <input type="hidden" id="hidjqxUnclearedChequeReceiptDate" name="hidjqxUnclearedChequeReceiptDate" value='<s:property value="hidjqxUnclearedChequeReceiptDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="width:120px;" />
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtunclearedchequereceiptdocno" value='<s:property value="txtunclearedchequereceiptdocno"/>' tabindex="-1" style="width:120px;" readonly />
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Bank Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Bank</label>
                <div class="input-search-container" style="width: 120px;">
                    <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);" />
                    <svg class="magnifier-icon" onclick="var d=$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountFromSearchContent('<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' style="flex:1;" tabindex="-1" readonly />
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>' />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" style="width:120px;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>' />
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>' />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" style="width:120px; text-align:right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1" />
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Cheque No.</label>
                <input type="text" id="txtchequeno" name="txtchequeno" style="width:120px;" value='<s:property value="txtchequeno"/>' />

                <label class="lbl-right" style="width:80px; margin-left:auto;">Cheque Date</label>
                <div style="width: 120px;">
                    <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Cheque Name</label>
                <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' style="flex:1;" />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" style="width:120px; text-align:right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:120px; text-align:right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Received From</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:80px;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>' />
                
                <div class="input-search-container" style="width: 120px; margin-left: 10px;">
                    <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);" />
                    <svg class="magnifier-icon" onclick="var d=$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountToSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbtotype').val()+'&date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' style="flex:1;" tabindex="-1" readonly />
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>' />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" style="width:120px;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>' />
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>' />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txttorate" name="txttorate" style="width:120px; text-align:right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1" />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" style="width:120px; text-align:right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" style="width:120px; text-align:right;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly />
            </div>
        </div>
        
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Uncleared Cheque Allocation</span>
        <div id="jqxUnclearedChequeReceiptGrid" class="grid-container">
            <jsp:include page="unclearedChequeReceiptGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:100px; text-align:right;" value='<s:property value="txtdrtotal"/>' readonly />
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:100px; text-align:right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>

</div>
</form>
	
<div id="unclearedChequeReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div> 

</div>
</body>
</html>