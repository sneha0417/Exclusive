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
	 $("#date").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	 
      		document.getElementById("formdet").innerText="Department Master(DPM)";
    		document.getElementById("formdetail").value="Department Master";
    		document.getElementById("formdetailcode").value="DPM";
    		window.parent.formCode.value="DPM";
    		window.parent.formName.value="Department Master";
  });
	
	function funFocus(){
		document.getElementById("dept").focus();
	}
	
	function funReadOnly() {
		$('#frmdept input').attr('readonly', true);
		$('#date').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmdept input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#date').val()){
			$("#date").jqxDateTimeInput('val', $('#date').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	    
	function funNotify(){
		if(document.getElementById("dept").value==''){
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
<form id="frmdept" action="savedeptAction" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Department Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Department</td>
    <td><input type="text" name="dept" id="dept" placeholder="Department" value='<s:property value="dept"/>' ></td>
  
  
<td><input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr>
   <td>
   
   <div id="dptgrid"><jsp:include page="deptGrid.jsp"></jsp:include></div> 
   </td>
  </tr>
</table>


</form>
</div>
<br/> 
	
</body>
</html>