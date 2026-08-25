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
		 
		 $("#jqxCashReceiptDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#cashReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashReceiptGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCashReceiptDate').on('change', function (event) {
				 var receiptdate = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(receiptdate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
		         }
			 });
			 
		  $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
	});
	
	function CashSearchContent(url) {
		$('#cashReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cashReceiptGridWindow').jqxWindow('setContent', data);
		$('#cashReceiptGridWindow').jqxWindow('bringToFront');
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
					 $('#frmCashReceipt select').attr('disabled', false);$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false});$("#jqxCashReceipt").jqxGrid({ disabled: false});  
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
			$('#frmCashReceipt input').attr('readonly', true );
			$('#frmCashReceipt select').attr('disabled', true);
			$('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			$("#jqxCashReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmCashReceipt input').attr('readonly', false );
			$('#frmCashReceipt select').attr('disabled', false);
			$('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxCashReceipt").jqxGrid({ disabled: false});

			var date = $('#jqxCashReceiptDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmCashReceipt input').attr('readonly', true );
   			    $('#frmCashReceipt select').attr('disabled', true);
   			    $("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			    $("#jqxCashReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxCashReceipt").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCashReceiptDate').val(new Date());
				$("#jqxCashReceipt").jqxGrid('clear'); 
				$("#jqxCashReceipt").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyCashReceiptInvoicing").jqxGrid('clear');
				$("#jqxApplyCashReceiptInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('crvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxCashReceiptDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmCashReceipt').validate({
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
		  
		    var receiptdate = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(receiptdate);
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
	    	    
	    	 /* Cash Receipt Grid  Saving*/
	  		  var rows = $("#jqxCashReceipt").jqxGrid('getrows');
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
							 baseamount=rows[i].baseamount1*-1;
						}
						else if(rows[i].dr==false){
							 amount=rows[i].amount1;
							 baseamount=rows[i].baseamount1;
						}
	  					
	  				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode);
	  				newTextBox.appendTo('form');
				     }
	  				}
			        $('#gridlength').val(length);
	  	 		   /* Cash Receipt Grid  Saving Ends*/	 
	  	 		
	  	 		/* Applying Invoice Grid Saving */
	  	 		var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
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
	  					
	  				newTextBox.val(rows[i].applying+"::"+parseFloat((rows[i].out_amount+rows[i].applying)*-1)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
	  				newTextBox.appendTo('form');
	  				}
	  			 }
	  			$('#applylength').val(lengthapply);
	  			 /* Applying Invoice Grid Saving Ends*/
	  			 
	  			 /* Applying Invoice Grid Updating */
	  		 		var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
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
			         $('#frmCashReceipt select').attr('disabled', false); 
			      }
				 
	  				 
	    		return 1;
		} 
	  
	  function setValues(){
		  funeditstatus(); 
		  $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxCashReceiptDate').val();
		  getCurrencyId(date);
		  $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxCashReceiptDate').val()){
				 $("#jqxCashReceiptDate").jqxDateTimeInput('val', $('#hidjqxCashReceiptDate').val());
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
	         	 $("#jqxCashReceiptGrid").load("cashReceiptGrid.jsp?txtcashpaydocno2="+indexVal+"&check="+check);
			 }
	         var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	 var check=1;
	        	 $("#jqxApplyInvoicing1").load("applyCashReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         }
		}
	  
	  function getDrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  
		  if(!isNaN(fromamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxCashReceipt').jqxGrid('getrows');
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
			$('#txtfrombaseamount').val(0.00);			
		}
	  } 
	  
	  function getCrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  if(!isNaN(toamount)){
			  
			    var dr=0.0,cr=0.0,cr1=0.0;
        	    var rows = $('#jqxCashReceipt').jqxGrid('getrows');
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
        	  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveCashReceipt");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  $("#jqxApplyCashReceiptInvoicing").jqxGrid('clear');
		  $("#jqxApplyCashReceiptInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AR"){
      		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
      	   }else if(atype == "AR"){
      		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false});
      	   }
	  }
	  
	  function datechange(){
		  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  function funeditstatus() {
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
              if (x.readyState == 4 && x.status == 200) {
                  var items = x.responseText.trim();
                  if (parseInt(items) > 0) {
                      $("#btnEdit").attr('disabled', true);
                      $("#btnDelete").attr('disabled', true);         

                  } else {

                  }

              } else {}
          }
          x.open("GET", "getEditStatus.jsp?masterdoc_no=" + document.getElementById("txttotrno").value, true);          
          x.send();
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
<form id="frmCashReceipt" action="saveCashReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxCashReceiptDate" name="jqxCashReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCashReceiptDate"/>'></div>
    <input type="hidden" id="hidjqxCashReceiptDate" name="hidjqxCashReceiptDate" value='<s:property value="hidjqxCashReceiptDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcashreceiptdocno" style="width:50%;" value='<s:property value="txtcashreceiptdocno"/>' tabindex="-1"/>
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
    <td><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:54%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td width="22%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxCashReceiptDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td width="23%" align="right">Rate</td>
    <td width="60%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:32%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" /></td>
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
<legend>Payment From</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="10%"><select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
    <option value="AR">AR</option><option value="AP">AP</option></select>
    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>
    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxCashReceiptDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>
    <td width="20%" align="right">Rate</td>
    <td width="57%"><input type="text" id="txttorate" name="txttorate" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" style="width:50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" /></td>
    <td align="right">Base Amount</td>
    <td><input type="text" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<fieldset>
<legend>Apply Invoices</legend>
<div id="jqxApplyInvoicing1"><center><jsp:include page="applyCashReceiptInvoicingGrid.jsp"></jsp:include></center></div> 
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
<div id="jqxCashReceiptGrid"><jsp:include page="cashReceiptGrid.jsp"></jsp:include></div><br/>
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
	
<div id="cashReceiptGridWindow">
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
