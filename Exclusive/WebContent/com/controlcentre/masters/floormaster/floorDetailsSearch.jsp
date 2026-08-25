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

 		var flname=document.getElementById("txtflname").value;
 		var flcode=document.getElementById("txtflcode").value;
 		var chk = 1;
 		
		getdata(flname,flcode,chk);
	}
	function getdata(flname,flcode,chk){
		 $("#refreshdiv").load('floorDetailsSearchGrid.jsp?flname='+flname.replace(/ /g, "%20")+'&flcode='+flcode+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right" style="font-size:9px;">Code</td>
    <td width="30%"><input type="text" name="txtflcode" id="txtflcode" value='<s:property value="txtflcode"/>'></td>
    <td width="5%" align="right" style="font-size:9px;">Name</td>
    <td width="42%"><input type="text" name="txtflname" id="txtflname" style="width:100%;" value='<s:property value="txtflname"/>'></td>
    <td width="19%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="floorDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>