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
    	 $("#binDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 

    	 $('#rackDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Rack Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#rackDetailsWindow').jqxWindow('close');
		 
  		 document.getElementById("formdet").innerText="Bin(BIN)";
		 document.getElementById("formdetail").value="Bin";
		 document.getElementById("formdetailcode").value="BIN";
		 window.parent.formCode.value="BIN"; 
		 
		 $('#txtrackname').dblclick(function(){
			 RackSearchContent("rackDetailsSearch.jsp");
		 });
     });
    
    function RackSearchContent(url) {
		$('#rackDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#rackDetailsWindow').jqxWindow('setContent', data);
		$('#rackDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
    
    function getBinIDAlreadyExists(value){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  		if (x.readyState==4 && x.status==200)
  			{
  			 	var items=x.responseText;
  			 	if(items.trim()!='undefine'){
  			 		document.getElementById("txtbincode").focus();
  			 		document.getElementById("errormsg").innerText="Bin Code Already Exists";
  			 	}
  			 	else{
  			 		document.getElementById("errormsg").innerText="";
  			 	  }
  			    }
  		       else
  			      {}
        }
        x.open("GET","getBinIDAlreadyExists.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        x.send();
      }
    
    function getRack(event){
        var x= event.keyCode;
        if(x==114){
        	 RackSearchContent("rackDetailsSearch.jsp");
        }
        else{}
        }
      
  function funFocus()
  {
	  document.getElementById("txtrackname").focus(); 	    		
  }
  
  $(function(){
      $('#frmBin').validate({
      	 rules: {
      			    txtbincode:{"required":true,maxlength:5},
      				txtbinname:"required"
	                 },
	                 messages: {
	                 txtbincode:{required:" *",maxlength:"Max 5 chars"},
	                 txtbinname:" *"
	                 }
      });});
  
   function funNotify(){
	     rack=document.getElementById("txtrackcode").value;
		 if(rack==""){
			 document.getElementById("errormsg").innerText="Floor is Mandatory.";
			 return 0;
		 }
		 
		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
   
   function funSearchLoad(){
		changeContent('binMainSearch.jsp');
   }
 
	function funReadOnly(){
		 $('#frmBin input').attr('readonly', true );
		 $('#binDate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmBin input').attr('readonly', false );
		$('#binDate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtrackname').attr('readonly', true );
		
		if ($("#mode").val() == "A") {
			$('#binDate').val(new Date());
		}
	}
	
    function setValues(){
    	 if($('#hidbinDate').val()){
			 $("#binDate").jqxDateTimeInput('val', $('#hidbinDate').val());
		  }
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();

    }
    
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBin" action="saveActionBin" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
     
<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="23%"><div id="binDate" name="binDate" value='<s:property value="binDate"/>'></div>
    <input type="hidden" id="hidbinDate" name="hidbinDate" value='<s:property value="hidbinDate"/>'/></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="66%"><input type="text" id="docno" name="txtbindocno" style="width:20%;" value='<s:property value="txtbindocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Rack</td>
    <td colspan="3"><input type="text" id="txtrackname" name="txtrackname" style="width:65%;" placeholder="Press F3 to Search" value='<s:property value="txtrackname"/>' onkeydown="getRack(event);"/>
    <input type="hidden" id="txtrackcode" name="txtrackcode" value='<s:property value="txtrackcode"/>'/>
    <input type="hidden" id="txtfloorcode" name="txtfloorcode" value='<s:property value="txtfloorcode"/>'/></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="txtbincode" name="txtbincode" style="width:50%;" onblur="getBinIDAlreadyExists(this.value);" value='<s:property value="txtbincode"/>'/></td>
    <td align="right">Name</td>
    <td><input type="text" id="txtbinname" name="txtbinname" style="width:50%;" value='<s:property value="txtbinname"/>'/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>

</fieldset>
</form>
<div id="rackDetailsWindow">
	<div></div>
</div>
</div>
</body>
</html>