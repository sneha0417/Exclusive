
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
		var unitno = document.getElementById("unitnosss").value;
		var property = document.getElementById("txtproperty1").value;
		var tenant = document.getElementById("txttenant1").value;
		var docno = document.getElementById("sdocno").value;
		var date = document.getElementById("sdate").value;
		getdata(property, tenant, docno, date,unitno);      
	}  
	function getdata(property, tenant, docno, date,unitno) {   
		$("#refreshdiv").load('requestSearchGrid.jsp?id=1&property='+ property.replace(/ /g, "%20")+'&tenant='+ tenant.replace(/ /g, "%20")+'&docno='+docno+'&date='+date+'&unitno='+unitno);      
	}
</script>
<body>
	<div id=search>
		<table width="100%">                
			<tr>
				<td width="5%" align="right">Unit No</td>                      
				<td width="10%"><input type="text" name="unitnosss" id="unitnosss" value='<s:property value="unitnosss"/>' style="width:100%"></td>     
				<td width="5%" align="right">Property</td>
				<td width="40%" colspan="3"><input type="text" name="txtproperty1" id="txtproperty1" style="width:100%" value='<s:property value="txtproperty1"/>'></td>    
			</tr>
			<tr>	
				<td width="5%" align="right">Tenant</td>
				<td width="15%"><input type="text" name="txttenant1" id="txttenant1" value='<s:property value="txttenant1"/>'></td>                          
				<td width="5%" align="right">Date</td>
				<td width="12%"><div id="sdate" name="sdate"  value='<s:property value="sdate"/>'></div></td>
				<td width="5%" align="right">Doc No</td>                      
				<td width="10%"><input type="text" name="sdocno" id="sdocno" value='<s:property value="sdocno"/>' style="width:100%"></td>     
				<td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();"></td>
			</tr>            
			<tr>       
				<td colspan="9">    
					<div id="refreshdiv">    
					<jsp:include page="requestSearchGrid.jsp"></jsp:include></div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>