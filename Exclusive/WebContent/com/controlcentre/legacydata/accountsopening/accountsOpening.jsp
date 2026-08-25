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
		 
		$('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountDetailsWindow').jqxWindow('close');
		
		 $('#openingBalanceGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#openingBalanceGridWindow').jqxWindow('close');
		 
		 $('#txtaccid').dblclick(function(){
			  accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	     });
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function OpeningSearchContent(url) {
		$('#openingBalanceGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#openingBalanceGridWindow').jqxWindow('setContent', data);
		$('#openingBalanceGridWindow').jqxWindow('bringToFront');
	}); 
	} 

	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	       }
	    }
	
	function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data1, 'AccountsOpening', true);
			 } else {
				 $("#jqxAppliedAccounts").jqxGrid('exportdata', 'xls', 'AccountsOpening');
			 }
		  }
	  }
	  
	function funReadOnly(){
		$('#frmAccountsOpening input').attr('readonly', true );
		$('#frmAccountsOpening select').attr('disabled', true);
		//$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: true});
	 	$("#jqxAppliedAccounts").jqxGrid({ disabled: true});
	}

	function funRemoveReadOnly(){
	    $('#frmAccountsOpening input').attr('readonly', false );
		$('#frmAccountsOpening select').attr('disabled', false);
		//$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: false});
		$('#txtaccountcurrency').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
	    $('#txtdebittotal').attr('readonly', true );
	    $('#txtcredittotal').attr('readonly', true );
	    $('#txtnettotal').attr('readonly', true );
		$("#jqxAppliedAccounts").jqxGrid({ disabled: false});
		
		 if ($("#mode").val() == "A") {
			 $("#jqxAppliedAccounts").jqxGrid('clear');
			 $("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
		}  
		
	}

	function funSearchLoad(){
	 	 changeContent('opnMainSearch.jsp', $('#window'));  
	}

	function funChkButton(){
		/* funReset(); */
	}

	function funFocus(){
		//$('#jqxAccountOpeningDate').jqxDateTimeInput('focus'); 
		document.getElementById("cmbacctype").focus();
	}

	function funNotify(){	
	  
	   /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 } 
		document.getElementById("errormsg").innerText="";
	  /* Validation Ends*/
			
	/* Accounts Invoice Grid Saving */
   	 var rows = $("#jqxAppliedAccounts").jqxGrid('getrows');
   	 var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].doc_no;
			var chks=rows[i].baseamount;
			if(typeof(chk) == "undefined" && (typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "")){
				document.getElementById("errormsg").innerText="Doc No is Mandatory.";
				return 0;
			}
			document.getElementById("errormsg").innerText="";
			
			if(typeof(chk) != "undefined"){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
				.attr("hidden", "true");
				
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
			
			newTextBox.val(rows[i].doc_no+"::"+rows[i].date+":: "+rows[i].description+":: "+amount+":: "+baseamount+":: "+id+":: "+rows[i].tr_no);
			newTextBox.appendTo('form');
			}
		 }
		 $('#gridlength').val(length);
		/* Accounts Invoice Grid Saving Ends */
			 
			return 1;
	} 


	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel(); 
		
	  var indexVal = document.getElementById("txttrno").value;
	  if(indexVal>0){
      $("#jqxAppliedAccountsGrid").load("accountsInvoiceGrid.jsp?txttrno2="+indexVal); 
		 }
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');$('#txtaccountcurrency').val('');$('#txtaccountcurrencyid').val('');$('#txtrate').val('');
		$('#hidcurrencytype').val('');$('#txtdebittotal').val('');$('#txtcredittotal').val('');$('#txtnettotal').val('');$('#txtbaseamount').val('');$('#txtvalidation').val('');
		$("#jqxAppliedAccounts").jqxGrid('clear'); 
		$("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
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
<form id="frmAccountsOpening" action="saveAccountsOpening" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>	
<table width="100%">
  <tr>
    <td align="right">Account</td>
    <td><select id="cmbacctype" name="cmbacctype" style="width:50%;" onchange="clearAccountInfo();" value='<s:property value="cmbacctype"/>'>
    <option value="BANK">Bank</option><option value="GL">GL</option><option value="AR">AR</option><option value="AP">AP</option><option value="HR">HR</option></select>
    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/></td>
    <td width="14%"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/></td>
    <td colspan="6"><input type="text" id="txtaccname" name="txtaccname" style="width:75%;" tabindex="-1" value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="6%" align="right">Currency</td>
    <td width="9%"><input type="text" id="txtaccountcurrency" name="txtaccountcurrency" readonly="readonly" style="width:60%;" value='<s:property value="txtaccountcurrency"/>' tabindex="-1"/>
    <input type="hidden" id="txtaccountcurrencyid" name="txtaccountcurrencyid" value='<s:property value="txtaccountcurrencyid"/>'/>
    <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/></td>
    <td width="5%" align="right">Rate</td>
    <td width="16%"><input type="text" id="txtrate" name="txtrate" style="width:40%;text-align: right;" value='<s:property value="txtrate"/>'/></td>
  </tr>
</table></fieldset>
<fieldset><legend>Opening Invoice/Cheque/Other Details</legend>
<div id="jqxAppliedAccountsGrid"><jsp:include page="accountsInvoiceGrid.jsp"></jsp:include></div>
</fieldset><br/>
<table width="100%">
  <tr>
    <td width="8%" align="right">Debit Total</td>
    <td width="15%"><input type="text" id="txtdebittotal" name="txtdebittotal" style="width:60%;text-align: right;" value='<s:property value="txtdebittotal"/>' tabindex="-1"/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>
    <td width="10%" align="right">Credit Total</td>
    <td width="19%"><input type="text" id="txtcredittotal" name="txtcredittotal" style="width:50%;text-align: right;" value='<s:property value="txtcredittotal"/>' tabindex="-1"/></td>
    <td width="8%" align="right">Net Total</td>
    <td width="16%"><input type="text" id="txtnettotal" name="txtnettotal" style="width:60%;text-align: right;" value='<s:property value="txtnettotal"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Base Amount</td>
    <td width="14%"><input type="text" id="txtbaseamount" name="txtbaseamount" style="width:70%;text-align: right;" value='<s:property value="txtbaseamount"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
</div>
</form>
	
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>  

<div id="openingBalanceGridWindow">
	<div></div><div></div>
</div> 	
</div>
</body>
</html>