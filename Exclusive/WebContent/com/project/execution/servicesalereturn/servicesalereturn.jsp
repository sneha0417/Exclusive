	<%@ taglib prefix="s" uri="/struts-tags" %>
	<!DOCTYPE html>
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
	</style>
	<script type="text/javascript">
	
	$(document).ready(function () { 
	    getAccountTypeEntity();
		   /* Date */ 	
	    $("#nipurchasedate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	    
	    $("#invDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	    
	    
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '75%',  maxHeight: '74%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	    $('#accountSearchwindow').jqxWindow('close');
		$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	    $('#accounttypeSearchwindow').jqxWindow('close');
	    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
	    $('#costtpesearchwndow').jqxWindow('close');   
	    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
	    $('#costcodesearchwndow').jqxWindow('close');  
	    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
	    $('#refnosearchwindow').jqxWindow('close');  
	    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
	    $('#nipurchslnosearch').jqxWindow('close');
	    getCurrencyIds($("#nipurchasedate").val());
	     
/* 		  	 $('#nipuraccid').dblclick(function(){
		  		if($('#mode').val()!= "view")
	    		{
			  	    $('#accountSearchwindow').jqxWindow('open');
			 
			
			  	  accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());
	    		} 
	  });   
		  	  */
		  	 
		  	 $('#rrefno').dblclick(function(){
		     	
		     	if($('#mode').val()!= "view")
		 		{
		 	  	    $('#refnosearchwindow').jqxWindow('open');
		 	 
		 	
		 	  	  refnoSearchContent('ordermainsearch.jsp?');
		 		}
		     }); 
	});
				function getAccountTypeEntity(){
				    var x = new XMLHttpRequest();
				    x.onreadystatechange = function() {
				     if (x.readyState == 4 && x.status == 200) {
				          var items = x.responseText.trim();
				          if(items==1){
				          	$("#typetd1").show();
				          	$("#typetd2").show();
				          }
				          else{
				        	  $("#typetd1").hide();
				        	  $("#typetd2").hide();
				          }
				     }
				    }
				    x.open("GET", "getAccountTypeEntity.jsp", true);
				    x.send();
				}
	
				function getNonTaxableEntity(){
				    var x = new XMLHttpRequest();
				    x.onreadystatechange = function() {
				     if (x.readyState == 4 && x.status == 200) {
				          var items = x.responseText.trim();
				          $('#txtnontaxableentity').val(items);
				          if(parseInt($('#txtnontaxableentity').val().trim())==1){
				        	  getTaxper($("#nipurchasedate").jqxDateTimeInput('val'));
				          }
				     }
				    }
				    x.open("GET", "getNonTaxableEntity.jsp", true);
				    x.send();
				}
				function refnoSearchContent(url) {
					 //alert(url);
						 $.get(url).done(function (data) {
							 
							 $('#refnosearchwindow').jqxWindow('open');
						$('#refnosearchwindow').jqxWindow('setContent', data);
				
					}); 
					} 				function getrefnosearch(event){
						 var x= event.keyCode;
							if($('#mode').val()!= "view")
				    		{
								 if(x==114){
								  $('#refnosearchwindow').jqxWindow('open');
							
							
								  refnoSearchContent('ordermainsearch.jsp?');   }
								 else{
									 }
				    		}
						 }  
				
				function getTaxper(date){
					var x = new XMLHttpRequest();
				    x.onreadystatechange = function(){
					    if (x.readyState == 4 && x.status == 200) {
						    var items = x.responseText.trim();
						    $('#taxperc').val(items);
					    }
				    }
				   x.open("GET", "getTaxper.jsp?date="+date, true);
				   x.send();
				}
					 function costcodeSearchContent(url) {
							 $.get(url).done(function (data) {
								 $('#costcodesearchwndow').jqxWindow('open');
								 $('#costcodesearchwndow').jqxWindow('setContent', data);
							 }); 
					 }  
	
						function costSearchContent(url) {
								 $.get(url).done(function (data) {
									 $('#costtpesearchwndow').jqxWindow('open');
									 $('#costtpesearchwndow').jqxWindow('setContent', data);
								 }); 
						} 
							
						function CashSearchContent(url) {
							 //alert(url);
								 $.get(url).done(function (data) {
									 $('#accounttypeSearchwindow').jqxWindow('open');
									 $('#accounttypeSearchwindow').jqxWindow('setContent', data);
								 }); 
						} 
						function getaccountdetails(event){
							var x= event.keyCode;
						 	if($('#mode').val()!= "view")
				    		{
						 		if(x==114){
						 			$('#accountSearchwindow').jqxWindow('open');
						 			accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val());  
							 	 }
							 	 else{
							 	 }
				    		} 
						}  
						function accountSearchContent(url) {
							$.get(url).done(function (data) {
								$('#accountSearchwindow').jqxWindow('setContent', data);
							}); 
						}
						function nipurhsaeslnocontent(url) {
							$.get(url).done(function (data) {
								$('#nipurchslnosearch').jqxWindow('open');
								$('#nipurchslnosearch').jqxWindow('setContent', data);
							}); 
						} 
		  

						function funFocus(){
							$('#nipurchasedate').jqxDateTimeInput('focus');  		
						}
			
						function funNotify(){	
							var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
							var aa=0;
							 for(var i=0 ; i < rows.length ; i++){
								 
								 if(parseFloat(rows[i].taxamount)> parseFloat(rows[i].valamount))
									 {
									 
									
									 
			    	             	aa=1;
			    	             	
			    	             	break;
			    	             	
									 }
								 
							 }
							 
							if(parseInt(aa)==1) 
								{
								
								 document.getElementById("errormsg").innerText=" Total Amount value not more than Actual Amount  ";
								 return 0;
								
								}
						 
						
						
						
							 
							
	/* 						var length=rows.length;
							if(!(typeof (rows[length-1].nettotal) == "undefined")){
								for(var i=length-1;i>=0;i--){
									if(((rows[i].netottal!="")||(rows[i].nettotal!="0.00"))&&rows[i].account==""){
										document.getElementById("errormsg").innerText=" Select an Account";
										return 0;
										i=0;
									}
									else{
										document.getElementById("errormsg").innerText="";
									}
								}
							}
							else{
								for(var i=length-2;i>=0;i--){
									if(((rows[i].nettotal!="")||(rows[i].nettotal!="0.00"))&&rows[i].account==""){
										document.getElementById("errormsg").innerText=" Select an Account";	
										return 0;
										i=0;
									}
									else{
										document.getElementById("errormsg").innerText="";
									}
								}
							}
							
							 */
							
							
							
							
							var refno= document.getElementById('refno').value;
							if(refno=="")
							{
								document.getElementById("errormsg").innerText=" Enter Ref NO";	
								document.getElementById('refno').focus();
								return 0;
							}
							else
							{
								document.getElementById("errormsg").innerText="";
							}
							var purid= document.getElementById("nipuraccid").value;
							if(purid=="")
							{
								 document.getElementById("errormsg").innerText=" Select An Account";
								 document.getElementById("nipuraccid").focus();
								 return 0;
							}
							else
							{
								document.getElementById("errormsg").innerText="";
							} 
							var invno= document.getElementById("invno").value;
							if(invno=="")
							{
								 document.getElementById("errormsg").innerText=" Enter PO NO";
								 document.getElementById("invno").focus();
								 return 0;
							}
							else
							{
								   document.getElementById("errormsg").innerText="";
							} 
							 var refval= document.getElementById("nettotal").value;
							 if(refval=="" || refval=="0" || refval==0)
							 {
								 document.getElementById("errormsg").innerText="Net Total Empty";
								 return 0;
							 }
							else
							{
								   document.getElementById("errormsg").innerText="";
							}
							 var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
							 $('#nidescdetailslenght').val(rows.length);
							 for(var i=0 ; i < rows.length ; i++){
								 newTextBox = $(document.createElement("input"))
								 .attr("type", "dil")
								 .attr("id", "desctest"+i)
								 .attr("name", "desctest"+i)
								 .attr("hidden", "true"); 
								 var aa=0;
								 newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
										 +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
										 +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
										 +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].rdocno+" :: "+aa+" :: ");
								 newTextBox.appendTo('form');
							 }   
							 var x =new XMLHttpRequest();
							 x.onreadystatechange=function()
							 {
								 if(x.readyState==4 && x.status==200)	
								 {
									 var items=x.responseText;
									 var chk=items.trim();
									 
									 			chk=0;
									 if(parseInt(chk)==1)
									 {
										 document.getElementById("errormsg").innerText="";
										 document.getElementById("frmsrvsaleret").submit();
									 }
									 else
									 {
										 document.getElementById("errormsg").innerText="";
										 document.getElementById("frmsrvsaleret").submit();
									 }
								 }
							 }
							 x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
							 x.send();	
						} 
	
			/* function funchkinv()
			{
			var x =new XMLHttpRequest();
			
			x.onreadystatechange=function()
			{
			if(x.readyState==4 && x.status==200)	
			
			{
				var items=x.responseText;
				
				
				
				var chk=items.trim();
				
				
			 
				
			if(parseInt(chk)==1)
				{
				
				document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
				document.getElementById("invno").focus();
				
				return 0;
				
				}
			else
				{
				 document.getElementById("errormsg").innerText="";
				 
				 
				 
				 return 1;
				}
				
				
			
			}
			}
			
			x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
	
			x.send();
			
			}
 */			
			function funChkButton() {
				
				//frmEnquiry.submit();
			}
	
			function funSearchLoad(){
				 changeContent('Mastersearch.jsp'); 
			}
	
				function funReset(){
					//$('#frmsrvsaleret')[0].reset(); 
				}
				function funReadOnly(){
					$('#frmsrvsaleret input').attr('readonly', true );
					$('#frmsrvsaleret select').attr('disabled', true );
					 $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
					 $('#deliverydate').jqxDateTimeInput({ disabled: true});
					 
					 $('#invDate').jqxDateTimeInput({ disabled: true});
					 $('#interstate').attr('disabled', true);
					 
					  $('#cmbcurr').attr('disabled', true);
					 $('#acctype').attr('disabled', true);
					   $('#refslno').attr('disabled', true);
						$("#nidescdetailsGrid").jqxGrid({ disabled: true});
					   combochange();
					   funinterstate();
				}
				function funRemoveReadOnly(){
					funinterstate();
					getNonTaxableEntity();
					$('#frmsrvsaleret input').attr('readonly', false );
					$('#frmsrvsaleret select').attr('disabled', false );
					 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
					 $('#deliverydate').jqxDateTimeInput({ disabled: false});
					 $('#invDate').jqxDateTimeInput({ disabled: false});
					 $('#interstate').attr('disabled', false);
					  $('#cmbcurr').attr('disabled', false);
					 $('#acctype').attr('disabled', false);;
					$('#docno').attr('readonly', true);
					 $('#currate').attr('readonly', true);
					 $('#rrefno').attr('readonly', true);
					  
					 
					 
					  $('#nipuraccid').attr('readonly', true);
					  $('#puraccname').attr('readonly', true);
					   $('#refslno').attr('disabled', true);
						  $('#refslno').attr('readonly', true);
				
						$("#nidescdetailsGrid").jqxGrid({ disabled: false});
						getCurrencyIds($("#nipurchasedate").val());
						
						if ($("#mode").val() == "A") {
							
							$('#nipurchasedate').val(new Date());
							$('#deliverydate').val(new Date());
							 getCurrencyIds($("#nipurchasedate").val());
							 $("#nidescdetailsGrid").jqxGrid('clear');
							    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
						   }
					if ($("#mode").val() == "E") {
						if(document.getElementById("interstate").checked==true){
							document.getElementById("interstate").value='1';
							
							
						}
						else{
							document.getElementById("interstate").value='0';
						}
						  if($('#reftypeval').val()=="NPO")
						  {
						
						  $('#refno').attr('disabled', false);
						   $('#refslno').attr('disabled', false);
					  $('#refno').attr('readonly', true);
					   $('#refslno').attr('readonly', true);
						  }
							
						   }
					
				}
					        
			    function getCurrencyIds(a){
		        	
			        
		        	
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
		        	            var currencyid=curidItems.split(",");
		        	            var currencycode=curcodeItems.split(",");
		        	            multiItems.split(",");
		        	          
		        	          for ( var i = 0; i < currencycode.length; i++) {
		        	           optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        	           }
		        	         
		        	            $("select#cmbcurr").html(optionscurr);
		        	            
		        	            if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
		        	             $('#cmbcurr').val($('#hidcmbcurr').val()) ;
		        	            } 
		        	        	
					        	if(document.getElementById("masterdoc_no").value=="" ||   document.getElementById("ordermasterdoc_no").value>0)
					        		{
					        		 
					        	
		        	            funRoundRate(currateItems,"currate");
					        		}
						         $('#currate').attr('readonly', true);
		        	          
		        	       }
		        	   
		        	          else{
		        	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		        	           
		        	          $("select#cmbcurr").html(optionscurr);
		        	           
		        	             if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
		        	              $('#cmbcurr').val($('#hidcmbcurr').val()) ;
		        	             } 
		        	         	if(document.getElementById("masterdoc_no").value=="" ||  document.getElementById("ordermasterdoc_no").value>0)
				        		{
				        		  
		        	          funRoundRate(currateItems,"currate");
				        		}
						        
					          $('#currate').attr('readonly', true);
					          
		        	          }
		        	    }
		        	       }
		        	        x.open("GET", "getCurrencyId.jsp?date="+a,true);
		        	       x.send();
		        	      
		        	     }				        
		   function getRatevalue(angel)
		   {
		    	
	        	if(document.getElementById("masterdoc_no").value>0 || document.getElementById("ordermasterdoc_no").value>0)
	        		{
	        		return 0;
	        		}
	        	 
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      var items= x.responseText;
		   /*       $('#currate').val(items) ; */
		         
		         funRoundRate(items,"currate");  
		         
		        }
		          else
		      {
		      }
		       }
		   x.open("GET","getRateTo.jsp?curr="+a,true);
			x.send();
		        
		      
		        }
					   function funrefdisslno()
					   {
						   
							 $("#nidescdetailsGrid").jqxGrid('clear');
							    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
							 
						   
						   if($('#nireftype').val()=="NPO") 
							  {
							   $('#refno').attr('disabled', false);
							   $('#refslno').attr('disabled', false);
							 
							 
							  } 
						   else
							   {
							   $('#refno').val(" ");
							   $('#refslno').val(" ");
							   $('#refno').attr('disabled', true);
							   $('#refslno').attr('disabled', true);
							   
							   }
					   }
					   function combochange()
					   {
						   if($('#cmbcurrval').val()!="")
							  {
							  
							  
							  $('#cmbcurr').val($('#cmbcurrval').val());
							  }
						   if($('#acctypeval').val()!="")
							  {
							  
							  
							  $('#acctype').val($('#acctypeval').val());
							  }
						   if($('#reftypeval').val()!="")
							  {
							  
							  
							  $('#nireftype').val($('#reftypeval').val());
							  
							  if($('#reftypeval').val()=="NPO")
								  {
								
								  $('#refno').attr('disabled', false);
								   $('#refslno').attr('disabled', false);
							  $('#refno').attr('readonly', true);
							   $('#refslno').attr('readonly', true);
								  }
							  }
						   
						   
					   }
					   function funinterstate()
						{
							
						   var x=new XMLHttpRequest();
							x.onreadystatechange=function(){
								if (x.readyState==4 && x.status==200)
									{
							       var items= x.responseText.trim();
							       //alert("items"+items);
							       if(parseInt(items)>0){
							    	   $('#interdiv').hide();
										// $('#interstate').attr('disabled', false);
										
							       }
									else{
										$('#interdiv').hide();
										
									}
									}
								else{
									
								}
								}
						x.open("GET","interstate.jsp?",true);
	
						x.send();
								
						}
					   function setValues() {
						  /*  if(document.getElementById("interstate").checked=true){
							   $('#interstate').val()=='1';
						   }
						   else{
							   $('#interstate').val()=='0';
						   } */
						   funinterstate();
						 
						   $('#nipurchasedate').jqxDateTimeInput({disabled: false});
						    var date = $('#nipurchasedate').val();
						    getCurrencyIds(date);
						    $('#nipurchasedate').jqxDateTimeInput({disabled: true});
						   
						   if($('#hidnipurchasedate').val()){
								$("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
							}
							
							if($('#hiddeliverydate').val()){
								$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
							}
							
							
							
							
							if($('#hidinvDate').val()){
								
								$("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
							}
	                       var interstate=document.getElementById("hidinterstate").value;
							
							if(interstate>0){
								document.getElementById("interstate").checked=true;
							}
							else{
								document.getElementById("interstate").checked=false;
							}
							
							
						 	var dis=document.getElementById("masterdoc_no").value;
							if(dis>0)
								{     
								
						 	 var indexval1 = document.getElementById("masterdoc_no").value;   
						 	 var indexval11 = document.getElementById("ordermasterdoc_no").value;   
								
					     	  		 
						 	 
					     	  	
					     	  		 $("#nipurdetails").load("descgridDetails.jsp?maindoc="+indexval1+"&rdocno="+indexval11);
					     	  		
								 } 
				
							 if($('#msg').val()!=""){
								   $.messager.alert('Message',$('#msg').val());
								  } 
							 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
							       combochange();
						}
					   $(function(){
					        $('#frmsrvsaleret').validate({
					                rules: { 
					              
					               	delterms:{maxlength:200},
					                	purdesc:{maxlength:200},
					                	payterms:{maxlength:200}
					                   
					                 },
					                 messages: {
					                	 delterms: {maxlength:"  Max 200 chars"},
					                	 purdesc: {maxlength:"  Max 200 chars"},
					                	 payterms: {maxlength:"  Max 200 chars"}
					                	
					                 }
					        });});
					   /*function diserror(){
						   document.getElementById("errormsg").innerText="";
					   } */
 
					   
					   
					   function funPrintBtn(){
					 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
					 	  
					 	   var url=document.URL;

					        var reurl=url.split("com");
					        
					        
					        $("#docno").prop("disabled", false);                
					        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
						     var dtype=$('#formdetailcode').val();
						  
									 var win= window.open(reurl[0]+"PRINTServiceSaleret?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						     
					  
					/* var win= window.open(reurl[0]+"printpurchaseorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					   */   
					win.focus();
					 	   } 
					 	  
					 	   else {
						    	      $.messager.alert('Message','Select a Document....!','warning');
						    	      return false;
						    	     }
						    	
					 	}
							   
	</script>
	</head>
	<body onload="setValues();" >
	
	
	<div id="mainBG" class="homeContent" data-type="background">
	<form id="frmsrvsaleret" action="savesrvsaleret" method="post" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />    
		<br/> 
		<fieldset>
	<table width="100%"     >
	
	  <tr>
	    <td width="3%" align="right">Date</td>
	    <td width="4%" align="left">
	    	<div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
	    	<input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
	    </td>
	    
	    <td align="right" width="8%" >Ref Type</td>
    <td align="left" width="10%" ><select name="nireftype" id="nireftype" style="width:99%;"  value='<s:property value="nireftype"/>'  >
     
      <option value="SRS" >SRS</option>
    </select></td>
     
    <td align="left" width="15%" > <input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:95%;" value='<s:property value="rrefno"/>' onKeyDown="getrefnosearch(event);"> </td>
	    
 
	    <td align="right" width="5%" > Ref No</td> 
	    <td align="left" width="15%" > 
	    	<input type="text" name="refno" id="refno" style="width:60%;" value='<s:property value="refno"/>' > 
	   	</td>
	     
	    	<input type="hidden" name="refslno" id="refslno"  value='<s:property value="refslno"/>' > 
	 
	  
 
	   
	    <td width="13%" align="right" colspan="6">Doc No </td>
	    <td width="13%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
	  </tr>
	 
	  <tr>
	   <td width="3.1%" align="right" id="typetd1" hidden="hidden">Type</td>
	    <td width="4%" align="left" id="typetd2" hidden="hidden">
	    	<select name="cmbtype" id="cmbtype" style="width:68%;"  value='<s:property value="cmbtype"/>'>
	    	<option value="AR" >AR</option>
	    	<option value="AP" >AP</option>
	    	<option value="GL" >GL</option>
	    	</select>
	    </td> 
	    
	    <td width="3.1%" align="right">Client</td>
	    <td colspan="5" width="13%" align="left"> 
	      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
	 
	    <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3 To Search"  style="width:20%;" onKeyDown="getaccountdetails(event);" >  
	      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:62%;"></td>
	     
	   
	
	<!--  <td width="3.1%" align="right">  &nbsp;</td> <td width="3.1%" align="right">  &nbsp;</td> -->
	  
	  </tr>
	 
	 <tr>
	 
	  <td align="right" width="1.6%">Curr</td>
	    <td width="6%" align="left"><select name="cmbcurr" id="cmbcurr" style="width:100%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
	      <option value="-1" >--Select--</option>
	    </select>  <input type="hidden" id="hidcmbcurr" name="hidcmbcurr"  value='<s:property value="hidcmbcurr"/>'/>    </td>   
	
	    <td width="8%" align="right">Rate  </td>
	 <td colspan="2"><input type="text" style="width:50%;"   name="currate" id="currate"  value='<s:property value="currate"/>'>&nbsp;&nbsp;&nbsp;PO NO 
	  <input type="text" id="invno" name="invno"  value='<s:property value="invno"/>'></td>
	<td  align="right" width="12%"> PO Date</td>
	<td  align="left" width="14%"> <div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div>
	<input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
	 </tr>
	 
	  <tr>
	 
	    <td align="right" width="4%" >Del Date</td>
	    <td align="left"width="4%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
	    </td>
 
	    <td align="right" width="5%" >Del Terms</td>
	    <td colspan="8" align="left" width="73%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:83%;"></td>
	 <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
	     
	  </tr> 
	  <tr>
	  <td align="right"  width="4.7%">Pay Terms</td>
	    <td colspan="10"  width="94%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:87%;"></td>
	    </tr>
	    <tr>
	    <td align="right"  width="4.7%">Description</td>
	    <td colspan="10"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:87%;"></td></tr>
	    
	</table>
	
	    
	 
	 </fieldset>
	 <br>
	 <fieldset>
	 
	    <div id="nipurdetails" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
	     <div id="interdiv" hidden="true"><input type="checkbox" name="interstate" id="interstate" value="interstate"  value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" >Interstate</div>
	
	</fieldset>
	<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
	<input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no"  value='<s:property value="ordermasterdoc_no"/>'/>
	     <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
	     <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
	     <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
	     <input type="hidden" id="rowval" name="rowval"  value='<s:property value="rowval"/>'/>   <!-- for refno  slno set grid -->
	     <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
	     <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
	     <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
	     <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
	     <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>  
	         
	     <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
	     <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
	     <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght"  value='<s:property value="nidescdetailslenght"/>'/>  
	     <input type="hidden" id="costgropename" name="costgropename"  value='<s:property value="costgropename"/>'/>
	     <input type="hidden" id="tarannumber" name="tarannumber"  value='<s:property value="tarannumber"/>'/>
	     <input type="hidden" id="hidinterstate" name="hidinterstate"  value='<s:property value="hidinterstate"/>'/>
	     <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity"  value='<s:property value="txtnontaxableentity"/>'/>
	     <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
	     <input type="hidden" id="taxperc" name="taxperc"  value='<s:property value="taxperc"/>'/>
	          
	</form>
	  <div id="accountSearchwindow">
		   <div></div>
		</div>
		 <div id="accounttypeSearchwindow">
		   <div></div>
		</div>
		<div id="costtpesearchwndow">
		   <div></div>
		</div>
		 <div id="costcodesearchwndow">
		   <div></div>
		</div> 
			 <div id="refnosearchwindow">
		   <div></div>
		</div> 
			 <div id="nipurchslnosearch">
		   <div></div>
		</div> 
	</div>
	</body>
	</html>