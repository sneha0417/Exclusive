 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
 
	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

	
 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var dates=document.getElementById("txtdate").value;
 		var check = 1;
 		
		getdata(docNo,dates,check);

	}
 	
	function getdata(docNo,dates,check){
		 $("#refreshdiv").load('lopMainSearchGrid.jsp?docNo='+docNo+'&dates='+dates+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="33%"><input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'></td>
    <td width="12%" align="right">Date</td>
    <td width="23%"><div id="txtdate" name="txtdate"  value='<s:property value="txtdate"/>'></div>
    <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'></td>
<td width="25%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="lopMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>