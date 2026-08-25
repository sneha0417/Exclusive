 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		
 		var fleetno=document.getElementById("searchfleet").value;
 		var cmbtype=document.getElementById("searchcmbtype").value;
 		var cmbreftype=document.getElementById("searchcmbreftype").value;
 		var refdocno=document.getElementById("searchrdocno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		 var branch=$('#brchName').val();
 		 var regno=document.getElementById("searchregno").value;
		getdata(fleetno,cmbtype,cmbreftype,refdocno,docno,searchdate,branch,regno);
 

	}
	 function getdata(fleetno,cmbtype,cmbreftype,refdocno,docno,searchdate,branch,regno){
		
		 $("#srefreshdiv").load('subMainSearch.jsp?fleetno='+fleetno+'&cmbtype='+cmbtype+'&cmbreftype='+cmbreftype+'&refdocno='+refdocno+'&docno='+docno+'&searchdate='+searchdate+'&branch='+branch+'&regno='+regno);
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
    <tr>
    <td width="6%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'></td>
    <td width="8%" align="right">Type</td>
    <td width="11%" align="left"><select name="searchcmbtype" id="searchcmbtype"  style="width:99%;"><option value="">--Select--</option>
    <option value="IN">IN</option><option value="OUT">OUT</option></select></td>
    <td width="15%" align="right">Ref Doc No</td>
    <td align="left"><input type="text" name="searchrdocno" id="searchrdocno"  value='<s:property value="searchrdocno"/>'></td>
    <td width="19%" align="right">Reg No</td>
    <td width="16%" align="left"><input type="text" name="searchregno" id="searchregno" ></td>
    </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="searchdate" name="searchdate"></div></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="searchfleet" id="searchfleet" ></td>
    <td align="right">Ref Type</td>
    <td width="14%" align="left"><select name="searchcmbreftype" id="searchcmbreftype" style="width:97%;"><option value="">--Select--</option>
    <option value="RAG">Rental</option><option value="LAG">Lease</option><option value="NRM">Non Revenue Movement</option><option value="RPL">
Replacement</option></select></td>
    <td colspan="2" align="center"><input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search"  onClick="mainloadSearch();"></td>
    
  </tr>
  <tr>
    <td colspan="8" align="right"> 
    <div id="srefreshdiv">
      
   <jsp:include  page="subMainSearch.jsp"></jsp:include> 
   
   </div></td>
    </tr>
</table>

  </div>
</body>
</html>