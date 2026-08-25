<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function () {
	 
	 $("#termsdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	  document.getElementById("formdet").innerText="Terms(CTT)";
	  document.getElementById("formdetail").value="Terms";
	  document.getElementById("formdetailcode").value="CTT";
	  window.parent.formCode.value="CTT";
      window.parent.formName.value="Terms";
    });
   function funSearchLoad(){
		changeContent('termsSearch.jsp'); 
	 }    
	function funReadOnly(){
		$('#frmterms input').attr('readonly', true );
		$('#termsdate').jqxDateTimeInput({ disabled: true}); 
		$('#frmterms select').attr('disabled', true );
	}

	function funRemoveReadOnly(){
		$('#frmterms input').attr('readonly', false );
		$('#termsdate').jqxDateTimeInput({ disabled: false}); 
		$('#frmterms select').attr('disabled', false );
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#servicedate').val(new Date());
			
		}
	
    	
	
	}
	function funNotify(){
		 if(document.getElementById("code").value==''){
				document.getElementById("errormsg").innerText="Code is Mandatory.";
				return 0;
			}
		 if(document.getElementById("name").value==''){
				document.getElementById("errormsg").innerText="Name is Mandatory.";
				return 0;
			}
		
		return 1;
	}
	function funChkButton() {
		   /* funReset(); */
    }
	  
	function setValues() {
	
		if($('#hidtermsdate').val()){
			$("#termsdate").jqxDateTimeInput('val', $('#termsdate').val());
		  }
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 $('#termsdiv').load("termsGrid.jsp?check=1");
	   
	}

	function funFocus(){
		document.getElementById("code").focus();
	}
	function getMode() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var mode = items[1].split(",");
				var optionsmode = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < mode.length; i++) {
					optionsmode += '<option value="' + srno[i].trim() + '">'
							+ mode[i] + '</option>';
				}
				$("select#cmbmode").html(optionsmode);
				if ($('#hidcmbmode').val() != null) {
					$('#cmbmode').val($('#hidcmbmode').val());
				}
			} else {}
		}
		x.open("GET","getMode.jsp", true);
		x.send();
	}
	 
</script>
</head>
<body onload="setValues();getMode();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmterms" action="saveTerms11"  autocomplete="off">
<jsp:include page="../../../header.jsp" /><br/> 

<fieldset>
<legend>Terms</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="termsdate" name="termsdate" value='<s:property value="termsdate"/>'></div></td>
    <td  align="right">Code</td>
    <td width="27%"><input type="text" id="code" name="code" value='<s:property value="code"/>'></td>
   
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
    </tr>
     <tr>
    <td width="7%" align="right">Name</td>
    <td width="27%"><input type="text" id="name" name="name" value='<s:property value="name"/>'></td>
   
   <td align="right">Mode</td>
    <td width="22%"><select id="cmbmode" name="cmbmode" style="width:71%;" value='<s:property value="cmbmode"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbmode" name="hidcmbmode" value='<s:property value="hidcmbmode"/>'/>
      <input type="hidden" id="hidmodetype" name="hidmodetype" value='<s:property value="hidmodetype"/>'/></td>
 
   </tr>
    </table>
</fieldset>
<div id="termsdiv"><jsp:include page="termsGrid.jsp"></jsp:include></div>


<input type="hidden" name="hidtermsdate" id="hidtermsdate" value='<s:property value="hidtermsdate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>

</form>
</body>
</html>