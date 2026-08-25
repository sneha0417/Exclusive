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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
    
    $("#clientname").dblclick(function(){
    	clientSearchContent("clientSearch.jsp");
    });
    
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
		clientSearchContent("clientSearch.jsp");
	}
}
function clientSearchContent(url) {
	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}


function funreload(){
	var cldocno=$("#hidcldocno").val();
	alert(cldocno);
	if(cldocno==""){
		$.messager.alert('Warning','Select a Client');
	}
	else{
		$("#overlay, #PleaseWait").show();
		var barchval = document.getElementById("cmbbranch").value;
	   	$("#invprocdiv").load("invoiceProcessingGrid.jsp?id=1&client="+$('#hidcldocno').val()+"&jobno="+$('#jobno').val()+"&barchval="+barchval);
	}
}



function funClear(){
	$('#uptodate').val(new Date());
	
	$('#clientname').val("");
	$('#hidcldocno').val("");
	$('#msg').val("");
	$('#gridlength').val("");
}

function funSave(){
	
	var selectedrows = $("#jqxInvProcessing").jqxGrid('selectedrowindexes');
	var rows = $("#jqxInvProcessing").jqxGrid('getrows');
	var z=0;
	 $('#gridlength').val(selectedrows.length);
	 if(selectedrows.length==0){
			$.messager.alert('Warning','Select a document');
			return false;
		}
	 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
	 if (r){
		 for(var i=0 ; i < rows.length ; i++){
			 for(var j=0 ; j < selectedrows.length ; j++){
				if(selectedrows[j]==i)	{	 
				 newTextBox = $(document.createElement("input"))
				 .attr("type", "dil")
				 .attr("id", "desctest"+z)
				 .attr("name", "desctest"+z)
				 .attr("hidden", "true"); 
				 var aa=0;
				 newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
						 +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
						 +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
						 +"4 :: "+rows[i].jobno+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: "+rows[i].cdifdno+" :: "+rows[i].jobno);
				 newTextBox.appendTo('form');
				 z++;
				}
			 }
		 }
		 $("#frmInvProcs").submit();
		 }	
	 });
}
function setValues(){
	$('#hidcldocno').val("");
 if($('#msg').val()!=""){
  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
 }
}
</script>
</head>

<body onload="getBranch();setValues();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<form id="frmInvProcs" action="invProcsAction" method="post">
<table width="100%">
<tr><td width="20%">
<fieldset style="background: #ECF8E0;">
<table width="100%" cellspacing="3" cellpadding="2">
<jsp:include page="../../heading.jsp"></jsp:include>

 
   <tr>
    <td width="34%" align="right"><label class="branch">Client Name</label></td>
    <td width="66%" align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchClient(event);">
    <input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
 <tr>
   <td width="34%" align="right"><label class="branch">Inv Date</label></td>
   <td width="66%"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
   </tr>
 <tr><td>&nbsp;</td></tr>
  <tr>
  <td colspan="2"  align="center">
  	<input type="button" id="btnClear" class="myButton" value="Clear" onclick="funClear();" >&ensp;&ensp;
  	<input type="button" id="btnSave" class="myButton" value="Save" onclick="funSave();" >
  </td></tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</fieldset>
</td>
<td>
<div id="invprocdiv"><jsp:include page="invoiceProcessingGrid.jsp"></jsp:include></div><br>
</td>
</tr>
</table>

<input type="text" name="hiddocno" id="hiddocno" hidden="true" value='<s:property value="hiddocno"/>' >
<input type="text" name="gridlength" id="gridlength" hidden="true" value='<s:property value="gridlength"/>' >
     <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<div id="clientSearchWindow">
   <div ></div>
</div>
</form>
</div>
</div>

</body>
</html>