<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>

<script type="text/javascript">
      
		$(document).ready(function() {
			$("#jqxChqPrintSetUpDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
			
			$('#bankDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
			$('#bankDetailsWindow').jqxWindow('close');
			
			$('#txtbankid').dblclick(function(){
				  bankSearchContent('bankDetails.jsp');
		    });
		});
		
		function bankSearchContent(url) {
			$('#bankDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#bankDetailsWindow').jqxWindow('setContent', data);
			$('#bankDetailsWindow').jqxWindow('bringToFront');
		}); 
		} 
		
		function isNumber(evt) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	          $.messager.alert('Message',' Enter Numbers Only ','warning');    
	            return false;
	         }
	        return true;
	    }
		
		function getBankDetails(event){
	          var x= event.keyCode;
	          if(x==114){
	        	  bankSearchContent('bankDetails.jsp');
	          }
	          else{
	           }
	          }
		
		function funReadOnly(){
			$('#frmChequePrintingSetUp input').attr('readonly', true );
			$('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmChequePrintingSetUp input').attr('readonly', false );
			$('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: false});
			$('#txtbankid').attr('readonly', true);
			$('#txtbankname').attr('readonly', true);
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxChqPrintSetUpDate').val(new Date());
			}
		}
		
		function funSearchLoad(){
			  changeContent('cpsMainSearch.jsp');   
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			$('#jqxChqPrintSetUpDate').jqxDateTimeInput('focus'); 	    		
		}
		
		function funNotify(){	
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			}
		  
		  function funPrintBtn(){
		    	if (($("#mode").val() == "view") && $("#docno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("saveChequePrintingSetUp");
			        $("#docno").prop("disabled", false);                
			     
			        var win= window.open(reurl[0]+"printChequeVoucher?docno="+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
		    }
		
  </script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmChequePrintingSetUp" action="saveChequePrintingSetUp" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="66%"><div id='jqxChqPrintSetUpDate' name='jqxChqPrintSetUpDate' value='<s:property value="jqxChqPrintSetUpDate"/>'></div>
                   <input type="hidden" id="hidjqxChqPrintSetUpDate" name="hidjqxChqPrintSetUpDate" value='<s:property value="hidjqxChqPrintSetUpDate"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="txtchqsetupdocno" style="width:40%;" value='<s:property value="txtchqsetupdocno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset><legend>Bank Details</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Bank Account</td>
    <td width="24%"><input type="text" id="txtbankid" name="txtbankid" style="width:40%;" placeholder="Press F3 to Search" onkeydown="getBankDetails(event);" value='<s:property value="txtbankid"/>'/>
    <input type="hidden" id="txtbankdocno" name="txtbankdocno" style="width:50%;" value='<s:property value="txtbankdocno"/>'/></td>
    <td width="9%" align="right">Bank Name</td>
    <td width="61%"><input type="text" id="txtbankname" name="txtbankname" style="width:50%;" value='<s:property value="txtbankname"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset><legend>Cheque Details</legend>
<table width="100%">
  <tr>
    <td width="7%">&nbsp;</td>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;Height&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Width</td>
  </tr>
  <tr>
    <td align="right">Page Size</td>
    <td width="38%"><input type="text" id="txtpageheight" name="txtpageheight" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtpageheight"/>'/>&nbsp;&nbsp;
    <input type="text" id="txtpagewidth" name="txtpagewidth" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtpagewidth"/>'/></td>
    <td width="10%" align="right">Date</td>
    <td width="45%"><input type="text" id="txtdate" name="txtdate" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdate"/>'/>&nbsp;&nbsp;
    <input type="text" id="txtdate1" name="txtdate1" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdate1"/>'/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Len</td>
  </tr>
  <tr>
    <td align="right">Pay To</td>
    <td><input type="text" id="txtvertical" name="txtvertical" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtvertical"/>'/>&nbsp;&nbsp;
 <input type="text" id="txthorizontal" name="txthorizontal" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txthorizontal"/>'/>&nbsp;&nbsp;
  <input type="text" id="txtlength" name="txtlength" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtlength"/>'/></td>
   <td align="right">Account Payee</td>
    <td><input type="text" id="txtaccountpaying" name="txtaccountpaying" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccountpaying"/>'/>&nbsp;&nbsp;
    <input type="text" id="txtaccountpaying1" name="txtaccountpaying1" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccountpaying1"/>'/></td>
  </tr>
</table><br/><br/>

<table width="100%">
  <tr>
    <td width="7%" align="right">Amt Words</td>
    <td width="43%"><input type="text" id="txtamtvertical" name="txtamtvertical" style="width:8.3%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamtvertical"/>'/>&nbsp;&nbsp;&nbsp;
    <input type="text" id="txtamthorizontal" name="txtamthorizontal" style="width:8.3%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamthorizontal"/>'/>&nbsp;&nbsp;&nbsp;
    <input type="text" id="txtamtlength" name="txtamtlength" style="width:8.3%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamtlength"/>'/></td>
    <td width="4%" align="right">Amount</td>
    <td width="46%"><input type="text" id="txtamount" name="txtamount" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamount"/>'/>&nbsp;&nbsp;
    <input type="text" id="txtamount1" name="txtamount1" style="width:10%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamount1"/>'/></td>
  </tr>
  <tr>
    <td align="right">Amt Words</td>
    <td colspan="3"><input type="text" id="txtamt1vertical" name="txtamt1vertical" style="width:4%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1vertical"/>'/>&nbsp;&nbsp;
 <input type="text" id="txtamt1horizontal" name="txtamt1horizontal" style="width:4%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1horizontal"/>'/>&nbsp;&nbsp;
  <input type="text" id="txtamt1length" name="txtamt1length" style="width:4%;text-align: right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1length"/>'/></td></tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>

<div id="bankDetailsWindow">
	<div></div><div></div>
</div>  
</div>
</body>
</html>