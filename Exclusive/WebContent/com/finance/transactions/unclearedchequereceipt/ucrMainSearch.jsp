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
	 $("#unclearchequedate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#chqdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("unclearchequedate").value;
 		var amount=document.getElementById("txtamount").value;
 		var chequeNo=document.getElementById("txtchqno").value;
 		var chequeDt=document.getElementById("chqdate").value;
	    var check = 1;
	    
		getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
		 $("#refreshdiv").load('ucrMainSearchGrid.jsp?partyname='+partyname+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtpartyname" id="txtpartyname" style="width:80%" value='<s:property value="txtpartyname"/>'></td>
    <td width="11%" align="right">Doc No</td>
    <td colspan="2"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td width="14%"><div id="unclearchequedate" name="unclearchequedate"  value='<s:property value="unclearchequedate"/>'></div>
        <input type="hidden" name="hidunclearchequedate" id="hidunclearchequedate" value='<s:property value="hidunclearchequedate"/>'></td>
    <td width="10%" align="right">Amount</td>
    <td width="14%"><input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'></td>
    <td align="right">Cheque No</td>
    <td width="14%"><input type="text" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'></td>
    <td width="14%" align="right">Cheque Date</td>
    <td><div id="chqdate" name="chqdate"  value='<s:property value="chqdate"/>'></div>
        <input type="hidden" name="hidchqdate" id="hidchqdate" value='<s:property value="hidchqdate"/>'></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="ucrMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>