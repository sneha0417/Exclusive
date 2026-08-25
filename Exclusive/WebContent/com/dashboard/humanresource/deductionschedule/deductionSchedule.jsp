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
		 document.getElementById("rdsummary").checked=true;
		 $("#leaveDetailsDetailedDiv").prop("hidden", true); 
		 $('#cmbleavetype').attr('disabled', true );
			
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
    
    function getLeaveType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var leavetypeItems = items[0].split(",");
				var leavetypeIdItems = items[1].split(",");
				var optionsleavetype = '<option value="">--Select--</option>';
				for (var i = 0; i < leavetypeItems.length; i++) {
					optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
							+ leavetypeItems[i] + '</option>';
				}
				$("select#cmbleavetype").html(optionsleavetype);
				
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }
    
    function funleavestype() {
    	 var leavetype=$('#cmbleavetype').children("option").length;
		 for(var k=1 ; k <= leavetype ; k++){
			 $('#txtleavename'+k).val($('#cmbleavetype option').eq(k).text().trim());
		 } 
    }
    
    function funGridHide(){
		if(document.getElementById("rdsummary").checked==true){
       	 	$("#leaveDetailsDetailedDiv").prop("hidden", true); 
       	 	$("#leaveDetailsDiv").prop("hidden", false);
			$('#cmbleavetype').attr('disabled', true );
			$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
			$("#leaveDetailsDetailedGridID").jqxGrid('clear');$("#leaveDetailsDetailedGridID").jqxGrid('addrow', null, {});
        
	    } else if(document.getElementById("rddetailed").checked==true){
       	    $("#leaveDetailsDiv").prop("hidden", true);
       	    $("#leaveDetailsDetailedDiv").prop("hidden", false);
			$('#cmbleavetype').attr('disabled', false );
			$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
			$("#leaveDetailsDetailedGridID").jqxGrid('clear');$("#leaveDetailsDetailedGridID").jqxGrid('addrow', null, {});
        }
	 }
    
    function funClearInfo(){
    	$('#cmbtype').val('');
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
		
		document.getElementById("rdsummary").checked=true;
		funGridHide();
	}
    
    function funClearYearInfo(){
		$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
		
		document.getElementById("rdsummary").checked=true;
		funGridHide();
	}
	
	function funExportBtn(){
		if(document.getElementById("rdsummary").checked==true){
			JSONToCSVCon(dataExcelExport, 'Deduction Schedule Summary', true);
		} else if(document.getElementById("rddetailed").checked==true){
			JSONToCSVCon(dataExcelExport1, 'Deduction Schedule Detail', true);
		}
	} 
	
	 
	
	
	
	
	function funreload(event){
		/*  var year=$('#cmbyear').val();
		 var month=$('#cmbmonth').val();
		 var department=$('#cmbempdepartment').val();
		 var category=$('#cmbempcategory').val(); */
		 var empId=$('#txtemployeedocno').val();
		 var cmbtype=$('#cmbtype').val();
		 
		 
		 /*  alert(empId);
		 
		 alert(cmbtype);  */
		 
		// funleavestype();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	$("#leaveDetailsDiv").load("deductionScheduleGrid.jsp?cmbtype="+cmbtype+"&empId="+empId+"&check=1");
		 } else if(document.getElementById("rddetailed").checked==true){
			// var leavetype=$('#cmbleavetype').val();
			 $("#leaveDetailsDetailedDiv").load("deductionScheduleDetailedGrid.jsp?cmbtype="+cmbtype+"&empId="+empId+"&check=1"); 
		 }
	}
	
</script>
</head>
<body onload="getBranch();getYear();getDepartment();getPayrollCategory();getLeaveType();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	 <tr><td colspan="2">&nbsp;</td></tr>
     <%-- <tr><td align="right"><label class="branch">Year</label></td>
		 <td align="left"><select name="cmbyear" id="cmbyear" style="width:40%;" onchange="funClearYearInfo();" value='<s:property value="cmbyear"/>'></select></td></tr> --%>
	<%-- <tr>
    	<td align="right"><label class="branch">Month</label></td>
    	<td><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
     		<option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      		<option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
     		<option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      		<option value="12">December</option></select></td>
   </tr><tr> --%>
      <%-- <td align="right"><label class="branch">Department</label></td>
      <td><select id="cmbempdepartment" name="cmbempdepartment" style="width:80%;" value='<s:property value="cmbempdepartment"/>'>
        <option value="">--Select--</option></select></td>
    </tr>
    <tr>
      <td align="right"><label class="branch">Category</label></td>
      <td><select id="cmbempcategory" name="cmbempcategory" style="width:80%;" value='<s:property value="cmbempcategory"/>'>
      <option value="">--Select--</option></select></td>
     </tr>
     <tr>
      <td align="right"><label class="branch">Leaves</label></td>
      <td><select id="cmbleavetype" name="cmbleavetype" style="width:80%;" value='<s:property value="cmbleavetype"/>'>
      <option value="">--Select--</option></select></td>
     </tr> --%>
     
     
     
     <tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="all" selected>All</option><option value="posted">Posted</option><option value="notposted">Not Posted</option></select></td></tr>
     
     
     
     
     
     <tr>
       <td align="right"> <label class="branch">Employee</label></td>
       <td ><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
       <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
     </tr> 
     <tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" style="width:95%;height:20;" placeholder="Employee Name" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>
     <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdsummary" name="rdo" onchange="funGridHide();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       <td width="52%" align="center"><input type="radio" id="rddetailed" name="rdo" onchange="funGridHide();" value="rddetailed"><label for="rddetailed" class="branch">Detailed</label></td>
       </tr>
       </table>
	  </fieldset>
	 </td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	 <input type="hidden" id="txtleavename1" name="txtleavename1" value='<s:property value="txtleavename1"/>'/>
	 <input type="hidden" id="txtleavename2" name="txtleavename2" value='<s:property value="txtleavename2"/>'/>
	 <input type="hidden" id="txtleavename3" name="txtleavename3" value='<s:property value="txtleavename3"/>'/>
	 <input type="hidden" id="txtleavename4" name="txtleavename4" value='<s:property value="txtleavename4"/>'/>
	 <input type="hidden" id="txtleavename5" name="txtleavename5" value='<s:property value="txtleavename5"/>'/>
	 <input type="hidden" id="txtleavename6" name="txtleavename6" value='<s:property value="txtleavename6"/>'/>
	 <input type="hidden" id="txtleavename7" name="txtleavename7" value='<s:property value="txtleavename7"/>'/>
	 <input type="hidden" id="txtleavename8" name="txtleavename8" value='<s:property value="txtleavename8"/>'/>
	 <input type="hidden" id="txtleavename9" name="txtleavename9" value='<s:property value="txtleavename9"/>'/>
	 <input type="hidden" id="txtleavename10" name="txtleavename10" value='<s:property value="txtleavename10"/>'/>
	 
	 </td></tr>
  </table>
</fieldset>

</td>
<td width="80%">
	<table width="100%">
		 <tr><td><div id="leaveDetailsDiv"><jsp:include page="deductionScheduleGrid.jsp"></jsp:include></div>
		 <div id="leaveDetailsDetailedDiv"><jsp:include page="deductionScheduleDetailedGrid.jsp"></jsp:include></div></td></tr> 
	</table>
</td></tr></table>
</div>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>
