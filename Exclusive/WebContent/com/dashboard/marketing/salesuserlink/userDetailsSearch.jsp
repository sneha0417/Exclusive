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

 		var usersname=document.getElementById("txtusersname").value;
 		var usersrole=document.getElementById("txtusersrole").value;
 		var chk = 1;
 		
		getdata(usersname,usersrole,chk);
	}
 	
	function getdata(usersname,usersrole,chk){
		 $("#refreshdiv").load('userDetailsSearchGrid.jsp?usersname='+usersname.replace(/ /g, "%20")+'&usersrole='+usersrole.replace(/ /g, "%20")+'&chk='+chk);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right" style="font-size:9px;">User</td>
    <td width="37%"><input type="text" name="txtusersname" id="txtusersname" style="width:100%;height:20px;" value='<s:property value="txtusersname"/>'></td>
    <td width="9%" align="right" style="font-size:9px;">Role</td>
    <td width="33%"><input type="text" name="txtusersrole" id="txtusersrole" style="width:100%;height:20px;" value='<s:property value="txtusersrole"/>'></td>
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="userDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>