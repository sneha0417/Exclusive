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
		 
		 $("#icBankPaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});	
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '35%' , title: 'Inter Company / Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $('#bankPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#bankPaymentGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#icBankPaymentDate').on('change', function (event) {
				 var receiptdate = $('#icBankPaymentDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(receiptdate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
			 
		  $('#txtfromaccid').dblclick(function(){
			  var date = $('#icBankPaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
	});
	
	function BankSearchContent(url) {
		$('#bankPaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#bankPaymentGridWindow').jqxWindow('setContent', data);
		$('#bankPaymentGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountFromSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
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
	
	function getChequeNoAlreadyExists(chequeno,bankacno,mode,docno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
				
  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Cheque No. Already Exists.";
  					 return 0;
  				 }
  				document.getElementById("errormsg").innerText="";
  		}
	}
	x.open("GET", <%=contextPath+"/"%>+"com/finance/getChequeNoAlreadyExists.jsp?chequeno="+chequeno+'&bankacno='+bankacno+'&mode='+mode+'&docno='+docno, true);
	x.send();
    }
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);
					 $('#txtdescription').attr('readonly', false);$('#txtfromrate').attr('readonly', false);$('#txtfrombaseamount').attr('readonly', true);
					 $('#txtchequeno').attr('readonly', false);$('#txtchequename').attr('readonly', false);$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
				     $('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);$('#frmIcBankPayment select').attr('disabled', false);
				     $('#txtpaymentreceivedfrom').attr('readonly', false);$("#icBankPaymentGridId").jqxGrid({ disabled: false});  
			    }
			   });
	  }
	  
	 function funReadOnly(){
			$('#frmIcBankPayment input').attr('readonly', true );
			$('#frmIcBankPayment select').attr('disabled', true);
			$('#icBankPaymentDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$("#icBankPaymentGridId").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmIcBankPayment input').attr('readonly', false );
			$('#frmIcBankPayment select').attr('disabled', false);
			$('#icBankPaymentDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#docno').attr('readonly', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txtfrombaseamount').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$("#icBankPaymentGridId").jqxGrid({ disabled: false});

			var date = $('#icBankPaymentDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIcBankPayment input').attr('readonly', true );
   			    $('#frmIcBankPayment select').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			    $("#icBankPaymentGridId").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $('#txtpaymentreceivedfrom').attr('readonly', false);
   			    $("#icBankPaymentGridId").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#icBankPaymentDate').val(new Date());
				$('#jqxChequeDate').val(new Date());
				$("#icBankPaymentGridId").jqxGrid('clear'); 
				$("#icBankPaymentGridId").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('icbpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#icBankPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmIcBankPayment').validate({
	        	 rules: {
		                txtfromaccid:"required",
		                txtfromamount:{"required":true,number:true},
		                txtdescription:{maxlength:500}
		                 },
		                 messages: {
		                 txtfromaccid:" *",
		                 txtfromamount:{required:" *",number:"Invalid"},
		                 txtdescription: {maxlength:"    Max 500 chars"}
		                 }
	        });});
	   
	  function funNotify(){	
		  /* Validation */
		    getChequeNoAlreadyExists($('#txtchequeno').val(),$('#txtfromdocno').val(),$("#mode").val(),$("#docno").val());
		  
		    var receiptdate = $('#icBankPaymentDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(receiptdate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		    }
			 
			 currency=document.getElementById("cmbfromcurrency").value;
			 if(currency==""){
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
	    	    
	    	 /*IC Bank Payment Grid  Saving*/
	  		  var rows = $("#icBankPaymentGridId").jqxGrid('getrows');
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
	  					
	  				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].dbname+":: "+rows[i].intrbrhid+":: "+rows[i].intrcompid);
	  				newTextBox.appendTo('form');
				     }
	  				}
			        $('#gridlength').val(length);
	  	 		   /*IC Bank Payment Grid  Saving Ends*/	 
	  	 		
	  	 		  $('#icBankPaymentDate').jqxDateTimeInput({disabled: false});
			      $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			         
	  			  if ($("#mode").val() == "E") {
			         $('#frmIcBankPayment select').attr('disabled', false); 
			      }
				 
	    		return 1;
		} 
	  
	  function setValues(){
		  $('#icBankPaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#icBankPaymentDate').val();
		  getCurrencyId(date);
		  $('#icBankPaymentDate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidicBankPaymentDate').val()){
				 $("#icBankPaymentDate").jqxDateTimeInput('val', $('#hidicBankPaymentDate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
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
	         	 $("#icBankPaymentGridDiv").load("icBankPaymentGrid.jsp?txticcashpaydocno2="+indexVal+"&check="+check);
			 }
	         
		}
	  
	  function getCrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,cr1=0.0;
        	    var rows = $('#icBankPaymentGridId').jqxGrid('getrows');
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
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#icBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveIcBankPayment");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIcBankPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIcBankPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  var date = $('#icBankPaymentDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  $("#jqxChequeDate").jqxDateTimeInput('val', date);
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
<form id="frmIcBankPayment" action="saveIcBankPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="icBankPaymentDate" name="icBankPaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="icBankPaymentDate"/>'></div>
    <input type="hidden" id="hidicBankPaymentDate" name="hidicBankPaymentDate" value='<s:property value="hidicBankPaymentDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txticbankpaymentdocno" style="width:50%;" value='<s:property value="txticbankpaymentdocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Bank</td>
    <td width="16%"><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:85%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
    <td width="7%" align="right">Currency</td>
    <td width="17%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:40%;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#icBankPaymentDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td width="8%" align="right">Rate</td>
    <td width="19%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:45%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="getBaseAmountFrom();getCrTotal();funRoundAmt(this.value,this.id);" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="getBaseAmountFrom();getCrTotal();funRoundAmt(this.value,this.id);" tabindex="-1"/></td>
    <td width="11%" align="right">Base Amount</td>
    <td width="16%"><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:75%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>
    <td align="right">Cheque No.</td>
    <td><input type="text" id="txtchequeno" name="txtchequeno" style="width:98%;" onblur="getChequeNoAlreadyExists(this.value,$('#txtfromdocno').val(),$('#mode').val(),$('#docno').val());" value='<s:property value="txtchequeno"/>' /></td>
    <td align="right">Cheque Date</td>
    <td><div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Cheque Name</td>
    <td colspan="3"><input type="text" id="txtchequename" name="txtchequename" style="width:61%;" value='<s:property value="txtchequename"/>' /></td>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:77%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
   <tr>
    <td align="right">Received From</td>
     <td colspan="7"><input type="text" id="txtpaymentreceivedfrom" name="txtpaymentreceivedfrom" style="width:41%;" value='<s:property value="txtpaymentreceivedfrom"/>'/>
     <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
     <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<div id="icBankPaymentGridDiv"><jsp:include page="icBankPaymentGrid.jsp"></jsp:include></div><br/>
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
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
<div id="bankPaymentGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>   

<div id="branchSearchWindow">
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
