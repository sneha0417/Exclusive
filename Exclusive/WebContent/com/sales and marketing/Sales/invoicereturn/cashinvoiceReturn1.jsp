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

<script type="text/javascript">
$(document).ready(function() {
	$('#btnvaluechange').hide();
$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
$("#payDueDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
refChange();
getCurrencyIds();
//getPriceGroup();

chkfoc();
$('#customerDetailsWindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
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
//getPriceGroup();
 

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
			
		}
		else{
			document.getElementById("errormsg").innerText="Select a client";
			document.getElementById("clientid").focus();
			return 0;
		}
		 
   	if($('#mode').val()!= "view")
   		{
  	  $('#refnosearchwindow').jqxWindow('open');
  	
	  refsearchContent('refnosearch.jsp');  
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
     	 
function accountSearchContent(url) {
	$('#accountsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#accountsearchwindow').jqxWindow('setContent', data);
		$('#accountsearchwindow').jqxWindow('bringToFront');
	});
}   	 

function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}



function funReadOnly(){

	$('#frmSalesReturn input').attr('readonly', true );
	$('#frmSalesReturn select').attr('disabled', true);
	$('#date').jqxDateTimeInput({disabled: true});
	$('#payDueDate').jqxDateTimeInput({disabled: true});
	$("#jqxInvoiceReturn").jqxGrid({ disabled: true});
	$('#btnvaluechange').hide();
	
}

function funRemoveReadOnly(){
gridLoad();
chkmultiqty();
document.getElementById("editdata").value="";
	$('#frmSalesReturn input').attr('readonly', false );
	$('#frmSalesReturn select').attr('disabled', false);
	
	$('#txtclient').attr('readonly', true );
	$('#rrefno').attr('readonly', true );
	$('#txtlocation').attr('readonly', true );
	$('#txtsalesperson').attr('readonly', true );
	$('#txtproductamt').attr('readonly', true );
	$('#txtdiscount').attr('readonly', true );
	$('#txtnettotal').attr('readonly', true );
	
	$('#orderValue').attr('readonly', true);
	
	$('#payDueDate').jqxDateTimeInput({disabled: false});
	$('#date').jqxDateTimeInput({disabled: false});
	$('#docno').attr('readonly', true);
	$("#jqxInvoiceReturn").jqxGrid({ disabled: false}); 
	/* $("#jqxTerms").jqxGrid({ disabled: false}); */
/* 	if ($("#mode").val() == "E") {
 
		    $("#jqxInvoiceReturn").jqxGrid('addrow', null, {}); */
 
		    
		    
		    	if ($("#mode").val() == "E") {
		 
			 
		 $('#btnvaluechange').show();
 	 
		$("#jqxInvoiceReturn").jqxGrid({ disabled: true});
		 
	 
		
		

		    
	/*   } */
		    
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
		//getPriceGroup();
		$('#date').val(new Date());
		$('#payDueDate').val(new Date());
		/* $("#jqxTerms").jqxGrid({ disabled: false}); */
		/* $("#jqxserviceGrid").jqxGrid({ disabled: false}); */
		/* $("#jqxserviceGrid").jqxGrid('clear'); 
		$("#jqxserviceGrid").jqxGrid('addrow', null, {}); */
		$("#jqxInvoiceReturn").jqxGrid('clear'); 
		$("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
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
   $('#frmSalesReturn').validate({
           rules: {
           txtfromaccid:"required",
           txtfromamount:{"required":true,number:true}
           },
            messages: {
            txtfromaccid:" *",
            txtfromamount:{required:" *",number:"Invalid"}
            }
   });});

function funNotify(){	
	if($('#txtlocation').val()== "")
	{
	document.getElementById("errormsg").innerText="select location";
	document.getElementById("txtlocation").focus();
	return 0;
	}

 var rows = $("#jqxInvoiceReturn").jqxGrid('getrows');
  $('#gridlength').val(rows.length);
  
 for(var i=0 ; i < rows.length ; i++){ 
	  
	 
  newTextBox = $(document.createElement("input"))
     .attr("type", "dil")
     .attr("id", "prodg"+i)
     .attr("name", "prodg"+i)
     .attr("hidden", "true");
  //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
  
 newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].rdocno+"::"+rows[i].detdocno);
 newTextBox.appendTo('form');
	    
 }
  
	return 1;
} 


function setValues(){
 
 if($('#hiddate').val()){
		 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
	  }

 if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
 
 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 funSetlabel();
 combochange();
 var masterdoc_no=$('#masterdoc_no').val().trim();
 var refmasterdocno=$('#refmasterdocno').val().trim();
 var dtype=$('#formdetailcode').val().trim();
 
 var locaid=$('#locationid').val();
 
 if(masterdoc_no>0){
	  
	/*  $("#btnEdit").attr('disabled', true ); */
	 $("#btnDelete").attr('disabled', true ); 
	 
	   $("#invoiceDiv").load("invoiceReturnGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&locaid="+locaid+"&cond=2");
	  
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
	            $("select#cmbprice").html(optionspg);
	          
	        }
	   
	          else
	      {
	        	  optionspg += '<option value="' + pgid + '"selected>' + pgname + '</option>';
	           $("select#cmbprice").html(optionspg);
	       			       
	      }
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
 }
 else{
	  
	  $('#rrefno').attr('disabled', false);
 }
 
}

function gridLoad(){
 var dtype=document.getElementById("formdetailcode").value;
 /* $("#termsDiv").load("termsGrid.jsp?dtype="+dtype); */
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
		  if($('#hidcmbreftype').val()!="")
		  {
		  
		  
		  $('#cmbreftype').val($('#hidcmbreftype').val());
		  }
		 
		  
		   if($('#hidcmbprice').val()!="")
			  {
			  
			  
			  $('#cmbprice').val($('#hidcmbprice').val());   
			  
			  }
		  
		 if($('#hidcmbreftype').val()!='DIR')
		  {
		
		  $('#rrefno').attr('disabled', false);
		  
	  $('#rrefno').attr('readonly', true);
	
		  }
	   
		 if($('#cmbreftype').val()!='DIR'){
			 $('#btnDelete').attr('disabled', true);
		 }
		
 
		 
  }
	   
	   
	 function funcalcu()
	{
		
	 
		document.getElementById('prddiscount').value="";
		
		
		$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
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
		
		 var rows = $('#jqxInvoiceReturn').jqxGrid('getrows');
	      var rowlength= rows.length;
	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	   
			    for(var i=0;i<rowlength;i++)
						  {
		 
			    	var totamt=rows[i].total;
			     
			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
			     
			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
			    	
		  
			    	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "dis" ,discounts);
			    	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "netotal" ,nettot);
					 
				  
						  }
		 
	
		
		}
		
		
		
		
	function funvalcalcu()
		{
		
		
		document.getElementById('prddiscount').value="";
		$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
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
		   var summaryData3= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
		   $('#descPercentage').attr('disabled', true);
			 $('#txtdiscount').attr('disabled', true);
				$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
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
      
        
        $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'foc');
     
        
        
         }
           else
       {
       
            $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'foc');
       
       }
       
        if(parseInt(kg)>0)
       {
     
       
       $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'kgprice');
       $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'totwtkg');
    
       
       
        }
          else
      {
      
           $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'kgprice');
           $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'totwtkg');
      
      } 
       
       
       
        }}
    x.open("GET","checkfoc.jsp",true);
  x.send();
  
       
         
     
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
		    	   
		
		    		$("#jqxInvoiceReturn").jqxGrid({ disabled: false});
		    		
		    		  $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
		    		

		       }
		      });
		   }
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveSalesInvoiceReturn");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printinvcashret?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CASH","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
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
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesReturn" action="saveSalesInvoiceReturn" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include> 
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="100%">
  <tr>
    <td width="7%" height="42" align="right">Date</td>
    <td width="33%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="17%"><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="9%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Sales Person</td>
  <td><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:71%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
  <td align="right">Mode of Pay</td>
  <td><select id="cmbmodeofpay" name="cmbmodeofpay" style="width:51%;" value='<s:property value="cmbmodeofpay"/>'>
      <option value="cash">CASH</option></select>
      <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/></td>
  <td align="right">Location</td>
  <td><input type="text" id="txtlocation" name="txtlocation" style="width:50%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Customer</td>
    <td width="14%"><input type="text" id="txtclient" name="txtclient" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td colspan="3"><input type="text" id="txtclientdet" name="txtclientdet" style="width:48%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/>
    </td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td><select id="cmbcurr" name="cmbcurr" style="width:71%;" value='<s:property value="cmbcurr"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>
    <td colspan="3"><input type="text" id="currate" name="currate" style="width:11%;" value='<s:property value="currate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
       <option value="INV">INV</option></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
     <td width="14%"><input type="text" id="rrefno" name="rrefno" style="width:100%;" placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/></td> 
     <%-- <td>Sales Order
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="rrefno" name="rrefno" style="width:35%;"  placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
     </td> --%>
    <td width="12%" align="right">&nbsp;</td>
    <td width="53%">&nbsp;<select hidden="true" id="cmbprice" name="cmbprice" style="width:23%;" value='<s:property value="cmbprice"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Due on</td>
    <td><div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
    <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/></td>
    <td  align="left" colspan="3">Del. Terms <input type="text" id="txtdelterms" name="txtdelterms" style="width:65.7%;" value='<s:property value="txtdelterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="4"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:75%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:75%;" value='<s:property value="txtdescription"/>'/>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    
    
    </td>
  </tr>
</table>
</fieldset><br/>

<div id="invoiceDiv"><center><jsp:include page="invoiceReturnGrid.jsp"></jsp:include></center></div>

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
</fieldset>
 --%>

<%-- <fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset>
 --%>

<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label>Order Value</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table>

 


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
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
<input type="hidden" name="txtnettotal"  id="txtnettotal" value='<s:property value="txtnettotal"/>'>
<input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
<input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
<input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
<input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
   <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>

</div>
</form>
	
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
<div id="accountsearchwindow">
			<div></div>
		</div>	
</div>
</body>
</html>
