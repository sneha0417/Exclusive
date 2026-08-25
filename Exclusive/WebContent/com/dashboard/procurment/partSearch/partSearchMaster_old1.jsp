
<jsp:include page="../../../../includes.jsp"></jsp:include>    
 <%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<link href="css/body.css" media="screen" rel="stylesheet" type="text/css" /> 
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
</style>

<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		   $('#pbrandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pbrandwindow').jqxWindow('close');
		   $('#pmodelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pmodelwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		   $('#pyomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pyomwindow').jqxWindow('close');
		   $('#spec1window').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#spec1window').jqxWindow('close');
		   $('#spec2window').jqxWindow({ width: '52%',height: '65%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Chart' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
		   $('#spec2window').jqxWindow('close');
		   $('#spec3window').jqxWindow({ width: '52%',height: '65%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Chart' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
		   $('#spec3window').jqxWindow('close');

   
});


function getPtype(){
	 
 	  $('#ptypewindow').jqxWindow('open');
		$('#ptypewindow').jqxWindow('focus');
		typeSearchContent('clientINgridsearch.jsp', $('#ptypewindow'));

}


function getPbrand(){
	 
	  $('#pbrandwindow').jqxWindow('open');
		$('#pbrandwindow').jqxWindow('focus');
		brandSearchContent('clientCatSearch.jsp?id=1', $('#pbrandwindow'));

}

function getPmodel(){
	
	  $('#pmodelwindow').jqxWindow('open');
		$('#pmodelwindow').jqxWindow('focus');
		 modelSearchContent('salesAgentSearch.jsp?id=1', $('#pmodelwindow'));

}

function getPcategory(){

	  $('#pcategorywindow').jqxWindow('open');
		$('#pcategorywindow').jqxWindow('focus');
		 categorySearchContent('rentalAgentSearch.jsp?id=1', $('#pcategorywindow'));
}


function getPsubcategory(){
	 $('#psubcategorywindow').jqxWindow('open');
		$('#psubcategorywindow').jqxWindow('focus');
		 subcategorySearchContent('brandSearch.jsp?id=1', $('#psubcategorywindow'));

}


function getProduct(){
	
	 $('#productwindow').jqxWindow('open');
		$('#productwindow').jqxWindow('focus');
		 productSearchContent('modelSearch.jsp?id=1', $('#productwindow'));

}

function getSpec1(event){

	$('#spec1window').jqxWindow('open');
	$('#spec1window').jqxWindow('focus');
	 spec1SearchContent('groupSearch.jsp?id=1', $('#spec1window'));

}
function getSpec2(event){

	$('#spec2window').jqxWindow('open');
	$('#spec2window').jqxWindow('focus');
	 spec2SearchContent('groupSearch.jsp?id=1', $('#spec2window'));

}
function getSpec3(event){

	$('#spec3window').jqxWindow('open');
	$('#spec3window').jqxWindow('focus');
	 spec3SearchContent('groupSearch.jsp?id=1', $('#spec3window'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
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
  $('#pbrandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#pmodelwindow').jqxWindow('setContent', data);

}); 
}

function categorySearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#pcategorywindow').jqxWindow('setContent', data);

}); 
}

function subcategorySearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#psubcategorywindow').jqxWindow('setContent', data);

}); 
}

function spec1SearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#spec1window').jqxWindow('setContent', data);

}); 
}

function spec2SearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#spec2window').jqxWindow('setContent', data);

	}); 
	}
	
function spec3SearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#spec3window').jqxWindow('setContent', data);

	}); 
	}

function yomSearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#yomwindow').jqxWindow('setContent', data);

}); 
}



function funExportBtn(){
	   $("#qutlistgrid").jqxGrid('exportdata', 'xls', 'Quotation List');
	 }
function funreload(event)
{
	
}

function setSearch(){
	var value=$('#searchby').val().trim();
	
	if(value=="ptype"){
		getPtype();
	}
	else if(value=="pbrand"){
		getPbrand();
	}
	else if(value=="pmodel"){
		getPmodel();
	}
	else if(value=="pcategory"){
		getPcategory();
	}
	else if(value=="psubcategory"){
		getPsubcategory();
	}
	else if(value=="product"){
		getProduct();
	}
	else if(value=="pyom"){
		getYom();
	}
	else if(value=="psepc1"){
		getSpec1();
	}
	else if(value=="pspec2"){
		getSpec2();
	}
	else if(value=="pspec3"){
		getSpec3();
	}
	else{
		
	}



}

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr >
	  <td width="24%" align="right"><label class="branch">Suitability</label></td>
	  <td width="76%"  align="left"><select name="suitsearchby" id="suitsearchby" style="width:52%;">
<option value="">--Select--</option>
    <option value="pbrand">Brand</option>
    <option value="pmodel">Model</option>
    <option value="pyom">YOM</option>
    <option value="pspec1">EngineSize</option>
     <option value="psec2">BedSize</option>
      <option value="pspec3">CabinSize</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
      <tr >
	  <td align="right"><label class="branch">Suitability</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;">
<option value="">--Select--</option>
    <option value="ptype">Type</option>
    <option value="pbrand">Brand</option>
    <option value="pmodel">Model</option>
    <option value="pcategory">Category</option>
    <option value="psubcategory">SubCategory</option>
    <option value="product">Product</option>
    <option value="pyom">YOM</option>
    <option value="pspec1">EngineSize</option>
     <option value="psec2">BedSize</option>
      <option value="pspec3">CabinSize</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr>
	<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><%-- <div id="releasediv"><jsp:include page="partSearchGrid.jsp"></jsp:include></div> --%>
			 <%-- <div id="distributiondiv"  hidden="true"><jsp:include page="salesMonthwiseGrid.jsp"></jsp:include></div> --%>
			 
			 
			 </td>
			  
		</tr>
	</table>
</tr>
</table>
<div id="ptypewindow">
<div></div>
</div>
<div id="pbrandwindow">
<div></div>
</div>
<div id="pmodelwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>
<div id="pyomwindow">
<div></div>
</div>
<div id="spec1window">
<div></div>
</div>
<div id="spec2window">
<div></div>
</div>
<div id="spec3window">
<div></div>
</div>
</div>
</div>
</body>

</html>