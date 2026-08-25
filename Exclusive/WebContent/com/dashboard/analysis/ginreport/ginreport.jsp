
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

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}

</style>





<%
	String contextPath=request.getContextPath();
 %>
<script type="text/javascript">

$(document).ready(function () {


	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	     $('#searchwindow').jqxWindow('close');
	     
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		
		 
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
	 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#productDetailsWindow').jqxWindow('close');
	 
	 $('#salmwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sales Man Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salmwindow').jqxWindow('close');
	 
	 $('#txtpartno').dblclick(function(){
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
	 }); 
	 
	 $('#txtclientname').dblclick(function(){
		  accountsSearchContent('clientDetailsSearch.jsp');
	 });
	 
	 $('#salname').dblclick(function(){
	 	    
		   $('#salmwindow').jqxWindow('open');
		   salmsearchContent('salmsearch.jsp', $('#salmwindow')); 
	       });
	 $('#itemname').dblclick(function(){
	 
 	    $('#searchwindow').jqxWindow('open');
 	
		if(document.getElementById("itemtype").value=="1") 
			{
		 
			refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		
		else
			{
			  	
			}
		
		 
			  
	  }); 
  
});
function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getClientAccount(event){
    var x= event.keyCode;
    if(x==114){
  	  accountsSearchContent('clientDetailsSearch.jsp');
    }
    else{}
    }
 
function productSearchContent(url) {
    $('#productDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#productDetailsWindow').jqxWindow('setContent', data);
	$('#productDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getProduct(){
	
	 $('#productDetailsWindow').jqxWindow('open');
		$('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

}

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
function getitem(event){
	
 	 var x= event.keyCode;
 	 if(x==114){

 		  $('#searchwindow').jqxWindow('open');
 			
 		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
 		
		refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno=1');
		}
 		
		
 		
	else
		{
		  	
		}		  
 	 
 	 }
 	 }  
 	  function refsearchContent(url) {
      
       //document.getElementById("errormsg").innerText="";
         $.get(url).done(function (data) {
 //alert(data);
       $('#searchwindow').jqxWindow('setContent', data);

 	}); 
   	}
 function funExportBtn(){
	  
	
		JSONToCSVCon(rdatas, 'GIS Reports', true);
	
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
	  
		 
	   
		   

		   
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 

	 
	  var psrno = document.getElementById("psrno").value; 
	
	 
	
 
	 
	   $("#overlay, #PleaseWait").show();
	  
	  
	   
	   var aa="yes";
	   
		   $("#listdetdiv").load("ginreportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&aa="+aa);
			         
		   }
	
	
	
/* function funClearInfo()
{
	 
	 
	 
	  $("#fromdocno").val('');
	  $("#todocno").val('');   
	 $("#fromamount").val('');  
	 $("#toamount").val(''); 
	  $("#accdocno").val(''); 
	  
	 $("#acno").val(''); 
	 $("#accname").val(''); 
	 
	 
	  $("#fromdocno").attr('placeholder', 'From');
	  $("#todocno").attr('placeholder', 'To');
	  $("#fromamount").attr('placeholder', 'From');
	  $("#toamount").attr('placeholder', 'To');
	  
	  
	/*   $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  
	 
	 
} */
	   
	
	
/* function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    	}
   // document.getElementById("errormsg").innerText="";  
    return true;
} */	
function fundisable(){
	

	/* 
	if (document.getElementById('rsumm').checked) {
		$('#orderlist').show(); 
		  $('#orderlistdetails').hide();
		 
		   $('#summuryselect').attr('disabled', false);
		}
	 else if (document.getElementById('rdet').checked) {
		 
		 $('#orderlist').hide(); 
		   $('#orderlistdetails').show();
		  $('#summuryselect').attr('disabled', true);
		} */
	 }
function  getproject(){
	document.getElementById("itemtype").value="1";
	$('#summuryselect').attr('disabled', true);
}

function  funcleardata()
{
	// txtpartno  psrno   txtproductname   Press F3 to Search;
	 

	 document.getElementById('txtpartno').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('txtproductname').value="";
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	
	}
</script>
</head>
<body onload="getBranch();getproject();">
<div id="mainBG" class="homeContent" data-type="background">  
<div class='hidden-scrollbar'>                               
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		<tr><td  width="25%">&nbsp;</td><td  width="75%">&nbsp;</td></tr>
 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    
	<tr><td>&nbsp;</td></tr>	
 <tr><td align="right"><label class="branch">Product</label></td>
	<td align="left"><input type="text" id="txtpartno" name="txtpartno" style="width:70%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/></td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
<tr><td>&nbsp;</td>
	<td><input type="text" id="txtproductname" name="txtproductname" style="width:70%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/></td></tr> 
 
<tr><td>&nbsp;</td></tr>	
  
<!-- 	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 100px;"></div></td>
	</tr> -->	
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
	<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>	<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
 <tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr> <tr><td>&nbsp;</td></tr> <tr><td>&nbsp;</td></tr>
	
	</table>
	</fieldset>
	
	
	<input type="hidden" id="costtr_no" name="costtr_no"  >
	 
</td>

	<td width="80%">
	
	
	<table width="100%">
		
		    <tr><td><div id="listdetdiv">
				 <jsp:include page="ginreportGrid.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
	</td>
</tr>
</table>



</div>
 
<div id="accountDetailsWindow">
	<div></div> 
</div>
<div id="productDetailsWindow">
<div></div> 
</div>
<div id="salmwindow">
<div></div> 
</div>
<div id="searchwindow">
   <div ></div>
</div>


</div>
</body>
</html>