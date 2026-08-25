<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();

System.out.println("====masterdocno===="+request.getParameter("mastertrno"));

String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
%>

<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';

	$(document).ready(function() {
		
		getType();
		 $("#callRegisterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#datetime").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy HH:mm"});
		// $('#datetime').val(new Date());
		 /* Searching Window */
     	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#clientDetailsWindow').jqxWindow('close');
  		 
         $('#calledbyWindow').jqxWindow({width: '25%', height: '53%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Called By Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#calledbyWindow').jqxWindow('close'); 

 	 	 $('#vehicleWindow').jqxWindow({width: '25%', height: '53%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vehicleWindow').jqxWindow('close');
		 
		 $('#txtclientname').dblclick(function(){
			 clientSearchContent("clientDetailsSearch.jsp");
		 });
		/*  $('#txtcontactperson').dblclick(function(){
			  if($("#txtclientdocno").val()==''){
					 $.messager.alert('Message','Choose Client & Search.','warning');
					 if($("#txtclientdocno").val()==''){
					 	$('#txtclientname').attr('placeholder', 'Press F3 to Search');
					 }
					 return 0;
				}
			
	  			calledbySearchContent("calledbyDetailsSearchGrid.jsp?cldocno="+document.getElementById("txtclientdocno").value);
			  }); */
	});
	
	function getType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				
				items = items.split('####');
								
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
							
				$("select#cmbtype").html(optionsbranch);
				if($('#hidcmbtype').val()!="")
				{
					$('#cmbtype').val($('#hidcmbtype').val());   
				}
			} 
			else {}
		}
		x.open("GET","getType.jsp", true);
		x.send();
	}

	 function funReadOnly(){
			$('#frmCallRegisterss input').attr('readonly', true );
			$('#frmCallRegisterss select').attr('disabled', true);
			$('#chkrepeated').attr('disabled', true);
			$('#vehicle').attr('disabled', true);
			$('#callRegisterDiv').attr('disabled', true);
			
			$("#callRegisterGridID").jqxGrid({ disabled: true});
			$('#callRegisterDate').jqxDateTimeInput({disabled: true});
			$('#datetime').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		 $('#jqxInput').val();
		 	if($('#txtregno').val()!=""){
				  $('#jqxInput').val($('#txtregno').val());
			}
			$('#frmCallRegisterss input').attr('readonly', false );
			$('#frmCallRegisterss select').attr('disabled', false);
			$('#chkrepeated').attr('disabled', false);
			$('#vehicle').attr('disabled', false);
			$('#callRegisterDiv').attr('disabled', true);
			
			$('#callRegisterDate').jqxDateTimeInput({disabled: false});
			$('#datetime').jqxDateTimeInput({disabled: false});
			if ($("#mode").val() == "E") {  
				$('#frmCallRegisterss input').attr('readonly', false );
   			    $('#frmCallRegisterss select').attr('disabled', false);
   			    $("#callRegisterGridID").jqxGrid('addrow', null, {});
			  }
			
			if ($("#mode").val() == "A") {
				$('#datetime').val(new Date(<%=new java.util.Date().getTime()%>));
				$('#callRegisterDate').val(new Date());
				$("#callRegisterGridID").jqxGrid('clear');
				$("#callRegisterGridID").jqxGrid('addrow', null, {});
				$('#jqxInput').val("");
			}
			
			$('#docno').attr('readonly', true);
			$('#txtclientname').attr('readonly', true );
			$('#txtvehicle').attr('readonly', true );   
	 }
	 
	 function funSearchLoad(){
		 changeContent('cregMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#callRegisterDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
		  var txtmobile=document.getElementById("txtmobile").value;
		  if(!mobileValid($("#txtmobile").val())){
				 return 0;
			}
// 		  if(txtmobile=="")
// 			{
// 				document.getElementById("errormsg").innerText="  Mobile number is mandatory";
// 				return 0;
// 			}
		  	 if(document.getElementById("txtvehicleno").value==""){
				 document.getElementById("errormsg").innerText="Vehicle is Mandatory.";
				 return 0;
			 } 
		  	 if(document.getElementById("txtclientdocno").value==""){
				 document.getElementById("errormsg").innerText="Client is Mandatory.";
				 return 0;
			 }
		  	 if(document.getElementById("txtplace").value==""){
				 document.getElementById("errormsg").innerText="Place is Mandatory.";
				 return 0;
			 }
			 if(document.getElementById("txtcontactperson").value==""){
				 document.getElementById("errormsg").innerText="Called By Details is Mandatory.";
				 return 0;
			 }
			 if(document.getElementById("chkrepeated").checked==true){
				 document.getElementById("chkhidrepeated").value="1";
			 }
		  	if(document.getElementById("chkrepeated").checked==false){
				 document.getElementById("chkhidrepeated").value="0";
			 }
			 return 1;
	 } 

	  function setValues(){
		  if($('#txtregno').val()!=""){
			  $('#jqxInput').val($('#txtregno').val());
		  }
		  if($('#hidcallRegisterDate').val()!=""){
				 $("#callRegisterDate").jqxDateTimeInput('val', $('#hidcallRegisterDate').val());
		  } 
		  var date=$('#hiddatetime').val();
		  var day=date.split(".")[0].trim();
		  var month=date.split(".")[1].trim();
		  
		  var rest=date.split(".")[2].trim();
		  var year=rest.split(" ")[0].trim();
		  
		  var time=rest.split(" ")[1].trim();
		  var hrs=time.split(":")[0].trim();
		  var min=time.split(":")[1].trim();
		  
// 		  alert(year+"."+month+"."+day+"  "+hrs+":"+min);
		  
		  $('#datetime ').jqxDateTimeInput('setDate', new Date(year, month-1, day, hrs, min));
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		  if(document.getElementById("chkhidrepeated").value==1){
			  document.getElementById("chkrepeated").checked=true;
		  }
		  else{
			  document.getElementById("chkrepeated").checked=false;
		  }
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  $("#callRegisterDiv").load('callRegisterGrid.jsp?cldocno='+$("#txtclientdocno").val());
		  
		}
	  
	  function chkChange(){
		  if(document.getElementById("chkrepeated").checked==true){
				 document.getElementById("chkhidrepeated").value="1";
			 }
		  if(document.getElementById("chkrepeated").checked==false){
				 document.getElementById("chkhidrepeated").value="0";
			 }
	  }
	  function funPrintBtn() {
	    }
	  function reloads()
		{
		 $("#vehicle").load('vehicle.jsp?cldocno='+$("#txtclientdocno").val());
		 
		}
	  function getClientInfo(event){
		  var x= event.keyCode;
		  if(x==114){
			  clientSearchContent("clientDetailsSearch.jsp");
		  }
		  else{}
	  }
	  function clientSearchContent(url) {
		 	$('#clientDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#clientDetailsWindow').jqxWindow('setContent', data);
			$('#clientDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
	  function getCalledbyDetails(event){
		  var x= event.keyCode;
		  if(x==114){
			  calledbySearchContent("calledbyDetailsSearchGrid.jsp?cldocno="+document.getElementById("txtclientdocno").value);
		  }
		  else{}
	  }
	  function calledbySearchContent(url) {
		 	$('#calledbyWindow').jqxWindow('open');
			$.get(url).done(function (data) {
				
			$('#calledbyWindow').jqxWindow('setContent', data);
			$('#calledbyWindow').jqxWindow('bringToFront');
		}); 
		}
	  function mobileValid(value){
		   if(value!=""){ 
		    var phoneno = /^\d{12}$/;  
			if(value.match(phoneno)){
				document.getElementById("errormsg").innerText="";
				//$('#txtmobilevalidation').val(0);
				return true;
			}
			else{
				document.getElementById("errormsg").innerText="Invalid Mobile Number";
				//$('#txtmobilevalidation').val(1);
				return false;
			}
		    } 
		   return true;
	}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getType();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCallRegisterss" action="saveCallRegisterss" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="callRegisterDate" name="callRegisterDate" value='<s:property value="callRegisterDate"/>'></div>
    <input type="hidden" id="hidcallRegisterDate" name="hidcallRegisterDate" value='<s:property value="hidcallRegisterDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcallregisterdocno"  value='<s:property value="txtcallregisterdocno"/>' tabindex="-1"/>
    <input type="hidden" id="txtcallregistertrno" name="txtcallregistertrno"  value='<s:property value="txtcallregistertrno"/>'/></td>
  </tr>
</table>

<table width="100%">
<tr><td>
<fieldset>
<table width="100%">
  <tr>
  <td width="6%" align="right">Client</td>  
    <td width="20%">
    	<input type="text" id="txtclientname" name="txtclientname"  placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClientInfo(event);"/>
    	<input type="hidden" id="txtclientdocno" name="txtclientdocno" style="width:90%;" value='<s:property value="txtclientdocno"/>'/>
    	<input type="hidden" id="txtclientacno" name="txtclientacno" style="width:90%;" value='<s:property value="txtclientacno"/>'/>
    </td>
    <td width="6%" align="right">Vehicle</td>
    <td width="10%">
    	<div id="vehicle" value='<s:property value="vehicle"/>'><jsp:include page="vehicle.jsp"></jsp:include></div>
    </td>
    <td width="30%">
    	<input type="text" id="txtvehicle" name="txtvehicle" style="width: 80%"  value='<s:property value="txtvehicle"/>' readonly/>
    	<input type="hidden" id="txtvehicleno" name="txtvehicleno" value='<s:property value="txtvehicleno"/>'/>
    	<input type="hidden" id="txtregno" name="txtregno" value='<s:property value="txtregno"/>'/>
    </td>
  </tr>
</table>
</fieldset><br/>    

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Other Details</font></legend>
<table width="100%">
   <tr>
     <td align="right">Called By</td>
     <td width="14%"><input type="text" id="txtcontactperson" name="txtcontactperson" value='<s:property value="txtcontactperson"/>'/></td>
     <td>&nbsp;</td>
     <td align="right">Mobile</td>
     <td width="14%"><input type="text" id="txtmobile" name="txtmobile" onblur="mobileValid(this.value);" style="width:95%;" value='<s:property value="txtmobile"/>' /></td>
      <td align="right">Repeated</td>
     <td width="14%"><input type="checkbox" id="chkrepeated" name="chkrepeated" onchange="chkChange();" value='<s:property value="chkrepeated"/>' />
     	<input type="hidden" id="chkhidrepeated" name="chkhidrepeated" value='<s:property value="chkhidrepeated"/>'/></td>
  </tr>
  <tr>
    <td width="10%" align="right">Type</td>
    <td width="24%">
    	<select id="cmbtype" name="cmbtype" style="width:42%;"  value='<s:property value="cmbtype"/>'></select>
    	<input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
    </td>
  </tr>
  <tr>  
    <td align="right">Remarks</td>  
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:90%;" value='<s:property value="txtdescription"/>'/></td>
    <td align="right">Place</td>
     <td width="14%"><input type="text" id="txtplace" name="txtplace" style="width:95%;" value='<s:property value="txtplace"/>' /></td>
      <td align="right">Date & Time</td>
     <td width="14%"><div id="datetime" name="datetime" value='<s:property value="datetime"/>'></div>
     <input type="hidden" id="hiddatetime" name="hiddatetime" value='<s:property value="hiddatetime"/>' /></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<table width="100%">  
<tr><td>   
<fieldset>
<div id="callRegisterDiv"><jsp:include page="callRegisterGrid.jsp"></jsp:include></div>
</fieldset></td>
</tr></table>
<input type="hidden" id="mode" name="mode"/>

<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
</div>
</form>

<div id="clientDetailsWindow">
   <div></div>
</div>
<div id="calledbyWindow">
   <div></div>
</div>
<div id="vehicleWindow">
   <div></div>
</div>	
</div>
</body>
</html>
