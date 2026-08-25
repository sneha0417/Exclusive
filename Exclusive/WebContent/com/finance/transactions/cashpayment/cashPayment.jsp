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
		
		 $("#jqxCashPaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#cashPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashPaymentGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCashPaymentDate').on('change', function (event) {
				var paydate = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			 });
		 
		 $('#txttoamount').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxApplyInvoicing').jqxGrid('selectcell',0, 'applying');
			          $('#jqxApplyInvoicing').jqxGrid('focus',0, 'applying');
			  }
		 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  }); 
	});
	
	function CashSearchContent(url) {
		$('#cashPaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cashPaymentGridWindow').jqxWindow('setContent', data);
		$('#cashPaymentGridWindow').jqxWindow('bringToFront');
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
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);$('#txtapplyinvoiceamt').attr('readonly', true);
				     $('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
					 $('#frmCashPayment select').attr('disabled', false);$("#jqxApplyInvoicing").jqxGrid({ disabled: false});$("#jqxCashPayment").jqxGrid({ disabled: false});  
			    }
			   });
	  }
	  
	  function funPaymentAmount(txttoamount) {
	    if (parseFloat($("#txtapplyinvoiceapply").val())>0 && $("#mode").val()=="EDIT") {
	        if(parseFloat(txttoamount.value)<parseFloat(txttoamount.oldvalue)){
	        	$("#txttoamount").val(txttoamount.oldvalue);
	    		$.messager.alert('Message','Applied for '+txttoamount.oldvalue+'/-, Remove applied & then change the Payment Amount.','warning');
		    	return;
	        }
	    }
	  }
	
	 function funReadOnly(){
			$('#frmCashPayment input').attr('readonly', true );
			$('#frmCashPayment select').attr('disabled', true);
			$('#jqxCashPaymentDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
			$("#jqxCashPayment").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmCashPayment input').attr('readonly', false );
			$('#frmCashPayment select').attr('disabled', false);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxCashPaymentDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxCashPayment").jqxGrid({ disabled: false});
			
			var date = $('#jqxCashPaymentDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmCashPayment input').attr('readonly', true );
   			    $('#frmCashPayment select').attr('disabled', true);
   			    $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
			    $("#jqxCashPayment").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxCashPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCashPaymentDate').val(new Date());
				$("#jqxCashPayment").jqxGrid('clear'); 
				$("#jqxCashPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyInvoicing").jqxGrid('clear');
				$("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		changeContent('cpvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxCashPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmCashPayment').validate({
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
		    var paydate = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			 valid=document.getElementById("txtvalidation").value;
			 if(valid==1){
				 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
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
	    		
	     /* Cash Payment Grid  Saving*/
				 var rows = $("#jqxCashPayment").jqxGrid('getrows');
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
							
				    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Cash Payment Grid  Saving Ends*/	 
	 		
	 		/* Applying Invoice Grid Saving */
	 		var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
	 		var lengthapply=0;
			 for(var i=0 ; i < rows.length ; i++){
				    var chks=rows[i].applying;
	  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "txtapply"+lengthapply)
					    .attr("name", "txtapply"+lengthapply)
					    .attr("hidden", "true");
						lengthapply=lengthapply+1;
					
				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
				newTextBox.appendTo('form');
				}
			 }
			 $('#applylength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			 /* Applying Invoice Grid Updating */
		 		 var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
		 		 var lengthupdate=0;
				 for(var i=0 ; i < rows.length ; i++){
					    var chkd=rows[i].applying;
		  				if(typeof(chkd) != "undefined" && typeof(chkd) != "NaN" && chkd != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "txtapplyupdate"+lengthupdate)
						    .attr("name", "txtapplyupdate"+lengthupdate)
						    .attr("hidden", "true");
							lengthupdate=lengthupdate+1;
						
					newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
					newTextBox.appendTo('form');
					}
				  }
				  $('#applylengthupdate').val(lengthupdate);
				 /* Applying Invoice Grid Updating Ends*/
				 
				 if ($("#mode").val() == "E") {
			        	 $('#frmCashPayment select').attr('disabled', false); 
			      }
				 
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxCashPaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxCashPaymentDate').val();
		  getCurrencyId(date);
		  $('#jqxCashPaymentDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxCashPaymentDate').val()){
				 $("#jqxCashPaymentDate").jqxDateTimeInput('val', $('#hidjqxCashPaymentDate').val());
			  }

		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check=1;
	         	 $("#jqxCashPaymentGrid").load("cashPaymentGrid.jsp?txtcashpaydocno2="+indexVal+"&check="+check);
			 }
	         
			 var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	var check=1;
	         	$("#jqxApplyInvoicing1").load("applyInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         } 
		}
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxCashPayment').jqxGrid('getrows');
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
               	dr1=parseFloat(dr) + parseFloat(toamount);
                funRoundAmt(dr1,"txtdrtotal");
           	 }
	      }
		  else if(isNaN(toamount)){
			$('#txtdrtotal').val(0.00);
			$('#txttoamount').val(0.00);
		}
	  } 
	  
	  function getCrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,cr1=0.0;
        	    var rows = $('#jqxCashPayment').jqxGrid('getrows');
    	        var rowlength= rows.length;
        		for(var i=0;i<=rowlength-1;i++) {
        		
        		var value = rows[i].dr;
                var baseamount = rows[i].baseamount1;
                
                if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
	              
                	if(value==true){
                 	   if(!isNaN(baseamount)){
                       	dr=dr+baseamount;
                 	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 dr=dr+baseamount;
                 	   }
                    }
                    else{
                 	   if(!isNaN(baseamount)){
                   	  	cr=cr+baseamount;
                 	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 cr=cr+baseamount;
                 	   }
                    }
        	       }
        		}
        		
        		if(!isNaN(fromamount)){
                    cr1=parseFloat(cr) + parseFloat(fromamount);
                    funRoundAmt(cr1,"txtcrtotal");
                    }
		  }
		  else if(isNaN(fromamount)){
		  	$('#txtcrtotal').val(0.00);
		  	$('#txtfrombaseamount').val(0.00);
		  }
	  } 
	  
	  function getAmount(){
		  var toamount = $('#txttoamount').val();
		  if(!isNaN(toamount)){
		  	funRoundAmt(toamount,"txtapplyinvoiceamt");
		  }
		  else if(isNaN(toamount)){
			  $('#txtapplyinvoiceamt').val(0.00);
			  $('#txttoamount').val(0.00);
			}
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveCashPayment");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');$("#txtapplyinvoiceapply").val(0.00);
		  $("#jqxApplyInvoicing").jqxGrid('clear');
		  $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AP"){
      		$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
      	   }else if(atype == "AP"){
      		$("#jqxApplyInvoicing").jqxGrid({ disabled: false});
      	   }
	  }
	  
	  function datechange(){
		  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
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
<form id="frmCashPayment" action="saveCashPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxCashPaymentDate" name="jqxCashPaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCashPaymentDate"/>'></div>
    <input type="hidden" id="hidjqxCashPaymentDate" name="hidjqxCashPaymentDate" value='<s:property value="hidjqxCashPaymentDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcashpaydocno" style="width:50%;" value='<s:property value="txtcashpaydocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>
<table width="100%">
<tr>
<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Cash</td>
    <td><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:54%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td width="22%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onload="getRate(this.value,$('#jqxCashPaymentDate').val());" onchange="getRate(this.value,$('#jqxCashPaymentDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td width="23%" align="right">Rate</td>
    <td width="60%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:32%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:32%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>
  </tr>
   <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset>
<legend>Payment To</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="10%"><select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
    <option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>
    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" value='<s:property value="cmbtocurrency"/>' onload="getRatevalue(this.value,$('#jqxCashPaymentDate').val());" onchange="getRatevalue(this.value,$('#jqxCashPaymentDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>
    <td width="20%" align="right">Rate</td>
    <td width="57%"><input type="text" id="txttorate" name="txttorate" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" style="width:50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<fieldset>
<legend>Apply Invoices</legend>
<div id="jqxApplyInvoicing1"><center><jsp:include page="applyInvoicingGrid.jsp"></jsp:include></center></div>
<table width="100%">
  <tr>
    <td width="8%" align="right">Amount</td>
    <td width="24%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>
    <td width="5%" align="right">Applied</td>
    <td width="26%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Balance</td>
    <td width="27%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset><br/>
<div id="jqxCashPaymentGrid"><jsp:include page="cashPaymentGrid.jsp"></jsp:include></div><br/>
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
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
</div>
</form>
	
<div id="cashPaymentGridWindow">
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
	
</div>
</body>
</html>
