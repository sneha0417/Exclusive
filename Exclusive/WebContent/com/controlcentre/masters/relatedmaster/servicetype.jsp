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
		  
		  
		  document.getElementById("formdet").innerText="ServiceTpe(SERT)";
   		  document.getElementById("formdetail").value="ServiceType";
   		  document.getElementById("formdetailcode").value="SERT";
   		  window.parent.formCode.value="SERT";
   		  window.parent.formName.value="ServiceType";
   		  
		});
	
	
	 
	
	function funReadOnly(){
		$('#frmServiceType input').attr('readonly', true );
		$("#jqxService").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmServiceType input').attr('readonly', false );
		$('#docno').attr('readonly', true);
		$("#jqxService").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        /*$("#jqxService").jqxGrid('clear');
	        $("#jqxService").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	       
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxService").jqxGrid('addrow', null, {});
		}
		 */
		
	}
	
	
	function funNotify(){
		
		if(document.getElementById("name").value==''){
			document.getElementById("errormsg").innerText="Enter a servicetype.";
			return false;
		}
		
		
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	

		  
	function setValues() {
		if(document.getElementById("txthidtype").value!=""){
		//alert(document.getElementById("txthidtype").value);
		document.getElementById("txttype").value=document.getElementById("txthidtype").value;
		//alert(document.getElementById("txttype").value);
		}
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
<form id="frmServiceType" action="saveActionServiceType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Service Type</legend>
<table width="100%">
  <tr>
    <td align="right">Name</td>
    <td ><input type="text" name="name" id="name" placeholder="Name" value='<s:property value="name"/>'></td>
    <td align="right">Tax Type</td>
    <td><select id="txttype" name="txttype" value='<s:property value="txttype"/>'>
        <option value="">--Select--</option> <option value="2">Vat 0</option> <option value="1">Vat 5</option></select>
        <input type="hidden" id="txthidtype" name="txthidtype" value='<s:property value="txthidtype"/>'/></td>
    <td align="right">Doc No.</td>
    <td ><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
 
  
</table>
</fieldset><br/>
 <div id="servicediv"><jsp:include page="servicetypeGrid.jsp"></jsp:include></div>

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

