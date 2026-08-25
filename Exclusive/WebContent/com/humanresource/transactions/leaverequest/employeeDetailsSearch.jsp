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

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var designation=document.getElementById("cmbempdesignation").value;
 		var department=document.getElementById("cmbempdepartment").value;
 		var category=document.getElementById("cmbpayrollcategory").value;
 		
		getdata(employeeName,empId,contactNo,designation,department,category);
	}
	function getdata(employeeName,empId,contactNo,designation,department,category){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&designation='+designation+'&department='+department+'&category='+category+'&contactno='+contactNo);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;" value='<s:property value="txtpartyname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right">ID#</td>
    <td width="26%"><input type="text" name="txtpartyid" id="txtpartyid" style="width:70%;" value='<s:property value="txtpartyid"/>'></td>
    <td width="18%" align="right">Contact No.</td>
    <td width="49%"><input type="text" name="txtcontactno" id="txtcontactno" style="width:50%;" value='<s:property value="txtcontactno"/>'>
    <input type="hidden" name="txtatype" id="txtatype" value='<s:property value="txtatype"/>'></td>   
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>