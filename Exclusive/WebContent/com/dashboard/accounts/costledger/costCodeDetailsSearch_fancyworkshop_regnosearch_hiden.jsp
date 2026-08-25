 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
 		document.getElementById("txtcosttype").value=$('#cmbcosttype').val();
 		if(($("#cmbcosttype option:selected").text().trim()=='Fleet')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Reg No";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='AMC')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='SJOB')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='Ticket No')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else {
 			$('#txtregno').attr('hidden', true );
 			document.getElementById("lblregnositename").innerText="";
 		}
	}); 

 	function loadSearch() {

 		var costCode=document.getElementById("txtcostcodes").value;
 		var RegNo=document.getElementById("txtregno").value;
 		var type=document.getElementById("txtcosttype").value;
 		var costCodeName=document.getElementById("txtcostcodesname").value;
 		var check = 1;
 		
		getdata(type,costCode,costCodeName,RegNo,check);
	}
 	
	function getdata(type,costCode,costCodeName,RegNo,check){
		 $("#refreshdiv").load('costCodeDetailsSearchGrid.jsp?type='+type+'&costCode='+costCode+'&costCodeName='+costCodeName.replace(/ /g, "%20")+'&RegNo='+RegNo.replace(/ /g, "%20")+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right" style="font-size:9px;">Cost Code</td>
    <td width="38%"><input type="text" name="txtcostcodes" id="txtcostcodes" style="width:80%;height:20px;" value='<s:property value="txtcostcodes"/>'></td>
    <td width="9%" align="right" style="font-size:9px;"><label name="lblregnositename" id="lblregnositename"></label></td>
    <td width="33%"><input type="text" name="txtregno" id="txtregno" style="width:60%;height:20px;" value='<s:property value="txtregno"/>'>
    <input type="hidden" name="txtcosttype" id="txtcosttype" value='<s:property value="txtcosttype"/>'></td>
    <td width="13%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr><td align="right" style="font-size:9px;">Name</td>
  <td colspan="4"><input type="text" name="txtcostcodesname" id="txtcostcodesname" style="width:60%;height:20px;" value='<s:property value="txtcostcodesname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="costCodeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>