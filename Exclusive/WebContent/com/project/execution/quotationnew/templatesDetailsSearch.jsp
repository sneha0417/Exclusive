 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadTemplateSearch() {
			var code=document.getElementById("txttempcode").value;
			var name=document.getElementById("txttempcodename").value;
			var check = 1;
	
			getTemplateDetails(code,name,check);
	}
		
	function getTemplateDetails(code,name,check){
		 $("#refreshTemplateDetailsDiv").load("templatesDetailsSearchGrid.jsp?code="+code+'&name='+name.replace(/ /g, "%20")+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right" style="font-size:9px;">Code</td>
    <td width="51%"><input type="text" name="txttempcode" id="txttempcode" style="width:70%;" value='<s:property value="txttempcode"/>'></td>
    <td width="39%" align="center"><input type="button" name="btnTemplateSearch" id="btnTemplateSearch" class="myButton" value="Search"  onclick="loadTemplateSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txttempcodename" id="txttempcodename" style="width:70%;" value='<s:property value="txttempcodename"/>'></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshTemplateDetailsDiv"><jsp:include page="templatesDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>