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
        var reurl=url.split("com");
        $("#docno").prop("disabled", false);  
        
		var win= window.open(reurl[0]+"printBankPaymentCheque?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
 	}
 	
 	function printReceipt(){
 		
 		  if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
              var url = document.URL;
              var reurl;
              if (url.indexOf('saveTenancyContract') >= 0) {
                  reurl = url.split("saveTenancyContract");
              } else {
                  reurl = url.split("tenancyContract.jsp");
              }
              $("#docno").prop("disabled", false);
              var dtype = $('#formdetailcode').val();
              var print=1;
              var brhid = '<%=session.getAttribute("BRANCHID").toString()%>';
              var win = window.open(reurl[0] + "printTenancyContract?docno=" + document.getElementById("masterdoc_no").value + "&brhid=" + brhid + "&dtype=" + dtype + "&print=" + print, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
              win.focus();

          } else {
              $.messager.alert('Message', 'Select a Document....!', 'warning');
              return false;
          } 
 	}
	function printInvoice(){
		  if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
              var url = document.URL;
              var print=2;
              var reurl;
              if (url.indexOf('saveTenancyContract') >= 0) {
                  reurl = url.split("saveTenancyContract");
              } else {
                  reurl = url.split("tenancyContract.jsp");
              }
              $("#docno").prop("disabled", false);
              var dtype = $('#formdetailcode').val();
              var brhid = '<%=session.getAttribute("BRANCHID").toString()%>';
              var win = window.open(reurl[0] + "printTenancyContract?docno=" + document.getElementById("masterdoc_no").value + "&brhid=" + brhid + "&dtype=" + dtype + "&print=" + print, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
              win.focus();

          } else {
              $.messager.alert('Message', 'Select a Document....!', 'warning');
              return false;
          } 
		
	}

</script>

<body onload="checkConfig();">
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnvoucherhead" class="myButton" value="Receipt"  onclick="printReceipt();"></td>
    <td align="center"><input type="button" name="btncheque" id="btncheque" class="myButton" value="Invoice"  onclick="printInvoice();"></td>
   
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>