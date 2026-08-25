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
<style type="text/css">
.classpass {
    -webkit-text-security: disc;
}
 #psearch {
 
background:#FAEBD7;
 
}

.blink {
  animation: blink-animation 2s steps(5, start) infinite;
  -webkit-animation: blink-animation 2s steps(5, start) infinite;
}
@keyframes blink-animation {
  to {
    visibility: hidden;
  }
}
@-webkit-keyframes blink-animation {
  to {
    visibility: hidden;
  }
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

</style>
<script type="text/javascript">
	$(document).ready(function() {
		 
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 refChange();
			$('#btnvaluechange').hide();
		 chkfoc();
		// $("#btnEdit").attr('disabled', true );
		 document.getElementById("checkhidegrid").value="0";
		 $('#userwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		 $('#userwindow').jqxWindow('close');  
		 $('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 $('#sidesearchwndow').jqxWindow({  width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close'); 
	     
	     
	     $('#sal').hide();
	     
		 	$('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
	         	y : 87
			}, keyboardCloseKey: 27});
		    $('#tremwndow').jqxWindow('close');
	     
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
			
			$('#accountsearchwindow').jqxWindow({
		 		width : '25%',
		 		height : '58%',
		 		maxHeight : '70%',
		 		maxWidth : '45%',
		 		title : 'Account Search',
		 		position : {
		 			x : 420,
		 			y : 87
		 		},
		 		theme : 'energyblue',
		 		showCloseButton : true,
		 		keyboardCloseKey : 27
		 	});
		 	$('#accountsearchwindow').jqxWindow('close');
			
			$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#searchwndow').jqxWindow('close');  
			 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
	 
	 
		 
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
		 
		 $('#rrefno').dblclick(function(){
			   
		    	if($('#mode').val()== "A")
		    		{
		    		
		    		  var clientid=document.getElementById("clientid").value;
		  			
		  			if(clientid>0){
		  				
		  				document.getElementById("errormsg").innerText="";
		  				
		  			}
		  			else{
		  				document.getElementById("errormsg").innerText="Select a Customer";
		  				
		  				return 0;
		  			}
		  			
		    		
		    		
		    		$('#refnosearchwindow').jqxWindow('open');
		    		refsearchContent('refnosearch.jsp');
		    		}
		  });
		 
		 
		 $('#user_namess').dblclick(function(){
			 
			 	if($('#mode').val()!= "view")
					{
			 		 
				usersearchcontent('searchuser.jsp?'); 
					}
				
			     });

		 
		 $('#shipto').dblclick(function(){
	         
		     	if($('#mode').val()!= "view")
		     		{
		     	
		     		
		 	  	  
		 	  	
		 	  	   shipSearchContent('shipmasterSearch.jsp?');
		     		}
		   }); 
		 
		 
		 $('#date').on('change', function (event) {
			  
			    var maindate = $('#date').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });

	});
	
	
	function getuser(event){
		 var x= event.keyCode;
		 if(x==114){
			   	if($('#mode').val()!= "view")
		   		{
		  usersearchcontent('searchuser.jsp?');
		   		}}
		 else{
			 }
		 } 
	function usersearchcontent(url) {
		  $('#userwindow').jqxWindow('open');
	     $.get(url).done(function (data) {
	    $('#userwindow').jqxWindow('setContent', data);

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
	
	 function funReadOnly(){
		 
			$('#frmSalesOrder input').attr('readonly', true );
			$('#frmSalesOrder select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxSalesOrder").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
			$("#jqxserviceGrid").jqxGrid({ disabled: true});
			$('#btnvaluechange').hide();
			$('#chkdiscount').attr('disabled', true);	 
			 $('#btnCalculate').attr('disabled', true);
			 $("#shipdata").jqxGrid({ disabled: true});
			  $('#rrefno').attr('disabled', true);
				 $('#process').attr('disabled', true);
				  $('#psearch').attr('disabled', true );
				  $('#sal').hide();
			     $('#user_namess').attr('disabled', true);
			
				 $('#dscper').attr('disabled', true);
				 $('#process').attr('disabled', true);
				 $('#changeuser').attr('disabled', true);
	 }
	 
	 function funRemoveReadOnly(){
			if ($("#mode").val() == "A") {
		 gridLoad();
			}
			gettaxaccount(1);
			getround();
			 chkmultiqty();
		  $('#rrefno').attr('disabled', true);
		       document.getElementById("editdata").value="";
			$('#frmSalesOrder input').attr('readonly', false );
			$('#frmSalesOrder select').attr('disabled', false);
			
			
			$('#st').attr('readonly', true );
			$('#taxontax1').attr('readonly', true );
			$('#taxontax2').attr('readonly', true );
			$('#taxontax3').attr('readonly', true );
			$('#taxtotal').attr('readonly', true );
			$('#process1').attr('disabled', false);
			
			 
			$('#quantity').attr('readonly', false );
		//	$('#focs').attr('readonly', false );
			$('#amounts').attr('readonly', true );
			$('#totamt').attr('readonly', true );
			$('#uprice').attr('readonly', false );
			  $('#sal').hide();
			
			$('#taxpers').attr('readonly', true );
			$('#taxamounts').attr('readonly', true );
			$('#taxamountstotal').attr('readonly', true );
		
			
			
			
			$('#txtclient').attr('readonly', true );
			$('#rrefno').attr('readonly', true );
			$('#txtsalesperson').attr('readonly', true );
			$('#txtproductamt').attr('readonly', true );
			$('#txtdiscount').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			
			$('#orderValue').attr('readonly', true);
			
			
			
			
			 $('#user_namess').attr('readonly', true );
			 $('#user_namess').attr('disabled', true);
			 $('#pass_wordss').attr('disabled', true);
			 $('#dscper').attr('disabled', true);
			 $('#process').attr('disabled', true);
			 $('#changeuser').attr('disabled', true);
			
			
			 $('#process').attr('disabled', true);
			 $('#shipto').attr('readonly', true);
			 $('#shipaddress').attr('readonly', true);
			 $('#contactperson').attr('readonly', true);
			 $('#shiptelephone').attr('readonly', true);
			 $('#shipmob').attr('readonly', true);
			 
			 $('#shipemail').attr('readonly', true);
			 $('#shipfax').attr('readonly', true);
			 
			 
			
			 $("#shipdata").jqxGrid({ disabled: false});
			
			 $('#descPercentage').attr('disabled', true);
			 $('#txtdiscount').attr('disabled', true);
			
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxSalesOrder").jqxGrid({ disabled: false}); 
			$("#jqxTerms").jqxGrid({ disabled: false});
			if ($("#mode").val() == "E") {
				 reloads();
				 $('#process').attr('disabled', true);
				$("#jqxSalesOrder").jqxGrid({ disabled: true}); 
				$("#jqxTerms").jqxGrid({ disabled: true});
				$("#shipdata").jqxGrid({ disabled: true});
				$("#jqxserviceGrid").jqxGrid({ disabled: true});
   			    /* $("#jqxSalesOrder").jqxGrid('addrow', null, {});
   			    $("#jqxserviceGrid").jqxGrid('addrow', null, {}); */
   			 $('#process').attr('disabled', true);
				 var rows = $("#jqxSalesOrder").jqxGrid('getrows');
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
		      		  $('#jqxSalesOrder').jqxGrid('render');
		      		 $('#btnvaluechange').hide();
		   		   
		   		   }
		   	   else
		   		   {
		   		  $('#btnvaluechange').show();
		   		   }
				   
		    	   
			      	 if($('#cmbreftype').val()=="SQOT")
			      		 {
			      		 
			      		  $('#rrefno').attr('disabled', false);
			      		 $('#psearch').attr('disabled', true );
			      		 }
			      	 else
			      		 {
			      		$('#psearch').attr('disabled', false );
			      		$('#setbtn').attr('disabled', false );  

			      		 }
		      
		      	funckclientcat();
   			    
			  }
			
			if ($("#mode").val() == "A") {
				$("#txtproductamt").val("0.0");
				$("#txtdiscount").val("0.0");
				$("#txtnettotal").val("0.0");
				$("#descPercentage").val("0.0");
				$("#prodsearchtype").val("0");
				$("#orderValue").val("0.0");
				$("#roundOf").val("0.0");
				$("#nettotal").val("0.0");
				getCurrencyIds();
				  $('#psearch').attr('disabled', false );
				reloads();
				
				 $('#chkdiscount').attr('disabled', false);	 
				$('#date').val(new Date());
				$("#jqxTerms").jqxGrid({ disabled: false});
				$("#jqxserviceGrid").jqxGrid({ disabled: false});
				$("#jqxserviceGrid").jqxGrid('clear'); 
				$("#jqxserviceGrid").jqxGrid('addrow', null, {});
				$("#jqxSalesOrder").jqxGrid('clear'); 
				$("#jqxSalesOrder").jqxGrid('addrow', null, {});
				$("#shipdata").jqxGrid('clear');
				  $("#shipdata").jqxGrid('addrow', null, {});
				  
				  
				  $("#hidegrids").jqxGrid('clear'); 
			}
		  	/* if ($("#mode").val() == "E") {
				 $('#btnvaluechange').show();
		  	 
				$("#jqxSalesOrder").jqxGrid({ disabled: true});
				$("#jqxserviceGrid").jqxGrid({ disabled: true});
				$("#jqxTerms").jqxGrid({ disabled: true});
				
				
			}   */
		  
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('qotMastersearch.jsp'); 
	}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmSalesOrder').validate({
	                rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true}
	                },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"}
	                 }
	        });});
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


	/*   function funNotify(){	

		  
		  if($('#txtclient').val()=="")
		  {
		  document.getElementById("errormsg").innerText="Search Customer";  
		   document.getElementById("txtclient").focus();
		     
		      return 0;
		  
		  }
	  
		  var rows = $("#jqxSalesOrder").jqxGrid('getrows');
		  var termrows = $("#jqxTerms").jqxGrid('getrows');
		  
		  
		  $('#termsgridlength').val(termrows.length);
		   $('#gridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
			  
			 
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "prodg"+i)
		      .attr("name", "prodg"+i)
		      .attr("hidden", "true");        
		   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
		   
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice 
				              +"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid
				              +"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].unitprice1+"::"+rows[i].disper1+"::"+rows[i].foc
				              +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+rows[i].taxdocno+"::"+"0000"+"::");
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
		  
		  var srows = $("#jqxserviceGrid").jqxGrid('getrows');
		   $('#servgridlen').val(srows.length);
		  for(var i=0 ; i < srows.length ; i++){
		  // var myvar = rows[i].tarif; 
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "serv"+i)
		      .attr("name", "serv"+i)
		      .attr("hidden", "true"); 
		  
		  newTextBox.val(srows[i].srno+"::"+srows[i].qty+" :: "+srows[i].description+" :: "
				   +srows[i].price+" :: "+srows[i].total+" :: "+srows[i].discount+" :: "+srows[i].nettotal+" :: "+srows[i].acno+" :: ");

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
		 
		  
		  $('#descPercentage').attr('disabled', false);
			 $('#txtdiscount').attr('disabled', false);
	    	return 1;
		} 
	   */
	   function funNotify(){	

			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriodchk(maindate);
			   if(validdate==0){
			   return 0; 
			   }
			  
			  var aa=0;
		  		var rows = $("#jqxSalesOrder").jqxGrid('getrows');
		  	   for(var i=0 ; i < rows.length; i++){
		  		   if(parseInt(rows[i].prodoc)>0)  
		  		   { 
		  			  if(parseFloat(rows[i].qty)==0 || rows[i].qty=="0.00" || rows[i].qty=="" ||rows[i].qty==null || typeof(rows[i].qty)=="undefiend") 
			  	 	   {
			    		   aa=1; 
			    		   
			    		   $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "clstatus",1);
			    		   
			    		   break;
			    		   
			    		   
			  	 	   }
		  		   }
		  	   }
		  	   
		  	   
	       	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText=" Invalid Quantity ";
        		   
        		   return 0;
        		   
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   }
		  	   
		  	   
	       
			  
		 if((parseInt(document.getElementById("multimethod").value)==1))
			{	
			 save();
			}
		 else
			 {
			 save();
			 
			 
			 }
		  }
	   
		  function chkstock()
		  {
		   
		  		var rows = $("#jqxSalesOrder").jqxGrid('getrows');
		  		var list = new Array();
		  		 
		  	   for(var i=0 ; i < rows.length; i++){
		  		 
		  		   
		  		   
		  		   
		  		   if(parseInt(rows[i].prodoc)>0)  
		  		   { 
		  		 
		  		   list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty);
		  		 
		  		   }
		  	   }
		  			 
		  	  ajaxcall(list);
		  	   
		  }
		  	   

		  	 function ajaxcall(list){
		  		 var branch=document.getElementById("brchName").value;
	 
		  		 var mode=$('#mode').val();
		  		 	
		  		 	var x=new XMLHttpRequest();
		  		 	x.onreadystatechange=function(){
		  		 		if (x.readyState==4 && x.status==200)
		  		 			{
		  		 			 var items= x.responseText.trim();
		  		  
		  		 	 
		  		 		   
		  		 		    if(parseInt(items)==1)
		  			           {
		  		 		    	document.getElementById("errormsg").innerText=" Does Not Have Sufficient Stock!!";  
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
		  		 	 x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode,true);
		  				x.send();
		  			        
		  		 }

		  	   
		  	   
		  	   
		  	   

	   
	  function save(){	
		  
	 
		 
		  if($('#txtclient').val()=="")
		  {
		  document.getElementById("errormsg").innerText="Search Customer";  
		   document.getElementById("txtclient").focus();
		     
		      return 0;
		  
		  }
	  
		  var rows = $("#jqxSalesOrder").jqxGrid('getrows');
		  var termrows = $("#jqxTerms").jqxGrid('getrows');
		  
		  
		  $('#termsgridlength').val(termrows.length);
		   $('#gridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
			  
			 
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "prodg"+i)
		      .attr("name", "prodg"+i)
		      .attr("hidden", "true");        
		   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
		   
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice 
				              +"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid
				              +"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].unitprice1+"::"+rows[i].disper1+"::"+rows[i].foc
				              +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+000+"::"+rows[i].collectqty+"::");
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
		  
		  var srows = $("#jqxserviceGrid").jqxGrid('getrows');
		   $('#servgridlen').val(srows.length);
		  for(var i=0 ; i < srows.length ; i++){
		  // var myvar = rows[i].tarif; 
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "serv"+i)
		      .attr("name", "serv"+i)
		      .attr("hidden", "true"); 
		  
		  newTextBox.val(srows[i].srno+"::"+srows[i].qty+" :: "+srows[i].description+" :: "
				   +srows[i].price+" :: "+srows[i].total+" :: "+srows[i].discount+" :: "+srows[i].nettotal+" :: "+srows[i].acno+" :: ");

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
		 
		  
		  $('#descPercentage').attr('disabled', false);
			 $('#txtdiscount').attr('disabled', false);
			 
		
	    	 
			  document.getElementById("frmSalesOrder").submit(); 
	    	 
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
		  var reftype=$('#cmbreftype').val().trim();
		   
		  if(masterdoc_no>0){
			  
			  funchkforedit();
			  
			  $("#salesOrderDiv").load("salesOrderGrid.jsp?qotdoc="+masterdoc_no+"&reftype="+reftype+"&enqdoc="+refmasterdocno+"&cond=2");
			  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
			  $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
			  $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+masterdoc_no+"&formcode="+$('#formdetailcode').val());
			  var txtproductamt=document.getElementById("txtproductamt").value; 
	          var txtdiscount=document.getElementById("txtdiscount").value; 
	          var txtnettotal=document.getElementById("txtnettotal").value;
	          var orderValue=document.getElementById("orderValue").value;
			  var roundOf=document.getElementById("roundOf").value;
			  var descPercentage=document.getElementById("descPercentage").value;
			  
			  funRoundAmt(txtproductamt,"txtproductamt");
			  funRoundAmt(txtdiscount,"txtdiscount");
			  funRoundAmt(orderValue,"orderValue");
			  funRoundAmt(txtnettotal,"txtnettotal");
			  funRoundAmt(roundOf,"roundOf");
			  funRoundAmt(descPercentage,"descPercentage");
			  
		  }
		  gettaxaccount(1);
		  
	 
		  
		  
		  
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
			   var items= x.responseText;
			 
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
	  
	  
	  function getPriceGroup(){ 
			
			var clientid=document.getElementById("clientid").value;
			
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			     
			      items=items.split('####');
			           var pgid=items[0];
			           var pgcode=items[1];
			           var pgname=items[2];
			       //alert(pgname);
			           var optionspg = '';
			           if(pgname.indexOf(",")>=0){
			        	   var pgids=pgid.split(",");
			        	   var pgcodes=pgcode.split(",");
			        	   var pgnames=pgname.split(",");
			        	   /* alert(pgnames.length); */
			            for ( var i = 0; i < pgnames.length; i++) {
			            	
			            	optionspg += '<option value="' + pgids[i] + '">' + pgnames[i] + '</option>';
			           }
			            //$("select#cmbprice").html(optionspg);
			            
			        }
			   
			     /*      else
			      {
			        	  optionspg += '<option value="' + pgid + '"selected>' + pgname + '</option>';
			           $("select#cmbprice").html(optionspg);
			       			       
			      } */
			    }
			       }
			   x.open("GET","getPriceId.jsp?clientid="+clientid,true);
				x.send();
			        
			      
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
			  $('#psearch').attr('disabled', false );
			    $("#jqxSalesOrder").jqxGrid('clear');
				 $("#jqxSalesOrder").jqxGrid('addrow', null, {});
			  
		  }
		  else{
			  
			  $('#rrefno').attr('disabled', false);
			  $('#psearch').attr('disabled', true );
			  $('#user_namess').attr('disabled', true);
				 $('#pass_wordss').attr('disabled', true);
				 $('#dscper').attr('disabled', true);
				 $('#process').attr('disabled', true);
				 $('#changeuser').attr('disabled', true);
			  
			   $("#jqxSalesOrder").jqxGrid('clear');
				 $("#jqxSalesOrder").jqxGrid('addrow', null, {});
		  }
		  
	  }
	  
	  function gridLoad(){
		  var dtype=document.getElementById("formdetailcode").value;
		  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
	  }
	  
	 
	  
	  
	  function getrefno(event)
	  {
		  if($("#mode").val() == "A")
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
			   if($('#hidcmbbilltype').val()!="")
				  {
				  
				  
				  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
				  
				  }
			    
			   
				  if($('#hidcmbreftype').val()!="")
				  {
				  
				  
				  $('#cmbreftype').val($('#hidcmbreftype').val());
				  }
				 
				 if($('#hidcmbreftype').val()=="SQOT")
				  {
				
				  $('#rrefno').attr('disabled', false);
				  
			  $('#rrefno').attr('readonly', true);
			
				  }
			   
				 if($('#cmbreftype').val()!='DIR'){
					 $('#btnDelete').attr('disabled', true);
				 }
				
				 
				 if($('#descPercentage').val()>0)
		 		  {
		 		  document.getElementById("chkdiscount").checked = true;
		 		  
		 		  }	 
				 
		   }
	  	   
	  	   
	  	 function funcalcu()
		  	{
		  		
		  	 
		  		document.getElementById('prddiscount').value="";
		  		
		  		
		  		$('#jqxSalesOrder').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
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
		  	        
		  	                
		  	            	funRoundAmt(aa,"orderValue");
		  		
		  		 var rows = $('#jqxSalesOrder').jqxGrid('getrows');
		  	      var rowlength= rows.length;
		  	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
		  	  	
		  	 
		  	   
		  			    for(var i=0;i<rowlength;i++)
		  						  {
		  		 
		  			    	var totamt=rows[i].total;
		  			     
		  			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
		  			     
		  			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
		  			    	
		  		  
		  			    	$('#jqxSalesOrder').jqxGrid('setcellvalue',i, "dis" ,discounts);
		  			    	$('#jqxSalesOrder').jqxGrid('setcellvalue',i, "netotal" ,nettot);
		  					 
		  				  
		  						  }
		  		 
		  		 
		  		
		  	 
		  		
		  		
		  		
		  		
		  		}
		  		
		  		
		  		
		  		
		  	function funvalcalcu()
		  		{
		  		
		  		
		  		document.getElementById('prddiscount').value="";
		  		$('#jqxSalesOrder').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
		  		var  productTotal=document.getElementById('txtproductamt').value;
		  		var  descountVal=document.getElementById('txtdiscount').value;
		  	 
		  		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
		  		var netval=parseFloat(productTotal)-parseFloat(descountVal);
		  		
		  	 
		  		funRoundAmt(descper,"descPercentage");
		  		funRoundAmt(netval,"txtnettotal");
		  		
		  		funcalcu();
		  		}
	  		
	  		
	  		
/* 	  	 function roundval()
	  	{
	  			var  netTotaldown=document.getElementById('txtnettotal').value;
	  		    var roundOf=document.getElementById('roundOf').value;
	  	 
	  			 
	  			var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
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
	  			
	  			
	  			funRoundAmt(aa,"orderValue");
	  			
	  		 
	  	} */
	  	 
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
	  				 $('#btnCalculate').attr('disabled', false); 
	  		   }
	  		  
	  		   
	  				}
	  			
	  			
	  		      
	  	      });
	  		   }
	  		   else
	  		   {
	  		   document.getElementById('descPercentage').value="";
	  		   document.getElementById('txtdiscount').value="";
	  		   var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
	  		   $('#descPercentage').attr('disabled', true);
	  			 $('#txtdiscount').attr('disabled', true);
	  			 $('#btnCalculate').attr('disabled', true);
	  				$('#jqxSalesOrder').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
	  		   }
	  	   
	  		}
	  	
	  	
	  	function accountSearchContent(url) {
	  		$('#accountsearchwindow').jqxWindow('open');
	  		$.get(url).done(function(data) {
	  			$('#accountsearchwindow').jqxWindow('setContent', data);
	  			$('#accountsearchwindow').jqxWindow('bringToFront');
	  		});
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
          
            
            $('#jqxSalesOrder').jqxGrid('showcolumn', 'foc');
         
            
            
             }
               else
           {
           
                $('#jqxSalesOrder').jqxGrid('hidecolumn', 'foc');
           
           }
           
            if(parseInt(kg)>0)
           {
         
           
           $('#jqxSalesOrder').jqxGrid('showcolumn', 'kgprice');
           $('#jqxSalesOrder').jqxGrid('showcolumn', 'totwtkg');
        
           
           
            }
              else
          {
          
               $('#jqxSalesOrder').jqxGrid('hidecolumn', 'kgprice');
               $('#jqxSalesOrder').jqxGrid('hidecolumn', 'totwtkg');
          
          } 
           
           
           
            }}
        x.open("GET","checkfoc.jsp",true);
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
	 	function funwarningopen(){
		 	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
		 	       if (r){
		 	    	   $('#chkdiscount').attr('disabled', false);
		 			   
		 	    	  if(document.getElementById("chkdiscount").checked == true)
		 	    		  
		 	    		  {
		 		 		 $('#descPercentage').attr('disabled', false);
		 		 		 $('#btnCalculate').attr('disabled', false);
		 		 		 $('#txtdiscount').attr('disabled', false);
		 		 		    
		 		 		  
		 		 	 
		 	    		  }
		 		 	 
		 			   
		 			   document.getElementById("editdata").value="Editvalue";
		 			 
		 			   if(document.getElementById("cmbreftype").value=="DIR")
		 				   {
		 				  $('#process').attr('disabled', false);
		 				   }
		 			   else
		 				   {
		 				  $('#process').attr('disabled', true);
		 				   }
		 				
		 				 
		 				 
		 				 
		 			  $("#jqxSalesOrder").jqxGrid({ disabled: false});
						$("#jqxserviceGrid").jqxGrid({ disabled: false});
						$("#jqxTerms").jqxGrid({ disabled: false});
						
						$("#shipdata").jqxGrid({ disabled: false});
						
						 $("#shipdata").jqxGrid('addrow', null, {});
						
		 	      
		 	    	    $("#jqxSalesOrder").jqxGrid('addrow', null, {});
		 	    	    
		 	     
		 	    	    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
		 	    	   $("#jqxTerms").jqxGrid('addrow', null, {});
		 	    		

		 	       }
		 	      });
		 	   }
		
		  
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("saveSalesOrder");
		        
		        $("#docno").prop("disabled", false);                
		        
		  
		var win= window.open(reurl[0]+"printsalesorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
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
					  
					// $("#btnEdit").attr('disabled', true );
						
						
					} else {
					}
				}
				x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("cmbreftype").value+"&refmasterdocno="+document.getElementById("refmasterdocno").value, true);
				x.send();
			
			
			}	
			
			
			
			
			
			
			
			
			   
			function funckangeuser()
		    {
				 $("#overlay, #PleaseWait").show();

			
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();	
						
						  var item = items.split('::');
						  
						  var userid= item[0];
						 	
							var discper = item[1];
							
							
							var catid=item[2];
						  
						if(parseInt(userid)>0)
							{
							
							document.getElementById("dscper").value= discper;
							
							document.getElementById("clientcaid").value= catid;
							  $.messager.alert('Message','User Has Been Changed');
							  
							  
							  funreloadhidegrid();
								document.getElementById("checkhidegrid").value="1";
							  
				    	      return false;
							 
							}
						else
							{
							 $("#overlay, #PleaseWait").hide();
							  $.messager.alert('Message','Not Changed');
				    	      return false;
							}
					  
						
						
						
					} else {
					}
				}
				x.open("GET", "changeuser.jsp?userids="+document.getElementById("userids").value+"&pass_wordss="+document.getElementById("pass_wordss").value, true);
				x.send();
			
			
			}
			  
			function funcksalesman()
		    {
			

				
				
				
			
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						 
						 var items= x.responseText.trim();
					       var item = items.split('##');
					       

					  /*  	response.getWriter().print(saldocno+"##"+catid+"##"+userdoc+"##"+salesman+"##"+username+"##"+usgper+"##");
	 */				       
								var saldocno  = item[0];
								 	
								var catid = item[1];
								
								var userdoc = item[2];
								var salesman = item[3];
								
								var username = item[4];
								var usgper = item[5];
						
								document.getElementById("salespersonid").value=item[0];
								document.getElementById("clientcaid").value= item[1];
								
								document.getElementById("userdocno").value= item[2];
								
								document.getElementById("txtsalesperson").value=item[3];
								
								document.getElementById("user_namess").value= item[4];
								document.getElementById("userids").value= item[4];
						
								document.getElementById("dscper").value= item[5];
								
							
								document.getElementById("salesmanusgper").value= item[5];
								
							 
						
						
					} else {
					}
				}
				x.open("GET", "salesmanset.jsp?", true);
				x.send();
			
			
			}
			  
			
		 function funprocess()
		 {
			 $("#overlay, #PleaseWait").show();       
			 
				$("#jqxSalesOrder").jqxGrid({ disabled: true});
			 
			 if(parseInt(document.getElementById("checkhidegrid").value)==1)
				 {
			 var rows  = $("#jqxSalesOrder").jqxGrid('getrows');
			 var rows1 = $("#hidegrids").jqxGrid('getrows');
			 
			 for(var i=0 ; i < rows.length ; i++){ 
				 
				 for(var j=0 ; j<rows1.length ; j++){
					 
					 if(parseInt(rows1[j].doc_no)==parseInt(rows[i].prodoc))
						 {
						 
					     $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "allowdiscount",rows1[j].allowdiscount);
						 
						 break;
						 }
					 
				 }
				 
				 
			 }
	           
				 }
			 
			 
	 
			 
			 var rows = $("#jqxSalesOrder").jqxGrid('getrows');
			 
			 for(var i=0 ; i < rows.length ; i++){ 
				  
				 
		   if(parseInt(rows[i].prodoc)>0)
				 {  
			  
					
			         var dscper=document.getElementById("dscper").value;
			     	      
			     	 var allowdiscount=rows[i].allowdiscount;
			     	
			     	 var discallowper=0;
				 
			     	 
	 
					      	if(dscper!="" || dscper!=null)
					      		{
					      		 discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100); 
					      	 if(discallowper>0)
					      		 {
					            $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "discper",discallowper.toFixed(2));
					     	
					      		 }
					      		}
				
			    }  
			  
		    }
			 
			 $("#overlay, #PleaseWait").hide();
				$("#jqxSalesOrder").jqxGrid({ disabled: false});
		 } 
		 
		 
		function funreloadhidegrid()
		{
			
			 var prodsearchtype=$("#prodsearchtype").val();
	    	 var refmasterdocno=0;
	    	 var reftype=$("#cmbreftype").val();
			 var cmbprice=document.getElementById("cmbprice").value;
			 var cmbreftype=document.getElementById("cmbreftype").value;
			 var clientcaid=document.getElementById("clientcaid").value; 
			 var clientid=document.getElementById("clientid").value;
			 var dates=document.getElementById("date").value;
			 $("#hidegrid").load("hidegrid.jsp?prodsearchtype="+prodsearchtype+"&enqmasterdocno="+refmasterdocno+"&reftype="+reftype+"&cmbprice="+cmbprice+"&clientid="+clientid+"&cmbreftype="+cmbreftype+"&clientcaid="+clientcaid+"&dates="+dates);
	 	
			 $("#overlay, #PleaseWait").hide();
		}
			
		function gettaxaccounts()
		{
			
			 $("#jqxSalesOrder").jqxGrid('clear');
			    $("#jqxSalesOrder").jqxGrid('addrow', null, {});
			gettaxaccount(1);
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
		   x.open("GET","gettaxaccount.jsp?date="+document.getElementById("date").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
			x.send();
		 
		      
		        
			
		} 
		
		
		
		function funcalutax()
		{
			
			
			var tax1=document.getElementById("tax1per").value;
			var tax2=document.getElementById("tax2per").value;
			
			var tax3=document.getElementById("tax3per").value;
			
			var typeoftaken=document.getElementById("typeoftaken").value;
			 
			var st=document.getElementById("st").value;
			
			var producttotal=document.getElementById("txtnettotal").value;
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
					
					
					
					
					finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
					
					
					
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
			
			
			
					
					finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
					
 
					
					
					}
				}
				
				
			 
				
				
				
			
			funRoundAmt4(tax1val,"taxontax1"); 
			funRoundAmt4(tax2val,"taxontax2");
			funRoundAmt4(tax3val,"taxontax3");
			funRoundAmt4(finaltax,"taxtotal");
			
		 
			
			
			 	
			
		}
 
		function funRoundAmt4(value,id){
			  var res=parseFloat(value).toFixed(4);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
			 }      			
		   	
		function funckclientcat()
	    {
		

			
			
			
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					 
					 var items= x.responseText.trim();
				       var item = items.split('##');
		
					 
							
					 
					
					          document.getElementById("catid").value=item[0];
				               document.getElementById("clientcaid").value=item[0];
				               
				               document.getElementById("clientpricegroup").value=item[1];
				               var aa=item[1];
				               if(parseInt(aa)==0)
				            		   {
				            		 $('#user_namess').attr('disabled', false);
									 $('#pass_wordss').attr('disabled', true);
									 $('#dscper').attr('disabled', false);
									 $('#process').attr('disabled', true);
									 
									 $('#changeuser').attr('disabled', false);
									 funcksalesman();
									 
				            		   }   
				               else
				            	   {
				            	   
				            	  
				            		 $('#user_namess').attr('disabled', true);
									 $('#pass_wordss').attr('disabled', true);
									 $('#dscper').attr('disabled', true);
									 $('#process').attr('disabled', true);
									 $('#changeuser').attr('disabled', true);
				            	   }
				               
							
						 
					
					
				} else {
				}
			}
			x.open("GET", "clientcatchk.jsp?cldocno="+document.getElementById("clientid").value, true);
			x.send();
		
		
		}
	 
		function setgrid()
		 {
			
			   
			 
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
         	  
     		var rows1 = $("#jqxSalesOrder").jqxGrid('getrows');
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
  		 document.getElementById("stockmsg").innerText="";  

				 
		     document.getElementById("jqxInput1").focus();
  			 
  		   return 0;
  		   
  		   
  		   
  		   }
  	   else
  		   {
  		   document.getElementById("errormsg").innerText="";
  		   }
  	    
			
			
			
			 var rows = $('#jqxSalesOrder').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
		     
		
		    
		    var quantity=document.getElementById("quantity").value;
		    var focs=0;
		    var totalstock=document.getElementById("totalstock").value;
		    
			if(quantity=="" || quantity==null || quantity=="0.00" || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			
			if(focs=="" || focs==null || focs=="0.00" || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
			{
				focs=0;
				
				
			}
			if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
			{
				totalstock=0;
			}
			
			 var aoq=100;
		    
			
 
			
		    if(parseFloat(document.getElementById("uprice").value)>0)
	    	{
	    	
	    	}
	    else
	    	{
	    	document.getElementById("errormsg").innerText="unit price is required";
	    	document.getElementById("uprice").focus();
	   	     return 0;
	    	}
	     
			
		     $('#datas3').val(1);
		
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "allowdiscount",aoq);
		     
		     
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		   //  $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "collectqty", document.getElementById("collqty").value);
		   
		  //   $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
		     
		     
		     
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("totamt").value);
		     
		     if(parseFloat(document.getElementById("dispers").value)>0)    		 {
			     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value);  
			     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "dis", document.getElementById("dict").value);
			     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);	 }
			     else   	 {  	  $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
					     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1,"dis", 0);
					     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("totamt").value);
			    	 
			    	 }
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "taxamount", document.getElementById("taxamountstotal").value);
		     

		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     
		     
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		     
		     $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
		     
		   
		     
		 
				  
			
				  
				  
				   document.getElementById("jqxInput").value ="";
				   document.getElementById("jqxInput1").value="";
				   document.getElementById("brand").value=""; 
		         //  document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				         
				    //  document.getElementById("focs").value="";
				     
				      document.getElementById("uprice").value="";
				      document.getElementById("totamt").value="";
				      document.getElementById("amounts").value="";
				    
				      document.getElementById("taxpers").value="";
				      document.getElementById("taxamounts").value="";
				      document.getElementById("taxamountstotal").value="";
				     
				      
				      document.getElementById("dispers").value=""
					     
					      document.getElementById("dict").value="";
				  
				      
				       document.getElementById("temppsrno").value="";
				       document.getElementById("tempspecid").value="";
				       
				       document.getElementById("stockmsg").innerText="";
				     // document.getElementById("cleardata").checked=false;
				     
				     
				     
				     var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
       			
          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
         
         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
     	funRoundAmt(orderValue,"orderValue");
     	
     	
     	if(document.getElementById("mode").value=="view" )
		{
		
		}
	else
		{

   	funRoundAmt(0,"roundOf");
		}
	
	
	
	funRoundAmt(orderValue,"orderValue");
         
      	var summaryData10= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
       
     	var aa1=summaryData10.sum.replace(/,/g,'');
 	   	
    	/*   
   	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
   	  */
   	 funRoundAmt4(aa1,"st");
   	 funRoundAmt4(aa1,"taxtotal");
				     
				       
				       $('#datas3').val(0);  
				       clearprd();
			  $("#jqxSalesOrder").jqxGrid('addrow', null, {});
		     document.getElementById("jqxInput1").focus();
		  
		 }
		
		function calculatedatas(val)
		 {
			
			document.getElementById("errormsg").innerText="";
			
			 
			
	 
			var quantity=document.getElementById("quantity").value;
			
 
		 
			var focs=0;
			
			var uprice=document.getElementById("uprice").value;
			var taxpers=document.getElementById("taxpers").value;
			var totalstock=document.getElementById("totalstock").value;
			
			
			var disper=document.getElementById("dispers").value;
			var discount=document.getElementById("dict").value;
			
			if(val=="dispers"){discount=0; }
			 if(val=="dict"){disper=0; }
			
			var totamt=0;
			var taxamounts=0;
			var taxamountstotal=0;
			
			if(quantity=="" || quantity==null || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			
			if(focs=="" || focs==null || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
			{
				focs=0;
				
				
			}
			if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
			{
				totalstock=0;
			}
			
			
			if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
			{
				disper=0;
			}
			
			
			if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN")
			{
				discount=0;
			}
			
			
			
			
			
			 
 
			
			
			
			if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
			{
				uprice=0;
			}
			 
				 
			if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
			{
				taxpers=0;
			}
			
			
			
			var netamount=0; 
			 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
				 {
				 
				 totamt=parseFloat(quantity)*parseFloat(uprice);
				/*  taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts); */
				 
				 
				 
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
			
		 
			 
			 
			 if(parseFloat(taxpers))
			 {
				 
				 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
				 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
			 }
			 else
				 {
				 taxamountstotal=netamount;
				 }
		 			 
			 document.getElementById("totamt").value=(totamt).toFixed(2);
			 document.getElementById("amounts").value=(totamt).toFixed(2);
			 document.getElementById("dispers").value=parseFloat(disper).toFixed(2);
			 document.getElementById("dict").value=parseFloat(discount).toFixed(2);
			 document.getElementById("amounts").value=(netamount).toFixed(2);
			 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
			 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
			
			 
			 if(val==1)
				 {
				// document.getElementById("focs").focus();
				 }
			 else{
				// document.getElementById("setbtn").focus();
			 }
				 
				 
			 
				 
			 
			 
		 }
		
		
		
		function calculatedata()
		 {
	 
			var quantity=document.getElementById("quantity").value;
			
			var uprice=document.getElementById("uprice").value;
			var taxpers=document.getElementById("taxpers").value;
	 
			var totamt=0;
			var taxamounts=0;
			var taxamountstotal=0;
			
			if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			 
			if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
			{
				uprice=0;
			}
			 
				 
			if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
			{
				taxpers=0;
			}
			
			 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
				 {
				 
				 totamt=parseFloat(quantity)*parseFloat(uprice);
				 taxamountstotal=totamt;
				 
				 
				 
				 }
			 if(parseFloat(taxpers))
			 {
				 
				 taxamounts=parseFloat(totamt)*(parseFloat(taxpers)/100);
				 taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts);
			 }else{
				 taxamountstotal=totamt;	 
			 }
			 
			 
			 document.getElementById("totamt").value=(totamt).toFixed(2);
			 document.getElementById("amounts").value=(totamt).toFixed(2);
			 
			 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
			 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
				 
				 
			 document.getElementById("setbtn").focus();
				 
			 
			 
		 }

		function reloads()
		{
      	 var prodsearchtype=0;
   	 var refmasterdocno="";
   	 

     		var clientid=document.getElementById("clientid").value;
     		var cmbprice="";
     		
      
    	 var clientcaid=""; 
  		 var dates=document.getElementById("date").value;
  		 
  		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
     		
     		 
  		 $("#part").load('part.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
       	
		
  		 $("#pnames").load('name.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
    	 
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
<body onload="getCurrencyIds();setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesOrder" action="saveSalesOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />
<jsp:include page="calculation.jsp"></jsp:include>
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
   <%--  <td width="8%" align="right">Sales Person</td>
    <td width="24%"><input type="text" id="txtsalesperson" name="txtsalesperson" readonly style="width:50%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td> --%>
    <td width="8%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%" >
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
    <input type="text" id="currate" name="currate" style="width:10%;" value='<s:property value="currate"/>'/>
        
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <label id="billname">Bill Type</label>&nbsp;<select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()" style="width:13%;" value='<s:property value="cmbbilltype"/>'>
      <option value="1">ST</option>
      <option value="2">CST</option> 
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
    
    
    
    </td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();"  value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
       <option value="SQOT">SQOT</option></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <%-- <td width="14%"><input type="text" id="txtreftype" name="txtreftype" style="width:85%;" value='<s:property value="txtreftype"/>'/></td> --%>
    <td>Sales Quotation
      <input type="text" id="rrefno" name="rrefno" style="width:15%;" readonly placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
     &nbsp;&nbsp;&nbsp;&nbsp;  
   <select id="cmbprice" hidden="true" name="cmbprice" style="width:10%;" value='<s:property value="cmbprice"/>'>
      <option value="1">Max Rate1</option>
       <option value="2">Mid Rate2</option>
         <option value="3">Min Rate3</option>
         </select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/></td>
      
      
    </tr>
     <tr>
    <td align="right">Del Terms</td>
    <td colspan="2"><input type="text" id="delterms" name="delterms" style="width:61%;" value='<s:property value="delterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="2"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:61%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:61%;" value='<s:property value="txtdescription"/>'/> 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  
    
  </tr>
</table>
</fieldset>

<table width="96%"  id="sal"  > 
 <tr>
  <td width="7%"   align="right">Sales Person</td>  
  <td width="15%"><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:100%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
      

      <td width="7%" align="right">User Name</td>   
  <td width="16%"><input type="text" id="user_namess" name="user_namess" style="width:90%;"   autocomplete="off" placeholder="Press F3 to Search" onKeyDown="getuser(event);" value='<s:property value="user_namess"/>'>
      <input type="hidden" id="userids" name="userids" value='<s:property value="userids"/>'/>
       <input type="hidden" id="userdocno" name="userdocno" value='<s:property value="userdocno"/>'/></td>
          <td width="6%" align="right">Password</td>
  <td width="17%"><input type="text" id="pass_wordss" name="pass_wordss" class="classpass" style="width:60%;"  autocomplete="off"  value='<s:property value="pass_wordss"/>'>
   <button type="button" class="icon" id="changeuser" title="changeuser" onclick="funckangeuser();">
							<img alt="changeuser" src="<%=contextPath%>/icons/changeuser.png" width="18" height="18">
						    </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						    </td>  
       <td width="5%" align="right">Percentage</td>
       
        <td width="15%">  <input type="text" id="dscper" name="dscper"  style="width:25%;"   value='<s:property value="dscper"/>'/></td>
       
  <td width="12%" colspan="4"  >
					 &nbsp;&nbsp; <button type="button" class="icon" id="process" title="Process" onclick="funprocess();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						   </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>

</table>


 <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% " >   
   <tr> 
   <td align="center">Product ID</td>
   <td align="center" colspan="2">Product Name</td>
   <td align="center" style="width:15%;" >Brand</td>
   <td align="center">Unit</td>
    
   <td  width="6%" align="center">Qty</td>
<!--    <td align="center" class="ff">FOC</td> -->
  <td align="center"> Unit price</td>
 <td align="center">Total</td> 
   
   </tr>
  <!--   onblur="funRoundAmt(this.value,this.id);" --> 
   
    <tr><td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
 <td align="center" >   <input type="text" id="brand"   > <input type="hidden" id="collqty"    ></td>
<td align="center"> <select    id="unit"   onchange="closes()"  >   </select>      </td>  
<td align="center" hidden="true" class="ff1"> <input type="button" id="loads" class="myButtons" value="Load Data" >     </td> 


<td width="6%" align="center">   <input type="text"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  id="quantity" style="text-align: left;" onchange="calculatedatas(1);"  ></td>
    <input type="hidden" id="focs"   onchange="calculatedatas(2);"   >
 <td align="center">   <input type="text"      id="uprice"       onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedatas(this.id);"  style="text-align: right;" ></td>
 
 <td align="center">  <input type="text" id="totamt" tabindex="-1"      style="text-align: right;"   > </td>
 

 </tr>
 <tr>
    
   <td align="center">Discount% </td>
      <td align="center">Discount</td>  
  <td align="center">Net Amount</td>  
 
     
<td align="center">Tax%</td>  
<td align="center">Tax Amount</td>  
  <td    align="center">Net Total</td>    
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>    
 </tr>
 <tr>
  
 
 
 
 
 


  <td align="center">   <input type="text" id="dispers"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedatas(this.id);"  style="text-align: right;"  ></td>
<td align="center">   <input type="text" id="dict"  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   onchange="calculatedatas(this.id);"    style="text-align: right;"  ></td>
 
 <td align="center"><input type="text" id="amounts" tabindex="-1"     style="text-align: right;" ></td>
 <td align="center"> <input type="text" id="taxpers"  tabindex="-1"      style="text-align: right;" ></td>  
 
 <td align="center"> 
 <input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
  <td align="center"> 
 <input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>  
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 </tr>  
   
   </table> 
   </fieldset> 

<fieldset><legend>Product Details</legend>
<div id="salesOrderDiv"><center><jsp:include page="salesOrderGrid.jsp"></jsp:include></center></div> 


</fieldset>
 
<div id="hidegrid" hidden="true" ><center><jsp:include page="hidegrid.jsp"></jsp:include></center></div>

<fieldset>
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

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundvals();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset>




 <fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset>


<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table>
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
<fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
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
<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset> --%>




 
<input type="hidden" id="clientcaid" name="clientcaid"  value='<s:property value="clientcaid"/>'/>
<input type="hidden" id="clientcatname" name="clientcatname"  value='<s:property value="clientcatname"/>'/>
<input type="hidden" id="clientpricegroup" name="clientpricegroup"  value='<s:property value="clientpricegroup"/>'/>

<input type="hidden" id="salesmancatid" name="salesmancatid"  value='<s:property value="salesmancatid"/>'/>          <!--    not use -->
<input type="hidden" id="salesmanusgper" name="salesmanusgper"  value='<s:property value="salesmanusgper"/>'/>    <!--    not use -->

 <input type="hidden" id="checkhidegrid" name="checkhidegrid"  value='<s:property value="checkhidegrid"/>'/>





 <input type="hidden" id="totalstock" name="totalstock"  value='<s:property value="totalstock"/>'/>
  
  
        <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
 
        <input type="hidden" id="tempunitdocno" > 
  
  <label id="stockmsg" name="stockmsg" class="blink" style="position:fixed;z-index:1000;right:310px;top:25px;color:#003300;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;">  </label>
  
   


 
 <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>'/> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/> 
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
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
  
  
  
    
 <input type="hidden" id="typeoftaken"> <!-- valuebased -->
 <input type="hidden" id="tax1per"> <!-- first tax % -->
 <input type="hidden" id="tax2per"><!--  sec tax % -->
 <input type="hidden" id="tax3per"><!--  tird tax % -->
 
</div>
<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
</form>
	
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
<div id="accountsearchwindow">
	<div></div>
</div>
 

<div id="tremwndow">
			<div></div>
		</div>

  <div id="userwindow">
	   <div ></div>
	</div>

</div>
</body>
</html>
 