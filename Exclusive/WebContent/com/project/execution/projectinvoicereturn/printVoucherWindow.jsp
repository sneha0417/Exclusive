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
		
	$(document).ready(function () {
		getbankname();
	});
	
	function getbankname() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var banknameItems = items[0].split(",");
				var bankIdItems = items[1].split(",");
				var optionsbanknames = '<option value="">--Select--</option>';
				for (var i = 0; i < banknameItems.length; i++) {
					optionsbanknames += '<option value="' + bankIdItems[i] + '">'
							+ banknameItems[i] + '</option>';
				}
				$("select#cmbprintbankname").html(optionsbanknames);
				
			} else {
			}
		}
		x.open("GET", "getBankName.jsp", true);
		x.send();
	}

 	function printProjectInvoice() {

 		$("#docno").prop("disabled", false);
		$("#maintrno").prop("disabled", false);
		$("#formdetailcode").prop("disabled", false);
		 
		var docno=$('#docno').val();
 		var trno=$('#maintrno').val();
 		var dtype=$('#formdetailcode').val();
 		var bankdocno=$('#cmbprintbankname').val();
 		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
 		var url=document.URL;
 		var reurl=url.split("com/"); 
 		
		 var win= window.open(reurl[0]+"printInvoice?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&bankdocno="+bankdocno+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     win.focus();
			
 	}

</script>

<body onload="getbankname();">
<div id=search>
<br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td width="7%" align="right">Bank</td>
    <td colspan="2"><select id="cmbprintbankname" name="cmbprintbankname" style="width:65%;" value='<s:property value="cmbprintbankname"/>'>
      <option value="">--Select--</option></select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="57%" align="center"><input type="button" name="btnPrintProjectInvoice" id="btnPrintProjectInvoice" class="myButton" value="Print"  onclick="printProjectInvoice();"></td>
    <td width="36%">&nbsp;</td>
  </tr>
</table>
<br/><br/><br/><br/><br/>
  </div>
</body>
</html>