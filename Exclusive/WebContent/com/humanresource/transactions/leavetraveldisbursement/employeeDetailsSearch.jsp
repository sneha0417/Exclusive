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
	 $("#txtdoj").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 getEmpDesignation();getEmpDepartment();
	}); 

	function getEmpDesignation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var designationItems = items[0].split(",");
				var designationIdItems = items[1].split(",");
				var optionsdesignation = '<option value="">--Select--</option>';
				for (var i = 0; i < designationItems.length; i++) {
					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
							+ designationItems[i] + '</option>';
				}
				$("select#employeedesignation").html(optionsdesignation);
			} else {}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
  
  	function getEmpDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#employeedepartment").html(optionsdepartment);
			} else {}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
  
 	function loadSearch() {
 		
 		var empname=document.getElementById("txtempname").value;
 		var mob=document.getElementById("txtmobile").value;
 		var employeedesignation=document.getElementById("employeedesignation").value;
 		var employeedepartment=document.getElementById("employeedepartment").value;
 		var empid=document.getElementById("txtempid").value;
 		var doj=document.getElementById("txtdoj").value;
        var check = 1;
        
 		getdata(empname,mob,employeedesignation,employeedepartment,empid,doj,check);
	}
 	
	function getdata(empname,mob,employeedesignation,employeedepartment,empid,doj,check){
		
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&mob='+mob+'&employeedesignation='+employeedesignation+'&employeedepartment='+employeedepartment+'&empid='+empid+'&doj='+doj+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtempname" id="txtempname" style="width:96%" value='<s:property value="txtempname"/>'></td>
    <td width="8%" align="right">Mob</td>
    <td colspan="2"><input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'></td>
    <td width="15%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Designation</td>
    <td width="15%"><select id="employeedesignation" name="employeedesignation" style="width:96%;" value='<s:property value="employeedesignation"/>'>
      <option value="">--Select--</option></select></td>
    <td width="10%" align="right">Department</td>
    <td width="19%"><select id="employeedepartment" name="employeedepartment" style="width:96%;" value='<s:property value="employeedepartment"/>'>
      <option value="">--Select--</option></select></td>
    <td width="8%" align="right">Emp#</td>
    <td width="14%"><input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'></td>
    <td width="12%" align="right">Date of Join</td>
    <td><div id="txtdoj" name="txtdoj"  value='<s:property value="txtdoj"/>'></div></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="employeeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>