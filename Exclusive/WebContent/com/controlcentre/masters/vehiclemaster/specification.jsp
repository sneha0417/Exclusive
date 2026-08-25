<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	document.getElementById("formdet").innerText="Specification(SPC)";
	document.getElementById("formdetail").value="Specification";
	document.getElementById("formdetailcode").value="SPC";
	window.parent.formCode.value="SPC";
	window.parent.formName.value="Specification";
	
});

function funNotify(){
	return 1;
}
function funReadOnly(){
	$('#frmSpecification input').attr('readonly', true );
}
function funRemoveReadOnly(){
	$('#frmSpecification input').attr('readonly', false );

}
function funSearchLoad(){
	changeContent('specificationSearch.jsp', $('#window')); 
 }
function chkButton(){
	
}
function funFocus(){
	document.getElementById("specname").focus();
}
function setValues(){
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}
function funExcelBtn(){
				  $("#specGrid").jqxGrid('exportdata', 'xls', 'Specifications');
			  }
	</script>
</head>
<body onload="setValues();">

<div>
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmSpecification" action="saveSpecification" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Specification Info</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td width="25%" align="left"><input type="text" name="specname" id="specname" value='<s:property value="specname"/>' placeholder="Spec Name" /></td>
    <td width="58%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" name="docno" tabindex="-1" readonly id="docno" value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Details</td>
    <td colspan="3" align="left"><input type="text" name="specdetails" id="specdetails" style="width:100%;" value='<s:property value="specdetails"/>' placeholder="Spec Details"/></td>
    </tr>
</table>
</fieldset>
<table  width="100%">
<tr>
    <td ><jsp:include page="specGrid.jsp"></jsp:include></td>
    </tr>
</table>
										        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
</div>
</div>
</body>
</html>