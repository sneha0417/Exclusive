 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
 		
	}); 

 	function loadSearch() {
 		var bdcenter=document.getElementById("center").value;
 		var docno=document.getElementById("txtdocno").value;
 		
 		var chk = 1;
 		
		getdata(docno,bdcenter,chk);
	}
	function getdata(docno,bdcenter,chk){
		 $("#nationalitydiv").load('nationSearch.jsp?docno='+docno+'&bdcenter='+bdcenter+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
 
    <td colspan="1"><input type="hidden" name="txtdocno" id="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'></td>
     <td align="right" style="font-size:9px;">Nation</td>
    <td colspan="1"><input type="text" name="center" id="center" style="width:80%;height:20px;" value='<s:property value="center"/>'></td>
    <td width="1%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="nationalitydiv"><jsp:include page="nationSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>