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
 <%

 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 

 
 %>
<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadContractSearch() {
 		 
 		var contractType=document.getElementById("cmbcontracttype").value;
 		var cldocno=1;
 		var contractno=document.getElementById("txtcontractsno").value;
 		var refno=1;
 
 		//alert(contractType);
		getdata(contractType,cldocno,contractno,refno);
	}
 	
	function getdata(contractType,cldocno,contractno,refno){
		 $("#refreshcontractdiv").load('contractDetailsSearchGrid.jsp?contracttype='+contractType+'&cldocno='+cldocno+'&contractno='+contractno.replace(/ /g, "%20")+'&refno='+refno);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="20%" align="leftt" ><label style="background-color:transparent;font:10px Tahoma;">Contract No.</label>
    <input type="text" name="txtcontractsno" id="txtcontractsno" style="height:120%;"   value='<s:property value="txtcontractsno"/>'></td>
    
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshcontractdiv"><jsp:include page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>