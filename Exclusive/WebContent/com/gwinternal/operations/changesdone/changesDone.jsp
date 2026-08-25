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
		 $('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 
		 $("#changesDoneDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 getProjects();
	});
	
	function getProjects() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var projectNameItems = items[0].split(",");
  				var projectIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < projectNameItems.length; i++) {
  					optionsproject += '<option value="' + projectIdItems[i] + '">'
  							+ projectNameItems[i] + '</option>';
  				}
  				$("select#cmbproject").html(optionsproject);
  				if ($('#hidcmbproject').val() != null) {
  					$('#cmbproject').val($('#hidcmbproject').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getProjects.jsp", true);
  		x.send();
  	}
	
	 function funReadOnly(){
			$('#frmChangesDone input').attr('readonly', true );
			$('#frmChangesDone select').attr('disabled', true);
			$('#changesDoneDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmChangesDone input').attr('readonly', false );
			$('#frmChangesDone select').attr('disabled', false);
			$('#changesDoneDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#changesDoneDate').val(new Date());
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('chngMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus() {
	    	$('#changesDoneDate').jqxDateTimeInput('focus'); 	    		
	  }
	 
	  /* Validations */
	  $(function(){
	        $('#frmChangesDone').validate({
	                rules: {
	                cmbproject:"required",
	                txtchangedformname:"required",
	                txtchangedformfiles:"required",
	                txtchangedformdescription:{maxlength:500}
	                 },
	                 messages: {
	                 cmbproject:" *",
	                 txtchangedformname:" *",
	                 txtchangedformfiles:" *",
	                 txtchangedformdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  /* Validation */
		    
		  if($('#txtchangedformname').val()==""){
			    document.getElementById("errormsg").innerText="Form Name is Mandatory";
				return 0;
		  }
		  
		  if($('#txtchangedformpath').val()==""){
			    document.getElementById("errormsg").innerText="File Path is Mandatory";
				return 0;
		  }
		  
		  if($('#txtchangedformfiles').val()==""){
			    document.getElementById("errormsg").innerText="Files to be Copied is Mandatory";
				return 0;
		  }
		  
		  if($('#txtchangedformdescription').val()==""){
			    document.getElementById("errormsg").innerText="Description is Mandatory";
				return 0;
		  }
	 		
	      document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
	  				 
	    		return 1;
		} 
	  
	  function setValues(){

		  if($('#hidchangesDoneDate').val()){
				 $("#changesDoneDate").jqxDateTimeInput('val', $('#hidchangesDoneDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			 
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
<form id="frmChangesDone" action="saveChangesDone" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset style="background-color: #EBDEF0;">
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="changesDoneDate" name="changesDoneDate" value='<s:property value="changesDoneDate"/>'></div>
    <input type="hidden" id="hidchangesDoneDate" name="hidchangesDoneDate" value='<s:property value="hidchangesDoneDate"/>'/></td>
    <td align="right">Project</td>
    <td><select id="cmbproject" name="cmbproject" style="width:71%;" value='<s:property value="cmbproject"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbproject" name="hidcmbproject" value='<s:property value="hidcmbproject"/>'/></td>
    <td width="14%" align="right">Doc No</td>
    <td width="20%"><input type="text" id="docno" name="txtchangesdonedocno" style="width:50%;" value='<s:property value="txtchangesdonedocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Form</td>
    <td><input type="text" id="txtchangedformname" name="txtchangedformname" style="width:98%;" value='<s:property value="txtchangedformname"/>'/></td>
    <td width="25%" align="right">File Path</td>
    <td width="21%"><input type="text" id="txtchangedformpath" name="txtchangedformpath" style="width:95%;" value='<s:property value="txtchangedformpath"/>'/></td>
    <td align="right">Query File</td>
    <td><input type="text" id="txtchangedformquery" name="txtchangedformquery" style="width:95%;" value='<s:property value="txtchangedformquery"/>'/></td>
  </tr>
  <tr>
    <td align="right">To be Copied</td>
    <td colspan="2"><input type="text" id="txtchangedformfiles" name="txtchangedformfiles" style="width:95%;" value='<s:property value="txtchangedformfiles"/>'/></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtchangedformdescription" name="txtchangedformdescription" style="width:98%;" value='<s:property value="txtchangedformdescription"/>'/></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
	

</div>
</body>
</html>
