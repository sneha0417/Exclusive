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
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
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
	
	function getDesignation() {
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
				$("select#cmbdesignation").html(optionsdesignation);
				
			} else {
			}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
	
	function getCategory() {
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
  				$("select#cmbcategory").html(optionspayrollcategory);
  				
  			} else {
  			}
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
    }
	
	function saveGridData(selecteddocs,selectedempid,uptodate,branchid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0){
					
					$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#txtselecteddocs').val('');$('#txtselectedempid').val('');
	  	 			$('#cmbdepartment').val('');$('#cmbdesignation').val('');$('#cmbcategory').val('');$('#txtemployeeid').val('');
	  	 			$('#txtemployeename').val('');$('#txtemployeedocno').val('');
	  	 			
	  	 			if (document.getElementById("txtemployeeid").value == "") {
	  	 		        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	  	 		        $('#txtemployeename').attr('placeholder', 'Employee Name');
	  	 		    }
	  	 			
					$.messager.alert('Message', '  Leave Confirmed ', function(r){
				    });
					funreload(event);
					 
			      
				} else {
					$.messager.alert('Message', '  Leave Not Confirmed ', function(r){
				    });
					$("#overlay, #PleaseWait").hide();
				} 
		  }
		}
			
	x.open("GET","saveData.jsp?selecteddocs="+selecteddocs+"&selectedempid="+selectedempid+"&uptodate="+uptodate+"&uptodate="+uptodate+"&branchid="+branchid,true);
	x.send();
	}

	function funConfirm() {
		
	    var temp1="",tempempid1="";
		var rows = $("#leaveAcceptanceDetailsGridID").jqxGrid('getrows');
		if(rows.length==1 && (rows[0].docno=="undefined" || rows[0].docno==null || rows[0].docno=="")){
			return false;
		}
		
		var selectedrows=$("#leaveAcceptanceDetailsGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Leaves to be Confirmed.');
			return false;
		}
		
		var i=0;var j=0;var k=0;var temp="",tempempid="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					if(k==0){
						temp=rows[i].docno;
						tempempid=rows[i].empdocno;
						k=1;
					}
					else{
						temp=temp+"::"+rows[i].docno;
						tempempid=tempempid+","+rows[i].empdocno;
					}
					temp1=temp+"::";
					tempempid1=tempempid+",";
					
				j++; 
			  }
            }
	    $('#txtselecteddocs').val(temp1);
	    $('#txtselectedempid').val(tempempid1);
	
	    $.messager.confirm('Confirm', 'Do you want to Confirm ?', function(r){
  	 		if (r){
  	 			  var selecteddocs = $('#txtselecteddocs').val();
  	 			  var selectedempid = $('#txtselectedempid').val();
  	 			  var uptodate = $('#uptodate').val();
  	 			  var branchid = $('#cmbbranch').val();
  	 			  
  	 			  $("#overlay, #PleaseWait").show();
  	 			
  	 			  saveGridData(selecteddocs,selectedempid,uptodate,branchid);
  	 	  }
  	  });  
		
	}
	
	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());
		$('#cmbdepartment').val('');$('#cmbdesignation').val('');$('#cmbcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		$("#leaveAcceptanceDetailsGridID").jqxGrid('clear');$("#leaveAcceptanceDetailsGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
		
	 }
	
	function funreload(event){
		 var branchval = $('#cmbbranch').val(); 
		 var uptodate = $('#uptodate').val();
		 var department = $('#cmbdepartment').val();
		 var designation = $('#cmbdesignation').val();
		 var category = $('#cmbcategory').val();
		 var employee = $('#txtemployeedocno').val();
		 
		 $("#overlay, #PleaseWait").show();
		 $('#txtselecteddocs').val('');$('#txtselectedempid').val('');
		 $("#leaveAcceptanceDiv").load("leaveAcceptanceGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1');
	}
	
	function funExportBtn(){
		  if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	  JSONToCSVCon(data, 'LeaveAcceptanceDetails', true);
		  } else {
			  $("#leaveAcceptanceDetailsGridID").jqxGrid('exportdata', 'xls', 'LeaveAcceptanceDetails');
		  }
	 }
		
</script>
</head>
<body onload="getBranch();getDepartment();getDesignation();getCategory();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td colspan="2">&nbsp;</td></tr>		
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr>
	 <tr><td align="right"><label class="branch">Department</label></td>
	 <td align="left"><select id="cmbdepartment" style="width:80%;" name="cmbdepartment"  value='<s:property value="cmbdepartment"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Designation</label></td>
	 <td align="left"><select id="cmbdesignation" style="width:80%;" name="cmbdesignation"  value='<s:property value="cmbdesignation"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td align="left"><select id="cmbcategory" style="width:80%;" name="cmbcategory"  value='<s:property value="cmbcategory"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Employee</label></td>
     <td align="left"><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
     <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
     <button class="myButton" type="button" id="btnConfirm" name="btnConfirm" onclick="funConfirm();">Confirm</button></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>		
     <tr><td colspan="2"><input type="hidden" name="txtselecteddocs" id="txtselecteddocs" style="width:100%;height:20px;" value='<s:property value="txtselecteddocs"/>'>
     <input type="hidden" name="txtselectedempid" id="txtselectedempid" style="width:100%;height:20px;" value='<s:property value="txtselectedempid"/>'></td></tr>
	 </table>
	 </fieldset>
</td>
<td width="80%">
<table width="100%">
		<tr>
			<td><div id="leaveAcceptanceDiv"><jsp:include page="leaveAcceptanceGrid.jsp"></jsp:include></div></td>
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
