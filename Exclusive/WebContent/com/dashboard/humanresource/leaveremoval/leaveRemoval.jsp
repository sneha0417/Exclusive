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

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	});     
	
	function  funClearInfo(){   
		$('#cmbbranch').val('a');$('#fromdate').val(new Date());$('#todate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		$("#leaveRequestDetailsGridID").jqxGrid('clear');$("#leaveRequestDetailsGridID").jqxGrid('addrow', null, {});
	 }
	
	function funreload(event){
		 var branchval = $('#cmbbranch').val(); 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 $("#overlay, #PleaseWait").show();       
	     $("#leaveRequestDetailsDiv").load("leaveRemovalGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
	}
	
	function funExportBtn(){
		  if(parseInt(window.parent.chkexportdata.value)=="1") {    
		  	  JSONToCSVCon(data, 'LeaveRequestDetails', true);
		  } else {
			  $("#leaveRequestDetailsGridID").jqxGrid('exportdata', 'xls', 'LeaveRequestDetails');
		  }
	 }
	function funConfirm() {
	    var empdocno=$("#hidempdocno").val();
	    var branchid = $('#cmbbranch').val(); 
	    var fromdate = $('#hidfromdate').val();     
		var todate = $('#hidtodate').val(); 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0){
	  	 			$.messager.alert('Message', 'Salary processed, cannot remove leaves ', function(r){
				    });
	  	 			return false;   
				} else {
					funRemove();        
				} 
		  }
		}
			
	x.open("GET","validate.jsp?empdocno="+empdocno+"&fromdate="+fromdate+"&todate="+todate+"&branchid="+branchid,true);              
	x.send();  
	}
	function funRemove() {
	    var docno=$("#hiddocno").val();
	    var empdocno=$("#hidempdocno").val();
		if(docno==""){     
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Please select a document!!!');   
			return false;
		}
	
	    $.messager.confirm('Confirm', 'Do you want to remove ?', function(r){   
  	 		if (r){
  	 			  var branchid = $('#cmbbranch').val();
  	 			  $("#overlay, #PleaseWait").show();
  	 			
  	 			  saveGridData(docno,empdocno,branchid);
  	 	  }
  	  });  
		
	}
	function saveGridData(docno,empdocno,branchid){              
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0){
					
					$('#cmbbranch').val('a');$('#hiddocno').val('');$('#hidempdocno').val('');
	  	 			$.messager.alert('Message', '  Leave Removed ', function(r){
				    });
					funreload(event);
				} else {
					$.messager.alert('Message', '  Leave Not Removed ', function(r){   
				    });
					$("#overlay, #PleaseWait").hide();
				} 
		  }
		}
			
	x.open("GET","saveData.jsp?selecteddocs="+docno+"&selectedempid="+empdocno+"&branchid="+branchid,true);          
	x.send();
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td colspan="2">&nbsp;</td></tr>		
	 <tr><td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr>
	 <tr><td align="right"><label class="branch">To</label></td>
     <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnConfirm" name="btnConfirm" onclick="funConfirm();">Remove</button></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
     <tr><td colspan="2">&nbsp;
     <input type="hidden" id="hiddocno" name="hiddocno"/>
     <input type="hidden" id="hidempdocno" name="hidempdocno"/>
     <input type="hidden" id="hidfromdate" name="hidfromdate"/>
     <input type="hidden" id="hidtodate" name="hidtodate"/>    
     </td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>		
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
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
			<td><div id="leaveRequestDetailsDiv"><jsp:include page="leaveRemovalGrid.jsp"></jsp:include></div></td>           
		</tr>
</table>
</tr>
</table>
</div>
</div> 
</body>
