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
	 $("#fgmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 //$('#jqxgroupgrid').jqxGrid({ disabled: true}); 
	 
	 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
		
      		 $('#txtaccno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
			    var url=document.URL;
			    var reurl=url.split("com/");
				  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp');
      		 }); 
      		document.getElementById("formdet").innerText="Group Master(FGM)";
    		document.getElementById("formdetail").value="Group Master";
    		document.getElementById("formdetailcode").value="FGM";
    		window.parent.formCode.value="FGM";
    		window.parent.formName.value="Group Master";
    		
  });
	
	function funFocus(){
		document.getElementById("fgmcode").focus();
	}
	
	function funReadOnly() {
		$('#frmgrp input').attr('readonly', true);
		$('#fgmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmgrp input').attr('readonly', false);
		$('#fgmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#hidfgmdate').val()){
			$("#fgmdate").jqxDateTimeInput('val', $('#hidfgmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmgrp').validate({
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
		if(document.getElementById("fgmname").value==''){
			document.getElementById("errormsg").innerText="Group Name is Mandatory.";
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
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmgrp" action="saveActiongrp" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>Group Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="fgmdate" name="fgmdate" value='<s:property value="fgmdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" name="fgmcode" id="fgmcode" placeholder="Group Code" value='<s:property value="fgmcode"/>' ></td>
   <%--  <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="salesmanname" id="salesmanname" placeholder="Code Name" value='<s:property value="salesmanname"/>' style="width:59%;"></td> --%>
    <td width="5%" align="right">Name</td>
    <td><input type="text" name="fgmname" id="fgmname" style="width:80%;" placeholder="Group Name" value='<s:property value="fgmname"/>' ></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr>
   <td>
   
   <div id="grpgrid"><jsp:include page="groupGrid.jsp"></jsp:include></div> 
   </td>
  </tr>
</table>

<input type="hidden" name="hidfgmdate" id="hidfgmdate" value='<s:property value="hidfgmdate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
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