 <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>

.myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #007dc1), color-stop(1, #0061a7));
	background:-moz-linear-gradient(top, #007dc1 5%, #0061a7 100%);
	background:-webkit-linear-gradient(top, #007dc1 5%, #0061a7 100%);
	background:-o-linear-gradient(top, #007dc1 5%, #0061a7 100%);
	background:-ms-linear-gradient(top, #007dc1 5%, #0061a7 100%);
	background:linear-gradient(to bottom, #007dc1 5%, #0061a7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#007dc1', endColorstr='#0061a7',GradientType=0);
	background-color:#007dc1;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-radius:5px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 8px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0061a7), color-stop(1, #007dc1));
	background:-moz-linear-gradient(top, #0061a7 5%, #007dc1 100%);
	background:-webkit-linear-gradient(top, #0061a7 5%, #007dc1 100%);
	background:-o-linear-gradient(top, #0061a7 5%, #007dc1 100%);
	background:-ms-linear-gradient(top, #0061a7 5%, #007dc1 100%);
	background:linear-gradient(to bottom, #0061a7 5%, #007dc1 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0061a7', endColorstr='#007dc1',GradientType=0);
	background-color:#0061a7;
}
.myButtons:active {
	position:relative;
	top:1px;
}

   
</style>
<script type="text/javascript">
	 $(document).ready(function() {
		 $('#btnvaluechange').hide();
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 refChange();
		 getCurrencyIds();
		 //getPriceGroup();
		 chkfoc();
		 $('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close'); 
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
			
			 $('#locationwindow').jqxWindow({
					width : '25%',
					height : '58%',
					maxHeight : '70%',
					maxWidth : '45%',
					title : 'Location Search',
					position : {
						x : 420,
						y : 87
					},
					theme : 'energyblue',
					showCloseButton : true,
					keyboardCloseKey : 27
				});
				$('#locationwindow').jqxWindow('close');
			
			$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#searchwndow').jqxWindow('close');  
			 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
			     
			 	$('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
					x : 420,
		         	y : 87
				}, keyboardCloseKey: 27});
			    $('#tremwndow').jqxWindow('close');
	 
		 
		 
		 $('#txtclient').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
			  	  CustomerSearchContent('clientINgridsearch.jsp');
		    		}
		  });
		 
		 $('#txtsalesperson').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
		    		salespersonSearchContent('salesPersonSearch.jsp');
		    		}
		  });
		 

		 $('#shipto').dblclick(function(){
	         
		     	if($('#mode').val()!= "view")
		     		{
		     	
		     		
		 	  	  
		 	  	
		 	  	   shipSearchContent('shipmasterSearch.jsp?');
		     		}
		   });  
		 $('#txtlocation').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
		    		$('#locationwindow').jqxWindow('open');
		    		locationSearchContent('locationSearch.jsp');  
		    		}
		  });
		 
		 
		 $('#rrefno').dblclick(function(){
			   
			 var clientid=document.getElementById("clientid").value;
				
				if(clientid>0){
					
					
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
					
					
					document.getElementById("errormsg").innerText="";
					 $('#refnosearchwindow').jqxWindow('open');
					  	
				  	  refsearchContent('refnosearch.jsp');
					
				}
				else{
					document.getElementById("errormsg").innerText="Select a Customer";
					document.getElementById("txtclient").focus();
					
					return 0;
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
		    //alert(url);
		      $('#customerDetailsWindow').jqxWindow('open');
		       $.get(url).done(function (data) {
		//alert(data);
		     $('#customerDetailsWindow').jqxWindow('setContent', data);

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

	function CustomerSearchContent(url) {
		$('#customerDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#customerDetailsWindow').jqxWindow('setContent', data);
		$('#customerDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
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
	
	function getLocation(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		locationSearchContent('locationSearch.jsp');  	 }
	    	 else{
	   		 }
	          	 }
		
		function locationSearchContent(url) {
			$('#locationwindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#locationwindow').jqxWindow('setContent', data);
				$('#locationwindow').jqxWindow('bringToFront');
			});
		}
	
	
	
	 function funReadOnly(){
		 
			$('#frmdeliveryNote input').attr('readonly', true );
			$('#frmdeliveryNote select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxDeliveryNote").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
			$('#btnvaluechange').hide();
			//$("#jqxserviceGrid").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		 
			if ($("#mode").val() == "A") {
		 gridLoad();
			}
			 chkmultiqty();
		 document.getElementById("editdata").value="";
			$('#frmdeliveryNote input').attr('readonly', false );
			$('#frmdeliveryNote select').attr('disabled', false);
			
			$('#txtclient').attr('readonly', true );
			$('#rrefno').attr('readonly', true );
			$('#txtlocation').attr('readonly', true );
			$('#txtsalesperson').attr('readonly', true );
			$('#txtproductamt').attr('readonly', true );
			$('#txtdiscount').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			
			$('#orderValue').attr('readonly', true);
			
			 $('#shipto').attr('readonly', true);
			 $('#shipaddress').attr('readonly', true);
			 $('#contactperson').attr('readonly', true);
			 $('#shiptelephone').attr('readonly', true);
			 $('#shipmob').attr('readonly', true);
			 
			 $('#shipemail').attr('readonly', true);
			 $('#shipfax').attr('readonly', true);
			 
				
			 $("#shipdata").jqxGrid({ disabled: false});
			
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxDeliveryNote").jqxGrid({ disabled: false}); 
			$("#jqxTerms").jqxGrid({ disabled: false});
			if ($("#mode").val() == "E") {
				 
   			 
				 $('#btnvaluechange').show();
		  	 
				$("#jqxDeliveryNote").jqxGrid({ disabled: true});
				 
				$("#jqxTerms").jqxGrid({ disabled: true});
				
				$("#shipdata").jqxGrid({ disabled: true});
				
			 
		 
   			    
			  }
			
			if ($("#mode").val() == "A") {
				$('#rrefno').attr('disabled', true );
				$("#txtproductamt").val("0.0");
				$("#txtdiscount").val("0.0");
				$("#txtnettotal").val("0.0");
				$("#descPercentage").val("0.0");
				$("#prodsearchtype").val("0");
				$("#orderValue").val("0.0");
				$("#roundOf").val("0.0");
				$("#nettotal").val("0.0");
				getCurrencyIds();
				//getPriceGroup();
				$('#date').val(new Date());
				$("#jqxTerms").jqxGrid({ disabled: false});
				//$("#jqxserviceGrid").jqxGrid({ disabled: false});
				//$("#jqxserviceGrid").jqxGrid('clear'); 
				//$("#jqxserviceGrid").jqxGrid('addrow', null, {});
				$("#jqxDeliveryNote").jqxGrid('clear'); 
				$("#jqxDeliveryNote").jqxGrid('addrow', null, {});
				
				$("#shipdata").jqxGrid('clear'); 
				$("#shipdata").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmdeliveryNote').validate({
	                rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true}
	                },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"}
	                 }
	        });});
	   
	   
	   function checkqty()
	   {
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
			var rows = $("#jqxDeliveryNote").jqxGrid('getrows');
			var list = new Array();
			 
		   for(var i=0 ; i < rows.length; i++){
			 
			   if(parseInt(rows[i].prodoc)>0)  
			   { 
			 
			   list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].oldqty);
			 
			   }
		   }
				 
		  ajaxcall(list);
		   
	   }
		   
 
		 function ajaxcall(list){
			 var branch=document.getElementById("brchName").value;
			 var location=document.getElementById("locationid").value;
			 var mode=$('#mode').val();
			 	
			 	var x=new XMLHttpRequest();
			 	x.onreadystatechange=function(){
			 		if (x.readyState==4 && x.status==200)
			 			{
			 			 var items= x.responseText.trim();
			 	 
			 		 var temps1="";
			 		 var temps2="";
			 		    items = items.split('###');
			 		    
			 		    
				           var temp1=items[0];
				           var temp2=items[1];
				          
				       
				           if(temp1.indexOf(",")>=0){
				    
				 
				        	 
					            for ( var j = 0; j < temp1.length; j++) {
					            	
					             
					            var	test=temp1.split(",");
					            var test2=temp2.split(",");
					      
					         
					            	var rows = $("#jqxDeliveryNote").jqxGrid('getrows');
					    		 
					    			 
					    		   for(var i=0 ; i < rows.length ; i++){
					    			   
					    			   if(parseInt(test[j])==parseInt(rows[i].prodoc)){
					    			   
					                   $('#jqxDeliveryNote').jqxGrid('setcellvalue', i, "chkqty" ,1);
					    			   $('#jqxDeliveryNote').jqxGrid('setcellvalue', i, "balqty" ,test2[j]);
					    			   }
					    			   
					    		   }
					    	 
					            	
					            }
					            	
					           }
				           
				           else
				        	   {
				        	   save();
				        	   }
				           
			 			    
			 			}
			 		  //type,description,remarks,lbrcost,partscost,total
			 	}
			 	 x.open("GET","validateqtys.jsp?list="+list+"&branch="+branch+"&location="+location+"&mode="+mode,true);
					x.send();
				        
			 }

		   
		   
 
		  
		  function save()
		  
		  {
		  
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
		  var rows = $("#jqxDeliveryNote").jqxGrid('getrows');
		  var termrows = $("#jqxTerms").jqxGrid('getrows');
		  
		  
		  $('#termsgridlength').val(termrows.length);
		   $('#gridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
			  
			 
		   newTextBox = $(document.createElement("input")) 
		      .attr("type", "dil")
		      .attr("id", "prodg"+i)
		      .attr("name", "prodg"+i)
		      .attr("hidden", "true");
		   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
		   
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+ 
				  rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+
				  rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].ordout_qty);
		  newTextBox.appendTo('form');
			    
		  }
		  
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

		  document.getElementById("frmdeliveryNote").submit();
	     
		  }
	   
	  function funNotify(){	
		   
		  if($('#txtclient').val()=="")
		  {
		  document.getElementById("errormsg").innerText="Search Customer";  
		   document.getElementById("txtclient").focus();
		     
		      return 0;
		  
		  }
			if($('#txtlocation').val()== "")
			{
			document.getElementById("errormsg").innerText="select location";
			document.getElementById("txtlocation").focus();
			return 0;
			}
		  if(parseInt(document.getElementById("multimethod").value)==1)
			{	
			  chkstock();
			}
		  else
			  {
		/*   checkqty(); */ chkstock();
			  }
		  
		  
		}
	  
	  
	   
	  function chkstock()
	  {
 
	  		var rows = $("#jqxDeliveryNote").jqxGrid('getrows');
	  		var list = new Array();
	  		 
	  	   for(var i=0 ; i < rows.length; i++){
	  		 
	  		   if(parseInt(rows[i].prodoc)>0)  
	  		   { 
	  		 
	  		   list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty);
	  		 
	  		   }
	  	   }
	  			 
	  	  ajaxcallchk(list);
	  	   
	  }
	  	   

	  	 function ajaxcallchk(list){
	  		 var branch=document.getElementById("brchName").value;
	  		 var location=document.getElementById("locationid").value;
	  		 var mode=$('#mode').val();
	  		 	
	  		 	var x=new XMLHttpRequest();
	  		 	x.onreadystatechange=function(){
	  		 		if (x.readyState==4 && x.status==200)
	  		 			{
	  		 			 var items= x.responseText.trim();
	  		  
	  		 	 
	  		 		   
	  		 		    if(parseInt(items)==1)
	  			           {
	  		 		    	document.getElementById("errormsg").innerText=" Does Not Have Sufficient Stock !!";  
	  		 		        return 0;
	  			           }
	  		 		    else  if(parseInt(items)==2)
	  		 		    	{
	  		 		    	document.getElementById("errormsg").innerText=" error!!";  
	  		 		        return 0;
	  		 		    	
	  		 		    	}
	  			       
 
	  				           
	  			           
	  			           else
	  			        	   {
	  			        	   save();
	  			        	   }
	  			           
	  		 			    
	  		 			}
	  		 		  //type,description,remarks,lbrcost,partscost,total
	  		 	}
	  		 	 x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location,true);
	  				x.send();
	  			        
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
        
          
          $('#jqxDeliveryNote').jqxGrid('showcolumn', 'foc');
       
          
          
           }
             else
         {
         
              $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'foc');
         
         }
         
          if(parseInt(kg)>0)
         {
       
         
         $('#jqxDeliveryNote').jqxGrid('showcolumn', 'kgprice');
         $('#jqxDeliveryNote').jqxGrid('showcolumn', 'totwtkg');
      
         
         
          }
            else
        {
        
             $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'kgprice');
             $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'totwtkg');
        
        } 
         
         
         
          }}
      x.open("GET","checkfoc.jsp",true);
    x.send();
    
         
           
       
      }
	  
	  
	  
	  function setValues(){
		  
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 // funSetlabel();
		  combochange();
		  var masterdoc_no=$('#masterdoc_no').val().trim();
		  var refmasterdocno=$('#refmasterdocno').val().trim();
		  var dtype=$('#formdetailcode').val().trim();
		  var cmbreftype= $('#cmbreftype').val().trim();
		  var locationid=$('#locationid').val().trim();
 
		  if(masterdoc_no>0){
			  
			  
			  funchkforedit();
			  
			  $("#delNoteDiv").load("deliveryNoteGrid.jsp?qotdoc="+masterdoc_no+"&locationid="+locationid+"&reftype="+cmbreftype+"&enqdoc="+refmasterdocno+"&cond=2");
			  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
			  $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
			  
			  $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+masterdoc_no+"&formcode="+$('#formdetailcode').val());
			 // checkout();
		  }
			 
		}
	 
	  function getCustomer(event){
          var x= event.keyCode;
          	if(x==114){
        	  <%-- CustomerSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp"); --%>
          	}
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
			            if($('#hidcmbcurrency').val()!="")
						  {
						  
						  
						  $('#cmbcurr').val($('#hidcmbcurrency').val());   
						  
						  }
					   
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
	  
	  
	  function getPriceGroup(){ 
			
 
			        }
		
	  
	  
			   	  
		 function getclinfo(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    	  $('#customerDetailsWindow').jqxWindow('open');
	    
	    
	    	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	    	 else{
	    		 }
	    	 } 
		 
		 
		 function getDocumentSearch(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    	  $('#customerDetailsWindow').jqxWindow('open');
	    	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	    	 else{
	    		 }
	    	 } 
		 
		 
		 
		       function clientSearchContent(url) {
	                 
		                 $.get(url).done(function (data) {
	        
			           $('#customerDetailsWindow').jqxWindow('setContent', data);

	          	}); 
		           	} 
		       
		       
		       
		       function termsSearchContent(url) {
		    	   $('#searchwndow').jqxWindow('open');
	                 $.get(url).done(function (data) {
		           $('#searchwndow').jqxWindow('setContent', data);
		           $('#searchwndow').jqxWindow('bringToFront');

        	}); 
	           	} 
		       
		       
		       function productSearchContent(url) {
		       	 //alert(url);
		       		 $.get(url).done(function (data) {
		       			 
		       			 $('#sidesearchwndow').jqxWindow('open');
		       		$('#sidesearchwndow').jqxWindow('setContent', data);
		       
		       	}); 
		       	} 

	  
	  function refChange(){
		  var reftype=$('#cmbreftype').val();
		  if(reftype=='DIR'){
			  
			  $('#rrefno').attr('disabled', true);
			  
			  $("#jqxDeliveryNote").jqxGrid('clear');
				 $("#jqxDeliveryNote").jqxGrid('addrow', null, {});
			  
			  
			  
		  }
		  else{
			  
			  $('#rrefno').attr('disabled', false);
			  $("#jqxDeliveryNote").jqxGrid('clear');
				 $("#jqxDeliveryNote").jqxGrid('addrow', null, {});
			  
		  }
		  
	  }
	  
	  function gridLoad(){
		  var dtype=document.getElementById("formdetailcode").value;
		  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
	  }
	  
	 
	  
	  
	  function getrefno(event)
	  {
		  
		  var clientid=document.getElementById("clientid").value;
			
			if(clientid>0){
				
				document.getElementById("errormsg").innerText="";
				
			}
			else{
				document.getElementById("errormsg").innerText="Select a client";
				
				return 0;
			}
			
		  
		  
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#refnosearchwindow').jqxWindow('open');
	  	
	  	  refsearchContent('refnosearch.jsp');  }
	  	 else{
	  		 }
	  	 }  
	  	
	  	  function refsearchContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	  //alert(data);
	         $('#refnosearchwindow').jqxWindow('setContent', data);

	  	}); 
	     	}	
	  	  
	  	   function combochange()
		   {
	  		   
			   if($('#hidcmbcurrency').val()!="")
				  {
				  
				  
				  $('#cmbcurr').val($('#hidcmbcurrency').val());   
				  
				  }
			   
			   if($('#hidcmbprice').val()!="")
				  {
				  
				  
				  $('#cmbprice').val($('#hidcmbprice').val());   
				  
				  }
			   
				  if($('#hidcmbreftype').val()!="")
				  {
				  
				  
				  $('#cmbreftype').val($('#hidcmbreftype').val());
				  }
				 
				 if($('#hidcmbreftype').val()=="SOR")
				  {
				
				  $('#rrefno').attr('disabled', false);
				  
			  $('#rrefno').attr('readonly', true);
			
				  }
			   
				 if($('#cmbreftype').val()!='DIR'){
					 $('#btnDelete').attr('disabled', true);
				 }
				
				 
				/*  if($('#txtdiscount').val()>0)
		 		  {
		 		  document.getElementById("chkdiscount").checked = true;
		 		  
		 		  }	  */
				 
		   }
	  	   
	  	   
	  	 function funcalcu()
	  	{
	  		
	  	 
	  		document.getElementById('prddiscount').value="";
	  		
	  		
	  		$('#jqxDeliveryNote').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	  		var  productTotal=document.getElementById('txtproductamt').value;
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
	  		
	  		
	  	/* 	
	  		alert("descvalue"+descvalue);
	  		
	  		alert("netval"+netval);
	  		 */
	  		funRoundAmt(descvalue,"txtdiscount");
	  		funRoundAmt(netval,"txtnettotal");
	  		var aa;
	  	 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
	  	   	            	   {
	  	   	               
	  	   	               aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
	  	   	            	   }
	  	   	               else
	  	   	            	   {
	  	   	            	    aa=document.getElementById("txtnettotal").value;
	  	   	            	    
	  	   	            	
	  	   	            	   }
	  	        
	  				document.getElementById("orderValue").value=aa;	
	  	            	funRoundAmt(aa,"orderValue");
	  		
	  		 var rows = $('#jqxDeliveryNote').jqxGrid('getrows');
	  	      var rowlength= rows.length;
	  	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	  	   
	  			    for(var i=0;i<rowlength;i++)
	  						  {
	  		 
	  			    	var totamt=rows[i].total;
	  			     
	  			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
	  			     
	  			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
	  			    	
	  		  
	  			    	$('#jqxDeliveryNote').jqxGrid('setcellvalue',i, "dis" ,discounts);
	  			    	$('#jqxDeliveryNote').jqxGrid('setcellvalue',i, "netotal" ,nettot);
	  					 
	  				  
	  						  }
	  		 
	  	
	  		
	  		}
	  		
	  		
	  		
	  		
	  	function funvalcalcu()
	  		{
	  		
	  		
	  		document.getElementById('prddiscount').value="";
	  		$('#jqxDeliveryNote').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
	  		var  productTotal=document.getElementById('txtproductamt').value;
	  		var  descountVal=document.getElementById('txtdiscount').value;
	  	 
	  		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	  		var netval=parseFloat(productTotal)-parseFloat(descountVal);
	  		
	  	 
	  		funRoundAmt(descper,"descPercentage");
	  		funRoundAmt(netval,"txtnettotal");
	  		funcalcu();
	  		}
	  		
	  		
	  		
	  	 function roundval()
	  	{
	  			var  netTotaldown=document.getElementById('txtnettotal').value;
	  		    var roundOf=document.getElementById('roundOf').value;
	  	 
	  			 
	  			var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
	  			funRoundAmt(netval,"txtnettotal");
	  			funRoundAmt(netval,"orderValue");
	  	}
	  	 
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
	  				 $('#txtdiscount').attr('disabled', false);
	  				  
	  		   }
	  		  
	  		   
	  				}
	  			
	  			
	  		      
	  	      });
	  		   }
	  		   else
	  		   {
	  		   document.getElementById('descPercentage').value="";
	  		   document.getElementById('txtdiscount').value="";
	  		   var summaryData3= $("#jqxDeliveryNote").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
	  		   $('#descPercentage').attr('disabled', true);
	  			 $('#txtdiscount').attr('disabled', true);
	  				$('#jqxDeliveryNote').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
	  		   }
	  	   
	  		}	
	  	
	  	
	  	
	  	function checkout()
	  	{
	  		var rdocno=$('#masterdoc_no').val().trim();
	  	var x=new XMLHttpRequest();
	  	x.onreadystatechange=function(){
	  	if (x.readyState==4 && x.status==200)
	  	 {
	  	   var items= x.responseText.trim();
	  		var qty = items;

	  		if(parseInt(qty)>0){
	  			$("#btnEdit").attr('disabled', true );
	  			$("#btnDelete").attr('disabled', true );
	  		}
	  		else{
	  			$("#btnEdit").attr('disabled', false );
	  			$("#btnDelete").attr('disabled', false );
	  		}
	  	   
	  	   }}
	  	x.open("GET","checkout.jsp?rdocno="+rdocno,true);
	  	x.send();
	  	  
	  	}

	 	function funwarningopen(){
	 		   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	 		       if (r){
	 		    	    
	 				   
	 				   document.getElementById("editdata").value="Editvalue";
	 				   
 
	 			 	
	 			 	
	 			 	$("#jqxDeliveryNote").jqxGrid({ disabled: false});
	 				$("#jqxDeliveryNote").jqxGrid('addrow', null, {});
	 			 	
					$("#shipdata").jqxGrid({ disabled: false});
					
				 	$("#shipdata").jqxGrid('addrow', null, {});
	 		    		
 

	 		       }
	 		      });
	 		   }
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("savedeliveryNote");
		        
		        $("#docno").prop("disabled", false);                
		        
		  
		var win= window.open(reurl[0]+"printdeliveryNote?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
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
							 $("#btnEdit").attr('disabled', false);
							 $("#btnDelete").attr('disabled', false);
							}
					  
						
						
						
					} else {
					}
				}
				x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("cmbreftype").value+"&refmasterdocno="+document.getElementById("refmasterdocno").value, true);
				x.send();
			
			
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
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmdeliveryNote" action="savedeliveryNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />
<jsp:include page="multiqty.jsp"></jsp:include>
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="100%">
  <tr>
  
    <td width="3%" height="42" align="right">Date</td>
    <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="14%"><input type="text" id="txtrefno" name="txtrefno" style="width:60%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="8%" align="right">Sales Person</td>
    <td width="24%"><input type="text" id="txtsalesperson" name="txtsalesperson" readonly style="width:50%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
    <td width="8%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%"  >
  <tr>
    <td width="9%" align="right">Customer</td>
    <td width="15%"><input type="text" id="txtclient" name="txtclient" readonly style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td><input type="text" id="txtclientdet" name="txtclientdet" style="width:54%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td><select id="cmbcurr" name="cmbcurr" style="width:71%;" value='<s:property value="cmbcurr"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td>Currency Rate
     &nbsp;&nbsp;<input type="text" id="currate" name="currate" style="width:10%;" value='<s:property value="currate"/>'/></td>
  </tr>
   <tr>
      
    <td  align="right">Location</td><td>
        <input type="text" id="txtlocation" name="txtlocation" style="width:98%;" readonly placeholder="Press F3 to Search"  onKeyDown="getLocation(event);" value='<s:property value="txtlocation"/>'/>
        <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
 
    </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();"  value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
       <option value="SOR">SOR</option></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <%-- <td width="14%"><input type="text" id="txtreftype" name="txtreftype" style="width:85%;" value='<s:property value="txtreftype"/>'/></td> --%>
    <td>Sales Order <input type="text" id="rrefno" name="rrefno" style="width:15%;"  placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
     </td>
    <%--  &nbsp;&nbsp;&nbsp; Price&nbsp;<select id="cmbprice" name="cmbprice" style="width:10%;" value='<s:property value="cmbprice"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/> --%>
    </tr>
    
   
    
  <%-- <tr>
    <td align="right">Payment Terms</td>
    <td colspan="2"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:61%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr> --%>
  <tr>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:61%;" value='<s:property value="txtdescription"/>'/>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    </td>
  </tr>
</table>
</fieldset>
<fieldset><legend>Product Details</legend>
<div id="delNoteDiv"><center><jsp:include page="deliveryNoteGrid.jsp"></jsp:include></center></div><br/>
</fieldset>
 
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


<%-- <fieldset>
   <legend>Summary</legend>  
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" name="txtproductamt" readonly="readonly" id="txtproductamt" value='<s:property value="txtproductamt"/>'    style="width:50%;text-align: right;"></td>
<td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset> --%>




 <%-- <fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset>
 --%>

<%-- <table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table> --%>

  <%-- <fieldset>
<table width="100%">
  <tr>
    <td width="8%" align="right">Product</td>
    <td width="24%"><input type="text" id="txtproductamt" name="txtproductamt" style="width:50%;text-align: right;" value='<s:property value="txtproductamt"/>'/></td>
     <td width="5%" align="right">Discount</td>
    <td width="26%"><input type="text" id="txtdiscount" name="txtdiscount" style="width:50%;text-align: right;" value='<s:property value="txtdiscount"/>'/></td> 
    <td width="10%" align="right">Net Total</td>
    <td width="27%"><input type="text" id="txtnettotal" name="txtnettotal" style="width:50%;text-align: right;" value='<s:property value="txtnettotal"/>'/></td>
  </tr>
</table>
</fieldset> --%>
</br> 
<fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset>
<input type="hidden" id="cmbprice" name="cmbprice" value='<s:property value="cmbprice"/>'/>
<input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
<input type="hidden" name="txtnettotal"  id="txtnettotal" value='<s:property value="txtnettotal"/>'>
<input type="hidden"  id="orderValue"  name="orderValue"  value='<s:property value="orderValue"/>'/>
<input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
<input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
<input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
<input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="refmasterdocno" name="refmasterdocno"  value='<s:property value="refmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
   <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
   
   
    <input type="hidden" id="shipdocno" name="shipdocno"  value='<s:property value="shipdocno"/>'/>
                <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght"  value='<s:property value="shipdatagridlenght"/>'/>
   
</div>
<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
<div id="customerDetailsWindow">
	<div></div>
</div>

<div id="sidesearchwndow">
	<div></div>
</div>  
<div id="refnosearchwindow">
	<div></div>
</div>
<div id="searchwndow">
	<div></div>
</div>
<div id="locationwindow">
	<div></div>
</div>	

<div id="tremwndow">
	<div></div>
</div>	

	
</form>
	

</div>
</body>
</html>
