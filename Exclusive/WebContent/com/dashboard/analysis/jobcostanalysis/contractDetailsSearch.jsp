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
 <%  String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");%>
<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadContractSearch() {
 		 
 		var contractType=document.getElementById("cmbcontracttype").value;
 		var contractno=document.getElementById("txtcontractsno").value;
 		var check=1;
		getdata(contractType,contractno,check);
	}
 	
	function getdata(contractType,contractno,check){
		 $("#refreshcontractdiv").load('contractDetailsSearchGrid.jsp?contracttype='+contractType+'&contractno='+contractno.replace(/ /g, "%20")+'&check='+check);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="20%" align="left"><label style="background-color:transparent;font:10px Tahoma;">Contract No.</label>
    <input type="text" name="txtcontractsno" id="txtcontractsno" style="height:20px;"   value='<s:property value="txtcontractsno"/>'></td>
    
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshcontractdiv"><jsp:include page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>