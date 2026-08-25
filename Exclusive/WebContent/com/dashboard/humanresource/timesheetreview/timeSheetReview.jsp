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

.myConfirmButton {
	-moz-box-shadow: 0px 1px 0px 0px #fff6af;
	-webkit-box-shadow: 0px 1px 0px 0px #fff6af;
	box-shadow: 0px 1px 0px 0px #fff6af;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffec64), color-stop(1, #ffab23));
	background:-moz-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-webkit-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-o-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-ms-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:linear-gradient(to bottom, #ffec64 5%, #ffab23 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffec64', endColorstr='#ffab23',GradientType=0);
	background-color:#ffec64;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #ffaa22;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffee66;
}
.myConfirmButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffab23), color-stop(1, #ffec64));
	background:-moz-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-webkit-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-o-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-ms-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:linear-gradient(to bottom, #ffab23 5%, #ffec64 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffab23', endColorstr='#ffec64',GradientType=0);
	background-color:#ffab23;
}
.myConfirmButton:active {
	position:relative;
	top:1px;
}

.myButtonReCheck {
	-moz-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	-webkit-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	box-shadow:inset 0px 1px 0px 0px #3dc21b;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #44c767), color-stop(1, #5cbf2a));
	background:-moz-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-webkit-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-o-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-ms-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#44c767', endColorstr='#5cbf2a',GradientType=0);
	background-color:#44c767;
	-moz-border-radius:42px;
	-webkit-border-radius:42px;
	border-radius:42px;
	border:6px solid #18ab29;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:10px;
	font-weight:bold;
	padding:3px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.myButtonReCheck:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cbf2a), color-stop(1, #44c767));
	background:-moz-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-webkit-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-o-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-ms-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:linear-gradient(to bottom, #5cbf2a 5%, #44c767 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cbf2a', endColorstr='#44c767',GradientType=0);
	background-color:#5cbf2a;
}
.myButtonReCheck:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $('#branchlabel').hide();$('#branchdiv').hide();
		 
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true, value: null});
		
     	 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost ID Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#txtemployeeid').dblclick(function(){
			 $('#txtorgridclick').val('1');
		  	 employeeSearchContent("employeeDetailsSearch.jsp");
	     });
		 
		 $('#txtprojecttype').dblclick(function(){
			 $('#txtorgridclick').val('1');
			 costTypeSearchContent("costTypeSearchGrid.jsp");
	     });
		 
		 $('#txtprojectidname').dblclick(function(){
			 if($('#txtprojecttypeid').val()==''){
	   			 	$.messager.alert('Message','Cost Type is Mandatory.','warning');
	   			 	return 0;
	   		 }
			 $('#txtorgridclick').val('1');
			 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtprojecttypeid').val());
	     });
		 
		 document.getElementById("rdsummary").checked=true;reportTypeChange();
		 document.getElementById("chckorderbydate").checked=true;document.getElementById("hidchckorderbydate").value = 1;
		 $('#chckorderbydate').attr('disabled', true);
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
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
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						funreload(event);
					  }
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
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	 $('#txtorgridclick').val('1');
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
	 }
	 
	 function getProjectType(event){
	        var x= event.keyCode;
	        if(x==114){
	        	 $('#txtorgridclick').val('1');
				costTypeSearchContent("costTypeSearchGrid.jsp");
	        }
	        else{}
		 }
	 
	 function getProjectId(event){
	        var x= event.keyCode;
	        if(x==114){
	        	if($('#txtprojecttypeid').val()==''){
	   			 	$.messager.alert('Message','Cost Type is Mandatory.','warning');
	   			 	return 0;
	   		     }
	        	 $('#txtorgridclick').val('1');
				 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtprojecttypeid').val());
	        }
	        else{}
		 }

	 function orderbycheck(){
		 if(document.getElementById("chckorderbydate").checked==true){
			 document.getElementById("hidchckorderbydate").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbydate").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbyemployee").checked==true){
			 document.getElementById("hidchckorderbyemployee").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbyemployee").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbycosttype").checked==true){
			 document.getElementById("hidchckorderbycosttype").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbycosttype").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbycostid").checked==true){
			 document.getElementById("hidchckorderbycostid").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbycostid").value = 0;
		 }
	 }
	 
	 function  funClearInfo(){
			$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#cmbempcategory').val('');
			$('#date').val(null);$('#hiddate').val('');$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		    $('#txtprojecttype').val('');$('#txtprojecttypeid').val('');$('#txtprojectidname').val('');$('#txtprojectid').val('');
		    document.getElementById("rdsummary").checked=true;document.getElementById("chckorderbydate").checked=true;document.getElementById("hidchckorderbydate").value = 1;
			document.getElementById("chckorderbyemployee").checked=false;document.getElementById("hidchckorderbyemployee").value = 0;document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;document.getElementById("chckorderbycostid").checked=false;document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbydate').attr('disabled', true);reportTypeChange();
		    $("#timeSheetReviewGridID").jqxGrid('clear');$("#timeSheetReviewGridID").jqxGrid('addrow', null, {});
		    
		    if (document.getElementById("txtemployeeid").value == "") {
		        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
		        $('#txtemployeename').attr('placeholder', 'Employee Name');
		    }
		    
		    if (document.getElementById("txtprojecttype").value == "") {
		        $('#txtprojecttype').attr('placeholder', 'Press F3 to Search'); 
		    }
		    
		    if (document.getElementById("txtprojectidname").value == "") {
		        $('#txtprojectidname').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		 }
	
	function funreload(event){
		 //var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var date = $('#date').val();
		 var category = $('#cmbempcategory').val();
		 var employee = $('#txtemployeedocno').val();
		 var projecttype = $('#txtprojecttypeid').val();
		 var projectid = $('#txtprojectid').val();
		 var orderbydate = $('#hidchckorderbydate').val();
		 var orderbyemployee = $('#hidchckorderbyemployee').val();
		 var orderbycosttype = $('#hidchckorderbycosttype').val();
		 var orderbycostid = $('#hidchckorderbycostid').val();
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	 $("#timeSheetReviewDetailsDiv").load("timeSheetReviewGrid.jsp?rpttype=1&year="+year+'&month='+month+'&date='+date+'&category='+category+'&employee='+employee+'&projecttype='+projecttype+'&projectid='+projectid+'&orderbydate='+orderbydate+'&orderbyemployee='+orderbyemployee+'&orderbycosttype='+orderbycosttype+'&orderbycostid='+orderbycostid+'&check=1');
		 } else {
			 $("#timeSheetReviewDetailsDiv").load("timeSheetReviewGrid.jsp?rpttype=2&year="+year+'&month='+month+'&date='+date+'&category='+category+'&employee='+employee+'&projecttype='+projecttype+'&projectid='+projectid+'&orderbydate='+orderbydate+'&orderbyemployee='+orderbyemployee+'&orderbycosttype='+orderbycosttype+'&orderbycostid='+orderbycostid+'&check=1');
		 }
	}
	
	function saveGridData(date,empdocno,costtype,costcode,normalhrs,overtimehrs,holidayovertimehrs,rowno,intime,outtime,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='E') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} else if($('#mode').val()=='D') {
					$.messager.alert('Message', '  Record Successfully Deleted ', function(r){
				    });
				}
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?date="+date+"&empdocno="+empdocno+"&costtype="+costtype+"&costcode="+costcode+"&normalhrs="+normalhrs+"&overtimehrs="+overtimehrs+"&holidayovertimehrs="+holidayovertimehrs+"&rowno="+rowno+"&mode="+mode+"&intime="+intime+"&outtime="+outtime,true);
	x.send();
	}
	
	function recheckGridData(year,month,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='A') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} 
				
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveDataReCheck.jsp?year="+year+"&month="+month+"&mode="+mode,true);
	x.send();
	}
	
	
	
	function funExportBtn(){
		JSONToCSVCon(data1, 'TimeSheetReview', true);
	} 
	
	function funRestrictDate(){
		  var date = $('#date').jqxDateTimeInput('val');
		  
		  if(date!=''){
			  if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
					 $.messager.alert('Message','Year and Month are Mandatory.','warning');
					 $("#date").jqxDateTimeInput('val', null);
		             return 0;
			  }
		  }
		  var day = date.split(".");
		  var restrictedDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),day[0]));
		  $("#date").jqxDateTimeInput('val', restrictedDate);
	}
	
	function funChangeDate(){
		$("#date").jqxDateTimeInput('val', null);
	}
	
	function reportTypeChange(){
		if(document.getElementById("rdsummary").checked==true){
			$('#txtprojecttype').attr('disabled', true);
			$('#txtprojectidname').attr('disabled', true);
			$('#btnRecheck').attr('disabled', false);
			$('#btnConfirmed').attr('disabled', false);
			$('#btnUnConfirmed').attr('disabled', false);
			document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;
			$('#chckorderbycosttype').attr('disabled', true);
			document.getElementById("chckorderbycostid").checked=false;
			document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbycostid').attr('disabled', true);
			$('#txtprojecttype').val('');$('#txtprojecttypeid').val('');$('#txtprojectidname').val('');$('#txtprojectid').val('');
			if (document.getElementById("txtprojecttype").value == "") {
		        $('#txtprojecttype').attr('placeholder', 'Press F3 to Search'); 
		    }
		    
		    if (document.getElementById("txtprojectidname").value == "") {
		        $('#txtprojectidname').attr('placeholder', 'Press F3 to Search'); 
		    }
		} else {
			$('#txtprojecttype').attr('disabled', false);
			$('#txtprojectidname').attr('disabled', false);
			$('#btnRecheck').attr('disabled', true);
			$('#btnConfirmed').attr('disabled', true);
			$('#btnUnConfirmed').attr('disabled', true);
			document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;
			$('#chckorderbycosttype').attr('disabled', false);
			document.getElementById("chckorderbycostid").checked=false;
			document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbycostid').attr('disabled', false);
		}
	}
	
	function funReCheck(){
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
            return 0;
	    }
		
		$.messager.confirm('Confirm', 'Do you want to Re-Check?', function(r){
				if (r){
					 $('#mode').val('A');
					 var year = $('#cmbyear').val();
					 var month = $('#cmbmonth').val();
	     		 	 var mode = $('#mode').val();
	     		 
	     		 	 $("#overlay, #PleaseWait").show();
	     		     recheckGridData(year,month,mode);	
				   }
			});
	}
	
	function funUnconfirm(){
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
            return 0;
	    }
		
		$.messager.confirm('Confirm', 'Do you want to Un-Confirm?', function(r){
				if (r){
					 $('#mode').val('A');
					 var year = $('#cmbyear').val();
					 var month = $('#cmbmonth').val();
	     		 	 var mode = $('#mode').val();
	     		 
	     		 	 $("#overlay, #PleaseWait").show();
	     		 	 unConfirmData(year,month,mode);	
				   }
			});
	}
	
	function unConfirmData(year,month,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='A') {
					if(items==0){
						$.messager.alert('Message', '  Record Successfully Unconfirmed ', function(r){});
					}else if(items==1){
						$.messager.alert('Message', '  Record Not Updated ', function(r){});
					}else if(items==2){
						$.messager.alert('Message', '  Record Not Updated, Payroll Processed Already ', function(r){});
					}
					
				} 
				
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","unConfirmData.jsp?year="+year+"&month="+month+"&mode="+mode,true);
	x.send();
	}
	
	
	function funNotify(){
		
		var gridrows = $("#timeSheetReviewGridID").jqxGrid('getrows');
		if(parseInt($('#txtgridconfirmed').val())==gridrows.length){
		 	$.messager.alert('Message','Already Confirmed.','warning');
		 	return 0;
		 }
		
		if(parseInt($('#txtgridconfirm').val())!=0){
		 	$.messager.alert('Message','Time Sheet should be Entered for All Employees.','warning');
		 	return 0;
		 }
		
		$.messager.confirm('Confirm', 'Do you want to Confirm?', function(r){
	 		if (r){
	 				
	 			/* Summary Grid Confirming*/
  			 	var rows = $("#timeSheetReviewGridID").jqxGrid('getrows');
  			 	var length=0;
  					 for(var i=0 ; i < rows.length ; i++){
  						var chk=rows[i].empdocno;
  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  							newTextBox = $(document.createElement("input"))
  						    .attr("type", "dil")
  						    .attr("id", "test"+length)
  						    .attr("name", "test"+length)
  							.attr("hidden", "true");
  							length=length+1;
  								
  					newTextBox.val(rows[i].empdocno+"::"+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "date")+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "hrs")+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "othrs")+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "hothrs"));
  				    newTextBox.appendTo('form');
  				 }
  				}
  	 		 	$('#gridlength').val(length);
  			 	/* Summary Grid Confirming Ends*/
	 		
			 $('#mode').val('E');
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardTimeSheetReview").submit();
			 
	 		 }
	 		});
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#mode').val('');$('#gridlength').val('');
			 funreload(event);
		 }
	}
	function funExportBtn(){
		JSONToCSVCon(tsexceldata, 'Time Sheet Review', true);
		 }
	
</script>
</head>
<body onload="getBranch();setValues();getYear();getPayrollCategory();orderbycheck();">
<form id="frmDashboardTimeSheetReview" action="saveDashboardTimeSheetReview" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td align="right"><label class="branch">Year</label></td>
     <td align="left"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Month</label></td>
     <td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" onchange="funRestrictDate();" value='<s:property value="date"/>'></div>
     <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td align="left"><select id="cmbempcategory" style="width:80%;" name="cmbempcategory"  value='<s:property value="cmbempcategory"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Employee</label></td>
     <td align="left"><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
     <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Cost_Type</label></td>
     <td align="left"><input type="text" id="txtprojecttype" name="txtprojecttype" style="width:95%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtprojecttype"/>' onkeydown="getProjectType(event);"/>
     <input type="hidden" id="txtprojecttypeid" name="txtprojecttypeid" value='<s:property value="txtprojecttypeid"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Cost_Id</label></td>
     <td align="left"><input type="text" id="txtprojectidname" name="txtprojectidname" style="width:95%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtprojectidname"/>' onkeydown="getProjectId(event);"/>
     <input type="hidden" id="txtprojectid" name="txtprojectid" value='<s:property value="txtprojectid"/>'/></td></tr>
     <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdsummary" name="rdo" onchange="reportTypeChange();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       <td width="52%" align="center"><input type="radio" id="rddetailed" name="rdo" onchange="reportTypeChange();" value="rddetailed"><label for="rddetailed" class="branch">Detail</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Order by</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="checkbox" id="chckorderbydate" name="chckorderbydate" value="" onchange="orderbycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Date</label> 
                                 <input type="hidden" id="hidchckorderbydate" name="hidchckorderbydate" value='<s:property value="hidchckorderbydate"/>'/></td>
       <td width="52%" align="center"><input type="checkbox" id="chckorderbyemployee" name="chckorderbyemployee" value="" onchange="orderbycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Employee</label> 
                                 <input type="hidden" id="hidchckorderbyemployee" name="hidchckorderbyemployee" value='<s:property value="hidchckorderbyemployee"/>'/></td>
       </tr>
       
       <tr>
       <td align="center"><input type="checkbox" id="chckorderbycosttype" name="chckorderbycosttype" value="" onchange="orderbycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Cost_Type</label> 
                                 <input type="hidden" id="hidchckorderbycosttype" name="hidchckorderbycosttype" value='<s:property value="hidchckorderbycosttype"/>'/></td>
       <td align="center"><input type="checkbox" id="chckorderbycostid" name="chckorderbycostid" value="" onchange="orderbycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Cost_Id</label> 
                                 <input type="hidden" id="hidchckorderbycostid" name="hidchckorderbycostid" value='<s:property value="hidchckorderbycostid"/>'/></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <input type="button" class="myButtonReCheck" name="btnRecheck" id="btnRecheck"  value="Re-Check" onclick="funReCheck();"></td></tr>
	 <tr><td colspan="2" align="center">
	 	<input type="button" class="myConfirmButton" id="btnConfirmed" name="btnConfirmed" value="Confirm" onclick="funNotify();">
	    <input type="button" class="myConfirmButton" id="btnUnConfirmed" name="btnUnConfirmed" value="Un-Confirm" onclick="funUnconfirm();">
	 </td></tr>
     <tr><td colspan="2">&nbsp;<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
     <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
     <input type="hidden" name="txtorgridclick" id="txtorgridclick" style="width:100%;height:20px;" value='<s:property value="txtorgridclick"/>'>
     <input type="hidden" name="txtgridconfirm" id="txtgridconfirm" style="width:100%;height:20px;" value='<s:property value="txtgridconfirm"/>'>
     <input type="hidden" name="txtgridconfirmed" id="txtgridconfirmed" style="width:100%;height:20px;" value='<s:property value="txtgridconfirmed"/>'></td></tr>
	 </table>
	 </fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="timeSheetReviewDetailsDiv"><jsp:include page="timeSheetReviewGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>

</div>
<div id="employeeDetailsWindow">
   <div></div>
</div>
<div id="costTypeSearchGridWindow">
	<div></div>
</div> 
<div id="costCodeSearchWindow">
	<div></div>
</div> 
</div> 
</form>
</body>
