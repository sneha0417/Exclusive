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
	

 	function printHeaderVoucher() {

        var url=document.URL;
        var reurl=url.split("saveSecurityCheque");
        $("#docno").prop("disabled", false);

        var win= window.open(reurl[0]+"securityChequeVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
				
 	}
 	
 	function printCheque(){
 		
        var url=document.URL;
        var reurl=url.split("com");
        $("#docno").prop("disabled", false);  
        
        var win= window.open(reurl[0]+"printSecurityCheque?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();

 	}
 	
 	function printWithOutHeader(){
 		
 		var url=document.URL;
        var reurl=url.split("saveSecurityCheque");
        $("#docno").prop("disabled", false); 
        
        var win= window.open(reurl[0]+"securityChequeVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
 	}

</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnvoucherhead" class="myButton" value="Voucher(Header)"  onclick="printHeaderVoucher();"></td>
    <td align="center"><input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque"  onclick="printCheque();"></td>
    <td align="center"><input type="button" name="btnvoucherwithouthead" id="btnvoucherwithouthead" class="myButton" value="Voucher(Without Header)"  onclick="printWithOutHeader();"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>