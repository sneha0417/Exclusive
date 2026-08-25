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
	 $("#budgetsdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#assessmentDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("budgetsdate").value;
 		var assessmentDt=document.getElementById("assessmentDate").value;
 		var description=document.getElementById("txtdescriptions").value;
	
		getdata(docNo,date,assessmentDt,description);
	}
	function getdata(docNo,date,assessmentDt,description){
		 $("#refreshdiv").load('bgtMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&assessmentDt='+assessmentDt+'&description='+description.replace(/ /g, "%20"));
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="11%" align="right">Doc No</td>
    <td width="17%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="22%" align="right">Assessment Year</td>
    <td width="20%"><div id="assessmentDate" name="assessmentDate"  value='<s:property value="assessmentDate"/>'></div></td>
    <td width="14%" align="right">Date</td>
    <td width="16%"><div id="budgetsdate" name="budgetsdate"  value='<s:property value="budgetsdate"/>'></div></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" name="txtdescriptions" id="txtdescriptions" style="width:95%" value='<s:property value="txtdescriptions"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include  page="bgtMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>