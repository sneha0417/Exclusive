
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

.hidden-scrollbar {
    overflow: auto;
    height: 550px; 
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	
	/* $('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide(); */
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
			  
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#clientsearch1').jqxWindow('close');
	     
	     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
    
});


function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
     function clientSearchContent(url) {
           
               $.get(url).done(function (data) {
  
	           $('#clientsearch1').jqxWindow('setContent', data);

    	}); 
         	}

     function funExportBtn(){
			
    	   //$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
    	   
    //	   JSONToCSVCon(exceldata,'Service Scheduler',true);
    	 

    }

function funreload()
{

     var id=1;
  
    if(id>0){
    	
    	gridload(id);
    }
     
	}
	
		

	 function gridload(id){
		 
		 var clientid=$('#clientid').val();
		 frmdate=$('#fromdate').jqxDateTimeInput('val');
		 todate=$('#todate').jqxDateTimeInput('val');
		 var barchval = document.getElementById("cmbbranch").value;
	 
		 $("#qutDetGrid").jqxGrid('clear'); 
			
		 $("#overlay, #PleaseWait").show();
			 $("#qotdiv").load("quotGrid.jsp?barchval="+barchval+"&fromdate="+frmdate+"&todate="+todate+"&clientid="+clientid+"&id="+id);
		
		 
	 }

	function funPrint()
	{
		
	}
</script>
</head>
<body onload="getBranch();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
 <tr><td colspan="2"></td></tr>
	   <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' ></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
  <tr><td colspan="2"></td></tr>
	    <tr>
	      <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      </td>
	      </tr>
	  
	</table>
	
	      <table width="100%" ><tr>
	      
	        <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr>
	          
	 <tr>
	      
	      <td >
     
      
      </td>
	      </tr>  
	     
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%">
		<tr><td><div id="qotdiv"><jsp:include page="quotGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="qotsubdiv"><jsp:include page="quotsubGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><fieldset><legend>Site Details</legend><div id="qotsitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div></fieldset></td></tr>
		<tr><td><fieldset><legend>Revision Details</legend><div id="qotrevisiondiv"><jsp:include page="revisionGrid.jsp"></jsp:include></div></fieldset></td></tr>
		
	</table>
	</td>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 

</div>
</body>
</html>