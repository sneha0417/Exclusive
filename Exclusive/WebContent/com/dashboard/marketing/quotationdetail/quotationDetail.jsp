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

.processicon img {
	width: 1em;
	height: 1em;
}

.processicon {
	border: none;
	background-color: #ECF8E0;
}

.hidden-scrollbar {
    overflow: auto;
    
    height: 550px; 
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
			  
			  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    	  $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    	  $("#quotdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", value: null});
	    	  
		      $('#quotwindow').jqxWindow({ width: '45%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Quotation Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
			  $('#quotwindow').jqxWindow('close') ; 
			  $('#sidesearchwndow').jqxWindow({  width: '45%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 725, y: 0 }, keyboardCloseKey: 27});
			  $('#sidesearchwndow').jqxWindow('close'); 
		      $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#servicetypewindow').jqxWindow('close');
			  $('#unitsearchwindow').jqxWindow({ width :'25%',height:'58%',maxHeight:'70%',maxWidth:'45%',title:'Unit Search',position:{	x : 420,y : 87},theme : 'energyblue',showCloseButton : true,keyboardCloseKey : 27 });
			  $('#unitsearchwindow').jqxWindow('close');
			  $('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#sertypefowindow').jqxWindow('close');
			  $('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#siteinfowindow').jqxWindow('close');
			  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
			  $('#clientsearch1').jqxWindow('close');
			  $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#sitewindow').jqxWindow('close');
			  $('#sidesearchwndowqot').jqxWindow({ width: '45%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 725, y: 0 }, keyboardCloseKey: 27});
			  $('#sidesearchwndowqot').jqxWindow('close');
			  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			  $('#scopesearchwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#scopesearchwindow').jqxWindow('close');
			  
			  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		      var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	          $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		       
	          $('#todate').on('change', function (event) {
				
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
				   if(fromdates>todates){
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				   	   return false;
				   }   
			   
		 	   });
	          
		       $('#txtclient').dblclick(function(){
		      	 	$('#clientsearch1').jqxWindow('open');
		      	 	clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		  	   });
		  	 
			   $('#qutname').dblclick(function(){
				  	    $('#quotwindow').jqxWindow('open');
			            $('#quotwindow').jqxWindow('focus');
			            var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   	        // out date
			   	 	    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			   	        if(fromdates>todates){
			   		         $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	             return false;
			   	         }
			   	         var fromdate= $("#fromdate").val();
			   	         var todate= $("#todate").val();
			   	         getQuotationGrid(fromdate,todate);
			        // quotationSearchContent('quotationSearchOuter.jsp'); 
			   });  
		 
		 	   $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		       $('#btnsave').attr('disabled',true); 
		       $('#quotdate').jqxDateTimeInput({disabled: true});
		  
	});
	
	function scopeSearchContent(url) {
		$('#scopesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#scopesearchwindow').jqxWindow('setContent', data);
			$('#scopesearchwindow').jqxWindow('bringToFront');
		});
	}
  
  function getScopeGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var scopeGroupItems = items[0].split(",");
				var scopeGroupIdItems = items[1].split(",");
				var optionsscopegroup = '<option value="">--Select--</option>';
				for (var i = 0; i < scopeGroupItems.length; i++) {
					optionsscopegroup += '<option value="' + scopeGroupIdItems[i] + '">'
							+ scopeGroupItems[i] + '</option>';
				}
				$("select#cmbscopegroup").html(optionsscopegroup);
				if ($('#hidcmbscopegroup').val() != null) {
					$('#cmbscopegroup').val($('#hidcmbscopegroup').val());
				}
			} else {
			}
		}
		x.open("GET", "getScopeGroup.jsp?contrmode="+$('#txtcontrmode').val(), true);
		x.send();
	}
  
  function getScopeGroupAdvanced() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var scopeGroupItems = items[0].split(",");
				var scopeGroupIdItems = items[1].split(",");
				var optionsscopegroup = '<option value="">--Select--</option>';
				for (var i = 0; i < scopeGroupItems.length; i++) {
					optionsscopegroup += '<option value="' + scopeGroupIdItems[i] + '">'
							+ scopeGroupItems[i] + '</option>';
				}
				$("select#cmbscopegroupchange").html(optionsscopegroup);
				if ($('#hidcmbscopegroupchange').val() != null) {
					$('#cmbscopegroupchange').val($('#hidcmbscopegroupchange').val());
				}
				$('#cmbscopegroupchange').attr('disabled', true );
				$('#btnProcess').attr('disabled', true );
			} else {
			}
		}
		x.open("GET", "getScopeGroupAdvanced.jsp?contrmode="+$('#txtcontrmode').val(), true);
		x.send();
	}
  
  function getPreSalesScopeAllowed(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#presalesscopeallowed').val(items);
			    
			  if(parseInt(items)==1){
					$('#cmbscopegroupchange').show(); 
					$('#btnProcess').show();
					document.getElementById("lblscopegroup").style.display = 'inline-block';
        			$('#qutDetSubGrid').jqxGrid('showcolumn', 'scope');
					$('#qutDetSubGrid').jqxGrid('showcolumn', 'scopeamount');
					$('#qutDetGrid').jqxGrid('showcolumn', 'scope');
					$('#qutDetGrid').jqxGrid('showcolumn', 'scopeamount');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '14%');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '10%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '14%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '11%');
			    } else {
			    	$('#cmbscopegroupchange').hide();
			    	$('#btnProcess').hide();
			    	document.getElementById("lblscopegroup").style.display = 'none';
			    	$('#qutDetSubGrid').jqxGrid('hidecolumn', 'scope');
					$('#qutDetSubGrid').jqxGrid('hidecolumn', 'scopeamount');
					$('#qutDetGrid').jqxGrid('hidecolumn', 'scope');
					$('#qutDetGrid').jqxGrid('hidecolumn', 'scopeamount');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '23%');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '15%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '23%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '16%');
			    }
		}
		}
		x.open("GET", "getPreSalesScopeAllowed.jsp", true);
		x.send();
	}
  
  	function funscopegroupchange(){
  		$('#cmbscopegroup').val($('#cmbscopegroupchange').val());
  	}
  	
  	function funProcessBtn(){
  		
  		if($('#quttrno').val().trim()==""){
				$.messager.alert('Message','Select a Quotation.','warning');
	     		return 0;
		}
  		
  		if($('#cmbscopegroupchange').val().trim()==""){
  				$.messager.alert('Message','Select a Scope Group.','warning');
		     	return 0;
  		}
  		
  		$('#txtscopegroupchanged').val('1');
  		if($('#reftype').val()=="ENQ"){
  			
  				$("#loadsubgriddata").load("estimationGrid.jsp?docno="+$("#quttrno").val()+"&scopegroupid="+$("#cmbscopegroupchange").val()+"&scopegroupchanged="+$("#txtscopegroupchanged").val());
  		}
  	}

	 function setValues(){
		 getPreSalesScopeAllowed();getScopeGroup();getScopeGroupAdvanced();
		 
		 if($('#hidquotdate').val()!=""){
			 $("#quotdate").jqxDateTimeInput('val', $('#hidquotdate').val());
			 $('#quotdate').jqxDateTimeInput({disabled: false});
		  }
		var qutno=document.getElementById("quttrno").value;
		
		if(qutno>0){
			
			 if($('#reftype').val()=="ENQ"){
					$("#loadsubgriddata").load("estimationGrid.jsp?docno="+qutno);
			 }
			 $("#loadgriddata").load("quotationGrid.jsp?docno="+qutno+"&revision="+$('#revision').val());
			 $("#loadsitegriddata").load("siteGrid.jsp?docno="+qutno);
		}
		
		if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
		}
	}

	function getQuotation(event){
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		  var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		  if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  }
		  var fromdate= $("#fromdate").val();
		  var todate= $("#todate").val();
		  var x= event.keyCode;
	 	  if(x==114){
		 	getQuotationGrid(fromdate,todate);
	 	  }
	 	  else{}
	}

function getQuotationGrid(fromdate,todate){
  
 	
 	  $('#quotwindow').jqxWindow('open');
 	  quotationSearchContent('quotationSearchOuter.jsp?fromdate='+fromdate+'&todate='+todate);  
    
 	 
 	 }
 	 
function getservicetype(rowBoundIndex){
	 
	  $('#servicetypewindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
      serviceSearchContent('servicesearch.jsp?rowBoundIndex='+rowBoundIndex);
   	 }
 	 
function serviceSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
		//	 alert(data);
	$('#servicetypewindow').jqxWindow('setContent', data);
		 }); 
	}
function quotationSearchContent(url) {
	 
		 $.get(url).done(function (data) {
		
		$('#quotwindow').jqxWindow('setContent', data);

	}); 
	} 
	
function productSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#sidesearchwndow').jqxWindow('open');
 		$('#sidesearchwndow').jqxWindow('setContent', data);
 
 	}); 
 } 
 
function getserType(rowBoundIndex){
	 
	  $('#sertypefowindow').jqxWindow('open');

//$('#accountWindow').jqxWindow('focus');
serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex='+rowBoundIndex);
	 }
	 
function serTypeSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sertypefowindow').jqxWindow('setContent', data);

	      	}); 
		}
	 
function productSearchContentqot(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#sidesearchwndowqot').jqxWindow('open');
 		$('#sidesearchwndowqot').jqxWindow('setContent', data);
 
 	}); 
 } 
 function getsite(rowBoundIndex){
	 
	  $('#siteinfowindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');

    siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&hidtrno='+$('#quttrno').val());
 	 }
 
 function getareas(rowBoundIndex){
	 
	  $('#areainfowindow').jqxWindow('open');
       areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
  }
 	 
function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#siteinfowindow').jqxWindow('setContent', data);

	          	}); 
		} 
		
function areaSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#areainfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}
 	 
function unitSearchContent(url) {
	$('#unitsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#unitsearchwindow').jqxWindow('setContent', data);
		$('#unitsearchwindow').jqxWindow('bringToFront');
	});
}
 
function funExportBtn(){
    

	//JSONToCSVCon(quotstatusexcel, 'Quotation Status', true);
	   }

function getClient(event){
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

    function getsiteEst(rowBoundIndex,reftrno,id){
		 
		  $('#sitewindow').jqxWindow('open');
		  var reftype=$('#reftype').val();
	 // $('#accountWindow').jqxWindow('focus');
	        siteSearchContentEst("sitesearch.jsp?rowBoundIndex="+rowBoundIndex+"&reftrno="+reftrno+"&id="+id+"&reftype="+reftype);
	     	 }
	     	 
	function siteSearchContentEst(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sitewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
    
function funreload(event)
{

	var  trno=$("#quttrno").val();
	/* var  enqno=$("#enqno").val();
	var  surtrno=$("#surtrno").val(); */
	if(trno==""){
		$.messager.alert('Message','Select Quotation','warning');
		return 0;
	}
	// $('#btnsave').attr('disabled',false); 
	 
	 if($('#reftype').val()=="ENQ" || $('#reftype').val()=="SRVE"){
			$("#loadsubgriddata").load("estimationGrid.jsp?docno="+trno);
	 } 
	 
	 $("#loadgriddata").load("quotationGrid.jsp?docno="+trno+"&revision="+$('#revision').val());
	 $("#loadsitegriddata").load("siteGrid.jsp?docno="+trno);
	 
	 if(parseInt($('#cmbscopegroup').val())==1){
   	  	$('#cmbscopegroupchange').attr('disabled', false );
   	  	$('#btnProcess').attr('disabled', false );
     }
	 
	}

function saveEst()
{
	
	$('#btnval').val("SE");
	var rows1 = $("#qutDetSubGrid").jqxGrid('getrows');
    
  	//document.getElementById("errormsg").innerText="";

  	 $('#estimationgrdlen').val(rows1.length);
  	 var reftype=$("#reftype").val();
	   var srno=0; 
	   var actid=0;
  	 for(var i=0 ; i < rows1.length ; i++){
  		     newTextBox = $(document.createElement("input"))
  		       .attr("type", "dil")
  		       .attr("id", "mate"+i)
  		       .attr("name", "mate"+i)
  		       .attr("hidden", "true"); 
	 
  		   if(reftype=="DIR"){
       		 srno=srno+1;
       		     }
       		     else{
       		    	 srno=rows1[i].sitesrno;
       		     }
  		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].nettotal+" :: "+actid+" :: "+rows1[i].site+" :: "+rows1[i].stypeid+" :: "+srno+" :: "+rows1[i].marginper+" :: "+rows1[i].scopeid+" :: "+rows1[i].scopeamount+" :: "+rows1[i].stdprice+" :: "+rows1[i].lbrchg+" :: "+rows1[i].scopestdcost+" :: " );
  		   newTextBox.appendTo('form');
  		  
  				}	
 	$('#frmqtDetails').submit();
    return 1;
}

function saveQot(){ 
	$('#btnval').val("SQ");
	var qut_nettotal=$('#qutnettotal').val();
	var estimation_total=$('#estimationtotal').val();
	if($('#reftype').val()=="ENQ"){
		if(qut_nettotal<estimation_total){
			$.messager.alert('Message','Amount Mismatch ','warning');   
		    return false;
		}
		
	}
	
  	  var rows1 = $("#qutDetGrid").jqxGrid('getrows');
  	  $('#qutgridlen').val(rows1.length);
  	  for(var i=0 ; i < rows1.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "service"+i)
		       .attr("name", "service"+i)
		       .attr("hidden", "true"); 
		    
		   newTextBox.val(rows1[i].stypeid+" :: "+rows1[i].proname+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].desc1+" :: "+rows1[i].siteid+" :: "+rows1[i].unitid+" :: "+rows1[i].psrno+" :: "+rows1[i].scopeid+" :: "+rows1[i].scopeamount+" :: "+rows1[i].stdprice+" :: "+rows1[i].lbrchg+" :: "+rows1[i].scopestdcost+" :: ");
		   newTextBox.appendTo('form');
		  
				}
  	  
  	  var rows2 = $("#siteGridID").jqxGrid('getrows');
	  $('#sitegridlen').val(rows2.length);
	  	for(var i=0 ; i < rows2.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "site"+i)
		       .attr("name", "site"+i)
		       .attr("hidden", "true"); 
		    
		    	 newTextBox.val(rows2[i].site+" :: "+rows2[i].areaid+" :: "+rows2[i].rowno+" :: ");
		  
		   newTextBox.appendTo('form');
		  
				}
	  	
  	/*  QutDet Grid Saving Ends */	  			
  	$('#frmqtDetails').submit();
    return 1;
	
	
	
}
function saveReQot()
{
	var enqno=document.getElementById("enqno").value;
	var reftype=$('#reftype').val();  
		$("#qutDetGrid").jqxGrid('clear');
		/* 
		if(enqno==0){
			$.messager.alert('Message','No Data','warning');   
			return 0;
		} */
		
		 $("#loadgriddata").load("quotationGrid.jsp?enqno="+enqno+"&reftype="+reftype+"&load=2");
	}
function fundisamt()
	{
	

	var  Total=parseFloat(document.getElementById('qutnettotal').value);
	var  disamt=parseFloat(document.getElementById('txtdiscount').value);
	
		var netval=parseFloat(Total)-parseFloat(disamt);
		
		document.getElementById('txtnettotal').value=netval || 0;
	

	}
	
	function disablebtn()
	{
	/* 	 $('#btnsaveest').attr('disabled',true);
   	  $('#btnsavereqot').attr('disabled',true);
   	 $('#txtclient').attr('disabled',true);
  	  $('#txtremarks').attr('disabled',true);
  	 $('#btnsaveqot').attr('disabled',true);
 */  	 
	}
	function funchkrev(){
		 if(document.getElementById("chkrev").checked){
			 document.getElementById("hidchkrev").value = 1;
			
		 }
		 else{
			 document.getElementById("hidchkrev").value = 0;
			
		 }
	 }
	
</script>
</head>

<body onload="setValues(); disablebtn();">  
<form id="frmqtDetails" action="savequtdetails" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2"></td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
    <tr><td align="right"> <label class="branch">Quotation</label></td> <td >
    <input type="text"  id="qutname" name="qutname" readonly="readonly" style="height:20px;width:95%;"  placeholder="F3 To Search " value='<s:property value="qutname"/>' onKeyDown="getQuotation(event);">
    <input type="hidden" id="quttrno" style="height:20px;width:70%;"  name="quttrno" value='<s:property value="quttrno"/>' >
     </td></tr> 
	 	<tr><td align="right"><label class="branch" id="lblscopegroup">ScopeGrp.</label></td>
	 	<td><select id="cmbscopegroupchange" name="cmbscopegroupchange" style="width:70%;" onchange="funscopegroupchange();" value='<s:property value="cmbscopegroupchange"/>'>
    	<option value="">--Select--</option></select>&nbsp;&nbsp;&nbsp;
    	<input type="hidden" id="hidcmbscopegroupchange" name="hidcmbscopegroupchange" value='<s:property value="hidcmbscopegroupchange"/>'/>
    	<button type="button" class="processicon" id="btnProcess" title="Scope Update" onclick="funProcessBtn();">
				<img alt="Scope Update" src="<%=contextPath%>/icons/process2.png">
		</button></td></tr>
	 <tr><td colspan="2"align="center"><input type="button" id="btnsaveest" name="btnsaveest" class="myButton"
						value="Save Estimation" style="width: 150px;" onclick="saveEst();" />
	      </td>
	 </tr> 
	 <tr><td colspan="2"></td></tr> 
	 	<tr><td colspan="2"align="center"><input type="button" id="btnsavereqot" name="btnsavereqot" class="myButton"
						value="Reload Quotation" style="width: 150px;" onclick="saveReQot();" />
	      </td>
	 	</tr> 
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr><td  align="right" ><label class="branch">Quot.Date</label></td><td align="left"><div id='quotdate' name='quotdate' value='<s:property value="quotdate"/>'></div>
         <input type="hidden" id="hidquotdate" name="hidquotdate" value='<s:property value="hidquotdate"/>'/></td></tr>
	 	<tr><td align="right"> <label class="branch">Client</label></td> <td >
    <input type="text"  id="txtclient" name="txtclient" readonly="readonly" style="height:20px;width:95%;"  placeholder="F3 To Search " onKeyDown="getClient(event);">
    <input type="hidden" id="clientid" style="height:20px;width:70%;"  name="clientid">
     </td></tr> 
     
     <tr><td align="right"> <label class="branch">Remarks</label></td> <td >
   <textarea rows="10" cols="25" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'></textarea>
     </td></tr> 
     <tr><td colspan="2"></td></tr> 
     <tr><td colspan="2"align="center"><label class="branch">Revision</label>
	 	<input type="checkbox" id="chkrev" name="chkrev" value="" onchange="funchkrev();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
          <input type="hidden" id="hidchkrev" name="hidchkrev" value='<s:property value="hidchkrev"/>'/>
	 	
	      </td>
	 	</tr> 
	 	<tr><td colspan="2"align="center">
	 	
	 	<input type="button" id="btnsaveqot" name="btnsaveqot" class="myButton"
						value="Save Quotation" style="width: 150px;" onclick="saveQot();" />
	      </td>
	 	</tr> 
	
	
	<tr><td>
	 <input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' />
		 <input type="text" name="gridtext3" id="gridtext3" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext3"/>'  />   
  		
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2"> <input type="hidden" id="estimationtotal" style="height:20px;width:70%;"  name="estimationtotal">
	    <input type="hidden" id="qutnettotal" style="height:20px;width:70%;"  name="qutnettotal">
	    <input type="hidden" id="qutgridlen" style="height:20px;width:70%;"  name="qutgridlen">
	    <input type="hidden" id="estimationgrdlen" style="height:20px;width:70%;"  name="estimationgrdlen">
	    <input type="hidden" id="sitegridlen" style="height:20px;width:70%;"  name="sitegridlen">
	    <input type="hidden" id="hidtrno" style="height:20px;width:70%;"  name="hidtrno" value='<s:property value="hidtrno"/>'><!-- trno of estimation grid -->
	    <input type="hidden" id="msg" style="height:20px;width:70%;"  name="msg">
	    <input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno" value='<s:property value="cldocno"/>'>
	    <input type="hidden" id="date" style="height:20px;width:70%;"  name="date" value='<s:property value="date"/>'>
	    <input type="hidden" id="brhid" style="height:20px;width:70%;"  name="brhid" value='<s:property value="brhid"/>'>
	    <input type="hidden" id="datas" style="height:20px;width:70%;"  name="datas" >
	    <input type="hidden" id="reftype" style="height:20px;width:70%;"  name="reftype" value='<s:property value="reftype"/>'>
	    <input type="hidden" id="revision" style="height:20px;width:70%;"  name="revision" value='<s:property value="revision"/>'>
	    <input type="hidden" id="btnval" style="height:20px;width:80%;" readonly name="btnval" value='<s:property value="btnval"/>'>
	    <input type="hidden" id="enqno" style="height:20px;width:70%;"  name="enqno" value='<s:property value="enqno"/>'>
	    <input type="hidden" id="surtrno" style="height:20px;width:70%;"  name="surtrno" value='<s:property value="surtrno"/>'>
	    <input type="hidden" id="productchk" name="productchk" style="height:20px;width:70%;" value='<s:property value="productchk"/>'/>
	    <input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid" style="height:20px;width:70%;" value='<s:property value="txtgridservicetypeid"/>' />  
        <input type="hidden" id="txtgridscopeid" name="txtgridscopeid" style="height:20px;width:70%;" value='<s:property value="txtgridscopeid"/>' />
        <input type="hidden" id="txtgridqotservicetypeid" name="txtgridqotservicetypeid" style="height:20px;width:70%;" value='<s:property value="txtgridqotservicetypeid"/>' />  
        <input type="hidden" id="txtgridqotscopeid" name="txtgridscopeid" style="height:20px;width:70%;" value='<s:property value="txtgridqotscopeid"/>' />        
        <input type="hidden" name="txtgridscopeproduct" id="txtgridscopeproduct" style="height:20px;width:70%;" value='<s:property value="txtgridscopeproduct"/>'>
	    <input type="hidden" id="presalesscopeallowed" name="presalesscopeallowed" style="height:20px;width:70%;" value='<s:property value="presalesscopeallowed"/>'/>
	    <input type="hidden" id="txtcontrmode" name="txtcontrmode" style="height:20px;width:70%;" value='<s:property value="txtcontrmode"/>'/>
	    <input type="hidden" id="txtscopegroupchanged" name="txtscopegroupchanged" style="height:20px;width:70%;" value='<s:property value="txtscopegroupchanged"/>'/>    
	    <select id="cmbscopegroup" name="cmbscopegroup" style="width:70%;" hidden="true" value='<s:property value="cmbscopegroup"/>'>    
    	<option value="">--Select--</option></select>
    	<input type="hidden" id="hidcmbscopegroup" name="hidcmbscopegroup" value='<s:property value="hidcmbscopegroup"/>'/>
	    </td></tr>
	</table>
	</fieldset>
</td>
<td width="80%" >
	<table width="100%" >
		<tr><td colspan="4"><fieldset ><legend>Estimation Details</legend>
		
		<div id="loadsubgriddata"><jsp:include page="estimationGrid.jsp"></jsp:include> 
			</div></fieldset></td></tr>
			
			<tr><td colspan="4"><fieldset><legend>Quotation Details</legend>
			
			<div id="loadgriddata"><jsp:include page="quotationGrid.jsp"></jsp:include> 
			</div></fieldset></td></tr>
			
		<tr><td align="right" width="50%" style="font-family: Tahoma;font-size: 9px;font-weight: bold;">Discount</td>
		<td><input type="text" id="txtdiscount" style="height:20px;width:80%;"  name="txtdiscount" value='<s:property value="txtdiscount"/>' onblur="fundisamt();"></td>
 <td align="right" style="font-family: Tahoma;font-size: 9px;font-weight: bold;">Net Total</td>
		<td><input type="text" id="txtnettotal" style="height:20px;width:80%;" readonly name="txtnettotal" value='<s:property value="txtnettotal"/>'></td>
		</tr>
		
		<tr><td colspan="4"><fieldset><legend>Site Details</legend>
			
			<div id="loadsitegriddata"><jsp:include page="siteGrid.jsp"></jsp:include> 
			</div></fieldset></td></tr>
	</table>
	</td>
</tr>
</table>

 <div id="quotwindow">
   <div></div>
</div>
 <div id="sidesearchwndow">
   <div></div>
</div>
 <div id="servicetypewindow">
   <div></div>
</div>
<div id="unitsearchwindow">
   <div ></div>
</div>
<div id="sertypefowindow">
   <div ></div>
</div>
<div id="siteinfowindow">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 
<div id="sitewindow">
   <div ></div>
</div>
<div id="sidesearchwndowqot">
   <div ></div> 
</div>
<div id="areainfowindow">
   <div ></div>
</div>
<div id="scopesearchwindow">
	<div ></div>
</div>
</div>
</div>
</form>
</body>

</html> 