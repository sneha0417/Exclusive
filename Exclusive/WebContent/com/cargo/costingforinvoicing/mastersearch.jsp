 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	  $("#estmdates").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 
 	function estloadSearch1() {
 		var estdate=document.getElementById("estmdates").value;
 		var client=document.getElementById("jobnossss").value;
 		var docno=document.getElementById("docnos").value;
 		var refno=document.getElementById("refnos").value;
 		getdata1(estdate,docno,client,refno)
	}
	function getdata1(estdate,docno,client,refno){
		$("#refreshdiv").load('subMastersearch.jsp?estdate='+estdate+'&docno='+docno+'&client='+client+'&refno='+refno+'&id=1');
	}
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table width="100%">
   <tr>
   <td width="7%" align="right">DOC No</td>
    <td align="left" width="24%"><input type="text" name="docnos" id="docnos"  value='<s:property value="docnos"/>'></td>
    <td align="right" >Job No</td>
    <td align="left" width="37%" ><input type="text" name="jobnossss" id="jobnossss"  style="width:96.5%;" value='<s:property value="jobnossss"/>'></td>
    <td width="21%" rowspan="2" align="center" ><input type="button" name="enqbtnrasearch" id="enqbtnrasearch" class="myButton" value="Search"  onclick="estloadSearch1()"></td>
    </tr>
    <tr>
    <td align="right">Date </td>
    <td align="left" ><div id="estmdates" name="estmdates"  value='<s:property value="estmdates"/>'></div>
    <td width="11%" align="right"  >Ref No.</td>
    <td ><input type="text" name="refnos" id="refnos" value='<s:property value="refnos"/>'></td>
   </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdiv">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>