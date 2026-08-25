 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
     <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script>
	function loadgrid(){
		
		var id=1;
		$("#refreshdiv1").load('searchUser.jsp?id='+id);

		}
	</script>
	
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
       <td width="90%" align="right"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadgrid();"></td>
  </tr>  
<tr>
    <td align="right">
    
    <div id="refreshdiv1">
      
   <jsp:include page="searchUser.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>