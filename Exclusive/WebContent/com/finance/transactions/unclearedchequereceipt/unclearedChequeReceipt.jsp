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
		 $("#btnvaluechange").hide();
		
		 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});		 
		
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

<style>
	.hidden-scrollbar {
	  overflow: auto;
	  height: 530px;
	}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUnclearedChequeReceipt" action="saveUnclearedChequeReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxUnclearedChequeReceiptDate" name="jqxUnclearedChequeReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequeReceiptDate"/>'></div>
    <input type="hidden" id="hidjqxUnclearedChequeReceiptDate" name="hidjqxUnclearedChequeReceiptDate" value='<s:property value="hidjqxUnclearedChequeReceiptDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtunclearedchequereceiptdocno" style="width:50%;" value='<s:property value="txtunclearedchequereceiptdocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>
 
<table width="100%">
<tr>
<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="11%" align="right">Bank</td>
    <td><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:90%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:60%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td width="20%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td align="right">Rate</td>
    <td width="45%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:37%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
   <td align="right">Cheque No.</td>
   <td width="20%"><input type="text" id="txtchequeno" name="txtchequeno" style="width:100%;" value='<s:property value="txtchequeno"/>' /></td>
   <td width="24%" align="right">Cheque Date</td>
   <td align="left"><div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/></td>
   </tr>
   <tr>
      <td align="right">Cheque Name</td>
    <td colspan="3" align="left"><input type="text" id="txtchequename" name="txtchequename" style="width:69%;" value='<s:property value="txtchequename"/>' /></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:90%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:37%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>
  </tr>
   <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:69%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset>
<legend>Received From</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="10%"><select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
    <option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>
    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>
    <td width="20%" align="right">Rate</td>
    <td width="57%"><input type="text" id="txttorate" name="txttorate" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" style="width:50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/></td>
  </tr>
</table><br/><br/><br/><br/>
</fieldset>
</td>
</tr></table>
<div id="jqxUnclearedChequeReceiptGrid"><jsp:include page="unclearedChequeReceiptGrid.jsp"></jsp:include></div><br/>
<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>'/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
<div id="unclearedChequeReceiptGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
<div id="accountDetailsToWindow">
				<div></div><div></div>
</div> 

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

<div id="printWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>
