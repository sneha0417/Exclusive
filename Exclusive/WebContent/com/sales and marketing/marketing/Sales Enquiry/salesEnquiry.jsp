<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<%
	String contextPath = request.getContextPath();
%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
	color: red;
	font-weight: bold;
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
	 $('#btnvaluechange').hide();
	   /* Date */ 	
    $("#date").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	   
    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');   
	 	$('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
			x : 420,
         	y : 87
		}, keyboardCloseKey: 27});
	    $('#tremwndow').jqxWindow('close');
     
		 $('#date').on('change', function (event) {
			  
			    var maindate = $('#date').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });
	     
		 $('#salespersonwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '45%',
				title : 'Sales Person Search',
				position : {
					x : 420,
					y : 87
				},
				theme : 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#salespersonwindow').jqxWindow('close');
	    
	     $('#shipto').dblclick(function(){
	         
	     	if($('#mode').val()!= "view")
	     		{
	     	
	     		
	 	  	  
	 	  	
	 	  	   shipSearchContent('shipmasterSearch.jsp?');
	     		}
	   });   
	     

	     
    $('#txtclient').dblclick(function(){
   
    	if($('#mode').val()!= "view")
    		{
    		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	clientSearchContent('clientINgridsearch.jsp');
    		}
  });   
    
	 $('#txtsalesperson').dblclick(function(){
		   
	    	if($('#mode').val()!= "view")
	    		{
	    		salespersonSearchContent('salesPersonSearch.jsp');
	    		}
	  });
	 
    
	$("#r1").click(function() {
		$('#txtclient').hide();
		document.getElementById("r2").checked = false;
		
	});
	
	
	$("#cmbcurr").click(function() {
		getCurrencyIds();
		
	});
	
	$("#r2").click(function() {
		$('#txtclient').show();
		document.getElementById("r1").checked = false;
		
	}); 
    
  
});



function getSalesPerson(event){
	 var x= event.keyCode;
	 if(x==114){
		salespersonSearchContent('salesPersonSearch.jsp');  	 }
	 else{
		 }
      	 }

function salespersonSearchContent(url) {
	$('#salespersonwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#salespersonwindow').jqxWindow('setContent', data);
		$('#salespersonwindow').jqxWindow('bringToFront');
	});
}

function getshipdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	 
 	
 	  shipSearchContent('shipmasterSearch.jsp?');    }
 	 else{
 		 }
 		}
 	 }  
function shipSearchContent(url) {
    //alert(url);
      $('#accountSearchwindow').jqxWindow('open');
       $.get(url).done(function (data) {
//alert(data);
     $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
 	}  


function shipdescSearchContent(url) {
    //alert(url);
       $.get(url).done(function (data) {
//alert(data);
  $('#tremwndow').jqxWindow('open');
     $('#tremwndow').jqxWindow('setContent', data);

	}); 
 	}  


function getclientdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 clientSearchContent('clientINgridsearch.jsp');    }
 	 else{
 		 }
 		}
 	 }  
	  function accountSearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
    	}
	  
	  
		 function getclinfo(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    	  $('#accountSearchwindow').jqxWindow('open');
	    
	    
	    	 clientSearchContent('clientINgridsearch.jsp', $('#accountSearchwindow'));    }
	    	 else{
	    		 }
	    	 } 
		       function clientSearchContent(url) {
	                 
		                 $.get(url).done(function (data) {
	        
			           $('#accountSearchwindow').jqxWindow('setContent', data);

	          	}); 
		           	} 
	  
	  
      function productSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#searchwndow').jqxWindow('open');
     		$('#searchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 

function funReset(){
	//$('#salesEnquiry')[0].reset(); 
}
function funReadOnly(){
	
	$('#salesEnquiry input').attr('readonly', true );
	$('#salesEnquiry select').attr('disabled', true );
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $("#prodetGrid").jqxGrid({ disabled: true});
	 $("#shipdata").jqxGrid({ disabled: true});
	 $('#r1').attr('disabled', true);
	$('#r2').attr('disabled', true);
	$('#btnvaluechange').hide();
}

function funRemoveReadOnly(){
	
	 document.getElementById("editdata").value="";
	 chkmultiqty();
	$('#r1').attr('disabled', false);
	$('#r2').attr('disabled', false);
	
	if ($("#mode").val() == "A") {
	document.getElementById("r1").checked = true;
	$('#txtclient').hide();
	}
	
	$('#salesEnquiry input').attr('readonly', false );
	$('#salesEnquiry select').attr('disabled', false );
	
	$('#txtsalesperson').attr('readonly', true );
	
      $('#currate').attr('readonly', true);
	  $('#txtclient').attr('readonly', true);
	  $('#puraccname').attr('readonly', true); 
	 $('#date').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	 $("#prodetGrid").jqxGrid({ disabled: false});
	 
	 
	 
	 $('#shipto').attr('readonly', true);
	 $('#shipaddress').attr('readonly', true);
	 $('#contactperson').attr('readonly', true);
	 $('#shiptelephone').attr('readonly', true);
	 $('#shipmob').attr('readonly', true);
	 
	 $('#shipemail').attr('readonly', true);
	 $('#shipfax').attr('readonly', true);
	 
	 
	 
	 $("#shipdata").jqxGrid({ disabled: false});

	if ($("#mode").val() == "A") {
		$('#date').val(new Date());
		$("#shipdata").jqxGrid('clear');
	  $("#shipdata").jqxGrid('addrow', null, {});
	  
	  
	  $("#prodetGrid").jqxGrid('clear');
	  $("#prodetGrid").jqxGrid('addrow', null, {});
		    		   
	   }
	if ($("#mode").val() == "E") {
	
		 $('#btnvaluechange').show();
		$("#prodetGrid").jqxGrid({ disabled: true});
		$("#shipdata").jqxGrid({ disabled: true});
	
	
	}
	getCurrencyIds();
}

function funFocus(){
	 
   	$('#date').jqxDateTimeInput('focus'); 	    		
}

function funDateInPeriodchk(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
 
     if(value>currentDate){
     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
    
     return 0;
    } 
    
    document.getElementById("errormsg").innerText="";
   
     return 1;
 }


function funNotify(){	
	
	
	
	var maindate = $('#date').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriodchk(maindate);
	   if(validdate==0){
	   return 0; 
	   }

 
var client= document.getElementById("txtclientdet").value;

if(client=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Client";
	 
	 return 0;
	}

var txtemail= document.getElementById("txtemail").value;

if(txtemail!="")
	{

	if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(txtemail))  
	{  
	  
	} 
	else
		{
	
	 document.getElementById("errormsg").innerText=" You have entered an invalid email address!";
	 
	 // alert("")  
	  return (false)  ;
		}
	}



 var rows = $("#prodetGrid").jqxGrid('getrows');
   $('#proGridlen').val(rows.length);
  for(var i=0 ; i < rows.length ; i++){ 
   newTextBox = $(document.createElement("input"))
      .attr("type", "dil")
      .attr("id", "prodg"+i)
      .attr("name", "prodg"+i)
      .attr("hidden", "true");
   
  newTextBox.val(rows[i].size+"::"+rows[i].qty+" :: "+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].specid+" :: ");  
  
  newTextBox.appendTo('form');
  }
  
  
  var rows = $("#shipdata").jqxGrid('getrows');
  $('#shipdatagridlenght').val(rows.length);
 //alert($('#gridlength').val());
 for(var i=0 ; i < rows.length ; i++){
 // var myvar = rows[i].tarif; 
  newTextBox = $(document.createElement("input"))
     .attr("type", "dil")
     .attr("id", "shiptest"+i)
     .attr("name", "shiptest"+i)
     .attr("hidden", "true"); 
 
 newTextBox.val(rows[i].doc_nos+"::"+rows[i].desc1+" :: "+rows[i].refno+" :: "+rows[i].date+" :: ");

// alert(newTextBox.val());
 newTextBox.appendTo('form');

  // alert("ddddd"+$("#test"+i).val());
  
 }  
 


  

	return 1;
} 

function funChkButton() {
	

}

function funSearchLoad(){
	 changeContent('enqMastersearch.jsp'); 
}


function getCurrencyIds(){ 
	
	var clientid=document.getElementById("clientid").value;
	
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var curidItems=items[0];
	           var curcodeItems=items[1];
	           var currateItems=items[2];
	           var multiItems=items[3];
	           var optionscurr = '';
	           if(curcodeItems.indexOf(",")>=0){
	            curidItems.split(",");
	            curcodeItems.split(",");
	            currateItems.split(",");
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           }
	            $("select#cmbcurr").html(optionscurr);
	          
	        }
	   
	          else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	          
	        //  $('#currate').val(currateItems) ;
	          
	          funRoundRate(currateItems,"currate");
	      
	          $('#currate').attr('readonly', true);
	       
	      }
	    }
	       }
	   x.open("GET","getCurrencyId.jsp?clientid="+clientid,true);
		x.send();
	        
	      
	        }
	   
	   function getRatevalue(angel)
	   {
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText;
	      
	      
	    /*      $('#currate').val(items) ; */
	         funRoundRate(items,"currate"); 
	        }
	          else
	      {
	      }
	       }
	   x.open("GET","getRateTo.jsp?curr="+a,true);
		x.send();
	        
	      
	        }
	   

	$(function(){
        $('#salesEnquiry').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	txtclientdet:{required:true},
                	txtmob:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
                	 txtclientdet: {required:" *"},
                	 txtmob: {required:" *"}
                 }
        });});
	
	function setValues(){
		
		var clid=document.getElementById("clientid").value;
	/* 	if($('#date').val()){
			$("#date").jqxDateTimeInput('val', $('#date').val());
		}
		 */
		if(clid>0){
			
			$('#txtclient').show();
			document.getElementById("r2").checked = true;
			document.getElementById("r1").checked = false;
			
		}
		else{
			
			$('#txtclient').hide();
			document.getElementById("r2").checked = false;
			document.getElementById("r1").checked = true;
		}
		
		if ($('#msg').val() != "") {
			$.messager.alert('Message', $('#msg').val());
		}
		
		//alert(document.getElementById("r2").value());
		
		fungridload();
		
		  var masterdoc_no=$('#masterdoc_no').val().trim();
	 
		  if(masterdoc_no>0){
		
		 funchkforedit();
		  }
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		
		}
	
function fungridload(){
		
		var docno=document.getElementById("masterdoc_no").value;
		if(docno>0){
		$("#prodet").load("prodetGrid.jsp?docno="+docno);
		
		 $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+docno+"&formcode="+$('#formdetailcode').val());
		
		}
	}

function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    	    
			   
			   document.getElementById("editdata").value="Editvalue";
			   
		 	$("#prodetGrid").jqxGrid({ disabled: false});
		 	$("#prodetGrid").jqxGrid('addrow', null, {});
 
		    
		 	$("#shipdata").jqxGrid({ disabled: false});
		 	$("#shipdata").jqxGrid('addrow', null, {});
 
		 	
	    		


	       }
	      });
	   }
function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

      var reurl=url.split("saveSalesEnquiry");
      
     // $("#docno").prop("disabled", false);                
      

var win= window.open(reurl[0]+"saveSalesEnquiryAction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
   
win.focus();
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
	}
function funchkforedit()
{



	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				
				 $("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true ); 
				 
				 
				 
				}
			else
				{
				 
				}
		  
			
			
			
		} else {
		}
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();


} 	

function validateemail()
{
	var txtemail= document.getElementById("txtemail").value;

	if(txtemail!="")
		{

		if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(txtemail))  
		{  
			 document.getElementById("errormsg").innerText="";
		  return (true)  ;
		}  
		
		 document.getElementById("errormsg").innerText=" You have entered an invalid email address!";
		 
		 // alert("")  
		  return (false)  ;
		}

	
	}



</script>

<style>
.hidden-scrollbar {
	/* // overflow: auto; */
	height: 530px;
	overflow-x: hidden;
}
</style>
</head>
<body onLoad="getCurrencyIds();setValues();">

<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="salesEnquiry" action="saveSalesEnquiry" method="post"
			autocomplete="off">
			<jsp:include page="../../../../header.jsp"/><br/>
			<jsp:include page="multiqty.jsp"></jsp:include><br/>
			<div class='hidden-scrollbar'>
			<fieldset>
					<table width="100%">

						<tr>
							<td width="4.8%" align="right">Date</td>
							<td width="8%" align="left"><div id="date"
									name="date"
									value='<s:property value="date"/>'></div> <input
								type="hidden" name="hiddate"
								id="hiddate"
								value='<s:property value="hiddate"/>'></td>
							<td align="right" width="33.8%">Ref No</td>
							<td align="left"><input type="text" name="refno" id="refno"
								value='<s:property value="refno"/>'></td>
							<td width="5%" align="right">Doc No</td>
							<td width="13%" align="left"><input type="text" name="docno"
								id="docno" tabindex="-1" value='<s:property value="docno"/>'
								readonly="readonly"></td>

						</tr>
					</table>
					<table width="100%"  >
					<tr>
    <td align="right">&nbsp;</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  >General</td>
    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
  </tr> 
						<tr>
							<td width="71" align="right">Client</td>
							<td colspan="5" align="left"> 
							<input type="text" name="txtclient" id="txtclient"
								placeholder="Press F3 To Search"
								value='<s:property value="txtclient"/>' style="width: 20%;"
								onKeyDown="getclinfo(event);"> <input
								type="text" id="txtclientdet" name="txtclientdet"
								value='<s:property value="txtclientdet"/>' style="width: 63.5%;"></td>
							<td align="right" width="32">Curr</td>
							<td width="93" align="left"><select name="cmbcurr"
								id="cmbcurr" style="width: 92%;"
								value='<s:property value="cmbcurr"/>'
								onload="getRatevalue(this.value);">
									<option value="-1">--Select--</option>
							</select></td>

							<td width="399" align="left">Rate <input type="text"
								name="currate" id="currate" style="width: 20.6%;"
								value='<s:property value="currate"/>'></td>
							<td width="91" align="left"></td>

						</tr>
						
						<tr>

							<td width="71" align="right">MOB</td>
							<td colspan="5" align="left"> 
							<input type="text" name="txtmob" id="txtmob"
								value='<s:property value="txtmob"/>' style="width: 20%;">
								
								
								 &nbsp; Sales Person   
   <input type="text" id="txtsalesperson" name="txtsalesperson" style="width:30.5%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
								
								 

							<td align="right" width="71">E-mail</td>
							<td colspan="2" align="left" width="1080"><input type="text"
								name="txtemail" id="txtemail" onblur="validateemail()"
								value='<s:property value="txtemail"/>' style="width: 40.8%;"></td>


						</tr>
						
						
						
					</table>
					<table width="100%">
						<tr>

<%-- 							<td align="right" width="4.3%">Del Date</td>
							<td align="left" width="3%"><div id="deliverydate"
									name="deliverydate" value='<s:property value="deliverydate"/>'></div>

								<input type="hidden" name="hiddeliverydate" id="hiddeliverydate"
								value='<s:property value="hiddeliverydate"/>'></td>
 --%>

							<td align="right" width="71">Del Terms</td>
							<td colspan="3" align="left" width="987"><input type="text"
								name="delterms" id="delterms"
								value='<s:property value="delterms"/>' style="width: 68.6%;"></td>


						</tr>
					</table>

					<table width="100%">
						<tr>
							<td align="right" width="72"> Pay Terms</td>
							<td colspan="6" width="986" align="left"><input type="text"
								name="payterms" id="payterms"
								value='<s:property value="payterms"/>' style="width: 68.6%;"></td>
						</tr>
						<tr>
							<td align="right" width="72">Description</td>
							<td colspan="6" width="986" align="left"><input type="text"
								name="txtdesc" id="txtdesc"
								value='<s:property value="txtdesc"/>' style="width: 68.6%;">
								
								 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
								</td>
						</tr>
					</table>
				</fieldset>
<br>
				<div id="prodet"><jsp:include page="prodetGrid.jsp"></jsp:include></div>
				
				
	 

<fieldset>
 <legend>Shipping Details</legend>
<table width="100%"  >

<tr>

<td width="50%">
 <fieldset>
<table  width="100%"   >   

<tr><td align="right" width="15%">Name</td><td colspan="3"><input type="text" id="shipto" name="shipto" style="width:91%;" placeholder="Press F3 To Search"  value='<s:property value="shipto"/>' onkeydown="getshipdetails(event)" ></td></tr>
<tr><td align="right">Shipping Address</td><td colspan="3"><input type="text" id="shipaddress" name="shipaddress"  style="width:91%;"  value='<s:property value="shipaddress"/>' ></td></tr>
<tr><td align="right">Contact Person</td><td colspan="3"><input type="text" id="contactperson" name="contactperson"  style="width:91%;"    value='<s:property value="contactperson"/>' ></td></tr>
<tr><td align="right">Telephone</td><td><input type="text" id="shiptelephone" name="shiptelephone"   style="width:90%;"   value='<s:property value="shiptelephone"/>' ></td>
<td align="right">MOB</td><td><input type="text" id="shipmob" name="shipmob"  style="width:80%;"  value='<s:property value="shipmob"/>' ></td></tr>
<tr><td align="right">Email</td><td><input type="text" id="shipemail" name="shipemail"   style="width:90%;"   value='<s:property value="shipemail"/>' ></td>
<td align="right">FAX</td><td><input type="text" id="shipfax"  style="width:80%;"  name="shipfax" value='<s:property value="shipfax"/>' ></td>
</tr>
</table>
 </fieldset>
 </td>

 
<td width="50%"> 
 <fieldset>
<div id="shipdetdiv"><jsp:include page="shipdetailsGrid.jsp"></jsp:include></div> 
</fieldset>
</td>

</tr>
</table>
 
 
 
</fieldset>
				
 					<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>' />
 					<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
					<input type="hidden" id="proGridlen" name="proGridlen" value='<s:property value="proGridlen"/>' /> 
					<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /> 
					<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
					<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
					<input type="hidden" id="datas" name="datas" value='<s:property value="datas"/>' />
					
					  <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
					  
                  <input type="hidden" id="shipdocno" name="shipdocno"  value='<s:property value="shipdocno"/>'/>
                <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght"  value='<s:property value="shipdatagridlenght"/>'/>
 
		</form>
	</div>
	<div id="accountSearchwindow">
		<div></div>
	</div>
	<div id="searchwndow">
		<div></div>
	</div>
	
	<div id="tremwndow">
		<div></div>
	</div>
	
	<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
	

</body>
</html>