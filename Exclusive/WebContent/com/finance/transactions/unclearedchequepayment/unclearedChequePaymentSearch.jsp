 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>

<script type="text/javascript">
	$(document).ready(function () {
		var atype='<%=atype%>';
		document.getElementById("txttypes").value=atype;
		document.getElementById("txtnewmaindate").value=$('#maindate').val();
	}); 
	
	function loadAccountSearchGrid() {
			var accountsno=document.getElementById("txtacctno").value;
			var accountsname=document.getElementById("txtacctname").value;
			var currs=document.getElementById("txtacctcurrency").value;
			var type=document.getElementById("txttypes").value;
			var date=document.getElementById("txtnewmaindate").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,type,date,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,type,date,check){
		 $("#refreshAccountSearchDetailsDiv").load("unclearedChequePaymentSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%"><input type="text" name="txtacctno" id="txtacctno" style="width:85%;" value='<s:property value="txtacctno"/>'></td>
    <td width="10%" align="right">Currency</td>
    <td width="27%"><input type="text" name="txtacctcurrency" id="txtacctcurrency" style="width:50%;" value='<s:property value="txtacctcurrency"/>'>
    <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
    <input type="hidden" name="txtnewmaindate" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearchGrid();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtacctname" id="txtacctname" style="width:80%;" value='<s:property value="txtacctname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshAccountSearchDetailsDiv"><jsp:include page="unclearedChequePaymentSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>