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
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		/*  
		 $('#txtaccid').dblclick(function(){
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 }); */
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
				 productSearchContent('productSearch.jsp');
			 }
		
			
			
		}); 
		
	});
	
	function funExportBtn(){
	    JSONToCSVConvertor(data, 'AgeingStatement', true);
	} 
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
 
		 
   
	
	function changelevel1(){ 
	   var level1to=$('#txtlevel1to').val();
	   var level2to=$('#txtlevel2to').val();
	   var level1from=$('#txtlevel1from').val();
	   if(level2to!=""){
	   if(parseInt(level1to)>parseInt(level2to) || parseInt(level1to)<parseInt(level1from)){
			 $.messager.alert('Message','Not a Valid Range.','warning');
			 $('#txtlevel1to').val('');
			 return 0;
		 }
	   }
	   
	   if(level1to!=""){
		   $('#txtlevel2from').val(parseInt(level1to)+1);
		   }
	    else{
		   $('#txtlevel2from').val('');
		   }
	}
	
	function changelevel2(){
		 var level2to=$('#txtlevel2to').val();
		 var level3to=$('#txtlevel3to').val();
		 var level2from=$('#txtlevel2from').val();
		 if(level3to!=""){
		 if(parseInt(level2to)>parseInt(level3to) || parseInt(level2to)<parseInt(level2from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel2to').val('');
				return 0;
			 }
		 }
		 
		if(level2to!=""){
			   $('#txtlevel3from').val(parseInt(level2to)+1);
			   }
		   else{
			   $('#txtlevel3from').val('');
			   } 
		
	}
	
  	function changelevel3(){
		var level3to=$('#txtlevel3to').val();
		var level4to=$('#txtlevel4to').val();
		var level3from=$('#txtlevel3from').val();
		if(level4to!=""){
		 if(parseInt(level3to)>parseInt(level4to) || parseInt(level3to)<parseInt(level3from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel3to').val('');
				return 0;
			 }
		}
		 
		if(level3to!=""){
			   $('#txtlevel4from').val(parseInt(level3to)+1);
			   }
		     else{
			   $('#txtlevel4from').val('');
			   } 
	} 
	
  	function changelevel4(){
		var level4to=$('#txtlevel4to').val();
		var level4from=$('#txtlevel4from').val();
		if(level4to!=""){
		 if(parseInt(level4to)<parseInt(level4from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel4to').val('');
				return 0;
			 }
		}
		
		if(level4to!=""){
			   $('#txtlevel5from').val(parseInt(level4to)+1);
			   }
		    else{
			   $('#txtlevel5from').val('');
			   } 
	}  
	
/* 	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
		  if($('#cmbtype').val()==''){
    		  $.messager.alert('Message','Please Choose Account Type.','warning');
    		  return 0;
    	  }
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        } */
	
	function funOutStandingStatement(){
		// var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		   var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 
	/* 	if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 } 
		 */
/*   	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingsStatement?&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		} */
	   }
	    
	 
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
/* 		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var clientstatus = $('#cmbclientstatus').val(); */
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		   var level3to = $('#txtlevel3to').val();
			 var level4from = $('#txtlevel4from').val();
			 var level4to = $('#txtlevel4to').val();
			 var level5from = $('#txtlevel5from').val();
		 var check=1;
		 
	/* 	 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 } */
		 
		 if(level1from==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level1to==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level2from==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level2to==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level3from==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
	    if(level3to==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level4from==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level4to==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level5from==''){$.messager.alert('Message','Level 5 is Mandatory.','warning');return 0;}
		  
		 $("#overlay, #PleaseWait").show();
		 
		 
		 var hidbrandid=$("#hidbrandid").val(); 
		 var hidtypeid=$("#hidtypeid").val(); 
		 var hideptid=$("#hideptid").val(); 
		 var hidcatid=$("#hidcatid").val(); 
		 var hidsubcatid=$("#hidsubcatid").val(); 
		 var hidproductid=$("#hidproductid").val(); 
		 
		 
		 
		 $("#ageingStatementDiv").load("stockageingGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
				 +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&check='+check+"&hidbrandid="+hidbrandid
	 			  +"&hidtypeid="+hidtypeid+"&hideptid="+hideptid+"&hidcatid="+hidcatid+"&hidsubcatid="+hidsubcatid+"&hidproductid="+hidproductid);
		 
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
		 function productSearchContent(url) {
				$('#productwindow').jqxWindow('open');
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
<body onload="getBranch(); ">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
     			 
     			
<%-- 	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="AR" selected>AR</option><option value="AP">AP</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Sales Person</label></td>
	<td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	<td><select id="cmbcategory" name="cmbcategory" style="width:100%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="cmbclientstatus" style="width:70%;" name="cmbclientstatus"  value='<s:property value="cmbclientstatus"/>'>
	 <option value=''>-- Select --</option><option value='0'>Active</option><option value='1'>Litigation</option><option value='2'>Dispute</option><option value='3'>Bad Debts</option></select>
	 <input type="hidden" id="hidcmbclientstatus" name="hidcmbclientstatus" value='<s:property value="hidcmbclientstatus"/>'/></td></tr> --%>
	<tr><td align="right"><label class="branch">Level 1</label></td>
	<td align="left"><input type="text" id="txtlevel1from" name="txtlevel1from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='0'/>&nbsp;-
	<input type="text" id="txtlevel1to" name="txtlevel1to" style="width:20%;height:20px;text-align: center;" onblur="changelevel1();" value='30'/></td></tr>
	<tr><td align="right"><label class="branch">Level 2</label></td>
	<td align="left"><input type="text" id="txtlevel2from" name="txtlevel2from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='31'/>&nbsp;-
	<input type="text" id="txtlevel2to" name="txtlevel2to" style="width:20%;height:20px;text-align: center;" onblur="changelevel2();" value='60'/></td></tr>
	<tr><td align="right"><label class="branch">Level 3</label></td>
	<td align="left"><input type="text" id="txtlevel3from" name="txtlevel3from"  style="width:20%;height:20px;text-align: center;" readonly="readonly" value='61'/>&nbsp;-
	<input type="text" id="txtlevel3to" name="txtlevel3to" style="width:20%;height:20px;text-align: center;" onblur="changelevel3();" value='90'/></td></tr>
   <tr><td align="right"><label class="branch">Level 4</label></td>
	<td align="left"><input type="text" id="txtlevel4from" name="txtlevel4from"  style="width:20%;height:20px;text-align: center;" readonly="readonly" value='90'/>&nbsp;-
	<input type="text" id="txtlevel4to" name="txtlevel4to" style="width:20%;height:20px;text-align: center;" onblur="changelevel4();" value='120'/></td></tr>
		 <tr><td align="right"><label class="branch">Level 5</label></td>
	<td align="left"><input type="text" id="txtlevel5from" name="txtlevel5from"  style="width:20%;height:20px;text-align: center;" readonly="readonly" value='121'/>&nbsp;>=</td></tr>
<!-- 				<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>	
								<tr><td colspan="2">&nbsp;</td></tr>	
	<tr><td align="right"><label class="branch"> </label></td> -->
	
	
	<!-- <td align="left"><input type="hidden" id="txtlevel5from" name="txtlevel5from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='61'/>&nbsp;&nbsp;
	<input type="hidden" id="txtlevel3to" name="txtlevel3to" style="width:20%;height:20px;text-align: center;" onblur="changelevel3();" value='90'/></td></tr>
	<tr><td align="right"><label class="branch"> </label></td>
	<td align="left"><input type="hidden" id="txtlevel4from" name="txtlevel4from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='91'/>&nbsp;&nbsp;
	<input type="hidden" id="txtlevel4to" name="txtlevel4to" style="width:20%;height:20px;text-align: center;" onblur="changelevel4();" value='120'/></td></tr>
	 -->
	 <tr>
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
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="14"  readonly></textarea></td>
	  </tr>
	<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtonss" onclick="funClearData();"></center>
    </td>
	</tr>    
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="ageingStatementDiv"><jsp:include page="stockageingGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

<table width="100%">
<tr>
		<td width="50%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;"> &nbsp;</td>
        <td width="50%" align="left"><input type="hidden" class="textbox" id="txtnetbalance" name="txtnetbalance" style="width:15%;text-align: right;" value='<s:property value="txtnetbalance"/>'/></td>
</tr>
</table>
</div>

	 <center><input type="hidden" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();"> </button></center> 
	 <input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	<input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/> 
	
	
  	    
			  
 			  
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

<div id="accountDetailsWindow">
	<div></div><div></div>
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