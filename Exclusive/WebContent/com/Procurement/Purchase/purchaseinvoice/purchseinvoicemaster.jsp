<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
	color:red;
  	font-weight:bold;
}
.iconss {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
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


.classpass {
    -webkit-text-security: disc;
}
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}

#divname {
    background-color: #e2c791;
    box-shadow: 10px 10px grey;
     position:fixed;z-index:1000;right:30px;top:100px;  
}
.myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
}  
.ff{
	display :none;
}    

</style>

<script type="text/javascript">

 
$(document).ready(function () { 
 /* 
    $("#FixedDiv").click(function(){
    	 $('#sss').show();
        $(".target").hide( "slide", { direction: "down"  }, 10000 );
     }); */
	   /* Date */ 	
	   
	   
	   
	$('#FixedDiv').hide();
    $('#btnvaluechange').hide();
    getunit(0);
    $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $('#bacthWindow1').jqxWindow({ width: '45%', height: '65%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 500, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#bacthWindow1').jqxWindow('close');
    
    $("#invdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#lastpurchasewindow').jqxWindow({ width: '50%', height: '32%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	$('#lastpurchasewindow').jqxWindow('close');
	
	
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');  
	 	

		   $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		     $('#searchwindow').jqxWindow('close');
		    
			$('#expencewindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#expencewindow').jqxWindow('close');
	     
	     
		     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '92%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
		     $('#sidesearchwndow').jqxWindow('close');   
	     
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 
	 
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		     $('#importwindow').jqxWindow('close');   
		     
		     
		     $('#calculationwindow').jqxWindow({ width: '80%', height: '60%',  maxHeight: '80%' ,maxWidth: '80%'  , title: 'Calculation ' ,animationType: 'slide',position: { x: 150, y: 50 }, keyboardCloseKey: 27});
			   $('#calculationwindow').jqxWindow('close');
		     
			   $('#masterdate').on('change', function (event) {
					  
				    var maindate = $('#masterdate').jqxDateTimeInput('getDate');
				  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
				    funDateInPeriod(maindate);
				  	 }
				   });
		     
		     
		     if($('#reftypeval').val()=="GRN")
			  {
		    	 $("#btnDelete").attr('disabled', true );
			  }
		     else
		    	 {
		    	 $("#btnDelete").attr('disabled', false );
		    	 }
			   
		  	  
		   
			   $('#rrefno').dblclick(function(){
				   
					  if($("#mode").val() == "A")
						  {
					   
						  if(document.getElementById("puraccid").value=="")
							{
							
							 document.getElementById("errormsg").innerText="Search Vendor";  
							 document.getElementById("puraccid").focus();
						       
						        return 0;
							}
						  if(document.getElementById('reftype').value=="GRN")	 
							  {
				  	    $('#refnosearchwindow').jqxWindow('open');
				  	
				  	  refsearchContent('refnosearch.jsp?'); 
							  }
				  	  
						 
						 else if(document.getElementById('reftype').value=="PO")
						 {	 
					  $('#refnosearchwindow').jqxWindow('open');
					//	alert("1");
					  refsearchContent('purchaseorderrefsearch.jsp?');
						 }
				  	  
						  }
					  
			          
					  }); 
			   $('#batch').dblclick(function(){
					 if(document.getElementById("multi").checked)
					 {
					  if($("#mode").val() == "A" || ($("#mode").val() == "E") )
					  {
						  $('#bacthWindow1').jqxWindow('open');
						  btsearchContent('batchsearchform.jsp?'); 
					  }
					 }
			   }); 
			   
		   $('#txtlocation').dblclick(function(){
			   
				  if($("#mode").val() == "A" || $("#mode").val() == "E")
					  {
				   
			  	    $('#locationwindow').jqxWindow('open');
			  	
			  	  locationsearchContent('searchlocation.jsp?'); 
					  }
				  
		  	  
	          
                  }); 
		   
    $('#puraccid').dblclick(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()!= "view")
    		{
    	
    		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsSearch.jsp?');
    		}
  });   
    
    $("#FixedDiv").click(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()== "view")
    		{
    	
    		
	  	    $('#calculationwindow').jqxWindow('open');
	  	
	  	  calculationsearchContent('calcutionmaster.jsp?');
    		}
  });   
    
    
    $('#itemdocno').dblclick(function(){

		  if($("#mode").val() == "A" || $("#mode").val() == "E")
			  {
	 
		 
	    $('#searchwindow').jqxWindow('open');
	
		if(document.getElementById("itemtype").value=="1") 
			{
		 
			refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
		else
			{
			 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		
		 
			  }
	  }); 
    
  
});


function getitem(event){
 	 var x= event.keyCode;
 	 if(x==114){

 		  $('#searchwindow').jqxWindow('open');
 			
 		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
		refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
 		
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
 		
	else
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
	

 		 
 		  
 	 
 	 }
 	 else{
 		 }
 	 }  
 	  function refsearchContent1(url) {
      //alert(url);
         $.get(url).done(function (data) {
 //alert(data);
       $('#searchwindow').jqxWindow('setContent', data);

 	}); 
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
function expenceSearchContent(url) {
	   $('#expencewindow').jqxWindow('open');
      $.get(url).done(function (data) {
    $('#expencewindow').jqxWindow('setContent', data);
    $('#expencewindow').jqxWindow('bringToFront');

}); 
	} 

function getloc(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#locationwindow').jqxWindow('open');
	
	  locationsearchContent('searchlocation.jsp?');   }
	 else{
		 }
	 }  
function priceSearchContent(url) {
	  $('#lastpurchasewindow').jqxWindow('open');
   $.get(url).done(function (data) {
//alert(data);
 $('#lastpurchasewindow').jqxWindow('setContent', data);

	}); 
	}  

function getrefno(event)
{
	 var x= event.keyCode;
	 if(x==114){
		 
		 if(document.getElementById('reftype').value=="GRN")
		 {	 
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp?');
	  
		 }
		 
		 else if(document.getElementById('reftype').value=="PO")
		 {	 
	  $('#refnosearchwindow').jqxWindow('open');
		
	  refsearchContent('purchaseorderrefsearch.jsp?');
		 }
	 
	  
	 
	 }
	 else{
		 }
	 }  
	
	 



/* function getrefDetails(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp?');  }
	 else{
		 }
	 }   */
	  function refsearchContent(url) {
      //alert(url);
         $.get(url).done(function (data) {
//alert(data);
       $('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
   	}

	  function importsearchcontent(url) {
	      //alert(url);
	      
	       $('#importwindow').jqxWindow('open');
	      
	         $.get(url).done(function (data) {
	//alert(data);
	       $('#importwindow').jqxWindow('setContent', data);

		}); 
	   	}

	  function locationsearchContent(url) {
		     //alert(url);
		        $.get(url).done(function (data) {
		//alert(data);
		      $('#locationwindow').jqxWindow('setContent', data);

			}); 
		  	}

	  function calculationsearchContent(url) {
		     //alert(url);
		        $.get(url).done(function (data) {
		//alert(data);
		      $('#calculationwindow').jqxWindow('setContent', data);

			}); 
		  	}


function getaccountdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 accountSearchContent('accountsDetailsSearch.jsp?');    }
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
	  
	  
	  function reqproductSearchContent(url) {
	     	 //alert(url);
	     		 $.get(url).done(function (data) {
	     			 
	     			 $('#sidesearchwndow').jqxWindow('open');
	     		$('#sidesearchwndow').jqxWindow('setContent', data);
	     
	     	}); 
	     	} 

	  
	  
      function productSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#sidesearchwndow').jqxWindow('open');
     		$('#sidesearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 

function funReset(){
	//$('#purchaseInv')[0].reset(); 
}
function funReadOnly(){
	$('#purchaseInv input').attr('readonly', true );
	$('#purchaseInv select').attr('disabled', true );
	 $('#masterdate').jqxDateTimeInput({ disabled: true});
	 
	 $('#invdate').jqxDateTimeInput({ disabled: true});
	 
	 
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
		$("#descdetailsGrid").jqxGrid({ disabled: true});
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		 $('#rrefno').attr('disabled', true);
		  $('#descPercentage').attr('disabled', true);
		 $('#descountVal').attr('disabled', true);
		 $('#chkdiscount').attr('disabled', true);	 

		 $('#producttype').val(0);	 
		 $('#process1').attr('disabled', true);
		 
			$("#purchexpgrid").jqxGrid({ disabled: true});
			 
			 $('#btnCalculate').attr('disabled', true);
		 
		 
	  $('#cmbcurr').attr('disabled', true);		
	  $('#btnvaluechange').hide();
	 $('#acctype').attr('disabled', true);
	 
	 
	 if(document.getElementById('reftype').value=="DIR")
	 {
		 chkfoc(); 
		 
	 }
	 else
		 {
		 $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
		 }
	 
	 
	
}
function funRemoveReadOnly(){
	chkproductconfig();
	 chklastpurchase();
	 getunit(0);
	 document.getElementById("editdata").value="";
	 $('#FixedDiv').hide();
	$('#purchaseInv input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
  chkmultiqty();
	
	
	getround();
	$('#purchaseInv select').attr('disabled', false );
	
	gettaxaccount(1);	
	
	
	
	 
	$('#totamt').attr('readonly', true );
	$('#taxpers').attr('readonly', true );
	$('#taxamounts').attr('readonly', true );
	$('#taxamountstotal').attr('readonly', true );
	
	$('#amounts').attr('readonly', true );
$('#st').attr('readonly', true );
$('#taxontax1').attr('readonly', true );
$('#taxontax2').attr('readonly', true );
$('#taxontax3').attr('readonly', true );
$('#taxtotal').attr('readonly', true );
 $('#process1').attr('disabled', false);

	
	
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  $('#rrefno').attr('disabled', true);
	  $('#rrefno').attr('readonly', true);
		 $('#btnvaluechange').hide();
		 $('#txtlocation').attr('readonly', true);
		 
		 $('#producttype').val(0);	 
		 
		  
		 $('#invdate').jqxDateTimeInput({ disabled: false});
	 $('#masterdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});
	 $("#serviecGrid").jqxGrid({ disabled: false});
		$("#purchexpgrid").jqxGrid({ disabled: false});
	 
	  $('#descPercentage').attr('disabled', true);
	 $('#descountVal').attr('disabled', true);
	 $('#docno').attr('readonly', true);
	 
	 $('#orderValue').attr('readonly', true);
	 
	 
	 $('#productTotal').attr('readonly', true);
	 $('#netTotaldown').attr('readonly', true);
	 
	 
	 
	if ($("#mode").val() == "A") {
		  $('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
		$('#deliverydate').val(new Date());
		
		$('#invdate').val(new Date());
		// $('#invdate').jqxDateTimeInput({ disabled: false});
		
		 $("#descdetailsGrid").jqxGrid('clear');
		    $("#descdetailsGrid").jqxGrid('addrow', null, {});
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
			    
			    
			    $("#purchexpgrid").jqxGrid('clear');
			    $("#purchexpgrid").jqxGrid('addrow', null, {});
			    
			    if(document.getElementById('reftype').value=="DIR")
			    {
			   	 chkfoc(); 
			   	 
			    }
			    else
			   	 {
			   	 $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
			   	 }
			    
				 
		    
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
  		$("#descdetailsGrid").jqxGrid({ disabled: true});
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		
		  $('#btnCalculate').attr('disabled', true);
	    
		$("#purchexpgrid").jqxGrid({ disabled: true});
		 
	    
		
		
	}  
  
	
	
  	$('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');  
	
	getCurrencyIds();
 chkcostcode();
	 
	 $('#itemdocno').attr('readonly', true);
	 $('#itemname').attr('readonly', true);
}




function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
function getround(){ 
	 
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('::');
	      
	        
	      document.getElementById("roundmethod").value=items[0];
	      document.getElementById("roundvals").value=items[1];
	          
	    }
	       }
	   x.open("GET","getroundval.jsp?",true);
		x.send();
	        
	      
	        }
function funNotify(){	
	
	
	//   alert(infunnotify);
	   var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(maindate);
	   if(validdate==0){
	   return 0; 
	   }
	var purid= document.getElementById("puraccid").value;
	if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 
	 document.getElementById("puraccid").focus();
	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
	   
	   
	   
if(document.getElementById("txtlocation").value=="")
{

 document.getElementById("errormsg").innerText="Search Location";  
 document.getElementById("txtlocation").focus();
   
    return 0;
}
	 
else
	{
	  document.getElementById("errormsg").innerText="";
	}
	   
	   
	   
if(document.getElementById("invno").value=="")
{

 document.getElementById("errormsg").innerText="Enter Invno";  
 document.getElementById("invno").focus();
   
    return 0;
}
	 
else
	{
	  document.getElementById("errormsg").innerText="";
	}
	   
if(document.getElementById('reftype').value=="DIR")
{
	
}
else
	{
	
	if(document.getElementById("rrefno").value=="")
	{

	 document.getElementById("errormsg").innerText="Search Goods Receipt Note";  
	 document.getElementById("rrefno").focus();
	   
	    return 0;
	}
	
	}
	
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
var refval= document.getElementById("nettotal").value;

if(refval=="")
	{
	
	document.getElementById("nettotal").value=0;
	
	/*  document.getElementById("errormsg").innerText="Net Amount Empty";
	 

	 return 0; */
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }

/* psrno unitdocno prodoc qty unitprice discount nettotal */
var rows = $("#serviecGrid").jqxGrid('getrows');
   $('#serviecGridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0 ; i < rows.length ; i++){
	  
	 
	  
			  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input")) 
				      .attr("type", "dil")
				      .attr("id", "sertest"+i)
				      .attr("name", "sertest"+i) 
				      .attr("hidden", "true");           
				  
				  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
						   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc
						   +" :: "+rows[i].orderdiscper+" :: "+rows[i].orderamount+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].batch_no+"::"
						   +$('#serviecGrid').jqxGrid('getcelltext', i, "exp_date")+"::"+rows[i].taxdocno+"::"+"0000"+"::"); 
				//  orderdiscper,orderamount
				// alert(newTextBox.val());
				  newTextBox.appendTo('form');
				  
		   
				 
   //alert("ddddd"+$("#test"+i).val());
   
  }   
	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	    $('#descgridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   /*  var net = rows[i].nettotal1; 
	    var nettax = rows[i].srvtaxamount; 
	    var change=net-nettax; */
	   // alert(change);
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty1+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice1+" :: "+rows[i].total1+" :: "+rows[i].discount1+" :: "+rows[i].nettotal1+" :: "+rows[i].srvtaxper+" :: "+rows[i].srvtaxamount+" :: ");
	
	// alert(newTextBox.val());
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }   
	   
	   var rows = $("#purchexpgrid").jqxGrid('getrows');
	    $('#expgridlength').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "exptest"+i)
	       .attr("name", "exptest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty2+" :: "+rows[i].descsrno+" :: "
			   +rows[i].unitprice2+" :: "+rows[i].total2+" :: "+rows[i].discount2+" :: "+rows[i].nettotal2+" :: "+rows[i].accountdono+" :: ");
	
 
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }   
	   
	   
/* 	   var exprows = $("#purchexpgrid").jqxGrid('getrows');
		  
		  
		  $('#expgridlength').val(exprows.length);
	   
	   
	   
		  for(var i=0 ; i < exprows.length ; i++){ 
			   newTextBox = $(document.createElement("input"))
			      .attr("type", "dil")
			      .attr("id", "exp"+i)
			      .attr("name", "exp"+i)
			      .attr("hidden", "true");
			   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::");
			   newTextBox.val(exprows[i].srno+" :: "+exprows[i].qty+" :: "+exprows[i].descsrno+" :: "
			   +exprows[i].unitprice+" :: "+exprows[i].total+" :: "+exprows[i].discount+" :: "+exprows[i].nettotal+" :: "+exprows[i].accountdono+" :: ");
			  newTextBox.appendTo('form');
			  }
	    */
	   
		if ($("#mode").val() == "E") {
			
			 if($('#reftypeval').val()=="GRN")
			  {
			
			  $('#rrefno').attr('disabled', false);
			  
		      $('#rrefno').attr('readonly', true);

			  }
			 
			 
			 
			 
			 
			 $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		 
					  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  }
		 	 
				  $('#rrefno').attr('disabled', false);
				  $('#rrefno').attr('readonly', true);
	    	   
	    		$("#descdetailsGrid").jqxGrid({ disabled: false});
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
	    		$("#purchexpgrid").jqxGrid({ disabled: false});	 
			 

			 
			} 
		  
	   
	
	return 1;
} 



function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    	   $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		  document.getElementById("chkdiscount").checked = true;
		 		  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  }
		 	 
			   
			   document.getElementById("editdata").value="Editvalue";
			   
			   if(document.getElementById('reftype').value=="DIR")
				 {
				   $('#rrefno').attr('disabled', true);
					  $('#rrefno').attr('readonly', true);
				   
				 }
			   else
				   {
				   $('#rrefno').attr('disabled', false);
					  $('#rrefno').attr('readonly', true);
				   
				   }
			   
			   
		 
				  
				  
				  
				  
				  
					$("#purchexpgrid").jqxGrid({ disabled: false});
					 
	    		$("#descdetailsGrid").jqxGrid({ disabled: false});
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		
	    		
	    		
	    	    $("#purchexpgrid").jqxGrid('addrow', null, {});
	    	    $("#descdetailsGrid").jqxGrid('addrow', null, {});
	    	    $("#serviecGrid").jqxGrid('addrow', null, {});

	       }
	      });
	   }

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
function getCurrencyIds(){
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
	   x.open("GET","getCurrencyId.jsp",true);
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
	   
	   
	   function combochange()
	   {
		   if($('#cmbcurrval').val()!="")
			  {
			  
			  
			  $('#cmbcurr').val($('#cmbcurrval').val());   
			  
			  }
		   
		   if($('#hidcmbbilltype').val()!="")
			  {
			  
			  
			  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
			  
			  }
		    
		   
			  if($('#reftypeval').val()!="")
			  {
			  
			  
			  $('#reftype').val($('#reftypeval').val());
			  }
			 
			 if($('#reftypeval').val()=="GRN")
			  {
			
			  $('#rrefno').attr('disabled', false);
			  
		  $('#rrefno').attr('readonly', true);
		
			  }
		   
		   
		   
		   if(document.getElementById("chkdiscountval").value==1)
 		  {
 		  document.getElementById("chkdiscount").checked = true;
 		  
 		  
 		  document.getElementById("chkdiscount").value = 1;
 	 
 		  }
 	  else
 		  {
 		  document.getElementById("chkdiscount").checked = false;
 		  document.getElementById("chkdiscount").value = 0;
 		  
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
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("reftype").value+"&refmasterdocno="+document.getElementById("reqmasterdocno").value, true);
			x.send();
		
		
		}
/* 	   function funchkforedit()
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
						 $("#btnEdit").attr('disabled', false);
						 $("#btnDelete").attr('disabled', false);
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	  */
	   function setValues() {
		  
		//  alert(insetvalues);
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
			if($('#hidinvdate').val()){
				$("#invdate").jqxDateTimeInput('val', $('#hidinvdate').val());
			}
			
			 
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
			combochange();
			funchkforedit();	
				
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  		 $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1); 
	     	  		 $("#expDiv").load("purchaseexpGrid.jsp?masterdoc="+indexval1);
	     	  		  
	     	  		 var reftypeval = document.getElementById("reftypeval").value;  
	     	  		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
	     	  		 
	     	  		 
	     	  		 $('#FixedDiv').show(); 
	     	  		
	     	  		 
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
				
    		 gettaxaccount(1);
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionpurInv");
	        
	        $("#docno").prop("disabled", false);                
	        var dtype=$('#formdetailcode').val();
	        var brhid='<%=session.getAttribute("BRANCHID").toString()%>';
	        
			var win= window.open(reurl[0]+"printpurchase?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#purchaseInv').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }
function fundisable()
{
	
	   if (document.getElementById('chkdiscount').checked) {
	$.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
		if (r==false){
			document.getElementById('chkdiscount').checked=false;
			return 0;
		}
		else
			{
	
	
			
			   if (document.getElementById('chkdiscount').checked) {
			 
			  $('#descPercentage').attr('disabled', false);
			 $('#descountVal').attr('disabled', false);
			 $('#btnCalculate').attr('disabled', false);
	   }
	  
	   
			}
		
		
	      
      });
	   }
	   else
	   {
	   document.getElementById('descPercentage').value="";
	   document.getElementById('descountVal').value="";
	   var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
	   $('#descPercentage').attr('disabled', true);
		 $('#descountVal').attr('disabled', true);
		 $('#btnCalculate').attr('disabled', true);
			$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
			$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	   }
   
	}
	
	
	
	
	
function funcalcu()
{
	
   // alert(funcalcu);
	document.getElementById('prddiscount').value="";

	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descPercentage=document.getElementById('descPercentage').value;
	
	//alert("pro"+productTotal);
	
	//alert("descPercentage"+descPercentage);
	//productTotal descPercentage
	
	var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
	var netval=parseFloat(productTotal)-parseFloat(descvalue);
	
	/* var  roundOf=document.getElementById('roundOf').value;
	
	 if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
 	   {
		  
		 netval=parseFloat(netval)+parseFloat(roundOf);
 	   }
 
 
	funRoundAmt(descvalue,"descountVal");
	funRoundAmt(netval,"netTotaldown");
	
	
 
 	  var ordertotal="0";
      var nettotalval="0";
      var exptotalval="0";
          
          if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
       	   {
       	   
            nettotalval=parseFloat(document.getElementById("nettotal").value);
       	   }
          
                  
       if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
	   {
    
        
     exptotalval=parseFloat(document.getElementById("expencenettotal").value);
	   }
   
          
        
         ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
       	   
    
	funRoundAmt(ordertotal,"orderValue"); */
	
	 var rows = $('#serviecGrid').jqxGrid('getrows');
      var rowlength= rows.length-1;
  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
  	
 
   
		    for(var i=0;i<rowlength;i++)
					  {
	 
		    	var totamt=rows[i].total;
		     
		    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
		    	
		    	
		    	var	discper=(100/parseFloat(totamt))*parseFloat(discounts);
		     
		    	//var discountsper=parseFloat(totamt)/parseFloat(discounts);
		    	
		    	var nettot=parseFloat(totamt)-parseFloat(discounts);
		    	
	  
		    	$('#serviecGrid').jqxGrid('setcellvalue',i, "discount" ,discounts);
		    	
		    	$('#serviecGrid').jqxGrid('setcellvalue',i, "discper" ,discper);
		    	
		    	$('#serviecGrid').jqxGrid('setcellvalue',i, "nettotal" ,nettot);
				 
			  
					  }
	 
	 
	
			var  productTotal=document.getElementById('productTotal').value;
			var  descPercentage=document.getElementById('descPercentage').value;
		    var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
			var netval=parseFloat(productTotal)-parseFloat(descvalue);
			
			var  roundOf=document.getElementById('roundOf').value;
			
			 if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
		 	   {
				  
				 netval=parseFloat(netval)+parseFloat(roundOf);
		 	   }
		 
		 
			funRoundAmt(descvalue,"descountVal");
			funRoundAmt(netval,"netTotaldown");
			var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
			   
			document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
			 
			
			
		 
		 	  var ordertotal="0";
		      var nettotalval="0";
		      var exptotalval="0";
		      
		      var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
	            			  
	            document.getElementById("descgridhid").value=summaryData.sum.replace(/,/g,'');
		          
		          if(document.getElementById("descgridhid").value!="" && !(document.getElementById("descgridhid").value==null) && !(document.getElementById("descgridhid").value=="undefiend")) 
		       	   {
		       	   
		            nettotalval=parseFloat(document.getElementById("descgridhid").value);
		           //alert(nettotalval);
		       	   }
		          
		                  
		       if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
			   {
		    
		        
		     exptotalval=parseFloat(document.getElementById("expencenettotal").value);
			   }
		   
		          
		        
		         ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
		       	   
		    
			funRoundAmt(ordertotal,"orderValue");
	
	
	
	}
	
	
	
	
function funvalcalcu()
	{
	
	
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descountVal=document.getElementById('descountVal').value;
	var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
	//var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
 
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	
	funcalcu();
	}
	
	
	
 function roundval()
{
	 
	// alert(inroundval);
	 if(parseInt(document.getElementById("roundmethod").value)>0)
	 {
	 
	    var roundOf1=document.getElementById('roundOf').value;
	    var roundval1=document.getElementById('roundvals').value;
	    var id=1;
	    if(parseFloat(roundOf1)<0)
	    	{
	    	roundOf1=roundOf1*-1;
	    	id=-1;
	    	}
	    
	    if(parseFloat(roundOf1)>parseFloat(roundval1))
	    	{
	 		document.getElementById("errormsg").innerText="Maximum Allowed Round of Is "+roundval1*id;
	 		document.getElementById('roundOf').value=0;
	 		document.getElementById('roundOf').focus();
	 		 
	    	 
	    	}
	    else
	    	{
	   	 document.getElementById("errormsg").innerText="";
	    	}
	 
	 
	 }

		
		
       var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
		  
	   var  netTotaldown=summaryData.sum.replace(/,/g,'');
		
	    var roundOf=document.getElementById('roundOf').value;
 
	    if(roundOf!="")
	    {	 
		var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
		funRoundAmt(netval,"netTotaldown"); 
		
		
		  var ordertotal="0";
	      var nettotalval="0";
	      var exptotalval="0";
	          
	          if(document.getElementById("descgridhid").value!="" && !(document.getElementById("descgridhid").value==null) && !(document.getElementById("descgridhid").value=="undefiend")) 
	       	   {
	       	   
	            nettotalval=parseFloat(document.getElementById("descgridhid").value);
	       	   }
	          
	                  
	       if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
		   {
	    
	        
	     exptotalval=parseFloat(document.getElementById("expencenettotal").value);
		   }
	   
	          
	        
	         ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
	       	   
	    
		funRoundAmt(ordertotal,"orderValue");
		

		
		
		
		
	    }
} 
	

 
 function funrefdisslno()
 {
	 
	 if(document.getElementById('reftype').value=="DIR")
		 {
		 
		  $('#rrefno').attr('disabled', true);
		  $('#rrefno').attr('readonly', true);
		  document.getElementById("errormsg").innerText="";
			 document.getElementById("rrefno").value="";
			 document.getElementById("reqmasterdocno").value="";
			 $("#serviecGrid").jqxGrid('clear');
			 $("#serviecGrid").jqxGrid('addrow', null, {});
			 
			 
			 chkfoc();
			 
		 }
	 
	 else
		 {
		 
		  $('#rrefno').attr('disabled', false);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("reqmasterdocno").value="";
			 $("#serviecGrid").jqxGrid('clear');
			 $("#serviecGrid").jqxGrid('addrow', null, {});
			 
			 $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
		  
		 
		 }
	 
 }
 
 

	function removemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
	}
	function isNumber1(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
        
        		 if (iKeyCode == 45)
        			       			 
        			  {
        			 
        			 
        			  return true;
        		     } 
        		
        		
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }
	
	function gettaxaccount(val)
	{
	 
	
		 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	     
	      var item = items.split('::');
 
	  
	      var method=item[0];
	      
	      var aa=item[1];
	      
	      if(parseInt(method)>0)
	    	  {
	     
	    	  if(parseInt(aa)==0)
    		  {
	    		 	$('#taxsss').hide();
	    		 	$('#process1').hide(); 
	    		  	$('#taxontax1').hide();
    		  		$('#taxontax2').hide();
    		  		$('#taxontax3').hide();
    		    
    		  }
	    	  
	    	  
	    	  if(parseInt(aa)==1)
	    		  {
	    		  
	    		  document.getElementById("tax1per").value=item[3];
	    		  document.getElementById("labeltax1").innerText=item[2];
	    		  document.getElementById("typeoftaken").value=item[6];
	    		  
	    	 
	    		  $('#taxontax2').hide();
	    		  $('#taxontax3').hide();
	    		    
	    		  }
	    	  
	    	  if(parseInt(aa)==2)
    		  {
	    	
    		  document.getElementById("tax1per").value=item[3];
    		  document.getElementById("labeltax1").innerText=item[2];
    		  
    		  document.getElementById("tax2per").value=item[5];
    		  document.getElementById("labeltax2").innerText=item[4];
    		  
    		  document.getElementById("typeoftaken").value=item[6];
    		  
    		  
    		 
    		  $('#taxontax3').hide();
    		  
    		  }
	    	  
	    	  if(parseInt(aa)==3)
    		  {
	    	
    		  document.getElementById("tax1per").value=item[3];
    		  document.getElementById("labeltax1").innerText=item[2];
    		  
    		  document.getElementById("tax2per").value=item[5];
    		  document.getElementById("labeltax2").innerText=item[4];
    		  
    		  document.getElementById("typeoftaken").value=item[6];
    		  
    		  
    		  document.getElementById("tax3per").value=item[8];
    		  document.getElementById("labeltax3").innerText=item[7];
    		  
    		  
    		  }
	    	  
	    	  
	    	  }
	      
		  
	       }}
	   x.open("GET","gettaxaccount.jsp?date="+document.getElementById("masterdate").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
		x.send();
	 
	      
	        
		
	} 
	
	
	function gettaxaccounts()
	{
		$("#serviecGrid").jqxGrid('clear');
	    $("#serviecGrid").jqxGrid('addrow', null, {});
		gettaxaccount(1);
	}
	
	
	function funcalutax()
	{
		
		//alert(infuncalutax);
		var tax1=document.getElementById("tax1per").value;
		var tax2=document.getElementById("tax2per").value;
		
		var tax3=document.getElementById("tax3per").value;
		
		var typeoftaken=document.getElementById("typeoftaken").value;
		 
		var st=document.getElementById("st").value;
		
		var producttotal=document.getElementById("netTotaldown").value;
		var tax1val=0;
		var tax2val=0;
		var tax3val=0;
		var finaltax=0;
		
		if(parseInt(typeoftaken)==-1)
			{
			if(parseFloat(tax1)>0)
				{
				tax1val=parseFloat(producttotal)*(parseFloat(tax1)/100);
				
				
				if(parseFloat(tax2)>0)
				{
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
				}
				else
					{
					tax2val=0;
					}
				
				
						if(parseFloat(tax3)>0)
						{
							tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
						}
						else
							{
							tax3val=0;
							}
				
				
				
				
			//	finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
				
				
				
				}
			}
			
			else {
				
				if(parseFloat(tax1)>0)
				{
				tax1val=parseFloat(st)*(parseFloat(tax1)/100);
				if(parseFloat(tax2)>0)
				{
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
				}
				else
					{
					tax2val=0;
					}
				

				if(parseFloat(tax3)>0)
				{
					tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
				}
				else
					{
					tax3val=0;
					}
		
		
		
				
				

				
				
				}
			}
			
			
		 
			
			
			
		
		funRoundAmt4(tax1val,"taxontax1"); 
		funRoundAmt4(tax2val,"taxontax2");
		funRoundAmt4(tax3val,"taxontax3");
		
		finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
		
		 
		
		funRoundAmt4(finaltax,"taxtotal");
		
	 
		
		
		 	
		
	}
	
	function funRoundAmt4(value,id){
		  var res=parseFloat(value).toFixed(2);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }      			
	 function getitemtype(){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		        
		            if($('#hideitemtype').val()!="")
					  {
					  
					  
					  $('#itemtype').val($('#hideitemtype').val());   
					  
					  }
				 
		  
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        
		      
		        }
	 
   
   function chkcostcode()
   {
    
      var x=new XMLHttpRequest();
      x.onreadystatechange=function(){
      if (x.readyState==4 && x.status==200)
       {
         var items= x.responseText.trim();
        
         if(parseInt(items)>0)
          {
      	   
      	   document.getElementById("costcheck").value=1;
      	   
      	   $('#hcostcodes').show();
      	    
      	   
       	  
           }
             else
         { 
          	   document.getElementById("costcheck").value=0;
          	   $('#hcostcodes').hide();
         }
         
          }}
      x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
   	x.send();
    
         
           
   	
   } 
   
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
	/* 	 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value=""; */
		 
	 
	 }  
	 
	 function reloads()
	 {
		 
	 	  var accdocno = document.getElementById("accdocno").value;
	 	  
	 	  
	 	  var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
	 	  var dates=document.getElementById("masterdate").value;
	 	  var brandids=0;
	 	  var cmbbilltype=document.getElementById("cmbbilltype").value;     	

	 	  $("#part").load('part.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&acno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&brandids="+brandids);
	 	  $("#pnames").load('name.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&acno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&brandids="+brandids);
	 }
	 
	 function getunit(val){ 
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		      items=items.split('####');
		      var docno=items[0].split(",");
		      var type=items[1].split(",");
		      var optionstype;
		      for ( var i = 0; i < type.length; i++) {
		    	  optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		      }
		      $("select#unit").html(optionstype); 	
		    }
		   }
		   x.open("GET","getunit.jsp?psrno="+val,true);
		   x.send();
	 }
	 function getbatch(event){
		 if(document.getElementById("multi").checked)
		 {
			 var x= event.keyCode;
			 if(x==114){
			  $('#bacthWindow1').jqxWindow('open');
			  btsearchContent('batchsearchform.jsp?');
			 }
		 }
	}
	function btsearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#bacthWindow1').jqxWindow('open');
			 $('#bacthWindow1').jqxWindow('setContent', data);
		}); 
	}
	function setgrid()
	{
		 var temppsrno=document.getElementById("temppsrno").value; 
		 var unit=document.getElementById("unit").value; 
		 var rows1 = $("#serviecGrid").jqxGrid('getrows');
		 var aa=0;
	    for(var i=0;i<rows1.length;i++){
		   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
		   {
			 if((parseInt(document.getElementById("multimethod").value)==1))
			 {	
			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
			   {
				   aa=1;
    			   break;
			   }
			 }
			 else
			 {
			   aa=1;
			   break;
			 }
		   }
		   else{
			   aa=0;
		   } 
	    }
	    if(parseInt(aa)==1)
	    {
	    	document.getElementById("errormsg").innerText="You have already select this product";
	    	document.getElementById("jqxInput1").focus();
	    	return 0;
	    }
	    else
	    {
	    	document.getElementById("errormsg").innerText="";
	    }
		 var rows = $('#serviecGrid').jqxGrid('getrows');
	     var rowlength= rows.length;
	     /* if(document.getElementById("multi").checked)
		 {
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');

			 if(document.getElementById("colbatch").value=="")
			 {
				 document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
				 return 0;
			 }
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
		 }
	     else
	     {
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
			 if(parseInt(document.getElementById("expchk").value)==1)
			 {
				  var  exp_date=document.getElementById("expdate").value;
				  if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
				  {
					  document.getElementById("errormsg").innerText="Expiry Date Is Required ";
					  return 0;
	      	 	   }
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
			 }else
			 {
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
			 }
	     } */
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
	     if(parseFloat(document.getElementById("dispers").value)>0){
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value);  
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "discount", document.getElementById("dict").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "nettotal", document.getElementById("amounts").value);	 
		 }
	     else{
	    	 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
	    	 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1,"discount", 0);
	    	 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "nettotal", document.getElementById("totamt").value);
	     }
	     if(parseFloat(document.getElementById("taxpers").value)>0)		    		 {
	    	  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
	    	  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
	    	  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxamount", document.getElementById("taxamountstotal").value);	    		 }
	     else{
	    	 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper", 0);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", 0);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxamount",  document.getElementById("amounts").value);  
		 }
	     
	     if(document.getElementById("unit").value>0)
	     {
	     	$('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
	     }
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
	     $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
// 	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "expfoc", document.getElementById("extrafocs").value);
	     
	     /* if(document.getElementById("multi").checked)
		 {
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
			  if(document.getElementById("colbatch").value=="")
			  {
				  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
				  return 0;
			  }
			  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
	     }
	     else
	     {
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
			 if(parseInt(document.getElementById("expchk").value)==1)
			 {
				 var  exp_date=document.getElementById("expdate").value;
				 if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
				 {
					 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
					 return 0;
				 }
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
				 }else
				 {
					 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
				 }
	     } */
			  
		   document.getElementById("jqxInput").value ="";
		   document.getElementById("jqxInput1").value="";
		   document.getElementById("brand").value=""; 
		   document.getElementById("collqty").value ="";
		   document.getElementById("quantity").value ="";
		   document.getElementById("unit").value ="";
		   document.getElementById("extrafocs").value="";
		   document.getElementById("focs").value="";
		   document.getElementById("dispers").value="";
		   document.getElementById("uprice").value="";
		   document.getElementById("totamt").value="";
		   document.getElementById("amounts").value="";
		   document.getElementById("dict").value="";
		   document.getElementById("taxpers").value="";
		   document.getElementById("taxamounts").value="";
		   document.getElementById("taxamountstotal").value="";
		   document.getElementById("multi").checked=false;
		   document.getElementById("batch").value="";
		   document.getElementById("colbatch").value="";

		   $('#batch').attr('readonly', false);
		   $('#expdate').jqxDateTimeInput({ disabled: false});
		   $('#expdate').val(null);
			 
		       document.getElementById("temppsrno").value="";
		       document.getElementById("tempspecid").value="";
	     
	     
	     
	     
			  
			   document.getElementById("jqxInput").value ="";
			   document.getElementById("jqxInput1").value="";
			   document.getElementById("brand").value=""; 
	           document.getElementById("collqty").value ="";
			   document.getElementById("quantity").value ="";
			   document.getElementById("unit").value ="";
			   document.getElementById("focs").value="";
		  	   document.getElementById("batch").value="";
			   document.getElementById("colbatch").value="";
			   document.getElementById("temppsrno").value="";
			   document.getElementById("tempspecid").value="";
			   $('#expdate').val(null); 										
			   $("#serviecGrid").jqxGrid('addrow', null, {});
			   document.getElementById("jqxInput1").focus();
	 }
	function calculatedata(val)
	 {

		
		
		//alert(incalculatedata);
		var quantity=document.getElementById("quantity").value;
		
		var uprice=document.getElementById("uprice").value;
		var taxpers=document.getElementById("taxpers").value;
		var disper=document.getElementById("dispers").value;
		var discount=document.getElementById("dict").value;

		var totamt=0;
		var taxamounts=0;
		var taxamountstotal=0;
		if(val=="dispers"){discount=0; }
		 if(val=="dict"){disper=0; }
		
		if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN")
		{
			quantity=0;
		}
		 
		if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
		{
			uprice=0;
		}
		 
		if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
		{
			disper=0;
		}
		
		
		if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN")
		{
			discount=0;
		}
		var netamount=0; 
		if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
		{
			taxpers=0;
		}
		
		 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
			 {
			 totamt=parseFloat(quantity)*parseFloat(uprice);
			 }
		 
		 
			
			if(parseFloat(disper)>0 || parseFloat(discount)>0)
			{
				if(parseFloat(disper)>0)
					{
						discount=(parseFloat(totamt)*parseFloat(disper))/100;
					
					}
				
				else if(parseFloat(discount)>0)
					{
					
					disper=(100/parseFloat(totamt))*parseFloat(discount);
					
					}
				 
				netamount=parseFloat(totamt)-parseFloat(discount);
				
			}
			else
			{
				disper=0;
				discount=0;
				netamount=totamt;
			}
			
		 
		 
		 
		 
		 if(parseFloat(taxpers)>0)
		 {
			 
			 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
			 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
		 }
		 else
			 {
			 taxamountstotal=netamount;
			 }
		 document.getElementById("totamt").value=(totamt).toFixed(2);
		 document.getElementById("dispers").value=parseFloat(disper).toFixed(2);
		 document.getElementById("dict").value=parseFloat(discount).toFixed(2);
		 document.getElementById("amounts").value=(netamount).toFixed(2);
		 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
		 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
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
<body onLoad="getCurrencyIds();setValues();chkcostcode();getitemtype();">


<div id="mainBG" class="homeContent" data-type="background">
<form id="purchaseInv" action="saveActionpurInv" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
<jsp:include page="multiqty.jsp"></jsp:include><br/>
	<div class='hidden-scrollbar'>
	 <input type="hidden" id="roundmethod">
<input type="hidden" id="roundvals">
	<fieldset>
	
	     <table width="100%"  >
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="12%"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
      <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'></td>
            <td align="right" width="6%">Location</td> 
    <td colspan="3"  ><input type="text" id="txtlocation" name="txtlocation" style="width:40.5%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>'  onkeydown="getloc(event);"/>
      <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
      
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
      <label id="billname">Bill Type</label> &nbsp;<select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()"  style="width:13%;" value='<s:property value="cmbbilltype"/>'>
      <option value="1">ST</option>
      <option value="2">RCM</option>
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
    
      </td>
    <td width="3%" align="right">Ref No</td>
    <td width="18%"><input type="text" name="refno" id="refno" style="width:50%;" value='<s:property value="refno"/>'></td>
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>

  <tr>
    <td align="right">Vendor</td>  
    <td colspan="3"><input type="text" name="puraccid" id="puraccid" value='<s:property value="puraccid"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:72%;"></td>
      
      <td align="right">Ref Type</td>
    <td colspan="5"><select name="reftype" id="reftype" style="width:17%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR">DIR</option>
       <option value="PO">PO</option>
      <option value="GRN">GRN</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:32%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefno(event);"></td>
      
    
  </tr>
    <tr>
    <td   align="right">Currency</td>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select></td>
    <td align="right">Rate</td>
    <td  ><input type="text" name="currate" id="currate"  value='<s:property value="currate"/>'></td>
    

<%--     <td align="right">Ref Type</td>
    <td colspan="5"><select name="reftype" id="reftype" style="width:10%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR">DIR</option>
      <option value="GRN">GRN</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:37.2%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefnosearch(event);"></td>
  </tr> --%>
  <td align="right">Inv. Date</td> 
    <td><div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div>  
    <input type="hidden" name="hidinvdate" id="hidinvdate" value='<s:property value="hidinvdate"/>'></td>
    <td align="right">Inv. No</td>
    <td colspan="1"><input type="text" name="invno" id="invno" style="width:50%;"  onblur="removemsg()" value='<s:property value="invno"/>'></td>
    
    
    <td colspan="2" rowspan="3"> <div id="hcostcodes" hidden="true">  
 
 <table width="100%" >
 <tr><td align="right" width="15%">Group</td><td><select  id="itemtype"  name="itemtype" style="width:62%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select></td>
 
  <tr><td align="right">Job No</td><td><input type="text" id="itemdocno" placeholder="Press F3 to Search"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' >
    </td>
    
     <tr><td colspan="2">  <input type="text" id="itemname" name="itemname" style="width:99%;"   value='<s:property value="itemname"/>' > </td>
 
 </table>
 
 
  </div>
 
  </td>
    </tr>
  
  <tr>
    <td align="right">Delivery Date</td>
    <td><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'></td>
    <td align="right">Delivery Terms</td>
    <td colspan="7"><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:63.5%;"></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="9"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:70.4%;"></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="7"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:88.2%;"></td>
    <td colspan="2" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>
	 <button type="button"  title="Show data" class="iconss"   id="FixedDiv"  style="position:fixed;z-index:1000;right:130px;top:6px; " value='<s:property value="FixedDiv" /> '>
					 <img alt="Show data" src="<%=contextPath%>/icons/reportpurchase.png" width="33" height="36" > 
					</button>
<%-- <table width="100%">
  <tr> 
    <td width="39" align="right">Date</td>  
    <td width="128"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div> 
    
    <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
    </td>
   <td align="right" width="139">Ref No</td>
    <td width="152"><input type="text" name="refno" id="refno" style="width:71%;" value='<s:property value="refno"/>'></td>
    <td align="right" width="99">Ref Type</td>
    <td width="110" >
        <select name="reftype" id="reftype" style="width:41%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno()"> 
      <option value="DIR">DIR</option>
      <option value="GRN">GRN</option>
    </select></td> 
    <td width="144"><input type="text" name="rrefno" id="rrefno" style="width:70%;" placeholder="Press F3 To Search"  value='<s:property value="rrefno"/>'  onKeyDown="getrefno(event);"> </td>   
     
    <td width="56" align="right">Doc No</td>
    <td width="163"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>
  </table>
 <table width="100%"  >
  <tr>
       <td width="1%" align="right">Vendor</td> 
    <td colspan="5" width="14%" align="left"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
    <td width="1%" align="right">Account</td>
  
     <td colspan="5" width="14%" align="left"> 
    <select name="acctype" id="acctype" style="width:10%;"  value='<s:property value="acctype"/>' > puraccid puraccname
    <option value="" ></option>
      <option value="AR" >AR</option>
      <option value="AP" >AP</option>  
    </select>  
    <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' style="width:20%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:70%;"></td>
    <td align="right" width="1.6%">&nbsp;</td>
    <td width="4%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    
    Curr&nbsp;<select name="cmbcurr" id="cmbcurr" style="width:40%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select>    </td>

    <td width="3.1%" align="right">Rate <input type="text" name="currate" id="currate" value='<s:property value="currate"/>'></td>
    <td width="9%" align="left"></td>
    
  </tr>
  </table>
  <table width="100%" >
  <tr>
 
    <td align="right" width="4.3%" >Del Date</td> 
    <td align="left"width="3%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    
     <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
    
    </td>
  

    <td align="right" width="3.8%" >Del Terms</td>
    <td colspan="4" align="left" width="73%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:68.1%;"></td>
 
    
  </tr></table> --%>
                              
<%--     <table width="100%"  >
  <tr>
  <td align="right"  width="4.7%">Pay Terms</td>
    <td colspan="6"  width="94%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:73%;"></td>
    </tr>
    <tr>
    <td align="right"  width="4.7%">Description</td>
    <td colspan="6"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:73%;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td></tr>

 <!-- <button class="myButton" type="button" id="FixedDiv" name="btnvaluechange1"   style="position:fixed;z-index:5000;right:10px;top:10px;">Value Change</button> --> 
</table> --%>
 <%--    <button type="button"  title="Show data" class="iconss"   id="FixedDiv"  style="position:fixed;z-index:1000;right:20px;top:10px; " value='<s:property value="FixedDiv" /> '>
					 <img alt="Show data" src="<%=contextPath%>/icons/reportpurchase.png" width="30" height="35" > 
					</button> --%>
  </fieldset>
  
<fieldset id="psearch">
<legend>Item Details</legend>
   <table width="100% "  >   
   <tr> 
	   <td align="center">Product ID</td>
	   <td align="center" colspan="2">Product Name</td>
	   <td align="center" style="width:15%;"  >Brand</td>
	   <td align="center">Unit</td>
	   <td  width="6%" align="center">Qty</td>
	   <td align="center" class="ff" >FOC</td>
	   <td align="center" class="ff" > Extra FOC</td> 
	   <td align="center"> Unit price</td>
	   <td align="center"> &nbsp;</td>
   </tr>
   <tr>
	   <td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
	   <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
	   <td align="center" ><input type="text" id="brand" ><input type="hidden" id="collqty" ></td>
	   <td align="center"> <select    id="unit"   >   </select>      </td>  
	   <td width="6%" align="center"> <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">    <input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
	   <td align="center" class="ff">   <input type="text" id="focs"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"     ></td>
	   <td  align="center"class="ff"> <input type="text" id="extrafocs"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"     ></td>
	   <td align="center">   <input type="text" id="uprice"    onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);" style="text-align: right;"></td>
	   <td align="center"> &nbsp;</td>
  </tr>
  <tr>
	<td align="center">Total</td> 
	<td align="center">Discount% </td>
	<td align="center">Discount</td> 
	<td align="center">Net Amount</td>  
	<td align="center">Tax%</td>  
	<td align="center">Tax Amount</td>  
	<td    align="center">Net Total</td>   
    <td align="center" class="ff">Multi_Batch</td> 
    <td align="center" class="ff">Batch</td>
    <td align="center" class="ff">ExpDate</td>   
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
  </tr>
  <tr>
	<td align="center"><input type="text" id="totamt" tabindex="-1"      style="text-align: right;"   ></td>
	<td align="center"><input type="text" id="dispers"     onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);"  style="text-align: right;"  ></td>
	<td align="center"><input type="text" id="dict"    onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"    onchange="calculatedata(this.id);"  style="text-align: right;"  ></td>
  	<td align="center"><input type="text" id="amounts" tabindex="-1"    style="text-align: right;" ></td> 
	<td align="center"><input type="text" id="taxpers"  tabindex="-1"       style="text-align: right;"  onchange="calculatedata(this.id);" ></td>  
	<td align="center"><input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
	<td align="center"><input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>  
	<td align="center" class="ff"><input type="checkbox" id="multi"style="text-align: right;" onchange="chkmultis()" > </td>
	<td align="center" class="ff"><input type="text" id="batch"    onkeydown="getbatch(event)" > </td>
	<td  class="ff"><div id="expdate" name="expdate" value='<s:property value="expdate"/>'></div> </td> 
	<td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 </tr>
 </table> 
</fieldset> 
  
 <br>
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    <div id="sevdesc" ><jsp:include page="serviecgrid.jsp"></jsp:include></div>  
  
    
 <fieldset> 
   <legend>Summary</legend>   
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;"></td>
<td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

 <td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>             
</fieldset>
 
 <fieldset>
   <legend>Service</legend>
 
  
       <div id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>

</fieldset>


 


<fieldset><legend>Purchase Expense</legend>
<table width="100%">
  <tr><td>
    <div id="expDiv"><jsp:include page="purchaseexpGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset>



<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table>

<div  id="taxsss">
<fieldset > 
 <legend>Tax Details</legend> 
<table width="100%">

<tr>

<td align="right">Total Tax</td><td align="left"><input type="text" id="st" name="st" style="width:50%;"   value='<s:property value="st"/>'  ></td>

<td><button type="button" class="icon" id="process1" title="Process1" onclick="funcalutax();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button></td>

<td align="right"><label id="labeltax1"></label></td><td  align="left"><input type="text" id="taxontax1" name="taxontax1" style="width:50%;"   value='<s:property value="taxontax1"/>'  ></td>
<td align="right"><label id="labeltax2"></label></td><td  align="left"><input type="text" id="taxontax2" name="taxontax2" style="width:50%;"   value='<s:property value="taxontax2"/>'  >
<td align="right"><label id="labeltax3"></label></td><td  align="left"><input type="text" id="taxontax3" name="taxontax3" style="width:50%;"   value='<s:property value="taxontax3"/>'  >
 </td>

<td  align="right">Net Tax Total</td><td  align="left"><input type="text" id="taxtotal" name="taxtotal" style="width:50%;"   value='<s:property value="taxtotal"/>'  ></td>

</table>

</fieldset>
</div>
<input type="hidden" id="expencenettotal" name="expencenettotal"  value='<s:property value="expencenettotal"/>'/>    

   <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
    <input type="hidden" id="descgridhid" name="descgridhid"  value='<s:property value="descgridhid"/>'/>
    <input type="hidden" id="descgridtax" name="descgridtax"  value='<s:property value="descgridtax"/>'/>
  <input type="hidden" id="chkdiscountval" name="chkdiscountval"  value='<s:property value="chkdiscountval"/>'/>      

  <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>  
  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
             
          
             
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>   
                   <input type="hidden" id="serviecGridlength" name="serviecGridlength"  value='<s:property value="serviecGridlength"/>'/>    
                
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>    
           
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
           
          <!--  req search docno -->
           
               <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>
            <input type="hidden" id="reqmasterdocno" name="reqmasterdocno"  value='<s:property value="reqmasterdocno"/>'/>
            
            
             <input type="hidden" id="producttype" name="producttype"  value='<s:property value="producttype"/>'/> <!-- no use -->
             
             
<input type="hidden" id="expgridlength" name="expgridlength"  value='<s:property value="expgridlength"/>'/>
<input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
 
   
<input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
<input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
<input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
<input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
 
<input type="hidden" id="puchasechk"/> 
<input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
<input type="hidden" id="typeoftaken"> <!-- valuebased -->
<input type="hidden" id="tax1per"> <!-- first tax % -->
<input type="hidden" id="tax2per"><!--  sec tax % -->
<input type="hidden" id="tax3per"><!--  tird tax % -->
<input type="hidden" id="temppsrno" >  
<input type="hidden" id="tempspecid" >
<input type="hidden" id="colbatch" >  
 
</form>
</div> 
<div id="searchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	  <div id="sidesearchwndow">
	   <div ></div>
	</div>
		  <div id="importwindow">
	   <div ></div>
	</div>
		  <div id="searchwndow">
	   <div ></div>
	</div>
	<div id="expencewindow">
	   <div ></div>
	</div>
	
		  <div id="locationwindow">
	   <div ></div>
	</div>
			  <div id="calculationwindow">
	   <div ></div>
	</div>
 <div id="lastpurchasewindow">
	   <div ></div>
	</div>
<div id="bacthWindow1"> <div></div></div>
</body>
</html>