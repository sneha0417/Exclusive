 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
 <%
 String rownindex = request.getParameter("rownindex")==null?"0":request.getParameter("rownindex");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");%>
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
  
	var rownindex="<%=rownindex%>";
	var id="<%=id%>";
	
 	function loadUserSearch() {

 		var teamusername=document.getElementById("txtteamusername").value;
 		
		getdata(teamusername);
	}
 	
	function getdata(teamusername){
		 $("#refreshuserdiv").load('userDetailsSearchGrid.jsp?teamusername='+teamusername.replace(/ /g, "%20")+'&rownindex='+rownindex+'&id='+id);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">User</td>
    <td width="49%"><input type="text" name="txtteamusername" id="txtteamusername" style="width:90%;" value='<s:property value="txtteamusername"/>'></td>
    <td width="44%" align="center"><input type="button" name="btnusersearch" id="btnusersearch" class="myButton" value="Search"  onclick="loadUserSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshuserdiv"><jsp:include page="userDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>