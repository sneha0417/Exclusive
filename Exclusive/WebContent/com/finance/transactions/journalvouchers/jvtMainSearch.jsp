 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
 
	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

	
 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var dates=document.getElementById("txtdate").value;
 		var descriptions=document.getElementById("txtdesc").value;
 		var refNo=document.getElementById("txtreference").value;
 		var amounts=document.getElementById("txtamount").value;
 		var check = 1;
 		
		getdata(docNo,dates,descriptions,refNo,amounts,check);

	}
 	
	function getdata(docNo,dates,descriptions,refNo,amounts,check){
		 $("#refreshdiv").load('jvtMainSearchGrid.jsp?docNo='+docNo+'&dates='+dates+'&descriptions='+descriptions.replace(/ /g, "%20")+'&refNo='+refNo+'&amounts='+amounts+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="20%"><input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'></td>
    <td width="11%" align="right">Ref. No.</td>
    <td width="23%"><input type="text" name="txtreference" id="txtreference" autocomplete="off" value='<s:property value="txtreference"/>'></td>
    <td width="21%" align="right">Date</td>
    <td width="18%"><div id="txtdate" name="txtdate"  value='<s:property value="txtdate"/>'></div>
    <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'></td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtamount" name="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdesc" name="txtdesc" autocomplete="off" style="width:85%;" value='<s:property value="txtdesc"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="jvtMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>