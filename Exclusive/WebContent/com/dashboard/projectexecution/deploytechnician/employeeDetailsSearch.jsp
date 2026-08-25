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
<% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString().trim(); %>
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		document.getElementById("txtid").value='<%=id%>';
	}); 

 	function loadSearch() {

 		var empname=document.getElementById("txtemployeesname").value;
 		var empid=document.getElementById("txtemployeesid").value;
 		var id=document.getElementById("txtid").value;
 		
		getdata(empname,empid,id);
	}
	function getdata(empname,empid,id){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&empid='+empid+'&id='+id+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Emp Id</td>
    <td width="80%"><input type="text" name="txtemployeesid" id="txtemployeesid" style="width:40%;height:20px;" value='<s:property value="txtemployeesid"/>'>
    <input type="hidden" name="txtid" id="txtid" style="width:40%;height:20px;" value='<s:property value="txtid"/>'></td>
    <td width="14%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtemployeesname" id="txtemployeesname" style="width:70%;height:20px;" value='<s:property value="txtemployeesname"/>'></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshdiv"><jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>