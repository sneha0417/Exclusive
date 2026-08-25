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
		 $('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		 
		 $("#jqxMultipleChequePreparationDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#jqxMultipleChequePreparationDate').on('change', function (event) {
				 var multiplechequepreparationdate = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
				 funDateInPeriod(multiplechequepreparationdate); 
		 });
		
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		 });
		 
		 $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
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
	
	 function funReadOnly(){
			$('#frmMultipleChequePreparation input').attr('readonly', true );
			$('#frmMultipleChequePreparation select').attr('disabled', true);
			$('#jqxMultipleChequePreparationDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#btnfill').attr('disabled', true);
			$("#chequeDetailsGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    
			$('#frmMultipleChequePreparation input').attr('readonly', false );
			$('#frmMultipleChequePreparation select').attr('disabled', false);
			
			$('#jqxMultipleChequePreparationDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#btnfill').attr('disabled', false);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#docno').attr('readonly', true);
			$("#chequeDetailsGridID").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxMultipleChequePreparationDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "A") {
				$('#jqxMultipleChequePreparationDate').val(new Date());
				$('#jqxChequeDate').val(new Date());
				$("#txtchequeduration").val('0');
				$("#txtnoofcheques").val('1');
			  	$("#chequeDetailsGridID").jqxGrid('clear');
			  	$("#chequeDetailsGridID").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","dr": true,"amount1": "","baseamount1": "","chequeno": "","chequedate": "","description": "","grtype": "","currencytype": "","sr_no":""}); 
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('mcpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxMultipleChequePreparationDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  /* Validations */
	  $(function(){
	        $('#frmMultipleChequePreparation').validate({
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
		  
		    var multiplechequepreparationdate = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(multiplechequepreparationdate);
			if(validdate==0){
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
	    
	    	/* Cheque Details Grid  Saving*/
	  		  var rows = $("#chequeDetailsGridID").jqxGrid('getrows');
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
	  					
	  				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0::0::0:: "+rows[i].chequeno+":: "+$('#chequeDetailsGridID').jqxGrid('getcelltext', i, "chequedate"));
	  				newTextBox.appendTo('form');
	  				}
			      }
			      $('#gridlength').val(length);
	  	 	 /* Cheque Details Grid  Saving Ends*/
	  	 		   
	    	 $('#jqxMultipleChequePreparationDate').jqxDateTimeInput({disabled: false});
	         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	         
	         if ($("#mode").val() == "E") {
	        	 $('#frmMultipleChequePreparation select').attr('disabled', false); 
	         }
	  				 
	    		return 1;
		} 
	  
	  function setValues(){
		  
		  $('#jqxMultipleChequePreparationDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxMultipleChequePreparationDate').val();
		  getCurrencyId(date);
		  $('#jqxMultipleChequePreparationDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  document.getElementById("cmbchequefrequency").value=document.getElementById("hidcmbchequefrequency").value;
		  
		  if($('#hidjqxMultipleChequePreparationDate').val()){
				 $("#jqxMultipleChequePreparationDate").jqxDateTimeInput('val', $('#hidjqxMultipleChequePreparationDate').val());
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
				 var check = 1;
	         	 $("#chequeDetailsDiv").load("chequeDetailsGrid.jsp?txtmultiplechequepreparationdocno2="+indexVal+"&check="+check);
			 } 
	         
		}
	  
	  function funInstAmount() {
			 
			 var amount=$('#txtfromamount').val();
			 var instno=$('#txtnoofcheques').val();
			 
			 if(parseInt(instno)==0 || instno==""){
				 instno=1;
				 $('#txtnoofcheques').val("1");
			 }
			 if(!isNaN(amount)){
			     var result = parseFloat(amount) / parseFloat(instno);
				 funRoundAmt(result,"txtinstamt");
				 }
				 else if(isNaN(amount)){
					 funRoundAmt(0,"txtinstamt");
				 }
		 }
	  
	  function funfill(){
		  var acno=$("#txttodocno").val();
		  var chequestartdate=$("#jqxChequeDate").val();
		  var chequeno=$("#txtchequeno").val();
		  var chequeduration=$("#txtchequeduration").val();
		  var chequefrequency=$("#cmbchequefrequency").val();
		  var noofcheques=$("#txtnoofcheques").val();
		  var description=$("#txtdescription").val();
		  var amount=$("#txtfromamount").val();
		  var instamount=$("#txtinstamt").val();
		  
		  if(acno==""){
			   document.getElementById("errormsg").innerText="Account is Mandatory.";
			   return 0;
		  }
		  
		  if(chequestartdate==""){
			   document.getElementById("errormsg").innerText="Cheque Start Date is Mandatory.";
			   return 0;
		  }
		  
		  if(chequeno==""){
			   document.getElementById("errormsg").innerText="Cheque No is Mandatory.";
			   return 0;
		  }
		  
		  if(chequeduration==""){
			   document.getElementById("errormsg").innerText="Cheque Duration is Mandatory.";
			   return 0;
		  }
		  
		  if(chequefrequency==""){
			   document.getElementById("errormsg").innerText="Cheque Frequency is Mandatory.";
			   return 0;
		  }
		  
		  if(noofcheques==""){
			   document.getElementById("errormsg").innerText="No of Cheques is Mandatory.";
			   return 0;
		  }
		  
		  if(amount==""){
			   document.getElementById("errormsg").innerText="Amount is Mandatory.";
			   return 0;
		  }
		  
		  document.getElementById("errormsg").innerText="";
		  var fillchequedetails=1;
		  var check=1;
		  
		  $("#chequeDetailsDiv").load("chequeDetailsGrid.jsp?acno="+acno+"&chequestartdate="+chequestartdate+"&chequeno="+chequeno.replace(/ /g, "%20")+"&chequeduration="+chequeduration+"&chequefrequency="+chequefrequency+"&noofcheques="+noofcheques+"&description="+description.replace(/ /g, "%20")+"&amount="+amount+"&instamount="+instamount+"&fillchequedetails="+fillchequedetails+"&check="+check);
		  
	  }
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#chequeDetailsGridID').jqxGrid('getrows');
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
        	    var rows = $('#chequeDetailsGridID').jqxGrid('getrows');
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
        	  var date = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			/* BankPrintContent('printVoucherWindow.jsp'); */
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	      }
	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
		  if (document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
	  }
	 
	  function datechange(){
		  var date = $('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate');
		    var validdate=funDateInPeriod(date);
			if(validdate==0){
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
<form id="frmMultipleChequePreparation" action="saveMultipleChequePreparation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxMultipleChequePreparationDate" name="jqxMultipleChequePreparationDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxMultipleChequePreparationDate"/>'></div>
	<input type="hidden" id="hidjqxMultipleChequePreparationDate" name="hidjqxMultipleChequePreparationDate" value='<s:property value="hidjqxMultipleChequePreparationDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtmultiplechequepreparationdocno" style="width:50%;" value='<s:property value="txtmultiplechequepreparationdocno"/>' tabindex="-1"/></td>
  </tr>
</table>

<table width="100%">
<tr>
<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="8%" align="right">Bank</td>
    <td><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:90%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="3"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:58%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td width="16%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxMultipleChequePreparationDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>
    <td colspan="2" align="right">Rate</td>
    <td width="50%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:35%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:90%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();funInstAmount();" /></td>
    <td colspan="2"  align="right">Base Amount</td>
    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:34%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>
  </tr>
   <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset>
<legend>Auto Fill Options</legend>
<table width="100%">
  <tr>
    <td width="9%" align="right">Type</td>
    <td width="7%"><select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
    <option value="GL">GL</option><option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>
    <td width="19%"><input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Start Chq#</td>
    <td colspan="2"><input type="text" id="txtchequeno" name="txtchequeno" style="width:100%;" onblur="getChequeNoAlreadyExists(this.value,$('#txtfromdocno').val(),$('#mode').val(),$('#docno').val());" value='<s:property value="txtchequeno"/>' /></td>
    <td width="15%" align="right">Cheque Date</td>
    <td width="50%"><div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxMultipleChequePreparationDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>
    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Cheque Dur.</td>
    <td colspan="2"><input type="text" id="txtchequeduration" name="txtchequeduration" style="width:30%;" value='<s:property value="txtchequeduration"/>'/>&nbsp;&nbsp;
    <select id="cmbchequefrequency" name="cmbchequefrequency" style="width:30%;" value='<s:property value="cmbchequefrequency"/>'>
    <option value="1">Day</option><option value="2">Month</option><option value="3">Year</option></select>
    <input type="hidden" id="hidcmbchequefrequency" name="hidcmbchequefrequency" value='<s:property value="hidcmbchequefrequency"/>'/></td>
    <td align="right">No. of Cheque</td>
    <td><input type="text" id="txtnoofcheques" name="txtnoofcheques" style="width:20%;" onblur="funInstAmount();" value='<s:property value="txtnoofcheques"/>'/>
    <input type="hidden" id="txtinstamt" name="txtinstamt" style="width:50%;" value='<s:property value="txtinstamt"/>'/>&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnfill" name="btnfill" onclick="funfill();">Fill</button></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<fieldset>
<legend>Cheque Details</legend>
<div id="chequeDetailsDiv"><jsp:include page="chequeDetailsGrid.jsp"></jsp:include></div>
</fieldset>
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
<select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" hidden="true" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxMultipleChequePreparationDate').val());">
<option></option></select>
<input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
<input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
<input type="hidden" id="txttorate" name="txttorate" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>'/>
<input type="hidden" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='0'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>

<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
<div id="accountDetailsToWindow">
	<div></div><div></div>
</div> 
</div>
</body>
</html>