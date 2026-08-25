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

 		var client=document.getElementById("txtname").value;
 		var cldocno=document.getElementById("txtcldocno").value;

		getdata(client,cldocno);
	}
	function getdata(client,cldocno){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?client='+client.replace(/ /g, "%20")+'&cldocno='+cldocno+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
   <td width="7%" align="right" style="font-size:9px;">Name</td>
    <td width="26%"><input type="text" name="txtname" id="txtname" style="width:70%;height:20px;" value='<s:property value="txtname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right" style="font-size:9px;">Cldocno</td>
    <td width="26%"><input type="text" name="txtcldocno" id="txtcldocno" style="width:70%;height:20px;" value='<s:property value="txtcldocno"/>'></td>
    </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>