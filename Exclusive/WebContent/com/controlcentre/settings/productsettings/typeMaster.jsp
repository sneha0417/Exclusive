<% String contextPath=request.getContextPath();%>
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
	$('#btnSearch').attr('disabled', true);
	 $("#ptmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	 
      		document.getElementById("formdet").innerText="Type Master(PTM)";
    		document.getElementById("formdetail").value="Type Master";
    		document.getElementById("formdetailcode").value="PTM";
    		window.parent.formCode.value="PTM";
    		window.parent.formName.value="Type Master";
    		
  });
	
	function funFocus(){
		document.getElementById("ptmtype").focus();
	}
	
	function funReadOnly() {
		$('#frmptm input').attr('readonly', true);
		$('#ptmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmptm input').attr('readonly', false);
		$('#ptmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#ptmdate').val()){
			$("#ptmdate").jqxDateTimeInput('val', $('#ptmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	    
	function funNotify(){
		if(document.getElementById("ptmtype").value==''){
			document.getElementById("errormsg").innerText="Product Type is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  

</script>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmptm" action="saveptmAction" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Product Type Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="ptmdate" name="ptmdate" value='<s:property value="ptmdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td><input type="text" name="ptmtype" id="ptmtype" placeholder="Product Type" value='<s:property value="ptmtype"/>' ></td>
   <td><input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr>
   <td>
   
   <div id="grpgrid"><jsp:include page="typeGrid.jsp"></jsp:include></div> 
   </td>
  </tr>
</table>

<input type="hidden" name="hidfgmdate" id="hidfgmdate" value='<s:property value="hidfgmdate"/>'/>
</form>
</div>
<br/> 
	
</body>
</html>