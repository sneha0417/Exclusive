<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}

.style1 {
	color: #FF0000;
	font-weight: bold;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {  
          $("#floorDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	      
	      document.getElementById("formdet").innerText="Floor(FLR)";
		  document.getElementById("formdetail").value="Floor";
		  document.getElementById("formdetailcode").value="FLR";
		  window.parent.formCode.value="FLR";
      });
  
      function getFloorIDAlreadyExists(value){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  		if (x.readyState==4 && x.status==200)
  			{
  			 	var items=x.responseText;
  			 	if(items.trim()!='undefine'){
  			 		document.getElementById("txtfloorcode").focus();
  			 		document.getElementById("errormsg").innerText="Floor Code Already Exists";
  			 	}
  			 	else{
  			 		document.getElementById("errormsg").innerText="";
  			 	  }
  			    }
  		       else
  			      {}
        }
        x.open("GET","getFloorIDAlreadyExists.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        x.send();
      }
      
  function funFocus()
  {
	  document.getElementById("txtfloorcode").focus(); 	    		
  }
  
  $(function(){
      $('#frmFloor').validate({
      	 rules: {
      				txtfloorcode:{"required":true,maxlength:5},
      				txtfloorname:"required"
	                 },
	                 messages: {
	                 txtfloorcode:{required:" *",maxlength:"Max 5 chars"},
	                 txtfloorname:" *"
	                 }
      });});
  
   function funNotify(){
  		return 1;
	} 
   
   
   function funSearchLoad(){
		changeContent('floorMainSearch.jsp');
   }
 
	function funReadOnly(){
		 $('#frmFloor input').attr('readonly', true );
		 $('#floorDate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmFloor input').attr('readonly', false );
		$('#floorDate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#floorDate').val(new Date());
		}
	}
	
    function setValues(){
    	 if($('#hidfloorDate').val()){
			 $("#floorDate").jqxDateTimeInput('val', $('#hidfloorDate').val());
		  }
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();

    }
 </script> 
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFloor" action="saveActionFloor" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 

<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="23%"><div id="floorDate" name="floorDate" value='<s:property value="floorDate"/>'></div>
    <input type="hidden" id="hidfloorDate" name="hidfloorDate" value='<s:property value="hidfloorDate"/>'/></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="66%"><input type="text" id="docno" name="txtfloordocno" style="width:20%;" value='<s:property value="txtfloordocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="txtfloorcode" name="txtfloorcode" style="width:50%;" onblur="getFloorIDAlreadyExists(this.value);" value='<s:property value="txtfloorcode"/>'/></td>
    <td align="right">Name</td>
    <td><input type="text" id="txtfloorname" name="txtfloorname" style="width:50%;" value='<s:property value="txtfloorname"/>'/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
</fieldset>
</form>
 </div>                                  
</body>
</html>