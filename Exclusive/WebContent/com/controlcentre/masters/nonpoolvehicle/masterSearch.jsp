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
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		getGroup();
		getColor();
	
	}); 
function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#searchgroup").html(optionsgroup);
				
				
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#searchcolor").html(optionscolor);
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
		x.send();
	}
 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		var color=document.getElementById("searchcolor").value;
		var group=document.getElementById("searchgroup").value;
 		
		getdata(searchdate,fleetno,docno,regno,color,group);
 

	}

	 function getdata(searchdate,fleetno,docno,regno,color,group){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('nonPoolSearch.jsp?searchdate='+searchdate+'&fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&color='+color+'&group='+group);
		 

		  
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
    <td width="13%" align="right">Color</td>
    <td width="15%" align="left"><select name="searchcolor" id="searchcolor" ><option value="">--Select--</option></select></td>
    <td width="12%" align="right">&nbsp;</td>
    <td width="14%" align="left">&nbsp;</td>
    </tr>

  <tr>
    <td align="right">Fleet No</td>
    <td align="left"><input type="text" name="searchfleetno" id="searchfleetno" ></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="searchregno" id="searchregno"></td>
    <td align="right">Group</td>
    <td align="left"><select name="searchgroup" id="searchgroup" ><option value="">--Select--</option></select></td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();"></td>
  </tr>
  <tr>
  <td colspan="8">
   <div id="srefreshdiv">
      
   <jsp:include  page="nonPoolSearch.jsp"></jsp:include> 
   
  </div>
  </td>
  </tr>
 </table>

   
</div>
</body>
</html>