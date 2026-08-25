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
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	   $("#btnExcel").click(function() {
				JSONToCSVCon(exceldata, 'Datalog Report', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			});
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#userwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#userwindow').jqxWindow('close');
	 $('#formwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#formwindow').jqxWindow('close');
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
   
       $('#user').dblclick(function(){
 		  userSearchContent('userSearchGrid.jsp');
 		});
       $('#form').dblclick(function(){
  		  formSearchContent('formSearchGrid.jsp');
  		});

});
function getUser(event){
    var x= event.keyCode;
    if(x==114){
    	userSearchContent('userSearchGrid.jsp');
    }
    else{}
    }
function getForm(event){
    var x= event.keyCode;
    if(x==114){
    	formSearchContent('formSearchGrid.jsp');
    }
    else{}
    }
    
function userSearchContent(url) {
    $('#userwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#userwindow').jqxWindow('setContent', data);
	$('#userwindow').jqxWindow('bringToFront');
}); 
}

function formSearchContent(url) {
    $('#formwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#formwindow').jqxWindow('setContent', data);
	$('#formwindow').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	  	 var hidform=document.getElementById("hidform").value;
	  	 var hiduser=document.getElementById("hiduser").value;
	    	 $("#overlay, #PleaseWait").show();
	    	 $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser);   	 
	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
		   $("#overlay, #PleaseWait").hide();
   		  }
		
		 
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 	
	}


</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="99%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Form Name</label></td>
   <td><input type="text" name="form" id="form" placeholder="Press F3 to Search" readonly style="height:20px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">User</label></td>
   <td><input type="text" name="user" id="user" placeholder="Press F3 to Search" readonly  style="height:20px;"></td>
 </tr>
 
 

 
	<tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	 
	<div style="text-align:center;"><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></div>
   
    </td>
	</tr>
		  <tr>
   <td colspan="2" align="right">
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
   </td>
 </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="logdiv"> <jsp:include page="datalogGrid.jsp"></jsp:include> </div> 		
			 </td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
				<input type="hidden" name="hiduser" id="hiduser">
				<input type="hidden" name="hidform"  id="hidform">			  
		</tr>
	</table>
</tr>
</table>
</div>

</div>
<div id="userwindow">
	<div></div><div></div>
</div>
<div id="formwindow">
	<div></div><div></div>
</div>
</form>
</body>
</html>