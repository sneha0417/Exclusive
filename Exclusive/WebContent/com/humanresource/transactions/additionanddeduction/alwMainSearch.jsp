 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#alwdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 getAlwYear();getAlwMonth();
	}); 
	
	function getAlwYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbalwyear").html(optionsyear);
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
	
	function getAlwMonth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var monthItems = items[0].split(",");
				var monthIdItems = items[1].split(",");
				var optionsmonth = '<option value="">--Select--</option>';
				for (var i = 0; i < monthItems.length; i++) {
					optionsmonth += '<option value="' + monthIdItems[i] + '">'
							+ monthItems[i] + '</option>';
				}
				$("select#cmbalwmonth").html(optionsmonth);
			} else {
			}
		}
		x.open("GET", "getMonth.jsp", true);
		x.send();
	}

 	function loadSearch() {

 		var date=document.getElementById("alwdate").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var year=document.getElementById("cmbalwyear").value;
 		var month=document.getElementById("cmbalwmonth").value;
 		var description=document.getElementById("txtalwdescription").value;
	
		getdata(date,docNo,year,month,description);
	}
 	
	function getdata(date,docNo,year,month,description){
		 $("#refreshdiv").load('alwMainSearchGrid.jsp?date='+date+'&docNo='+docNo+'&year='+year+'&month='+month+'&description='+description.replace(/ /g, "%20"));
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="15%"><div id="alwdate" name="alwdate"  value='<s:property value="alwdate"/>'></div>
        <input type="hidden" name="hidalwdate" id="hidalwdate" value='<s:property value="hidalwdate"/>'></td>
    <td width="9%" align="right">Doc No</td>
    <td width="12%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="10%" align="right">Year</td>
    <td width="29%"><select id="cmbalwyear" name="cmbalwyear" style="width:50%;" value='<s:property value="cmbalwyear"/>'>
    <option value="">--Select--</option></select></td>
    <td width="20%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Month</td>
    <td><select id="cmbalwmonth" name="cmbalwmonth" style="width:98%;"  value='<s:property value="cmbalwmonth"/>'>
      <option value="">--Select--</option></select></td>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" name="txtalwdescription" id="txtalwdescription" style="width:80%;" value='<s:property value="txtalwdescription"/>'></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include page="alwMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>