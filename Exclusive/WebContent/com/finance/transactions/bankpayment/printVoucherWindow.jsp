 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
$(document).ready(function() {
	$('#btnpaymentauthform').hide();
	checkConfig();
});
function checkConfig(){
	//alert("in chk confg");
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
			      //alert(items);
				if(parseInt(items)==1){
					$('#btnpaymentauthform').show();
				 }
			 
			
		}
}
x.open("GET", <%=contextPath+"/"%>+"com/finance/transactions/bankpayment/checkConfig.jsp", true);
x.send();
}
 	function printHeaderVoucher() {

        var url=document.URL;
        var reurl=url.split("saveBankPayment");
        $("#docno").prop("disabled", false);

        var win= window.open(reurl[0]+"printBankPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	
 /* var win= window.open(reurl[0]+"BankPaymentPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus(); */			
 	}
 	
 	function printCheque(){
 		
        var url=document.URL;
        var reurl=url.split("saveBankPayment");
        $("#docno").prop("disabled", false);  
        
		var win= window.open(reurl[0]+"printBankPaymentCheque?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
 	}
 	
 	function printWithOutHeader(){
 		
 		var url=document.URL;
        var reurl=url.split("saveBankPayment");
        $("#docno").prop("disabled", false); 
       
 		var win= window.open(reurl[0]+"printBankPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();

/* var win= window.open(reurl[0]+"BankPaymentPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus(); */
 	}
	function printPaymentauthform(){
		 var url=document.URL;
	        var reurl=url.split("saveBankPayment");
	        $("#docno").prop("disabled", false);

	        var win= window.open(reurl[0]+"paymentauthform?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
		
	}

</script>

<body onload="checkConfig();">
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnvoucherhead" class="myButton" value="Voucher(Header)"  onclick="printHeaderVoucher();"></td>
    <td align="center"><input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque"  onclick="printCheque();"></td>
    <td align="center"><input type="button" name="btnvoucherwithouthead" id="btnvoucherwithouthead" class="myButton" value="Voucher(Without Header)"  onclick="printWithOutHeader();"></td>
    <td align="center"><input type="button" name="btnpaymentauthform" id="btnpaymentauthform" class="myButton" value="PaymentAuthorizationForm"  onclick="printPaymentauthform();"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>