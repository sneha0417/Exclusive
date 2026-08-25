<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String rfqarrays = request.getParameter("rfqarray") == null? "0": request.getParameter("rfqarray").toString();

%>
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
var mod1='<%=mod%>';
var rfqarrays='<%=rfqarrays%>';

$(document).ready(function () { 
    
	   /* Date */ 	
	   
	   		 $('#btnvaluechange').hide();
    $("#date").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');
	      
			$('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
             	y : 87
			}, keyboardCloseKey: 27});
		     $('#tremwndow').jqxWindow('close');
	     
	     
	     
	     $('#sidesearchwndow').jqxWindow({ width: '50%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');   
	      
	     
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		 $('#refnosearchwindow').jqxWindow('close'); 
	 
		   
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		   $('#importwindow').jqxWindow('close');   
		     
		     if($('#reftypeval').val()=="CEQ" || $('#reftypeval').val()=="PR")
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
				  /* if(document.getElementById("puraccid").value=="")
					{
					
					 document.getElementById("errormsg").innerText="Search Vendor";  
					 document.getElementById("puraccid").focus();
				       
				        return 0;
					} */
		  	    $('#refnosearchwindow').jqxWindow('open');
		  	
		  	  refsearchContent('refnosearch.jsp?'); 
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
    
    $('#shipto').dblclick(function(){
        
    	if($('#mode').val()!= "view")
    		{
    	
    		
	   
	  	   shipSearchContent('shipmasterSearch.jsp?');
    		}
  });   
    

});

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
	 $('#accountSearchwindow').jqxWindow('open');
       $.get(url).done(function (data) {
//alert(data);
     $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
 	}  


function shipdescSearchContent(url) {
    //alert(url);
       $.get(url).done(function (data) {
 
  $('#tremwndow').jqxWindow('open');
     $('#tremwndow').jqxWindow('setContent', data);

	}); 
 	}  

function termsSearchContent(url) {
	   $('#tremwndow').jqxWindow('open');
      $.get(url).done(function (data) {
    $('#tremwndow').jqxWindow('setContent', data);
    $('#tremwndow').jqxWindow('bringToFront');

}); 
	} 

function getrefno(event)
{
	 var x= event.keyCode;
	 if(x==114){
		 
/* 		 if(document.getElementById("puraccid").value=="")
			{
			
			 document.getElementById("errormsg").innerText="Search Vendor";  
			 document.getElementById("puraccid").focus();
		       
		        return 0;
			} */
		 
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
	//$('#purchaseReqforqout')[0].reset(); 
}
function funReadOnly(){
	$('#purchaseReqforqout input').attr('readonly', true );
	$('#purchaseReqforqout select').attr('disabled', true );
	 $('#date').jqxDateTimeInput({ disabled: true});
	 
		 
		$("#serviecGrid").jqxGrid({ disabled: true});
		 $("#shipdata").jqxGrid({ disabled: true});
		 $('#rrefno').attr('disabled', true);
		  $('#descPercentage').attr('disabled', true);
		 $('#descountVal').attr('disabled', true);
		 $('#chkdiscount').attr('disabled', true);	 

		 $('#producttype').val(0);	 
		 
		 
			$("#jqxTerms").jqxGrid({ disabled: true});
			
			
			 $('#btnCalculate').attr('disabled', true);
			 
		 
		 
		 
	  $('#cmbcurr').attr('disabled', true);		
	  $('#btnvaluechange').hide();
	 $('#acctype').attr('disabled', true);
	 if(document.getElementById("status").value.trim()=="0" )
		{
		mod1="view";
		}
		if(mod1=="A")
			{
			
			 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
			}
	
}
function funRemoveReadOnly(){
	
		
	
	 document.getElementById("editdata").value="";
	
	if ($("#mode").val() == "A") {
	 gridLoad();
	 chkprocess();
	}
	$('#purchaseReqforqout input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	
	$('#purchaseReqforqout select').attr('disabled', false );
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  $('#rrefno').attr('disabled', true);
	  $('#rrefno').attr('readonly', true);
		 $('#btnvaluechange').hide();
		 
		 $('#shipto').attr('readonly', true);
		 $('#shipaddress').attr('readonly', true);
		 $('#contactperson').attr('readonly', true);
		 $('#shiptelephone').attr('readonly', true);
		 $('#shipmob').attr('readonly', true);
		 
		 $('#shipemail').attr('readonly', true);
		 $('#shipfax').attr('readonly', true);	 
		 $('#producttype').val(0);	 
		 
	  
	 $('#date').jqxDateTimeInput({ disabled: false});
 

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
		 $("#serviecGrid").jqxGrid({ disabled: false});

	 
	  $('#descPercentage').attr('disabled', true);
	 $('#descountVal').attr('disabled', true);
	 $('#docno').attr('readonly', true);
	 
	 $('#orderValue').attr('readonly', true);
	 
	 
	 $('#productTotal').attr('readonly', true);
	 $('#netTotaldown').attr('readonly', true);
	 
	 $("#shipdata").jqxGrid({ disabled: false});
	 
	if ($("#mode").val() == "A") {
		  $('#chkdiscount').attr('disabled', false);
		$('#date').val(new Date());
		 
		 
		    
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
			    
			    $("#jqxTerms").jqxGrid('addrow', null, {});
			    $("#jqxTerms").jqxGrid({ disabled: false});
		 
			    $("#shipdata").jqxGrid('clear');
			    $("#shipdata").jqxGrid('addrow', null, {});
			    
		    
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 
  		 
		$("#serviecGrid").jqxGrid({ disabled: true});
	 
		
		 
		$("#shipdata").jqxGrid({ disabled: true});
	    
		$("#jqxTerms").jqxGrid({ disabled: true});
		 
		   $('#btnCalculate').attr('disabled', true);
		
		
      	   var rows = $("#serviecGrid").jqxGrid('getrows');
      	    var aa=0;
      	    for(var i=0;i<rows.length;i++){
      	 
      	    	
      	    	 
      		   if(parseInt(rows[i].clstatus)==1)
      			   {
      			   aa=1;
      			   break;
      			   }
      		   else{
      			   
      			   aa=0;
      		       } 

      	 
      	   
      	                         }
      	    
      	    
      	    
      	   if(parseInt(aa)==1)
   		   {
      		  $('#serviecGrid').jqxGrid('render');
      		 $('#btnvaluechange').hide();
   		   
   		   }
   	   else
   		   {
   		$('#btnvaluechange').show();
   		   }
		   
		   
		   
		   
	}  
  
	
	
	
	
	getCurrencyIds();
	if(mod1=="A")
	{
    	
    	$("#sevdesc").load("serviecgrid.jsp?rfqarray="+'<%=rfqarrays.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
     	}
	chkproductconfig();
}
function chkproductconfig()
{
	
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
    	
    	   document.getElementById("productchk").value=1;
    	 
    	     $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',false);
    	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',false);
    	   		
    	   } 
        
          else
      {
        	   document.getElementById("productchk").value=0; 
        	   $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
       	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
      }
      
       }}
   x.open("GET","checkproductconfig.jsp?",true);
	x.send();

	
}

function gridLoad(){
	  var dtype=document.getElementById("formdetailcode").value;
	  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
}

function funFocus(){
	 
   	$('#date').jqxDateTimeInput('focus'); 	    		
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
	   
	   
if(document.getElementById('reftype').value=="DIR")
{
	
}
else
	{
	
	if(document.getElementById("rrefno").value=="")
	{

	 document.getElementById("errormsg").innerText="Search Sales Enquiry";  
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
						   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper); 
				
				// alert(newTextBox.val());
				  newTextBox.appendTo('form');
				  
		   
				 
   //alert("ddddd"+$("#test"+i).val());
   
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
 
   //alert("ddddd"+$("#test"+i).val());
   
  }  
  



	   var termrows = $("#jqxTerms").jqxGrid('getrows');
		  
		  
		  $('#termsgridlength').val(termrows.length);
	   
	   
	   
		  for(var i=0 ; i < termrows.length ; i++){ 
			   newTextBox = $(document.createElement("input"))
			      .attr("type", "dil")
			      .attr("id", "termg"+i)
			      .attr("name", "termg"+i)
			      .attr("hidden", "true");
			   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::");
			   
			  newTextBox.val(termrows[i].voc_no+"::"+termrows[i].dtype+"::"+termrows[i].terms+"::"+termrows[i].conditions+"::");
			  newTextBox.appendTo('form');
			  }
	   
	   
		if ($("#mode").val() == "E") {
			
			 if($('#reftypeval').val()!="DIR")
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
	    	   
	    	 
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
	    		$("#jqxTerms").jqxGrid({ disabled: false});	 
			 
			 
			 
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
			   
			   
			//	  $('#rrefno').attr('disabled', false);
				 // $('#rrefno').attr('readonly', true);
					$("#jqxTerms").jqxGrid({ disabled: false});
					 
	    		 
	    		
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		
	    		
	  	      
	    		$("#shipdata").jqxGrid({ disabled: false});
	    		
	    		$("#shipdata").jqxGrid('addrow', null, {});
	    	    
	    	    
	     
	    	    $("#serviecGrid").jqxGrid('addrow', null, {});
	    	    $("#jqxTerms").jqxGrid('addrow', null, {});
	    		

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
			  if($('#reftypeval').val()!="")
			  {
			  
			  
			  $('#reftype').val($('#reftypeval').val());
			  }
			 
			 if($('#reftypeval').val()!="DIR")
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

	   function setValues() {
			if($('#hiddate').val()){
				$("#date").jqxDateTimeInput('val', $('#hiddate').val());
			}
		 
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
				
				funchkforedit();
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  		 $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1);
	     	  		 
	     	  		  
	     	  		 var reftypeval = document.getElementById("reftypeval").value;  
	     	  		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
	     	  		 
	     	  		 
	     	  		 
	     	  		 $("#termsDiv").load("termsGrid.jsp?masterdoc="+indexval1);
	     	  		 
	     	  		 
	     	  		 $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+indexval1+"&formcode="+$('#formdetailcode').val());
	     	  		 
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("savepurchaseReqforqout");
	        
	        $("#docno").prop("disabled", false);
	        
	        
	  var branch=$('#brchName').val();
	var win= window.open(reurl[0]+"printpurchaseReqforqout?docno="+document.getElementById("masterdoc_no").value+"&branch="+branch,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#purchaseReqforqout').validate({
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
	 
/* 	
	var  roundOf=document.getElementById('roundOf').value;
	
	 if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
 	   {
		 netval=parseFloat(netval)+parseFloat(roundOf);
 	   }
	
		
		funRoundAmt(descvalue,"descountVal");
		funRoundAmt(netval,"netTotaldown");
		
		var aa;
		 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
		   	            	   {
		   	               
		   	               aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
		   	            	   }
		   	               else
		   	            	   {
		   	            	    aa=document.getElementById("netTotaldown").value;
		   	            	   }
		        
		
		

	    funRoundAmt(aa,"orderValue"); */
		
/* 	
	alert("descvalue"+descvalue);
	
	alert("netval"+netval);
	 */



	
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
				
				var aa;
				 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
				   	            	   {
				   	               
				   	               aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
				   	            	   }
				   	               else
				   	            	   {
				   	            	    aa=document.getElementById("netTotaldown").value;
				   	            	   }
				        
				
				

			    funRoundAmt(aa,"orderValue");
	
	
	
	
	}
	
	
	
	
function funvalcalcu()
	{
	
	
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descountVal=document.getElementById('descountVal').value;
 
	var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
 
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	funcalcu();
	}
	
	
	
 function roundval()
{
		//var  netTotaldown=document.getElementById('netTotaldown').value;
	    var roundOf=document.getElementById('roundOf').value;
 	 
 
 if(roundOf!="")
 {
	  var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	  
	  var  netTotaldown=summaryData.sum.replace(/,/g,'');
	  
		var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
		
 
		 
		funRoundAmt(netval,"netTotaldown"); 
		
  	       var ordertotal="0";
       	  
       	  var nettotalval="0";
		  if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
     	   {
     	   
   
     nettotalval=parseFloat(document.getElementById("nettotal").value);
     	   }
        
        
       
       ordertotal=parseFloat(nettotalval)+parseFloat(document.getElementById("netTotaldown").value);
     	   
  
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
		 }
	 
	 else
		 {
		 
		  $('#rrefno').attr('disabled', false);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("reqmasterdocno").value="";
			 $("#serviecGrid").jqxGrid('clear');
			 $("#serviecGrid").jqxGrid('addrow', null, {});
		  
		 
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
<form id="purchaseReqforqout" action="savepurchaseReqforqout" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<div class='hidden-scrollbar'>
	<fieldset>
	
	       <table width="100%"  >
  <tr> 
    <td width="85" align="right">Date</td>  
    <td width="104"><div id="date" name="date" value='<s:property value="date"/>'></div>
    
    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
    </td>
   <td align="right" width="119">Ref No</td>
    <td width="144"><input type="text" name="refno" id="refno" style="width:80%;" value='<s:property value="refno"/>'></td>
    <td align="right" width="231">&nbsp;</td>
    <td width="155" >
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Curr
          <select name="cmbcurr" id="cmbcurr" style="width:41%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select></td> 
    <td width="205">Rate <input type="text" name="currate" style="width:70%;" id="currate" value='<s:property value="currate"/>'> </td>   
     
    <td width="101" align="right">Doc No</td>
    <td width="144"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>
 
  <tr>
       <td width="85" align="right">Vendor</td> 
    <td colspan="4" align="left"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
 
    <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' style="width:20%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:70%;"></td>
    <td align="left" width="155">Ref Type
      <select name="reftype" id="reftype" style="width:41%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno()">
    <option value="DIR">DIR</option>
      <option value="CEQ">CEQ</option>
      <option value="PR">PR</option>
    </select></td>
    <td width="205" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="text" name="rrefno" id="rrefno" style="width:70%;" placeholder="Press F3 To Search"  value='<s:property value="rrefno"/>'  onKeyDown="getrefno(event);"></td>

    <td width="101" align="right">&nbsp;</td>
    <td width="144" align="left"></td>
 
    
  </tr>
  
    <tr>
    <td align="right"  width="85">Description</td>
    <td colspan="6" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:96%;">
    
    </td><td colspan="2"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td></tr>
 
   
</table>
	
<%-- <table width="100%">
  <tr> 
    <td width="39" align="right">Date</td>  
    <td width="128"><div id="date" name="date" value='<s:property value="date"/>'></div>
    
    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
    </td>
   <td align="right" width="139">Ref No</td>
    <td width="152"><input type="text" name="refno" id="refno" style="width:71%;" value='<s:property value="refno"/>'></td>
    <td align="right" width="99">Ref Type</td>
    <td width="110" >
        <select name="reftype" id="reftype" style="width:41%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno()"> 
      <option value="DIR">DIR</option>
      <option value="CEQ">CEQ</option>
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
 
                              
    <table width="100%"  >
    <tr>
    <td align="right"  width="4.7%">Description</td>
    <td colspan="6"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:73%;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td></tr>
</table>
 --%>
  </fieldset>
 
   <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
   <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' /> 
    
    
     <fieldset>   
    <div id="sevdesc" ><jsp:include page="serviecgrid.jsp"></jsp:include></div>  
  </fieldset>
    
 

<fieldset>
 <legend>Shipping Details</legend>
<table width="100%"  >

<tr>

<td width="50%">
 <fieldset>
<table  width="100%"   >   

<tr><td align="right" width="15%">Name</td><td colspan="3"><input type="text" id="shipto" name="shipto" style="width:91%;" placeholder="Press F3 To Search"  value='<s:property value="shipto"/>' onkeydown="getshipdetails(event);" ></td></tr>
<tr><td align="right">Shipping Address</td><td colspan="3"><input type="text" id="shipaddress" name="shipaddress"  style="width:91%;"  value='<s:property value="shipaddress"/>' ></td></tr>
<tr><td align="right">Contact Person</td><td colspan="3"><input type="text" id="contactperson" name="contactperson"  style="width:91%;"    value='<s:property value="contactperson"/>' ></td></tr>
<tr><td align="right">Telephone</td><td><input type="text" id="shiptelephone" name="shiptelephone"   style="width:90%;"   value='<s:property value="shiptelephone"/>' ></td>
<td align="right">MOB</td><td><input type="text" id="shipmob" name="shipmob"  style="width:80%;"  value='<s:property value="shipmob"/>' ></td>
</tr>
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

<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >&nbsp;</label></td><td><input type="hidden" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
</tr>

</table>

<fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset>





<input type="hidden" id="chkdiscountval" name="chkdiscountval"  value='<s:property value="chkdiscountval"/>'/>      

<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>  
           <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
             <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
             
             <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
             
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
             
             
                         <input type="hidden" id="termsgridlength" name="termsgridlength"  value='<s:property value="termsgridlength"/>'/>
                         
                         
                                    <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
 
                  <input type="hidden" id="shipdocno" name="shipdocno"  value='<s:property value="shipdocno"/>'/>
                                            
                                              <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght"  value='<s:property value="shipdatagridlenght"/>'/>
 
           
 <input type="text" hidden="true" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;">
<input type="checkbox" hidden="true" value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" >
 <input type="text" hidden="true" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;">
 <button type="button" hidden="true" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
 
 <input type="text" hidden="true" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;">

<input type="hidden" hidden="true" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;">

<input type="text" hidden="true" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  style="width:51%;text-align: right;">
<input type="text" hidden="true" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>'/>
     
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
	<div id="tremwndow">
	   <div ></div>
	</div>
	
	

</body>
</html>