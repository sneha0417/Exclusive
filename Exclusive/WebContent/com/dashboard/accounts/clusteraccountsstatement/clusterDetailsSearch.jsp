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

<script type="text/javascript">
	$(document).ready(function () {
		$("#txtdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 
	
	function loadClusterSearch() {
			var docno=document.getElementById("txtcldocumentno").value;
			var clustersname=document.getElementById("txtclname").value;
			var date=document.getElementById("txtdate").value;
			var check = 1;
	
			getClusterDetails(docno,clustersname,date,check);
	}
		
	function getClusterDetails(docno,clustersname,date,check){
		 $("#refreshClusterDetailsDiv").load("clusterDetailsSearchGrid.jsp?docno="+docno+'&clustersname='+clustersname.replace(/ /g, "%20")+'&date='+date+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right" style="font-size:9px;">Doc No</td>
    <td width="30%"><input type="text" name="txtcldocumentno" id="txtcldocumentno" style="width:85%;height:20px;" value='<s:property value="txtcldocumentno"/>'></td>
    <td width="10%" align="right" style="font-size:9px;">Date</td>
    <td width="27%"><div id="txtdate" name="txtdate"  value='<s:property value="txtdate"/>'></div>
        <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadClusterSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Cluster Name</td>
    <td colspan="3"><input type="text" name="txtclname" id="txtclname" style="width:80%;height:20px;" value='<s:property value="txtclname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshClusterDetailsDiv"><jsp:include page="clusterDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>