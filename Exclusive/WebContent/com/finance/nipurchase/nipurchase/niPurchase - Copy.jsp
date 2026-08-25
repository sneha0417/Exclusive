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
	
	   /* Date */ 	
    $("#nipurchasedate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $("#invDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#typesearchwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : ' Search',
		position : {
			x : 700,
			y : 87
		},
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#typesearchwindow').jqxWindow('close');
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
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
	$('#txtproducttype').dblclick(function(){
		
		typeFormSearchContent('typeFormSearchGrid.jsp'); 
		
	}); 
	
	
    $('#refno').dblclick(function(){
    	
    	if($('#mode').val()!= "view")
		{
	  	    $('#refnosearchwindow').jqxWindow('open');
	 
	
	  	  refnoSearchContent('ordermainsearch.jsp?');
		}
    }); 
	  	 $('#nipuraccid').dblclick(function(){
	  		if($('#mode').val()!= "view")
    		{
		  	    $('#accountSearchwindow').jqxWindow('open');
		 
		
		  	  accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());
    		} 
  });   
});

function typeFormSearchContent(url) {
	 document.getElementById("errormsg").innerText="";
	$('#typesearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#typesearchwindow').jqxWindow('setContent', data);
		$('#typesearchwindow').jqxWindow('bringToFront');
	});
}
function getProdType(event){
	 var x= event.keyCode;
	 if(x==114){
		 typeFormSearchContent('typeFormSearchGrid.jsp');  	 }
	 else{
		 }
      	 }
				function getrefnosearch(event){
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
				function refnoSearchContent(url) {
					 //alert(url);
						 $.get(url).done(function (data) {
							 
							 $('#refnosearchwindow').jqxWindow('open');
						$('#refnosearchwindow').jqxWindow('setContent', data);
				
					}); 
					} 
				 function costcodeSearchContent(url) {
					 //alert(url);
						 $.get(url).done(function (data) {
							 
							 $('#costcodesearchwndow').jqxWindow('open');
						$('#costcodesearchwndow').jqxWindow('setContent', data);
				
					}); 
					}  

					function costSearchContent(url) {
						 //alert(url);
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
						 
						 
						 	 accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());   }
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
						  
					/* 	  function getslno(event){
						  	  	 var x= event.keyCode;
						  	  	 if(x==114){
						  	  	  $('#nipurchslnosearch').jqxWindow('open');
						  	  
						  	  	nipurhsaeslnocontent('nislnosearch.jsp?niorder='+document.getElementById("refno").value, $('#nipurchslnosearch'));   }
						  	  	 else{
						  	  		 }
						  	  	 }  */
						 	/* function searchslno()
							{
						 		
						 		 $('#refslno').dblclick(function(){
						 	  	  
						 	   
						 	  	 nipurhsaeslnocontent('nislnosearch.jsp?niorder='+document.getElementById("refno").value, $('#nipurchslnosearch'));
						 	  	  
						     });  
						 	 
						   		 
							}  */
						 	
						 	  function nipurhsaeslnocontent(url) {
						   	        //alert(url);
						   	           $.get(url).done(function (data) {
						   	 //alert(data);
						   	   $('#nipurchslnosearch').jqxWindow('open');
						   	         $('#nipurchslnosearch').jqxWindow('setContent', data);
					
						   		}); 
						   	     	} 
						  
	  
	  function funFocus(){
			 
		  $('#nipurchasedate').jqxDateTimeInput('focus');  		
		}
		function funNotify(){	
			//alert($('#nettotal').val());$('#nireftype').val()=="NPO"
		 
			/***
			*added by nitin
			*/

			/*   var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
            alert("ssssss"+summaryData.sum);
            document.getElementById("nettotal").value=summaryData.sum; */
		    var nipurchasedate = $('#nipurchasedate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(nipurchasedate);
			if(validdate==0){
			return 0;	
			}
			
            
            if(parseInt(document.getElementById("validates").value)==1)
            	{
            	
                var txtproducttype= document.getElementById('txtproducttype').value;
   			 
   			 if(txtproducttype=="")
   			 {
   				 document.getElementById("errormsg").innerText=" Bill Type Is Required ";	
   				 document.getElementById('txtproducttype').focus();
   				 return 0;
   			 }
   			 
            	
            	}
            
            
			
			var rows=$('#nidescdetailsGrid').jqxGrid('getrows');
		     
		     
		     var aa=0;
		     
			 for(var i=0;i<(rows.length);i++){
			   var chk=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'headdoc');
			   
			   
			   var qty=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'qty');
			   
			   if(parseFloat(qty)>0)
			   {
			   
			      if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
			    	  
			    	 aa=1;
			    	 
			      }
			      else 
			    	  {
			    	  aa=0;
			    	  
			    	  }
			   }
			 }
			    
		 
			 if(parseInt(aa)==0) {
				 document.getElementById("errormsg").innerText=" Please Select Account";
				 return false;
			 } 
			 
		if( document.getElementById("nireftype").value=="NPO")
			{
	      var refno= document.getElementById('refno').value;
			 
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('refno').focus();
				 return 0;
			 }
			 
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
		 
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
							 document.getElementById("errormsg").innerText=" Enter Inv NO";
							 document.getElementById("invno").focus();
							 
							 return 0;
							   }
						else
							   {
							   document.getElementById("errormsg").innerText="";
							   } 
							
						
						
						
						
						
						 var refval= document.getElementById("nettotal").value;

						 if(refval=="")
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
			   //alert($('#gridlength').val());
			   for(var i=0 ; i < rows.length ; i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "desctest"+i)
			       .attr("name", "desctest"+i)
			        .attr("hidden", "true"); 
			   
			   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
					   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
					   +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
			
			//alert(newTextBox.val()); 
			   newTextBox.appendTo('form');
			    
			   }   
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
					 
					 
					 
					 document.getElementById("frmNipurchase").submit();
					}
					
					
				
				}
				}
				
				x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);

				x.send();	
			
				
			
		} 

		function funchkinv()
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
		
		function funChkButton() {
			
			//frmEnquiry.submit();
		}

		function funSearchLoad(){
			 changeContent('nipurchaseMastersearch.jsp'); 
		}

			function funReset(){
				//$('#frmNipurchase')[0].reset(); 
			}
			function funReadOnly(){
				$('#frmNipurchase input').attr('readonly', true );
				$('#frmNipurchase select').attr('disabled', true );
				 $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
				 $('#deliverydate').jqxDateTimeInput({ disabled: true});
				 
				 $('#invDate').jqxDateTimeInput({ disabled: true});
				 
				 $('#interstate').attr('disabled', true);
				 
				 
				 $('#nireftype').attr('disabled', true);
				  $('#cmbcurr').attr('disabled', true);
				 $('#acctype').attr('disabled', true);
				 $('#refno').attr('disabled', true);
				   $('#refslno').attr('disabled', true);
					$("#nidescdetailsGrid").jqxGrid({ disabled: true});
					 $('#txtproducttype').attr('disabled', true);
				   combochange();
					  getCurrencyIds();
				
			}
			function funRemoveReadOnly(){
				  funinterstate();
				$('#frmNipurchase input').attr('readonly', false );
				$('#frmNipurchase select').attr('disabled', false );
				 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
				 $('#deliverydate').jqxDateTimeInput({ disabled: false});
				 
				 $('#invDate').jqxDateTimeInput({ disabled: false});
				 $('#interstate').attr('disabled', false);
				 
				 
				 
				 $('#txtproducttype').attr('readonly', true);
				 
				 
				 $('#nireftype').attr('disabled', false);
				  $('#cmbcurr').attr('disabled', false);
				 $('#acctype').attr('disabled', false);;
				$('#docno').attr('readonly', true);
				 $('#currate').attr('readonly', true);
				  $('#nipuraccid').attr('readonly', true);
				  $('#puraccname').attr('readonly', true);
				  $('#refno').attr('disabled', true);
				   $('#refslno').attr('disabled', true);
					  $('#refno').attr('readonly', true);
					  $('#refslno').attr('readonly', true);
			
					$("#nidescdetailsGrid").jqxGrid({ disabled: false});
					if ($("#mode").val() == "A") {
						
						$('#nipurchasedate').val(new Date());
						$('#deliverydate').val(new Date());
						 $("#nidescdetailsGrid").jqxGrid('clear');
						    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
						    $('#txtproducttype').attr('disabled', true);
						    document.getElementById("validates").value=0;
						    getCurrencyIds();
					   }
				if ($("#mode").val() == "E") {
					getCurrencyIds();
				  if($('#reftypeval').val()=="NPO")
					  {
					
					  $('#refno').attr('disabled', false);
					   $('#refslno').attr('disabled', false);
				  $('#refno').attr('readonly', true);
				   $('#refslno').attr('readonly', true);
					  }
						
					   }
				
			}
			function getCurrencyIds(){
				   var x=new XMLHttpRequest();
				   x.onreadystatechange=function(){
				   if (x.readyState==4 && x.status==200)
				    {
				      items= x.responseText;
				     
				      items=items.trim().split('####');
				           var curidItems=items[0];
				           var curcodeItems=items[1];
				           var currateItems=items[2];
				           var multiItems=items[3];
				           var optionscurr = '';
				           
				           if(curcodeItems.indexOf(",")>=0){
				        	   curidItems=curidItems.split(",");
				            curcodeItems=curcodeItems.split(",");
				            currateItems=currateItems.split(",");
				           
				            for ( var i = 0; i < curcodeItems.length; i++) {
				           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
				           }
				            $("select#cmbcurr").html(optionscurr);
				            //$("#currate").val(currateItems[0]);
				            funRoundRate(currateItems,"currate");
				            
				            if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
					       		 $('#cmbcurr').val($('#cmbcurrval').val()) ;
					       		getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
					         } 
				        }
				   
				          else
				      {
				           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
				           $("select#cmbcurr").html(optionscurr);
				         //  $("#currate").val(currateItems[0]);
				           
				       
				          funRoundRate(currateItems,"currate");
				        
				      
				          if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
					       		 $('#cmbcurr').val($('#cmbcurrval').val()) ;
					       		getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
					         } 
				          $('#currate').attr('readonly', true);
				       
				      }
				    }
				       }
				   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchasedate").value ,true);
					x.send();
				        
				      
				        }
				   function getRatevalue1(angel,date)
				   {
					 // alert(angel);
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
				   x.open("GET","getRateFrom.jsp?curr="+angel+"&date="+date,true);
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
	
				   function setValues() {
					   combochange();
					   getCurrencyIds();
					  
					 //  $('#interstate').attr('disabled', true);
					   
					   
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
							
				     	  		 
				     	  	
				     	  		 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
				     	  		
							 } 
			
						 if($('#msg').val()!=""){
							   $.messager.alert('Message',$('#msg').val());
							  } 
						 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
						       
					}
				   $(function(){
				        $('#frmNipurchase').validate({
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
				/*    function diserror(){
					   document.getElementById("errormsg").innerText="";
				   } */
				    function funPrintBtn(){
				 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
				 	  
				 	   var url=document.URL;

				        var reurl=url.split("saveActionNipurchase");
				        
				        $("#docno").prop("disabled", false);                
				        var dtype=$('#formdetailcode').val();
						 var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				  
				var win= window.open(reurl[0]+"printniphs?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				     
				win.focus();
				 	   } 
				 	  
				 	   else {
					    	      $.messager.alert('Message','Select a Document....!','warning');
					    	      return false;
					    	     }
					    	
				 	}
						   
</script>
</head>
<body onLoad="setValues();" >


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchase" action="saveActionNipurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>
<table width="100%"     >    

  <tr>
    <td width="4%" align="right">Date</td>
    <td width="8%" align="left"><div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
    
    <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
    </td>
<td align="right" width="10%" >Ref Type</td>
    <td align="left" width="10%" ><select name="nireftype" id="nireftype" style="width:99%;"  value='<s:property value="nireftype"/>' onchange="funrefdisslno()">
      <option value="DIR" >DIR</option>
      <option value="NPO" >NPO</option>
    </select></td>
    <td align="right" width="5%" >Ref No</td> 
    <td align="left" width="15%" > <input type="text" name="refno" id="refno" placeholder="Press F3 To Search" style="width:95%;" value='<s:property value="refno"/>' onKeyDown="getrefnosearch(event);"> </td>
   
   
    <td  align="right" width="4%"> Inv NO</td><td  align="left" width="1%"> <input type="text" id="invno" name="invno" onblur="funchkinv();" value='<s:property value="invno"/>'></td>
<td  align="right" width="10%"> Inv Date</td><td  align="left" width="14%"> <div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div>
<input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'> </td>
   
    <td width="13%" align="right">Doc No </td><td width="13%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
  </tr>
 
  <tr>
   
    <td width="3.1%" align="right">Vendor</td>
    <td colspan="5" width="14%" align="left"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
 
    <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3 To Search"  style="width:20%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:77.5%;"></td>
     
    <td align="right" width="3%">Curr</td>
    <td width="6%" align="left"><select name="cmbcurr" id="cmbcurr" style="width:100%;"  value='<s:property value="cmbcurr"/>' onchange="getRatevalue1(this.value,$('#nipurchasedate').val());">
      <option value="-1" >--Select--</option>
    </select>    </td>   

    <td width="15%" align="right">Rate &nbsp; <input type="text" style="width:70%;"   name="currate" id="currate"  value='<s:property value="currate"/>'></td>
 
   <input type="hidden" name="refslno" id="refslno"  value='<s:property value="refslno"/>' >    
        <td align="left" colspan="2" > <label id="billtype">Bill Type</label> &nbsp;<input type="text" id="txtproducttype" name="txtproducttype"
											style="width: 68%;" placeholder="Press F3 for Search"  onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /> </td>

<!--  <td width="3.1%" align="right">  &nbsp;</td> <td width="3.1%" align="right">  &nbsp;</td> -->
 
  </tr>
 
  <tr>
 
    <td align="right" width="6%" >Del Date</td>
    <td align="left"width="3%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'></td>
 
 <td>&nbsp;<div id="interdiv" hidden="true"><input type="checkbox" name="interstate" id="interstate" value="interstate"  value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" >Interstate</div></td>
    <td align="right" width="5%" >Del Terms</td>
    <td colspan="7" align="left" width="56%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:96%;"></td>
 
     
  </tr> 
  <tr>
  <td align="right"  width="4.7%">Pay Terms</td>
    <td colspan="10"  width="94%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:97.3%;"></td>
    </tr>
    <tr>
    <td align="right"  width="4.7%">Description</td>
    <td colspan="10"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:97.3%;"></td></tr>
    
</table>

    
 
 </fieldset>
 <br>
 <fieldset>
 
    <div id="nipurdetails" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
     

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
            <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/> 
           
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
            <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
           
            <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght"  value='<s:property value="nidescdetailslenght"/>'/>  
            <input type="hidden" id="costgropename" name="costgropename"  value='<s:property value="costgropename"/>'/>
            
             <input type="hidden" id="tarannumber" name="tarannumber"  value='<s:property value="tarannumber"/>'/>
             <input type="hidden" id="hidinterstate" name="hidinterstate"  value='<s:property value="hidinterstate"/>'/>
             
             
                  <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
                   <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
                     <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
            
           
        
            
            
          
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
		 <div id=nipurchslnosearch>
	   <div></div>
	</div> 
	
	
			
		<div id="typesearchwindow">
			<div></div>
			 
		</div>
	
</div>
</body>
</html>