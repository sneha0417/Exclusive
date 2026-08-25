<% String contextPath=request.getContextPath();%>

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
	 $("#flmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 document.getElementById("formdet").innerText="Location Master(FLM)";
		document.getElementById("formdetail").value="Location Master";
		document.getElementById("formdetailcode").value="FLM";
		window.parent.formCode.value="FLM";
		window.parent.formName.value="Location Master";
});
	 
	
	function funFocus(){
		document.getElementById("flmcode").focus();
	}
	
	function funReadOnly() {
		$('#frmloc input').attr('readonly', true);
		$('#flmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmloc input').attr('readonly', false);
		$('#flmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#hidflmdate').val()){
			$("#flmdate").jqxDateTimeInput('val', $('#hidflmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmloc').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		
		if(document.getElementById("flmname").value==''){
			document.getElementById("errormsg").innerText="Location Name is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
 
</script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
.page-header {
    padding-bottom: 0px !important;
    margin: 10px 0px 20px !important; 
}
</style>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<div  class='hidden-scrollbar'>
<form id="frmloc" action="saveActionloc" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>Location Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="flmdate" name="flmdate" value='<s:property value="flmdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" name="flmcode" id="flmcode" placeholder="Location Code" value='<s:property value="flmcode"/>' ></td>
   <%--  <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="salesmanname" id="salesmanname" placeholder="Code Name" value='<s:property value="salesmanname"/>' style="width:59%;"></td> --%>
    <td width="5%" align="right">Name</td>
    <td><input type="text" name="flmname" id="flmname" style="width:80%;" placeholder="Location Name" value='<s:property value="flmname"/>' ></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr>
   <td>
   
   <div id="locgrid"><jsp:include page="locationGrid.jsp"></jsp:include></div>
   </td>
  </tr>
</table>

<input type="hidden" name="hidflmdate" id="hidflmdate" value='<s:property value="hidflmdate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>
</div>
</div>
<br/>
	<div id="jqxSalesmanSearch1"></div>
		
	<div id="accountWindow">
	<div >
	
	</div>
	<div>
	</div>
	 </div>  
	
</body>
</html>