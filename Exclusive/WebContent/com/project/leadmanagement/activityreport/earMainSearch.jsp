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
	 $("#eardate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var highlight=document.getElementById("txthighlighted").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("eardate").value;
 		var status=document.getElementById("txtstatuses").value;
		var check=1;
		
		getdata(highlight,docNo,date,status,check);
	}
 	
	function getdata(highlight,docNo,date,status,check){
		 $("#refreshdiv").load('earMainSearchGrid.jsp?highlight='+highlight.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&status='+status.replace(/ /g, "%20")+'&check='+check);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="eardate" name="eardate"  value='<s:property value="eardate"/>'></div>
        <input type="hidden" name="hideardate" id="hideardate" value='<s:property value="hideardate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Hightlight</td>
    <td colspan="2"><input type="text" name="txthighlighted" id="txthighlighted" style="width:100%" value='<s:property value="txthighlighted"/>'></td>
    <td align="right">Status</td>
    <td><input type="text" name="txtstatuses" id="txtstatuses" value='<s:property value="txtstatuses"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="earMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>