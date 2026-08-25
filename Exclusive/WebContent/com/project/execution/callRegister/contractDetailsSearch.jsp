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

 	function loadContractSearch() {

 		var contractNo=document.getElementById("txtcontractsno").value;
 		var contractDetails=document.getElementById("txtcontractsdetails").value;
 		var branch=document.getElementById("brchName").value;
 		var contractType=document.getElementById("cmbcontracttype").value;
 		var cldocno=document.getElementById("txtclientdocno").value;
 		var areass=document.getElementById("txtarea").value;
 		var area = areass.replace(' ','%20');
 		var sitess=document.getElementById("txtsite1").value;
 		var site = sitess.replace(' ','%20');
 		
 		var check = 1;
 		
		getdata(contractDetails,contractNo,branch,contractType,cldocno,check,area,site);
	}
 	
	function getdata(contractDetails,contractNo,branch,contractType,cldocno,check,area,site){
		 $("#refreshcontractdiv").load('contractDetailsSearchGrid.jsp?contractdetails='+contractDetails.replace(/ /g, "%20")+'&contractno='+contractNo+'&branch='+branch+'&contracttype='+contractType+'&cldocno='+cldocno+'&check='+check+'&area='+area+'&site='+site);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="15%" align="right">Contract No.</td>
    <td width="28%"><input type="text" name="txtcontractsno" id="txtcontractsno" style="width:90%;" value='<s:property value="txtcontractsno"/>'></td>
    <td width="10%" align="right">Ref No</td>
    <td width="31%"><input type="text" name="txtcontractsdetails" id="txtcontractsdetails" style="width:90%;" value='<s:property value="txtcontractsdetails"/>'></td>
  
  </tr>
  <tr>
    <td width="15%" align="right">Site</td>
    <td width="28%"><input type="text" name="txtsite1" id="txtsite1" style="width:90%;" value='<s:property value="txtsite1"/>'></td>
    <td width="10%" align="right">Area</td>
    <td width="31%"><input type="text" name="txtarea" id="txtarea" style="width:90%;" value='<s:property value="txtarea"/>'></td>
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
    </tr>
  <tr>
    <td colspan="5"><div id="refreshcontractdiv"><jsp:include page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>