<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" ,value:new Date()});
	    $("#dateupto").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null});
	    $("#mclosedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null });
	   
	 /*    $('#mclosedate').on('change', function (event) 
	    		{  
	    		    checkDate(); 
	    		});  */
	    $('#mclosedate').focusout(function(){
	    	 checkDate(); 
	    	 $('#mclosedate').jqxDateTimeInput('focus');
	    });
        });
	
	function getUptodate(){
		//alert(document.getElementById("brchName").value);
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				
				if(items!=null){
					
					$('#dateupto').jqxDateTimeInput('val',new Date(items));
				}
				else{
					$('#dateupto').jqxDateTimeInput('val',null); 
				}
			} else {
			}
		}
		x.open("GET", "getDateUpto.jsp?branch="+document.getElementById("brchName").value, true);
		x.send();
		
	}
	function funSearchLoad(){
		changeContent('monthCloseSearch.jsp?branch='+document.getElementById("brchName").value, $('#window')); 
	 }

	function funReadOnly() {
		$('#frmMonthClose input').attr('readonly', true);
		$('#dateupto').jqxDateTimeInput({disabled:true});
		$('#date').jqxDateTimeInput({disabled:true});
		$('#mclosedate').jqxDateTimeInput({disabled:true});
		
	}
	function funRemoveReadOnly() {
		$('#frmMonthClose input').attr('readonly', false);
		$('#mclosedate').jqxDateTimeInput({disabled:false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=="A"){
			$('#date').jqxDateTimeInput('setDate',new Date());
			$('#dateupto').jqxDateTimeInput('setDate',null);
			$('#mclosedate').jqxDateTimeInput('setDate',null);
			getUptodate();
		}
	}

	function setValues() {
		// getUptodate();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	/*  $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });}); */
	     function funNotify(){
	    
	        	if($('#mclosedate').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Month Close Date  is Mandatory";
	        		return 0;
	        	}
	        	if($('#dateupto').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Month Close Date  is Mandatory";
	        		return 0;
	        	}
	        	if($('#mclosedate').jqxDateTimeInput('getDate')<=$('#dateupto').jqxDateTimeInput('getDate')){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Month Close Date Cannot be less than Upto Date";
	        		return 0;
	        	}
	        	checkDate();
	        	$('#dateupto').jqxDateTimeInput({disabled:false});
	    		$('#date').jqxDateTimeInput({disabled:false});
	    		return 1;
		} 
	     function funFocus(){
	    	 $('#mclosedate').jqxDateTimeInput('focus');
	     }
	  function checkDate(){
		  var closedate=new Date($('#mclosedate').jqxDateTimeInput('getDate'));
      	var lastday= new Date(closedate.getFullYear(), closedate.getMonth() + 1, 0).getDate();
      	var currentday=new Date($('#mclosedate').jqxDateTimeInput('getDate')).getDate();
      	
      	if(lastday!=currentday){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Month Close Date must be at Month End";
      		 $('#mclosedate').jqxDateTimeInput('focus');
      		return false;
      	}
      	else{
      		document.getElementById("errormsg").innerText="";
      		return true;
      	}
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmMonthClose" action="saveMonthClose"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	
	<br>
	<fieldset><legend>Month Close Details</legend>
	<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="12%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="14%">&nbsp;</td>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'></td>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
    <td width="10%" align="right">&nbsp;</td>
    <td width="11%" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Period Upto</td>
    <td align="left"><div id="dateupto" name="dateupto" value='<s:property value="dateupto"/>'></div></td>
    <td>&nbsp;</td>
    <td width="19%" align="right">Month Close Date</td>
    <td width="26%" align="left"><div id="mclosedate" name="mclosedate" value='<s:property value="mclosedate"/>'></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
</form>
</body>
</html>