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
		
		 $("#jqxDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: null });
		 $("#jqxFromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#chequedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#checkchequedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');  
		 
		 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		
		$('#txtaccid').dblclick(function(){
			  accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
			  });
	});
	
	function accountSearchContent(url){
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getPDCAccounts(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  			
  			    $('#txtpdcdocno').val(docNoItems);	
  			    $('#txtpdcaccid').val(accountIdItems);
  			    $('#txtpdcaccname').val(accountItems);
  			  	$('#txtpdcatype').val(accountTypeItems);
			    $('#txtpdccurid').val(accountCurIdItems);
			    $('#txtpdcrate').val(accountRateItems);
			    $('#txtpdctype').val(accCurrTypeItems);
  		}
  		}
  		x.open("GET", "getPDCAccounts.jsp", true);
  		x.send();
   }
	
	 function getAcc(event){
         var x= event.keyCode;
         if(x==114){
        	 accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
            }
         }
	 
	 function funReadOnly(){
			$('#frmPDCPostingPayment input').attr('readonly', true );
			$('#frmPDCPostingPayment select').attr('disabled', true);
			$('#jqxFromDate').jqxDateTimeInput({disabled: true});
			$('#jqxToDate').jqxDateTimeInput({disabled: true});
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").hide();
	 }
	 
	 function funRemoveReadOnly(){
		    $('#frmPDCPostingPayment input').attr('readonly', false );
			$('#frmPDCPostingPayment select').attr('disabled', false);
			$('#jqxFromDate').jqxDateTimeInput({disabled: false});
			$('#jqxToDate').jqxDateTimeInput({disabled: false});
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtbankaccid').attr('readonly', true );
			$('#txtbankaccname').attr('readonly', true );     
			$('#txtchequeno').attr('readonly', true );
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").show();
			
			if ($("#mode").val() == "A") {
			     getPDCAccounts();
				 $('#jqxFromDate').val(new Date());
				 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
			     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			     $('#jqxToDate').val(new Date());
				 $('#jqxDate').val(null);
			     $('#chequedate').val(new Date());
				 $('#checkchequedate').val(new Date());
			     $('#txtbankaccid').attr('readonly', true );
				 $('#txtbankaccname').attr('readonly', true );
				 $('#txtchequeno').attr('readonly', true );
				 $("#jqxJournalVoucher").jqxGrid('clear'); 
				 $("#jqxJournalVoucher").jqxGrid('addrow', null, {}); 
			     $("#jqxJournalVoucherApplying").jqxGrid('clear');
				 $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {}); 
			} 
			
	 }
	 
	 function funSearchLoad(){}
		
	 function funChkButton(){
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	document.getElementById("cmbcriteria").focus(); 	    		
	    }
	 
	 function funNotify(){	
		 
		 /* Validation */
		 
		    if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
		  
		  	if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		  	}
	    	
			var postdate = $('#jqxDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(parseInt(postvaliddate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			if($('#txtchequevalidation').val()==1){
				 document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
				 return 0;
			}
			
			if($('#cmbcriteria').val()!='4'){
				var applyrows=$("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(applyrows.length<=1){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
			   }
			}else if($('#cmbcriteria').val()=='4'){
				if(document.getElementById("txtchequeno").value=="" || document.getElementById("txtchequeno").value==null){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
				 }
			}
			
			if($('#cmbcriteria').val()=='1'){
				var rows1 = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(typeof(rows1[0].doc_no) == "undefined" || typeof(rows1[0].doc_no) == "NaN" || rows1[0].doc_no == ""){
					document.getElementById("errormsg").innerText="Select a Bank Account.";
					return 0;
				}
			}
			
	     document.getElementById("errormsg").innerText="";
		 /* Validation Ends*/
			
		 /* Journal Voucher Applying Grid Saving */
    	 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
 		 var length=0;
 		 for(var i=0 ; i < rows.length ; i++){
 			var chk=rows[i].doc_no;
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
				length=length+1;
				
			var amount,baseamount,id;
			if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
				 amount=rows[i].credit*-1;
				 baseamount=rows[i].baseamount*-1;
				 id=-1;
				
			}
			
			if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
				 amount=rows[i].debit;
				 baseamount=rows[i].baseamount;
				 id=1;
			}
			
			if($('#txtdtype').val()=='IBP'){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else if(($('#txtdtype').val()=='COT' && $('#txtibbranch').val()=='1')){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else{
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+rows[i].sr_no+":: "+id+":: 0:: 0");
			}
			newTextBox.appendTo('form');
			}
 		 }
		 $('#gridlength').val(length);
 		/* Journal Voucher Applying Grid Saving Ends */
 		 
 		  $('#jqxFromDate').jqxDateTimeInput({disabled: false});
		  $('#jqxToDate').jqxDateTimeInput({disabled: false});
		  $('#jqxDate').jqxDateTimeInput({disabled: false});
		  $('#chequedate').jqxDateTimeInput({disabled: false});
		  $('#cmbcriteria').attr('disabled', false);
		  $('#cmbacctype').attr('disabled', false);
		  
		  return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbcriteria").value=document.getElementById("hidcmbcriteria").value;
		  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
		  
		  if($('#hidjqxFromDate').val()){
				 $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());
			  }
		  
		  if($('#hidjqxToDate').val()){
				 $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());
			  }
		  
		  if($('#hidjqxDate').val()){
				 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
			  }
			  
		  if($('#hidchequedate').val()){
				 $("#chequedate").jqxDateTimeInput('val', $('#hidchequedate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  $('#cmbcriteria').attr('disabled', false);$('#cmbacctype').attr('disabled', false);
		  
		  
		  if($('#mode').val()=="view"){
			    $("#jqxJournalVoucher").jqxGrid({ disabled: true});
			  	$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			  	$("#jqxJournalVoucherApplying").jqxGrid('clear');
			  	$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
			  }
		  $('#cmbcriteria').attr('disabled', true);$('#cmbacctype').attr('disabled', true);
		  
		}
		
		function checkChequeDate(){
		 var posted=$('#cmbcriteria').val();
         if(posted==4){
		  var newchequedate = $('#chequedate').jqxDateTimeInput('getDate');
		  var oldchequedate = $('#checkchequedate').jqxDateTimeInput('getDate');
		  if(newchequedate<oldchequedate){
			  document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
			  $('#txtchequevalidation').val(1);
			  return 0;
		  }
		  document.getElementById("errormsg").innerText="";
		  $('#txtchequevalidation').val(0);
		  return 1;
		  }
	  }
	  
	  function gridloading(){
		  var criteria = document.getElementById("cmbcriteria").value;
		  var accId = document.getElementById("txtdocno").value;      
		  var accType = document.getElementById("cmbacctype").value;
		  var fromDate = document.getElementById("jqxFromDate").value;
		  var toDate = document.getElementById("jqxToDate").value;
		  var check = 1;  
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#jqxJournalVoucherGrid").load('journalVoucherGrid.jsp?txtcriteria='+criteria+'&accId='+accId+'&accType='+accType+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
	  }
	  
	  function funloadgrid(){
		    
			if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
			
			if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		    }
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
		  
		  document.getElementById("errormsg").innerText="";
		  
		  $("#jqxJournalVoucher").jqxGrid({ disabled: false});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  
		  getPDCAccounts();
		  gridloading();
		  }
	  
	  function dateDisable(){
		 var posted=$('#cmbcriteria').val();
         if(posted==1){
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
        	 $("#pdcPostponedDiv").prop("hidden", true);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
         }else if(posted==4){
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
        	 $("#pdcPostponedDiv").prop("hidden", false);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", true);
         }else{
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
        	 $("#pdcPostponedDiv").prop("hidden", true);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
         }
	  }
	  
	  function headerbtndisable(){
		  $('#btnEdit').attr('disabled', true);
		  $('#btnDelete').attr('disabled', true);
		  $('#btnSearch').attr('disabled', true);
	  }
	 
	  function clearClientInfo(){
		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
		  if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		  $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucher").jqxGrid('clear');
		  $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
	  }
	  
	   function datechange(){
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
		   $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucherApplying").jqxGrid('clear');
		   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		   $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucher").jqxGrid('clear');
		   $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
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
<form id="frmPDCPostingPayment" action="savePDCPostingPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Criteria</td>
    <td width="23%"><select id="cmbcriteria" name="cmbcriteria" style="width:97%;" value='<s:property value="cmbcriteria"/>' onchange="dateDisable();getPDCAccounts();clearClientInfo();">
    <option value="">--Select--</option><option value="1">PDC to be Posted</option><option value="2">PDC to be Returned</option><option value="3">Posted PDC to be Dishonoured</option>
    <option value="4">PDC to be Postponed</option><option value="5">Retuned PDC to be Reversed</option><option value="6">Dishourned PDC to be Reversed</option>
    <option value="7">CDC to be Dishourned</option></select>
    <input type="hidden" id="hidcmbcriteria" name="hidcmbcriteria" value='<s:property value="hidcmbcriteria"/>'/></td>
    <td width="3%" align="right">From</td>
    <td width="3%"><div id="jqxFromDate" name="jqxFromDate" value='<s:property value="jqxFromDate"/>'></div>
    <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/></td>
    <td width="2%" align="right">To</td>          
    <td width="3%"><div id="jqxToDate" name="jqxToDate" value='<s:property value="jqxToDate"/>'></div>
    <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/></td>
    <td width="4%" align="right">Account</td>   
    <td width="9%"><select id="cmbacctype" name="cmbacctype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbacctype"/>'>
    <option value="0">--Select--</option><option value="BANK">Bank</option><option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/></td>
    <td width="12%"><input type="text" id="txtaccid" name="txtaccid" style="width:85%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/></td>
    <td width="24%"><input type="text" id="txtaccname" name="txtaccname" style="width:97%;" value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="3%" align="right">Posting</td>
    <td width="4%"><div id="jqxDate" name="jqxDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxDate"/>'></div>
	<input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/></td>
    <td width="8%" align="center"><button class="myButton" type="button" id="btnview" name="btnview" onclick="funloadgrid();">View</button></td>
  </tr>
  </table></fieldset><br/>
 <div id="jqxJournalVoucherGrid"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div><br/>
 <div id="jqxJournalVoucherApplyingGrid"><jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include></div>
 <div id="pdcPostponedDiv" hidden="true">
 <fieldset style="background: #ECF8E0;">
 <table width="100%">
  <tr>
    <td width="7%" align="right">Bank</td>
    <td width="14%"><input type="text" id="txtbankaccid" name="txtbankaccid" style="width:80%;" value='<s:property value="txtbankaccid"/>'/></td>
    <td colspan="2"><input type="text" id="txtbankaccname" name="txtbankaccname" style="width:40%;" value='<s:property value="txtbankaccname"/>'/>
    <input type="hidden" id="txtbankdocno" name="txtbankdocno" value='<s:property value="txtbankdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Cheque No.</td>
    <td><input type="text" id="txtchequeno" name="txtchequeno" style="width:80%;" value='<s:property value="txtchequeno"/>'/></td>
    <td width="8%" align="right">Cheque Date</td>
    <td width="71%"><div id="chequedate" name="chequedate" onchange="checkChequeDate();" value='<s:property value="chequedate"/>'></div>
	<input type="hidden" id="hidchequedate" name="hidchequedate" value='<s:property value="hidchequedate"/>'/>
	<div hidden="true" id="checkchequedate" name="checkchequedate" value='<s:property value="checkchequedate"/>'></div></td>
  </tr>
</table>
</fieldset>
 </div>
 
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtpdcdocno" name="txtpdcdocno"  value='<s:property value="txtpdcdocno"/>'/>
<input type="hidden" id="txtpdcaccid" name="txtpdcaccid"  value='<s:property value="txtpdcaccid"/>'/>
<input type="hidden" id="txtpdcaccname" name="txtpdcaccname"  value='<s:property value="txtpdcaccname"/>'/>
<input type="hidden" id="txtpdcatype" name="txtpdcatype"  value='<s:property value="txtpdcatype"/>'/>
<input type="hidden" id="txtpdccurid" name="txtpdccurid"  value='<s:property value="txtpdccurid"/>'/>
<input type="hidden" id="txtpdcrate" name="txtpdcrate"  value='<s:property value="txtpdcrate"/>'/>
<input type="hidden" id="txtpdctype" name="txtpdctype"  value='<s:property value="txtpdctype"/>'/>
<input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
<input type="hidden" id="txtgriddocno" name="txtgriddocno" value='<s:property value="txtgriddocno"/>'/>
<input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtposttrno" name="txtposttrno"  value='<s:property value="txtposttrno"/>'/>
<input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
<input type="hidden" id="txtibbranch" name="txtibbranch" value='<s:property value="txtibbranch"/>'/>
<input type="hidden" id="typevalue" name="typevalue"  value='<s:property value="typevalue"/>'/>
<input type="hidden" id="txtchequevalidation" name="txtchequevalidation"  value='<s:property value="txtchequevalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>