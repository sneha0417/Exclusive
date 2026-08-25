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
		 $("#btnUnclearedChequeSearch").hide();
		
		 $("#jqxUnclearedChequeProcessingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxUnclearedChequeProcessFromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxUnclearedChequeProcessToDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#postingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: null });
		 
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

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();headerbtndisable();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmUnclearedChequeProcessing" action="saveUnclearedChequeProcessing" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>

<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right"><!-- Date --> &nbsp;</td>
    <td width="12%"><div id="jqxUnclearedChequeProcessingDate" hidden="true" name="jqxUnclearedChequeProcessingDate" value='<s:property value="jqxUnclearedChequeProcessingDate"/>'></div>
    <input type="hidden" id="hidjqxUnclearedChequeProcessingDate" name="hidjqxUnclearedChequeProcessingDate" value='<s:property value="hidjqxUnclearedChequeProcessingDate"/>'/></td>
    <td width="14%" align="right">Uncleared P.D.C From</td>
    <td width="8%"><div id="jqxUnclearedChequeProcessFromDate" name="jqxUnclearedChequeProcessFromDate" value='<s:property value="jqxUnclearedChequeProcessFromDate"/>'></div>
    <input type="hidden" id="hidjqxUnclearedChequeProcessFromDate" name="hidjqxUnclearedChequeProcessFromDate" value='<s:property value="hidjqxUnclearedChequeProcessFromDate"/>'/></td>
    <td width="7%" align="right">P.D.C. Upto</td>
    <td width="9%"><div id="jqxUnclearedChequeProcessToDate" name="jqxUnclearedChequeProcessToDate" value='<s:property value="jqxUnclearedChequeProcessToDate"/>'></div>
    <input type="hidden" id="hidjqxUnclearedChequeProcessToDate" name="hidjqxUnclearedChequeProcessToDate" value='<s:property value="hidjqxUnclearedChequeProcessToDate"/>'/></td>
    <td width="3%" align="right">Type</td>
    <td width="9%"><select id="cmbtype" name="cmbtype" style="width:80%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="UCP">Payment</option><option value="UCR">Receipt</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td width="6%" align="right">Posting</td>
    <td width="13%"><div id="postingDate" name="postingDate" onchange="datechange();" onblur="datechange();" value='<s:property value="postingDate"/>'></div>
    <input type="hidden" id="hidpostingDate" name="hidpostingDate" value='<s:property value="hidpostingDate"/>'/></td>
    <td width="16%" align="left"><button class="myButton" type="button" id="btnUnclearedChequeSearch" name="btnUnclearedChequeSearch" onclick="funloadgrid();">View</button></td>
  </tr>
</table>
</fieldset><br/>

<div id="unclearedChequeProcessingDiv"><center><jsp:include page="unclearedChequeProcessingGrid.jsp"></jsp:include></center></div><br/>

<div id="bankPaymentDiv"><center><jsp:include page="bankPaymentGrid.jsp"></jsp:include></center></div><br/>

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
</form>
	
</div>
</body>
</html>
