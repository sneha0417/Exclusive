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
 
		 
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	      $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		   $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');
		   $('#modelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#modelwindow').jqxWindow('close');
		   $('#submodelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#submodelwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   $('#pdeptwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pdeptwindow').jqxWindow('close');
		   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		
		   $('#locationwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#locationwindow').jqxWindow('close');
	     
	     
		  var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
	});

	function funExportBtn(){
	 
			JSONToCSVCon(partdata, 'Stock Analysis', true);
		 
		 
		 }
	
	
	function funreload(event){


		var prodvalue=$('#prodsearchby').val().trim();
		var type;
		var branchid;
		var hidbrand;
		var hidtype;
		var hidproduct;
		var hidcat;
		var hidsubcat;
		var frmdate;
		var todate;
		var hidsubcat;
		
		 	 branchid=document.getElementById("cmbbranch").value;
		 	 hidbrand=document.getElementById("hidbrandid").value;
			 hidtype=document.getElementById("hidtypeid").value;
			 hidproduct=document.getElementById("hidproductid").value;
			 hidcat=document.getElementById("hidcatid").value;
			 hidsubcat=document.getElementById("hidsubcatid").value;
			 hidept=document.getElementById("hideptid").value;
			 frmdate=$('#fromdate').jqxDateTimeInput('val');
			 //document.getElementById("fromdate").value;
			 todate=$('#todate').jqxDateTimeInput('val');
			 
				var prodgroupby=$('#prodgroupby').val().trim(); 
			 
			 
				var hidlocid=document.getElementById("hidlocid").value;
				  $("#overlay, #PleaseWait").show();
	 
				 var load="yes";
		 $("#stockLedgerDiv").load("stockgrid.jsp?todate="+todate+"&frmdate="+frmdate+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load="+load+"&prodgroupby="+prodgroupby+"&hidlocid="+hidlocid+"&type=1");
			 
 
			 
			 
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
	function getLocation(){
		var cmbbranch=$('#cmbbranch').val().trim();
		 $('#locationwindow').jqxWindow('open');
			$('#locationwindow').jqxWindow('focus');
			 
			locationSearchContent('locationsearch.jsp?brhid='+cmbbranch, $('#locationwindow'));

	}



	function getProduct(){
		
		var brandid=$('#hidbrandid').val().trim();
		var catid=$('#hidcatid').val().trim();
		var subcatid=$('#hidsubcatid').val().trim();
		
		 $('#productwindow').jqxWindow('open');
			$('#productwindow').jqxWindow('focus');
			 productSearchContent('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

	}


	/*


	
	
	 */
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
		

		function locationSearchContent(url) {
		  
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#locationwindow').jqxWindow('setContent', data);

		}); 
		}	 

		function subcategorySearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#psubcategorywindow').jqxWindow('setContent', data);

		}); 
		}

		function productSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#productwindow').jqxWindow('setContent', data);

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
		else if(value=="ploca"){
			getLocation();
		}
		
		else{
			
		}
	}
	
	function fundisable(){
		

		
		if (document.getElementById('rsumm').checked) {
			
			  $('#stockLedgerDiv').show();
			   $('#stockLedgerDetDiv').hide();
			  
			}
		 else if (document.getElementById('rdet').checked) {
			 
			  $('#stockLedgerDiv').hide();
			  $('#stockLedgerDetDiv').show();
			 
			}
		 }
	
	function funClearData(){
		document.getElementById("cmbbranch").value="a";
		 
		 document.getElementById("hidbrandid").value="";
		 document.getElementById("hidtypeid").value="";
		 document.getElementById("hidproductid").value="";
		 document.getElementById("hidcatid").value="";
		 document.getElementById("hidsubcatid").value=""; 
		 document.getElementById("hidbrand").value="";
		 document.getElementById("hidtype").value="";
		 document.getElementById("hidproduct").value="";
		 document.getElementById("hidcat").value="";
		 document.getElementById("hidsubcat").value="";
		 document.getElementById("prodsearchby").value="";
		 document.getElementById("searchdetails").value="";
		 document.getElementById("hideptid").value="";
		 document.getElementById("hidept").value="";
		 
		 document.getElementById("hidloc").value="";
		 document.getElementById("hidlocid").value="";
		 
		 document.getElementById("prodgroupby").value="";
		 
	   
		
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
		else if(prodvalue=="hidloc"){
			document.getElementById("hidlocid").value="";
			document.getElementById("hidloc").value="";
		}
 
		document.getElementById("searchdetails").value="";
		
 
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
		if(document.getElementById("hidloc").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidloc").value;	
		}
	}


</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<!--  <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail</label></td></tr>
	 <tr> -->
	 <tr>
	 <td align="right"><label class="branch">Periodss</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
 	  <tr >
	<td align="right"><label class="branch">Group</label></td>  
	   <td  align="left"><select name="prodgroupby" id="prodgroupby" style="width:52%;">
<option value="">--Select--</option>
<option value="gbranch">BRANCH</option>
<option value="gloca">LOCATION</option>
    <option value="gptype">TYPE</option>
    <option value="gpbrand">BRAND</option>
    <option value="gpdept">DEPARTMENT</option>
    <option value="gpcategory">CATEGORY</option>
    <option value="gpsubcategory">SUB CATEGORY</option>
    <option value="gproduct">PRODUCT</option>
    </select>&nbsp;&nbsp;
	  </tr>  
	  <tr>
	  <td align="right"><label class="branch">Product</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;">
<option value="">--Select--</option>
    <option value="ploca">LOCATION</option>
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
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr>
	  <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<!--<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> -->
			<tr><td colspan="2">
			 <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  	  <input type="hidden" name="hidlocid" id="hidlocid">
			  
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			   <input type="hidden" name="hidloc" id="hidloc">
			  
			  
			  </td></tr>
			  
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="stockLedgerDiv"><jsp:include page="stockgrid.jsp"></jsp:include></div></td>
		</tr>
		    
	</table>
</tr>
</table>
<div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="submodelwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="pdeptwindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>

<div id="locationwindow">
<div></div>
</div>


</div>
</div>
</body>
</html>