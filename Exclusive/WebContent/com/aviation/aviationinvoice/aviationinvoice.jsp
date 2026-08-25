<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

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
    
	   /* Date */ 	
	   
	   		 
	   
	   	    $("#fromdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	   	 $("#duedate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		   
	   
	   	 
	   
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $("#todate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	   $('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#productSearchwindow').jqxWindow('close');
	   $('#unitsearchwindow').jqxWindow({width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%', title: 'Unit Search',position: { x: 500, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	   $('#unitsearchwindow').jqxWindow('close');
	   
	     $('#currencysearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' ,title: 'Currency Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#currencysearchwndow').jqxWindow('close'); 
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	     $('#refnosearchwindow').jqxWindow('close'); 
	
	     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	     $('#searchwindow').jqxWindow('close');	   
		   
		   
    $('#puraccid').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		
    		
    		var psrno= document.getElementById("psrno").value;

    		if(psrno=="")
    			{
    			 document.getElementById("errormsg").innerText="Product is required";
    			 
    			 document.getElementById("part_no").focus();
    			 return 0;
    			   }
    		else
    			   {
    			   document.getElementById("errormsg").innerText="";
    			   }
    		
    		
    		$('#accountSearchwindow').jqxWindow('open');
    		accountSearchContent('accountsDetailsSearch.jsp?type='+$('#cmbtype').val());
    	}
    });
    $('#part_no').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		$('#productSearchwindow').jqxWindow('open');
    		productSearchContent('productSearchs.jsp?');
    	}
    });
    $('#txtcurrency').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		$('#currencysearchwndow').jqxWindow('open');
    		currencySearchContent('currencySearch.jsp?');
    	}
    });
});

function getrefDetails(event){
	if(document.getElementById("puraccid").value=="")
	{
	 
	 document.getElementById("puraccid").focus();
	 return 0;
	}
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	  refsearchContent('refnosearch.jsp?'); }
	 else{
		 }
}  
function refsearchContent(url) {
  $.get(url).done(function (data) {
       $('#refnosearchwindow').jqxWindow('setContent', data);
  }); 
}

function getaccountdetails(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
		if(x==114){
			var type=$('cmbtype')
			$('#accountSearchwindow').jqxWindow('open');
			accountSearchContent('accountsDetailsSearch.jsp?type='+$('#cmbtype').val());    }
		else{
		}
 	}
}  

function accountSearchContent(url) {
	$.get(url).done(function (data) {
		$('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
}

function getProduct(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
 		
 		var psrno= document.getElementById("psrno").value;

 		if(psrno=="")
 			{
 			 document.getElementById("errormsg").innerText="Product is required";
 			 
 			 document.getElementById("part_no").focus();
 			 return 0;
 			   }
 		else
 			   {
 			   document.getElementById("errormsg").innerText="";
 			   }
 		
 		
		if(x==114){
			$('#productSearchwindow').jqxWindow('open');
			productSearchContent('productSearchs.jsp?');    }
		else{
		}
 	}
}  
function productSearchContent(url) {
	$.get(url).done(function (data) {
		$('#productSearchwindow').jqxWindow('setContent', data);
	}); 
}

function getCurrency(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
		if(x==114){
			$('#currencysearchwndow').jqxWindow('open');
			productSearchContent('currencySearch.jsp?');    }
		else{
		}
 	}
}  

function currencySearchContent(url) {
	$.get(url).done(function (data) {
		$('#currencysearchwndow').jqxWindow('setContent', data);
	}); 
}

 
function funReset(){
	//$('#frmaninv')[0].reset(); 
}
function funReadOnly(){
	$('#frmaninv input').attr('readonly', true );
	$('#frmaninv select').attr('disabled', true );
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#todate').jqxDateTimeInput({ disabled: true});
	$('#fromdate').jqxDateTimeInput({ disabled: true});
	$('#duedate').jqxDateTimeInput({ disabled: true});
	
	
	
	$("#jqxdetgrid").jqxGrid({ disabled: true});
	$('#cmbcurr').attr('disabled', true);		 
	$('#acctype').attr('disabled', true);
}
function funRemoveReadOnly(){
	$('#frmaninv input').attr('readonly', false );
	$('#frmaninv select').attr('disabled', false );
	$('#currate').attr('readonly', true);
	$('#puraccid').attr('readonly', true);
	$('#puraccname').attr('readonly', true);
	$('#btnvaluechange').hide();
	$('#txtlocation').attr('readonly', true);
	$('#fromdate').jqxDateTimeInput({ disabled: false});
	$('#duedate').jqxDateTimeInput({ disabled: false});
	$('#part_no').attr('readonly', true);
	$('#pname').attr('readonly', true);
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#todate').jqxDateTimeInput({ disabled: false});
	$('#cmbcurr').attr('disabled', false);
	$('#acctype').attr('disabled', false);
	$('#usdrate').attr('disabled', false);
	
	
	
	$('#docno').attr('readonly', true);
	$("#jqxdetgrid").jqxGrid({ disabled: false});
	$('#docno').attr('readonly', true);
	if ($("#mode").val() == "A") {
		$('#masterdate').val(new Date());
		$('#todate').val(new Date());
		$('#duedate').val(new Date());
		$('#fromdate').val(new Date());
		$("#jqxdetgrid").jqxGrid('clear');
		$("#jqxdetgrid").jqxGrid('addrow', null, {});
	}
}

function funcheckaccinvendor()
{
	if(document.getElementById("puraccid").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search Vendor";  
		 document.getElementById("puraccid").focus();
	       
	        return 0;
		}
	
}


function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 

	   
var psrno= document.getElementById("psrno").value;

if(psrno=="")
	{
	 document.getElementById("errormsg").innerText=" Product is required";
	 
	 document.getElementById("part_no").focus();
	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
	   
var purid= document.getElementById("puraccid").value;

if(purid=="")
	{
	 document.getElementById("errormsg").innerText="Client is required";
	 
	 document.getElementById("puraccid").focus();
	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
var aa=0;
var bb=0;
var rows = $("#jqxdetgrid").jqxGrid('getrows');
 
for(var i=0 ; i < rows.length-1 ; i++){
	
	 if(rows[i].sprice==""||rows[i].sprice=="0.00"||typeof(rows[i].sprice)=="undefined"||typeof(rows[i].sprice)=="NaN")
				    		
							{
		 aa=1;
		 break;
					    	 
							}
	
	 
	 
	 if(rows[i].pprice==""||rows[i].pprice=="0.00"||typeof(rows[i].pprice)=="undefined"||typeof(rows[i].pprice)=="NaN")
 		
		{
bb=1;
break;
 	 
		}
	
}
	   
	   
	   
	   
	   
	   if(aa==1)
		   {
		   document.getElementById("errormsg").innerText=" Selling price is required";
			 
			 
			 return 0;
		   }
	   
	   if(bb==1)
	   {
	   document.getElementById("errormsg").innerText=" Purchase price is required";
		 
		 
		 return 0;
	   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
   
	      

var rows = $("#jqxdetgrid").jqxGrid('getrows');
$('#descgridlenght').val(rows.length);
for(var i=0 ; i < rows.length ; i++){
	newTextBox = $(document.createElement("input"))      
	.attr("type", "dil")
	.attr("id", "reqtest"+i)
	.attr("name", "reqtest"+i)
	.attr("hidden", "true");       
 
	newTextBox.val($('#jqxdetgrid').jqxGrid('getcellText', i, "dateoff")+"::"+rows[i].fdocno+" :: "+rows[i].dono+" :: "+rows[i].operator+" :: "  
			+rows[i].portid+" :: "+rows[i].flno+" :: "+rows[i].qpl+" :: "+rows[i].qpg+" ::"+rows[i].tax+" ::"+rows[i].itax+" ::"+rows[i].sprice+" :: "+rows[i].pprice+" :: "
			+rows[i].amountusd+" :: "+rows[i].amountaed+" :: "+rows[i].ddocno+" :: "+rows[i].vndid+" :: "+rows[i].amountusdp+" :: "+rows[i].amountaedp+" :: "+rows[i].unitid+" :: "+i); 

	newTextBox.appendTo('form');
}   

$("#jqxdetgrid").jqxGrid({ disabled: false});
return 1;
} 



 

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
 
 
	   

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			if($('#hidtodate').val()){
				$("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
			}
			if($('#hidfromdate').val()){
				$("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
			}
			if($('#hidduedate').val()){
				$("#duedate").jqxDateTimeInput('val', $('#hidduedate').val());
			}
			
			
			var docVal1 = document.getElementById("masterdoc_no").value;
	   		if(docVal1>0)
	   		{
			
			 $("#detdiv").load("detailsGrid.jsp?masterdocno="+docVal1); 
			
	   		}
			
			if($('#msg').val()!=""){
				$.messager.alert('Message',$('#msg').val());
			} 
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		}
	   
	   function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				var reurl="";
				var url=document.URL;
				if( url.indexOf('saveavinv') >= 0){
					reurl=url.split("saveavinv");
				}else {
					reurl=url.split("aviationinvoice.jsp");
				}
				
			     $("#docno").prop("disabled", false);
				 var win= window.open(reurl[0]+"printAviationInvoice?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();
			  }
			else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
		      }
	 
	 
  
</script>
</head>
<body onLoad="setValues();" >


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmaninv" action="saveavinv" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp" />   
<br/><fieldset> 
<table width="100%" > 
  <tr>
    <td width="6%" align="right">Date</td> 
    <td width="12%"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
      <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'></td>
 
 
   <td align="right">Period From</td>
    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>  
    <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'></td>
      <td align="right">To</td>
    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div>
    <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'></td>
 
     <td align="right">Product</td>   
    <td ><input type="text" name="part_no" id="part_no" value='<s:property value="part_no"/>' placeholder="Press F3 To Search"   style="width:35%;" onKeyDown="getProduct(event);" >  
      <input type="text" id="pname" name="pname" value='<s:property value="pname"/>'  style="width:60%;"></td>
 
 
 <select hidden="true" id="cmbtype"  name="cmbtype" style="width:62%;" > 
    <option value="crm">Sales </option>   
     <option value="vnd">Purchase</option>
    </select>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype"  value='<s:property value="hidcmbtype"/>'>
 
 
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>
  <tr>
    <td align="right">Name</td>    
    <td colspan="5"><input type="text" name="puraccid" id="puraccid" value='<s:property value="puraccid"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:72%;"></td>
  <td  align="right"> Acc No </td><td> <input type="text" name="account" id="account"  value='<s:property value="account"/>'> <input type="hidden" name="txtcurrency" id="txtcurrency"  value='<s:property value="txtcurrency"/>' onKeyDown="getCurrency(event);">
  <input type="hidden" name="currate" id="currate"  value='<s:property value="currate"/>'>
  <input type="hidden" name="currid" id="currid"  value='<s:property value="currid"/>'></td>
  </tr>
<tr>

    
       <td align="right">Note</td>
    <td colspan="3"><input type="text" name="desc1" id="desc1" value='<s:property value="desc1"/>' style="width:99%;"></td>
    
     <td align="right">Due Date</td>
    <td><div id="duedate" name="duedate" value='<s:property value="duedate"/>'></div> 
    
     <input type="hidden" name="hidduedatee" id="hidduedatee" value='<s:property value="hidduedatee"/>'>
    
       </td>
    
           <td align="right">USD Rate</td>
    <td  ><input type="text" name="usdrate" id="usdrate" value='<s:property value="usdrate"/>' style="width:25%;"></td>
    </tr>
 
  
 </table>
 
 </fieldset>
 <br>
 <fieldset>
 
    <div id="detdiv" > <jsp:include page="detailsGrid.jsp"></jsp:include> </div> 
     

</fieldset>

<input type="hidden" id="psrno" name="psrno"  value='<s:property value="psrno"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
<input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
<input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</form>
<div id="searchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
<div id="accountSearchwindow">
	<div ></div>
	</div>
<div id="productSearchwindow">
	   <div ></div>
	</div>
<div id="currencysearchwndow">
	   <div ></div>
	</div>
<div id="unitsearchwindow">
   <div ></div>
</div>
	
</div>
</body>
</html>