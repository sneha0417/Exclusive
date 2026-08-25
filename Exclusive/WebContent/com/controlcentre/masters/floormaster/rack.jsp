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
    	 $("#rackDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	 
    	 $('#floorDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Floor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#floorDetailsWindow').jqxWindow('close'); 

  		 document.getElementById("formdet").innerText="Rack(RCK)";
		 document.getElementById("formdetail").value="Rack";
		 document.getElementById("formdetailcode").value="RCK";
		 window.parent.formCode.value="RCK"; 
		 
		 $('#txtfloorname').dblclick(function(){
		     FloorSearchContent("floorDetailsSearch.jsp");
		 });
     });
    
    function FloorSearchContent(url) {
		$('#floorDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#floorDetailsWindow').jqxWindow('setContent', data);
		$('#floorDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
    
    function getRackIDAlreadyExists(value){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  		if (x.readyState==4 && x.status==200)
  			{
  			 	var items=x.responseText;
  			 	if(items.trim()!='undefine'){
  			 		document.getElementById("txtrackcode").focus();
  			 		document.getElementById("errormsg").innerText="Rack Code Already Exists";
  			 	}
  			 	else{
  			 		document.getElementById("errormsg").innerText="";
  			 	  }
  			    }
  		       else
  			      {}
        }
        x.open("GET","getRackIDAlreadyExists.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        x.send();
      }
    
    function getFloor(event){
        var x= event.keyCode;
        if(x==114){
        	FloorSearchContent("floorDetailsSearch.jsp");
        }
        else{}
        }
    
  function funFocus()
  {
	  document.getElementById("txtfloorname").focus(); 	    		
  }
  
  $(function(){
      $('#frmRack').validate({
      	 rules: {
      			    txtrackcode:{"required":true,maxlength:5},
      				txtrackname:"required"
	                 },
	                 messages: {
	                 txtrackcode:{required:" *",maxlength:"Max 5 chars"},
	                 txtrackname:" *"
	                 }
      });});
  
   function funNotify(){
	     floor=document.getElementById("txtfloorcode").value;
		 if(floor==""){
			 document.getElementById("errormsg").innerText="Floor is Mandatory.";
			 return 0;
		 }
		 
		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
   
   function funSearchLoad(){
		changeContent('rackMainSearch.jsp');
   }
 
	function funReadOnly(){
		 $('#frmRack input').attr('readonly', true );
		 $('#rackDate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmRack input').attr('readonly', false );
		$('#rackDate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtfloorname').attr('readonly', true );
		
		if ($("#mode").val() == "A") {
			$('#rackDate').val(new Date());
		}
	}
	
    function setValues(){
    	 if($('#hidrackDate').val()){
			 $("#rackDate").jqxDateTimeInput('val', $('#hidrackDate').val());
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
<form id="frmRack" action="saveActionRack" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
     
<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="23%"><div id="rackDate" name="rackDate" value='<s:property value="rackDate"/>'></div>
    <input type="hidden" id="hidrackDate" name="hidrackDate" value='<s:property value="hidrackDate"/>'/></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="66%"><input type="text" id="docno" name="txtrackdocno" style="width:20%;" value='<s:property value="txtrackdocno"/>' tabindex="-1"/></td>
  </tr>
   <tr>
    <td align="right">Floor</td>
    <td colspan="3"><input type="text" id="txtfloorname" name="txtfloorname" style="width:65%;" placeholder="Press F3 to Search" value='<s:property value="txtfloorname"/>' onkeydown="getFloor(event);"/>
    <input type="hidden" id="txtfloorcode" name="txtfloorcode" value='<s:property value="txtfloorcode"/>'/></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="txtrackcode" name="txtrackcode" style="width:50%;" onblur="getRackIDAlreadyExists(this.value);" value='<s:property value="txtrackcode"/>'/></td>
    <td align="right">Name</td>
    <td><input type="text" id="txtrackname" name="txtrackname" style="width:50%;" value='<s:property value="txtrackname"/>'/></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
</form>

<div id="floorDetailsWindow">
	<div></div>
</div>
</div>
</body>
</html>