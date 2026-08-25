<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function () {     
		  $('#btnExcel').attr({ disabled: true});
		  $('#btnSearch').attr({ disabled: true});
		  
		
		  
		  document.getElementById("formdet").innerText="VisaType(VISA)";
   		  document.getElementById("formdetail").value="VisaType";
   		  document.getElementById("formdetailcode").value="VISA";
   		  window.parent.formCode.value="VISA";
   		  window.parent.formName.value="VisaType";
   		  
		});
	
	
	 
	
	function funReadOnly(){
		$('#frmVisaType input').attr('readonly', true );
		$("#jqxVisa").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmVisaType input').attr('readonly', false );
		$('#docno').attr('readonly', true);
		$("#jqxVisa").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        /* $("#jqxVisa").jqxGrid('clear');
	        $("#jqxVisa").jqxGrid('addrow', null, {}); */
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	        $('#code').attr('readonly', false);
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxVisa").jqxGrid('addrow', null, {});
		} */
		
	}
	
	
	function funNotify(){
		
		if(document.getElementById("name").value==''){
			document.getElementById("errormsg").innerText="Enter visatype.";
			return false;
		}
		
		if(document.getElementById("validity").value==''){
			document.getElementById("errormsg").innerText="Enter validity.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
			
			
	
		   
	}
	
	function funFocus(){
		document.getElementById("name").focus();
	}
	
	/* function funSearchLoad(){
		changeContent('staffSearch.jsp'); 
	 } */
	 
	 /*  $(function(){
		    $('#frmStaff').validate({
	            rules: {
	            code: {required:true,maxlength:10},
	            name:{required:true,maxlength:40},
	            txtaccname:{required:true},
	            mail:{email:true}
	            },
	            messages: {
	             code:{required:" *",maxlength:"Max 10 Chars"},
	             name:{required:" *",maxlength:"Max 40 Chars"},
	             txtaccname:{required:" *"},
	             mail:{email:"Not a valid Email."}
	             }
	   });});  */
	 
	 function funExcelBtn(){
		   	if(document.getElementById("docno").value!=""){
		   		
		   		$("#jqxVisa").jqxGrid('exportdata', 'xls', 'Staff '+document.getElementById("name").value);	
		   	} 
		   	else{
		   	 $.messager.alert('Warning','Select a valid Document');
		   	 return false;
		   	}
			
		   }
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmVisaType" action="saveActionVisaType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Visa Type</legend>
<table width="100%">
  <tr>
    <td width="15%" align="right">Name</td>
    <td width="15%"><input type="text" name="name" id="name" style="width: 200px;" placeholder="Name" value='<s:property value="name"/>' style="width:81%;" ></td>
    
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Validity</td>
    <td width="15%"><input type="text" id="validity" name="validity" style="width: 200px;" placeholder="Validity" value='<s:property value="validity"/>'/></td>
  </tr>
  <tr>
   <%--  <td align="right">Account</td>
    <td><input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search"></td>
    <td colspan="4"><input type="text" name="txtaccname" style="width:53%;" id="txtaccname" value='<s:property value="txtaccname"/>' readonly></td> --%>
  </tr>
</table>
</fieldset><br/>
 <div id="visadiv"><jsp:include page="visatypeGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidservicedate" id="hidservicedate" value='<s:property value="hidservicedate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
 <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>

</form>

<div id="accountWindow">
	<div ></div>
</div>

<div id="nationalityWindow">
   <div></div>
</div>	

<div id="stateWindow">
   <div></div>
</div>
</div>

</body>
</html>

