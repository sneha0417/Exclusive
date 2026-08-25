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
		  
		  document.getElementById("formdet").innerText="PackageType(PAT)";
   		  document.getElementById("formdetail").value="PackageType";
   		  document.getElementById("formdetailcode").value="PAT";
   		  window.parent.formCode.value="PAT";
   		  window.parent.formName.value="PackageType";
   		  
		});
	
	
	 
	
	function funReadOnly(){
		$('#frmPackageType input').attr('readonly', true );
		$("#jqxPackage").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmPackageType input').attr('readonly', false );
		$('#docno').attr('readonly', true);
		$("#jqxPackage").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        /*$("#jqxPackage").jqxGrid('clear');
	        $("#jqxPackage").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	        $('#code').attr('readonly', false);
	     }
		
		if ($("#mode").val() == "E") {
			$("#jqxPackage").jqxGrid('addrow', null, {});
		}
		
	}
	
	
	function funNotify(){
		
		if(document.getElementById("name").value==''){
			document.getElementById("errormsg").innerText="Enter packagetype.";
			return false;
		}
		
		if(document.getElementById("code").value==''){
			document.getElementById("errormsg").innerText="Enter code.";
			return false;
		}
		if(document.getElementById("descr").value==''){
			document.getElementById("errormsg").innerText="Enter description.";
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
	
	
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmPackageType" action="saveActionPackageType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Package Type</legend>
<table width="100%">
  <tr>
    <td width="15%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" style="width: 200px;" placeholder="Name" value='<s:property value="name"/>' style="width:81%;" ></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="code" name="code" style="width: 200px;" placeholder="Code" value='<s:property value="code"/>'/></td>
    <td width="15%" align="right">Description</td>
    <td width="33%"><input type="text" name="descr" id="descr" placeholder="Description" value='<s:property value="descr"/>' style="width:81%;" ></td>
  </tr>
  <tr>
  </tr>
</table>
</fieldset><br/>
 <div id="packagediv"><jsp:include page="packagetypeGrid.jsp"></jsp:include></div>

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

