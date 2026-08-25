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
		
		 $("#jqxFuelCardReimbursementDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#fuelCardReimbursementGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#fuelCardReimbursementGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxFuelCardReimbursementDate').on('change', function (event) {
				 var paydate = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(paydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent('accountsDetailsSearch.jsp?date='+date);
			  });
	});
	
	function FuelCardReimbursementSearchContent(url) {
		$('#fuelCardReimbursementGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#fuelCardReimbursementGridWindow').jqxWindow('setContent', data);
		$('#fuelCardReimbursementGridWindow').jqxWindow('bringToFront');
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
	
	function getCurrencyIds(date){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
			 	var curidItems=items[0];
		        var curcodeItems=items[1];
		        var currateItems=items[2];
		        var curtypeItems=items[3];
		        var multiItems=items[4];
		        var optionscurr = '';
		        
		     if(curcodeItems.indexOf(",")>=0){
		    	    var currencyid=curidItems.split(",");
		        	var currencycode=curcodeItems.split(",");
		        	var currencyrate=currateItems.split(",");
		        	var currencytype=curtypeItems.split(",");
		        	multiItems.split(",");
		       
		       for ( var i = 0; i < currencycode.length; i++) {
		    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		      
		         $("select#cmbcurrency").html(optionscurr);
		         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
		       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
		         } 
		         
		         if($('#mode').val()=="A"){
			    	funRoundRate(currencyrate[0],"txtrate");
			        $('#hidcurrencytype').val(currencytype[0]);
				 }
				     
			   }
		
		       else{
		    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		    	   
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         }
			         
			         if($('#mode').val()=="A"){
				    	funRoundRate(currateItems,"txtrate");
			    	    $('#hidcurrencytype').val(curtypeItems);
					 }
			      }
			}
	     }
	      x.open("GET", "getCurrencyId.jsp?date="+date,true);
	     x.send();
	    
	   }
	
	function getRates(a,date){
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var ratesItems  = items[0].split(",");
						var typesItems = items[1].split(",");
							funRoundRate(ratesItems,"txtrate");
							$('#hidcurrencytype').val(typesItems);
							getBaseAmount();
				    }
		     }
		      x.open("GET", "getRate.jsp?currs="+a+"&date="+date,true);
		     x.send();
		    
		   }
	
	function getBaseAmount(){
		 var fromrate = $('#txtrate').val(); 
		 var fromamount = $('#txtamount').val();
		 var currencytype = $('#hidcurrencytype').val().trim();
	   
	    if(!isNaN(fromamount)){
		    if(currencytype=="M"){
		    		var result = parseFloat(fromamount) * parseFloat(fromrate);
				    funRoundAmt(result,"txtbaseamount");
		    }else{
		    		var result = parseFloat(fromamount) / parseFloat(fromrate);
				    funRoundAmt(result,"txtbaseamount");
		    	
		    }
	    }
	    else if(isNaN(fromamount)){
	    	 	 $('#txtbaseamount').val(0.00);
	    	 	 $('#txtamount').val(0.00);
	    }
	}
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
					 $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
					 $('#frmFuelCardReimbursement select').attr('disabled', false);$("#jqxFuelCardReimbursement").jqxGrid({ disabled: false});  
			    }
			   });
	  }
	
	 function funReadOnly(){
			$('#frmFuelCardReimbursement input').attr('readonly', true );
			$('#frmFuelCardReimbursement select').attr('disabled', true);
			$('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: true});
			$("#jqxFuelCardReimbursement").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmFuelCardReimbursement input').attr('readonly', false );
			$('#frmFuelCardReimbursement select').attr('disabled', false);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxFuelCardReimbursement").jqxGrid({ disabled: false});
			
			var date = $('#jqxFuelCardReimbursementDate').val();
		    getCurrencyIds(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmFuelCardReimbursement input').attr('readonly', true );
   			    $('#frmFuelCardReimbursement select').attr('disabled', true);
			    $("#jqxFuelCardReimbursement").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false);
   			    $("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","reg_no": "","amount1": "","baseamount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxFuelCardReimbursementDate').val(new Date());
				$("#jqxFuelCardReimbursement").jqxGrid('clear'); 
				$("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","reg_no": "","amount1": "","baseamount1": "","description": ""});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('fcrMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxFuelCardReimbursementDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmFuelCardReimbursement').validate({
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
		    var paydate = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
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
	    		
	     /* Fuel Card Reimbursement Grid  Saving*/
			 var rows = $("#jqxFuelCardReimbursement").jqxGrid('getrows');
			 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].costcode;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
						.attr("hidden", "true");
						length=length+1;
						
			    newTextBox.val(rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].amount1+"::"+rows[i].baseamount1+"::"+rows[i].description);
				newTextBox.appendTo('form');
				 }
				}
				$('#gridlength').val(length);
	 		   /* Fuel Card Reimbursement Grid  Saving Ends*/	
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxFuelCardReimbursementDate').val();
		  getCurrencyIds(date);
		  $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidjqxFuelCardReimbursementDate').val()){
				 $("#jqxFuelCardReimbursementDate").jqxDateTimeInput('val', $('#hidjqxFuelCardReimbursementDate').val());
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
	         	 $("#fuelCardReimbursementDiv").load("fuelCardReimbursementGrid.jsp?txtfuelcardreimbursementdocno2="+indexVal+'&check='+check);
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
        	  var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent('accountsDetailsSearch.jsp?date='+date);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveFuelCardReimbursement");
		        $("#docno").prop("disabled", false); 
		        
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printFuelCardReimbursement?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printFuelCardReimbursement?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
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
<form id="frmFuelCardReimbursement" action="saveFuelCardReimbursement" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxFuelCardReimbursementDate" name="jqxFuelCardReimbursementDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxFuelCardReimbursementDate"/>'></div>
    <input type="hidden" id="hidjqxFuelCardReimbursementDate" name="hidjqxFuelCardReimbursementDate" value='<s:property value="hidjqxFuelCardReimbursementDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtfuelcardreimbursementdocno" style="width:50%;" value='<s:property value="txtfuelcardreimbursementdocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Card</td>
    <td width="16%"><input type="text" id="txtaccid" name="txtaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtaccname" name="txtaccname" style="width:85%;" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="7%" align="right">Currency</td>
    <td width="18%"><select id="cmbcurrency" name="cmbcurrency" style="width:40%;" value='<s:property value="cmbcurrency"/>' onload="getRates(this.value,$('#jqxFuelCardReimbursementDate').val());" onchange="getRates(this.value,$('#jqxFuelCardReimbursementDate').val());">
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
<div id="fuelCardReimbursementDiv"><jsp:include page="fuelCardReimbursementGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
</div>
</form>
	
<div id="fuelCardReimbursementGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
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
