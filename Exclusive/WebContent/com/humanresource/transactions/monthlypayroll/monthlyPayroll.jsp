<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
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

.myProcessCalcButton {
	 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #E0ECF8), color-stop(1, #81BEF7));
	 background:-moz-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	 background:-webkit-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	 background:-o-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	 background:-ms-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	 background:linear-gradient(to bottom, #E0ECF8 5%, #81BEF7 100%);
	 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#E0ECF8', endColorstr='#81BEF7',GradientType=0);
	 background-color:#E0ECF8;
	 -moz-border-radius:4px;
	 -webkit-border-radius:4px;
	 border-radius:4px;
	 display:inline-block;
	 cursor:pointer;
	 font-family:Verdana;
	 font-size:10px;
	 padding:4px 8px;
	 text-decoration:none;
}
.myProcessCalcButton:hover {
	 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #81BEF7), color-stop(1, #E0ECF8));
	 background:-moz-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	 background:-webkit-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	 background:-o-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	 background:-ms-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	 background:linear-gradient(to bottom, #81BEF7 5%, #E0ECF8 100%);
	 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#81BEF7', endColorstr='#E0ECF8',GradientType=0);
	 background-color:#81BEF7;
}
.myProcessCalcButton:active {
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

.bounce {
	color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -webkit-transform: translateX(0);
    transform: translateX(0);
  }
  40% {
    -moz-transform: translateX(-30px);
    -ms-transform: translateX(-30px);
    -webkit-transform: translateX(-30px);
    transform: translateX(-30px);
  }
  60% {
    -moz-transform: translateX(-15px);
    -ms-transform: translateX(-15px);
    -webkit-transform: translateX(-15px);
    transform: translateX(-15px);
  }
} 

@media (min-width: 15px) {
  .mega {
    font-size: 15px;
  }
}

@font-face {
  font-family: 'Roboto',comic sans ms,Tahoma;
  font-style: normal;
  font-weight: 100;
  unicode-range: U+0460-052F, U+20B4, U+2DE0-2DFF, U+A640-A69F;
}
  
@-webkit-keyframes hue {
  from {
    -webkit-filter: hue-rotate(0deg);
  }

  to {
    -webkit-filter: hue-rotate(-360deg);
  }
}

</style>

<script type="text/javascript">
      $(document).ready(function () {
    	  $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );
 		  $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
 		 
    	  /* Date */
    	  $("#payrollDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#payrollPrintDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#txtemployeeid').dblclick(function(){
  			employeeSearchContent("employeeDetailsSearch.jsp");
		  });
  		 
  		 $('#txtprintemployeeid').dblclick(function(){
   			employeeSearchContent("employeeDetailsSearch.jsp");
 		  });
  		 
  		$(".chckpayrollprocessprint").click(function() {
 	        selectedBox = this.id;

 	        $(".chckpayrollprocessprint").each(function() {
 	            if ( this.id == selectedBox )
 	            {
 	                this.checked = true;
 	            }
 	            else
 	            {
 	                this.checked = false;
 	            };        
 	        });
 	    }); 
  		 
  		 if($('#docno').val().trim()==''){
  			$('#mode').val('view');$('#docno').val('0');
  		 } else if(parseInt($('#docno').val().trim())==0){
  			$('#mode').val('A'); 
  		 } else if(parseInt($('#docno').val().trim())>0){
  			$('#mode').val('E'); 
  		 } else {
  			$('#mode').val('view');
  		 }
		 
		 $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		 $('#txtprintemployeeid').attr('readonly', true);
		 $('#txtprintemployeename').attr('readonly', true);
		 $('#payrollDate').jqxDateTimeInput('focus'); 
		 $("#monthlyPayrollGridID").jqxGrid('clear');
		 $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
		 $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
		 $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
		 document.getElementById("lblcurrentstatus").innerText="";
		 $('#hidchckpayrollprocess').val(1);document.getElementById("chckpayrollprocess").checked = true;
		 $('#hidchckpayrollprint').val(0);document.getElementById("chckpayrollprint").checked = false;
		 $('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;

		 $('#payrollPrintDate').jqxDateTimeInput({disabled: true});
		 $('#cmbempprintcategory').attr('disabled', true);
		 $('#txtprintemployeeid').attr('disabled', true);
		 $('#txtprintemployeename').attr('disabled', true);
		 $('#chckpayslip').attr('disabled', true);
		 $('#btnPayrollPrint').attr('disabled', true );
		 $('#btnView').attr('disabled', true );
		 $('#clearPrint').attr('disabled', true );
		 
		 var date = $('#payrollDate').val();
    	 getPayrollDate(date);getPayrollCategory();getLeaveType();getAllowanceType();
    	 
    	 $('#payrollDate').focusout(function(){
    		 var date = $('#payrollDate').val();
    		 //alert(date);
        	 getPayrollDate(date);getPayrollDocNo(date);
		 });
    	 $('#payrollDate').on('close', function (event) { 
    		 var date = $('#payrollDate').val();
    		// alert(date);  
        	 getPayrollDate(date);getPayrollDocNo(date);
    	 }); 
    	 $('#payrollPrintDate').focusout(function(){
    		 var date = $('#payrollPrintDate').val();
    		 getPayrollPrintDate(date);getPayrollPrintDocNo(date);
		 });
    	 
      }); 
      
      function employeeSearchContent(url) {
		 	$('#employeeDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#employeeDetailsWindow').jqxWindow('setContent', data);
			$('#employeeDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
      
     function getPayrollDate(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#payrollDate').val(items);
	  		}
	  		}
	  		x.open("GET", "getPayrollDate.jsp?date="+date, true);
	  		x.send();
	 }
     
     function getPayrollPrintDate(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#payrollPrintDate').val(items);
	  		}
	  		}
	  		x.open("GET", "getPayrollDate.jsp?date="+date, true);
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
				$("select#cmbempprintcategory").html(optionspayrollcategory);
				if ($('#hidcmbempcategory').val() != null) {
					$('#cmbempcategory').val($('#hidcmbempcategory').val());
				}
				if ($('#hidcmbempprintcategory').val() != null) {
					$('#cmbempprintcategory').val($('#hidcmbempprintcategory').val());
				}
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
				var leavetypeCountItems = items[2].split(",");
				
				for (var i = 0; i < leavetypeItems.length; i++) {
					
					if(i==0){
						$('#txtleavetype1').val(leavetypeItems[i]);
					} else if(i==1){
						$('#txtleavetype2').val(leavetypeItems[i]);
					} else if(i==2){
						$('#txtleavetype3').val(leavetypeItems[i]);
					} else if(i==3){
						$('#txtleavetype4').val(leavetypeItems[i]);
					} else if(i==4){
						$('#txtleavetype5').val(leavetypeItems[i]);
					} else if(i==5){
						$('#txtleavetype6').val(leavetypeItems[i]);
					} else if(i==6){
						$('#txtleavetype7').val(leavetypeItems[i]);
					} else if(i==7){
						$('#txtleavetype8').val(leavetypeItems[i]);
					} else if(i==8){
						$('#txtleavetype9').val(leavetypeItems[i]);
					} else {
						$('#txtleavetype10').val(leavetypeItems[i]);
					} 									
					$('#txtleavetypecount').val(leavetypeCountItems[i]);
				}
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
    
    function getAllowanceType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var allowancetypeItems = items[0].split(",");
				var allowancetypeIdItems = items[1].split(",");
				var allowancetypeCountItems = items[2].trim();

				for (var i = 0; i < allowancetypeItems.length; i++) {
					
					if(i==0){
						$('#txtallowancetype1').val(allowancetypeItems[i]);
					} else if(i==1){
						$('#txtallowancetype2').val(allowancetypeItems[i]);
					} else if(i==2){
						$('#txtallowancetype3').val(allowancetypeItems[i]);
					} else if(i==3){
						$('#txtallowancetype4').val(allowancetypeItems[i]);
					} else if(i==4){
						$('#txtallowancetype5').val(allowancetypeItems[i]);
					} else if(i==5){
						$('#txtallowancetype6').val(allowancetypeItems[i]);
					} else if(i==6){
						$('#txtallowancetype7').val(allowancetypeItems[i]);
					} else if(i==7){
						$('#txtallowancetype8').val(allowancetypeItems[i]);
					} else if(i==8){
						$('#txtallowancetype9').val(allowancetypeItems[i]);
					} else {
						$('#txtallowancetype10').val(allowancetypeItems[i]);
					} 									
				}
				$('#txtallowancetypecount').val(allowancetypeCountItems);
			} else {
			}
		}
		x.open("GET", "getAllowanceType.jsp", true);
		x.send();
	}
    
    function getLastPayrollDate(payrolldate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			     $('#txtchkgridload').val(items[0]);
  			     // alert($('#txtchkgridload').val());
  			     document.getElementById("errormsg").innerText="Payroll Processed till "+items[1]+".";
  			     
  			     if(parseInt($('#txtchkgridload').val())==1){
  			    	  $("#overlay, #PleaseWait").show();
  			    	  $('#txtchkgridload').val('');
  			    	  document.getElementById("lblcurrentstatus").innerText="Payroll to be Saved.";
  			    	  //$('#mode').val('A');
  			    	  funLoadGrid();
  			     } else if(parseInt($('#txtchkgridload').val())==0) {
					  $.messager.alert('Message','Payroll Process Pending for Last-Month.','warning');
					  $("#monthlyPayrollGridID").jqxGrid('clear'); 
			          $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
			          $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
			          document.getElementById("lblcurrentstatus").innerText="Pending for Last-Month.";
			          $('#mode').val('view');
  					  return;
  				 } else if(parseInt($('#txtchkgridload').val())==2) {
					  $.messager.alert('Message','Already Payroll Processed.','warning');
					  $("#monthlyPayrollGridID").jqxGrid('clear'); 
			          $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
			          $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
			          document.getElementById("lblcurrentstatus").innerText="Already Processed.";
			          $('#mode').val('E');
					  return;
				 } else if(parseInt($('#txtchkgridload').val())==3) {
					  $.messager.alert('Message','Enter Attendance & Process Payroll','warning');
					  $("#monthlyPayrollGridID").jqxGrid('clear'); 
			          $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
			          $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
			          document.getElementById("lblcurrentstatus").innerText="";
			          $('#mode').val('view');
			          document.getElementById("errormsg").innerText="";
					  return;
				 } else if(parseInt($('#txtchkgridload').val())==4) {
					  document.getElementById("lblcurrentstatus").innerText="Payroll Processed.";
					  $('#mode').val('E');
					  $("#overlay, #PleaseWait").show();
 			    	  funLoadGrid();
				 } else if(parseInt($('#txtchkgridload').val())==5) {
					  $("#overlay, #PleaseWait").show();
					  document.getElementById("lblcurrentstatus").innerText="Payroll Confirmed.";
					  $('#mode').val('view');
 			    	  funLoadGrid();
				 }
  			     
  			   
  		}
		}
		x.open("GET", "getLastPayrolledDate.jsp?payrolldate="+payrolldate, true);
		x.send();
	}
    
    function getPayrollDocNo(payrolldate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#docno').val(items);
  			  
  			    if(items.trim()==''){
  	  				$('#mode').val('view');$('#docno').val('0');
  	  		 	} else if(parseInt(items.trim())==0){
  	  				$('#mode').val('A'); 
  	  		 	} else if(parseInt(items.trim())>0){
  	  				$('#mode').val('E'); 
  	  		 	} else {
  	  				$('#mode').val('view');
  	  		 	}
  		}
  		}
  		x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate, true);
  		x.send();
    }
    
    function getPayrollPrintDocNo(payrolldate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#docno').val(items);
  			  
  			    if(items.trim()==''){
  	  				$('#docno').val('0');
  	  		 	}
  		}
  		}
  		x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate, true);
  		x.send();
    }
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }

    function funExcelBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
			 JSONToCSVCon(data, 'MonthlyPayroll', true);
		 } else {
			 $("#monthlyPayrollGridID").jqxGrid('exportdata', 'xls', 'MonthlyPayroll');
		 }
	 }
	 
	 function funLoadGrid() {
		 
		  var mode = $('#mode').val();
		  var docno = $('#docno').val().trim(); 
		  var date = $('#payrollDate').jqxDateTimeInput('val');
		  var category = $('#cmbempcategory').val();
		  var empid = $('#txtemployeedocno').val();
		  
		  $("#payrollDiv").load("monthlyPayrollGrid.jsp?mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1");
		  $("#monthlyPayrollGridID").jqxGrid({ disabled: false});
	 	  $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', true );
	 	  
	 	  if(mode=='E'){
	 		 $('#btnConfirmed').attr('disabled', false ); 
	 	  }
	 	  
	 	 if(mode=='view'){
	 		$('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true ); 
	 	  }
    }
	 
	 function funLoadPrintGrid() {
		  var date = $('#payrollPrintDate').val();
		  var category = $('#cmbempprintcategory').val();
		  var empid = $('#txtprintemployeedocno').val();
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#payrollPrintDiv").load("monthlyPayrollPrintGrid.jsp?date="+date+"&category="+category+"&empid="+empid+"&check=1");
		  $('#btnPayrollPrint').attr('disabled', false );
	 }
	 
	function funReadOnly(){} 
	
	function funRemoveReadOnly(){}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	 
	 function funNotify(){
		 	
  	 			/* Monthly Payroll Grid  Saving*/
  			 	var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
  			 	var length=0;
  					 for(var i=0 ; i < rows.length ; i++){
  						var chk=rows[i].employeedocno;
  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  							newTextBox = $(document.createElement("input"))
  						    .attr("type", "dil")
  						    .attr("id", "test"+length)
  						    .attr("name", "test"+length)
  							.attr("hidden", "true");
  							length=length+1;
  								
  				    newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks+":: "+rows[i].earnbasic+":: "+rows[i].earnallowance1+":: "+rows[i].earnallowance2+":: "+rows[i].earnallowance3+":: "+rows[i].earnallowance4+":: "+rows[i].earnallowance5+":: "+rows[i].earnallowance6+":: "+rows[i].earnallowance7+":: "+rows[i].earnallowance8+":: "+rows[i].earnallowance9+":: "+rows[i].earnallowance10+":: "+rows[i].totalearnedsalary+":: "+rows[i].rowno);
  				    newTextBox.appendTo('form');
  				 }
  				}
  	 		 	$('#gridlength').val(length);
  			 	/* Monthly Payroll Grid  Saving Ends*/	
		 
 		 return 1;
		} 
	 
	 function funSearchLoad(){}
	 
	 function funFocus(){
		 $('#payrollDate').jqxDateTimeInput('focus'); 
	  }
	 
	 function setValues(){
		 	 checkPaySlip();checkPayrollPrint();checkPayrollProcess();
		 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#payrollDiv").load("monthlyPayrollGrid.jsp?docno="+indexVal+"&date="+$('#payrollDate').val());
			 } 
		}
	 
	 function  funClearInfo(){
			
		    $('#payrollDate').val(new Date());
			document.getElementById("cmbempcategory").value="";
			document.getElementById("txtemployeeid").value="";
			document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtemployeename").value="";
			document.getElementById("txtchkgridload").value="";
			document.getElementById("lblcurrentstatus").innerText="";
			$("#monthlyPayrollGridID").jqxGrid('clear');
			$("#monthlyPayrollGridID").jqxGrid({ disabled: true});
			$('#btnSavePayRoll').prop('disabled', true);$('#btnConfirmed').prop('disabled', true);
			
			 if (document.getElementById("txtemployeeid").value == "") {
			        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
			        $('#txtemployeename').attr('placeholder', 'Employee Name');
			    }
			 
			 $('#payrollDate').jqxDateTimeInput('focus'); 
			 document.getElementById("errormsg").innerText="";
	}
	 
	 function  funClearPrintInfo(){
			
		    $('#payrollPrintDate').val(new Date());
			document.getElementById("cmbempprintcategory").value="";
			document.getElementById("txtprintemployeeid").value="";
			document.getElementById("txtprintemployeedocno").value="";
			document.getElementById("txtprintemployeename").value="";
			document.getElementById("lblcurrentstatus").innerText="";
			$("#monthlyPayrollPrintGridID").jqxGrid('clear');
			$("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
			$('#btnView').prop('disabled', false);$('#clearPrint').prop('disabled', false);$('#btnPayrollPrint').prop('disabled', true);
			$('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;
			
			 if (document.getElementById("txtprintemployeeid").value == "") {
			        $('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); 
			        $('#txtprintemployeename').attr('placeholder', 'Employee Name');
			    }
			 
			 $('#payrollPrintDate').jqxDateTimeInput('focus'); 
			 document.getElementById("errormsg").innerText="";
	}
	 
	 function funProcessGrid(){
		 var date = $('#payrollDate').val();
		 getLastPayrollDate(date);
	 }
	 
	 function funSaveGrid(){
		 $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', false );$('#btnSave').mousedown();
	 }
	 
	 function funConfirm(){
		 var alreadyProcessed = $('#txtpayrollalreadyprocessed').val();
		 var payrollRows = $("#monthlyPayrollGridID").jqxGrid('getrows');
		 if(parseInt(alreadyProcessed)!=parseInt(payrollRows.length)){
			 $.messager.alert('Message','Payroll Saving Pending For Some Employee(s).','warning');
			 return;
		 }
		 
		 $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
	  	 		if (r){
	  	 			
	  	 			/* Monthly Payroll Grid  Saving*/
	  			 	var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
	  			 	var length=0;
	  					 for(var i=0 ; i < rows.length ; i++){
	  						var chk=rows[i].employeedocno;
	  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	  							newTextBox = $(document.createElement("input"))
	  						    .attr("type", "dil")
	  						    .attr("id", "test"+length)
	  						    .attr("name", "test"+length)
	  							.attr("hidden", "true");
	  							length=length+1;
	  								
	  				    newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks);
	  				    newTextBox.appendTo('form');
	  				 }
	  				}
	  	 		 	$('#gridlength').val(length);
	  			 	/* Monthly Payroll Grid  Saving Ends*/	
	  			 	
	  	 			$('#mode').val('EDIT');
	  				$("#overlay, #PleaseWait").show();
	  				document.getElementById("frmMonthlyPayroll").submit();
	  	 	    }
		   });
	 }
	 
	 function funCheckPayrollProcess(){
		 $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
		 document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
		 document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
		 $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtemployeename').attr('placeholder', 'Employee Name');
		 $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
		 document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";
		 $("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});$('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
				  
		 if(document.getElementById("chckpayrollprocess").checked == true){
			     $('#payrollDate').jqxDateTimeInput('focus'); $('#hidchckpayrollprocess').val(1);$('#hidchckpayrollprint').val(0);$('#payrollDate').jqxDateTimeInput({disabled: false});
			     $('#cmbempcategory').attr('disabled', false);$('#txtemployeeid').attr('disabled', false);$('#txtemployeename').attr('disabled', false);$("#payrollDiv").prop("hidden", false);
			     $("#payrollPrintDiv").prop("hidden", true);$('#clear').attr('disabled', false);$('#btnProcess').attr('disabled', false );$('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
				 $('#payrollPrintDate').jqxDateTimeInput({disabled: true});$('#cmbempprintcategory').attr('disabled', true);$('#txtprintemployeeid').attr('disabled', true);$('#txtprintemployeename').attr('disabled', true);
				 $('#chckpayslip').attr('disabled', true);$('#btnPayrollPrint').attr('disabled', true );$('#btnView').attr('disabled', true );$('#clearPrint').attr('disabled', true );
		  } 
	  }
	
	 function funCheckPayrollPrint(){
		  $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
		  document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
		  document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
		  $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');$('#txtemployeename').attr('placeholder', 'Employee Name');
		  $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
		  document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";$("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
		  $('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
		  
		  if(document.getElementById("chckpayrollprint").checked == true){
			     $('#payrollPrintDate').jqxDateTimeInput('focus');$('#hidchckpayrollprint').val(1);$('#hidchckpayrollprocess').val(0);$('#payrollPrintDate').jqxDateTimeInput({disabled: false});
				 $('#cmbempprintcategory').attr('disabled', false);$('#txtprintemployeeid').attr('disabled', false);$('#txtprintemployeename').attr('disabled', false);$('#chckpayslip').attr('disabled', false);
				 $('#btnPayrollPrint').attr('disabled', true );$('#payrollDate').jqxDateTimeInput({disabled: true});$('#cmbempcategory').attr('disabled', true);$('#txtemployeeid').attr('disabled', true);
				 $('#txtemployeename').attr('disabled', true);$("#payrollDiv").prop("hidden", true); $("#payrollPrintDiv").prop("hidden", false);$('#clear').attr('disabled', true);$('#btnProcess').attr('disabled', true );
				 $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );$('#btnView').attr('disabled', false );$('#clearPrint').attr('disabled', false );
				 
		  } 
	  }
	 
	 function checkPayrollProcess(){
		 if(document.getElementById("hidchckpayrollprocess").value==1){
			 document.getElementById("chckpayrollprocess").checked = true;
		 }
		 else if(document.getElementById("hidchckpayrollprocess").value==0){
			document.getElementById("chckpayrollprocess").checked = false;
		  }
		 }
	 
	 function funCheckPaySlip(){
		  if(document.getElementById("chckpayslip").checked == true){
		 		 $('#hidchckpayslip').val(1);
		  } else{
			  $('#hidchckpayslip').val(0);  
		  }
	  }
	
	 function checkPayrollPrint(){
		 if(document.getElementById("hidchckpayrollprint").value==1){
			 document.getElementById("chckpayrollprint").checked = true;
		 }
		 else if(document.getElementById("hidchckpayrollprint").value==0){
			document.getElementById("chckpayrollprint").checked = false;
		  }
		 }
	 
	function checkPaySlip(){
		 if(document.getElementById("hidchckpayslip").value==1){
			 document.getElementById("chckpayslip").checked = true;
		 }
		 else if(document.getElementById("hidchckpayslip").value==0){
			document.getElementById("chckpayslip").checked = false;
		  }
	}
	
	function payrollprintdatechange(){
   	     var date = $('#payrollPrintDate').val();
		 getPayrollPrintDate(date);getPayrollPrintDocNo(date);
	}

	 function funPayrollPrint() {
		   
		if($("#hidchckpayrollprint").val()=="1") {
			
		var rows=$("#monthlyPayrollPrintGridID").jqxGrid("getrows");
    	var selectedrows=$("#monthlyPayrollPrintGridID").jqxGrid('selectedrowindexes');
    	selectedrows = selectedrows.sort(function(a,b){return a - b});
    	
        var i=0;j=0;k=0;tempemps="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
				   if(k==0){
					 tempemps=rows[i].employeedocno;
					 k=1;
				   } else{
					tempemps=tempemps+","+rows[i].employeedocno;
				 }
			   j++; 
			}
         }
  		
  		 $('#txtselectedemployees').val(tempemps);
   		
		 if($("#hidchckpayslip").val()=="0") {
			 
			 var url=document.URL;
			 var reurl=url.split("monthlypayroll");
			
		     $("#docno").prop("disabled", false);
			
				   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
				   
		  } else if($("#hidchckpayslip").val()=="1") {
			   if(selectedrows.length==0){
					$("#overlay, #PleaseWait").hide();
					$.messager.alert('Warning','Select Employee(s) to be Printed.');
					return false;
				}
			   
			    var url=document.URL;
				var reurl=url.split("monthlypayroll");
				
				var win= window.open(reurl[0]+"monthlypayroll/printPaySlipViewer?employeedocno="+$("#txtselectedemployees").val()+"&branch="+document.getElementById("brchName").value+"&date="+document.getElementById("payrollPrintDate").value+"&allowancecount="+document.getElementById("txtallowancetypecount").value+"&docno="+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			    win.focus();
				
		  }
		 }
	    }
	 function funPayrollprocessPrint(){
		  var mode = $('#mode').val();
		  var docno = $('#docno').val().trim(); 
		  var date = $('#payrollDate').jqxDateTimeInput('val');
		  var category = $('#cmbempcategory').val();
		  var empid = $('#txtemployeedocno').val();
	   		     var url=document.URL;
				 var reurl=url.split("monthlypayroll");
				 $("#docno").prop("disabled", false);
				        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){      
						if (r){
							var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll2?branch="+document.getElementById("brchName").value+"&header="+1+"&mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }                    
						else{   
							var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll2?branch="+document.getElementById("brchName").value+"&header="+0+"&mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });    
		    }
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMonthlyPayroll" action="saveMonthlyPayroll" method="post" autocomplete="off">
<jsp:include page="../../../../headerhr.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<table width="99%">
  <tr>
    <td width="20%">
<fieldset style="background-color: #EBDEF0;">
<table width="99%">
  <tr><td colspan="2" class="bounce" style="text-align: center;">&nbsp;<b><label id="lblcurrentstatus"  name="lblcurrentstatus"><s:property value="lblcurrentstatus"/></label></b></td></tr>
  <tr><td colspan="2"><fieldset><legend><b><input type="checkbox" id="chckpayrollprocess" name="chckpayrollprocess" class="chckpayrollprocessprint" onclick="funCheckPayrollProcess();">&nbsp;Process
       <input type="hidden" id="hidchckpayrollprocess" name="hidchckpayrollprocess" value='<s:property value="hidchckpayrollprocess"/>'/></b></legend>
	   <table width="100%">
  <tr>
    <td width="29%" align="right">Date</td>
    <td width="71%"><div id="payrollDate" name="payrollDate" value='<s:property value="payrollDate"/>'></div>
      <input type="hidden" id="hidpayrollDate" name="hidpayrollDate" value='<s:property value="hidpayrollDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Category</td>
    <td><select id="cmbempcategory" name="cmbempcategory" style="width:80%;" value='<s:property value="cmbempcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/></td>
  </tr>
  
  <tr>
    <td align="right">Employee</td>
    <td><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
  </tr>
  
   <tr>
    <td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:95%;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td>
  </tr>
  
 <tr>
    <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;&nbsp;
    <input type="button" class="myProcessCalcButton" id="btnProcess" name="btnProcess" value="Process & Calc" onclick="funProcessGrid();"></td>
 </tr>
 
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr>
    <td colspan="2" align="center"><input type="button" class="mySaveButton" id="btnSavePayRoll" name="btnSavePayRoll" value="Save" onclick="funSaveGrid();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" class="myConfirmButton" id="btnConfirmed" name="btnConfirmed" value="Confirm" onclick="funConfirm();">
	<input type="button" class="myProcessCalcButton" id="btnPayrollprocessPrint" name="btnPayrollprocessPrint" value="Print" onclick="funPayrollprocessPrint();"></td>
 </tr>
 
 </table>
 </fieldset></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2"><fieldset><legend><b><input type="checkbox" id="chckpayrollprint" name="chckpayrollprint" class="chckpayrollprocessprint" onclick="funCheckPayrollPrint();">&nbsp;Print
       <input type="hidden" id="hidchckpayrollprint" name="hidchckpayrollprint" value='<s:property value="hidchckpayrollprint"/>'/></b></legend>
	   <table width="100%">
  <tr>
    <td width="29%" align="right">Date</td>
    <td width="71%"><div id="payrollPrintDate" name="payrollPrintDate" onchange="payrollprintdatechange();" value='<s:property value="payrollPrintDate"/>'></div>
      <input type="hidden" id="hidpayrollPrintDate" name="hidpayrollPrintDate" value='<s:property value="hidpayrollPrintDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Category</td>
    <td><select id="cmbempprintcategory" name="cmbempprintcategory" style="width:80%;" value='<s:property value="cmbempprintcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempprintcategory" name="hidcmbempprintcategory" value='<s:property value="hidcmbempprintcategory"/>'/></td>
  </tr>
  <tr>
    <td align="right">Employee</td>
    <td><input type="text" id="txtprintemployeeid" name="txtprintemployeeid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtprintemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
    <input type="hidden" id="txtprintemployeedocno" name="txtprintemployeedocno" value='<s:property value="txtprintemployeedocno"/>'/></td>
  </tr>
   <tr>
    <td colspan="2"><input type="text" id="txtprintemployeename" name="txtprintemployeename" placeholder="Employee Name" style="width:95%;" tabindex="-1" value='<s:property value="txtprintemployeename"/>'/></td>
  </tr>
  <tr><td align="center"><input type="checkbox" id="chckpayslip" name="chckpayslip" onclick="funCheckPaySlip();">&nbsp;Pay Slip
       <input type="hidden" id="hidchckpayslip" name="hidchckpayslip" value='<s:property value="hidchckpayslip"/>'/></td><td>&nbsp;</td></tr>
  <tr>
    <td colspan="2" align="center"><input type="button" class="myButtons" name="clearPrint" id="clearPrint"  value="Clear" onclick="funClearPrintInfo();">&nbsp;&nbsp;&nbsp;
    <input type="button" class="myProcessCalcButton" id="btnView" name="btnView" value="View" onclick="funLoadPrintGrid();">&nbsp;&nbsp;&nbsp;
    <input type="button" class="myProcessCalcButton" id="btnPayrollPrint" name="btnPayrollPrint" value="Print" onclick="funPayrollPrint();"></td>
  </tr>
  </table></fieldset></td></tr>
  </table>
</fieldset>
    </td>
    <td width="80%">
    <div id="payrollDiv"><jsp:include page="monthlyPayrollGrid.jsp"></jsp:include></div>
    <div id="payrollPrintDiv" hidden="true"><jsp:include page="monthlyPayrollPrintGrid.jsp"></jsp:include></div>
    </td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="txtmonthlypayrolldocno" value='<s:property value="txtmonthlypayrolldocno"/>'/>
<input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtleavetype1" name="txtleavetype1"  value='<s:property value="txtleavetype1"/>'/>
<input type="hidden" id="txtleavetype2" name="txtleavetype2"  value='<s:property value="txtleavetype2"/>'/>
<input type="hidden" id="txtleavetype3" name="txtleavetype3"  value='<s:property value="txtleavetype3"/>'/>
<input type="hidden" id="txtleavetype4" name="txtleavetype4"  value='<s:property value="txtleavetype4"/>'/>
<input type="hidden" id="txtleavetype5" name="txtleavetype5"  value='<s:property value="txtleavetype5"/>'/>
<input type="hidden" id="txtleavetype6" name="txtleavetype6"  value='<s:property value="txtleavetype6"/>'/>
<input type="hidden" id="txtleavetype7" name="txtleavetype7"  value='<s:property value="txtleavetype7"/>'/>
<input type="hidden" id="txtleavetype8" name="txtleavetype8"  value='<s:property value="txtleavetype8"/>'/>
<input type="hidden" id="txtleavetype9" name="txtleavetype9"  value='<s:property value="txtleavetype9"/>'/>
<input type="hidden" id="txtleavetype10" name="txtleavetype10"  value='<s:property value="txtleavetype10"/>'/>
<input type="hidden" id="txtleavetypecount" name="txtleavetypecount"  value='<s:property value="txtleavetypecount"/>'/>
<input type="hidden" id="txtallowancetype1" name="txtallowancetype1"  value='<s:property value="txtallowancetype1"/>'/>
<input type="hidden" id="txtallowancetype2" name="txtallowancetype2"  value='<s:property value="txtallowancetype2"/>'/>
<input type="hidden" id="txtallowancetype3" name="txtallowancetype3"  value='<s:property value="txtallowancetype3"/>'/>
<input type="hidden" id="txtallowancetype4" name="txtallowancetype4"  value='<s:property value="txtallowancetype4"/>'/>
<input type="hidden" id="txtallowancetype5" name="txtallowancetype5"  value='<s:property value="txtallowancetype5"/>'/>
<input type="hidden" id="txtallowancetype6" name="txtallowancetype6"  value='<s:property value="txtallowancetype6"/>'/>
<input type="hidden" id="txtallowancetype7" name="txtallowancetype7"  value='<s:property value="txtallowancetype7"/>'/>
<input type="hidden" id="txtallowancetype8" name="txtallowancetype8"  value='<s:property value="txtallowancetype8"/>'/>
<input type="hidden" id="txtallowancetype9" name="txtallowancetype9"  value='<s:property value="txtallowancetype9"/>'/>
<input type="hidden" id="txtallowancetype10" name="txtallowancetype10"  value='<s:property value="txtallowancetype10"/>'/>
<input type="hidden" id="txtallowancetypecount" name="txtallowancetypecount"  value='<s:property value="txtallowancetypecount"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtpayrollalreadyprocessed" name="txtpayrollalreadyprocessed"  value='<s:property value="txtpayrollalreadyprocessed"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>
</html>
