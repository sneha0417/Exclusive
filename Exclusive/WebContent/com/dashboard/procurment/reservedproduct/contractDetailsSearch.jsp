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
 		 
 		var contractType=document.getElementById("cmbreftype").value;
 		var cldocno=document.getElementById("clientid").value;
 		var contractno=document.getElementById("txtcontractsno").value;
 		var refno=document.getElementById("txtcontractsdetails").value;
 
 		
		getdata(contractType,cldocno,contractno,refno);
	}
 	
	function getdata(contractType,cldocno,contractno,refno){
		 $("#refreshcontractdiv").load('contractDetailsSearchGrid.jsp?contracttype='+contractType+'&cldocno='+cldocno+'&contractno='+contractno+'&refno='+refno);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="20%" align="right" ><label style="background-color:transparent;font:10px Tahoma;">Contract No.</label></td>
    <td width="29%"><input type="text" name="txtcontractsno" id="txtcontractsno" style="height:120%;"   value='<s:property value="txtcontractsno"/>'></td>
    <td width="12%" align="right" ><label style="background-color:transparent;font:10px Tahoma;">Ref No</label></td>
    <td width="23%"><input type="text" name="txtcontractsdetails" style="height:120%;" id="txtcontractsdetails" value='<s:property value="txtcontractsdetails"/>'></td>
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshcontractdiv"><jsp:include page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>