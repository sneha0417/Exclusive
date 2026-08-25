  
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
	 
		   
		   
		   
		   
			$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		    $('#accounttypeSearchwindow').jqxWindow('close');
		    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
		    $('#costtpesearchwndow').jqxWindow('close');   
		    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
		    $('#costcodesearchwndow').jqxWindow('close');  
		    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
		    $('#refnosearchwindow').jqxWindow('close');  
		    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
		    $('#nipurchslnosearch').jqxWindow('close');
		    
		    
		    $("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		    
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



function getTaxper(date){
	
	var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
    if (x.readyState == 4 && x.status == 200) {
	    var items = x.responseText.trim();
	    $('#taxperc').val(items);
    }
   }
   x.open("GET", "getTaxper.jsp?date="+date, true);
   x.send();
}
function costcodeSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#costcodesearchwndow').jqxWindow('open');
		$('#costcodesearchwndow').jqxWindow('setContent', data);

	}); 
	}  

	function costSearchContent(url) {
		 //alert(url);
			 $.get(url).done(function (data) {
				 
				 $('#costtpesearchwndow').jqxWindow('open');
			$('#costtpesearchwndow').jqxWindow('setContent', data);
	
		}); 
		} 
		
	function CashSearchContent(url) {
		 //alert(url);
			 $.get(url).done(function (data) {
				 
				 $('#accounttypeSearchwindow').jqxWindow('open');
			$('#accounttypeSearchwindow').jqxWindow('setContent', data);
	
		}); 
		} 
  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);
	
		}); 
	    	}
		  
 
		 	
 
function funExportBtn(){
 
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
	  $("#nidescdetailsGrid").jqxGrid('clear');
	 var acno=$("#acno").val();
	 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("listGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno);
	
		   }
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
 
	
 
	document.getElementById("statusselect").value="All";
	
	
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
	
	
	function dis(val)
	{
		

		if(val=="1")
			{
			$('#pono').attr("readonly",false);
			$('#desc1').attr("readonly",false);
			 $('#Update').attr("disabled",false);
		   
			 document.getElementById("desc1").value="";
			 document.getElementById("pono").value="";
			 
			 $('#podate').val(new Date());
			 $('#podate').jqxDateTimeInput({ disabled: false});
			 
			 
			
			}
		else 
			{
	
			 
				$('#pono').attr("readonly",true);
				$('#desc1').attr("readonly",true);
				 $('#Update').attr("disabled",true);
			   
				 document.getElementById("desc1").value="";
				 document.getElementById("pono").value="";
				 
				 $('#podate').val(new Date());
				 $('#podate').jqxDateTimeInput({ disabled: true});
			}
		
		
	}
	
	
	function funupdate()
	{
		
		
		
		 // maintotal maintax subtotal subtax
		 
		 
		 var maintotal=document.getElementById("maintotal").value;
		
		 var maintax=document.getElementById("maintax").value;
			
		 var subtotal=document.getElementById("subtotal").value;
			
		 var subtax=document.getElementById("subtax").value;
			
		 
		 	if(maintotal=="" || maintotal==null || maintotal==0 ||typeof(maintotal)=="undefined"|| typeof(maintotal)=="NaN")
			{
			 maintotal=0;
			}
			 
			if(maintax=="" || maintax==null || maintax==0 || typeof(maintax)=="undefined"|| typeof(maintax)=="NaN")
			{
				maintax=0;
			}
			
			if(subtotal=="" || subtotal==null || subtotal==0 ||typeof(subtotal)=="undefined"|| typeof(subtotal)=="NaN")
			{
				subtotal=0;
			}
			 
			if(subtax=="" || subtax==null || subtax==0 || typeof(subtax)=="undefined"|| typeof(subtax)=="NaN")
			{
				subtax=0;
			}
		
			if(parseFloat(maintax)!=parseFloat(subtax))
			{
			 $.messager.alert('Message', ' Tax total should be equal');
			return 0;
			}
			
			if(parseFloat(maintotal)!=parseFloat(subtotal))
				{
				
				 $.messager.alert('Message', ' Net total should be equal');
					return 0;
				}
			
		
	 
		
		var listss = new Array();
 
	 
		 var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
		  
		   for(var i=0 ; i < rows.length-1 ; i++){
	 
		   var aa=0;
	 
		   
				   listss.push(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
					 +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
					 +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
					 +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: ");
 
		   }
 
 
					  
			 
 
	      
	      
	      var docno = document.getElementById("masterdocno").value;
	  
	 	 var branchids = document.getElementById("brhid").value;
	 	 var desc1 = document.getElementById("desc1").value;
	 	 
		 var podate = document.getElementById("podate").value;
		 var pono = document.getElementById("pono").value;
		 
		 
		

		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		
		     		
		     		
		     		
		     		
		     		 savegriddata(docno,branchids,desc1,podate,pono,listss);	
		     	}
			     });
		
		
		
	}
	function savegriddata(docno,branchids,desc1,podate,pono,listss)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
	     			
				var items=x.responseText;
				if(parseInt(items)>0)
					 {
				 
						  $.messager.alert('Message', ' Successfully Created : '+items);
						 
					  funreload(event);
					
					  
					  dis(0);
					  
					 }
				 else
					 {
					 $.messager.alert('Message', ' Not Created '); 
					 }
				 
				  
				
				 
				
				} 
		}
			
	x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&desc1="+desc1+"&pono="+pono+"&podate="+podate+"&listss="+listss+"&taxperc="+document.getElementById("taxperc").value+"&nettotal="+document.getElementById("nettotal").value,true);

	x.send();
			
	}


	
	
</script>
</head>
<body onload="getBranch();dis(0)">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  > 
	<jsp:include page="../../heading.jsp"></jsp:include>
		<input type="hidden" id="maintotal" name="maintotal" value='<s:property value="maintotal"/>'>
    
       <input type="hidden" id="maintax" name="maintax" value='<s:property value="maintax"/>'>
    
    
               <input type="hidden" id="subtotal" name="subtotal" value='<s:property value="subtotal"/>'>
    
       <input type="hidden" id="subtax" name="subtax" value='<s:property value="subtax"/>'>
    
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr ><td align="right" > <label class="branch">Type</label></td> <td ><select id="atype" name="atype" style="width:70%;">
	<option value="AR">AR</option>
	<option value="AP">AP</option>
		<option value="GL">GL</option>   
		
	
	 </select> </td></tr>
	 <tr>
<td align="right"><label class="branch">Account</label></td>
    <td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
 <tr> <td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td></tr>
 
  

 

 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>


 <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
<tr><td  align="right" ><label class="branch">PO Date</label></td><td align="left"><div id='podate' name='podate' value='<s:property value="podate"/>'></div> </td></tr>
       <tr><td  align="right" ><label class="branch">PO No</label></td><td align="left"> <input type="text" id="pono" style="height:20px;width:70%;"  name="pono" value='<s:property value="pono"/>'/> </td></tr>
     
           <tr><td  align="right" ><label class="branch">Description</label></td><td align="left"> <input type="text" id="desc1" style="height:20px;width:70%;"  name="desc1" value='<s:property value="desc1"/>'/> </td></tr>
     
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()"> </td> </tr>
 

	 	
 <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 
	</table>
	</fieldset>
	
	 <input type="hidden" id="setdocno" name="setdocno" value='<s:property value="setdocno"/>'>
	
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
    <input type="hidden" id="taxperc" name="taxperc" value='<s:property value="taxperc"/>'> 
    
        <input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>
    
        <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
        
                <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
        
                <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'>
         <input type="hidden" id="costgropename" name="costgropename" value='<s:property value="costgropename"/>'>
        
             <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'>
    	 
    
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
		</tr>
		
				<tr>
			 <td><div id="listdiv1"><jsp:include page="descgridDetails.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="accountSearchwindow">
   <div ></div>
</div> 
	 <div id="accounttypeSearchwindow">
	   <div></div>
	</div>
	<div id="costtpesearchwndow">
	   <div></div>
	</div>
	 <div id="costcodesearchwndow">
	   <div></div>
	</div> 
		 <div id="refnosearchwindow">
	   <div></div>
	</div> 
		 <div id="nipurchslnosearch">
	   <div></div>
	</div> 
</div>
</body>
</html>