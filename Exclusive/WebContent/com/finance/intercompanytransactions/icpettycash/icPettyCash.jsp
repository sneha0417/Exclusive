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
		
		 $("#icPettyCashDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#branchSearchWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '35%' , title: 'Inter Company / Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $('#icPettyCashGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#icPettyCashGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#icPettyCashDate').on('change', function (event) {
				var paydate = $('#icPettyCashDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
	     });
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#icPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
		});
		 
	});
	
	function icPettyCashSearchContent(url) {
		$('#icPettyCashGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#icPettyCashGridWindow').jqxWindow('setContent', data);
		$('#icPettyCashGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
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
					 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
					 $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
					 $('#frmIcPettyCash select').attr('disabled', false);$("#icPettyCashGridID").jqxGrid({ disabled: false});  
			    }
			   });
	  }
	
	 function funReadOnly(){
			$('#frmIcPettyCash input').attr('readonly', true );
			$('#frmIcPettyCash select').attr('disabled', true);
			$('#icPettyCashDate').jqxDateTimeInput({disabled: true});
			$("#icPettyCashGridID").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmIcPettyCash input').attr('readonly', false );
			$('#frmIcPettyCash select').attr('disabled', false);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#txtbaseamount').attr('readonly', true );
			$('#icPettyCashDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#icPettyCashGridID").jqxGrid({ disabled: false});
			
			var date = $('#icPettyCashDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIcPettyCash input').attr('readonly', true );
   			    $('#frmIcPettyCash select').attr('disabled', true);
			    $("#icPettyCashGridID").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false);
   			    $("#icPettyCashGridID").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#icPettyCashDate').val(new Date());
				$("#icPettyCashGridID").jqxGrid('clear'); 
				$("#icPettyCashGridID").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('icpcMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#icPettyCashDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmIcPettyCash').validate({
	                rules: {
	                txtaccid:"required",
	                txtamount:{"required":true,number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtaccid:" *",
	                 txtamount:{required:" *",number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  
		  /* Validation */
		    var paydate = $('#icPettyCashDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			currency=document.getElementById("cmbcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
		  
		   	document.getElementById("errormsg").innerText=""; 
	    		
	    /* Validation Ends*/
	    		
	     /* Petty Cash Grid  Saving*/
			 var rows = $("#icPettyCashGridID").jqxGrid('getrows');
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
						
			    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].baseamount1+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].dbname+":: "+rows[i].intrbrhid+":: "+rows[i].intrcompid);
				newTextBox.appendTo('form');
				 }
				}
				$('#gridlength').val(length);
	 		   /* Petty Cash Grid  Saving Ends*/	
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#icPettyCashDate').jqxDateTimeInput({disabled: false});
		  var date = $('#icPettyCashDate').val();
		  getCurrencyId(date);
		  $('#icPettyCashDate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidicPettyCashDate').val()){
				 $("#icPettyCashDate").jqxDateTimeInput('val', $('#hidicPettyCashDate').val());
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
	             $("#icPettyCashGridDiv").load("icPettyCashGrid.jsp?txticpettycashdocno2="+indexVal+"&check="+check);
			 }
		}
	  
	  function getDrTotal(){
		  var amount = $('#txtbaseamount').val();
		  if(!isNaN(amount)){
			  $('#txtdrtotal').val(amount);
		  }
		  else if(isNaN(amount)){
		  	$('#txtdrtotal').val(0.00);
		  	$('#txtamount').val(0.00);
		  }
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#icPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveIcPettyCash");
		        $("#docno").prop("disabled", false); 
		       
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIcPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIcPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  var date = $('#icPettyCashDate').jqxDateTimeInput('getDate');
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
<form id="frmIcPettyCash" action="saveIcPettyCash" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="icPettyCashDate" name="icPettyCashDate" onchange="datechange();" onblur="datechange();" value='<s:property value="icPettyCashDate"/>'></div>
    <input type="hidden" id="hidicPettyCashDate" name="hidicPettyCashDate" value='<s:property value="hidicPettyCashDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txticpettycashdocno" style="width:50%;" value='<s:property value="txticpettycashdocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Cash</td>
    <td width="16%"><input type="text" id="txtaccid" name="txtaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtaccname" name="txtaccname" style="width:85%;" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="7%" align="right">Currency</td>
    <td width="18%"><select id="cmbcurrency" name="cmbcurrency" style="width:40%;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#icPettyCashDate').val());" onchange="getRatevalue(this.value,$('#icPettyCashDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
      <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/></td>
    <td width="4%" align="right">Rate</td>
    <td width="20%"><input type="text" id="txtrate" name="txtrate" style="width:32%;text-align: right;" value='<s:property value="txtrate"/>' onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtamount" name="txtamount" style="width:70%;text-align: right;" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/></td>
    <td width="15%" align="right">Base Amount</td>
    <td width="14%"><input type="text" id="txtbaseamount" name="txtbaseamount" style="width:70%;text-align: right;" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1" tabindex="-1"/></td>
    <td align="right">Description</td>
     <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:68%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset><br/>
<div id="icPettyCashGridDiv"><jsp:include page="icPettyCashGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
</div>
</form>
	
<div id="icPettyCashGridWindow">
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
