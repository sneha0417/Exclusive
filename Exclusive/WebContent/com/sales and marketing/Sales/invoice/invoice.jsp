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
		$('#btnvaluechange').hide();
		 $("#invoiceDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#payDueDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Customers Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 
		 $('#salesPersonDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Sales-Persons Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#salesPersonDetailsWindow').jqxWindow('close'); 
		 
		 $('#locationDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Locations Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#locationDetailsWindow').jqxWindow('close'); 
		 
	});
	
	function CustomerSearchContent(url) {
		$('#customerDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#customerDetailsWindow').jqxWindow('setContent', data);
		$('#customerDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function SalesPersonSearchContent(url) {
		$('#salesPersonDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesPersonDetailsWindow').jqxWindow('setContent', data);
		$('#salesPersonDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function LocationSearchContent(url) {
		$('#locationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#locationDetailsWindow').jqxWindow('setContent', data);
		$('#locationDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmInvoice input').attr('readonly', true );
			$('#frmInvoice select').attr('disabled', true);
			$('#invoiceDate').jqxDateTimeInput({disabled: true});
			$('#payDueDate').jqxDateTimeInput({disabled: true});
			$("#jqxInvoice").jqxGrid({ disabled: true});
			
			$('#btnvaluechange').hide();
			$('#chkdiscount').attr('disabled', true);	 
			 $('#btnCalculate').attr('disabled', true);
			  $('#rrefno').attr('disabled', true);
	 }
	 
	 function funRemoveReadOnly(){
		 
		 document.getElementById("editdata").value="";
		 $('#rrefno').attr('disabled', true);
			$('#frmInvoice input').attr('readonly', false );
			$('#frmInvoice select').attr('disabled', false);
			$('#invoiceDate').jqxDateTimeInput({disabled: false});
			$('#payDueDate').jqxDateTimeInput({disabled: false});
			$("#jqxInvoice").jqxGrid({ disabled: false});
			
			$('#txtcustomerid').attr('readonly', true );
			$('#txtcustomername').attr('readonly', true );
			
			if ($("#mode").val() == "A") {
				$('#invoiceDate').val(new Date());
				$('#payDueDate').val(new Date());
				$("#jqxInvoice").jqxGrid('clear');
				$("#jqxInvoice").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		/* changeContent('cpvMainSearch.jsp'); */ 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#invoiceDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmInvoice').validate({
	                rules: {
	                txtcustomerid:"required",
	                txtdescription:{maxlength:200}
	                 },
	                 messages: {
	                 txtcustomerid:" *",
	                 txtdescription: {maxlength:"    Max 200 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
				 
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidinvoiceDate').val()){
				 $("#invoiceDate").jqxDateTimeInput('val', $('#hidinvoiceDate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveInvoice");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 /* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus(); */
						 }
						else{
							/* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus(); */
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
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
<form id="frmInvoice" action="saveInvoice" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="7%" height="42" align="right">Date</td>
    <td width="33%"><div id="invoiceDate" name="invoiceDate" value='<s:property value="invoiceDate"/>'></div>
    <input type="hidden" id="hidinvoiceDate" name="hidinvoiceDate" value='<s:property value="hidinvoiceDate"/>'/></td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="17%"><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="9%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="txtinvoicedocno" style="width:50%;" value='<s:property value="txtinvoicedocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Sales Person</td>
  <td><input type="text" id="txtsalespersonname" name="txtsalespersonname" style="width:71%;" placeholder="Press F3 to Search" value='<s:property value="txtsalespersonname"/>' onkeydown="getSalesPerson(event);"/>
      <input type="hidden" id="txtsalespersonid" name="txtsalespersonid" value='<s:property value="txtsalespersonid"/>'/></td>
  <td align="right">Mode of Pay</td>
  <td><select id="cmbmodeofpay" name="cmbmodeofpay" style="width:51%;" value='<s:property value="cmbmodeofpay"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/></td>
  <td align="right">Location</td>
  <td><input type="text" id="txtlocation" name="txtlocation" style="width:50%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Customer</td>
    <td width="14%"><input type="text" id="txtcustomerid" name="txtcustomerid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtcustomerid"/>' onkeydown="getCustomer(event);"/></td>
    <td colspan="3"><input type="text" id="txtcustomername" name="txtcustomername" style="width:48%;" value='<s:property value="txtcustomername"/>' tabindex="-1"/>
    <input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno" value='<s:property value="txtcustomerdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td><select id="cmbcurrency" name="cmbcurrency" style="width:71%;" value='<s:property value="cmbcurrency"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td colspan="3"><input type="text" id="txtcurrency" name="txtcurrency" style="width:11%;" value='<s:property value="txtcurrency"/>'/></td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" value='<s:property value="cmbreftype"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <td width="14%"><input type="text" id="txtreftype" name="txtreftype" style="width:100%;" value='<s:property value="txtreftype"/>'/></td>
    <td width="12%" align="right">Price</td>
    <td width="53%"><select id="cmbprice" name="cmbprice" style="width:23%;" value='<s:property value="cmbprice"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Due on</td>
    <td><div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
    <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/></td>
    <td align="right">Del. Terms</td>
    <td colspan="2"><input type="text" id="txtdelterms" name="txtdelterms" style="width:74%;" value='<s:property value="txtdelterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="4"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:82%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:82%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<div id="invoiceDiv"><center><jsp:include page="invoiceGrid.jsp"></jsp:include></center></div>

<fieldset>
<legend>Summary</legend>  
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" id="txtproducttotal" name="txtproducttotal" readonly="readonly" style="width:50%;text-align: right;" value='<s:property value="txtproducttotal"/>'></td>
<td align="right">Discount</td><td><input type="checkbox"  id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" value="0"></td>
<td align="right">Discount %</td><td><input type="text" id="txtdescpercentage" name="txtdescpercentage" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;" value='<s:property value="txtdescpercentage"/>'></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" id="txtdescountval" name="txtdescountval" onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;" value='<s:property value="txtdescountval"/>'></td>
<td align="right">Round of</td><td><input type="text" id="txtroundof" name="txtroundof" onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;" value='<s:property value="roundOf"/>'></td>
<td align="right">Net Total</td><td><input type="text" id="txtnettotaldown" name="txtnettotaldown" readonly="readonly" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;" value='<s:property value="txtnettotaldown"/>'></td>
 
</tr>


</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
<div id="customerDetailsWindow">
	<div></div>
</div>  

<div id="salesPersonDetailsWindow">
	<div></div>
</div> 

<div id="locationDetailsWindow">
	<div></div>
</div>
	
</div>
</body>
</html>
