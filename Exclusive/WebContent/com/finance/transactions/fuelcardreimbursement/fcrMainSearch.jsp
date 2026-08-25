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
	 	$("#fueldate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtfuelcarddocno").value;
 		var date=document.getElementById("fueldate").value;
 		var amount=document.getElementById("txtfuelcardamount").value;
	    var check = 1;
	    
		getdata(partyname,docNo,date,amount,check);
	}
 	
	function getdata(partyname,docNo,date,amount,check){
		 $("#refreshdiv").load('fcrMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="fueldate" name="fueldate"  value='<s:property value="fueldate"/>'></div>
        <input type="hidden" name="hidfueldate" id="hidfueldate" value='<s:property value="hidfueldate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" id="txtfuelcarddocno" name="txtfuelcarddocno" value='<s:property value="txtfuelcarddocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td align="right">Amount</td>
    <td><input type="text" id="txtfuelcardamount" name="txtfuelcardamount" value='<s:property value="txtfuelcardamount"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="fcrMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>