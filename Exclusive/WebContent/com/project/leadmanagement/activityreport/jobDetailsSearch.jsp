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
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString().trim(); %>
<% String cldocno =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString().trim(); %>
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>
	
<script type="text/javascript">

	$(document).ready(function () {
		document.getElementById("txtdtype").value='<%=dtype%>';
		document.getElementById("txtclientdocno").value='<%=cldocno%>';
	});   
		   
  	function loadJobSearch() {
 		
 		var docno=document.getElementById("txtjobdocnos").value;
 		var refnames=document.getElementById("refnames").value;
 		var dtype=document.getElementById("txtdtype").value;
 		var cldocno=document.getElementById("txtclientdocno").value;
 		
		getjobdatas(docno,refnames,dtype,cldocno);
	}

  	function getjobdatas(docno,refnames,dtype,cldocno){
		 $("#refjobsearch").load('jobDetailsSearchGrid.jsp?docno='+docno+'&refnames='+refnames.replace(/ /g, "%20")+'&dtype='+dtype+'&cldocno='+cldocno+'&check=1');
	}  

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Doc No</td>
    <td width="80%"><input type="text" name="txtjobdocnos" id="txtjobdocnos"  style="width:30%;" value='<s:property value="txtjobdocnos"/>'>
    <input type="hidden" name="txtdtype" id="txtdtype" style="width:40%;" value='<s:property value="txtdtype"/>'>
    <input type="hidden" name="txtclientdocno" id="txtclientdocno" style="width:40%;" value='<s:property value="txtclientdocno"/>'></td>
    <td width="14%" align="center"><input type="button" name="searchss" id="searchss" class="myButton" value="Search"  onclick="loadJobSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Customer</td>
    <td colspan="2"><input type="text" name="refnames" id="refnames"  style="width:60%;" value='<s:property value="refnames"/>'></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refjobsearch"><jsp:include page="jobDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>