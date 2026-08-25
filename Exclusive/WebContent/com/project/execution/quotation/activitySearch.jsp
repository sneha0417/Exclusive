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

 	function loadActivitySearch() {

 		var activity=document.getElementById("txtactivitiesname").value;
 		var check = 1;
 		
		getdata(activity,check);
	}
	function getdata(activity,check){
		 $("#refreshactivitydiv").load('activitySearchGrid.jsp?activity='+activity.replace(/ /g, "%20")+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right">Activity</td>
    <td width="72%"><input type="text" name="txtactivitiesname" id="txtactivitiesname" style="width:80%;" value='<s:property value="txtactivitiesname"/>'></td>
    <td width="23%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadActivitySearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshactivitydiv"><jsp:include page="activitySearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>