
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtsergroup').dblclick(function(){
			   
	    	 var id=1;
	    	 $('#grpinfowindow').jqxWindow('open');
		      //grpSearchContent('servicegrpsearch.jsp');
	    	 grpSearchContent('servicegrpsearchgrid.jsp?id='+id);
			   		
			 });
	     
	     $('#txtclientname').dblclick(function(){
	    	 
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
	     
	     $('#txtcontract').dblclick(function(){
	    	// var contractType=document.getElementById("ctype").value;//cmbreftype
	    	 var contractType=$("#ctype").val();
	 		//var cldocno=document.getElementById("clientid").value;
	    	
	 		var  cldocno="";

	  	   

		  	    $('#contractwindow').jqxWindow('open');
		  	    
		  		 contractSearchContent('contractDetailsSearch.jsp?contracttype='+contractType+'&cldocno='+cldocno, $('#contractwindow'));  
		   
		  	//  contractSearchContent('contractMastersearch.jsp');
		  	//  contractSearchContent('contractDetailsSearch.jsp?', $('#contractwindow'));
	 });
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 $('#contractwindow').jqxWindow({width: '33%', height: '50%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#contractwindow').jqxWindow('close');
		  $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');

			$('#brandsearchwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '70%',
				title : 'Brand Search',
				position : {
					x : 420,
					y : 87
				},
				theme : 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#brandsearchwindow').jqxWindow('close');	
			 $('#productwindow').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			   $('#productwindow').jqxWindow('close');   
			   
			
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
		  }   
	 });
	 
	 
	 
		$('#name').dblclick(function(){
			 if($('#type').val()=="BR")
				 {
				 brandFormSearchContent('brandFormSearchGrid.jsp');  
				 } 
			
			 else if($('#type').val()=="PR")
			 {
				 productSearchContent('productSearch1.jsp');
			 }
		});  
});


function brandFormSearchContent(url) {
	$('#brandsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#brandsearchwindow').jqxWindow('setContent', data);
		$('#brandsearchwindow').jqxWindow('bringToFront');
	});
}

function productSearchContent(url) {
	$('#productwindow').jqxWindow('open');
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}



function getname(event)
{
	if($('#type').val()=="BR")
	 {
	 brandFormSearchContent('brandFormSearchGrid.jsp');  
	 } 

else if($('#type').val()=="PR")
{
	 productSearchContent('productSearch.jsp');
}
	
	
	}

function funExportBtn(){
    

	JSONToCSVCon(servicereportlistexcel, 'Reserved Product', true);
	   }



function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }
	  
	 	 
	  
     var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds=$('#ctype').val(); //amc or sjob
	 var contrctid= $("#contracttrno").val();
	 var clientid=$('#txtclientaccountdocno').val();
	var cldocno=$("#hidcldocno").val();
	 var type=$("#type").val(); //brand or product
	 var brandid="";
	 var productid="";
	 if(type=="BR"){
		  brandid=$("#brandid").val();
	 }
	 if(type=="PR"){
		 productid=$("#psrno").val();
	 }
	 
	 $("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&contrctid="+contrctid+"&clientid="+clientid+"&type="+type+"&brandid="+brandid+"&productid="+productid+"&cldocno="+cldocno);
	
	  
	}

function getClientAccount(event){
	
    var x= event.keyCode;
    if(x==114){
  	  accountsSearchContent('clientAccountDetailsSearch.jsp');
    }
    else{}
    }
function accountsSearchContent(url) {
	
 $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getgrpcode(event,id){
	 
	 var x= event.keyCode;
	 if(x==114){
	  $('#grpinfowindow').jqxWindow('open');
     grpSearchContent('servicegrpsearchgrid.jsp');
  	 }
	 else{
		 }
	 }
  	 
function grpSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#grpinfowindow').jqxWindow('setContent', data);

         	}); 
	}
	
function clearnames()
{
	$("#name").val("");
	$("#brandid").val("");
	$("#psrno").val("");	
}
function getcontract(event){
alert(document.getElementById("ctype").value);
	   var contractType=document.getElementById("ctype").value;
		//var cldocno=document.getElementById("clientid").value;
		alert(contractType);
	   var cldocno="";
				var x= event.keyCode;
	 	 if(x==114){
	 		 $('#contractwindow').jqxWindow('open');
	 		// changeContent('contractMastersearch.jsp');  
	 		 contractSearchContent('contractDetailsSearch.jsp?contracttype='+contractType+'&cldocno='+cldocno, $('#contractwindow'));
	    	 }
	 	 else{
	 		 
	 		 }
	 	 }
	    	 
	function contractSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#contractwindow').jqxWindow('setContent', data);
	           	}); 
	 	}

	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100% "  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    
                    <tr><td  align="right" ><label class="branch">Type</label></td><td  align="left"   ><select id="type" style="width: 75%;height:20PX;"   name="type"  onchange="clearnames()">
  <option value="BR">Brand</option>
  <option value="PR">Product</option>
  
  </select></td></tr>
  
  <tr> <td  align="left" ></td><td><input type="text" id="name" style="width: 100%;height:20PX;"  style="width: 75%;"  placeholder="Press F3 for Search" readonly="readonly" onKeyDown="getname(event);" name="name"  value='<s:property value="name"/>'> </td></tr>
  
                      <tr><td align="right"><label class="branch"> Job Type</label></td>
     <td align="left"><select id="ctype" name="ctype"  value='<s:property value="ctype"/>'>
     <option value="ALL" >ALL</option><option value="AMC">AMC</option><option value="SJOB">SJOB</option>
     </select></td></tr>
     <tr>
	       <td align="right"><label class="branch">Job No</label></td>
    <td><input style="height:19px;" type="text" name="txtcontract" id="txtcontract" placeholder="Press F3 To Search"  onKeyDown="getcontract(event);" readonly value='<s:property value="txtcontract"/>'></td>
	      </tr>
                     <tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left"><input style="height:19px"; type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClientAccount(event);"/></td></tr>
	 <tr><td colspan="2">
	 <input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno"  value='<s:property value="txtclientaccountdocno"/>'/></td></tr>
    <tr>
      <input type="hidden" id="sergroupid" name="sergroupid" value='<s:property value="sergroupid"/>'></td>
	   <input type="hidden" id="brandid" name="brandid" >
	   <input type="hidden" id="psrno" name="psrno" >
	      </tr>
	 	
         
       
         
         
        
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	

	
		
	</table>
	<table>
	
	       
	       <tr>
	      
	      <td >

      <input type="hidden" id="contracttrno" name="contracttrno" value='<s:property value="contracttrno"/>'>
       <input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'>
      
      
      </td>
	      </tr>  
	      
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr><div id="loadgriddata">
				<jsp:include page="gridDetails.jsp"></jsp:include> 
			</div></tr>
		
	</table>
</tr>
</table>

  	<div id="brandsearchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="productwindow"><div></div></div>
</div>
 <div id="accountDetailsWindow">
	<div></div>
	</div>
	<div id="grpinfowindow">
   <div ></div>
</div>
	<div id="contractwindow">
   <div ></div>

</div>
</body>
</html>