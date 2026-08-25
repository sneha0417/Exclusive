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
	 		  
		  $("#rdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		  
		
		  
		  document.getElementById("formdet").innerText="RoomType(RMT)";
   		  document.getElementById("formdetail").value="RoomType";
   		  document.getElementById("formdetailcode").value="RMT";
   		  window.parent.formCode.value="RMT";
   		  window.parent.formName.value="RoomType";
   		  
		});
	
	
	 
	
	function funReadOnly(){
		$('#frmRoomType input').attr('readonly', true );
		$('#rdate').jqxDateTimeInput({ disabled: true}); 
		$("#jqxRoom").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmRoomType input').attr('readonly', false );
		$('#rdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$("#jqxRoom").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	       /* $("#jqxRoom").jqxGrid('clear');
	        $("#jqxRoom").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	        $('#code').attr('readonly', false);
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxRoom").jqxGrid('addrow', null, {});
		} */
		
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	
	function funNotify(){
		
		if(document.getElementById("name").value==''){
			document.getElementById("errormsg").innerText="Enter roomtype";
			return false;
		}
		
		if(document.getElementById("remarks").value==''){
			document.getElementById("errormsg").innerText="Enter remarks.";
			return false;
		}
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			 if($('#hidrdate').val()){
				$("#rdate").jqxDateTimeInput('val', $('#rdate').val());
			  }
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
			
			/* if(document.getElementById("docno").value>0){
			   var code=$('#formdetailcode').val().trim();
	           var doc=document.getElementById("docno").value;
	           $('#staffdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
		   } */
	
		   
	}
	
	function funFocus(){
		document.getElementById("name").focus();
	}
	
	
	 
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmRoomType" action="saveActionRoomType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Room Type</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="rdate" name="rdate" value='<s:property value="rdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td width="15%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" placeholder="Name" value='<s:property value="name"/>' style="width:81%;" ></td>
	<td align="right" >Category</td>
    <td width="40%"><input type="text" id="remarks" name="remarks" placeholder="Category" style="width: 100%" value='<s:property value="remarks"/>'/></td>
    
  </tr>
  
</table>
</fieldset><br/>
 <div id="roomdiv"><jsp:include page="roomtypeGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidrdate" id="hidrdate" value='<s:property value="hidrdate"/>'>
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

