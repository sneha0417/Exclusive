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
	 $("#debitdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocumentno").value;
 		var date=document.getElementById("debitdate").value;
 		var accId=document.getElementById("txtaccountid").value;
 		var accName=document.getElementById("txtaccountname").value;
 		var amounts=document.getElementById("txtamounts").value;
 		var amount=(amounts*-1);
 		var description=document.getElementById("txtdescriptions").value;
	    var check = 1 ;
	    
		getdata(docNo,date,accId,accName,amount,description,check);
	}
	function getdata(docNo,date,accId,accName,amount,description,check){
		 $("#refreshdiv").load('dnoMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&accId='+accId+'&accName='+accName.replace(/ /g, "%20")+'&amount='+amount+'&description='+description.replace(/ /g, "%20")+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="9%" align="right">Doc No</td>
    <td width="23%"><input type="text" name="txtdocumentno" id="txtdocumentno" value='<s:property value="txtdocumentno"/>'></td>
    <td width="6%" align="right">Date</td>
    <td width="21%"><div id="debitdate" name="debitdate"  value='<s:property value="debitdate"/>'></div>
        <input type="hidden" name="hiddebitdate" id="hiddebitdate" value='<s:property value="hiddebitdate"/>'></td>
    <td width="7%" align="right">A/C No.</td>
    <td width="23%"><input type="text" name="txtaccountid" id="txtaccountid" style="width:80%" value='<s:property value="txtaccountid"/>'></td>
    <td width="11%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">A/C Name</td>
    <td><input type="text" name="txtaccountname" id="txtaccountname" style="width:80%" value='<s:property value="txtaccountname"/>'></td>
    <td align="right">Amount</td>
    <td><input type="text" name="txtamounts" id="txtamounts" value='<s:property value="txtamounts"/>'></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" name="txtdescriptions" id="txtdescriptions" style="width:80%" value='<s:property value="txtdescriptions"/>'></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include  page="dnoMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>