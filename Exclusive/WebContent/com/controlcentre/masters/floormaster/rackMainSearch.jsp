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

 		var rackcode=document.getElementById("txtrackscode").value;
 		var rackname=document.getElementById("txtracksname").value;
 		var chk = 1;
 		
		getdata(rackname,rackcode,chk);
	}
 	
	function getdata(rackname,rackcode,chk){
		 $("#refreshdiv").load('rackMainSearchGrid.jsp?rackname='+rackname.replace(/ /g, "%20")+'&rackcode='+rackcode+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right" style="font-size:9px;">Code</td>
    <td width="30%"><input type="text" name="txtrackscode" id="txtrackscode" value='<s:property value="txtrackscode"/>'></td>
    <td width="5%" align="right" style="font-size:9px;">Name</td>
    <td width="42%"><input type="text" name="txtracksname" id="txtracksname" style="width:100%;" value='<s:property value="txtracksname"/>'></td>
    <td width="19%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadMianSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="rackMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>