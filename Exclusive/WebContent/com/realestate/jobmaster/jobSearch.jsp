
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function() {
	$("#sdate").jqxDateTimeInput({ width: '100%', height: '23px', formatString:"dd.MM.yyyy",value:null});
	});

	function loadSearch() {
		var job = document.getElementById("txtjobdesc1").value;
		var docno = document.getElementById("sdocno").value;
		var date = document.getElementById("sdate").value;
		getdata(job, docno, date);  
	}  
	function getdata(job, docno, date) {   
		$("#refreshdiv").load('jobSearchGrid.jsp?id=1&job='+ job.replace(/ /g, "%20")+'&docno='+docno+'&date='+date);              
	}
</script>
<body>
	<div id=search>
		<table width="100%">                
			<tr>
				<td width="5%" align="right">Description</td>
				<td width="15%"><input type="text" name="txtjobdesc1" id="txtjobdesc1" value='<s:property value="txtjobdesc1"/>'></td>    
				<td width="5%" align="right">Date</td>
				<td width="12%"><div id="sdate" name="sdate"  value='<s:property value="sdate"/>'></div></td>
				<td width="5%" align="right">Doc No</td>                         
				<td width="10%"><input type="text" name="sdocno" id="sdocno" value='<s:property value="sdocno"/>' style="width:100%"></td>     
				<td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();"></td>
			</tr>            
			<tr>     
				<td colspan="9">    
					<div id="refreshdiv">    
					<jsp:include page="jobSearchGrid.jsp"></jsp:include></div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>