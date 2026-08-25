 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 getStatus();
	
	}); 

 	function masterloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#msearchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("msearchfleetno").value;
 		var docno=document.getElementById("msearchdocno").value;
 		var regno=document.getElementById("msearchregno").value;
 		var status=document.getElementById("cmbsearchstatus").value;
	
 		
		getdata(reftype,reftype,searchdate,fleetno,docno,regno,status);
 

	}
	 function getStatus() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('***');
					var statusItems = items[0].split(",");
					var statusIdItems = items[1].split(",");
					var optionsstatus = '<option value="">--Select--</option>';
					for (var i = 0; i < statusItems.length; i++) {
						optionsstatus += '<option value="' + statusIdItems[i] + '">'
								+ statusItems[i] + '</option>';
					}
					$("select#cmbsearchrtype").html(optionsstatus);
					
					
				} else {
				}
			}
			x.open("GET", "getStatus.jsp", true);
			x.send();
		}
	 function getdata(reftype,reftype,searchdate,fleetno,docno,regno,status){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#mainrefreshdiv").load('subMainSearch.jsp?reftype='+reftype+'&msearchdate='+searchdate+'&mfleetno='+fleetno+'&mdocno='+docno+'&mregno='+regno+'&status='+status+'');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
 <table width="100%" >
  <tr>
    <td width="9%">Doc No</td>
    <td width="24%"><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td width="10%">Ref Type</td>
    <td width="24%"><select name="cmbsearchrtype" id="cmbsearchrtype" style="width:84%;"><option value="">--Select--</option></select></td>
    <td width="8%">Status</td>
    <td width="14%"><select name="cmbsearchstatus" id="cmbsearchstatus" style="width:99%;"><option value="">--Select--</option>
    <option value=1>IN</option><option value=0>OUT</option></select></td>
    <td width="11%" rowspan="2"><input type="button" name="btnmainSearchExt" id="btnmainSearchExt" class="myButton" value="Search" onclick="masterloadSearch();"></td>
  </tr>
  <tr>
    <td>Date</td>
    <td><div id="msearchdate" name="msearchdate"></div></td>
    <td>Fleet No</td>
    <td><input type="text" name="msearchfleetno" id="msearchfleetno" ></td>
    <td>Reg No</td>
    <td><input type="text" name="msearchregno" id="msearchregno"></td>
    </tr>
  <tr>
  <td colspan="7">
   <div id="mainrefreshdiv">
      
   <jsp:include  page="subMainSearch.jsp"></jsp:include> 
   
  </div>
  </td>
  </tr>
 </table>

   
</div>
</body>
</html>