
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






<script type="text/javascript">

$(document).ready(function () {
	
	$('#orderlist').show();
	 $('#orderlistdetails').hide();
	 document.getElementById('rsumm').checked=true;
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
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
	 
	 
     $('#acno').dblclick(function(){
 	 
  		  
		  $('#accountDetailsWindow').jqxWindow('open');
		 commenSearchContent('accountsDetailsSearch.jsp?');
 		    
 		   
	  }); 
	  
});
function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('accountsDetailsSearch.jsp?');
	 }
	 }   
	 
function funExportBtn(){
	  
	   if(document.getElementById('rsumm').checked) {
	  
	JSONToCSVCon(rdatasex, 'Ni Purchase Order Reports', true);
	   }
	   else if (document.getElementById('rdet').checked) {
		   JSONToCSVCon(rdatasdetailsex, 'Ni Purchase Order Details Reports', true);
	   }
	 }
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

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
		   
		   var fromdocno=$("#fromdocno").val();
		   var todocno=$("#todocno").val();   
		   var fromamount=$("#fromamount").val();  
		   var toamount=$("#toamount").val(); 
		   
		   if(fromdocno!="")
			   {
			   if(todocno=="")
				   {
				   
				   $.messager.alert('Message','Enter To Doc No ','warning');   
					 
				   return false;
				   
				   }
			   else if(parseInt(todocno)<parseInt(fromdocno))
				   {
				   
				   $.messager.alert('Message','To Doc No Less Than From Doc No','warning');   
					 
				   return false;
				   
				   }
			   
			   
			   
			   }
		   
		   if(fromamount!="")
		   {
		   if(toamount=="")
			   {
			   
			   $.messager.alert('Message','Enter To Amount ','warning');   
				 
			   return false;
			   
			   }
		   
		   else if(parseFloat(toamount)<parseFloat(fromamount))
		   {
		   
		   $.messager.alert('Message','To Amount Less Than From Amount  ','warning');   
			 
		   return false;
		   
		   }
		   
		   }
	   
		   

		   
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 
     var type=$("#statusselect").val();	
     
     
 // alert(type);
	 var accdocno=$("#accdocno").val(); 
	   $("#overlay, #PleaseWait").show();
	   if(document.getElementById('rsumm').checked) {
	  $("#listdiv").load("puchaseorderreportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno+"&type="+type);
	   }
	   else if (document.getElementById('rdet').checked) {
		   $("#listdetdiv").load("puchaseorderreportdetailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno+"&type="+type);
	   }
		   }
	}
	
	
	
function funClearInfo()
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
	  $(this).attr('placeholder', ''); */
	  
	 
	 
}
	   
	
	
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    	}
   // document.getElementById("errormsg").innerText="";  
    return true;
}

function fundisable(){
	

	
	if (document.getElementById('rsumm').checked) {
		
		 $('#orderlist').show(); 
		   $('#orderlistdetails').hide();
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#orderlist').hide(); 
		  $('#orderlistdetails').show();
		 
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
		<tr><td  width="20%">&nbsp;</td><td  width="80%">&nbsp;</td></tr>
 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
  <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail</label></td></tr>
	
	 	<tr ><td align="right"  > <label class="branch">DOC NO</label> </td><td align="left">
	 	 <input type="text" id="fromdocno" name="fromdocno" style="width:40%;height:20px;" placeholder="From"  value='<s:property value="fromdocno"/>' onkeypress="javascript:return isNumber (event);" />&nbsp;-&nbsp;<input type="text" id="todocno" placeholder="To"  name="todocno" style="width:40%;height:20px;" value='<s:property value="todocno"/>' onkeypress="javascript:return isNumber (event);"/> </td></tr>
	<tr ><td align="right"  > <label class="branch">Amount</label> </td><td align="left">
	 	 <input type="text" id="fromamount" name="fromamount" style="width:40%;height:20px;text-align:right;" placeholder="From"  value='<s:property value="fromamount"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" />&nbsp;-&nbsp;<input type="text" id="toamount" placeholder="To"  name="toamount" style="width:40%;height:20px;text-align:right;" value='<s:property value="toamount"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" /> </td></tr>
   <tr><td align="right"><label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="acno" name="acno" style="width:88%;height:20px;" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="acno"/>' tabindex="-1" onkeydown="getacc(event);"/></td></tr> 
	<tr><td>&nbsp;</td> 
	<td><input type="text" id="accname" name="accname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="accname"/>' tabindex="-1"/>
     </td></tr>
     
     
     
     
     
      
	 	<tr ><td align="right" > <label class="branch">Type</label></td> <td ><select id="statusselect" name="statusselect" style="width:70%;">
	<option value="All">All</option>
	<option value="PED">Pending</option>
		<option value="INV">Invoiced</option></select>  
		</td></tr> 
				   
	
	
     
     
     
     
     
     
     
 
 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 100px;"></div></td>
	</tr>	
	</table>
	</fieldset>
	
	<input type="hidden" id="accdocno" name="accdocno" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="accdocno"/>' tabindex="-1"/>
	
	 
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="puchaseorderreportGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr><td><div id="listdetdiv">
				 <jsp:include page="puchaseorderreportdetailsGrid.jsp"></jsp:include> 
				</div></td></tr>
	</table>
</tr>
</table>

</div>
 
<div id="accountDetailsWindow">
	<div></div> 
</div>


</div>
</body>
</html>