<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;
}
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>
<script type="text/javascript">
 $(document).ready(function () {
	 
   	 $("#estmDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#ttime").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"HH:mm", showCalendarButton: false });    

     ///ans
     $('#currencysearchwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Currency Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#currencysearchwindow').jqxWindow('close');
     $('#refnosearchwindow').jqxWindow({width: '50%', height: '62%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Enquiry Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#refnosearchwindow').jqxWindow('close');
	 $('#unitsearchwindow').jqxWindow({width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%', title: 'Unit Search',position: { x: 500, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#unitsearchwindow').jqxWindow('close');
	 $('#vendorsearchwindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vendor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#vendorsearchwindow').jqxWindow('close');
	 
	 
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '75%',  maxHeight: '74%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	    $('#accountSearchwindow').jqxWindow('close');
		$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	    $('#accounttypeSearchwindow').jqxWindow('close');
	    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
	    $('#costtpesearchwndow').jqxWindow('close');   
	    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
	    $('#costcodesearchwndow').jqxWindow('close');  
	   
	    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
	    $('#nipurchslnosearch').jqxWindow('close');
	    
	     //$('#btnUpdateDate').hide();
	     
	     
	     $('#btnUpdateDate1').hide();
	     
	     
	 
	 $("#refno").dblclick(function(){
		 refnoSearchContent("refnoSearch.jsp");
	 });
	/*  if(parseInt($("#docno").val())>0){
		 $("#estmdiv").show();
	 }else{
	 	$("#estmdiv").hide();
	 } */
	 	////ans-end
	 
 });
 
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

 //ans2
 function searchRefno(){
	 var x= event.keyCode;
	 if(x==114){
		 refnoSearchContent("refnoSearch.jsp");
	 }
 }
 function refnoSearchContent(url) {
	 	$('#refnosearchwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#refnosearchwindow').jqxWindow('setContent', data);
		$('#refnosearchwindow').jqxWindow('bringToFront');
	}); 
 }
 //ans2-end
 
    function funReset(){
		//$('#frmCFI')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmCFI input').prop('readonly', true );
		$('#frmCFI textarea').attr('readonly', true );
		$('#frmCFI select').attr('disabled', true);
		$('#estmDate').jqxDateTimeInput({ disabled: true});
		$('#ttime').jqxDateTimeInput({ disabled: true});
	   /*  $("#jqxEstimation").jqxGrid({ disabled: true});
	   
	   
	   
	   
		$("#estmdiv").show(); */
		if(document.getElementById("masterdoc_no").value>0)
			{
			
			
		 
		 funchkforedit();
			}
		
	    $("#jqxgridexp").jqxGrid({ disabled: true}); 
		$("#nidescdetailsGrid").jqxGrid({ disabled: true});  
		$("#jqxEstimation").jqxGrid({ disabled: true}); 
		
		  $('#btnUpdateDate1').hide();
	}
	function funRemoveReadOnly(){
		fungetterms();
		 document.getElementById("savestatus").value="";
		 // $('#btnUpdateDate').hide();
		  $('#btnUpdateDate1').show();
		  
		  
		  
		$('#frmCFI input').attr('readonly', false );
		$('#frmCFI textarea').attr('readonly', false );
		$('#frmCFI select').attr('disabled', false);
		$('#estmDate').jqxDateTimeInput({ disabled: false});
		$('#ttime').jqxDateTimeInput({ disabled: false});
	    $("#jqxgridexp").jqxGrid({ disabled: false}); 
		$("#nidescdetailsGrid").jqxGrid({ disabled: false});  
		$("#jqxEstimation").jqxGrid({ disabled: false}); 
			 
		$('#docno').attr('readonly', true);
		$('#refno').attr('readonly', true)
		
		
		$('#refnos').attr('readonly', false );
		$('#txtRemarks').attr('readonly', false );
	 
		$("#estmdiv").hide();
 
		if ($("#mode").val() == "A") {
			$('#estmDate').val(new Date());
			$('#ttime').val(new Date());
			$("#jqxgridexp").jqxGrid('clear');
		    $("#jqxgridexp").jqxGrid('addrow', null, {});
		    
		    $("#jqxEstimation").jqxGrid('clear');
		    $("#jqxEstimation").jqxGrid('addrow', null, {});
		    
			$("#nidescdetailsGrid").jqxGrid('clear');
		    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
		    
			  $('#btnUpdateDate1').show();
			 
		}
		
		if ($("#mode").val() == "E") {
		  $('#btnUpdateDate1').hide();
		}
  
	}
	function funFocus(){
		$("#refno").focus();
	}
	function funSearchLoad(){
		 changeContent('mastersearch.jsp'); 
	}
 
	function setValues() {
   		if($('#hidestmDate').val()){
   			$("#estmDate").jqxDateTimeInput('val', $('#hidestmDate').val());
   		}
   		
   		if($('#hidttime').val()){
   			$("#ttime").jqxDateTimeInput('val', $('#hidttime').val());
   		}
   		
   		
   		
   		if($('#msg').val()!=""){
   			$.messager.alert('Message',$('#msg').val());
   		}
   	 // $('#btnUpdateDate').hide();
   		var docVal1 = document.getElementById("masterdoc_no").value;
   		if(docVal1>0)
   		{
   			
   		 // $('#btnUpdateDate').show();
   			funchkforedit();
		    $("#enqdiv").load('estmgrid.jsp?rdocno='+document.getElementById("mastertr_no").value);
		    $("#expdiv").load('expgrid.jsp?rdocno1='+document.getElementById("refno").value);
	  	  	$("#srvgrid").load("descgridDetails.jsp?docno="+document.getElementById("masterdoc_no").value);
	  	  	
	  	   
	  	  	if(parseInt(document.getElementById("savestatus").value)==1)
	  	  		{
	  	  	 document.getElementById("savestatus").value="";
	  		$.messager.alert('Message',"Updated Successfully");
	  	  		}
	  	  	else if(parseInt(document.getElementById("savestatus").value)==2)
  	  		{
	  	  		
	  	  	 document.getElementById("savestatus").value="";
	  	  	$.messager.alert('Message',"Not Updated");
	  	  	
  	  		}
	  	  	 
	  	  	
   		}
   		
   		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
   	   funSetlabel();
  
	
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
					// $('#btnUpdateDate').hide();
					 
					 
					 
					}
				else
					{
					 // $('#btnUpdateDate').show();
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();    
	
	
	}
	
	
	function funsave()
	{
		
		
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
				 
					 $.messager.alert('Message', 'Not Possible To Update');
					 return 0;
					 
					}
				else
					{
					funsave1();
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();    
		
	}
	
   		  
	
	function funsave1()
	{
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		 	  
		     
		   	if(r==false)
		   	  {
		   		
		   	  }
		   	else
		   		{
		   		document.getElementById("mode").value="S";
				funSaveData();
		   		
		   		}
		
		 });
		
		
	}
	
	function funNotify(){
		
		
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
	 
					 $.messager.alert('Message', 'Not Possible To Update');
					 return 0;
					 
					}
				else
					{
					funSaveData();
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send(); 
	}
	
	
	function funSaveData(){
		
		var refno= document.getElementById('refno').value;
		if(refno=="")
		{
			document.getElementById("errormsg").innerText=" Job NO is required ";	
			document.getElementById('refno').focus();
			return 0;
		}
		else
		{
			document.getElementById("errormsg").innerText="";
		}
		
		
	    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
       
 
		 var refval= summaryData.sum.replace(/,/g,'');
		 if(refval=="" || (!parseFloat(refval)>0))
		 {
			 document.getElementById("errormsg").innerText="Net Total Empty";
			 return 0;
		 }
		else
		{
			   document.getElementById("errormsg").innerText="";
		}
		
		
		var bb=4;
		 var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
		 $('#gridlenght').val(rows.length);
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
					 +bb+" :: "+document.getElementById("refno").value+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: ");
			 newTextBox.appendTo('form');
		 }  
		 $('#estmDate').jqxDateTimeInput({ disabled: false});
		 document.getElementById("savestatus").value="";
		 $("#frmCFI").submit();
		 
		 
	 
	}
	
	
	
	   function fungetterms()
		{
			
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       //alert("items"+items);
			       if(parseInt(items)>0){
			    	   
			    	   
			    	   $('#termsval').val(1);
			    	 
			       }
					else{
						 
						  $('#termsval').val(0);
							 
					}
					}
				else{
					
				}
				}
		x.open("GET","terms.jsp?",true);

		x.send();
				
		}
	   
	   function funsetdata()
	   {
		   if(document.getElementById("mode").value=="A" ){
			 var rows = $("#jqxEstimation").jqxGrid('getrows');
			 	
			 for(var i=0 ; i <= rows.length ; i++){
				 
				/*  qty unitprice total nettotal account accname headdoc  grtype
				 
				 sertype qty price total basetotal actype description account gr_type
				  */
					 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "type",$('#jqxEstimation').jqxGrid('getcellvalue',i, "actype"));
				  
					 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "account",$('#jqxEstimation').jqxGrid('getcellvalue',i, "account"));
					 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "accname",$('#jqxEstimation').jqxGrid('getcellvalue',i, "description"));
					 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "headdoc",$('#jqxEstimation').jqxGrid('getcellvalue',i, "acno"));
					 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "grtype",$('#jqxEstimation').jqxGrid('getcellvalue',i, "gr_type"));
				 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "description",$('#jqxEstimation').jqxGrid('getcellvalue',i, "sertype"));
				 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "qty",$('#jqxEstimation').jqxGrid('getcellvalue',i, "qty"));
				 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "unitprice",$('#jqxEstimation').jqxGrid('getcellvalue',i, "price"));
				 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "total",$('#jqxEstimation').jqxGrid('getcellvalue',i, "total"));
				 $('#nidescdetailsGrid').jqxGrid('setcellvalue', i, "nettotal",$('#jqxEstimation').jqxGrid('getcellvalue',i, "basetotal"));
		if( i == (rows.length-1))
				{
			
				}
		else
			{
			 $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
			}
				   
			 }  
		   }
		   
	   }
	   
	   
</script>
</head>
<body width="100%" onload="setValues()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCFI" action="saveCFI" autocomplete="OFF" >
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
 <fieldset>
<table width="100%" >                        
  <tr>
    <td width="11%" align="right">Date</td> 
    <td width="11%"><div id='estmDate' name='estmDate' value='<s:property value="estmDate"/>'></div>
        <input type="hidden" id="hidestmDate" name="hidestmDate" value='<s:property value="hidestmDate"/>'/></td>
    
 <select  hidden="true" name="cmbreftype" id="cmbreftype" style="width:100%">
     
 
    <td width="4%" align="right">JOB No.</td>
    <td width="22%"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>' placeholder="Press F3 to search" readonly onkeydown="searchRefno(event);" /></td>
   
   
    <td width="4%" align="right">Ref No.</td>
    <td width="22%"><input type="text" name="refnos" id="refnos" value='<s:property value="refnos"/>' /></td>
 
    <td width="12%" align="right">Doc No</td>
    <td width="17%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' /></td>
  </tr>
       
 
 
 </table>
  <table width="100%" hidden="true" >
   <tr>
   <input type="hidden" id="txtclient" name="txtclient" value='<s:property value="txtclient"/>'>
  <input type="hidden" id="txtclientname" name="txtclientname" style="width: 40%;" value='<s:property value="txtclientname"/>' >
    <td width="10.8%" align="right"> </td>
    <td><input type="hidden" id="txtaddress" name="txtaddress" style="width:70%;" value='<s:property value="txtaddress"/>'></td>


  </tr>
  </table>
  <table  width="100%"  hidden="true" >
  <tr>
    <td align="right" width="10.8%"> </td>
    <td width="33.2%" ><input type="hidden" id="txtmobile" name="txtmobile" style="width:68.7%;" value='<s:property value="txtmobile"/>' ></td>
    <td align="right" width="3%" > </td>
    <td > <input type="hidden" id="txtemail" name="txtemail" style="width: 49.2%;" value='<s:property value="txtemail"/>' ></td>
  </tr>
  </table>
  <table  width="100%">
  <tr>
  <td align="right" width="10.8%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:69.9%;" value='<s:property value="txtRemarks"/>'></td>
  </tr>
</table>  

</fieldset>    
 
<fieldset>
<legend>Service Type </legend>
<div id="enqdiv">
<jsp:include page="estmgrid.jsp"></jsp:include></div>
</fieldset>
 


<fieldset>
<legend>Expenses Incurred </legend>
<table width="100%">
 
<tr><td>
<div id="expdiv"><jsp:include page="expgrid.jsp"></jsp:include></div>
</td></tr>
</table>
</fieldset>

<table width="100%"> 
<tr> 
<td align="right">MAWB</td><td> <input type="text" id="mawb" name="mawb" style="width:100%;" value='<s:property value="mawb"/>'></td>
<td  align="right">MBL</td><td> <input type="text" id="mbl" name="mbl"  style="width:100%;" value='<s:property value="mbl"/>'></td>
<td  align="right">HAWB</td><td> <input type="text" id="hawb" name="hawb"  style="width:100%;" value='<s:property value="hawb"/>'></td>
<td  align="right">HBL</td><td> <input type="text" id="hbl" name="hbl" style="width:100%;" value='<s:property value="hbl"/>'></td>
<td  align="right">Shipper</td><td> <input type="text" id="shipper" name="shipper"  style="width:100%;" value='<s:property value="shipper"/>'></td>
<td  align="right">Consignee</td><td> <input type="text" id="consignee" name="consignee"  style="width:100%;" value='<s:property value="consignee"/>'></td>
<td  align="right">Carrier</td><td> <input type="text" id="carrier" name="carrier"  style="width:100%;" value='<s:property value="carrier"/>'></td>
<td  align="right">FlightNo.</td><td> <input type="text" id="flightno" name="flightno" style="width:100%;" value='<s:property value="flightno"/>'></td>
</tr>

<tr>

<td  align="right">Vessel /Voage</td><td> <input type="text" id="Voage" name="Voage"  style="width:100%;" value='<s:property value="Voage"/>'></td>
<td  align="right">ETD</td><td> <input type="text" id="etd" name="etd"  style="width:100%;" value='<s:property value="etd"/>'></td>
<td  align="right">ETA</td><td> <input type="text" id="eta" name="eta" style="width:100%;" value='<s:property value="eta"/>'></td>
<td  align="right">Transit Time</td><td> <div id='ttime' name='ttime' value='<s:property value="ttime"/>'></div>
        <input type="hidden" id="hidttime" name="hidttime" value='<s:property value="hidttime"/>'/></td>
 


<td  align="right">BoE</td><td> <input type="text" id="boe" name="boe"  style="width:100%;" value='<s:property value="boe"/>'></td>
<td  align="right">ContainerNo.</td><td> <input type="text" id="contno" name="contno"  style="width:100%;" value='<s:property value="contno"/>'></td>
<td  align="right">TruckNo.</td><td> <input type="text" id="truckno" name="truckno"  style="width:100%;" value='<s:property value="truckno"/>'></td>
</tr>

</table>


















<br>
  <fieldset>
 
<table width="100%">
 <tr><td align="center"><input type="button" name="btnUpdateDate1" id="btnUpdateDate1" value="Load"   class="myButton" onclick="funsetdata();"></td> 
 <td align="center">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td> 
 <!-- <td align="center"><input type="button" name="btnUpdateDate" id="btnUpdateDate" value="Save" class="myButton" onclick="funsave();" hidden="true"></td> --></tr>
  
<tr ><td colspan="3">
<div id="srvgrid"><jsp:include page="descgridDetails.jsp"></jsp:include></div>
</td></tr>
</table>
</fieldset>  





<div id="estmdiv" hidden="hidden">
</div>

<input type="hidden" id="savestatus" name="savestatus" value='<s:property value="savestatus"/>' />

<input type="hidden" id="gridlenght" name="gridlenght" value='<s:property value="gridlenght"/>' />
	
	<input type="hidden" id="termsval" name="termsval"  value='<s:property value="termsval"/>'/>
	
<input type="hidden" id="mastertr_no" name="mastertr_no" value='<s:property value="mastertr_no"/>' /> 

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="enqdoc" id="enqdoc" value='<s:property value="enqdoc"/>' />
<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />
<input type="hidden" id="enqgridlenght" name="enqgridlenght" />
<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />  
<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' />  
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>

<div id="currencysearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
<div id="unitsearchwindow">
   <div ></div>
</div>
<div id="vendorsearchwindow">
   <div ></div>
</div>


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
	 
			 <div id="nipurchslnosearch">
		   <div></div>
		</div> 

</div>
</body>
</html>