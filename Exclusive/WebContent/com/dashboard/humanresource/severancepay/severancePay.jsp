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
		 $("#branchlabel").hide();$("#branchdiv").hide();
		 
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#txtemployeeid').dblclick(function(){
		  	 employeeSearchContent("employeeDetailsSearch.jsp");
	     });
	     
	     document.getElementById("rdactive").checked=true;
	     
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
	    JSONToCSVCon(dataExcelExport, 'SeverancePay', true);
	} 
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
	 }

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var employeedocno = $('#txtemployeedocno').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdactive").checked==true){
			 $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=1&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
		 	
		 } else{
			 $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=0&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());
		$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		
		document.getElementById("rdactive").checked=true;
		
		$("#severancePayGridID").jqxGrid('clear');$("#severancePayGridID").jqxGrid('addrow', null, {});
	    
	    if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
			
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
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td align="right"><label class="branch">UpTo</label></td>
    <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdactive" name="rdo" value="rdactive"><label for="rdactive" class="branch">Active</label></td>
       <td width="52%" align="center"><input type="radio" id="rdinactive" name="rdo" value="rdinactive"><label for="rdinactive" class="branch">Inactive</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td align="right"><label class="branch">Employee</label></td>
     <td align="left"><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>'  onkeydown="getEmployeeId(event);"/>
     <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
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
			 <td><div id="severancePayDiv"><jsp:include page="severancePayGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>
</html>