 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
      function loadhighgrid(){
		var id2=1;
		$("#refreshdiv2").load('searchHighLight.jsp?id2='+id2);
      } 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
       <td width="90%" align="right"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" onclick="loadhighgrid();" value="Search" ></td>
  </tr>
  <tr>
    <td align="right">
    
    <div id="refreshdiv2">
      
   <jsp:include page="searchHighLight.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>