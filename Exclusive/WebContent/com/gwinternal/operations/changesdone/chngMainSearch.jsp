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
	$(document).ready(function () {
	 $("#changeddate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("changeddate").value;
 		var forms=document.getElementById("txtforms").value;
 		var projects=document.getElementById("txtprojects").value;
 		var description=document.getElementById("txtchangeddescription").value;
	    var check = 1;
	    
		getdata(docNo,date,forms,projects,description,check);
	}
	
 	function getdata(docNo,date,forms,projects,description,check){
		 $("#refreshdiv").load('chngMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&forms='+forms.replace(/ /g, "%20")+'&projects='+projects.replace(/ /g, "%20")+'&description='+description.replace(/ /g, "%20")+'&check='+check);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="34%"><div id="changeddate" name="changeddate"  value='<s:property value="changeddate"/>'></div></td>
    <td width="9%" align="right">Doc No</td>
    <td width="25%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="24%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Form</td>
    <td><input type="text" name="txtforms" id="txtforms" style="width:80%" value='<s:property value="txtforms"/>'></td>
    <td align="right">Project</td>
    <td><input type="text" name="txtprojects" id="txtprojects" style="width:80%" value='<s:property value="txtprojects"/>'></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" name="txtchangeddescription" id="txtchangeddescription" style="width:80%" value='<s:property value="txtchangeddescription"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include  page="chngMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

  </div>
</body>
</html>