
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

</style>

<script type="text/javascript">

$(document).ready(function () {
	
	
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	      
			$('#userinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'User Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#userinfowindow').jqxWindow('close');
			
	     $('#complaintsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Complaint Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#complaintsearch').jqxWindow('close');
		  
		     
		     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			    
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
			 $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				 
				 	 
				   if(fromdates<todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }   
			 });
	 
	 
     $('#txtcomplaint').dblclick(function(){
		   
    	 $('#complaintsearch').jqxWindow('open');
    	 complaintSearchContent('complaintsearch.jsp?', $('#complaintsearch')); 
		   		
		 });
	 
     $('#txtuser').dblclick(function(){
		   
    	 $('#userinfowindow').jqxWindow('open');
    	 userSearchContent('userSearch.jsp');
		   		
		 });
     
        
     	  
});


function getcomplinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#complaintsearch').jqxWindow('open');
	 complaintSearchContent('complaintsearch.jsp?', $('#complaintsearch'));    }
	 else{
		 }
	 } 
     function complaintSearchContent(url) {
           
               $.get(url).done(function (data) {
  
	           $('#complaintsearch').jqxWindow('setContent', data);

    	}); 
         	}

     function funExportBtn(){
			
    	   //$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
    	   
    	   JSONToCSVCon(enqlistexcel,'Call Register Detail',true);
    	 

    }
     
    
    

function funreload()
{

     var id=1;
  
    if(id>0){
    	
    	gridload(id);
    }
     
	}
	
		

	 function gridload(id){
		 
		 var complid=$('#complid').val();
		 var userid=$('#userid').val();
		 var ctype=$('#ctype').val();
		 var fromdate=$('#fromdate').val();
		 var todate=$('#todate').val();
		 var barchval = document.getElementById("cmbbranch").value;
	
		 
		 $("#callDetailgrid").jqxGrid('clear'); 
			
		 $("#overlay, #PleaseWait").show();
			 $("#calldetaildiv").load("callregisterDetailGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&complid="+complid+"&userid="+userid+"&ctype="+ctype+"&id="+id);
		
		 
	 }
	 
	 
		
	
      function getUser(){
    	  
    	  var x= event.keyCode;
    	  
 		 if(x==114){
		  $('#userinfowindow').jqxWindow('open');
		  
		  userSearchContent('userSearch.jsp');
		  
	 	 }
 		 else{
 			 }
 		 }
	 	 
	function userSearchContent(url) {
		 $.get(url).done(function (data) {
			 
	$('#userinfowindow').jqxWindow('setContent', data);

	        	}); 
		}
	
	

	   
	   function funClear(){
			$("#callDetailgrid").jqxGrid('clear'); 
			
			 document.getElementById("ctype").value="ALL";
		   document.getElementById("txtcomplaint").value="";
		   document.getElementById("complid").value="";
		   $("#txtcomplaint").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtuser").value="";
		   document.getElementById("userid").value="0";
		   $("#txtuser").attr("placeholder", "press F3 for Search");
		   
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
 <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
       </td></tr>
       <tr><td colspan="2">&nbsp;</td></tr>
       <tr>
	      <td align="right"><label class="branch">User</label></td>
	      <td ><input style="height:19px;" type="text" name="txtuser" id="txtuser" value='<s:property value="txtuser"/>' onKeyDown="getUser(event);" readonly placeholder="Press F3 to Search">
       <input type="hidden" id="userid" name="userid" value='<s:property value="userid"/>'></td>
	      </tr>
	      <tr><td colspan="2"></td></tr>
	    <tr>
	      <td align="right"><label class="branch">Complaint</label></td>
	      <td ><input style="height:19px;" type="text" name="txtcomplaint" id="txtcomplaint" value='<s:property value="txtcomplaint"/>' onKeyDown="getcomplinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="complid" name="complid" value='<s:property value="complid"/>'>
      </td>
	      </tr>
	      <tr><td colspan="2"></td></tr>
	      <tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="ctype" name="ctype"  value='<s:property value="ctype"/>'>
     <option value="ALL" >ALL</option><option value="OPN">OPEN</option><option value="CLS">CLOSED</option>
     </select></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClear();">
	</td></tr>
	  
	 
	         <tr><td colspan="2">&nbsp;</td></tr> 
	          <tr><td colspan="2">&nbsp;</td></tr> 
	       <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr>
	        
	       <tr><td colspan="2">&nbsp;</td></tr>
	 </table>
	      <table width="100%"><tr>
	   
	        <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> 
	         <tr><td colspan="2">&nbsp;</td></tr> 
	          <tr><td colspan="2">&nbsp;</td></tr> 
	          
	 <tr>
	      
	      <td >
     
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
     
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
       <input type="hidden" id="reportdocno" name="reportdocno" value='<s:property value="reportdocno"/>'>
       <input type="hidden" id="surveydocno" name="surveydocno" value='<s:property value="surveydocno"/>'>
       <input type="hidden" id="enqdocno" name="enqdocno" value='<s:property value="enqdocno"/>'>
       
         <input type="hidden" id="reftrno" name="reftrno" value='<s:property value="reftrno"/>'>
      <input type="hidden" id="brhid1" name="brhid1" value='<s:property value="brhid1"/>'>
      <input type="hidden" id="refdtype" name="refdtype" value='<s:property value="refdtype"/>'>
      
      </td>
	      </tr>  
	     
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%">
		<tr><div id="calldetaildiv">
				<jsp:include page="callregisterDetailGrid.jsp"></jsp:include> 
			</div></tr>

	</table>
	</td>
</tr>
</table>
</div>
<div id="complaintsearch">
   <div ></div>
</div> 

<div id="userinfowindow">
   <div ></div>
</div>

</div>
</body>
</html>