<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
<script>

</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<table width="100%" class="normaltable" >
  <tr>
    <td  rowspan="6"><img src="<%=contextPath%>/icons/printheader.jpg" width="100%" height="91"  alt="" hspace="20"/></td>
   </tr>
     
  </table>
  <br><br><br>
  
  <table width="1062">
   <tr>
 <td width="125" colspan="4" align="center"><font size="4"><label align="center" id="clientfollowuplog" name="clientfollowuplog" ><b>CLIENT FOLLOWUP LOG</b></label></font></td>
  </tr> 
  	 <tr>
 <td width="125" colspan="4" align="center"><font size="2"><b><label align="center" id="lblprintname1" name="lblprintname1" ><s:property value="lblprintname1"/></label></b></font></td>
  </tr> 
  </table>
  </div>

</form>
</div>

</body>
</html>
