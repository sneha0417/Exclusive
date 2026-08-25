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

.mySaveButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77d42a), color-stop(1, #5cb811));
	background:-moz-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-webkit-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-o-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-ms-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:linear-gradient(to bottom, #77d42a 5%, #5cb811 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77d42a', endColorstr='#5cb811',GradientType=0);
	background-color:#77d42a;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #268a16;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px -1px 0px #aade7c;
}
.mySaveButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cb811), color-stop(1, #77d42a));
	background:-moz-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-webkit-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-o-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-ms-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:linear-gradient(to bottom, #5cb811 5%, #77d42a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cb811', endColorstr='#77d42a',GradientType=0);
	background-color:#5cb811;
}
.mySaveButton:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
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
	
	function getDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartments = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartments += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbdepartment").html(optionsdepartments);
				
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		$('#txtemployeeids').val('');$('#cmbempcategory').val('');$('#cmbdepartment').val('');
		$('#msg').val('');$('#mode').val('');$('#gridlength').val('');
		$("#openingDetailsGridID").jqxGrid('clear');$("#openingDetailsGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
		
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var category = $('#cmbempcategory').val();
		 var department = $('#cmbdepartment').val();
		 var employee = $('#txtemployeedocno').val();
		 $('#txtemployeeids').val('');$('#msg').val('');$('#mode').val('');$('#gridlength').val('');
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#openingBalanceDetailsDiv").load("openingBalanceGrid.jsp?category="+category+'&department='+department+'&employee='+employee+'&check=1');
	}
	
	function funNotify(){	
    	
		  var employeeids = $('#txtemployeeids').val();
		  if(employeeids.trim()==''){
			 $.messager.alert('Message','Change Opening For Some Employee(s) Before Saving.','warning');
			 return;
		  }
 		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Opening Balance Grid  Saving*/
  			 	var rows = $("#openingDetailsGridID").jqxGrid('getrows');
  			 	var length=0;
  					 for(var i=0 ; i < rows.length ; i++){
  						var chk=rows[i].tobesaved;
  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  							newTextBox = $(document.createElement("input"))
  						    .attr("type", "dil")
  						    .attr("id", "test"+length)
  						    .attr("name", "test"+length)
  							.attr("hidden", "true");
  							length=length+1;
  								
  				    newTextBox.val(rows[i].empdocno+"::"+rows[i].empacno+":: "+rows[i].terminationbenefits+":: "+rows[i].leavesalary+":: "+rows[i].travels);
  				    newTextBox.appendTo('form');
  				 }
  				}
  	 		 	$('#gridlength').val(length);
  			 	/* Opening Balance Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardOpening").submit();
			 
	 		 }
	 		});
		 
  		return 1;
	}
	
	function setValues(){
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 funreload(event);
		 }
	}
	
	function funExportBtn(){
		JSONToCSVCon(data, 'OpeningBalance', true);
	} 
	
</script>
</head>
<body onload="getBranch();setValues();getPayrollCategory();getDepartment();">
<form id="frmDashboardOpening" action="saveDashboardOpening" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td colspan="2">&nbsp;</td></tr>		
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td align="left"><select id="cmbempcategory" style="width:80%;" name="cmbempcategory"  value='<s:property value="cmbempcategory"/>'></select>
	 <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Department</label></td>
	 <td align="left"><select id="cmbdepartment" style="width:80%;" name="cmbdepartment"  value='<s:property value="cmbdepartment"/>'></select>
	 <input type="hidden" id="hidcmbdepartment" name="hidcmbdepartment" value='<s:property value="hidcmbdepartment"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Employee</label></td>
     <td align="left"><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
     <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <input type="button" class="mySaveButton" id="btnSaveOpening" name="btnSaveOpening" value="Save" onclick="funNotify();"></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>		
     <tr><td colspan="2">&nbsp;</td></tr>
	 </table>
	 </fieldset>
</td>
<td width="80%">
<table width="100%">
		<tr>
			<td><div id="openingBalanceDetailsDiv"><jsp:include page="openingBalanceGrid.jsp"></jsp:include></div></td>
		</tr>
</table>
</tr>
</table>
<input type="hidden" id="txtemployeeids" name="txtemployeeids" style="width:100%;height:20px;" value='<s:property value="txtemployeeids"/>'/>
<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
<input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
</div>
<div id="employeeDetailsWindow">
   <div></div>
</div>
</div> 
</form>
</body>
