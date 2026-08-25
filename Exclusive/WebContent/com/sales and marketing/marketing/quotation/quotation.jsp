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

</style>

 <%
 
 String masterdoc_no=request.getParameter("masterdoc_no");
 String checkval=request.getParameter("checkval");
 String branchvals=request.getParameter("branchvals");
 




 %>
<script type="text/javascript">
	$(document).ready(function() {

  		 $('#btnvaluechange').hide();
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 refChange();
		 getCurrencyIds();
		 chkfoc();
		 
		/* /*  $("#btnEdit").attr('disabled', true ); */ 
		 document.getElementById("checkhidegrid").value="0";
		 $('#userwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		 $('#userwindow').jqxWindow('close');  
		 $('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 $('#sidesearchwndow').jqxWindow({  width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');
	     
	     $('#accountsearchwindow').jqxWindow({
	 		width : '50%',
	 		height : '58%',
	 		maxHeight : '70%',
	 		maxWidth : '50%',
	 		title : 'Account Search',
	 		position : {
	 			x : 600,
	 			y : 87
	 		},
	 		theme : 'energyblue',
	 		showCloseButton : true,
	 		keyboardCloseKey : 27
	 	});
	 	$('#accountsearchwindow').jqxWindow('close');
	     
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
			$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
				x : 420,
				y : 87
			}, keyboardCloseKey: 27});
		     $('#searchwndow').jqxWindow('close');  
			 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
			
		 getCurrencyIds();
		 
		 $('#date').on('change', function (event) {
			  
			    var maindate = $('#date').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });

		 $('#txtclient').dblclick(function(){
			   
		    	if($('#mode').val()!= "view")
		    		{
			  	  CustomerSearchContent('clientINgridsearch.jsp');
		    		}
		  });
		 $('#user_namess').dblclick(function(){
			 
			 	if($('#mode').val()!= "view")
					{
			 		 
				usersearchcontent('searchuser.jsp?'); 
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
		    		
		    		var checkval='<%=checkval%>';
					 if(checkval=="open")
						 {
						 return 0;
						 }

		    		  var clientid=document.getElementById("clientid").value;
		  			
		  			if(clientid>0){
		  				
		  				document.getElementById("errormsg").innerText="";
		  				
		  			}
		  			else{
		  				document.getElementById("errormsg").innerText="Select a client";
		  				
		  				return 0;
		  			}
		  			
		    		
		    		$('#refnosearchwindow').jqxWindow('open');
		    		refsearchContent('refnosearch.jsp');
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
			  
			//	 $("#btnEdit").attr('disabled', true );
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	
	
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
		 
			$('#frmQuotation input').attr('readonly', true );
			$('#frmQuotation select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxQuotation").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
			$("#jqxserviceGrid").jqxGrid({ disabled: true});
			 
			$('#btnvaluechange').hide();
			 $('#chkdiscount').attr('disabled', true);	 
			 $('#btnCalculate').attr('disabled', true);
			

		     $('#user_namess').attr('disabled', true);
		
			 $('#dscper').attr('disabled', true);
			 $('#process').attr('disabled', true);
			 $('#changeuser').attr('disabled', true);
			 
			 $('#process1').attr('disabled', true);
			 
			var masterdoc_no='<%=masterdoc_no%>';
			
			var checkval='<%=checkval%>';
			 if(checkval=="open")
				 {
				/*  $("#btnCreate").click(); */
				 /* $( "#btnCreate" ).trigger( "click" ); */
				 
				// enqmasterdocno rrefno txtclient txtclientdet clientid
				 
				 funCreateBtn();
				 
				 }
			
			
			
	 }
	 
	 function funRemoveReadOnly(){
		 
		 document.getElementById("editdata").value="";
			if ($("#mode").val() == "A") {
		 gridLoad();
			}
			 chkmultiqty();
			gettaxaccount(1);	
			getround();
			$('#frmQuotation input').attr('readonly', false );
			$('#frmQuotation select').attr('disabled', false);
			
			
			
			$('#st').attr('readonly', true );
			$('#taxontax1').attr('readonly', true );
			$('#taxontax2').attr('readonly', true );
			$('#taxontax3').attr('readonly', true );
			$('#taxtotal').attr('readonly', true );
			 $('#process1').attr('disabled', false);
			
			
			$('#txtclient').attr('readonly', true );
			$('#rrefno').attr('readonly', true );
			$('#txtsalesperson').attr('readonly', true );
			$('#txtproductamt').attr('readonly', true );
			$('#txtdiscount').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#orderValue').attr('readonly', true );
			
			
			 $('#user_namess').attr('readonly', true );
			 $('#user_namess').attr('disabled', true);
			 $('#pass_wordss').attr('disabled', true);
			 $('#dscper').attr('disabled', true);
			 $('#process').attr('disabled', true);
			 $('#changeuser').attr('disabled', true);
			
			
			
			
			
			  $('#descPercentage').attr('disabled', true);
				 $('#txtdiscount').attr('disabled', true);
			
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxQuotation").jqxGrid({ disabled: false});   
			$("#jqxTerms").jqxGrid({ disabled: false});
			$("#jqxserviceGrid").jqxGrid('disabled', false);
			/* if ($("#mode").val() == "E") {
   			    $("#jqxQuotation").jqxGrid('addrow', null, {});
   			    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
			   $('#descPercentage').attr('disabled', false);
	  				 $('#txtdiscount').attr('disabled', false);
			
			}
			 */
			
		  	if ($("#mode").val() == "E") {
				 
		  		$("#jqxQuotation").jqxGrid({ disabled: true});
				$("#jqxserviceGrid").jqxGrid({ disabled: true});
			 
				
			   
			    
				$("#jqxTerms").jqxGrid({ disabled: true});
				 
				   $('#btnCalculate').attr('disabled', true);
				
				   $('#btnvaluechange').show();
					funckclientcat();
				   
			}  
		  
			 var masterdoc_no='<%=masterdoc_no%>';
				 
				var checkval='<%=checkval%>';
				 if(checkval=="open")
					 {	
					 
					
					 
		  	 
			 var x=new XMLHttpRequest();
		        x.onreadystatechange=function(){
		        if (x.readyState==4 && x.status==200) 	 
		         {
		           var items= x.responseText.trim();
		           var item = items.split('##');
/* 					var clientid  = item[0];
					var doc_no = item[1];
					var voc_no = item[2];
					var clientname = item[3];
					var address = item[4];
		      */
		    
		      $('#rrefno').attr('disabled', false);	
		      $('#rrefno').attr('readonly', true );
		  	document.getElementById("cmbreftype").value="CEQ";
		  	 var branchvals='<%=branchvals%>';
			 
			 document.getElementById("brchName").value=branchvals;	 
	        
					
					// enqmasterdocno rrefno txtclient txtclientdet clientid
					
					
					  document.getElementById("clientid").value=item[0];
					  document.getElementById("enqmasterdocno").value=item[1];
					  document.getElementById("rrefno").value=item[2];
					  document.getElementById("txtclient").value=item[3];
					  document.getElementById("txtclientdet").value=item[4];
					
					
					  		$("#mode").val("A");
							$("#txtproductamt").val("0.0");
							$("#txtdiscount").val("0.0");
							$("#txtnettotal").val("0.0");
							$("#nettotal").val("0.0");
							$("#descPercentage").val("0.0");
							$("#prodsearchtype").val("0");
							$("#orderValue").val("0.0");
							$("#roundOf").val("0.0");
							$('#rrefno').attr('disabled', false);
							getCurrencyIds();
							$('#date').val(new Date());
							$("#jqxTerms").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid('clear'); 
							$("#jqxserviceGrid").jqxGrid('addrow', null, {});
							 $('#chkdiscount').attr('disabled', false);	
			 
			       	
			    		
			    		
			       		  $("#quotationDiv").load("quotationGrid.jsp?enqdocs="+masterdoc_no);	
 
		           
		            }
		        }
		        x.open("GET","getenqdata.jsp?masterdoc_no="+masterdoc_no,true);
		      x.send();
		      
		           
					 }
				 else
					 {
			
			
						if ($("#mode").val() == "A") {
							
							$("#txtproductamt").val("0.0");
							$("#txtdiscount").val("0.0");
							$("#txtnettotal").val("0.0");
							$("#nettotal").val("0.0");
							$("#descPercentage").val("0.0");
							$("#prodsearchtype").val("0");
							$("#orderValue").val("0.0");
							$("#roundOf").val("0.0");
							$('#rrefno').attr('disabled', true);
							getCurrencyIds();
							$('#date').val(new Date());
							$("#jqxTerms").jqxGrid({ disabled: false});
							$("#jqxQuotation").jqxGrid('clear'); 
							$("#jqxQuotation").jqxGrid('addrow', null, {});
							$("#jqxserviceGrid").jqxGrid({ disabled: false});
							$("#jqxserviceGrid").jqxGrid('clear'); 
							$("#jqxserviceGrid").jqxGrid('addrow', null, {});
							 $('#chkdiscount').attr('disabled', false);	 
							 
							 
							 $("#hidegrids").jqxGrid('clear'); 
							 
							 
							 
							 
						}
					 }
			
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
	        $('#frmQuotation').validate({
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

	  function funNotify(){	
		  
		  
			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriodchk(maindate);
			   if(validdate==0){
			   return 0; 
			   }

		  if($('#txtclient').val()=="")
			  {
			  document.getElementById("errormsg").innerText="Search Customer";  
			   document.getElementById("txtclient").focus();
			     
			      return 0;
			  
			  }
		  
		  
		  var rows = $("#jqxQuotation").jqxGrid('getrows');
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
		   
		  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"
				  +rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"
				  +rows[i].outqty+"::"+rows[i].oldqty+"::"+rows[i].unitprice1+"::"+rows[i].disper1+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+rows[i].taxdocno+"::"+"0000"+"::");
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
		  $('#descPercentage').attr('disabled', false);
			 $('#txtdiscount').attr('disabled', false);
			 
			 
		
	    	return 1;
			
		} 
	  
	  
	  function setValues(){
		  document.getElementById("formdetail").value="Sales Quotation";
	   		document.getElementById("formdetailcode").value="SQOT";  
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
		  var enqmasterdocno=$('#enqmasterdocno').val().trim();
		  var dtype=$('#formdetailcode').val().trim();
		  var refdtype=$('#cmbreftype').val();
		  if(masterdoc_no>0){
			  funchkforedit();
			  $("#quotationDiv").load("quotationGrid.jsp?qotdoc="+masterdoc_no+"&refdtype="+refdtype+"&enqdoc="+enqmasterdocno+"&cond=2");
			  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
			  $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
			  
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
		  
		  
			var checkval='<%=checkval%>';
			
			var branchvals='<%=branchvals%>';
			 
	/* 		if(checkval=="open")
				 {	
				 
			 
				 document.getElementById("brchName").value="";
				 
				 document.getElementById("brchName").value=branchvals;
			 
				 } */

				  gettaxaccount(1);
				funSetlabel();
			
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
		 	if($('#mode').val()== "A")
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
				  if($('#hidcmbreftype').val()!="")
				  {
				  
				  
				  $('#cmbreftype').val($('#hidcmbreftype').val());
				  }
				   if($('#hidcmbbilltype').val()!="")
					  {
					  
					  
					  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
					  
					  }
				    
				 
				 if($('#hidcmbreftype').val()!="DIR")
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
	  		
	  		
	  		$('#jqxQuotation').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
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
	  		
	  		 var rows = $('#jqxQuotation').jqxGrid('getrows');
	  	      var rowlength= rows.length;
	  	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	  	  	
	  	 
	  	   
	  			    for(var i=0;i<rowlength;i++)
	  						  {
	  		 
	  			    	var totamt=rows[i].total;
	  			     
	  			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
	  			     
	  			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
	  			    	
	  		  
	  			    	$('#jqxQuotation').jqxGrid('setcellvalue',i, "dis" ,discounts);
	  			    	$('#jqxQuotation').jqxGrid('setcellvalue',i, "netotal" ,nettot);
	  					 
	  				  
	  						  }
	  		 
	  		 
	  		
	  	 
	  		
	  		
	  		
	  		
	  		}
	  		
	  		
	  		
	  		
	  	function funvalcalcu()
	  		{
	  		
	  		
	  		document.getElementById('prddiscount').value="";
	  		$('#jqxQuotation').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
	  		var  productTotal=document.getElementById('txtproductamt').value;
	  		var  descountVal=document.getElementById('txtdiscount').value;
	  	 
	  		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	  		var netval=parseFloat(productTotal)-parseFloat(descountVal);
	  		
	  	 
	  		funRoundAmt(descper,"descPercentage");
	  		funRoundAmt(netval,"txtnettotal");
	  		
	  		funcalcu();
	  		}
	  		
	  		
/* 	  		
	  	 function roundval()
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
	  		   var summaryData3= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
	  		   $('#descPercentage').attr('disabled', true);
	  			 $('#txtdiscount').attr('disabled', true);
	  				$('#jqxQuotation').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
	  		   }
	  	   
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
          
            
            $('#jqxQuotation').jqxGrid('showcolumn', 'foc');
         
            
            
             }
               else
           {
           
                $('#jqxQuotation').jqxGrid('hidecolumn', 'foc');
           
           }
           
            if(parseInt(kg)>0)
           {
         
           
           $('#jqxQuotation').jqxGrid('showcolumn', 'kgprice');
           $('#jqxQuotation').jqxGrid('showcolumn', 'totwtkg');
        
           
           
            }
              else
          {
          
               $('#jqxQuotation').jqxGrid('hidecolumn', 'kgprice');
               $('#jqxQuotation').jqxGrid('hidecolumn', 'totwtkg');
          
          } 
           
           
           
            }}
        x.open("GET","checkfoc.jsp",true);
      x.send();
      
           
             
         
        }
	  	
	  	
	  	function accountSearchContent(url) {
	  		$('#accountsearchwindow').jqxWindow('open');
	  		$.get(url).done(function(data) {
	  			$('#accountsearchwindow').jqxWindow('setContent', data);
	  			$('#accountsearchwindow').jqxWindow('bringToFront');
	  		});
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
	 			 

	 	 
	 				  $('#process').attr('disabled', false);
	 		 
	 			 
	 					$("#jqxTerms").jqxGrid({ disabled: false});
	 					 
	 	    		$("#jqxQuotation").jqxGrid({ disabled: false});
	 	    		
	 	    		$("#jqxserviceGrid").jqxGrid({ disabled: false});
	 	    		
	 	      
	 	    	    $("#jqxQuotation").jqxGrid('addrow', null, {});
	 	    	    
	 	     
	 	    	    $("#jqxserviceGrid").jqxGrid('addrow', null, {});
	 	    	    

	 	    	    $("#jqxTerms").jqxGrid('addrow', null, {});
	 	    	    
	 	    		

	 	       }
	 	      });
	 	   }
	
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("saveQuotation");
		        
		        $("#docno").prop("disabled", false);                
		        
		  
		var win= window.open(reurl[0]+"printqoteaction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
		win.focus();
		 	   } 
		 	  
		 	   else {
			    	      $.messager.alert('Message','Select a Document....!','warning');
			    	      return false;
			    	     }
			    	
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
			 
				$("#jqxQuotation").jqxGrid({ disabled: true});
			 
			 if(parseInt(document.getElementById("checkhidegrid").value)==1)
				 {
			 var rows  = $("#jqxQuotation").jqxGrid('getrows');
			 var rows1 = $("#hidegrids").jqxGrid('getrows');
			 
			 for(var i=0 ; i < rows.length ; i++){ 
				 
				 for(var j=0 ; j<rows1.length ; j++){
					 
					 if(parseInt(rows1[j].doc_no)==parseInt(rows[i].prodoc))
						 {
						 
					     $('#jqxQuotation').jqxGrid('setcellvalue', i, "allowdiscount",rows1[j].allowdiscount);
						 
						 break;
						 }
					 
				 }
				 
				 
			 }
	           
				 }
			 var rows = $("#jqxQuotation").jqxGrid('getrows');
			 
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
					      		 
					            $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper",discallowper.toFixed(2));
					      			 }
							  
					      		}
				
			    }  
			  
		    }
			 
			 $("#overlay, #PleaseWait").hide();
				$("#jqxQuotation").jqxGrid({ disabled: false});
		 } 
		 
		 
		function funreloadhidegrid()
		{
			
			 var prodsearchtype=$("#prodsearchtype").val();
	    	 var refmasterdocno=$("#rrefno").val();;
	    	 var reftype=$("#cmbreftype").val(); 
			 var cmbprice="";
			 var cmbreftype=document.getElementById("cmbreftype").value;
			 var clientcaid=document.getElementById("clientcaid").value; 
			 var clientid=document.getElementById("clientid").value;
			 var dates=document.getElementById("date").value;
			 $("#hidegrid").load("hidegrid.jsp?prodsearchtype="+prodsearchtype+"&enqmasterdocno="+refmasterdocno+"&reftype="+reftype+"&cmbprice="+cmbprice+"&clientid="+clientid+"&cmbreftype="+cmbreftype+"&clientcaid="+clientcaid+"&dates="+dates);
	 	
			 $("#overlay, #PleaseWait").hide();
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
		function gettaxaccounts()
		{
			 $("#jqxQuotation").jqxGrid('clear');
			    $("#jqxQuotation").jqxGrid('addrow', null, {});
			gettaxaccount(1);
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
<form id="frmQuotation" action="saveQuotation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />
<jsp:include page="calculation.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include> 
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<%-- <table width="100%">
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
</table> --%>
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
    <td width="21%"><input type="text" id="docno" name="docno" style="width:25%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="9%" align="right">Customer</td>
    <td width="15%"><input type="text" id="txtclient" name="txtclient" readonly style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td><input type="text" id="txtclientdet" name="txtclientdet" style="width:53%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
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
     <label id="billname">Bill Type</label>&nbsp;<select id="cmbbilltype" name="cmbbilltype"  style="width:13%;" value='<s:property value="cmbbilltype"/>' onchange="gettaxaccounts()">
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
       <option value="CEQ">CEQ</option>
       <!-- <option value="RFQ">RFQ</option> --></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <%-- <td width="14%"><input type="text" id="txtreftype" name="txtreftype" style="width:85%;" value='<s:property value="txtreftype"/>'/></td> --%>
    <td><div id="se">Ref No
      <input type="text" id="rrefno" name="rrefno" style="width:25%;" readonly placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/></div></td>
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
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    </td>
  </tr>
</table>
</fieldset>

<table width="96%"   > 
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


<fieldset><legend>Product Details</legend>
<div id="quotationDiv"><center><jsp:include page="quotationGrid.jsp"></jsp:include></center></div>   
</fieldset>
 
<div id="hidegrid"   hidden="true"  ><center><jsp:include page="hidegrid.jsp"></jsp:include></center></div>

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


 
 <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>'/>
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>          
<input type="hidden" id="enqmasterdocno" name="enqmasterdocno"  value='<s:property value="enqmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
<input type="hidden" id="termsgridlength" name="termsgridlength"  value='<s:property value="termsgridlength"/>'/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
 <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
 
 
 
  
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
<div id="accountsearchwindow">
			<div></div>
		</div>	
</div>

  <div id="userwindow">
	   <div ></div>
	</div>
</div>
</body>
</html>
