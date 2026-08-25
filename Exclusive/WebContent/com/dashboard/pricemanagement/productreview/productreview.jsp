
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
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
.myButtonss {
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
.myButtonss:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtonss:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
 
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
	 $("#updatdata").attr("disabled",true);
		$('#catsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#catsearchwindow').jqxWindow('close');
		$('#subcatsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#subcatsearchwindow').jqxWindow('close');
		
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
		
		
		
		
		   $('#brandwindow').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');   
		
		   $('#productwindow').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');   
		   $('#ptypewindow').jqxWindow({ width: '30%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		  
		   $('#pcategorywindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');  
		   $('#pdeptwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pdeptwindow').jqxWindow('close');
		     $('#psubcategorywindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		   
			 
		$('#name').dblclick(function(){
			 if($('#type').val()=="BR")
				 {
				 brandFormSearchContent('brandFormSearchGrid.jsp');  
				 } 
			 else if($('#type').val()=="CA")
				 {
				 catFormSearchContent('catFormSearchGrid.jsp'); 
				 }
			 else if($('#type').val()=="SC")
				 {
				 subCatFormSearchContent('subCatFormSearchGrid.jsp');
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
function subCatFormSearchContent(url) {
	$('#subcatsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#subcatsearchwindow').jqxWindow('setContent', data);
		$('#subcatsearchwindow').jqxWindow('bringToFront');
	});
}
function catFormSearchContent(url) {
	$('#catsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#catsearchwindow').jqxWindow('setContent', data);
		$('#catsearchwindow').jqxWindow('bringToFront');
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
else if($('#type').val()=="CA")
	 {
	 catFormSearchContent('catFormSearchGrid.jsp'); 
	 }
else if($('#type').val()=="SC")
	 {
	 subCatFormSearchContent('subCatFormSearchGrid.jsp');
	 }
else if($('#type').val()=="PR")
{
	 productSearchContent('productSearch.jsp');
}
	
	
	}


function funExportBtn(){
	JSONToCSVCon(dat1, 'General Review', true);
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
	   else
		   {
		var type=   $("#type option:selected").text().trim();
		   
		   if(document.getElementById("name").value=="")
			   {
			   
			   $.messager.alert('Message',' Search Your '+type ); 
			   document.getElementById("name").focus();
			   return 0;
			   }
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var type=$("#type").val();
	 
	 
	 var brandid=$("#brandid").val();
	 var catid=$("#catid").val();
	 var subcatid=$("#subcatid").val();                  
	 var psrno=$("#psrno").val();  
 
	 var hidbrandid=$("#hidbrandid").val(); 
	 var hidtypeid=$("#hidtypeid").val(); 
	 var hideptid=$("#hideptid").val(); 
	 var hidcatid=$("#hidcatid").val(); 
	 var hidsubcatid=$("#hidsubcatid").val(); 
	 var hidproductid=$("#hidproductid").val(); 
	 
	 
	 var optype=$("#optype").val();
	 
	   $("#overlay, #PleaseWait").show(); 
	   var load="yes";
		 
	//  hidbrandid hidtypeid hideptid hidcatid hidsubcatid hidproductid
		 
		
	   
 	  $("#mainlistdiv").load("mainlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&type="+type
 			  +"&brandid="+brandid+"&catid="+catid+"&subcatid="+subcatid+"&psrno="+psrno+"&load="+load+"&hidbrandid="+hidbrandid
 			  +"&hidtypeid="+hidtypeid+"&hideptid="+hideptid+"&hidcatid="+hidcatid+"&hidsubcatid="+hidsubcatid+"&hidproductid="+hidproductid+"&optype="+optype);
 
	
		   }
	}
	
 
  
  function funCalculate()
  {
	  
	  
		 $("#updatdata").attr("disabled",false);
	  var discountval=document.getElementById("discountval").value;
	  
	  if(discountval=="" || typeof(discountval)=="undefined")
			  {
		  $.messager.alert('Message', ' Enter Max Discount ', function(r){
			     
		     });
		  
		  
		  return 0;
			  }
	  
	 	var rows = $("#jqxpmgt").jqxGrid('getrows');
	    for(var i=0 ; i < rows.length ; i++){
	    	var pricegroup=rows[i].pricegroup;
	      	var counts=rows[i].counts;
	      	
	      	if(pricegroup>0)
	      		{
	     	if(pricegroup==1)
	    			{
	    			$('#jqxpmgt').jqxGrid('setcellvalue', i, "discount1",discountval);
	    			}
	     	else {
               var allowdiscount=(parseFloat(discountval)/parseInt(counts))*(counts-pricegroup+1);
	     		
	     		$('#jqxpmgt').jqxGrid('setcellvalue', i, "discount1",allowdiscount);
	     	}
	     		 
	      		}
	    	 
	    }
	  
  }
  function funupdates()
  {
	  
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		 	  
		     
		   	if(r==false)
		   	  {
		   		
		   	  }
		   	else
		   		{
 
	   save();
		   		}
		   	
		}); 
  }
  function save(){
	  
	  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				 	
				 	//alert(items);
				 	
      if(parseInt(itemval)==1)
      	{
				 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });
				    
 
					  $("#updatdata").attr("disabled",true);  
				  
				 	
				}
			else
				{
				$.messager.alert('Message', '  Not Updated ', function(r){
				     
			     });
				}  
		}
		}
	x.open("GET","pricesavedata.jsp?psrno="+document.getElementById("psrno").value+'&std_cost='+document.getElementById("std_cost").value+'&fixing='+document.getElementById("fixing").value);
		x.send();
	}

 
	function hidebranch()
	{
	 
		  /* $("#branchdiv").hide();
		  $("#branchlabel").hide(); */
		 
	}
	function clearnames()
	
	
	{
		
		
		 $("#mainlistgrid").jqxGrid('clear');
		
		  $("#mainlistgrid").jqxGrid('addrow', null, {});
		  $("#jqxpmgt").jqxGrid('clear');
		  document.getElementById("name1").innerText="";
			 document.getElementById("name2").innerText="";
			 document.getElementById("name3").innerText="";
			 document.getElementById("productid").innerText="";
			 document.getElementById("productname").innerText="";
			 document.getElementById("productbrand").innerText="";
			 document.getElementById("discountval").value="";
			 	
			 	document.getElementById("rowindexs").value="";
			 	document.getElementById("std_cost").value="";
			 	document.getElementById("psrno").value="";
			 	document.getElementById("labourcharge").value="";
				document.getElementById("fixing").value="";
				
			 	document.getElementById("name").value="";
			 	document.getElementById("brandid").value="";
			 	document.getElementById("catid").value="";
			 	document.getElementById("subcatid").value="";
 
		
	}
	     function funprocess1()
	   {
			   $("#overlay, #PleaseWait").show();
		   setTimeout(function(){
			    
		   funprocess();
			    
			}, 2000);
		  
		 
	   }
	 
	
	   function funprocess()
		
		{	  
		     
		  
		   
			var rows = $("#mainlistgrid").jqxGrid('getrows');
			
			var i=0;
			var k=rows.length-1;
			   for(i=0 ; i < rows.length ; i++){

	 	var std_cost=rows[i].std_cost;
	 	
	 	 
	 	if(std_cost>0 && std_cost!="" && typeof(std_cost)!="undefined")
	       {
	 		$('#mainlistgrid').jqxGrid('setcellvalue', i, "std_cost",0);
		
			   }
	 	
		if(std_cost>0 && std_cost!="" && typeof(std_cost)!="undefined")
	    {
			$('#mainlistgrid').jqxGrid('setcellvalue', i, "std_cost",std_cost);
			
			$('#mainlistgrid').jqxGrid('setcellvalue', i, "cellselects",1);
			
		
			   }
	 	
		/* if(i==k)
			{
			  document.getElementById("loadings").innerText="";
			} */
		
	 	
			   }
			   $("#overlay, #PleaseWait").hide();
		}
	   
		 
		 
	   function getPtype(){
	   	 
	    	  $('#ptypewindow').jqxWindow('open');
	   		$('#ptypewindow').jqxWindow('focus');
	   		typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

	   }


	   function getPbrand(t){
	   	 
	   	  $('#brandwindow').jqxWindow('open');
	   		$('#brandwindow').jqxWindow('focus');
	   		brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

	   }

	   function getPmodel(t){
	   	
	   	var brandid=$('#hidsbrandid').val().trim();
	   	
	   	if(brandid==""){
	   		 $.messager.alert('Message','Select Brand','warning');
	   		 
	   		 return 0;
	   	 }
	   	
	   	  $('#modelwindow').jqxWindow('open');
	   	  $('#modelwindow').jqxWindow('focus');
	   		 modelSearchContent('modelSearch.jsp?id='+t+'&brandid='+brandid, $('#modelwindow'));

	   }

	   function getSubmodel(){
	   	
	   	var brandid=$('#hidsbrandid').val().trim();
	   	var modelid=$('#hidsmodelid').val().trim();
	   	
	   	if(brandid==""){
	   		 $.messager.alert('Message','Select Brand','warning');
	   		 
	   		 return 0;
	   	 }
	   	
	   	if(modelid==""){
	   		 $.messager.alert('Message','Select Model','warning');
	   		 
	   		 return 0;
	   	 }
	   	
	   	  $('#submodelwindow').jqxWindow('open');
	   	  $('#submodelwindow').jqxWindow('focus');
	   	  subModelSearchContent('SubModelSearch.jsp?modelid='+modelid+'&brandid='+brandid, $('#submodelwindow'));

	   }




	   function getPcategory(){

	   	  $('#pcategorywindow').jqxWindow('open');
	   		$('#pcategorywindow').jqxWindow('focus');
	   		 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
	   }

	   function getDept(){

	   	  $('#pdeptwindow').jqxWindow('open');
	   		$('#pdeptwindow').jqxWindow('focus');
	   		 deptSearchContent('deptSearch.jsp', $('#pdeptwindow'));
	   }


	   function getPsubcategory(){
	   	var catid=$('#hidcatid').val().trim();
	   	 $('#psubcategorywindow').jqxWindow('open');
	   		$('#psubcategorywindow').jqxWindow('focus');
	   		 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

	   }


	   function getProduct(){
	   	
	   	var brandid=$('#hidbrandid').val().trim();
	   	var catid=$('#hidcatid').val().trim();
	   	var subcatid=$('#hidsubcatid').val().trim();
	   	
	   	 $('#productwindow').jqxWindow('open');
	   		$('#productwindow').jqxWindow('focus');
	   		 productSearchContent('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

	   }

	   function typeSearchContent(url) {
		   //alert(url);
		     $.get(url).done(function (data) {
		 //alert(data);
		   $('#ptypewindow').jqxWindow('setContent', data);

		 }); 
		 }
		 function brandSearchContent(url) {
		   //alert(url);
		     $.get(url).done(function (data) {
		 //alert(data);
		   $('#brandwindow').jqxWindow('setContent', data);

		 }); 
		 }

		 function modelSearchContent(url) {
		   //alert(url);
		     $.get(url).done(function (data) {
		 //alert(data);
		   $('#modelwindow').jqxWindow('setContent', data);

		 }); 
		 }

		 function subModelSearchContent(url) {
		 	  //alert(url);
		 	    $.get(url).done(function (data) {
		 	//alert(data);
		 	  $('#submodelwindow').jqxWindow('setContent', data);

		 	}); 
		 	}

		 function categorySearchContent(url) {
		   //alert(url);
		     $.get(url).done(function (data) {
		 //alert(data);
		   $('#pcategorywindow').jqxWindow('setContent', data);

		 }); 
		 }

		 function deptSearchContent(url) {
		 	  //alert(url);
		 	    $.get(url).done(function (data) {
		 	//alert(data);
		 	  $('#pdeptwindow').jqxWindow('setContent', data);

		 	}); 
		 	}

		 function subcategorySearchContent(url) {
		   //alert(url);
		     $.get(url).done(function (data) {
		 //alert(data);
		   $('#psubcategorywindow').jqxWindow('setContent', data);

		 }); 
		 }
	   function setprodSearch(){
	   	var value=$('#prodsearchby').val().trim();

	   	if(value=="ptype"){
	   		getPtype();
	   	}
	   	else if(value=="pbrand"){
	   		getPbrand(2);
	   	}
	   	else if(value=="pdept"){
	   		getDept();
	   	}
	   	else if(value=="product"){
	   		getProduct();
	   	}
	   	else if(value=="pcategory"){
	   		getPcategory();
	   	}
	   	else if(value=="psubcategory"){
	   		getPsubcategory();
	   	}
	   	
	   	
	   	else{
	   		
	   	}
	   }
	   function funClearData(){
	   	
	   	 document.getElementById("hidsbrandid").value="";
	   	 document.getElementById("hidsmodelid").value="";
	   	 document.getElementById("hidyomid").value="";
	   	 document.getElementById("hidspec1id").value="";
	   	 document.getElementById("hidspec2id").value="";
	   	 document.getElementById("hidspec3id").value="";
	   	 document.getElementById("hidbrandid").value="";
	   	 document.getElementById("hidtypeid").value="";
	   	 document.getElementById("hidproductid").value="";
	   	 document.getElementById("hidcatid").value="";
	   	 document.getElementById("hidsubcatid").value=""; 
	   	 document.getElementById("hidsbrand").value="";
	   	 document.getElementById("hidsmodel").value="";
	   	 document.getElementById("hidyom").value="";
	   	 document.getElementById("hidspec1").value="";
	   	 document.getElementById("hidspec2").value="";
	   	 document.getElementById("hidspec3").value="";
	   	 document.getElementById("hidbrand").value="";
	   	 document.getElementById("hidtype").value="";
	   	 document.getElementById("hidproduct").value="";
	   	 document.getElementById("hidcat").value="";
	   	 document.getElementById("hidsubcat").value="";

	   	 document.getElementById("prodsearchby").value="";
	   	 document.getElementById("searchdetails").value="";
	   	 document.getElementById("hideptid").value="";
	   	 document.getElementById("hidept").value="";
	   	 document.getElementById("cmbbranch").value="a";
	   	 //$("#partSearchdiv").load("partSearchGrid.jsp");
	   	  //clearnames();
	   	
	   }
	   function setRemove(){
	   	
	   	var suitvalue="";
	   	var prodvalue=$('#prodsearchby').val().trim();
	   	
	   	if(prodvalue=="ptype"){
	   		 
	   		 document.getElementById("hidtypeid").value="";
	   		 document.getElementById("hidtype").value="";
	   		 
	   	}
	   	else if(prodvalue=="pbrand"){
	   		document.getElementById("hidbrandid").value="";
	   		document.getElementById("hidproduct").value="";
	   		
	   	}
	   	else if(prodvalue=="product"){
	   		document.getElementById("hidproductid").value="";
	   		document.getElementById("hidbrand").value="";
	   	}
	   	else if(prodvalue=="pcategory"){
	   		 document.getElementById("hidcatid").value="";
	   		 document.getElementById("hidcat").value="";
	   		 
	   	}
	   	else if(prodvalue=="psubcategory"){
	   		document.getElementById("hidsubcatid").value="";
	   		document.getElementById("hidsubcat").value="";
	   	}
	   	else if(prodvalue=="pdept"){
	   		document.getElementById("hideptid").value="";
	   		document.getElementById("hidept").value="";
	   	}
	   	
	   	if(suitvalue=="sbrand"){
	   		 document.getElementById("hidsbrandid").value="";
	   		 document.getElementById("hidsbrand").value="";
	   		 
	   	}
	   	else if(suitvalue=="smodel"){
	   		document.getElementById("hidsmodelid").value="";
	   		document.getElementById("hidsmodel").value="";
	   		
	   	}
	   	else if(suitvalue=="syom"){
	   		document.getElementById("hidyomid").value="";
	   		 document.getElementById("hidyom").value="";
	   		 
	   	}
	   	
	   	else if(suitvalue=="spec1"){
	   		document.getElementById("hidspec1id").value="";
	   		document.getElementById("hidspec1").value="";
	   		 
	   	}
	   	else if(suitvalue=="spec2"){
	   		document.getElementById("hidspec2id").value="";
	   		document.getElementById("hidspec2").value="";
	   		 
	   	}
	   	else if(suitvalue=="spec3"){
	   		document.getElementById("hidspec3id").value="";
	   		document.getElementById("hidspec3").value="";
	   	}
	   	document.getElementById("searchdetails").value="";
	   	
	   	if(document.getElementById("hidsbrand").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsbrand").value;	
	   	}
	   	if(document.getElementById("hidsmodel").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsmodel").value;	
	   	}
	   	if(document.getElementById("hidyom").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidyom").value;	
	   	}
	   	if(document.getElementById("hidspec1").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec1").value;	
	   	}
	   	if(document.getElementById("hidspec2").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec2").value;	
	   	}
	   	if(document.getElementById("hidspec3").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec3").value;	
	   	}
	   	if(document.getElementById("hidbrand").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidbrand").value;	
	   	}
	   	if(document.getElementById("hidtype").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidtype").value;	
	   	}
	   	if(document.getElementById("hidcat").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidcat").value;	
	   	}
	   	if(document.getElementById("hidsubcat").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsubcat").value;	
	   	}
	   	if(document.getElementById("hidproduct").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidproduct").value;	
	   	}
	   	if(document.getElementById("hidept").value!=""){
	   		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidept").value;	
	   	}
	   }


</script>
</head>
<body onload="getBranch();hidebranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		 
<%-- 	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr> --%>
                    
           <tr><td  align="right" colspan="2">
	    <table  width="100%"    >
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td><td colspan="2" rowspan="2">&nbsp;&nbsp; <button type="button" hidden="true" class="icon" id="process" title="Process" onclick="funprocess1();">
							<img alt="process" src="<%=contextPath%>/icons/process2.png" width="18" height="18">
						</button> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td>
                    </tr>
            	
       </table>
               
       
       </td></tr>            
                    
                    
                    
  <tr><td  align="right" ><label class="branch">Type</label></td><td  align="left"   ><select id="type" style="width: 75%;height:20PX;"   name="type" onchange="clearnames()">
  <option value="BR">Brand</option>
  <option value="CA">Category</option>
  <option value="SC">Sub Category</option>
  <option value="PR">Product</option>
  
  </select></td></tr>
  
  <tr> <td  align="left" ></td><td><input type="text" id="name" style="width: 100%;height:20PX;"  style="width: 75%;"  placeholder="Press F3 for Search" readonly="readonly" onKeyDown="getname(event);" name="name"  value='<s:property value="name"/>'> </td></tr>
  
  
    <tr><td  align="right" ><label class="branch">Option</label></td><td  align="left"   ><select id="optype" style="width: 75%;height:20PX;"   name="optype" >
  <option value="EP">Existing Product</option>
  <option value="NR">Existing Not Reviewed</option>
  <option value="NP">New Product</option>
 
  
  </select></td></tr>
  
 
 	<tr><td  align="center" colspan="2"><input type="Button" name="updatdata" id="updatdata" class="myButton" value="Update" onclick="funupdates()"></td></tr>
 	 
  	       <tr >
	  <td align="right"><label class="branch">PRODUCT</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;"> 
    <option value="">--Select--</option>
    <option value="ptype">TYPE</option>
    <option value="pbrand">BRAND</option>
    <option value="pdept">DEPARTMENT</option>
    <option value="pcategory">CATEGORY</option>
    <option value="psubcategory">SUB CATEGORY</option>
    <option value="product">PRODUCT</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="16"  readonly></textarea></td>
	  </tr>
	<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtonss" onclick="funClearData();"></center>
    </td>
	</tr>     	        	        	  
       <input type="hidden" id="brandid" name="brandid" >  
       <input type="hidden" id="catid" name="catid" >
       <input type="hidden" id="subcatid" name="subcatid" >      
 

 
 
 	<input type="hidden" id="psrno" name="psrno" >
 	 	<input type="hidden" id="rowindexs" name="rowindexs" >       
 	 	<input type="hidden" id="discountval" name="discountval" >
 	 	
 	 		<input type="hidden" id="std_cost" name="std_cost" >
 	 	 	 	<input type="hidden" id="fixing" name="fixing" >
 	 	 	 	
 	 	 	 	
 	 	 	 		<input type="hidden" id="labourcharge" name="labourcharge" >
 	
 	
 	
 	
			  
 			  
			  <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidmodelid" id="hidmodelid">
			  <input type="hidden" name="hidyomid" id="hidyomid">
			  <input type="hidden" name="hidspec1id" id="hidspec1id">
			  <input type="hidden" name="hidspec2id" id="hidspec2id">
			  <input type="hidden" name="hidspec3id" id="hidspec3id">
			  <input type="hidden" name="hidsubmodelid" id="hidsubmodelid">
			  
              <input type="hidden" name="hidsubmodel" id="hidsubmodel">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidspec1" id="hidspec1">
			  <input type="hidden" name="hidspec2" id="hidspec2">
			  <input type="hidden" name="hidspec3" id="hidspec3">  
			  
			  <input type="hidden" name="hidsbrandid" id="hidsbrandid">  
			  <input type="hidden" name="hidsmodelid" id="hidsmodelid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  
   			<input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidsbrand" id="hidsbrand">
			  <input type="hidden" name="hidsmodel" id="hidsmodel">
			   <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  
			  <input type="hidden" name="hidvehsuitid" id="hidvehsuitid">  
	</table>
	</fieldset>


</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td colspan="2"><div id="mainlistdiv"><jsp:include page="mainlistGrid.jsp"></jsp:include></div></td>
		</tr>
		
	 
		
		
	</table>
</tr>
</table>

</div>
  	<div id="brandsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="catsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="subcatsearchwindow">
			<div></div>
			<div></div>
		</div>	
		
		<div id="brandwindow"><div></div></div>
		<div id="productwindow"><div></div></div>
		<div id="ptypewindow"><div></div></div>
		<div id="pcategorywindow"><div></div></div>
		<div id="pdeptwindow"><div></div></div>
		<div id="psubcategorywindow"><div></div></div>
 

</div>
</body>
</html>