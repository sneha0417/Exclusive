
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
	
    $('#clinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#clinfowindow').jqxWindow('close');
	 
	 $('#sourcewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#sourcewindow').jqxWindow('close');
	   $('#salmwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sales Man Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salmwindow').jqxWindow('close');
	  
	   $('#areawindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Area Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#areawindow').jqxWindow('close');
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	   $('#clientname').dblclick(function(){
	  	    $('#clinfowindow').jqxWindow('open');
            $('#clinfowindow').jqxWindow('focus');
           clinfoSearchContent('clientinfo.jsp'); 
           });
	   
	   $('#srcname').dblclick(function(){
			 	    
			   $('#sourcewindow').jqxWindow('open');
			       		sourcesearchContent('sourcesearch.jsp', $('#sourcewindow')); 
		       });
	   
	   $('#salname').dblclick(function(){
	 	    
		   $('#salmwindow').jqxWindow('open');
		   salmsearchContent('salmsearch.jsp', $('#salmwindow')); 
	       });
	   
	   $('#txtarea').dblclick(function(){
	 	    
		   $('#areawindow').jqxWindow('open');
		   areaSearchContent('area.jsp', $('#areawindow')); 
	       });
	 
});

function getsalminfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#salmwindow').jqxWindow('open');
		salmsearchContent('salmsearch.jsp', $('#salmwindow'));    }
	else{}
} 

function salmsearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#salmwindow').jqxWindow('open');
		$('#salmwindow').jqxWindow('setContent', data);
}); 
}

function getsrcinfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#sourcewindow').jqxWindow('open');
		sourcesearchContent('sourcesearch.jsp', $('#sourcewindow'));    }
	else{}
} 

function sourcesearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#sourcewindow').jqxWindow('open');
		$('#sourcewindow').jqxWindow('setContent', data);
}); 
}
function getclientinfo(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#clinfowindow').jqxWindow('open');
  
     
  	 clinfoSearchContent('clientinfo.jsp');    }
  	 else{
  		 }
  	 }

   function clinfoSearchContent(url) {
 
  		 $.get(url).done(function (data) {
  		
  		$('#clinfowindow').jqxWindow('setContent', data);
  
  	}); 
  	}
   function funExportBtn(){
	    

		JSONToCSVCon(enqlistexcel, 'Enquiry List', true);
		   }



function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	// var clientname=$("#clientname").val();
	 var clientname=$("#cldocno").val();
	 var srcno=$("#srcno").val();
	 var salid=$("#salid").val();
	 var areaid=$("#areaid").val();
	 
	 $("#Countgrid").load("Countgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&srcno="+srcno+"&salid="+salid+"&clientname="+clientname+"&areaid="+areaid);
	//  $("#enqlistdiv").load("enquirylistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&srcno="+srcno+"&salid="+salid+"&clientname="+clientname.replace(/ /g, "%20"));
	
		   }
	}
function  funClearData(){
	 $('#clientname').val('');
	 $('#cldocno').val('');
	 $('#srcname').val('');
	 $('#srcno').val('');
	 $('#salname').val('');
	 $('#salid').val('');
	 $('#areaid').val('');
	 $('#txtarea').val('');
	 
	       
	 $('#clientname').attr('placeholder', 'Press F3 To Search');
	 $('#srcname').attr('placeholder', 'Press F3 To Search');
	 $('#salname').attr('placeholder', 'Press F3 To Search');
	 $('#txtarea').attr('placeholder', 'Press F3 To Search');

}	
function getareas(event){
 	 var x= event.keyCode;
 	 //alert("x===="+x);
 	 if(x==114){
 	  $('#areawindow').jqxWindow('open');

           areaSearchContent('area.jsp?getarea=0');  	 }
  	 else{
  		
 		 }
        	 }
 
        	 
function areaSearchContent(url) {
 //alert(url);
 	 $.get(url).done(function (data) {
		 //alert(data);
$('#areawindow').jqxWindow('setContent', data);

               	}); 
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td width="20%"  align="right" ><label class="branch">From</label></td>
	  <td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td>
                     <td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
<%-- 	 <table width="100%">
	 <tr>
	<td  align="right"><label class="branch" >From Date</label></td><td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           
	</tr> 
	
	 <tr>
	<td align="right"><label class="branch">To Date</label></td><td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
    </tr>
     </table>
	</td> --%>      
	
	 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td align="right"> <label class="branch">Client</label></td> <td ><input type="text"  id="clientname" name="clientname" readonly="readonly" style="height:20px;width:95%;"  placeholder="F3 To Search " value='<s:property value="clientname"/>' onKeyDown="getclientinfo(event);"> </td></tr> 
 <tr><td align="right"> <label class="branch">Source</label></td> <td ><input type="text"  id="srcname" name="srcname" readonly="readonly" style="height:20px;width:95%;"  placeholder="F3 To Search " value='<s:property value="srcname"/>' onKeyDown="getsrcinfo(event);"> </td></tr>
 <tr><td align="right"> <label class="branch">Sales Man</label></td> <td ><input type="text"  id="salname" name="salname" readonly="readonly" style="height:20px;width:95%;"  placeholder="F3 To Search " value='<s:property value="salname"/>' onKeyDown="getsalminfo(event);"> </td></tr> 
<tr><td align="right"> <label class="branch">Area</label></td>
<td ><input type="text" id="txtarea" name="txtarea" style="height:20px;width:95%;" readonly="true" placeholder="press F3 to search" value='<s:property value="txtarea"/>' onKeyDown=" getareas(event);"/></td>
<%--  <td colspan="2"><input type="text" id="txtareadet" name="txtareadet" readonly="true" style="width:68%;" value='<s:property value="txtareadet"/>'/></td> --%></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	</tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 
  <tr>
	<td colspan="2" ><div id="Countgrid"><jsp:include page="Countgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	
 
 
		
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
	<input type="hidden" id="srcno" name="srcno"  >
	<input type="hidden" id="salid" name="salid"  >
	<input type="hidden" id="areaid" name="salid"  >
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="enqlistdiv"><jsp:include page="enquirylistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
	</td>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
<div id="sourcewindow">
   <div></div>
</div>
<div id="areawindow">
   <div></div>
</div>
<div id="salmwindow">
   <div></div>
</div>
</div>

</body>
</html>