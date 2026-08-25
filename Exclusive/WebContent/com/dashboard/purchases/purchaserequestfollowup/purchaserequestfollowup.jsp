 
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

	       $('#Searchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#Searchwindow').jqxWindow('close');
 
		   $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
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
	 
			 
		   $('#docnosss').dblclick(function(){
		    
		    	
		    		
			  	    $('#Searchwindow').jqxWindow('open');
			  	
			  	  SearchContent('mainsearch.jsp?');
		    		 
		  });  
	  
});
 
 
 
function  funcleardata()
{
	document.getElementById("reqdocno").value="";
	document.getElementById("docnosss").value="";
    $('#docnosss').attr('placeholder', 'Press F3 TO Search'); 
}
	  
		
 
 
 
function getdetails(event){
	 var x= event.keyCode;
 	

		
	 if(x==114){
	  $('#Searchwindow').jqxWindow('open');
	
	  SearchContent('mainsearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function SearchContent(url) {

        $.get(url).done(function (data) {

      $('#Searchwindow').jqxWindow('setContent', data);

	}); 
  	}
 
function funExportBtn(){
	JSONToCSVCon(datasex,'Purchase Request Followup Mater', true);
	JSONToCSVCon(datas11ex,'Purchase Request Followup Details', true);
	 }

 
 
function funreload(event)
{
	disitems(0);
	/*   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 var barchval = document.getElementById("cmbbranch").value;
		   
		   	   
		   
/*      var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); */
	 
	 var fromdate="";
	 var todate="";
	 
	 var statusselect="";
	 
	 var reqdocno=$("#reqdocno").val();
	  $("#ordersubgrid").jqxGrid('clear');
	  $("#duedetailsgrid").jqxGrid('clear');
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("mainGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&reqdocno="+reqdocno);
	
		  /*  } */
	}

 
function getinfo() {
	  var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send(); 
}
 
 
function funupdate()
{
	var docno = document.getElementById("masterdocno").value;
	  
	 var branchids = document.getElementById("brhid").value;
	 var remarks = document.getElementById("remarks").value;
	 var cmbinfo = document.getElementById("cmbinfo").value;
      
	 var folldate =$('#date').val();
 
	 
	 
	
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
		
x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate,true);

x.send();
		
}

function disitems(val)
{
	
	 
			if(val=="1")
				{
				
				 $('#cmbinfo').attr("disabled",false);
				 
				 $('#remarks').attr("disabled",false);
				 $('#remarks').attr("readonly",false);
				 $('#Update').attr("disabled",false);
			   
				 document.getElementById("remarks").value="";
	 
				 
				 $('#date').val(new Date());
				 $('#date').jqxDateTimeInput({ disabled: false});
				 
				}
		 
			
			else
			{
	 
				 $('#cmbinfo').attr("disabled",true);
				 
				 $('#remarks').attr("disabled",true);
				 $('#remarks').attr("readonly",true);
				 $('#Update').attr("disabled",true);
			   
				 document.getElementById("remarks").value="";
 
				 
				 $('#date').val(new Date());
				 $('#date').jqxDateTimeInput({ disabled: true});
				 
			
			}
		
			
	
}
 

</script>
</head>
<body onload="getBranch();getinfo();disitems(0);">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td align="right"><label class="branch">Doc No</label></td>
    <td><input type="text" name="docnosss" id="docnosss" value='<s:property value="docnosss"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getdetails(event);" >  </td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr> 
             <tr><td colspan="2">&nbsp;</td></tr> 
    	             
    	                   <tr><td colspan="2">&nbsp;</td></tr>  
    	               <tr><td colspan="2">&nbsp;</td></tr> 
    <tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
    <select name="cmbinfo" id="cmbinfo" style="width:70%;" value='<s:property value="cmbinfo"/>'   > </select></td></tr>
     <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div> </td></tr>
    <tr><td align="right"><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
    <tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()"> </td> </tr>
    	<tr><td colspan="2">&nbsp;</td></tr> 
    	   <tr><td colspan="2">&nbsp;</td></tr> 
    	   
       <tr><td colspan="2">&nbsp;</td></tr> 
    	
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:90px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
      <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
      
        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>
           <input type="hidden" id="reqdocno" name="reqdocno" value='<s:property value="reqdocno"/>'>
      
      

      
   
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="listdiv"><jsp:include page="mainGrid.jsp"></jsp:include></div></td></tr>
	    <tr><td><div id="listdiv1"><jsp:include page="subGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
<input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>



</div>
	  <div id="locationwindow">
	   <div ></div>
	</div>

<div id="Searchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>