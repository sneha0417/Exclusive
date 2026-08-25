
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

</style>

<script type="text/javascript">

$(document).ready(function () {

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#projectsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Project Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#projectsearch').jqxWindow('close');
	 
	 $('#txtproject').dblclick(function(){
		   
    	 $('#projectsearch').jqxWindow('open');
    	 clientSearchContent('projectSearch.jsp?', $('#projectsearch')); 
		   		
		 });
	 
	   
	  
});

function funExportBtn(){
    

//	JSONToCSVCon(projectlistexcel, 'Project List', true);
	   }



function funreload(event)
{

	  
		   var barchval = document.getElementById("cmbbranch").value;
	 var trno= $("#hidtrno").val();
	 var loadid=2;
	
	 $("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?trno="+trno+"&loadid="+loadid);
	
	  
	}

function getProject(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#projectsearch').jqxWindow('open');
	 clientSearchContent('projectSearch.jsp?', $('#projectsearch'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#projectsearch').jqxWindow('setContent', data);

   	}); 
   }

	

	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100% "  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	        <tr>
	      <td align="right"><label class="branch">Project</label></td>
	      <td ><input style="height:19px;" type="text" name="txtproject" id="txtproject" value='<s:property value="txtproject"/>' onKeyDown="getProject(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="hidtrno" name="hidtrno" value='<s:property value="hidtrno"/>'>
     </td>
	      </tr>
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
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
		
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="loadgriddata">
				<jsp:include page="gridDetails.jsp"></jsp:include> 
			</td></div></tr>
		
	</table>
</tr>
</table>

</div>
 <div id="projectsearch">
   <div ></div>
</div> 
</div>
</body>
</html>