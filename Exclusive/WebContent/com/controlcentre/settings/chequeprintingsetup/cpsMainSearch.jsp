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
	 $("#chqsetdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var chqdate=document.getElementById("chqsetdate").value;
 		var documentno=document.getElementById("txtdocno").value;
 		var bankid=document.getElementById("txtbanksid").value;
 		var bankname=document.getElementById("txtbanksname").value;

 		getdata(chqdate,documentno,bankid,bankname);
	}
	function getdata(chqdate,documentno,bankid,bankname){
		
		 $("#refreshdiv").load('cpsMainSearchGrid.jsp?chqdate='+chqdate+'&documentno='+documentno+'&bankid='+bankid+'&bankname='+bankname);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="26%"><div id="chqsetdate" name="chqsetdate"  value='<s:property value="chqsetdate"/>'></div>
        <input type="hidden" name="hidchqsetdate" id="hidchqsetdate" value='<s:property value="hidchqsetdate"/>'></td>
    <td width="6%" align="right">Doc No</td>
    <td width="23%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="6%" align="right">Bank Id</td>
    <td width="31%"><input type="text" name="txtbanksid" id="txtbanksid" value='<s:property value="txtbanksid"/>'></td>
  </tr>
  <tr>
    <td align="right">Bank Name</td>
    <td colspan="4"><input type="text" name="txtbanksname" id="txtbanksname" style="width:90%;" value='<s:property value="txtbanksname"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include  page="cpsMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

  </div>
</body>
</html>