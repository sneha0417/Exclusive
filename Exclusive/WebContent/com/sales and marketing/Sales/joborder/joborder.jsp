 <%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">

 $(document).ready(function () {
	 $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#customerDetailsWindow').jqxWindow('close'); 
     $('#brandsearchwndows').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
     $('#brandsearchwndows').jqxWindow('close'); 
     $('#modelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
     $('#modelsearchwndows').jqxWindow('close');
     
     $('#submodelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sub Model Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
     $('#submodelsearchwndows').jqxWindow('close');
     
     $('#yomsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Yom Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
     $('#yomsearchwndows').jqxWindow('close');

     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close'); 
 
	 $('#sidesearchwndow1').jqxWindow({width: '60%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: '  Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#sidesearchwndow1').jqxWindow('close'); 
     
    
	 $('#spec1window').jqxWindow({ width: '30%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Bed Size Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#spec1window').jqxWindow('close');
	   $('#spec2window').jqxWindow({ width: '32%',height: '62%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Engin Size Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
	   $('#spec2window').jqxWindow('close');
	   $('#spec3window').jqxWindow({ width: '32%',height: '62%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Cabin Size Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
	   $('#spec3window').jqxWindow('close');
     
    $("#btnEdit").attr('disabled', true );
     
     $('#txtclient').dblclick(function(){
 
	    	if($('#mode').val()!= "view")
	    		{
	    	 
		  	  accountSearchContent('clientINgridsearch.jsp?');
	    		}
	  });
   	 
	     $('#brand').dblclick(function(){
	    	 
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 
	    	
	    	 	if($('#mode').val()!= "view")
	    		{
	    	
	  	    $('#brandsearchwndows').jqxWindow('open');
	   
	  	  brandContent('brandSearch.jsp?', $('#brandsearchwndows')); 
      			   }
       	   
    });
     
	     
	     
      
      $('#yom').dblclick(function(){
    	  
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 
    	  if($('#mode').val()== "view")
  		{
    		  return false;
  		}
  	
    	  
    	  
	  	    $('#yomsearchwndows').jqxWindow('open');
	   
	  	  yomContent('yomsearch.jsp?', $('#yomsearchwndows')); 
   			   
   	  
  });
   	$('#model').dblclick(function(){
   		
   	 
   	 if(document.getElementById("r2").checked==true)
			{
   		 return 0;
			}
   	 
  	  if($('#mode').val()== "view")
		{
  		  return false;
		}
	
 		 
  	    $('#modelsearchwndows').jqxWindow('open');
   
  	  modelContent('modelsearch.jsp?brandid='+document.getElementById("brandid").value, $('#modelsearchwndows')); 
    			  
           });
   	
   	
	   $('#submodel').dblclick(function(){
			
		   
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 

	    	  if($('#mode').val()== "view")
	  		{
	    		  return false;
	  		}
	  	
			var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			/* 	if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 } */
			
			  $('#submodelsearchwndows').jqxWindow('open');
			  $('#submodelsearchwndows').jqxWindow('focus');
			  subModelSearchContent('SubModelSearch.jsp?modelid='+modelid+'&brandid='+brandid, $('#submodelsearchwndows'));

	   });

	   $('#bsize').dblclick(function(){

		   
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 

	    	  if($('#mode').val()== "view")
	  		{
	    		  return false;
	  		}
	  	
		   var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			var submodelid=$('#submodelid').val().trim();
/* 			
			if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 } */
		   
		   
			$('#spec1window').jqxWindow('open');
			$('#spec1window').jqxWindow('focus');
			 spec1SearchContent('spec1Search1.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec1window'));
		   });

 
	   
	   $('#esize').dblclick(function(){
		   
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 
	    	  if($('#mode').val()== "view")
	  		{
	    		  return false;
	  		}
	  	
		   var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			var submodelid=$('#submodelid').val().trim();
			
			/* if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 } */
		   
		   
		   $('#spec2window').jqxWindow('open');
			$('#spec2window').jqxWindow('focus');
			 spec2SearchContent('spec2Search2.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec2window'));
		   });

	   
	   
	 
	   $('#csize').dblclick(function(){

		   
		   
	    	 if(document.getElementById("r2").checked==true)
				{
	    		 return 0;
				}
	    	 
	    	  if($('#mode').val()== "view")
	  		{
	    		  return false;
	  		}
	  	
		   var brandid=$('#brandid').val().trim();
		   var modelid=$('#modelid').val().trim();
		   var submodelid=$('#submodelid').val().trim();
			
	/* 		if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }  */
			$('#spec3window').jqxWindow('open');
			$('#spec3window').jqxWindow('focus');
			 spec3SearchContent('spec3Search3.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec3window'));

	   });
	   
	   
             
	});
 
 
 function getbed(event){     
	 var x= event.keyCode;
	

		
	 if(x==114){
		 
    	 if(document.getElementById("r2").checked==true)
			{
    		 return 0;
			}
    	 
   	  if($('#mode').val()== "view")
 		{
   		  return false;
 		}
 	
		  var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			var submodelid=$('#submodelid').val().trim();
			
	/* 		if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		    */
		   
			$('#spec1window').jqxWindow('open');
			$('#spec1window').jqxWindow('focus');
			 spec1SearchContent('spec1Search1.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec1window'));	 
	 }
	 else{
		 }
		 
	 }  
	 
	 
function geteng(event){        
	 var x= event.keyCode;
	

		
	 if(x==114){
		 
    	 if(document.getElementById("r2").checked==true)
			{
    		 return 0;
			}
    	 
   	  if($('#mode').val()== "view")
 		{
   		  return false;
 		}
 	
		   var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			var submodelid=$('#submodelid').val().trim();
			
			/* if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		    */
		   
		   $('#spec2window').jqxWindow('open');
			$('#spec2window').jqxWindow('focus');
			 spec2SearchContent('spec2Search2.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec2window'));
	 
	 }
	 else{
		 }
		 
	 }  
	 

function getcab(event){
	 var x= event.keyCode;
	
	 
	 if(document.getElementById("r2").checked==true)
		{
		 return 0;
		}
	 
	  if($('#mode').val()== "view")
		{
		  return false;
		}
	
		
	 if(x==114){
		 

		   var brandid=$('#brandid').val().trim();
		   var modelid=$('#modelid').val().trim();
		   var submodelid=$('#submodelid').val().trim();
			/* 
			if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 }
		   
			if(submodelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 } */
			$('#spec3window').jqxWindow('open');
			$('#spec3window').jqxWindow('focus');
			 spec3SearchContent('spec3Search3.jsp?modelid='+modelid+'&brandid='+brandid+"&submodelid="+submodelid, $('#spec3window'));
	 }
	 else{
		 }
		 
	 }   
 function getsubmodel(event){
	 var x= event.keyCode;
	
	 
	 if(document.getElementById("r2").checked==true)
		{
		 return 0;
		}
	 
	  if($('#mode').val()== "view")
		{
		  return false;
		}
	
		
	 if(x==114){
			 
			var brandid=$('#brandid').val().trim();
			var modelid=$('#modelid').val().trim();
			
			/*	if(brandid==""){
				 $.messager.alert('Message','Select Brand','warning');
				 
				 return 0;
			 }
			
			if(modelid==""){
				 $.messager.alert('Message','Select Model','warning');
				 
				 return 0;
			 } */
			
			  $('#submodelsearchwndows').jqxWindow('open');
			  $('#submodelsearchwndows').jqxWindow('focus');
			  subModelSearchContent('SubModelSearch.jsp?modelid='+modelid+'&brandid='+brandid, $('#submodelsearchwndows')); }
	 else{
		 }
		 
	 }  
 

 function spec1SearchContent(url) {
   //alert(url);
     $.get(url).done(function (data) {
 //alert(data);
   $('#spec1window').jqxWindow('setContent', data);

 }); 
 }

 function spec2SearchContent(url) {
 	  //alert(url);
 	    $.get(url).done(function (data) {
 	//alert(data);
 	  $('#spec2window').jqxWindow('setContent', data);

 	}); 
 	}
 	
 function spec3SearchContent(url) {
 	  //alert(url);
 	    $.get(url).done(function (data) {
 	//alert(data);
 	  $('#spec3window').jqxWindow('setContent', data);

 	}); 
 	}
	 
 function subModelSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#submodelsearchwndows').jqxWindow('setContent', data);

	}); 
	}
 
 
 function searchveh()
 {
	if(document.getElementById("clientid").value=="")
		{
		
	 
				document.getElementById("errormsg").innerText=" Customer is Mandatory";
				
				document.getElementById("clientid").focus();
		
		return false;
		}
	else
		{
		hidemsg();
		}
	  
	  sideSearchContent('vehdetails.jsp?cldocno='+document.getElementById("clientid").value, $('#sidesearchwndow1'));  
 	}
 
 
 function sideSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#sidesearchwndow1').jqxWindow('open');
  		$('#sidesearchwndow1').jqxWindow('setContent', data);
  
  	}); 
  	} 
 
 function productSearchContent(url) {
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
 
 
 
 function getyomdetails(event){
  	 var x= event.keyCode;
  	 if(x==114){
  		 
  	  $('#yomsearchwndows').jqxWindow('open');
  
  	yomContent('yomsearch.jsp?', $('#yomsearchwndows'));  
    			   }
  
  	 }  
	  function yomContent(url) {
        //alert(url);
           $.get(url).done(function (data) {
 //alert(data);
         $('#yomsearchwndows').jqxWindow('setContent', data);

	}); 
     	}
	  
function getbranddetails(event){
  	 var x= event.keyCode;
  	 if(x==114){
  		 
  	  $('#brandsearchwndows').jqxWindow('open');
  
  	brandContent('brandSearch.jsp?', $('#brandsearchwndows'));  
    	 
  		 
  		}
  	  
  	 }  
	  function brandContent(url) {
        //alert(url);
           $.get(url).done(function (data) {
 //alert(data);
         $('#brandsearchwndows').jqxWindow('setContent', data);

	}); 
     	} 
 
 
	 	function getmodeldetails(event){
	        var x= event.keyCode;
	            if(x==114){
	            	 
	        $('#modelsearchwndows').jqxWindow('open');

	            modelContent('modelsearch.jsp?brandid='+document.getElementById("brandid").value, $('#modelsearchwndows')); 
	         			 
	            }
	                   }  
	 	function modelContent(url) {
		    //alert(url);
		       $.get(url).done(function (data) {
		//alert(data);
		     $('#modelsearchwndows').jqxWindow('setContent', data);
		
		            }); 
		 	} 
 
 
 
 
 
 
 
 
 
 function getaccountdetails(event){
  	 var x= event.keyCode;
    	
  	if($('#mode').val()!="view")
  		{
  		
  	 if(x==114){
  	 
  	 accountSearchContent('clientINgridsearch.jsp?');    }
  	 else{
  		 }
  		}
  	 }  
 	  function accountSearchContent(url) {
        //alert(url);
         $('#customerDetailsWindow').jqxWindow('open');
           $.get(url).done(function (data) {
 //alert(data);
         $('#customerDetailsWindow').jqxWindow('setContent', data);

 	}); 
     	}	  
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
		
	}
	function funReadOnly(){
	
		$('#frmjoborder input').attr('readonly', true );

		$('#docno').attr('readonly', true);
		$("#jqxInvoiceGrid").jqxGrid({ disabled: true});
		
		
		$('#searchbtn').attr('disabled', true);
		$('#r1').attr('disabled', true);
		$('#r2').attr('disabled', true);
		
		
		
	}
	
	function radioclick()
	{
		
		if(document.getElementById("r1").checked==true)
			{
			$('#searchbtn').attr('disabled', true);
			
			document.getElementById("typesave").value=1;
			
			 document.getElementById("regno").value="";
			 
			 $('#regno').attr('readonly', false);
			 
			 document.getElementById("yom").value="";
			 document.getElementById("yomid").value="";
			 
			 document.getElementById("brand").value="";
			 document.getElementById("brandid").value="";
			 
			 document.getElementById("model").value="";
			 document.getElementById("modelid").value="";
			 
			 document.getElementById("submodel").value="";
			 document.getElementById("submodelid").value="";
			 
			 document.getElementById("esize").value="";
			 document.getElementById("esizeid").value="";
			 
			 document.getElementById("bsize").value="";
			 document.getElementById("bsizeid").value="";
			 
			 document.getElementById("csize").value="";
			 document.getElementById("csizeid").value="";
		    	 
		    /* 	 regno brand model submodel yom esize  bsize  csize esizeid bsizeid csizeid brandid modelid submodelid yomid */
		    	 
			
			
			}
		else if(document.getElementById("r2").checked==true)
			{
			
			
			$('#searchbtn').attr('disabled', false);
			
			document.getElementById("typesave").value=2;
			
			 document.getElementById("regno").value="";
			 
			 $('#regno').attr('readonly', true);
			 
			 document.getElementById("yom").value="";
			 document.getElementById("yomid").value="";  
			 
			 document.getElementById("brand").value="";
			 document.getElementById("brandid").value="";
			 
			 document.getElementById("model").value="";
			 document.getElementById("modelid").value="";
			 
			 document.getElementById("submodel").value="";
			 document.getElementById("submodelid").value="";
			 
			 document.getElementById("esize").value="";
			 document.getElementById("esizeid").value="";
			 
			 document.getElementById("bsize").value="";
			 document.getElementById("bsizeid").value="";
			 
			 document.getElementById("csize").value="";
			 document.getElementById("csizeid").value="";

			}
		
	}
	
	
	
	function funRemoveReadOnly(){
		
		$('#frmjoborder input').attr('readonly', false );
		$("#jqxInvoiceGrid").jqxGrid({ disabled: false});
	 
		$('#searchbtn').attr('disabled', true);
		$('#r1').attr('disabled', false);
		$('#r2').attr('disabled', false);
		
		document.getElementById("r1").checked=true;
		
		
		
		$('#txtclientmob').attr('readonly', true);
		
		$('#docno').attr('readonly', true);
	
		$('#txtclient').attr('readonly', true);
		$('#txtclientdet').attr('readonly', true);
		$('#regno').attr('readonly', false);
		$('#brand').attr('readonly', true);
		$('#model').attr('readonly', true);
		$('#yom').attr('readonly', true);
		
		$('#submodel').attr('readonly', true);
		
		
		$('#esize').attr('readonly', true);
		$('#csize').attr('readonly', true);
		$('#bsize').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			
			
			$("#jqxInvoiceGrid").jqxGrid('clear'); 
			$("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
			document.getElementById("typesave").value=1;
			
			
			
		}
		
		if ($("#mode").val() == "E") {
		
		
		  var docno=$('#docno').val();
			 
		   
		  if(docno>0){    
		  $("#invoiceDiv").load("jobGrid.jsp?docno="+docno);
		  }
		
		}
		
		
	}


	       
	       
	function funNotify(){

			
		 
	
		   var txtclient=document.getElementById("txtclient").value;
			
			if(txtclient=="")
				{
				document.getElementById("errormsg").innerText=" Search Client";
				document.getElementById("txtclient").focus();  
				return 0;
				}
			else{
				 document.getElementById("errormsg").innerText="";
			}
			 
			
			
			
			   var regno=document.getElementById("regno").value;
				
				if(regno=="")
					{
					document.getElementById("errormsg").innerText=" Reg No is mandatory";
					document.getElementById("regno").focus();  
					return 0;
					}
				   var brand=document.getElementById("brand").value;
					
					if(brand=="")
						{
						document.getElementById("errormsg").innerText=" Search Brand";
						document.getElementById("brand").focus();  
						return 0;
						}
					   var model=document.getElementById("model").value;
						
						if(model=="")
							{
							document.getElementById("errormsg").innerText=" Search Model";
							document.getElementById("model").focus();  
							return 0;
							}
						
						
						
						 var submodel=document.getElementById("submodel").value;
							
							if(submodel=="")
								{
								document.getElementById("errormsg").innerText=" Search Sub Model";
								document.getElementById("submodel").focus();  
								return 0;
								}
				
						
						 var yom=document.getElementById("yom").value;
							
							if(yom=="")
								{
								document.getElementById("errormsg").innerText=" Search YOM";
								document.getElementById("yom").focus();  
								return 0;
								}
				
		
				
				 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
				
				  $('#gridlength').val(rows.length);	
				
			 for(var i=0 ; i < rows.length ; i++){ 
				  
				 
				  newTextBox = $(document.createElement("input"))
				     .attr("type", "dil")
				     .attr("id", "prodg"+i)
				     .attr("name", "prodg"+i)
				     .attr("hidden", "true");
				
				 
				  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+
							 rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+
							 rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].locid+"::"+rows[i].fixing+"::");  
				 newTextBox.appendTo('form'); 
					    
				 }
				 
				
      return 1;
	} 

	function funChkButton() {
		
	 
	}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp'); 
	}

		
	function funFocus(){
		 
		 
	   
	   
	}

	function chkfoc()
    {
     
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
       var item = items.split('##');
			var foc  = item[0];
			var kg = item[1];
       if(parseInt(foc)>0)
        {
      
        
        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'foc');
     
        
        
         }
           else
       {
       
            $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'foc');
       
       }
       
        if(parseInt(kg)>0)
       {
     
       
       $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'kgprice');
       $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'totwtkg');
    
       
       
        }
          else
      {
      
           $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'kgprice');
           $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'totwtkg');
      
      } 
       
       
       
        }}
    x.open("GET","checkfoc.jsp",true);
  x.send();
  
       
         
     
    }
	 
	 
	function setValues() {
	
	
		 
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
	    }
		  var docno=$('#masterdoc_no').val();
		 
		   
		  if(docno>0){    
		  $("#invoiceDiv").load("jobGrid.jsp?docno="+docno);
		  }
	
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		
		
		  if(document.getElementById("typesave").value==1)
		  {
		  document.getElementById("r1").checked = true;
		  document.getElementById("r1").value=1;
		  document.getElementById("r2").checked = false;
		  document.getElementById("r2").value=0;
		   
		  }
  if(document.getElementById("typesave").value==2)
		  {
	  document.getElementById("r2").checked = true;
	  document.getElementById("r2").value=1;
		  document.getElementById("r1").checked = false;
		  document.getElementById("r1").value=0;
	 
		  }
		
		
	}
	
	function hidemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
	}
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveJOD");
	        
	             
	        
	  
	var win= window.open(reurl[0]+"printjob?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
  
</script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
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




.btns {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 0;
  -moz-border-radius: 0;
  border-radius: 0px;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  padding: 2px 3px 2px 3px;
  border: solid #1f628d 0px;
  text-decoration: none;
}

.btns:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmjoborder" action="saveJOD" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/><br/>
<fieldset>
 

 <table width="100%">
 <tr>
 <td  align="center" > 
    
        <input type="radio" id="r1" name="new" value='<s:property value="0"/>' onchange="radioclick();" onclick="$(this).attr('value', this.checked ? 1 : 0)" >New &nbsp;  &nbsp;
     <input type="radio" id="r2" name="new" value='<s:property value="0"/>' onchange="radioclick();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Exist
     </td > 
     <td width="50%">
     <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
    </td>
 </tr>
 
 </table>
 
 
 
 
 <table  width="100%"  >  
 

<tr>  
    <td width="9%" align="right">Customer</td>  
    <td width="12%"><input type="text" id="txtclient" name="txtclient" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td colspan="6"><!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  -->    
     <input type="text" id="txtclientdet" name="txtclientdet" style="width:66%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MOB&nbsp;
    <input type="text" id="txtclientmob" name="txtclientmob"  style="width:20%;" value='<s:property value="txtclientmob"/>'   tabindex="-1"/>
  
    <td   width="9%"> 
    
 &nbsp;  &nbsp; 
 
    
    </td>
<td align="left" width="24%">Doc No  <input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>' /></td>
 </tr>
<tr>
 <td  align="right"><input type="button" class="btns" id="searchbtn" onclick="searchveh()" value="Search">&nbsp;  &nbsp; &nbsp;
 Reg No</td><td><input type="text" id="regno" name="regno" style="width:80%;" value='<s:property value="regno"/>' /></td>
       
    <td  align="right"  width="3%" >Brand</td>
    <td width="15%">
      <input type="text" id="brand" name="brand"  style="width:100%;" value='<s:property value="brand"/>' placeholder="Press F3 to Search"  onkeydown="getbranddetails(event);"/></td> 
    <td width="3%" align="right">Model</td>
    <td width="11%">
      <input type="text" id="model" name="model"  style="width:100%;" value='<s:property value="model"/>' placeholder="Press F3 to Search"  onkeydown="getmodeldetails(event);"   /></td>    <!-- onkeydown="getmodeldetails(event);" onfocus="searchmodel();" -->                     
    <td width="4%" align="right">Sub Model</td>
    <td width="13%" >
      <input type="text" id="submodel" name="submodel" style="width:80%;" value='<s:property value="submodel"/>' placeholder="Press F3 to Search"  onkeydown="getsubmodel(event);"/></td> <!--onkeydown="getyomdetails(event);" -->
   
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <tr>
  <td  align="right">YOM</td>  
    <td  >
      <input type="text" id="yom" name="yom" style="width:80%;" value='<s:property value="yom"/>' placeholder="Press F3 to Search"  onkeydown="getyomdetails(event);"/></td> <!--onkeydown="getyomdetails(event);" -->
   
    <td  align="right"  width="3%" >EngineSize</td>
    <td width="15%">
      <input type="text" id="esize" name="esize"  style="width:100%;" value='<s:property value="esize"/>' placeholder="Press F3 to Search"  onkeydown="geteng(event);"/></td>   
    <td width="3%" align="right">BedSize</td>
    <td width="11%">
      <input type="text" id="bsize" name="bsize"  style="width:100%;" value='<s:property value="bsize"/>' placeholder="Press F3 to Search"  onkeydown="getbed(event);"   /></td>    <!-- onkeydown="getmodeldetails(event);" onfocus="searchmodel();" -->                     
    <td width="4%" align="right">CabinSize</td>
    <td width="13%" >
      <input type="text" id="csize" name="csize" style="width:80%;" value='<s:property value="csize"/>' placeholder="Press F3 to Search"  onkeydown="getcab(event);"/></td> <!--onkeydown="getyomdetails(event);" -->
   
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 
</table>
 
</fieldset>
<br>
    <fieldset>
<div id="invoiceDiv"> <jsp:include page="jobGrid.jsp"></jsp:include> </div> 
</fieldset>

  <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/> 
  
  
  	 <input type="hidden" id="typesave" name="typesave" value='<s:property value="typesave"/>'/> 
  
	
	 <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/> 
	 
	  <input type="hidden" id="esizeid" name="esizeid" value='<s:property value="esizeid"/>'/> 
	   <input type="hidden" id="bsizeid" name="bsizeid" value='<s:property value="bsizeid"/>'/> 
	    <input type="hidden" id="csizeid" name="csizeid" value='<s:property value="csizeid"/>'/> 
	 
	 
 
   <input type="hidden" id="brandid" name="brandid" value='<s:property value="brandid"/>'/> 
 <input type="hidden" id="modelid" name="modelid" value='<s:property value="modelid"/>'/>
 
  <input type="hidden" id="submodelid" name="submodelid" value='<s:property value="submodelid"/>'/>
 
 
 
 <input type="hidden" id="yomid" name="yomid" value='<s:property value="yomid"/>'/>
   
 
   <input type="hidden" name="acno" id="acno" value='<s:property value="acno"/>' >  
      <input type="hidden" id="accname" name="accname" value='<s:property value="accname"/>'  >
      
      <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'  >
        <input type="hidden" id="desc1" name="desc1" value='<s:property value="desc1"/>'  >
        
        
             <input type="hidden" id="refdocnos" name="refdocnos" value='<s:property value="refdocnos"/>'  >




<input type="hidden" id="gridlength" name="gridlength"/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>
<div id="spec1window">
<div></div>
</div>
<div id="spec2window">
<div></div>
</div>
<div id="spec3window">
<div></div>
</div>
<div id="sidesearchwndow">
	<div></div>
</div>  
<div id="sidesearchwndow1">
	<div></div>
</div>  
  <div id="customerDetailsWindow">
	   <div ></div>
	</div>
	
	<div id="brandsearchwndows">
   <div ></div>
</div>
<div id="modelsearchwndows">
   <div ></div>
</div>

<div id="submodelsearchwndows">
   <div ></div>
</div>
<div id="yomsearchwndows">
   <div ></div>
</div>
</div>
</body>
</html>