<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> --> 
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 545px;
}
</style>
<script>
function funWildSearch(){
	alert("Inside Search Button");
	var tempdoc=document.getElementById("searchdocno").value;
	var tempfleet=document.getElementById("searchfleet").value;
	var tempregno=document.getElementById("searchregno").value;
	var tempstatus=document.getElementById("searchstatus").value;
	
	getWildData(tempdoc,tempfleet,tempregno,tempstatus);
}
function getWildData(tempdoc,tempfleet,tempregno,tempstatus) {
	alert("Inside Ajax Function");
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			//alert(items);
			$("#wildgriddiv").load("wildsearchgrid.jsp?id="+items);
		} else {
		}
	}
	x.open("GET", "getWildData.jsp?doc="+tempdoc+"&fleet="+tempfleet+"&regno="+tempregno+"&status="+tempstatus+"", true);
	x.send();
}
</script>
</head>
<body>
<div style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td align="right">Doc No</td>
    <td><input type="text" name="searchdocno" id="searchdocno"  value='<s:property value="searchdocno"/>'/></td>
    <td align="right">Fleet</td>
    <td><input type="text" name="searchfleet" id="searchfleet"  value='<s:property value="searchfleet"/>'/></td>
    <td align="right">Reg No</td>
    <td><input type="text" name="searchregno" id="searchregno"  value='<s:property value="searchregno"/>'/></td>
    <td>Status</td>
    <td><input type="text" name="searchstatus" id="searchstatus" value='<s:property value="searchstatus"/>'/></td>
  </tr>
  <tr>
    <td colspan="8" align="center"><input type="button" name="btndsearch" id="btndsearch" class="myButton" value="Search" onclick="funWildSearch();"></td>
  </tr>
  <tr>
    <td colspan="8"><div id="wildgriddiv"><jsp:include page="wildsearchgrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>