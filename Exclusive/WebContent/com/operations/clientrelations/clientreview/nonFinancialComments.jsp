<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#jqxNonFinancialDates").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 if($("#docno").val()=="" || $("#docno").val()=="undefined"){
			 if($("#txtnonfinancialcomment").val()=="undefined"){
				 $('#txtnonfinancialcomments').val('');
			 }
		 }
		 
		 if(!(($("#docno").val()=="") || ($("#docno").val()=="undefined"))){
			 
			 if($("#txtnonfinancialcomment").val()=="undefined"){
				 $('#txtnonfinancialcomments').val('');
			 }else{
			     $('#txtnonfinancialcomments').val($("#txtnonfinancialcomment").val());
			 }
			 $("#jqxNonFinancialDates").jqxDateTimeInput('setDate', $('#jqxNonFinancialDate').jqxDateTimeInput('getDate'));
		 }
			
	});

	function funEnterDetail(){
		if($("#docno").val()=="" || $("#docno").val()=="undefined"){
			$("#mode").val("A");
			$('#txtnonfinancialcomment').val($("#txtnonfinancialcomments").val()) ;
			$("#jqxNonFinancialDate").jqxDateTimeInput('setDate', $('#jqxNonFinancialDates').jqxDateTimeInput('getDate'));
			$('#frmClientReview').submit();
		}
		
		if(!(($("#docno").val()=="") || ($("#docno").val()=="undefined"))){
			$("#mode").val("E");
			$('#txtnonfinancialcomment').val($("#txtnonfinancialcomments").val()) ;
			$("#jqxNonFinancialDate").jqxDateTimeInput('setDate', $('#jqxNonFinancialDates').jqxDateTimeInput('getDate'));
			$('#frmClientReview').submit();
		}
		
	}
	
	function funDelete(){
		$("#mode").val("D");
		$('#frmClientReview').submit();
	}
</script>
</head>
<body style="background-color:#E0ECF8;font-size:10px;"> 
<div style="background-color:#E0ECF8;">
<br/><br/><br/>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="16%"><div id="jqxNonFinancialDates" name="jqxNonFinancialDates" value='<s:property value="jqxNonFinancialDates"/>'></div>
    <input type="hidden" id="hidjqxNonFinancialDates" name="hidjqxNonFinancialDates" value='<s:property value="hidjqxNonFinancialDates"/>'/></td>
    <td width="48%" align="center"><input type="button" name="btnSubmit" id="btnSubmit" class="myButton" value="Submit"  onclick="funEnterDetail();"></td>
    <td width="30%" align="left"><button class="icon" id="btnDeleteDoc" title="Delete current Document" onclick="funDelete();">
							<img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
						</button></td>
    </tr>
   <tr>
    <td width="6%" align="right">Comment</td>
    <td colspan="3"><input type="text" id="txtnonfinancialcomments" name="txtnonfinancialcomments" style="width:80%;" value='<s:property value="txtnonfinancialcomments"/>'/></td>
  </tr>
</table><br/><br/><br/>

</div>
</body>
</html>