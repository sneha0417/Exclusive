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
		/*  $("#btnPrint").attr('disabled', true ); */
		 $("#jqxmcpdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
		 $('#productSearchwindow').jqxWindow('close');
		    
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#McpGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#McpGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#vendorinfowindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vendorinfowindow').jqxWindow('close');
		 
		 $('#jqxmcpdate').on('change', function (event) {
				var paydate = $('#jqxmcpdate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
	     });
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
		});
		 
	});
	
	function VendorSearchContent(url) {
		$('#vendorinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vendorinfowindow').jqxWindow('setContent', data);
		$('#vendorinfowindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function McpSearchContent(url) {
		$('#McpGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#McpGridWindow').jqxWindow('setContent', data);
		$('#McpGridWindow').jqxWindow('bringToFront');
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
	

	
	 function funReadOnly(){
			$('#frmMultipleCashPurchase input').attr('readonly', true );
			$('#frmMultipleCashPurchase select').attr('disabled', true);
			$('#jqxmcpdate').jqxDateTimeInput({disabled: true});
			$("#jqxMultipleCashPurchase").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
			
	 }
	 
	 function funRemoveReadOnly(){
		 document.getElementById("errormsg").innerText="";
		    $('#txtforsearch').val(2);
			$('#frmMultipleCashPurchase input').attr('readonly', false );
			$('#frmMultipleCashPurchase select').attr('disabled', false);
			 
			$("#btnpost").hide();
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#txtbaseamount').attr('readonly', true );
			$('#jqxmcpdate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxMultipleCashPurchase").jqxGrid({ disabled: false});
			
			var date = $('#jqxmcpdate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmMultipleCashPurchase input').attr('readonly', true );
   			    $('#frmMultipleCashPurchase select').attr('disabled', false);
			    $("#jqxMultipleCashPurchase").jqxGrid({ disabled: false});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false);
   			    $("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxmcpdate').val(new Date());
				$("#jqxMultipleCashPurchase").jqxGrid('clear'); 
				$("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('mcpMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxmcpdate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmMultipleCashPurchase').validate({
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
			docno=document.getElementById("txtdocno").value;
		  if(docno==""){
				document.getElementById("errormsg").innerText="Select cash account.";
				return 0;	
			}
		  var summ= $("#jqxMultipleCashPurchase").jqxGrid('getcolumnaggregateddata', 'amount1', ['sum'],true);
	   		 var sum1=summ.sum.replace(/,/g,'');
		  if(sum1==0){
			   document.getElementById("errormsg").innerText="Enter amount value.";
				return 0;
		  }
		  /* Validation */
		    var paydate = $('#jqxmcpdate').jqxDateTimeInput('getDate');
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
	    		
	     /* Multiple Cash Purchase Grid  Saving*/
			 var rows = $("#jqxMultipleCashPurchase").jqxGrid('getrows');
			 //var rowno = rows[i].rowno;
			 
			 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					//var rowno = rows[i].rowno;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
						.attr("hidden", "true");
						length=length+1;
						
			    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].baseamount1+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].vendorid+"::"+rows[i].tinno+"::"+rows[i].invno+"::"+rows[i].hidinvdate+"::"+rows[i].taxamt+"::"+rows[i].total+"::"+rows[i].rowno+"::"+rows[i].srvtaxper+"::"+rows[i].psrno+"::"+rows[i].qty+"::"+rows[i].unitprice);
				// alert(newTextBox.val());   
				  
				newTextBox.appendTo('form');
				 }
				}
				$('#gridlength').val(length);
	 		   /* Multiple Cash Purchase Grid Saving Ends*/	
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxmcpdate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxmcpdate').val();
		  getCurrencyId(date);
		  $('#jqxmcpdate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidjqxmcpdate').val()){
				 $("#jqxmcpdate").jqxDateTimeInput('val', $('#hidjqxmcpdate').val());
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
	             $("#divMCPGrid").load("multipleCashPurchaseGrid.jsp?txtpettycashdocno2="+indexVal+"&check="+check);
			 }
			 if(document.getElementById("docno").value!=""){
				 getPostingdetails(); 
			 }
		}
		
	  function getPostingdetails(){
	  var mode=$("#mode").val();
	  var docno=document.getElementById("docno").value;
	 // alert(docno);
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)>0){
	  					$("#posted").val(parseInt(items));
	  					document.getElementById("errormsg").innerText="Account Is Not Posted Please Post The Account .";
	  					 return 0;
	  				 }
	  				else{
	  					document.getElementById("errormsg").innerText="Document Already Posted.";
	  					$("#btnEdit").attr('disabled', true );
	  					$("#btnDelete").attr('disabled', true );
	  					$("#btnpost").attr('disabled', true );
	  					
	  					//alert("edit disable ");
	  					//$("#btnEdit").hide();
	  				}
	  		}
		}
		x.open("GET", "getPostingDetails.jsp?docno="+docno+"&mode="+mode, true);
		x.send();
    }
	  
	  
	  function funPost(){
	  
		 
		  $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
				if (r){
					 var mode=$("#mode").val();
					  var docno=document.getElementById("docno").value;
					  var vendorid=document.getElementById("vendorid").value;
					  //alert(vendorid);
					  var vendor=document.getElementById("vendor").value;
					   //alert(vendor);
					  var trno=document.getElementById("txttrno").value;
					  //alert(trno);
					 
					  var x = new XMLHttpRequest();
					  		x.onreadystatechange = function() {
					  			if (x.readyState == 4 && x.status == 200) {
					  				var items = x.responseText.trim();
				
					  				if(parseInt(items)>1){
					  					 $.messager.alert('Message','Account is Posted.','warning');
					  					document.getElementById("errormsg").innerText="Document Already Posted.";
					  					 $("#btnpost").attr('disabled', true );
					  					$("#btnEdit").attr('disabled', true );
					  					 return 0;
					  				 }else{
					  				 
					  				  $.messager.alert('Message','Account not Posted.','warning');
					  				 }
					  		}
						}
						x.open("GET", "getPostingDone.jsp?docno="+docno+"&mode="+mode+"&vendorid="+vendorid+"&vendor="+vendor+"&trno="+trno, true);
						x.send();
				} 
		  });
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
	  
	 
	  
	   function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
		        return false;
		    return true;
		}
		
	  
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveMultipleCashPurchase");
		        $("#docno").prop("disabled", false); 
		       
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printMultipleCashPurchase?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();

/* var win= window.open(reurl[0]+"PettyCashPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus(); */
					 }
					else{
						var win= window.open(reurl[0]+"printMultipleCashPurchase?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();

/* var win= window.open(reurl[0]+"PettyCashPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus(); */
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	
	  function funwarningopen(){
			 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
				    if (r){
				    	$("#mode").val("EDIT");
						 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
						 $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
						 $('#frmMultipleCashPurchase select').attr('disabled', false);$("#jqxPettyCash").jqxGrid({ disabled: false});  
				    }
				   });
		  }
	  function getproductdetails(event){
		 	// var x= event.keyCode;
		 	 
		 	if($('#mode').val()!= "view")
  		{
			 	 
			 	  $('#productSearchwindow').jqxWindow('open');
			 
			 
			 	 productSearchContent('productSearchGrid.jsp');  
			 	 
  		  } 
		 	 }
	  function productSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#productSearchwindow').jqxWindow('setContent', data);
	
		}); 
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
<form id="frmMultipleCashPurchase" action="saveMultipleCashPurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxmcpdate" name="jqxmcpdate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxmcpdate"/>'></div>
    <input type="hidden" id="hidjqxmcpdate" name="hidjqxmcpdate" value='<s:property value="hidjqxmcpdate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" onkeypress="return isNumberKey(event)" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtpettycashdocno" style="width:50%;" value='<s:property value="txtpettycashdocno"/>' tabindex="-1"/>
    <td width="11%" align="right"><button id="btnpost" class="myButton" type="button" onclick="funPost()">Post</button></td>
    <!-- <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td> -->
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
    <td width="18%"><select id="cmbcurrency" name="cmbcurrency" style="width:40%;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxmcpdate').val());" onchange="getRatevalue(this.value,$('#jqxmcpdate').val());">
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

<%-- <fieldset id="psearch">
<legend>Item Details</legend>
   <table width="100% "  >   
   <tr> 
	   <td align="center">Product ID</td>
	   <td align="center" colspan="2">Product Name</td>
	   <td align="center" style="width:15%;"  >Brand</td>
	   <td align="center">Unit</td>
	   <td  width="6%" align="center">Qty</td>
	   <td align="center" class="ff" >FOC</td>
	   <td align="center" class="ff" > Extra FOC</td> 
	   <td align="center"> Unit price</td>
	   <td align="center"> &nbsp;</td>
   </tr>
   <tr>
	   <td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
	   <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
	   <td align="center" ><input type="text" id="brand" ><input type="hidden" id="collqty" ></td>
	   <td align="center"> <select    id="unit"   >   </select>      </td>  
	   <td width="6%" align="center"> <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">    <input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
	   <td align="center" class="ff">   <input type="text" id="focs"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"     ></td>
	   <td  align="center"class="ff"> <input type="text" id="extrafocs"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"     ></td>
	   <td align="center">   <input type="text" id="uprice"    onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);" style="text-align: right;"></td>
	   <td align="center"> &nbsp;</td>
  </tr>
  <tr>
	<td align="center">Total</td> 
	<td align="center">Discount% </td>
	<td align="center">Discount</td> 
	<td align="center">Net Amount</td>  
	<td align="center">Tax%</td>  
	<td align="center">Tax Amount</td>  
	<td    align="center">Net Total</td>   
    <td align="center" class="ff">Multi_Batch</td> 
    <td align="center" class="ff">Batch</td>
    <td align="center" class="ff">ExpDate</td>   
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
  </tr>
  <tr>
	<td align="center"><input type="text" id="totamt" tabindex="-1"      style="text-align: right;"   ></td>
	<td align="center"><input type="text" id="dispers"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);"  style="text-align: right;"  ></td>
	<td align="center"><input type="text" id="dict"    onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"    onchange="calculatedata(this.id);"  style="text-align: right;"  ></td>
  	<td align="center"><input type="text" id="amounts" tabindex="-1"    style="text-align: right;" ></td> 
	<td align="center"><input type="text" id="taxpers"  tabindex="-1"       style="text-align: right;"  onchange="calculatedata(this.id);" ></td>  
	<td align="center"><input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
	<td align="center"><input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>  
	<td align="center" class="ff"><input type="checkbox" id="multi"style="text-align: right;" onchange="chkmultis()" > </td>
	<td align="center" class="ff"><input type="text" id="batch"    onkeydown="getbatch(event)" > </td>
	<td  class="ff"><div id="expdate" name="expdate" value='<s:property value="expdate"/>'></div> </td> 
	<td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 </tr>
 </table> 
</fieldset>  --%>
<div id="divMCPGrid"><jsp:include page="multipleCashPurchaseGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
<input type="hidden" id="vendorid" name="vendorid" value='<s:property value="vendorid"/>'/>
<input type="hidden" id="vendor" name="vendor" value='<s:property value="vendor"/>'/>
<input type="hidden" id="txtvndortotal" name="txtvndortotal" value='<s:property value="txtvndortotal"/>'/>
<input type="hidden" id="taxchk" name="taxchk" value='<s:property value="taxchk"/>'/>
<input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'/>
<input type="hidden" id="posted" name="posted" value='<s:property value="posted"/>'/>   
<input type="hidden" id="prdsetrowno" name="prdsetrowno" value='<s:property value="prdsetrowno"/>'/>
</div>
</form>  
<div id="productSearchwindow">
	   <div></div>
	</div>	
<div id="McpGridWindow">
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

<div id="vendorinfowindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>
