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

 		var flname=document.getElementById("txtfloorsname").value;
 		var flcode=document.getElementById("txtfloorscode").value;
 		var chk = 1;
 		
		getdata(flname,flcode,chk);
	}
 	
	function getdata(flname,flcode,chk){
		 $("#refreshdiv").load('floorMainSearchGrid.jsp?flname='+flname.replace(/ /g, "%20")+'&flcode='+flcode+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right" style="font-size:9px;">Code</td>
    <td width="30%"><input type="text" name="txtfloorscode" id="txtfloorscode" value='<s:property value="txtfloorscode"/>'></td>
    <td width="5%" align="right" style="font-size:9px;">Name</td>
    <td width="42%"><input type="text" name="txtfloorsname" id="txtfloorsname" style="width:100%;" value='<s:property value="txtfloorsname"/>'></td>
    <td width="19%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadMianSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="floorMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>