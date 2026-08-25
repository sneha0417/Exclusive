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
		$("#datess").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy",value: null}); 
	}); 

 	function loadSearch() {
 		var Cl_names=document.getElementById("Cl_names").value;
 		var dates=document.getElementById("datess").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_namess = Cl_names.replace(' ','%20'); 
 		var reftype=document.getElementById("reftype").value; 
 		var refno=document.getElementById("refno").value; 
 		
	    getdata1(Cl_namess,msdocno,dates,reftype,refno);
			}
 	
	  function getdata1(Cl_namess,msdocno,dates,reftype,refno){
		  
		  var id=1;
		
		 $("#refreshdivmas").load('estimationDetailsSearchGrid.jsp?Cl_namess='+Cl_namess.replace(/ /g, "%20")+'&msdocno='+msdocno+'&dates='+dates+'&id='+id+'&reftype='+reftype+'&refno='+refno);
		
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right" style="font-size:9px;">Docno</td>
    <td width="15%"><input type="text" name="msdocno" id="msdocno" style="height:20px;" value='<s:property value="msdocno"/>'></td>
    <td width="10%" align="right" style="font-size:9px;">Client</td>
    <td width="46%"><input type="text" name="Cl_names" id="Cl_names"  style="width:85%;height:20px;" value='<s:property value="Cl_names"/>'></td>
    <td width="7%" align="right" style="font-size:9px;">Date</td>
    <td width="14%"><div id="datess" name="datess" value='<s:property value="datess"/>'></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Ref Type</td>
    <td><select  name="reftype" id="reftype" style="width:100%;height:20px;"  value='<s:property value="reftype"/>' >
  		<option value="">--select--</option>
		<option value="DIR">DIR</option>
      	<option value="ENQ">ENQ</option>
      	<option value="SRVE">SRVE</option></select></td>
    <td align="right" style="font-size:9px;">Ref. Doc No</td>
    <td><input type="text" name="refno" id="refno"  style="width:85%;height:20px;" value='<s:property value="refno"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdivmas"><jsp:include  page="estimationDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>