<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
body {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}
</style>
<script>
$(document).ready(function(e) {
    $("#detaildate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null});
});

function funSearchDetail(){
	<%
	String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
	String type=request.getParameter("type")==null?"":request.getParameter("type").toString();

	%>
		var type='<%=type%>';

	var reftype='<%=reftype%>';
	var branch='<%=branch%>';
	var docno=document.getElementById("detaildocno").value;
	var fleetno=document.getElementById("detailfleetno").value;
	var regno=document.getElementById("detailregno").value;
	var date=$('#detaildate').jqxDateTimeInput('val');
		$('#docdiv').load('docSearch.jsp?reftype='+reftype+'&branch='+branch+'&docno='+docno+'&fleetno='+fleetno+'&regno='+regno+'&date='+date+'&type='+type+'&mode=1');

}
</script>
</head>

<body >
<table width="100%" style="background-color:#E0ECF8;">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="16%" align="left"><div id="detaildate"></div></td>
    
    <td width="12%" align="right">Ref Doc No</td>
    <td width="15%" align="left"><input type="text" name="detaildocno" id="detaildocno"></td>
    <td width="9%" align="right">Fleet No</td>
    <td width="12%" align="left"><input type="text" name="detailfleetno" id="detailfleetno"></td>
    <td width="6%" align="right">Reg No</td>
    <td width="11%" align="left"><input type="text" name="detailregno" id="detailregno"></td>
    <td width="16%" align="center"><button type="button" id="btndetail" onClick="funSearchDetail();" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="9"><div id="docdiv"><jsp:include page="docSearch.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>