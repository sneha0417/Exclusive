<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	/*  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
 */	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 $('#assetwindow').jqxWindow({ width: '40%', height: '60%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Asset Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 $('#assetwindow').jqxWindow('close');
	  
 $('#assetgrp').dblclick(function(){
	    $('#assetwindow').jqxWindow('open');
	$('#assetwindow').jqxWindow('focus');
	 assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
	});
});
function getAssetGroup(event){
	 var x= event.keyCode;
   if(x==114){
   	  $('#assetwindow').jqxWindow('open');
 		$('#assetwindow').jqxWindow('focus');
 		 assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
   }
   else{
    }
}
function assetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#assetwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	/* if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	 */
	  $("#falistdiv").load("faListGrid.jsp?branch="+document.getElementById("cmbbranch").value+"&assetgroup="+document.getElementById("hidassetgrp").value+'&check=1');
	}
	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	}
	function funExportBtn(){
		JSONToCSVCon(exportdata,  'Fixed Asset List', true);
		
	}
		
	</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmFAList" action="frmFAList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td width="17%" align="right"><label class="branch">Period Upto</label><br></td>
   <td width="83%" align="left"><div id="periodupto"></div></td></tr>


<tr><td align="right"><label class="branch">Asset Group</label></td><td align="left"><input type="text" name="assetgrp" id="assetgrp" readonly placeholder="Press F3 to Search" onKeyDown="getAssetGroup(event);" ></td></tr>
 <input type="hidden" name="hidassetgrp" id="hidassetgrp">
 <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
  <tr>
  <td align="right">&nbsp;</td>
  <td align="left">&nbsp;</td>
  </tr> 
   <tr>
  </tr> 

		 <tr>
	<td colspan="2">&nbsp;</td>
	</tr> 
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	<td colspan="2">&nbsp;
	<br><br><br><br><br><br><br><br><br><br><br><br>
	</td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <!-- <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> --> <div id="falistdiv"><jsp:include page="faListGrid.jsp"></jsp:include></div> </td>
			 
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="assetwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>