<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
 .hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<script type="text/javascript">

$(document).ready(function () {  
	$('#branchlabel').hide();
	$('#branchdiv').hide();     
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
}); 
 
function funreload(event){   
	var fromdate=$("#fromdate").jqxDateTimeInput('val');
	var todate=$("#todate").jqxDateTimeInput('val');
	var fromacno=$("#txtaccfrom").val();
	var toacno=	$("#txtaccto").val();
	$("#overlay, #PleaseWait").show(); 
	$("#accdiv").load("accountsstatementperiodGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&fromacno="+fromacno+"&toacno="+toacno+"&id="+1);        
}   
function funExportBtn(){
	 $("#accdiv").excelexportjs({
			containerid: "accdiv",
			datatype: 'json',
			dataset: null,
			gridId: "jqxaccountgrid",
			columns: getColumns("jqxaccountgrid"),
			worksheetName: "Accounts Statement Period"
		});
}   
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
      $.messager.alert('Message',' Enter Numbers Only ','warning');    
        return false;
     }
    return true;
}
function validateEmail($email) {  
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if($email!=""){   
	  if(emailReg.test( $email )){  
			return true;
		}
		else{
			$.messager.alert('Warning',' Email Address Not Valid!!! ','warning');
			return false;
		}
	  }else{
		    $.messager.alert('Warning',' Email Address Not Valid!!! ','warning');
			return false;
	  }
	  return true;
	}
function funSendMail(){    
	var rows = $("#jqxaccountgrid").jqxGrid('getrows');

	var selectedrows=$("#jqxaccountgrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});

	if(selectedrows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}

	var i=0;
	var temptrno="";            
	var j=0;
	for (i = 0; i < selectedrows.length; i++) {

	if(i==0){      
	var accdocno= $('#jqxaccountgrid').jqxGrid('getcellvalue', selectedrows[i], "acno");
	var email= $('#jqxaccountgrid').jqxGrid('getcellvalue', selectedrows[i], "mail");  
	if(!validateEmail(email)){ 
		$("#overlay, #PleaseWait").hide();
		return false;
	 }
	temptrno=accdocno;   
	}  
	else{  
	var accdocno= $('#jqxaccountgrid').jqxGrid('getcellvalue', selectedrows[i], "acno"); 
	var email= $('#jqxaccountgrid').jqxGrid('getcellvalue', selectedrows[i], "mail");  
	if(!validateEmail(email)){ 
		$("#overlay, #PleaseWait").hide();
		return false;
	 }
	temptrno=temptrno+","+accdocno;
	}
	temptrno1=temptrno+","; 
	j++; 
	}
	$('#accdocno').val(temptrno1);
	sendMail($('#accdocno').val());	
	} 
function sendMail(gridarray){
	var fromdate=$("#fromdate").jqxDateTimeInput('val');
	var todate=$("#todate").jqxDateTimeInput('val');
	$("#overlay, #PleaseWait").show(); 
    var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 			if (x.readyState==4 && x.status==200)
 			{  
 				var items=x.responseText.trim();
 				if(parseInt(items)>0){                                     
 					 $.messager.alert('Message',' Successfully mail sent ','success');
 					 $("#overlay, #PleaseWait").hide();     
 				}
 				else{
 					 $.messager.alert('Message',' Mail not sent ','warning'); 
 					 $("#overlay, #PleaseWait").hide();  
 				}   
 			}
 			else    
 			{       
 			}                
 		}
 		x.open("GET","sendMail.jsp?gridarray="+encodeURIComponent(gridarray)+"&fromdate="+fromdate+"&todate="+todate,true);                              
 		x.send();      
}
function funClearData(){
	$("#jqxaccountgrid").jqxGrid('clear');   
	$("#txtaccfrom").val('');
	$("#txtaccto").val('');   
}
</script>
</head>
<body >
<div id="mainBG" class="homeContent" data-type="background">                              
<table width="100%" >
<tr>   
<td width="20%" >
    <fieldset style="background: #ECF8E0;">       
	<table width="100%"> 
	<jsp:include page="../../heading.jsp"></jsp:include>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td align="center" colspan="2"><label class="branch">Period</label></td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	 <tr><td align="center" colspan="2"><label class="branch">Account</label></td></tr>
    <tr><td align="right"><label class="branch">From</label></td>
	<td align="left"><input type="text" id="txtaccfrom" name="txtaccfrom" style="width:67%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccfrom"/>'/></td>
	</tr>
	 <tr><td align="right"><label class="branch">To</label></td>
	<td align="left"><input type="text" id="txtaccto" name="txtaccto" style="width:67%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccto"/>'/>
	</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>   
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>  
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	
     <tr><td  align="left"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td>
    <td  align="right"><input type="button" class="myButtons" name="btnsendmail" id="btnsendmail"  value="Send Mail" onclick="funSendMail();"></td></tr>             
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>          
 	 <tr><td colspan="2">&nbsp;</td></tr>
 	 
  </table>
   </fieldset>      
</td>  
<td width="80%">  
	<table width="100%">     
		<tr>
			  <td colspan="2"><div id="accdiv"><jsp:include page="accountsstatementperiodGrid.jsp"></jsp:include></div> <br></td> 
		</tr>    
		
	</table>   
</tr>
</table>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>'>       
</div>
</body>
