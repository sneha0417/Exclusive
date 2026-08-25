 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String type=request.getParameter("type")==null || request.getParameter("type")==""?"NA":request.getParameter("type").trim();%>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>    --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	 var typess='<%=type%>';
	function loadSearchs() {
 		
 		var accountss=document.getElementById("accountss").value;
 		var accnames=document.getElementById("accnamess").value.replace(' ', '%20');
 		var mobno=document.getElementById("mobileno").value;
 		/* var type=request.getParameter("type").trim(); */
		getdata(accountss,accnames,mobno,typess);
	}
	function getdata(accountss,accnames,mobileno,type){
				 $("#refreshdivs").load('accountsDetailsFromGrid.jsp?accountss='+accountss+'&accnamess='+accnames+'&mobileno='+mobileno+'&types='+type+"&id=1");
	}
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >

  <tr >
    <td align="right" width="6%">Account</td>
    <td align="left" width="20%"><input type="text" name="accountss" id="accountss" style="width:80%;"  value='<s:property value="accountss"/>'></td>
    <td width="40%">&nbsp;</td>
    <td align="right" width="10%">Mobile No</td>
  	<td align="left" width="24%"><input type="text" name="mobileno" style="width:90%;" id="mobileno" value='<s:property value="mobileno"/>'></td>
  </tr>
  
  <tr>
    <td align="right"  width="14%">Account Name</td>
    <td align="left" colspan="2" width="30%"><input type="text" name="accnamess" style="width:90%;" id="accnamess" value='<s:property value="accnamess"/>'></td>
  	<td>&nbsp;</td>
  	<td align="left"><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()"></td>
  </tr>

  <tr>
    <td colspan="8" align="right">
    	<div id="refreshdivs"><jsp:include  page="accountsDetailsFromGrid.jsp"></jsp:include></div>
    	<br/>
    </td>
  </tr>
<br/>
</table>
  </div>
</body>
</html>