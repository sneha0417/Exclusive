 
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
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

 
	     $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: '  Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#accountSearchwindow').jqxWindow('close');
		   
  /*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	/*  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
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
	 }); */
	 
	  
	  $('#prname').dblclick(function(){
		  	 
		  	 
		  		
	 
			  	  accountSearchContent('pmainsearch.jsp');
		  		 
		});   
	  $('#clientname').dblclick(function(){
		  	 
		  	 
	  		
			 
	  	  accountSearchContent('tmainsearch.jsp');
  		 
});   
	  
});
 
function funExportBtn(){
  	JSONToCSVCon(datamain1, 'Tenancy Contract List', true);
 
  	
	 }

function getaccountdetails2(event){
	 var x= event.keyCode;
	 
 
	 	 if(x==114){
	 	  
	 
	 
		  accountSearchContent('pmainsearch.jsp');  }
	 	 else{
	 		 }
	  
	 }  


function getaccountdetails1(event){
	 var x= event.keyCode;
	 

	 	 if(x==114){
	 	  
	 
	 
		  accountSearchContent('tmainsearch.jsp');  }
	 	 else{
	 		 }
	  
	 }  
 function accountSearchContent(url) {
      //alert(url);
     $('#accountSearchwindow').jqxWindow('open');
         $.get(url).done(function (data) {
//alert(data);
       $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
   	}
function funreload(event)
{

/*    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {   */
	 var barchval = document.getElementById("cmbbranch").value;
		   
		   var cldocno = document.getElementById("cldocno").value;
		   var prdocno = document.getElementById("prdocno").value;
		   var searchby=document.getElementById("searchby").value;
    var fromdate="";
	 var todate= $("#todate").val(); 
	 
	 
	 var statusselect="";
	 
	 var aa="yes";
	     
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("mainGrid.jsp?barchval="+barchval+"&prdocno="+prdocno+"&cldocno="+cldocno+"&searchby="+searchby+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&aa="+aa);
	
		  /* }  */
	}


 
function funupdate()
{
    var docno = document.getElementById("masterdocno").value;
    
	  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			if(parseInt(items)>0)
				 {
				 
				  $.messager.alert('Message', ' Successfully Updated');
				  funreload(event);
				
				  
				  disitems(0);
				  
				 }
			 else
				 {
				 $.messager.alert('Message', ' Not Updated '); 
				 }
			 
			  
			
			 
			
			}
	}
		
x.open("GET","savedata.jsp?docno="+docno,true);

x.send();
		
}


function disitems(val)
{
	
	 
 
			   $('#Update').attr("disabled",true);
			
			 
		
			
	
}

function  funcleardata() 
{
	document.getElementById("cldocno").value="";
	document.getElementById("clientname").value="";
	document.getElementById("prdocno").value="";
	document.getElementById("prname").value="";
	document.getElementById("masterdocno").value="";
	
	
 
	  $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	  $('#prname').attr('placeholder', 'Press F3 TO Search'); 
	
	 
	
 
		
	}


</script>
</head>
<body onload="getBranch();disitems(0);">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
 

  <%--   	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr> --%>
     <tr><td  align="right" ><label class="branch">Up To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    
    

            
   <tr><td align="right" ><label class="branch">Tenant</label></td><td><input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                  <input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' readonly="readonly" placeholder="Press F3 To Search"  style="width:80%;height:20px;" onKeyDown="getaccountdetails1(event);" >   </td></tr>
  
         
            
            <tr><td align="right"><label class="branch">Property  </label></td><td><input type="hidden" name="prdocno" id="prdocno" value='<s:property value="prdocno"/>'> 
            <input type="text"  readonly="readonly"  name="prname" id="prname" value='<s:property value="prname"/>' placeholder="Press F3 To Search"  style="width:80%;height:20px;" onKeyDown="getaccountdetails2(event);" >  </td></tr>  
   
 <tr >
	  <td align="right"><label class="branch">Status</label></td>
	  <td  align="left"><select name="searchby" id="searchby" style="width:52%;">
		<option value="">--Select--</option>
    	<option value="all">ALL</option>
    	<option value="open">OPEN</option>
    	<option value="close">CLOSE</option>
    	</select>
    	</td>
    	 </tr> 
 
            
             	<tr><td colspan="2">&nbsp;</td></tr> 
             	
             	 <tr><td  align="center" colspan="2"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
             	
             	     
             	<tr><td colspan="2">&nbsp;</td></tr>      
             	<tr><td colspan="2">&nbsp;</td></tr> 
             	<tr><td colspan="2">&nbsp;</td></tr> 
            
    <tr><td  align="center" colspan="2"> 
  
    <input type="hidden" name="Update" id="Update" class="myButton" value="Contract Close" onclick="funupdate()"> </td> </tr>
    
  
                
             	<tr><td colspan="2">&nbsp;</td></tr> 
            <tr><td colspan="2">&nbsp;</td></tr>     <tr><td colspan="2">&nbsp;</td></tr> 
            <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:90px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
      <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
      
        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>
      
      

      
   
</td>
<td width="80%">
	<table width="100%"> 
		<tr><td colspan="2"><div id="listdiv"><jsp:include page="mainGrid.jsp"></jsp:include></div></td></tr>
	 
		  
	</table>
</tr>
</table>
<input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>



</div>
 
<div id="accountSearchwindow">
   <div ></div>
</div>
</div>
</body>
</html>