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
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
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
</style>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	
	/*  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
 */	
 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
 
 $('#groupDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 $('#groupDetailsWindow').jqxWindow('close');
 $('#accountDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Account Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 $('#accountDetailsWindow').jqxWindow('close');
 
 //fundisable();
 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
 var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
 var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
 $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
 
 $('#txtgroup').dblclick(function(){
	  groupSearchContent('groupSearchGrid.jsp');
 });
 $('#txtemployee').dblclick(function(){
		 accountSearchContent('accountSearch.jsp?check=1'); 
});
 
});



function getGroup(event){
    var x= event.keyCode;
    if(x==114){
    	groupSearchContent('groupSearchGrid.jsp');
    }
    else{}
    }
    
function getEmployee(event){
	
  var x= event.keyCode;
    if(x==114){
    	
    	 accountSearchContent('accountSearch.jsp?check=1'); 	
    	    }
    else{} 
    }
    
function accountSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}    
    


function groupSearchContent(url) {
    $('#groupDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#groupDetailsWindow').jqxWindow('setContent', data);
	$('#groupDetailsWindow').jqxWindow('bringToFront');
}); 
}
function funreload(event)
{
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var issue_stat = $('#issue_ret').val();
	 var groupno=$('#txtgroupno').val();
	 var empid=$('#txtemployeedocno').val();
	 $("#overlay, #PleaseWait").show();
	 
	 
	  $("#faIssueDiv").load("fixedAssetIssueListGrid.jsp?issue_stat="+issue_stat+"&fromdate="+fromdate+"&todate="+todate+"&groupno="+groupno+"&empid="+empid+"&check=1");
	}
	
	function funExportBtn(){
		JSONToCSVCon(datagrid1, 'Fixed Asset Issue List', true);
		
	}

	function getclr(){
		    
		$('#txtgroup').val("");
		$('#txtgroupno').val("");
		//$('#txtisssueto').val("");
		$('#txtemployee').val("");
		$('#txtemployeedocno').val("");
	}
	function getAccountClear(){
		$('#txtemployee').val("");
		$('#txtemployeedocno').val("");
	}	
		
function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    $("#faIssueGrid").jqxGrid('clear');
	    document.getElementById("txtemployee").value="";
	    document.getElementById("txtgroup").value="";
		document.getElementById("issue_ret").value="";
	    if (document.getElementById("txtemployee").value == "") {
		        $('#txtemployee').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtgroup").value == "") {
		        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		    } 
		 if (document.getElementById("issue_ret").value == "") {
		        $('#issue_ret').attr('clear'); 
		    } 
		 
			
		}

	</script>
</head>
<body onload="getBranch();">
<form id="frmFAIssue" action="frmFAIssue" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>


 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
  <tr>
   <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td align="right"><label class="branch">Issue Type</label></td>
     <td align="left"><select id="issue_ret" name="issue_ret"  value='<s:property value="issue_ret"/>' onchange="getclr(event);">
     <option value="">--select--</option><option value="2">ISSUED</option><option value="1">TRANSFERED</option><option value="3">RETURNED</option>
     </select></td></tr>
      
  	<tr><td align="right"><label class="branch">Group</label></td> 
	<td align="left"><input type="text" id="txtgroup" name="txtgroup" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' onkeydown="getGroup(event);"/>
		             <input type="hidden" id="txtgroupno" name="txtgroupno" style="width:60%;height:20px;" value='<s:property value="txtgroupno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Employee</label></td> 
	<td align="left"><input type="text" id="txtemployee" name="txtemployee" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployee"/>' onkeydown="getEmployee(event);"/>
		             <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" style="width:60%;height:20px;" value='<s:property value="txtemployeedocno"/>'/></td></tr>
  	
  	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	  <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	   <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	     <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td>
 <div id="faIssueDiv"><jsp:include page="fixedAssetIssueListGrid.jsp"></jsp:include></div> </td>
			
		</tr>
	</table>
</tr>
</table>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="assetDetailsWindow">
	<div></div><div></div>
</div>
<div id="groupDetailsWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>