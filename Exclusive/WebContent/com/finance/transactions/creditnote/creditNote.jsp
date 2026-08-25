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
		 $("#jqxCreditNoteDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#creditNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#creditNoteGridWindow').jqxWindow('close'); 
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCreditNoteDate').on('change', function (event) {
				var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(creditdate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				} 
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			  $('#txtforsearch').val(2);
	    });  	 
		
	});
	
	function CreditSearchContent(url) {
		$('#creditNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#creditNoteGridWindow').jqxWindow('setContent', data);
		$('#creditNoteGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
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
				 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmCreditNote select').attr('disabled', false);$("#jqxCreditNote").jqxGrid({ disabled: false});  
		    }
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmCreditNote input').attr('readonly', true );
			$('#frmCreditNote select').attr('disabled', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxCreditNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmCreditNote input').attr('readonly', false );
			$('#frmCreditNote select').attr('disabled', false);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
		    $('#txtbaseamount').attr('readonly', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxCreditNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxCreditNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
      	    $("#btnvaluechange").show();
      	    $('#frmCreditNote input').attr('readonly', true );
			    $('#frmCreditNote select').attr('disabled', true);
			    $("#jqxCreditNote").jqxGrid({ disabled: true});
			    $("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			    $('#txtdescription').attr('readonly', false );
			    $('#txtrefno').attr('readonly', false );
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCreditNoteDate').val(new Date());
				$("#jqxCreditNote").jqxGrid('clear'); 
				$("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} 
	       }
	 
			function funSearchLoad(){
				changeContent('cnoMainSearch.jsp'); 
			 }
				
			 function funChkButton(){
					/* funReset(); */
				}
			 
			 function funFocus(){
			    	$('#jqxCreditNoteDate').jqxDateTimeInput('focus'); 	    		
			    }
			 
			   $(function(){
			        $('#frmCreditNote').validate({
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
				    var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
					var validdate=funDateInPeriod(creditdate);
					if(parseInt(validdate)==0){
						document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
						return 0;	
					} 
					 
					acctype=document.getElementById("cmbtype").value;
					if(acctype==""){
						document.getElementById("errormsg").innerText="Account Type is Mandatory.";
						return 0;
					}
					 
					accid=document.getElementById("txtdocno").value;
					if(accid==""){
						document.getElementById("errormsg").innerText="Account is Mandatory.";
						return 0;
					}
					 
					currencyto=document.getElementById("cmbcurrency").value;
					currencyrate=document.getElementById("txtrate").value;
					if(currencyto=="" || currencyrate==""){
						document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
						return 0;
					}
					 
				    var drtot = parseFloat(document.getElementById("txtdrtotal").value);
			 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);
			 		
			 		if(drtot>crtot || drtot<crtot){
			 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
		              return 0;
			 		}
			 		
			 		if(drtot=="" || crtot=="" ){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
			              return 0;
				 		}

			 		if(isNaN(drtot) || isNaN(crtot)){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
			              return 0;
				 		}
			 		
			 		if(drtot==0 || crtot==0){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		
			 		if(drtot==0.0 || crtot==0.0){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		
			 		if(drtot==0.00 || crtot==0.00){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		
			 		document.getElementById("errormsg").innerText="";
			    		
			    /* Validation Ends*/
			    		
			     /* Credit-Note Grid  Saving*/
				  var rows = $("#jqxCreditNote").jqxGrid('getrows');
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
							
						newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
						newTextBox.appendTo('form');
						}
						}
					    $('#gridlength').val(length);
			 		   /* Credit-Note Grid  Saving Ends*/
			 		   
			 		   if ($("#mode").val() == "E") {
			             $('#frmCreditNote select').attr('disabled', false); 
			           }
			 		   
				  return 1;
			  }
			  
			  function setValues(){
				  $('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
				  var date = $('#jqxCreditNoteDate').val();
				  getCurrencyId(date);
				  $('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
				  
				  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
				  document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
				  
				  if($('#hidjqxCreditNoteDate').val()){
						 $("#jqxCreditNoteDate").jqxDateTimeInput('val', $('#hidjqxCreditNoteDate').val());
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
			             $("#jqxCreditNoteGrid").load("creditNoteGrid.jsp?txtcreditnotedocno2="+indexVal+"&check="+check);
					 }
				}

			    function getCrTotal(){
			    	  var fromamount = $('#txtbaseamount').val();
			 		  if(!isNaN(fromamount)){
			 			  
			 			    var dr=0.0,cr=0.0,cr1=0.0;
			         	    var rows = $('#jqxCreditNote').jqxGrid('getrows');
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
			 			  $('#txtamount').val(0.00);
				 		  $('#txtcrtotal').val(0.00);
				 		  $('#txtdrtotal').val(0.00);
			 		  }
			 	  } 
			       
			       function getAccType(event){
			           var x= event.keyCode;
			           if(x==114){
			        	  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			 			  $("#maindate").jqxDateTimeInput('val', date);
			 			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			         	  $('#txtforsearch').val(2);
			           }
			           else{
			            }
			           }
			       
			       function funPrintBtn() {
						
						if (($("#mode").val() == "view") && $("#docno").val()!="") {
					        var url=document.URL;
					        var reurl=url.split("saveCreditNote");
					        $("#docno").prop("disabled", false);  
					     
					        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
								if (r){
									 var win= window.open(reurl[0]+"printCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
								     win.focus();
								 }
								else{
									var win= window.open(reurl[0]+"printCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
			 		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
			 	  }
			       
			       function datechange(){
			 		  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
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
<form id="frmCreditNote" action="saveCreditNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="7%" height="42" align="right">Date</td>
    <td colspan="2"><div id="jqxCreditNoteDate" name="jqxCreditNoteDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCreditNoteDate"/>'></div>
    <input type="hidden" id="hidjqxCreditNoteDate" name="hidjqxCreditNoteDate" value='<s:property value="hidjqxCreditNoteDate"/>'/></td>
    <td width="8%" align="right">Ref. No.</td>
    <td width="25%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
    <td width="22%" align="right">Doc No.</td>
    <td width="18%"><input type="text" id="docno" name="txtcreditnotedocno" style="width:50%;" value='<s:property value="txtcreditnotedocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td width="7%" align="right">Type</td>
    <td width="6%"><select id="cmbtype" name="cmbtype" style="width:100%;" onchange="clearClientInfo();" value='<s:property value="cmbtype"/>'>
    <option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td width="14%" align="center"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td>
    <td colspan="4"><input type="text" id="txtaccname" name="txtaccname" style="width:40%;" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td colspan="2"><select id="cmbcurrency" name="cmbcurrency" style="width:30%;" value='<s:property value="cmbcurrency"/>'  onload="getRatevalue(this.value,$('#jqxCreditNoteDate').val());" onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
      <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/></td>
    <td width="8%" align="right">Rate</td>
    <td colspan="3"><input type="text" id="txtrate" name="txtrate" style="width:15%;text-align: right;" value='<s:property value="txtrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1" /></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td colspan="2"><input type="text" id="txtamount" name="txtamount" style="width:35%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" /></td>
    <td align="right">Base Amount</td>
    <td colspan="3"><input type="text" id="txtbaseamount" name="txtbaseamount" style="width:15%;text-align: right;" value='<s:property value="txtbaseamount"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="6"><input type="text" id="txtdescription" name="txtdescription" style="width:53%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
  </table><br/>
<div id="jqxCreditNoteGrid"><jsp:include page="creditNoteGrid.jsp"></jsp:include></div><br/>
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
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
<div id="creditNoteGridWindow">
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