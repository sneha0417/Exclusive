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
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadComplaintsSearchGrid() {
			var complaintdocno=document.getElementById("txtcomplaintsdocno").value;
			var complaints=document.getElementById("txtcomplaintsdetails").value;
			var check = 1;
	
			getComplaintDetails(complaintdocno,complaints,check);
	}
		
	function getComplaintDetails(complaintdocno,complaints,check){
		 $("#refreshCallRegisterSearchDetailsDiv").load("callRegisterSearchGrid.jsp?complaintdocno="+complaintdocno+'&complaints='+complaints.replace(/ /g, "%20")+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="15%" align="right">Doc No.</td>
    <td width="18%"><input type="text" name="txtcomplaintsdocno" id="txtcomplaintsdocno" style="width:90%;" value='<s:property value="txtcomplaintsdocno"/>'></td>
    <td width="10%" align="right">Complaints</td>
    <td width="41%"><input type="text" name="txtcomplaintsdetails" id="txtcomplaintsdetails" style="width:90%;" value='<s:property value="txtcomplaintsdetails"/>'></td>
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadComplaintsSearchGrid();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshCallRegisterSearchDetailsDiv"><jsp:include page="callRegisterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>