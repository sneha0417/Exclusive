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
	 $("#yrcdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#yrcAccFrmDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#yrcAccToDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("yrcdate").value;
 		var yrcAccFrmDate=document.getElementById("yrcAccFrmDate").value;
 		var yrcAccToDate=document.getElementById("yrcAccToDate").value;
	
		getdata(docNo,date,yrcAccFrmDate,yrcAccToDate);
	}
	function getdata(docNo,date,yrcAccFrmDate,yrcAccToDate){
		 $("#refreshdiv").load('yrcMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&yrcAccFrmDate='+yrcAccFrmDate+'&yrcAccToDate='+yrcAccToDate);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="15%" align="right">Date</td>
    <td width="22%"><div id="yrcdate" name="yrcdate"  value='<s:property value="yrcdate"/>'></div>
        <input type="hidden" name="hidyrcdate" id="hidyrcdate" value='<s:property value="hidyrcdate"/>'></td>
    <td width="16%" align="right">Doc No</td>
    <td width="28%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="19%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Accounting Year From</td>
    <td><div id="yrcAccFrmDate" name="yrcAccFrmDate"  value='<s:property value="yrcAccFrmDate"/>'></div>
        <input type="hidden" name="hidyrcAccFrmDate" id="hidyrcAccFrmDate" value='<s:property value="hidyrcAccFrmDate"/>'></td>
    <td align="right">Accounting Year To</td>
    <td><div id="yrcAccToDate" name="yrcAccToDate"  value='<s:property value="yrcAccToDate"/>'></div>
        <input type="hidden" name="hidyrcAccToDate" id="hidyrcAccToDate" value='<s:property value="hidyrcAccToDate"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="yrcMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>