<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		
		 $("#leaveRequestDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#fromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#toDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#halfDayDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close');
		 
		 $('#txtemployeeid').dblclick(function(){
	  		 employeeSearchContent("employeeDetailsSearch.jsp");
		 });
		 
		 getDesignation();getDepartment();getPayrollCategory();getLeaveType();
		 
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
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
				$("select#cmbempdesignation").html(optionsdesignation);
				if ($('#hidcmbempdesignation').val() != null) {
					$('#cmbempdesignation').val($('#hidcmbempdesignation').val());
				}
			} else {
			}
		}
		x.open("GET", "getDesignation.jsp", true);
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
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbempdepartment").html(optionsdepartment);
				if ($('#hidcmbempdepartment').val() != null) {
					$('#cmbempdepartment').val($('#hidcmbempdepartment').val());
				}
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
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
				$("select#cmbpayrollcategory").html(optionspayrollcategory);
				if ($('#hidcmbpayrollcategory').val() != null) {
					$('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
  
	  function funNoofDaysLeave(){
			 
			 var leavestartday= $('#fromDate').jqxDateTimeInput('getDate');
			 var leaveendday= $('#toDate').jqxDateTimeInput('getDate');
	
			 if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leavestartday>leaveendday){
				 document.getElementById("errormsg").innerText="From Date Should be less than To Date.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
			 var startdate = $('#fromDate').jqxDateTimeInput('getText');
			 var enddate = $('#toDate').jqxDateTimeInput('getText');
			 var halfday = $('#hidchckhalfday').val();
			 getNumberOfDays(startdate,enddate,halfday);
	}
	
	function getNumberOfDays(startdate,enddate,halfday){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				    $('#txtnoofdays').val(items.trim());
			}
			}
			x.open("GET", "getNumberOfDays.jsp?startdate="+startdate+'&enddate='+enddate+'&halfday='+halfday, true);
			x.send();
	 }
	
	function halfdaycheck(){
			 if(document.getElementById("chckhalfday").checked){
				 document.getElementById("hidchckhalfday").value = 1;
				 $('#halfDayDate').jqxDateTimeInput({disabled: false});
			 }
			 else{
				 document.getElementById("hidchckhalfday").value = 0;
				 $('#halfDayDate').jqxDateTimeInput({disabled: true});
		 	} 
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
				if ($('#hidcmbleavetype').val() != null) {
					$('#cmbleavetype').val($('#hidcmbleavetype').val());
				}
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
  
    function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
      	employeeSearchContent("employeeDetailsSearch.jsp");
       } else{}
      }
  
	 function funReadOnly(){
			$('#frmLeaveRequest input').attr('readonly', true );
			$('#frmLeaveRequest select').attr('disabled', true);
			$('#leaveRequestDate').jqxDateTimeInput({disabled: true});
			$('#fromDate').jqxDateTimeInput({disabled: true});
			$('#toDate').jqxDateTimeInput({disabled: true});
			$('#halfDayDate').jqxDateTimeInput({disabled: true});
			$('#chckhalfday').attr('disabled', true);
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmLeaveRequest input').attr('readonly', false );
			$('#frmLeaveRequest select').attr('disabled', false);
			$('#leaveRequestDate').jqxDateTimeInput({disabled: false});
			$('#fromDate').jqxDateTimeInput({disabled: false});
			$('#toDate').jqxDateTimeInput({disabled: false});
			$('#chckhalfday').attr('disabled', false);
			$('#docno').attr('readonly', true);
			$('#txtemployeeid').attr('readonly', true);
			$('#txtemployeename').attr('readonly', true);
			$('#txtnoofdays').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#leaveRequestDate').val(new Date());
				$('#fromDate').val(new Date());
				$('#toDate').val(new Date());
				$('#halfDayDate').val(new Date());
				document.getElementById("chckhalfday").checked=false;
			    document.getElementById("hidchckhalfday").value = 0; 
			    $('#txtnoofdays').val('1.0');
			}
			
			if ($("#mode").val() == "E") {
				if(document.getElementById("hidchckhalfday").value==1){
					$('#halfDayDate').jqxDateTimeInput({disabled: false});
				}
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('lrqMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#leaveRequestDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	    $(function(){
	        $('#frmLeaveRequest').validate({
	                rules: {
	                cmbleavetype:"required",
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 cmbleavetype:" *",
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  
		  /* Validation */
		  
		    empid=document.getElementById("txtemployeedocno").value;
		    if(empid==""){
				 document.getElementById("errormsg").innerText="Employee is Mandatory.";
				 return 0;
			}
			 
		    if(document.getElementById("hidchckhalfday").value==1){
		    	
	        	var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
				var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
				var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
				 
				leavestartday = leavestartday.setHours(0,0,0,0);
				leaveendday = leaveendday.setHours(0,0,0,0);
				halfday = halfday.setHours(0,0,0,0);
			       
			   if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
		  	   }
			 
			   if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			   }
			 
			   if(!(halfday==leavestartday || halfday==leaveendday)){
				 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
				 return 0;
			  }
		  }
		    
		  noofdays=document.getElementById("txtnoofdays").value;
	      if(noofdays=="" || noofdays=="0"){
			 document.getElementById("errormsg").innerText="Invalid Request !!!";
			 return 0;
		  }
	    	 
		  document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/

	      return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidleaveRequestDate').val()){
				 $("#leaveRequestDate").jqxDateTimeInput('val', $('#hidleaveRequestDate').val());
			  }
		  
		  if($('#hidfromDate').val()){
				 $("#fromDate").jqxDateTimeInput('val', $('#hidfromDate').val());
			  }
		  
		  if($('#hidtoDate').val()){
				 $("#toDate").jqxDateTimeInput('val', $('#hidtoDate').val());
			  }
		  
		  if($('#hidhalfDayDate').val()){
				 $("#halfDayDate").jqxDateTimeInput('val', $('#hidhalfDayDate').val());
			  }

		  if(document.getElementById("hidchckhalfday").value==1){
	 			 document.getElementById("chckhalfday").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckhalfday").value==0){
	 			document.getElementById("chckhalfday").checked = false;
	 		 }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
	         
		}
	   
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 // alert(url);
			    var reurl=url.split("saveLeaveRequests"); 
			     $("#docno").prop("disabled", false);
				 var dtype=$('#formdetailcode').val();
				   //alert(dtype);
				var win= window.open(reurl[0]+"printLeaveRequests?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				win.focus();
			
			   }
			
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function funHalfDayCheck() {
		  if(document.getElementById("hidchckhalfday").value==1){
		    var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
			var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
			var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
			 
			 leavestartday = leavestartday.setHours(0,0,0,0);
			 leaveendday = leaveendday.setHours(0,0,0,0);
			 halfday = halfday.setHours(0,0,0,0);
			 
			 if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			 }
			 
			 if(!(halfday==leavestartday || halfday==leaveendday)){
				 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
		  }
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
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmLeaveRequest" action="saveLeaveRequests" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset style="background-color: #EBDEF0;">
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="15%"><div id="leaveRequestDate" name="leaveRequestDate" value='<s:property value="leaveRequestDate"/>'></div>
    <input type="hidden" id="hidleaveRequestDate" name="hidleaveRequestDate" value='<s:property value="hidleaveRequestDate"/>'/></td>
    <td colspan="4">&nbsp;</td>
    <td width="12%" align="right">Doc No.</td>
    <td width="22%"><input type="text" id="docno" name="txtleaverequestdocno" style="width:49%;" value='<s:property value="txtleaverequestdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Designation</td>
    <td><select id="cmbempdesignation" name="cmbempdesignation" style="width:95%;" value='<s:property value="cmbempdesignation"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/></td>
    <td width="10%" align="right">Department</td>
    <td colspan="3"><select id="cmbempdepartment" name="cmbempdepartment" style="width:60%;" value='<s:property value="cmbempdepartment"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/></td>
    <td align="right">Payroll Category</td>
    <td><select id="cmbpayrollcategory" name="cmbpayrollcategory" style="width:50%;" value='<s:property value="cmbpayrollcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/></td>
  </tr>
  <tr>
    <td align="right">Employee</td>
    <td><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployee(event);"/></td>
    <td colspan="6"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:82%;" value='<s:property value="txtemployeename"/>' tabindex="-1"/>
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">From</td>
    <td><div id="fromDate" name="fromDate" onchange="funNoofDaysLeave();" value='<s:property value="fromDate"/>'></div>
    <input type="hidden" id="hidfromDate" name="hidfromDate" value='<s:property value="hidfromDate"/>'/></td>
    <td align="right">To</td>
    <td width="16%"><div id="toDate" name="toDate" onchange="funNoofDaysLeave();" value='<s:property value="toDate"/>'></div>
    <input type="hidden" id="hidtoDate" name="hidtoDate" value='<s:property value="hidtoDate"/>'/></td>
            <td width="8%" align="center"><input type="checkbox" id="chckhalfday" name="chckhalfday" value="" onchange="halfdaycheck();funNoofDaysLeave();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Half Day
	    <input type="hidden" id="hidchckhalfday" name="hidchckhalfday" value='<s:property value="hidchckhalfday"/>'/></td>
    <td width="9%"><div id="halfDayDate" name="halfDayDate" onchange="funHalfDayCheck();" value='<s:property value="halfDayDate"/>'></div>
    <input type="hidden" id="hidhalfDayDate" name="hidhalfDayDate" value='<s:property value="hidhalfDayDate"/>'/></td>
    <td align="right">No. of Days</td>
    <td><input type="text" id="txtnoofdays" name="txtnoofdays" placeholder="No. of Days" style="width:49%;" value='<s:property value="txtnoofdays"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Leave Type</td>
    <td><select id="cmbleavetype" name="cmbleavetype" style="width:80%;" value='<s:property value="cmbleavetype"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbleavetype" name="hidcmbleavetype" value='<s:property value="hidcmbleavetype"/>'/></td>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" placeholder="Description" style="width:79%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset><br/>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</div>
</form>
<div id="employeeDetailsWindow">
   <div></div>
</div>

</div>
</body>
</html>
