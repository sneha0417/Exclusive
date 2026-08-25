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

 	function loadMianSearch() {

 		var bincode=document.getElementById("txtbinscode").value;
 		var binname=document.getElementById("txtbinsname").value;
 		var chk = 1;
 		
		getdata(binname,bincode,chk);
	}
 	
	function getdata(binname,bincode,chk){
		 $("#refreshdiv").load('binMainSearchGrid.jsp?binname='+binname.replace(/ /g, "%20")+'&bincode='+bincode+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right" style="font-size:9px;">Code</td>
    <td width="30%"><input type="text" name="txtbinscode" id="txtbinscode" value='<s:property value="txtbinscode"/>'></td>
    <td width="5%" align="right" style="font-size:9px;">Name</td>
    <td width="42%"><input type="text" name="txtbinsname" id="txtbinsname" style="width:100%;" value='<s:property value="txtbinsname"/>'></td>
    <td width="19%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadMianSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="binMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>