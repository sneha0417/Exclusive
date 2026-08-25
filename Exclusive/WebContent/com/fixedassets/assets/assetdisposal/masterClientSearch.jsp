 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
  <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
	
	}); 


 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var docno=document.getElementById("searchdocno").value;
 		var name=document.getElementById("searchname").value;
 		var acno=document.getElementById("searchacno").value;
 		var mobile=document.getElementById("searchmobile").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		
		getdata(searchdate,docno,name,acno,mobile);
 

	}

	 function getdata(searchdate,docno,name,acno,mobile){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('clientSearch.jsp?searchdate='+searchdate+'&docno='+docno+'&name='+name+'&acno='+acno+'&mobile='+mobile+'&id=1');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
    <tr>
    <td width="12%" align="right">Doc No</td>
    <td width="14%" align="left"><input type="text" name="searchdocno" id="searchdocno"></td>
    <td width="7%" align="right">Date</td>
    <td width="13%" align="left"><div id="searchdate" name="searchdate"></div></td>
    <td width="13%" align="right">Mobile</td>
    <td width="15%" align="left"><input type="text" name="searchmobile" id="searchmobile" ></td>
    <td width="12%" align="right">&nbsp;</td>
    <td width="14%" align="left">&nbsp;</td>
    </tr>

  <tr>
    <td align="right">Name</td>
    <td colspan="3" align="left"><input type="text" name="searchname" id="searchname" style="width:99%;"></td>
    <td align="right">A/c No</td>
    <td align="left"><input type="text" name="searchacno" id="searchacno"></td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();"></td>
  </tr>
  <tr>
  <td colspan="8">
   <div id="srefreshdiv">
      
   <jsp:include page="clientSearch.jsp"></jsp:include> 
   
  </div>
  </td>
  </tr>
 </table>

   
</div>
</body>
</html>