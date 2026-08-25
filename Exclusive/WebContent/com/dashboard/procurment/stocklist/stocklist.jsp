   
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
	$('#stockLedgerDiv').show();
	 $('#stockLedgerDetDiv').hide();
	 document.getElementById('rsumm').checked=true;
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


 
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
	  */
	 
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
		 
		 $('#txtpartno').dblclick(function(){
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
		 }); 
});

function funExportBtn(){
	if (document.getElementById('rsumm').checked) {
	 //  $("#stocklistgrid").jqxGrid('exportdata', 'xls', 'Strock List');
	 
		JSONToCSVCon(datass, 'Strock List', true);
	   
	   
	}
	 else if (document.getElementById('rdet').checked) {
		 
			//$("#stocklistgriddet").jqxGrid('exportdata', 'xls', 'Strock List');
			
			JSONToCSVCon(dat, 'Strock List', true);
			
			
		}
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
function funreload(event)
{

	 /*  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 var barchval = document.getElementById("cmbbranch").value;
     
	 var statusselect=$("#statusselect").val();
	 
	 var psrno=$("#psrno").val();
	 
 
   
		if (document.getElementById('rsumm').checked) {
			
			   
			  
			  $("#overlay, #PleaseWait").show();
			  var load="yes";
			  $("#stockLedgerDiv").load("stockGridSummary.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
		}
		 else if (document.getElementById('rdet').checked) {
			 
			   $("#overlay, #PleaseWait").show();
			   var load="yes";
				  $("#stockLedgerDetDiv").load("stockGridDetail.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
			 
			}  
	  
	}

function  funcleardata()
{
	// txtpartno  psrno   txtproductname   Press F3 to Search;
	 
	 document.getElementById('txtpartno').value="";
	 document.getElementById('txtproductname').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('rsumm').checked=true;
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	}
	
function fundisable(){
	

	
	if (document.getElementById('rsumm').checked) {
		
		  $('#stockLedgerDiv').show();
		   $('#stockLedgerDetDiv').hide();
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#stockLedgerDiv').hide();
		  $('#stockLedgerDetDiv').show();
		 
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <%-- <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr> --%>

 
 <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail</label></td></tr>
	 <tr>

 


 
     <tr><td align="right"><label class="branch">Product</label></td>
	<td align="left"><input type="text" id="txtpartno" name="txtpartno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/></td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/></td></tr> 
 
 
 <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
      <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
      <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
	</tr>	
	</table>
	</fieldset>
	
	 <input type="hidden" id="statusselect" name="statusselect" value='<s:property value="statusselect"/>'>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	<%-- <table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
		</tr>
	</table> --%>
	
		<table width="100%">
		<tr>
			 <td><div id="stockLedgerDiv"><jsp:include page="stockGridSummary.jsp"></jsp:include></div></td>
		</tr>
		    <tr><td><div id="stockLedgerDetDiv">
				 <jsp:include page="stockGridDetail.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
	
</tr>
</table>

</div>
 
<div id="productDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>