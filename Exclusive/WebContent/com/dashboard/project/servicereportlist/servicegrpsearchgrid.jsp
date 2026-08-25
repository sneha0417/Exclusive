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
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var docno=document.getElementById("txtdocno").value;
 		var group=document.getElementById("txtgroup").value;
 		var id=1;
 		
		getdata(docno,group,id);
	}
	function getdata(docno,group,id){
		 $("#servgrpdiv").load('servicegrpsearch.jsp?docno='+docno.replace(/ /g, "%20")+'&group='+group+'&id='+id);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Docno</td>
    <td colspan="2"><input type="text" name="txtdocno" id="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right" style="font-size:9px;">Group</td>
    <td width="26%"><input type="text" name="txtgroup" id="txtgroup" style="width:70%;height:20px;" value='<s:property value="txtgroup"/>'></td>
    </tr>
  <tr>
    <td colspan="5"><div id="servgrpdiv"><jsp:include page="servicegrpsearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>