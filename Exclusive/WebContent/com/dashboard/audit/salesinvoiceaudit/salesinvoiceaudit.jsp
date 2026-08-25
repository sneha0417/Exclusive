 
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


	 $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
     $('#accountSearchwindow').jqxWindow('close');
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
	 
	 
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	  
});

function funExportBtn(){
	 
	 JSONToCSVCon(datas, 'Sales Invoice Audit', true);
	   
	   
	 }

function getaccountdetails(event){
	 var x= event.keyCode;
  	
 
		
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function accountSearchContent(url) {
 
         $.get(url).done(function (data) {
 
       $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
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
	 var statusselect=$("#statusselect").val();
	 var type=$("#type").val();
	 var acno=$("#acno").val();
	 var aa="yes";
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("salesinvoiceauditGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&type="+type+"&aa="+aa);
	
		   }
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
	document.getElementById("type").value="1"; 
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
function funAudit(event){
	var docnos = $('#docnos').val();
 
		
	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 saveGridData(docnos);	
	     	}
	 });
}

function saveGridData(docnos){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;

		 if(parseInt(items)>0)
			 {
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
				$('#docnos').val('');
				dis();
		      funreload(event); 
		      
			 }
		 else
			 {
			 $.messager.alert('Message', '  Not Updated ', function(r){
			  });
			 }
			
			
	  }
	}
		
x.open("GET","saveData.jsp?docnos="+docnos,true);
x.send();
}

function typechg()
{
	 $("#invlist").jqxGrid('Clear');
	 $("#invlist").jqxGrid("addrow", null, {});
	
	
	}
function dis(){
    $("#btnaudit").attr('disabled', true); 
}

</script>
</head>
<body onload="getBranch();dis();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
<%--    <tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr ><td align="right" > <label class="branch">Status</label></td> <td ><select id="statusselect" name="statusselect" style="width:70%;">
	<option value="All">All</option>
	<option value="PED">Pending</option>
		  
		
	
	 </select> </td></tr> --%>
	 <tr>
<td align="right"><label class="branch">Account</label></td>
    <td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
 <tr> <td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td></tr>
 
  <tr><td align="right"><label class="branch">Type</label></td><td colspan="1"><select id="type" name="type" onchange="typechg()">
  
  <option value="1">Cash Invoice </option>
    <option value="2">Credit Invoice</option>
  </select></td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 


<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
      <input type="hidden" id="docnos" name="docnos" value='<s:property value="docnos"/>'>
     <input type="hidden" id="statusselect" name="statusselect" value='<s:property value="statusselect"/>'>
   
   
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="salesinvoiceauditGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="accountSearchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>