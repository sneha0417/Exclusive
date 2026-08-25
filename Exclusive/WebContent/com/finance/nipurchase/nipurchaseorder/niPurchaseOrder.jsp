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
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     
	     
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
		
		
		$('#txtproducttype').dblclick(function(){
			
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
			
		}); 
    $('#puraccid').dblclick(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()!= "view")
    		{
    	
    		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsFromGrid.jsp?');
    		}
  });   
    
  
});
function getaccountdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 accountSearchContent('accountsDetailsFromGrid.jsp?');    }
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
	  function typeFormSearchContent(url) {
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
function funReset(){
	//$('#frmNipurchaseOrder')[0].reset(); 
}
function funReadOnly(){
	$('#frmNipurchaseOrder input').attr('readonly', true );
	$('#frmNipurchaseOrder select').attr('disabled', true );
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
		$("#descdetailsGrid").jqxGrid({ disabled: true});
	  $('#cmbcurr').attr('disabled', true);
	 $('#acctype').attr('disabled', true);
	 $('#txtproducttype').attr('disabled', true);
	
}
function funRemoveReadOnly(){
	
	 funinterstate();
	$('#frmNipurchaseOrder input').attr('readonly', false );
	 $('#txtproducttype').attr('readonly', true);
	$('#frmNipurchaseOrder select').attr('disabled', false );
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});

	
	if ($("#mode").val() == "A") {
		$('#nipurchaseorderdate').val(new Date());
		$('#deliverydate').val(new Date());
		 $("#descdetailsGrid").jqxGrid('clear');
		    $("#descdetailsGrid").jqxGrid('addrow', null, {});
			 $('#txtproducttype').attr('disabled', true);
			  document.getElementById("validates").value=0;
	   }
	
	  if($('#mode').val()=='E')
	   {
	   $("#descdetailsGrid").jqxGrid('addrow', null, {});
	   
	   }
	
	
	getCurrencyIds();
}
function funFocus(){
	 
   	$('#nipurchaseorderdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 
	
	
var purid= document.getElementById("puraccid").value;

if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
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

	   
var refval= document.getElementById("nettotal").value;

if(refval=="")
	{
	 document.getElementById("errormsg").innerText="Net Amount Empty";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }

	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	    $('#descgridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
	
	// alert(newTextBox.val());
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }   
	
	return 1;
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
	        }
	   
	          else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	         //  $("#currate").val(currateItems[0]);
	           
	       
	          funRoundRate(currateItems,"currate");
	        
	      
	          $('#currate').attr('readonly', true);
	       
	      }
	    }
	       }
	   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchaseorderdate").value ,true);
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
		   if($('#acctypeval').val()!="")
			  {
			  
			  
			  $('#acctype').val($('#acctypeval').val());
			  }
			
	   }

	   function setValues() {
			if($('#hidnipurchaseorderdate').val()){
				$("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   
				
	     	  		 
	     	  	
	     	  		 $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		    funSetlabel();
				//  getCurrencyId();
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionNipurOrder");
	        
	        $("#docno").prop("disabled", false);                
	        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  	var dtype=$('#formdetailcode').val();
		  	
	  
	var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmNipurchaseOrder').validate({
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
</script>
</head>
<body onLoad="getCurrencyIds();setValues();funinterstate();">


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>
<table width="100%"  >

  <tr>
    <td width="4.8%" align="right">Date</td> 
    <td width="8%" align="left"><div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
    
    <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
    </td>
<td align="right" width="33.8%" >Ref No</td>
    <td align="left"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td width="5%" align="right">Doc No</td>
    <td width="13%" align="left"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
  
  </tr>
  </table>
 <table width="100%" >
  <tr>
       <td width="1%" align="right">Vendor</td>
    <td colspan="5" width="14%" align="left"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
<%--     <td width="1%" align="right">Account</td>
  
     <td colspan="5" width="14%" align="left"> 
    <select name="acctype" id="acctype" style="width:10%;"  value='<s:property value="acctype"/>' >
    <option value="" ></option>
      <option value="AR" >AR</option>
      <option value="AP" >AP</option>  
    </select>   --%>
    <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' style="width:20%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:63.5%;"></td>
    <td align="right" width="1.6%">Curr</td>
    <td width="4%" align="left"><select name="cmbcurr" id="cmbcurr" style="width:92%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select>    </td>

    <td width="3.1%" align="right">Rate <input type="text" name="currate" id="currate" value='<s:property value="currate"/>'></td>
    <td width="9%" align="left"></td>
    
  </tr>
  </table>
  <table width="100%"   >
  <tr>
 
    <td align="right" width="4.3%" >Del Date</td>
    <td align="left"width="3%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    
     <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
     
    </td>
  

    <td align="right" width="3.8%" >Del Terms</td>
    <td colspan="4" align="left" width="73%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:68.1%;">
    
    &nbsp;&nbsp; <label id="billtype">Bill Type</label> &nbsp;<input type="text" id="txtproducttype" name="txtproducttype"
											style="width: 15%;" placeholder="Press F3 for Search"  onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /> 
    
    </td>
 
    
  </tr></table>
                              
    <table width="100%"  >
  <tr>
  <td align="right"  width="4.7%">Pay Terms</td>
    <td colspan="6"  width="94%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:73%;"></td>
    </tr>
    <tr>
    <td align="right"  width="4.7%">Description</td>
    <td colspan="6"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:73%;"></td></tr>
</table>

 </fieldset>
 <br>
 <fieldset>
 
    <div id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
     

</fieldset>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
           <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
             <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
             
             <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
             
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>    
            <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/> 
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
           
                    <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
                   <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
                     <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
            
            
          
</form>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	<div id="typesearchwindow">
			<div></div>
			 
		</div>
</div>
</body>
</html>