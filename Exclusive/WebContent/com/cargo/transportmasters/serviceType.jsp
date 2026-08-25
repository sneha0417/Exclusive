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
	 
	 $("#servicedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	  document.getElementById("formdet").innerText="Service Type(CST)";
	  document.getElementById("formdetail").value="Service Type";
	  document.getElementById("formdetailcode").value="CST";
	  window.parent.formCode.value="CST";
      window.parent.formName.value="Service Type";
    });
    
 
function funSearchLoad(){
	changeContent('serviceTypeSearch.jsp'); 
 }
    
	function funReadOnly(){
			$('#frmServiceType input').attr('readonly', true );
			$('#frmServiceType select').attr('disabled', true );
			$('#servicedate').jqxDateTimeInput({ disabled: true}); 
	}

	function funRemoveReadOnly(){
			$('#frmServiceType input').attr('readonly', false );
			$('#frmServiceType select').attr('disabled', false );
			$('#servicedate').jqxDateTimeInput({ disabled: false}); 
			$('#docno').attr('readonly', true);

			if ($("#mode").val() == "A") {
				$('#servicedate').val(new Date());
			}
	
	
	 }
	 function funNotify(){
		 if(document.getElementById("servicetype").value==''){
				document.getElementById("errormsg").innerText="Service Type is Mandatory.";
				return 0;
			}
		
		 
		 
			return 1;
	 }
	function funChkButton() {
		   /* funReset(); */
	 }
	  
	function setValues() {
		 
		if($('#hidservicedate').val()){
				$("#servicedate").jqxDateTimeInput('val', $('#servicedate').val());
		  }
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		 }
	    
		 $('#servicetypediv').load("serviceTypeGrid.jsp?check=1");
		 
      }

	function funFocus(){
			document.getElementById("servicetype").focus();
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
					getSubMode();
				}
			} else {}
		}
		x.open("GET","getMode.jsp", true);
		x.send();
	}
	function getSubMode() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var submode = items[1].split(",");
				var optionssubmode = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < submode.length; i++) {
					optionssubmode += '<option value="' + srno[i].trim() + '">'
							+ submode[i] + '</option>';
				}
				$("select#cmbsubmode").html(optionssubmode);
				if ($('#hidcmbsubmode').val() != null) {
					$('#cmbsubmode').val($('#hidcmbsubmode').val());
				}
			} else {}
		}
		x.open("GET","getSubMode.jsp?modeid="+$('#cmbmode').val(), true);
		x.send();
	}
	function getShipment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var shipment = items[1].split(",");
				var optionsshipment = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < shipment.length; i++) {
					optionsshipment += '<option value="' + srno[i].trim() + '">'
							+ shipment[i] + '</option>';
				}
				$("select#cmbshipment").html(optionsshipment);
				if ($('#hidcmbshipment').val() != null) {
					$('#cmbshipment').val($('#hidcmbshipment').val());
				}
			} else {}
		}
		x.open("GET","getShipment.jsp", true);
		x.send();
	}

	 
</script>
</head>


<body onload="setValues();getMode();getShipment();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmServiceType" action="saveService1"  autocomplete="off">
<jsp:include page="../../../header.jsp" /><br/> 

<fieldset>
<legend>Service Type</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="servicedate" name="servicedate" value='<s:property value="servicedate"/>'></div></td>
    <td width="7%">Service Type</td>
    <td width="27%"><input type="text" id="servicetype" name="servicetype" value='<s:property value="servicetype"/>' readonly tabindex="-1"></td>
  
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
   
  </tr>
  <tr>
    <td align="right">Mode</td>
    <td width="22%"><select id="cmbmode" name="cmbmode" onchange="getSubMode();" style="width:71%;" value='<s:property value="cmbprocess"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbmode" name="hidcmbmode" value='<s:property value="hidcmbmode"/>'/>
      <input type="hidden" id="hidmodetype" name="hidmodetype" value='<s:property value="hidmodetype"/>'/></td>
  
   <td align="right">Sub Mode</td>
    <td width="22%"><select id="cmbsubmode" name="cmbsubmode" style="width:71%;" value='<s:property value="cmbsubmode"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbsubmode" name="hidcmbsubmode" value='<s:property value="hidcmbsubmode"/>'/>
      <input type="hidden" id="hidsubmodetype" name="hidsubmodetype" value='<s:property value="hidsubmodetype"/>'/></td>
   
   <td align="right">Shipment</td>
    <td width="22%"><select id="cmbshipment" name="cmbshipment" style="width:71%;" value='<s:property value="cmbshipment"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbshipment" name="hidcmbshipment" value='<s:property value="hidcmbshipment"/>'/>
      <input type="hidden" id="hidshipmenttype" name="hidshipmenttype" value='<s:property value="hidshipmenttype"/>'/></td>
   
   </tr>
 
</table>
</fieldset><br/>
<div id="servicetypediv"><jsp:include page="serviceTypeGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidservicedate" id="hidservicedate" value='<s:property value="hidservicedate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</form>
</div>
</body>
</html>