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
	$(document).ready(function () {}); 
  
 	function loadSearch() {
 		
 		var empname=document.getElementById("txtempname").value;
 		var empid=document.getElementById("txtempid").value;

 		getdata(empname,empid);
	}
 	
	function getdata(empname,empid){
		
		 $("#refreshdiv").load('empMainSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&empid='+empid);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtempname" id="txtempname" style="width:80%" value='<s:property value="txtempname"/>'></td>
    <td width="8%" align="right">Emp#</td>
    <td colspan="2"><input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'></td>
    <td width="15%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="empMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>