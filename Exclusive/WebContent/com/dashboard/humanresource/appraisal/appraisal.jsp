<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#employeeDetailsWindow').jqxWindow('close');
		 
 		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		 
		 $('#txtemployeeid').dblclick(function(){
	  			employeeSearchContent("employeeDetailsSearch.jsp");
			  });
		
	});
	

	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

    function getDepartment() {
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
				$("select#cmbempdepartment").html(optionsdepartment);
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
    function getYear() {
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
				$("select#cmbyear").html(optionsyear);
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
    
    function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
    
    function getAllowancesType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var allowancetypeItems = items[0].split(",");
				var allowancetypeIdItems = items[1].split(",");
				var optionsallowancetype = '<option value="">--Select--</option>';
				for (var i = 0; i < allowancetypeItems.length; i++) {
					optionsallowancetype += '<option value="' + allowancetypeIdItems[i] + '">'
							+ allowancetypeItems[i] + '</option>';
				}
				$("select#cmballowancetype").html(optionsallowancetype);
				
			} else {
			}
		}
		x.open("GET", "getAllowancesType.jsp", true);
		x.send();
	}
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }
    
    function funallowancestype() {
   	 var leavetype=$('#cmballowancetype').children("option").length;
		 for(var k=1 ; k <= leavetype ; k++){
			 $('#txtallowancetype'+k).val($('#cmballowancetype option').eq(k).text().trim());
		 } 
   }
    
    function funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#appraisalDetailsGridID").jqxGrid('clear');$("#appraisalDetailsGridID").jqxGrid('addrow', null, {});
	}
    
    function funClearYearInfo(){
		$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#appraisalDetailsGridID").jqxGrid('clear');$("#appraisalDetailsGridID").jqxGrid('addrow', null, {});
	}
	
	function funExportBtn(){
		//JSONToCSVCon(dataExcelExport, 'LeaveDetails', true);
	} 
	
	function funreload(event){
		 var year=$('#cmbyear').val();
		 var month=$('#cmbmonth').val();
		 var department=$('#cmbempdepartment').val();
		 var category=$('#cmbempcategory').val();
		 var empId=$('#txtemployeedocno').val();
		 if(year==''){
			 $.messager.alert('Message','Year is Mandatory.','warning');
			 return 0;
		 }
		 
		 funallowancestype();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#appraisalDiv").load("appraisalGrid.jsp?year="+year+"&month="+month+"&department="+department+"&category="+category+"&empId="+empId+"&check=1");
	}
	
</script>
</head>
<body onload="getBranch();getYear();getDepartment();getPayrollCategory();getAllowancesType();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Year</label></td>
     <td align="left"><select name="cmbyear" id="cmbyear" style="width:40%;" onchange="funClearYearInfo();" value='<s:property value="cmbyear"/>'></select></td></tr> 
	<tr><td align="right"><label class="branch">Month</label></td>
	<td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
     		<option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      		<option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
     		<option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      		<option value="12">December</option></select></td></tr>
    <tr><td align="right"><label class="branch">Department</label></td>
	<td align="left"><select id="cmbempdepartment" name="cmbempdepartment" style="width:80%;" value='<s:property value="cmbempdepartment"/>'>
        <option value="">--Select--</option></select></td></tr> 
	<tr><td align="right"><label class="branch">Category</label></td>
	<td><select id="cmbempcategory" name="cmbempcategory" style="width:80%;" value='<s:property value="cmbempcategory"/>'>
      <option value="">--Select--</option></select></td></tr> 
	<tr><td align="right"><label class="branch">Employee</label></td>
	<td><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
       <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td></tr>
	<tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" style="width:95%;height:20;" placeholder="Employee Name" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><select id="cmballowancetype" hidden="true" name="cmballowancetype" style="width:80%;" value='<s:property value="cmballowancetype"/>'>
      <option value="">--Select--</option></select>
	 <input type="hidden" id="txtallowancetype1" name="txtallowancetype1" value='<s:property value="txtallowancetype1"/>'/>
	 <input type="hidden" id="txtallowancetype2" name="txtallowancetype2" value='<s:property value="txtallowancetype2"/>'/>
	 <input type="hidden" id="txtallowancetype3" name="txtallowancetype3" value='<s:property value="txtallowancetype3"/>'/>
	 <input type="hidden" id="txtallowancetype4" name="txtallowancetype4" value='<s:property value="txtallowancetype4"/>'/>
	 <input type="hidden" id="txtallowancetype5" name="txtallowancetype5" value='<s:property value="txtallowancetype5"/>'/>
	 <input type="hidden" id="txtallowancetype6" name="txtallowancetype6" value='<s:property value="txtallowancetype6"/>'/>
	 <input type="hidden" id="txtallowancetype7" name="txtallowancetype7" value='<s:property value="txtallowancetype7"/>'/>
	 <input type="hidden" id="txtallowancetype8" name="txtallowancetype8" value='<s:property value="txtallowancetype8"/>'/>
	 <input type="hidden" id="txtallowancetype9" name="txtallowancetype9" value='<s:property value="txtallowancetype9"/>'/>
	 <input type="hidden" id="txtallowancetype10" name="txtallowancetype10" value='<s:property value="txtallowancetype10"/>'/>
	 </td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="appraisalDiv"><jsp:include page="appraisalGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="employeeDetailsWindow">
	<div></div>
</div>
</div> 
</body>
</html>