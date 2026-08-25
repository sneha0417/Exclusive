<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">

.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		
		   $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			
				   // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }})
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	         
	     
	     $('#clientsearch1').jqxWindow({ width: '40%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  $('#contractwindow').jqxWindow({ width: '50%', height: '52%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#contractwindow').jqxWindow('close');
		  $('#brandsearch').jqxWindow({ width: '50%', height: '52%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Brand Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#brandsearch').jqxWindow('close');
	     
	     $('#productsearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '90%' ,maxWidth: '80%' ,title: ' Product Search ' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#productsearchwndow').jqxWindow('close'); 
			

			 
		     $('#txtclient').dblclick(function(){
				   
		    	 $('#clientsearch1').jqxWindow('open');
		    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
				   		
				 });
		     
		    
			  $('#txtcontract').dblclick(function(){
			  	    $('#contractwindow').jqxWindow('open');
			   
			  	  contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
		    });
			  $('#txtproduct').dblclick(function(){
			  	    $('#productsearchwndow').jqxWindow('open');
			   
			  	  productSearchContent('productMasterSearch.jsp?', $('#productsearchwndow'));
		    });
			  
			  $('#txtbrand').dblclick(function(){
			  	    $('#brandsearch').jqxWindow('open');
			   
			  	  brandSearchContent('brandMasterSearch.jsp?', $('#brandsearch'));
		    });
			 
		    
			  
	});
	
	
	function getclinfo(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#clientsearch1').jqxWindow('open');
		 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
		 else{
			 }
		 } 
	     function clientSearchContent(url) {
	           
	               $.get(url).done(function (data) {
	  
		           $('#clientsearch1').jqxWindow('setContent', data);

	    	}); 
	         	}

	     function getcontract(event){

				var x= event.keyCode;
			 	 if(x==114){
			 		 $('#contractwindow').jqxWindow('open');
			 		// changeContent('contractMastersearch.jsp');  
			 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
			    	 }
			 	 else{
			 		 
			 		 }
			 	 }
			    	 
			function contractSearchContent(url) {
				 $.get(url).done(function (data) {
				$('#contractwindow').jqxWindow('setContent', data);
			           	}); 
			 	}
	
			 function getproduct(event){

					var x= event.keyCode;
				 	 if(x==114){
				 		 $('#productsearchwndow').jqxWindow('open');
				 		// changeContent('contractMastersearch.jsp');  
				 		 productSearchContent('productMasterSearch.jsp?', $('#productsearchwndow'));
				    	 }
				 	 else{
				 		 
				 		 }
				 	 }
	
	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			
      		$('#productsearchwndow').jqxWindow('setContent', data);
      
      	}); 
      } 
	
	 function getbrand(event){

			var x= event.keyCode;
		 	 if(x==114){
		 		 $('#brandsearch').jqxWindow('open');
		 		// changeContent('contractMastersearch.jsp');  
		 		 brandSearchContent('brandMasterSearch.jsp?', $('#brandsearch'));
		    	 }
		 	 else{
		 		 
		 		 }
		 	 }

function brandSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		
	$('#brandsearch').jqxWindow('setContent', data);

}); 
} 
	
	function funreload(event){

		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var clientid=$('#txtclientid').val();
		 
		 var contrid=document.getElementById("txtcontractid").value;
		 var prodid=document.getElementById("txtproductid").value;
		 var brandid=document.getElementById("txtbrandid").value;
		 
		 $("#overlay, #PleaseWait").show();  
		 $("#detailDiv").load("procurementStatusGrid.jsp?branchval="+branchval+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&contrid="+contrid+"&prodid="+prodid+"&brandid="+brandid+"&check=1");
	}
	

	function funExportBtn(){
	    

		JSONToCSVCon(matdata, 'Procurement Status', true);
		   }
function funcleardata()
{
	document.getElementById("txtclient").value="";
	document.getElementById("txtclientid").value="";
	document.getElementById("txtcontract").value="";
	document.getElementById("txtcontractid").value="";
	document.getElementById("txtproduct").value="";
	document.getElementById("txtproductid").value="";
	document.getElementById("txtbrand").value="";
	document.getElementById("txtbrandid").value="";
	document.getElementById("txtareadet").value="";
	       
	 $('#txtclient').attr('placeholder', 'Press F3 TO Search'); 
	 $('#txtcontract').attr('placeholder', 'Press F3 TO Search'); 
	 $('#txtproduct').attr('placeholder', 'Press F3 TO Search'); 
	 $('#txtbrand').attr('placeholder', 'Press F3 TO Search'); 
	}
		
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2"></td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>                 
	 
   
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr>
	      <td align="right" width="26%" ><label class="branch"> Client</label></td>
	      <td ><input style="width:170px;height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclient(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtclientid" name="txtclientid" value='<s:property value="txtclientid"/>'>
	      </td></tr>
	      <tr><td colspan="2"></td></tr>
	<tr>
	      <td align="right"><label class="branch"> Contract No.</label></td>
	      <td >
	    
	      <input style="width:170px;height:19px;" type="text" name="txtcontract" id="txtcontract" placeholder="Press F3 To Search"  onKeyDown="getcontract(event);" readonly value='<s:property value="txtcontract"/>'>
	      <input type="hidden" id="txtcontractid" name="txtcontractid" value='<s:property value="txtcontractid"/>'>
	      </td></tr>
	      <tr><td colspan="2"></td></tr>
	 <tr>
	      <td align="right"><label class="branch"> Product</label></td>
	      <td ><input style="width:170px;height:19px;" type="text" name="txtproduct" id="txtproduct" value='<s:property value="txtproduct"/>' onKeyDown="getproduct(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtproductid" name="txtproductid" value='<s:property value="txtproductid"/>'>
	      </td></tr>
	
	<tr><td colspan="2"></td></tr>
	 <tr>
	      <td align="right"><label class="branch"> Brand</label></td>
	      <td ><input style="width:170px;height:19px;" type="text" name="txtbrand" id="txtbrand" value='<s:property value="txtbrand"/>' onKeyDown="getbrand(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtbrandid" name="txtbrandid" value='<s:property value="txtbrandid"/>'>
	      </td></tr>
	      
	      <tr><td colspan="2"></td></tr>
	      
	      
	 <tr>
	 <td align="right"><label class="branch"> Details</label></td>
	 <td><textarea rows="6" cols="21" name="txtareadet" id="txtareadet" readonly></textarea>

</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 
	    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
	 
	  <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	
	 
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtsalid" name="txtsalid" style="width:100%;height:20px;" value='<s:property value="txtsalid"/>'/>
     <input type="hidden" id="txtrdocno" name="txtrdocno" style="width:100%;height:20px;" value='<s:property value="txtrdocno"/>'/>
     <input type="hidden" id="txtbrchid" name="txtbrchid" style="width:100%;height:20px;" value='<s:property value="txtbrchid"/>'/>
     <input type="hidden" id="txtuserid" name="txtuserid" style="width:100%;height:20px;" value='<s:property value="txtuserid"/>'/>
      <input type="hidden" name="subgridlength" id="subgridlength" value='<s:property value="subgridlength"/>'>
      <input type="hidden" name="contracttrno" id="contracttrno" value='<s:property value="contracttrno"/>'>
      <input type="hidden" name="contractdocno" id="contractdocno" value='<s:property value="contractdocno"/>'>
      <input type="hidden" id="puchasechk" name="puchasechk"/> 
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%" style=" vertical-align: top;">
		
		<tr><td><div id="detailDiv"><jsp:include page="procurementStatusGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="productsearchwndow">
   <div ></div> 
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="contractwindow">
   <div ></div>
</div>
            	
		<div id="brandsearch"> 
   <div ></div>
</div>
	
</div> 
</body>
</html>