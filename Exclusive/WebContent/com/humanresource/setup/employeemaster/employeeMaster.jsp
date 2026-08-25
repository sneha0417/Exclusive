<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#employeeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#joiningDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#empDateOfBirth").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
    	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#accountDetailsWindow').jqxWindow('close');
 		 
 		 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#nationalityWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '100%', height: '25%',  maxHeight: '25%' ,maxWidth: '50%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#printWindow').jqxWindow('close');
 		 
 		 $('#txtempaccount').dblclick(function(){
			  accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
		  });
 		 
 		$('#txtempnationality').dblclick(function(){
 			nationalitySearchContent("nationSearchGrid.jsp");
		  });
 		 
 		  getDesignation();getDepartment();getPayrollCategory();getSalesAgent();
      }); 
      
      function accountSearchContent(url) {
		 	$('#accountDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function nationalitySearchContent(url) {
		 	$('#nationalityWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#nationalityWindow').jqxWindow('setContent', data);
			$('#nationalityWindow').jqxWindow('bringToFront');
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
      
      function getSalesAgent() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var salesAgentItems = items[0].split(",");
  				var salesAgentIdItems = items[1].split(",");
  				var optionssalesagent = '<option value="">--Select--</option>';
  				for (var i = 0; i < salesAgentItems.length; i++) {
  					optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
  							+ salesAgentItems[i] + '</option>';
  				}
  				$("select#cmbempagentid").html(optionssalesagent);
  				if ($('#hidcmbempagentid').val() != null) {
  					$('#cmbempagentid').val($('#hidcmbempagentid').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getSalesAgent.jsp", true);
  		x.send();
  	}
      
      function getCurrencyIds(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var multiItems=items[2];
			        var optionscurr = '';
			        
			     if(curcodeItems.indexOf(",")>=0){
			        	var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
			      
			         $("select#cmbcurrency").html(optionscurr);
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
					     
				   }
			
			       else{
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   
				    	 $("select#cmbcurrency").html(optionscurr);
				       
				         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
				       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
				         }
				      }
				}
		     }
		      x.open("GET", "getCurrencyId.jsp",true);
		     x.send();
		    
		   }
      
      function getEmpAccount(event){
          var x= event.keyCode;
          if(x==114){
        	  accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          }
          else{}
          }
      
      function getNations(event){
          var x= event.keyCode;
          if(x==114){
        	  nationalitySearchContent("nationSearchGrid.jsp");
          }
          else{}
          }
      
	  function getEmployeeCodeAlreadyExists(empcode,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				
	  				if(parseInt(items.trim())==1){
	  					document.getElementById("errormsg").innerText="Employee ID Already Exists.";
	  					 return 0;
	  				 } else { 
	  					document.getElementById("errormsg").innerText="";
	  				 }
	  		}
		}
		x.open("GET", "getEmployeeCodeAlreadyExists.jsp?empcode="+empcode+"&docno="+docno+"&mode="+mode, true);
		x.send();
     }
  
      function getEmployeeAlreadyExists(employeename,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

					if(parseInt(items)==1){
	  					 document.getElementById("errormsg").innerText="Employee Already Exists.";
	  					 return 0;
	  				 }else{
	  					$("#frmEmployeeMaster").submit();
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getEmployeeAlreadyExists.jsp?employeename="+employeename+"&docno="+docno+"&mode="+mode, true);
		x.send();
   }
      
      $(function(){
	        $('#frmEmployeeMaster').validate({
	                rules: {
	                txtemployeename:"required",
	                cmbempdesignation:"required",
	                cmbempdepartment:"required",
	                cmbpayrollcategory:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtemployeename:" *",
	                 cmbempdesignation:" *",
	                 cmbempdepartment:" *",
	                 cmbpayrollcategory:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
 	 
	 function funReadOnly(){
			$('#frmEmployeeMaster input').attr('readonly', true );
			$('#frmEmployeeMaster select').attr('disabled', true);
			$('#employeeDate').jqxDateTimeInput({disabled: true});
			$('#joiningDate').jqxDateTimeInput({disabled: true});
			$('#empDateOfBirth').jqxDateTimeInput({disabled: true});
			
			$("#compensationGridID").jqxGrid({ disabled: true});
			$("#documentsGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmEmployeeMaster input').attr('readonly', false );
			$('#frmEmployeeMaster select').attr('disabled', false);
			$('#employeeDate').jqxDateTimeInput({disabled: false});
			$('#joiningDate').jqxDateTimeInput({disabled: false});
			$('#empDateOfBirth').jqxDateTimeInput({disabled: false});
			$('#txtempaccount').attr('readonly', true );
			$('#txtempaccountname').attr('readonly', true );
			$('#txtempnationality').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			$("#compensationGridID").jqxGrid({ disabled: false});
			$("#documentsGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "A") {
					 $('#employeeDate').val(new Date());
					 $('#joiningDate').val(new Date());
					 $('#empDateOfBirth').val(new Date());
					 document.getElementById("lblemployeestatus").innerText="";
					 
					 $("#compensationGridID").jqxGrid('clear'); 
				     $("#compensationGridID").jqxGrid('addrow', null, {});
				     $("#documentsGridID").jqxGrid('clear'); 
				     $("#documentsGridID").jqxGrid('addrow', null, {});
				     
				     $("#compensationDiv").load("compensationGrid.jsp?mode="+$("#mode").val());
				     $("#documentsDiv").load("documentsGrid.jsp?mode="+$("#mode").val());
			}
			
			if ($("#mode").val() == "E") {
				     $("#compensationGridID").jqxGrid('addrow', null, {});
				     $("#documentsGridID").jqxGrid('addrow', null, {});
				     
				     var indexVal = document.getElementById("docno").value;
					 if(indexVal> 0){
			         	 $("#compensationDiv").load("compensationGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
					     $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
					 } 
			}
	 }
	 function funNotify(){	
		 /* Validation */
		 
		 
		 
		// document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/
		 
		 var rows = $("#compensationGridID").jqxGrid('getrows');
		 var compensationslength=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].allowanceid;
				if(typeof(chk) != "undefined"){
					compensationslength=compensationslength+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtcompensations"+i)
				    .attr("name", "txtcompensations"+i)
				    .attr("hidden", "true");
			
					newTextBox.val(rows[i].allowanceid+" :: "+rows[i].refdtype+" :: "+rows[i].addition+":: "+rows[i].deduction+":: "+rows[i].statutorydeduction+":: "+rows[i].remarks+"::"+rows[i].actualsalary);
					newTextBox.appendTo('form');
			 }
			}
 		 $('#monthlysalarygridlength').val(compensationslength);
 		 
 		var rows = $("#documentsGridID").jqxGrid('getrows');
		 var documentslength=0;
			 for(var i=0 ; i < rows.length ; i++){
				// alert(rows[i].documentid);
				var chkng=rows[i].documentid;
				if(typeof(chkng) != "undefined"){
					documentslength=documentslength+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtdocuments"+i)
				    .attr("name", "txtdocuments"+i)
				    .attr("hidden", "true");
			
					var issueDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'issue_date');
					var expDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'exp_date');
					
			// alert(rows[i].documentid+" :: "+issueDate+" :: "+expDate+":: "+rows[i].place_of_issue+":: "+rows[i].location+":: "+rows[i].remarks+":: "+rows[i].documentno);					
			newTextBox.val(rows[i].documentid+" :: "+issueDate+" :: "+expDate+":: "+rows[i].place_of_issue+":: "+rows[i].location+":: "+rows[i].remarks+":: "+rows[i].documentno);
			
			newTextBox.appendTo('form');
			 }
			}
		 $('#documentsgridlength').val(documentslength);
		
		 employeename=document.getElementById("txtemployeename").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 getEmployeeAlreadyExists(employeename,docno,mode);
	    	
		} 
	 
	 function funSearchLoad(){
			changeContent('empMainSearch.jsp'); 
		 }
	 
	 function funFocus(){
	    	$('#employeeDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
			 if($('#hidemployeeDate').val()){
				 $("#employeeDate").jqxDateTimeInput('val', $('#hidemployeeDate').val());
			  }
			 
			 if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
			
			 if($('#hidjoiningDate').val()){
				 $("#joiningDate").jqxDateTimeInput('val', $('#hidjoiningDate').val());
			  }
			 
			 if($('#hidempDateOfBirth').val()){
				 $("#empDateOfBirth").jqxDateTimeInput('val', $('#hidempDateOfBirth').val());
			  }
			 
			 if($('#hidcmbcurrency').val()!=""){
				 getCurrencyIds();
				 $('#cmbcurrency').val($('#hidcmbcurrency').val());
			 }
			 
			 $('#cmbempsex').val($('#hidcmbempsex').val());
			 $('#cmbempbloodgroup').val($('#hidcmbempbloodgroup').val());
			 $('#cmbempmaritalstatus').val($('#hidcmbempmaritalstatus').val());
			 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
			 
			 if(document.getElementById("lblemployeestatus").innerText.trim()=="TERMINATED"){
				    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
			  } else {
				    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
			  }
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#compensationDiv").load("compensationGrid.jsp?docno="+indexVal);
			     $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal);
			 } 
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 function getEmpMasterconfig(){
		 	var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			  	document.getElementById("empprint").value=items;
	  		}
	  		}
	  		x.open("GET", "getEmpMasterconfig.jsp", true);
	  		x.send();
	    }
	 function funPrintBtn(){
		    var empprint=$('#empprint').val();
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				if(empprint==1)
					{
					PrintContent('printVoucherWindow.jsp');
					}
				
				else
					{
			     if (($("#mode").val() == "view") && $("#docno").val()!="") {
						  
						   var url=document.URL;
						   //alert(url);
				  	   var reurl=url.split("saveEmployeeMaster");
				  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
				    	   var dtype=$('#formdetailcode').val();
				  	   
					   var win= window.open(reurl[0]+"printEmployeeMasterJrxml?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
					     
					   win.focus(); 
					   }else {
				  	      $.messager.alert('Message','Select a Document....!','warning');
				  	      return false;
				  	     } 
					    	     
			}
				
			}	
				
			
			else {
				
				$.messager.alert('Message','Select a Document....!','warning');
				return false;
			}
					    	
				 	}
	 function PrintContent(url) {
		 
			$('#printWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#printWindow').jqxWindow('setContent', data);
			$('#printWindow').jqxWindow('bringToFront');
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
<body onload="setValues();getEmpMasterconfig();getCurrencyIds();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEmployeeMaster" action="saveEmployeeMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset>
<table width="99%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="20%"><div id="employeeDate" name="employeeDate" value='<s:property value="employeeDate"/>'></div>
    <input type="hidden" id="hidemployeeDate" name="hidemployeeDate" value='<s:property value="hidemployeeDate"/>'/></td>
    <td width="19%" align="right">Employee ID</td>
    <td width="17%"><input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Employee ID" style="width:70%;" onblur="getEmployeeCodeAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtemployeeid"/>'/></td>
    <td width="13%" align="center"><i><b><label id="lblemployeestatus"  name="lblemployeestatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC;text-align: right;"><s:property value="lblemployeestatus"/></label></b></i></td>
    <td width="7%" align="right">Doc No </td>
    <td width="19%"><input type="text" id="docno" name="txtempmasterdocno" style="width:70%;" tabindex="-1" value='<s:property value="txtempmasterdocno"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="99%">
    <tr>
    <td width="7%" align="right">Name</td>
    <td><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:95%;" value='<s:property value="txtemployeename"/>'/></td>
    <td align="right">Account </td>
    <td width="14%"><input type="text" id="txtempaccount" name="txtempaccount" style="width:78%;" placeholder="Press F3 to Search" value='<s:property value="txtempaccount"/>' onfocus="getCurrencyIds();" onkeydown="getEmpAccount(event);"/>
    <td colspan="6"><input type="text" id="txtempaccountname" name="txtempaccountname" placeholder="Employee Account Name" style="width:99%;" value='<s:property value="txtempaccountname"/>' tabindex="-1"/>    
    <input type="hidden" id="txtempaccdocno" name="txtempaccdocno" value='<s:property value="txtempaccdocno"/>'/></td>
    <td width="9%"><select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td width="5%" align="right">Date of Joining</td>
    <td width="14%"><div id="joiningDate" name="joiningDate" value='<s:property value="joiningDate"/>'></div>
    <input type="hidden" id="hidjoiningDate" name="hidjoiningDate" value='<s:property value="hidjoiningDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Designation</td>
    <td width="14%"><select id="cmbempdesignation" name="cmbempdesignation" style="width:96%;" value='<s:property value="cmbempdesignation"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/></td>
    <td width="7%" align="right">Department</td>
    <td colspan="2"><select id="cmbempdepartment" name="cmbempdepartment" style="width:96%;" value='<s:property value="cmbempdepartment"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/></td>
      <td width="12%" align="right">Payroll Category</td>
      <td colspan="3"><select id="cmbpayrollcategory" name="cmbpayrollcategory" style="width:98%;" value='<s:property value="cmbpayrollcategory"/>'>
        <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/></td>
      <td width="5%" align="right">Cost/Hour</td>
       <td><input type="text" id="txtempcostperhour" name="txtempcostperhour" style="width:90%;text-align: right;" placeholder="Cost Per Hour" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtempcostperhour"/>'/></td>
    <td align="right">Travels</td>
    <td><input type="text" id="txtemptravels" name="txtemptravels" style="width:70%;text-align: right;" placeholder="Travels" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtemptravels"/>'/></td>
  </tr>
  <tr>
     <td width="7%" align="right">Est. Code</td>
    <td><input type="text" id="txtest_code" name="txtest_code" placeholder="Establishment Code" style="width:95%;" value='<s:property value="txtest_code"/>'/></td>
    <td width="7%" align="right">Company Name</td>
    <td><input type="text" id="txtco_name" name="txtco_name" placeholder="Company Name" style="width:95%;" value='<s:property value="txtco_name"/>'/></td>
    <td width="7%" align="right">Qualification</td>
    <td><input type="text" id="txtqualification" name="txtqualification" placeholder="Qualification" style="width:95%;" value='<s:property value="txtqualification"/>'/></td>
  </tr>
</table>
</fieldset>


 <div class="panel panel-default">
    <div class="panel-heading">Personal Details</div>
    <div class="panel-body"> 
<table width="99.5%"  >
   <tr >
    <td align="right">Permanent Address</td>
    <td colspan="5" align="left"><input type="text" id="txtpermanentaddress" name="txtpermanentaddress" placeholder="Permanent Address" style="width:100%;" value='<s:property value="txtpermanentaddress"/>'/></td>
    <td align="right">Present Address</td>
    <td colspan="5" align="left"><input type="text" id="txtpresentaddress" name="txtpresentaddress" placeholder="Present Address" style="width:100%;" value='<s:property value="txtpresentaddress"/>'/></td>
  </tr>
  <tr >
    <td align="right">Mobile</td>
    <td><input type="text" id="txtpermanentmobile" name="txtpermanentmobile" placeholder="Permanent Mobile" style="width:100%;" value='<s:property value="txtpermanentmobile"/>'/></td>
    <td align="right">Email</td>
    <td colspan="3"><input type="text" id="txtpermanentemail" name="txtpermanentemail" placeholder="Permanent Email ID" style="width:100%;" value='<s:property value="txtpermanentemail"/>'/></td>
    <td align="right">Mobile</td>
    <td><input type="text" id="txtpresentmobile" name="txtpresentmobile" placeholder="Present Mobile" style="width:100%;" value='<s:property value="txtpresentmobile"/>'/></td>
    <td align="right">Email</td>
    <td colspan="3"><input type="text" id="txtpresentemail" name="txtpresentemail" placeholder="Present Email ID" style="width:100%;" value='<s:property value="txtpresentemail"/>'/></td>
  </tr>
  <tr  >
    <td width="7%" align="right">City</td>
    <td width="9%"><input type="text" id="txtempcity" name="txtempcity" placeholder="City" style="width:100%;" value='<s:property value="txtempcity"/>'/></td>
    <td width="7%" align="right">State</td>
    <td width="9%"><input type="text" id="txtempstate" name="txtempstate" placeholder="State" style="width:100%;" value='<s:property value="txtempstate"/>'/></td>
    <td width="7%" align="right">Pincode</td>
    <td width="9%"><input type="text" id="txtemppincode" name="txtemppincode" placeholder="Pincode" style="width:100%;" value='<s:property value="txtemppincode"/>'/></td>
    <td width="7%" align="right">Nationality</td>
    <td width="9%"><input type="text" id="txtempnationality" name="txtempnationality" style="width:100%;" placeholder="Press F3 to Search" value='<s:property value="txtempnationality"/>'  onkeydown="getNations(event);"/>
    <input type="hidden" id="txtempnationalityid" name="txtempnationalityid" value='<s:property value="txtempnationalityid"/>'/></td>
    <td width="7%" align="right">Religion</td>
    <td width="9%"><input type="text" id="txtempreligion" name="txtempreligion" placeholder="Religion" style="width:100%;" value='<s:property value="txtempreligion"/>'/></td>
    <td width="7%" align="right">Nearest Airport</td>
    <td width="9%"><input type="text" id="txtempnearestairport" name="txtempnearestairport" placeholder="Nearest Airport" style="width:100%;" value='<s:property value="txtempnearestairport"/>'/></td>
  </tr>
  <tr >
    <td align="right">Place of Birth</td>
    <td><input type="text" id="txtempplaceofbirth" name="txtempplaceofbirth" placeholder="Place of Birth" style="width:100%;" value='<s:property value="txtempplaceofbirth"/>'/></td>
    <td align="right">Date of Birth</td>
    <td><div id="empDateOfBirth" name="empDateOfBirth" value='<s:property value="empDateOfBirth"/>'></div>
    <input type="hidden" id="hidempDateOfBirth" name="hidempDateOfBirth" value='<s:property value="hidempDateOfBirth"/>'/></td>
    <td align="right">Sex</td>
    <td><select id="cmbempsex" name="cmbempsex" style="width:100%;" value='<s:property value="cmbempsex"/>'>
      <option value="">--Select--</option><option value="M">Male</option><option value="F">Female</option></select>
      <input type="hidden" id="hidcmbempsex" name="hidcmbempsex" value='<s:property value="hidcmbempsex"/>'/></td>
    <td align="right">Blood Group</td>
    <td><select id="cmbempbloodgroup" name="cmbempbloodgroup" style="width:70%;" value='<s:property value="cmbempbloodgroup"/>'>
      <option value="">--Select--</option><option value="O +ve">O Positive</option><option value="O -ve">O Negative</option><option value="A +ve">A Positive</option>
      <option value="A -ve">A Negative</option><option value="B +ve">B Positive</option><option value="B -ve">B Negative</option><option value="AB +ve">AB Positive</option>
      <option value="AB -ve">AB Negative</option></select>
      <input type="hidden" id="hidcmbempbloodgroup" name="hidcmbempbloodgroup" value='<s:property value="hidcmbempbloodgroup"/>'/></td>
    <td align="right">Marital Status</td>
    <td colspan="3"><select id="cmbempmaritalstatus" name="cmbempmaritalstatus" style="width:38%;" value='<s:property value="cmbempmaritalstatus"/>'>
      <option value="">--Select--</option><option value="SINGLE">Single</option><option value="MARRIED">Married</option></select>
      <input type="hidden" id="hidcmbempmaritalstatus" name="hidcmbempmaritalstatus" value='<s:property value="hidcmbempmaritalstatus"/>'/></td>
  </tr>
  <tr >
    <td align="right">Father's Name</td>
    <td><input type="text" id="txtempfathername" name="txtempfathername" placeholder="Father's Name" style="width:100%;" value='<s:property value="txtempfathername"/>'/></td>
    <td align="right">Mother's Name</td>
    <td><input type="text" id="txtempmothername" name="txtempmothername" placeholder="Mother's Name" style="width:100%;" value='<s:property value="txtempmothername"/>'/></td>
    <td align="right">Spouse's Name</td>
    <td><input type="text" id="txtempspousename" name="txtempspousename" placeholder="Spouse's Name" style="width:100%;" value='<s:property value="txtempspousename"/>'/></td>
    <td align="right">Other Details</td>
    <td colspan="5"><input type="text" id="txtempotherdetails" name="txtempotherdetails" placeholder="Other Details" style="width:100%;" value='<s:property value="txtempotherdetails"/>'/></td>
  </tr>
</table>
 </div>
  </div>

 <div class="panel panel-default">
    <div class="panel-heading">Bank Details</div>
    <div class="panel-body"> 
<table width="99%">
  <tr>
    <td width="6%" align="right">Agent ID</td>
    <td width="10%"><select id="cmbempagentid" name="cmbempagentid" style="width:100%;" value='<s:property value="cmbempagentid"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbempagentid" name="hidcmbempagentid" value='<s:property value="hidcmbempagentid"/>'/></td>
    <td width="6%" align="right">Employee ID</td>
    <td width="10%"><input type="text" id="txtbankemployeeid" name="txtbankemployeeid" placeholder="Employee ID" style="width:95%;" value='<s:property value="txtbankemployeeid"/>'/></td>
    <td width="7%" align="right">Bank Account No.</td>
    <td width="8%"><input type="text" id="txtbankaccountno" name="txtbankaccountno" placeholder="Bank Account No." style="width:98%;" value='<s:property value="txtbankaccountno"/>'/></td>
  <td width="7%" align="right">Branch Name</td>
  <td width="12%"><input type="text" id="txtbankbranchname" name="txtbankbranchname" placeholder="Branch Name" style="width:100%;" value='<s:property value="txtbankbranchname"/>'/></td>
  <td width="7%" align="right">IFSC Code</td>
  <td width="10%"><input type="text" id="txtbankifsccode" name="txtbankifsccode" placeholder="IFSC Code" style="width:90%;" value='<s:property value="txtbankifsccode"/>'/></td>
  </tr>
</table>
</div></div>


 <div class="panel panel-default">
    <div class="panel-heading">Monthly Salary</div>
    <div class="panel-body"> 
<div id="compensationDiv"><jsp:include page="compensationGrid.jsp"></jsp:include></div><br/>
</div></div>

 <div class="panel panel-default">
    <div class="panel-heading">Documents</div>
    <div class="panel-body"> 
<div id="documentsDiv"><jsp:include page="documentsGrid.jsp"></jsp:include></div><br/>
</div></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="monthlysalarygridlength" name="monthlysalarygridlength"/>
<input type="hidden" id="documentsgridlength" name="documentsgridlength"/>
<input type="hidden" id="empprint" name="empprint"/>

</div>
</form>
<div id="accountDetailsWindow">
   <div></div>
</div>
<div id="nationalityWindow">
   <div></div>
</div>
<div id="printWindow"><div></div></div>
</div>
</body>
</html>
