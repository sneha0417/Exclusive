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
	 	$("#tebdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("tebdate").value;
 		var tbamount=document.getElementById("txttbamount").value;
 		var lsamount=document.getElementById("txtlsamount").value;
 		var travelamount=document.getElementById("txttravelamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,tbamount,lsamount,travelamount,branch);
	}
	function getdata(partyname,docNo,date,tbamount,lsamount,travelamount,branch){
		 $("#refreshdiv").load('tebMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&tbamount='+tbamount+'&lsamount='+lsamount+'&travelamount='+travelamount+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="11%" align="right">Date</td>
    <td width="26%"><div id="tebdate" name="tebdate"  value='<s:property value="tebdate"/>'></div>
        <input type="hidden" name="hidtebdate" id="hidtebdate" value='<s:property value="hidtebdate"/>'></td>
    <td width="9%" align="right">Name</td>
    <td width="23%"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td width="10%" align="right">Doc No</td>
    <td width="10%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="11%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Terminal Benefit</td>
    <td><input type="text" name="txtamount" id="txttbamount" value='<s:property value="txtamount"/>'></td>
    <td align="right">Leave Salary</td>
    <td><input type="text" name="txtamount" id="txtlsamount" value='<s:property value="txtamount"/>'></td>
    <td align="right">Travel</td>
    <td><input type="text" name="txttravelamount" id="txttravelamount" value='<s:property value="txttravelamount"/>'></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include page="tebMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>