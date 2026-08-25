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
	 $("#txtdob").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	}); 

  
 	function loadSearch() {
 		var cdmname=document.getElementById("txtcdmname").value;
 		var cdmdocno=document.getElementById("txtcdmdocno").value;
 		var cdmrefno=document.getElementById("txtcdmrefno").value;
 		var cdmdob=document.getElementById("txtdob").value;

 		getdata(cdmname,cdmdocno,cdmrefno,cdmdob);
	}
 	
	function getdata(cdmname,cdmdocno,cdmrefno,cdmdob){
		
		 $("#refreshdiv").load('cdmMainSearchGrid.jsp?cdmname='+cdmname.replace(/ /g, "%20")+'&cdmdocno='+cdmdocno+'&cdmrefno='+cdmrefno+'&cdmdob='+cdmdob);
		}

	</script>
<body>
<div id=search>

<table width="100%" border="0">
  <tr>
    <td width="11%" align="right">Name</td>
    <td width="37%"><input type="text" name="txtcdmname" id="txtcdmname" style="width:80%" value='<s:property value="txtcdmname"/>'></td>
    <td width="10%" align="right">DOB</td>
    <td width="27%"><div id="txtdob" name="txtdob"  value='<s:property value="txtdob"/>'></div></td>
    <td width="15%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Doc No</td>
    <td><input type="text" name="txtcdmdocno" id="txtcdmdocno" style="width:80%" value='<s:property value="txtcdmdocno"/>'></td>
    <td align="right">Ref No</td>
    <td><input type="text" name="txtcdmrefno" id="txtcdmrefno" style="width:80%" value='<s:property value="txtcdmrefno"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include  page="cdmMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

  </div>
</body>
</html>