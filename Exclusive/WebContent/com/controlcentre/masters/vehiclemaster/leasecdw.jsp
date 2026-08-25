<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.custom-checkbox{
	width: 15px; 
	height: 15px;
	border: 1px solid #aaa;
  background: #f8f8f8;
  border-radius: 5px;
  box-shadow: inset 0 1px 3px rgba(0,0,0,.3);
  transition: all .2s;
}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    document.getElementById("formdet").innerText="Lease CDW(LCDW)";
		document.getElementById("formdetail").value="Lease";
		document.getElementById("formdetailcode").value="LCDW";
		window.parent.formCode.value="LCDW";
		window.parent.formName.value="Lease CDW";
		
        });
	function funSearchLoad(){
		changeContent('leaseCDWSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	
	
	function funReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', true);
		$('#chkreplace').attr('disabled', true);
		$('#chkexscdw').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
	}
	
	
	function funRemoveReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false});
		$('#chkreplace').attr('disabled', false);
		$('#chkexscdw').attr('disabled', false);
		$('#docno').attr('readonly', true);
		SetReplaceValue();
		 SetExcseecdwValue()
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		 if(document.getElementById("hidchkreplace").value=="1"){
			 document.getElementById("chkreplace").checked=true;
		 }
		 else{
			 document.getElementById("chkreplace").checked=false;
		 }
		 
		 
		  if(document.getElementById("hidchkexscdw").value=="1"){
			 document.getElementById("chkexscdw").checked=true;
		 }
		 else{
			 document.getElementById("chkexscdw").checked=false;
		 } 

		$('#leasecdwdiv').load('leaseCDWGrid.jsp');
	}
	
	 $(function(){
	        $('#frmLeaseCDW').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:100
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 100 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		 
	  }
	  function SetReplaceValue(){
		  if(document.getElementById("chkreplace").checked==true){
			  document.getElementById("hidchkreplace").value="1";
			 
		  }
		  else{
			  document.getElementById("hidchkreplace").value="0";
		  }
		  
		 
		
	  }
	  function SetExcseecdwValue(){
		
		  if(document.getElementById("chkexscdw").checked==true){
			  document.getElementById("hidchkexscdw").value="1";
			   
		  }
		  else{
			  document.getElementById("hidchkexscdw").value="0";
		  }
		  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmLeaseCDW" action="saveLeaseCDW" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Lease CDW Details</legend>
	<table width="100%">
		<tr><td width="7%" align="right">Date</td>
			<td width="29%"  align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>
		  	</td>
			<td width="50%" align="right">Doc No</td>
			<td width="14%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr>
			<td align="right">Name</td>
			<td><input type="text" name="name" id="name"  value='<s:property value="name"/>' style="width:100%;"></td>
			<td >&nbsp; &nbsp; &nbsp; &nbsp;
			<input type="checkbox" name="chkexscdw" id="chkexscdw" class="custom-checkbox" onchange="SetExcseecdwValue();">&nbsp;
            <label for="chkexscdw">Excess CDW</label>&nbsp; &nbsp; &nbsp; &nbsp;
            
            <input type="checkbox" name="chkreplace" id="chkreplace" class="custom-checkbox" onchange="SetReplaceValue();">&nbsp;
            <label for="chkreplace">Replacement</label>
            </td>
			<td>&nbsp;</td>
            </tr>

			<tr>
				<td align="right">Description</td>
                <td colspan="3" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:97%;"></td>
            </tr>
			<tr>
			  <td align="right">Remarks</td>
			  <td colspan="3" align="left"><input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>' style="width:97%;"></td>
	  </tr>
	</table>
	</fieldset>
    <br>
    <table width="100%">
  <tr>
    <td><div id="leasecdwdiv"><jsp:include page="leaseCDWGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" name="hidchkreplace" id="hidchkreplace" value='<s:property value="hidchkreplace"/>'/>
<input type="hidden" name="hidchkexscdw" id="hidchkexscdw" value='<s:property value="hidchkexscdw"/>'/>

	</form>
</body>
</html>