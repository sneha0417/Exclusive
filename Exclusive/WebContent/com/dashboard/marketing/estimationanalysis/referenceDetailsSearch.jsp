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
<% String reftype1 = request.getParameter("reftype")==null?"0":request.getParameter("reftype"); %>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	var reftype="<%=reftype1%>";
	$(document).ready(function () {
		
	  $("#enqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	
	}); 

 	function enqloadSearch1() {
 		
 		var enqdate=document.getElementById("enqdate").value;
 		var Cl_namess=document.getElementById("Cl_names").value;
 		var Cl_mobno=document.getElementById("Cl_mobno").value;
 		var msdocno=document.getElementById("msdocnos").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		var clientid=document.getElementById("txtclientdocno").value;

 		getdata1(Cl_names,msdocno,Cl_mobno,enqdate,clientid);

	}
 	
	function getdata1(Cl_names,msdocno,Cl_mobno,enqdate,clientid){
		
			var id=1;
		
		 	$("#refreshdivmas").load('referenceDetailsSearchGrid.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&Cl_mobno='+Cl_mobno+'&enqdate='+enqdate+'&clientid='+clientid+'&id='+id+'&reftype='+reftype);
		
	}

</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right" style="font-size:9px;">Docno</td>
    <td width="15%"><input type="text" name="msdocnos" id="msdocnos" style="height:20px;" value='<s:property value="msdocnos"/>'></td>
    <td width="10%" align="right" style="font-size:9px;">MOB</td>
    <td width="46%"><input type="text" name="Cl_mobno" id="Cl_mobno"  style="width:85%;height:20px;" value='<s:property value="Cl_mobno"/>'></td>
    <td width="7%" align="right" style="font-size:9px;">Date</td>
    <td width="14%"><div id="enqdate" name="enqdate" value='<s:property value="enqdate"/>'></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Client</td>
    <td colspan="3"><input type="text" name="Cl_names" id="Cl_names"  style="width:85%;height:20px;" value='<s:property value="Cl_names"/>'></td>
    <td colspan="2" align="center"><input type="button" name="enqbtnrasearch" id="enqbtnrasearch" class="myButton" value="Search"  onclick="enqloadSearch1()"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdivmas"><jsp:include  page="referenceDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>