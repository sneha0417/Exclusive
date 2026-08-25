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
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#deliverydate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 getCurrencyIds();
	 refChange();
	 chkfoc();
	 /* refChange();
	 getCurrencyIds();
	 getPriceGroup(); */
	 $('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
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
		
	 getCurrencyIds();
	/*  getPriceGroup(); */
 
	 
	 $('#txtclient').dblclick(function(){
		   
	    	if($('#mode').val()!= "view")
	    		{
		  	  CustomerSearchContent('clientINgridsearch.jsp');
	    		}
	  });
	 
	 $('#rrefno').dblclick(function(){
		   
		 var clientid=document.getElementById("clientid").value;
			
			if(clientid>0){
				
				document.getElementById("errormsg").innerText="";
				
				 var txtlocation=document.getElementById("locationid").value;
					
					if(txtlocation>0){
						document.getElementById("errormsg").innerText="";
						
					}
					else
						{
						document.getElementById("errormsg").innerText="Select Location";
						document.getElementById("txtlocation").focus();
						return 0;
						
						
						}
				
				 $('#refnosearchwindow').jqxWindow('open');
				  	
			  	  refsearchContent('refnosearch.jsp');
				
			}
			else{
				document.getElementById("errormsg").innerText="Select a client";
				document.getElementById("clientid").focus();
				return 0;
			}
			
		 
	  });


	 $('#txtlocation').dblclick(function(){
		   
	    	if($('#mode').val()!= "view")
	    		{
	    		$('#locationwindow').jqxWindow('open');
	    		locationSearchContent('locationSearch.jsp');  
	    		}
	  });
	 
	 
			  	  
}); 
		   
		   
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

  


function getloc(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#locationwindow').jqxWindow('open');
	
	  locationsearchContent('searchlocation.jsp?');   }
	 else{
		 }
	 }  
	  function locationsearchContent(url) {
     //alert(url);
        $.get(url).done(function (data) {
//alert(data);
      $('#locationwindow').jqxWindow('setContent', data);

	}); 
  	}








function getrefDetails(event){
	if(document.getElementById("txtclient").value=="")
	{
	
	 document.getElementById("errormsg").innerText="Search Client";  
	 document.getElementById("txtclient").focus();
       
        return 0;
	}
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp?'); }
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

	  function importsearchcontent(url) {
	      //alert(url);
	      
	       $('#importwindow').jqxWindow('open');
	      
	         $.get(url).done(function (data) {
	//alert(data);
	       $('#importwindow').jqxWindow('setContent', data);

		}); 
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
	     			 
	     			 $('#searchwndow').jqxWindow('open');
	     		$('#searchwndow').jqxWindow('setContent', data);
	     
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
	//$('#frmgrnreturn')[0].reset(); 
}

function funReadOnly(){
	 
	$('#frmdeliveryNoteReturn input').attr('readonly', true );
	$('#frmdeliveryNoteReturn select').attr('disabled', true);
	$('#date').jqxDateTimeInput({disabled: true});
	$('#deliverydate').jqxDateTimeInput({disabled: true});
	$("#jqxDeliveryNoteReturn").jqxGrid({ disabled: true});
	$('#btnvaluechange').hide();
}

function funRemoveReadOnly(){
 //gridLoad();
 chkmultiqty();
  document.getElementById("editdata").value="";
	$('#frmdeliveryNoteReturn input').attr('readonly', false );
	$('#frmdeliveryNoteReturn select').attr('disabled', false);
	
	$('#txtclient').attr('readonly', true );
	$('#rrefno').attr('readonly', true );
	$('#txtlocation').attr('readonly', true );
	$('#txtsalesperson').attr('readonly', true );
	
	
	$('#date').jqxDateTimeInput({disabled: false});
	$('#deliverydate').jqxDateTimeInput({disabled: false});
	$('#docno').attr('readonly', true);
	$("#jqxDeliveryNoteReturn").jqxGrid({ disabled: false}); 
	
 
	if ($("#mode").val() == "E") {
		 
			 
		 $('#btnvaluechange').show();
 	 
		$("#jqxDeliveryNoteReturn").jqxGrid({ disabled: true});
		 
	 
		
		

		    
	  }
	if ($("#mode").val() == "A") {
		getCurrencyIds();
		$('#date').val(new Date());
		$('#deliverydate').val(new Date());
		$("#jqxDeliveryNoteReturn").jqxGrid('clear'); 
		$("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
	}
	
}

function funcheckaccinvendor()
{
	if(document.getElementById("txtclient").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search client";  
		 document.getElementById("txtclient").focus();
	       
	        return 0;
		}
	
}


function funFocus(){
	 
   	$('#date').jqxDateTimeInput('focus'); 	    		
}



function funNotify(){	
	
	  if($('#txtclient').val()=="")
	  {
	  document.getElementById("errormsg").innerText="Search Customer";  
	   document.getElementById("txtclient").focus();
	     
	      return 0;
	  
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
	  var rows = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
	  
	 
	   $('#gridlength').val(rows.length);
	   
	  for(var i=0 ; i < rows.length ; i++){ 
		  
		 
	   newTextBox = $(document.createElement("input"))
	      .attr("type", "dil")
	      .attr("id", "prodg"+i)
	      .attr("name", "prodg"+i)
	      .attr("hidden", "true");
	   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
	   
	  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+
			  rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].rdocno+"::"+rows[i].detdocno);
	  newTextBox.appendTo('form');
		    
	  }
	 
	  
  	return 1;
	} 




function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    /* 	   $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		  document.getElementById("chkdiscount").checked = true;
		 		  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  } */
		 		 document.getElementById("editdata").value="Editvalue";
				  $('#rrefno').attr('disabled', false);
				  $('#rrefno').attr('readonly', true);
	    	   
	
	    		$("#jqxDeliveryNoteReturn").jqxGrid({ disabled: false});
	    		
	    		  $("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
	    		

	       }
	      });
	   }

function funChkButton() {
	

}

function funSearchLoad(){
	 changeContent('Mastersearch.jsp'); 
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



function refChange(){
	  var reftype=$('#cmbreftype').val();
	  if(reftype=='DIR'){
		  
		  $('#rrefno').attr('disabled', true);
	  }
	  else{
		  
		  $('#rrefno').attr('disabled', false);
	  }
	  
}


	   function setValues(){
			  
			  if($('#hiddate').val()){
					 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
				  }
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  //funSetlabel();
			  
			  var masterdoc_no=$('#masterdoc_no').val().trim();
			  var refmasterdocno=$('#refmasterdocno').val().trim();
			  var dtype=$('#formdetailcode').val().trim();
			  var locationid=$('#locationid').val().trim();
			  if(masterdoc_no>0){
				  funchkforedit();
				   $("#delreturngrid").load("deliveryNoteReturnGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&locaid="+locationid+"&cond=2"); 
				  
			  }
				 
			}
	   
	   
	   
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionNipurOrder");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmgrnreturn').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	txtclient:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 txtclient: {required:" *"}
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
 
 function funrefdisslno()
 {
	 
	 if(document.getElementById('cmbreftype').value=="DIR")
		 {
		 
		  $('#rrefno').attr('disabled', true);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("refmasterdoc_no").value="";
			 $("#jqxDeliveryNoteReturn").jqxGrid('clear');
			 $("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
			 document.getElementById("errormsg").innerText="";
		 }
	 
	 else
		 {
		 
		  $('#rrefno').attr('disabled', false);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("refmasterdoc_no").value="";
			 $("#jqxDeliveryNoteReturn").jqxGrid('clear');
			 $("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
		  
		 
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
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
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
          
            
            $('#jqxDeliveryNoteReturn').jqxGrid('showcolumn', 'foc');
         
            
            
             }
               else
           {
           
                $('#jqxDeliveryNoteReturn').jqxGrid('hidecolumn', 'foc');
           
           }
           
            if(parseInt(kg)>0)
           {
         
           
           $('#jqxDeliveryNoteReturn').jqxGrid('showcolumn', 'kgprice');
           $('#jqxDeliveryNoteReturn').jqxGrid('showcolumn', 'totwtkg');
        
           
           
            }
              else
          {
          
               $('#jqxDeliveryNoteReturn').jqxGrid('hidecolumn', 'kgprice');
               $('#jqxDeliveryNoteReturn').jqxGrid('hidecolumn', 'totwtkg');
          
          } 
           
           
           
            }}
        x.open("GET","checkfoc.jsp",true);
      x.send();
      
           
             
         
        }

	 	function funwarningopen(){
	 		   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	 		       if (r){
	 		    	    
	 				   
	 				   document.getElementById("editdata").value="Editvalue";
	 				   
	 			 	$("#jqxDeliveryNoteReturn").jqxGrid({ disabled: false});
	 			 	$("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
					 
					
	 		 
	 		    		


	 		       }
	 		      });
	 		   }
	
		   function funPrintBtn(){
		 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		 	  
		 	   var url=document.URL;

		        var reurl=url.split("saveActiondeliveryNoteReturn");
		        
		        $("#docno").prop("disabled", false);                
		        
		  
		var win= window.open(reurl[0]+"printdeliveryNotereturn?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
		win.focus();
		 	   } 
		 	  
		 	   else {
			    	      $.messager.alert('Message','Select a Document....!','warning');
			    	      return false;
			    	     }
			    	
		 	}
	  
 			   
</script>
</head>
<body onLoad="getCurrencyIds();setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdeliveryNoteReturn" action="saveActiondeliveryNoteReturn" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> <br/>
<jsp:include page="multiqty.jsp"></jsp:include> 
	<fieldset>
 
    
    <table width="100%"   >
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="12%"><div id="date" name="date" value='<s:property value="date"/>'></div>
      <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'></td>
            <td align="right" width="6%">Location</td> 
    <td colspan="3"  ><input type="text" id="txtlocation" name="txtlocation" style="width:43.5%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>'  onkeydown="getloc(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
    <td width="3%" align="right">&nbsp;</td>
    <td width="18%">&nbsp;</td>
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>

  <tr>
    <td align="right">Customer</td>
    <td colspan="3"><input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getclinfo(event);" >  
      <input type="text" id="txtclientdet" name="txtclientdet" value='<s:property value="txtclientdet"/>'  style="width:60%;"></td>
      <td align="right">Ref No</td>
      
        <td colspan="5"><input type="text" name="refno" id="refno" style="width:15%;" value='<s:property value="refno"/>'></td>
 <%--      <td align="right">Ref Type</td>
    <td colspan="5"><select name="reftype" id="reftype" style="width:17%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR" >DIR</option>
      <option value="GRN" >GRN</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:32%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefDetails(event);"></td>
       --%>
    
  </tr>
    <tr>
    <td   align="right">Currency</td>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select></td>
    <td align="right">Rate</td>
    <td  ><input type="text" name="currate" id="currate"  value='<s:property value="currate"/>'></td>
    <td align="right">Ref Type</td><td><select name="cmbreftype" id="cmbreftype" style="width:100%;"  value='<s:property value="cmbreftype"/>' onchange="funrefdisslno();">
      <!-- <option value="DIR" >DIR</option> -->
      <option value="DEL" >DEL</option>
    </select></td>
    <td colspan="4"><input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:30%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefDetails(event);"></td>
 
 
    </tr>
  
  <tr>
    <td align="right">Delivery Date</td>
    <td><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'></td>
    <td align="right">Delivery Terms</td>
    <td colspan="9"><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:63.2%;"></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="9"><input type="text" name="txtpaymentterms" id="txtpaymentterms" value='<s:property value="txtpaymentterms"/>' style="width:70.4%;"></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="9"><input type="text" name="txtdescription" id="txtdescription" value='<s:property value="txtdescription"/>' style="width:70.4%;">
    
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    </td>
    <!-- <td colspan="2" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td> -->
  </tr>
</table>

  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />  
 
 </fieldset>
 <br>
 <fieldset>
 
    <div id="delreturngrid" ><jsp:include page="deliveryNoteReturnGrid.jsp"></jsp:include></div>
     

</fieldset>

 
<table width="100%">
<tr>
<td align="right">&nbsp;</td><td><input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;"></td>

 <td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<%-- <td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td> --%>
  <%-- <td align="right">Discount Value</td><td><input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>  
<%-- <td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>
<td align="right">&nbsp;</td><td><input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
<%-- <td align="right">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td> --%>
 
 
</tr>


</table>
 





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
<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset> --%>

	 

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
</form>
	

</div>
</body>
</html>
