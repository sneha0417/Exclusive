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
		/*  $('#btnvaluechange').hide(); */
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	 
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
		    		locationSearchContent('locationSearch.jsp?brch='+document.getElementById("brchNames1").value);  
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
		 
		 
		 
		 $('#btnEdit').attr('disabled', true );
		 $('#btnDelete').attr('disabled', true );
		 
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
	   		locationSearchContent('locationSearch.jsp?brch='+document.getElementById("brchNames1").value);  	 }
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
		 
			$('#frmstkadjust input').attr('readonly', true );
			$('#frmstkadjust select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxstkAdjustment").jqxGrid({ disabled: true});
			 
			/* $('#btnvaluechange').hide(); */
			//$("#jqxserviceGrid").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		   $('#jqxstkAdjustment').jqxGrid('hidecolumn', 'totcost_price');
			if ($("#mode").val() == "A") {
		 gridLoad();
			}
		 document.getElementById("editdata").value="";
			$('#frmstkadjust input').attr('readonly', false );
			$('#frmstkadjust select').attr('disabled', false);  
			
			$('#txtclient').attr('readonly', true );
			$('#rrefno').attr('readonly', true );
			$('#txtlocation').attr('readonly', true );
			$('#txtsalesperson').attr('readonly', true );
			$('#txtproductamt').attr('readonly', true );
			$('#txtdiscount').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			
			$('#orderValue').attr('readonly', true);
			
	 
			
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxstkAdjustment").jqxGrid({ disabled: false}); 
		 
			if ($("#mode").val() == "E") {
				 
   			 
				/*  $('#btnvaluechange').show(); */
		  	 
				$("#jqxstkAdjustment").jqxGrid({ disabled: true});
				 
			 
				
		 
				
			 
		 
   			    
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
			 
				//getPriceGroup();
				$('#date').val(new Date());
				 
				//$("#jqxserviceGrid").jqxGrid({ disabled: false});
				//$("#jqxserviceGrid").jqxGrid('clear'); 
				//$("#jqxserviceGrid").jqxGrid('addrow', null, {});
				$("#jqxstkAdjustment").jqxGrid('clear'); 
				$("#jqxstkAdjustment").jqxGrid('addrow', null, {});
				
			//	$("#shipdata").jqxGrid('clear'); 
				//$("#shipdata").jqxGrid('addrow', null, {});
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
	        $('#frmstkadjust').validate({
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
			var rows = $("#jqxstkAdjustment").jqxGrid('getrows');
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
			 			 var items= x.responseText;
			 	 
			 		 var temps1="";
			 		 var temps2="";
			 		    items = items.split('###');
			 		    
			 		    
				           var temp1=items[0];
				           var temp2=items[1];
				          
				       
				           if(temp1.indexOf(",")>=0){
				    
				 
				        	 
					            for ( var j = 0; j < temp1.length; j++) {
					            	
					             
					            var	test=temp1.split(",");
					            var test2=temp2.split(",");
					      
					         
					            	var rows = $("#jqxstkAdjustment").jqxGrid('getrows');
					    		 
					    			 
					    		   for(var i=0 ; i < rows.length ; i++){
					    			   
					    			   if(parseInt(test[j])==parseInt(rows[i].prodoc)){
					    			   
					                   $('#jqxstkAdjustment').jqxGrid('setcellvalue', i, "chkqty" ,1);
					    			   $('#jqxstkAdjustment').jqxGrid('setcellvalue', i, "balqty" ,test2[j]);
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
			 	 x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&location="+location+"&mode="+mode,true);
					x.send();
				        
			 }

		   
		   
		   
		   
		   
	  
		 
		

	   
	   
	   

		  
		  
		  
		  function funNotify()
		  
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
		  	var aa=0;
		    var rows = $("#jqxstkAdjustment").jqxGrid('getrows');
			  for(var i=0 ; i < rows.length ; i++){ 
				  var prodoc= rows[i].prodoc;
				  
				  if(parseInt(prodoc)>0)
					  {
					  var adj_qty= rows[i].adj_qty;
					 
					  if(parseFloat(adj_qty)==0)
					  {
					  
					  aa=1;
					  
					  break;
					  
					  }		
					  
					  if(parseFloat(adj_qty)>0)
						  {
						  
						  
						  if(!(parseFloat(rows[i].cost_price)>0))
						  { 
						  
						  aa=2;
						  
						  break;
						  }
						  
						  
						  
						  }
					  
					    }
				 
				  
			          }
		  	
	      	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText="Adjusted Quantity Should Not Be Zero";
        		   
        		   return 0;
        		   
        		   }
        	   else if(parseInt(aa)==2)
        		   {
        		   document.getElementById("errormsg").innerText="Cost Price required !!";
        		   return 0;
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   
        		   }
        	   
		  var rows = $("#jqxstkAdjustment").jqxGrid('getrows');
		  
		  
		  
		 
		   $('#gridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
			  
			 
		   newTextBox = $(document.createElement("input")) 
		      .attr("type", "dil")
		      .attr("id", "prodg"+i)
		      .attr("name", "prodg"+i)
		      .attr("hidden", "true");
		   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
		  
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].adj_qty+"::"+rows[i].stk_qty+"::"+rows[i].phy_qty+"::"+ 
				  rows[i].cost_price+"::"+rows[i].totalcost_price+"::"+rows[i].specid+"::");
		  newTextBox.appendTo('form');
			    
		  }
		  
		 

		  document.getElementById("frmstkadjust").submit();
	     
		  }
	   
/* 	  function funNotify(){	
		   
		  if($('#txtclient').val()=="")
		  {
		  document.getElementById("errormsg").innerText="Search Customer";  
		   document.getElementById("txtclient").focus();
		     
		      return 0;
		  
		  }
		 // checkqty();
		  
		  
		}
	   */
	  
	  
	  function chkfoc()
      {
       
      /* var x=new XMLHttpRequest();
      x.onreadystatechange=function(){
      if (x.readyState==4 && x.status==200)
       {
         var items= x.responseText.trim();
         var item = items.split('##');
			var foc  = item[0];
			var kg = item[1];
         if(parseInt(foc)>0)
          {
        
          
          $('#jqxstkAdjustment').jqxGrid('showcolumn', 'foc');
       
          
          
           }
             else
         {
         
              $('#jqxstkAdjustment').jqxGrid('hidecolumn', 'foc');
         
         }
         
          if(parseInt(kg)>0)
         {
       
         
         $('#jqxstkAdjustment').jqxGrid('showcolumn', 'kgprice');
         $('#jqxstkAdjustment').jqxGrid('showcolumn', 'totwtkg');
      
         
         
          }
            else
        {
        
             $('#jqxstkAdjustment').jqxGrid('hidecolumn', 'kgprice');
             $('#jqxstkAdjustment').jqxGrid('hidecolumn', 'totwtkg');
        
        } 
         
         
         
          }}
      x.open("GET","checkfoc.jsp",true);
    x.send();
    
          */
           
       
      }
	  
	  
	  
	  function setValues(){
		  getBrchs();
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 // funSetlabel();
		  combochange();
		  var masterdoc_no=$('#masterdoc_no').val();
	 
		 
		   
		  
		  if(masterdoc_no>0){
			  
			  
			//  funchkforedit();
			  
			  $("#delNoteDiv").load("prdGrid.jsp?qotdoc="+masterdoc_no+"&cond=2");
		 
		  }
			 
		}
	 
	  function getCustomer(event){
          var x= event.keyCode;
          	if(x==114){
        	  <%-- CustomerSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp"); --%>
          	}
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
		  }
		  else{
			  
			  $('#rrefno').attr('disabled', false);
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
	  		   
	   
	  	
	  		 if($('#hidbrchids').val()!="")
			  {
			  
			  
			  $('#brchNames1').val($('#hidbrchids').val());   
			  
			  }   
	  		   
	  		   
			 /*   if($('#hidcmbcurrency').val()!="")
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
				 */
				 
				/*  if($('#txtdiscount').val()>0)
		 		  {
		 		  document.getElementById("chkdiscount").checked = true;
		 		  
		 		  }	  */
				 
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
	  	
	 
	  	 

	 	function funwarningopen(){
	 		   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	 		       if (r){
	 		    	    
	 				   
	 				   document.getElementById("editdata").value="Editvalue";
	 				   
 
	 			 	
	 			 	
	 			 	$("#jqxstkAdjustment").jqxGrid({ disabled: false});
	 				$("#jqxstkAdjustment").jqxGrid('addrow', null, {});
	 			 	
				//$("#shipdata").jqxGrid({ disabled: false});
					
				 //	$("#shipdata").jqxGrid('addrow', null, {});
	 		    		
 

	 		       }
	 		      });
	 		   }
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("savephkadjst");
		        
		       // alert(document.getElementById("masterdoc_no").value);
		        
		        $("#docno").prop("disabled", false);                
		       var dtype=$('#formdetailcode').val();
		  
		var win= window.open(reurl[0]+"printphkadjst?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brchid="+document.getElementById("hidbrchids").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
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
						var items = x.responseText;	
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
	  	
			function getBrchs()
			{
			 
			var x=new XMLHttpRequest();
			var items,brchItems;
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			        items= x.responseText;
			      
			        items=items.split('####');
			        brchIdItems=items[0].split(",");
			        brchItems=items[1].split(",");
			      
			        	var optionsbrch = '';
			         
			       for ( var i = 0; i < brchItems.length; i++) {
			    	   optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
			        }
			     
			        	$("select#brchNames1").html(optionsbrch); 	
			         
			        }
				else
					{
					}
				

		  		 if($('#hidbrchids').val()!="")
				  {
				  
				  
				  $('#brchNames1').val($('#hidbrchids').val());   
				  
				  }  
			}
			x.open("GET","getBranch.jsp?",true);
			x.send();
		}
function Clearloc(){
	
	document.getElementById("txtlocation").value="";
	document.getElementById("locationid").value="";
	
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
<body onload="setValues();getBrchs();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmstkadjust" action="savephkadjst" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div  class='hidden-scrollbar'>
<input type="text" name="gridtext0" id="gridtext0"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext0"/>' />
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
 <fieldset>
<table width="100%" >
  <tr>
   
    <td width="3%"  align="right">Date</td> 
    <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="9%" align="right">Branch</td>
    <td width="14%"><select name="brchNames1" id="brchNames1" style="width:98%;"  onchange="Clearloc()"> 
			</select>
			
			<input type="hidden" id="hidbrchids"  name="hidbrchids" value='<s:property value="hidbrchids"/>'/>
			</td>
    <td  align="right">Location</td><td>
        <input type="text" id="txtlocation" name="txtlocation" style="width:75%;" readonly placeholder="Press F3 to Search"  onKeyDown="getLocation(event);" value='<s:property value="txtlocation"/>'/>
        <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
    <td width="8%" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" style="width:30%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
 

  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" id="txtdescription" name="txtdescription" style="width:93%;" value='<s:property value="txtdescription"/>'/>
 
<!--     <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button> -->
    </td>
  </tr>
</table>
 </fieldset>
<fieldset><legend>Product Details</legend>
<div id="delNoteDiv"><center><jsp:include page="prdGrid.jsp"></jsp:include></center></div><br/>
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
 