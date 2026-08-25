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
	 $("#roledate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var rolename=document.getElementById("txtuserrolename").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("roledate").value;
	
		getdata(rolename,docNo,date);
	}
	function getdata(rolename,docNo,date){
		 $("#refreshdiv").load('ubiMainSearchGrid.jsp?rolename='+rolename+'&docNo='+docNo+'&date='+date);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="roledate" name="roledate"  value='<s:property value="roledate"/>'></div>
        <input type="hidden" name="hidroledate" id="hidroledate" value='<s:property value="hidroledate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="4"><input type="text" name="txtuserrolename" id="txtuserrolename" style="width:100%" value='<s:property value="txtuserrolename"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="ubiMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>