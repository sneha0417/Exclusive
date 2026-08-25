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
</style>

<script type="text/javascript">

 
$(document).ready(function () { 
 
 
	$('#btnvaluechange').hide();
    $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
   // $("#invdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');  
	      
			$('#expencewindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#expencewindow').jqxWindow('close');
	     
	     
	     
	     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');   
	     
	     
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 
	 
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		     $('#importwindow').jqxWindow('close');   
		     
		     
/* 		     $('#calculationwindow').jqxWindow({ width: '80%', height: '60%',  maxHeight: '80%' ,maxWidth: '80%'  , title: 'Calculation ' ,animationType: 'slide',position: { x: 150, y: 50 }, keyboardCloseKey: 27});
			   $('#calculationwindow').jqxWindow('close');
		      */
		     
		     
		     
		     if($('#reftypeval').val()=="PIV")
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
						  
				  	    $('#refnosearchwindow').jqxWindow('open');
				  	
				  	  refsearchContent('refnosearch.jsp?'); 
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
    
/*     $("#FixedDiv").click(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()== "view")
    		{
    	
    		
	  	    $('#calculationwindow').jqxWindow('open');
	  	
	  	  calculationsearchContent('calcutionmaster.jsp?');
    		}
  });    */
    
    
    
    
  
});
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
function getrefno(event)
{
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp?');  }
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
	 
	// $('#invdate').jqxDateTimeInput({ disabled: true});
	 
	 
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
		//$("#descdetailsGrid").jqxGrid({ disabled: true});
	//	$("#serviecGrid").jqxGrid({ disabled: true});
		 $('#process1').attr('disabled', true);
		 $('#rrefno').attr('disabled', true);
		 // $('#descPercentage').attr('disabled', true);
		// $('#descountVal').attr('disabled', true);
		// $('#chkdiscount').attr('disabled', true);	 

		 $('#producttype').val(0);	 
		 
		 
		//	$("#purchexpgrid").jqxGrid({ disabled: true});
			 
		 
		 
		 
	  $('#cmbcurr').attr('disabled', true);		
	  $('#btnvaluechange').hide();
	 $('#acctype').attr('disabled', true);
	 
	 
 
		 chkfoc(); 
		 
	 
	 
	
}
function funRemoveReadOnly(){
	 document.getElementById("editdata").value="";
	// $('#FixedDiv').hide();
	$('#purchaseInv input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	
	$('#purchaseInv select').attr('disabled', false );
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  $('#rrefno').attr('disabled', true);
	  $('#rrefno').attr('readonly', true);
		 $('#btnvaluechange').hide();
		 $('#txtlocation').attr('readonly', true);
		
		 gettaxaccount(1);	
		 
		 $('#st').attr('readonly', true );
		 $('#taxontax1').attr('readonly', true );
		 $('#taxontax2').attr('readonly', true );
		 $('#taxontax3').attr('readonly', true );
		 $('#taxtotal').attr('readonly', true );
		  $('#process1').attr('disabled', false);

		  
		  
		 $('#producttype').val(0);	 
		 
		  
		// $('#invdate').jqxDateTimeInput({ disabled: false});
	 $('#masterdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	//$("#descdetailsGrid").jqxGrid({ disabled: false});
	 $("#serviecGrid").jqxGrid({ disabled: false});
		//$("#purchexpgrid").jqxGrid({ disabled: false});
	 
	  $('#descPercentage').attr('disabled', true);
	 $('#descountVal').attr('disabled', true);
	 $('#docno').attr('readonly', true);
	 
	 $('#orderValue').attr('readonly', true);
	 
	 
	 $('#productTotal').attr('readonly', true);
	 $('#netTotaldown').attr('readonly', true);
	 
	 
	 
	if ($("#mode").val() == "A") {
		  //$('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
		$('#deliverydate').val(new Date());
		
		//$('#invdate').val(new Date());
		// $('#invdate').jqxDateTimeInput({ disabled: false});
/* /* 		
		 $("#descdetailsGrid").jqxGrid('clear');
		    $("#descdetailsGrid").jqxGrid('addrow', null, {}); */  
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
/* 			    
			    
			    $("#purchexpgrid").jqxGrid('clear');
			    $("#purchexpgrid").jqxGrid('addrow', null, {}); */
			    
			  
			   	 chkfoc(); 
			   	 
			   
				 
		    
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
  		//$("#descdetailsGrid").jqxGrid({ disabled: true});
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		

	    
		//$("#purchexpgrid").jqxGrid({ disabled: true});
		 
	    
		
		
	}  
  
	
	
  	$('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');  
	
	getCurrencyIds();
}




function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 
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
		   
	if(document.getElementById('reftype').value=="DIR")
	{
		
	}
	else
		{
		
		if(document.getElementById("rrefno").value=="")
		{

		 document.getElementById("errormsg").innerText=" Search Purchase Invoice ";  
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
						   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc+" :: "+rows[i].oldfoc
						   +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].taxdocno+"::"+"0000"+"::"); 
				
				// alert(newTextBox.val());
				  newTextBox.appendTo('form');  
				  
		   
				 
   //alert("ddddd"+$("#test"+i).val());
   
  }   
/* 	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	    $('#descgridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: ");
	
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
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].descsrno+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].accountdono+" :: ");
	
 
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }    */
	   
	   
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
			
			 if($('#reftypeval').val()=="PIV")
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
	    	   
	    		/* $("#descdetailsGrid").jqxGrid({ disabled: false}); */
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
/* 	    		$("#purchexpgrid").jqxGrid({ disabled: false});	  */
			 

			 
			} 
		  
	   
	
	return 1;
} 



function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    	  /*  $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		  document.getElementById("chkdiscount").checked = true;
		 		  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  }
		 	  */
			   
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
			   
			   
		 
				  
				  
				  
				  
		/* 		  
					$("#purchexpgrid").jqxGrid({ disabled: false});
					 
	    		$("#descdetailsGrid").jqxGrid({ disabled: false}); */
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		
	    		
	 /*    		
	    	    $("#purchexpgrid").jqxGrid('addrow', null, {});
	    	    $("#descdetailsGrid").jqxGrid('addrow', null, {}); */
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
			 
			 if($('#reftypeval').val()=="PIV")
			  {
			
			  $('#rrefno').attr('disabled', false);
			  
		  $('#rrefno').attr('readonly', true);
		
			  }
		   
		   
		   
/* 		   if(document.getElementById("chkdiscountval").value==1)
 		  {
 		  document.getElementById("chkdiscount").checked = true;
 		  
 		  
 		  document.getElementById("chkdiscount").value = 1;
 	 
 		  }
 	  else
 		  {
 		  document.getElementById("chkdiscount").checked = false;
 		  document.getElementById("chkdiscount").value = 0;
 		  
 		  } */
		   
		   
		   
		   
		   
		   
		   
			
	   }

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
			/* if($('#hidinvdate').val()){
				$("#invdate").jqxDateTimeInput('val', $('#hidinvdate').val());
			} */
			
			 
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
				
				
				
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  	/* 	 $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1); 
	     	  		 $("#expDiv").load("purchaseexpGrid.jsp?masterdoc="+indexval1);
	     	  		   */
	     	  		 var reftypeval = document.getElementById("reftypeval").value;  
	     	  		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
	     	  		 
	     	  	 
	     	  		 //$('#FixedDiv').show(); 
	     	  		
	     	  		 
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		 gettaxaccount(1);
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionpurInvret");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printpurchaseReturn?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
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
/* function fundisable()
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
			$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
			$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	   }
   
	} */
/* function funcalcu()
{
	
 
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
	
	var  roundOf=document.getElementById('roundOf').value;
	
	 if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
 	   {
		 netval=parseFloat(productTotal)+parseFloat(roundOf);
 	   }
	
 
	alert("descvalue"+descvalue);
	
	alert("netval"+netval);
 
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
       	   
    
	funRoundAmt(ordertotal,"orderValue");
	
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
	 
	 
	
 
	
	
	
	
	}
	
	 */
	
	
/* function funvalcalcu()
	{
	
	
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descountVal=document.getElementById('descountVal').value;
 
	var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
 
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	funcalcu();
	}
	 */
	
	
/*  function roundval()
{
		var  netTotaldown=document.getElementById('netTotaldown').value;
	    var roundOf=document.getElementById('roundOf').value;
 
	    if(roundOf!="")
	    {	 
		var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
		funRoundAmt(netval,"netTotaldown"); 
	    }
} 
	 */

 
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
			 
			 chkfoc();
		 
		 }
	 
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
			  var res=parseFloat(value).toFixed(4);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
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


<div id="mainBG" class="homeContent" data-type="background">
<form id="purchaseInv" action="saveActionpurInvret" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<div class='hidden-scrollbar'>
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
      <option value="2">CST</option>
      
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
      
      <td align="right">&nbsp;</td>
    <td colspan="5">&nbsp;</td>
      
    
  </tr>
    <tr>
    <td   align="right">Currency</td>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select></td>
    <td align="right">Rate</td>
    <td  ><input type="text" name="currate" id="currate"  value='<s:property value="currate"/>'></td>
    
 
      <td align="right">Ref Type</td>
    <td colspan="3"><select name="reftype" id="reftype" style="width:17%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR">DIR</option>
      <option value="PIV">PIV</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:39%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefno(event);"></td>
  
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
<%-- 	 <button type="button"  title="Show data" class="iconss"   id="FixedDiv"  style="position:fixed;z-index:1000;right:130px;top:6px; " value='<s:property value="FixedDiv" /> '>
					 <img alt="Show data" src="<%=contextPath%>/icons/reportpurchase.png" width="33" height="36" > 
					</button> --%>
 <input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;">

<input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;">
<input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;">

  </fieldset>
 <br>
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    <div id="sevdesc" ><jsp:include page="serviecgrid.jsp"></jsp:include></div>  
  
  
  <div id="taxsss">
<fieldset> 
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
    
<%--  <fieldset> 
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

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>             
</fieldset> --%>
 
<%--  <fieldset>
   <legend>Service</legend>
 
  
       <div id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>

</fieldset>
 --%>

 
<%-- 

<fieldset><legend>Purchase Expense</legend>
<table width="100%">
  <tr><td>
    <div id="expDiv"><jsp:include page="purchaseexpGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset> --%>



 

<input type="hidden" id="expencenettotal" name="expencenettotal"  value='<s:property value="expencenettotal"/>'/>    

   <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   

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
 
            <input type="hidden" id="typeoftaken"> <!-- valuebased -->
 <input type="hidden" id="tax1per"> <!-- first tax % -->
 <input type="hidden" id="tax2per"><!--  sec tax % -->
 <input type="hidden" id="tax3per"><!--  tird tax % -->
 
</form>
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
 
</body>
</html>