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
	 $("#reconciledate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var account=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocumentno").value;
 		var currency=document.getElementById("txtcurrency").value;
 		var description=document.getElementById("txtdesc").value;
 		var reconcileDt=document.getElementById("reconciledate").value;
	    var check = 1;
	    
		getdata(account,docNo,currency,description,reconcileDt,check);
	}
	function getdata(account,docNo,currency,description,reconcileDt,check){
		 $("#refreshdiv").load('brcnMainSearchGrid.jsp?account='+account+'&docNo='+docNo+'&currency='+currency+'&description='+description.replace(/ /g, "%20")+'&reconcileDt='+reconcileDt+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtpartyname" id="txtpartyname" style="width:95%" value='<s:property value="txtpartyname"/>'></td>
    <td width="15%" align="right">Doc No</td>
    <td><input type="text" name="txtdocumentno" id="txtdocumentno" value='<s:property value="txtdocumentno"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td width="10%" align="right">Currency</td>
    <td width="14%"><input type="text" name="txtcurrency" id="txtcurrency" style="width:50%" value='<s:property value="txtcurrency"/>'></td>
    <td width="7%" align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdesc" name="txtdesc" style="width:100%" value='<s:property value="txtdesc"/>'></td>
    <td width="14%" align="right">Reconcile Date</td>
    <td><div id="reconciledate" name="reconciledate"  style="width:80%" value='<s:property value="reconciledate"/>'></div>
        <input type="hidden" name="hidreconciledate" id="hidreconciledate" value='<s:property value="hidreconciledate"/>'></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include  page="brcnMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>