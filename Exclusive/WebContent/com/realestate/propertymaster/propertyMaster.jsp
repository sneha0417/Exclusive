<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO"%>

<!DOCTYPE html>
<html>
<%
	ClsPropertyMasterDAO DAO = new ClsPropertyMasterDAO();

	String contextPath = request.getContextPath();
	String pdocno = request.getParameter("pdocno") == null
			|| request.getParameter("pdocno") == "" ? "0" : request
			.getParameter("pdocno").toString();

	String mod = request.getParameter("mode") == null
			|| request.getParameter("mode") == "" ? "0" : request
			.getParameter("mode").toString();
	
	String pavail = request.getParameter("pavail") == null
			|| request.getParameter("pavail") == "" ? "0" : request
			.getParameter("pavail").toString();          
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important; 
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus,
.modern-ui textarea:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.modern-ui textarea[readonly],
.modern-ui textarea:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Tab overrides for modern UI matching */
.nav-tabs {
    border-bottom: 2px solid #c5d3e0;
    margin-bottom: 15px;
}
.nav-tabs > li > a {
    border-radius: 4px 4px 0 0;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding: 8px 15px;
}
.nav-tabs > li.active > a, 
.nav-tabs > li.active > a:focus, 
.nav-tabs > li.active > a:hover {
    color: #0056b3;
    border: 2px solid #c5d3e0;
    border-bottom-color: transparent;
    background-color: #fff;
}
.tab-content {
    padding-top: 10px;
}
</style>

<script type="text/javascript">
     
var pdoc='<%=pdocno%>';
var mode1='<%=mod%>' ;       
var pavail='<%=pavail%>';     

$(document).ready(function (){	
     document.getElementById('pavail').value=pavail;
     if(pavail=="1"){       
        $('#termscondtnid').hide();
		$('#salestermsid').hide();
      }else{
        $('#termscondtnid').show();
		$('#salestermsid').show();
      }
     
	 if ($("#mode").val() == "view") {			 
		 $('#furni_buttons').show();
		}else{
			 $('#furni_buttons').hide();
		}
	
	if($("#pmode").val() =="pview")
	{			 
	    $('#btnApproval').attr('disabled', true);
	    $('#btnClose').attr('disabled', true);
	    $('#btnCreate').attr('disabled', true);
	    $('#btnEdit').attr('disabled', true);
	    $('#btnPrint').attr('disabled', true);
	    $('#btnExcel').attr('disabled', true);
	    $('#btnDelete').attr('disabled', true);
	    $('#btnCancel').attr('disabled', true);
	    $('#btnSearch').attr('disabled', true);
	    $('#btnGuideLine').attr('disabled', true);
	    $('#btnSendmail').attr('disabled', true);
	}
	
	if ($("#mode").val() == "A")
	{
		$("#btnfuredit").prop("disabled", true);
		$("#btnfursave").prop("disabled", true); 
    }
 
	$('#chkpforrent').click(function() {	
		 if ($(this).is(':checked')) {
			$('#hidchkpforR').val($(this).val());
		 }
		 else {
		 $('#hidchkpforR').val('');
		 }
		$('#chkpforhc').prop('checked', false);
		$('#chkmanagedproperty').prop('disabled', false);
	});

	$('#chkpforsale').click(function() {		
		$('#hidchkpforS').val($(this).val());		 
		$('#chkpforhc').prop('checked', false);
		$('#chkmanagedproperty').prop('disabled', false);
		 if ($(this).is(':checked')) {
			  if($(this).val()=="Sale")
			  { 
				  $("#a_salesterms").attr("href", "#menu4");
			  }
			  else
			  {
				  $("#a_salesterms").removeAttr("href");
			  }
			 	$('#hidchkpforS').val($(this).val());		
			}
		  else
			{			   
			   $('#hidchkpforS').val('');	
			} 
	});
	
	$('#chkpforhc').click(function() {	
		$('#chkpforrent').prop('checked', false);
		$('#chkpforsale').prop('checked', false);
		$('#chkmanagedproperty').prop('checked', false);
		$('#chkmanagedproperty').prop('disabled', true);
		
		if ($(this).is(':checked')) {
		$('#hidchkpforHC').val($(this).val()); 
		}
		else {
			$('#hidchkpforHC').val(''); 
		}
		});
	
	$('.chkmanagedproperty').click(function() {			
		if ($(this).is(':checked')) { 			
			$('#hidchkmanagedproperty').val(1); 
		  }
		else
			{
			$('#hidchkmanagedproperty').val(0); 
			}			  
		}); 
	
	$('#divselectedroom').load("selectedRoomGrid.jsp?docno=" + $("#docno").val());
	$("#splinstructionsGrid").load("splinstructionGrid.jsp?docno=" + $("#docno").val());
	
	$("#jqxmodifieddate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	$("#jqxwarratydate").jqxDateTimeInput({ width: '120px', height: 24, formatString:'dd.MM.yyyy',enableBrowserBoundsDetection: true, theme: 'energyblue'});
	$("#jqxdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	
	setTimeout(function () {
        $("#jqxmodifieddate, #jqxwarratydate, #jqxdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxmodifieddate, #jqxwarratydate, #jqxdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

	$('#jqxdate').on('change', function (event) {		  
		    var maindate = $('#jqxdate').jqxDateTimeInput('getDate');
		 	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
		    funDateInPeriodchk(maindate);	
		 	 }
		   });
 	
	$('#salesmansearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'SalesMan Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#salesmansearchwindow').jqxWindow('close');

	$('#ownersearchwindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Owner Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#ownersearchwindow').jqxWindow('close');
	$('#areainfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	$('#ptytypesearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Property Type Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#ptytypesearchwindow').jqxWindow('close');
	$('#unittypesearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Unit Type Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#unittypesearchwindow').jqxWindow('close');	
	
	$('#usearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#usearchwindow').jqxWindow('close');
	
	$('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#refnosearchwindow').jqxWindow('close'); 
 	
 	$('#owner').dblclick(function(){
 		 refsearchContent1('ormainsearch.jsp');
	});
 	$('#txtarea').dblclick(function(){
		$('#areainfowindow').jqxWindow('open');
		areaSearchContent('area.jsp?getarea=0');
	});
 	$('#propertytype').dblclick(function(){
		$('#ptytypesearchwindow').jqxWindow('open');
		getPropertyType('propertytypesearch.jsp?');
	});
 	$('#unittype').dblclick(function(){
		$('#unittypesearchwindow').jqxWindow('open');
		getUnitType('unittypesearch.jsp?docno='+$("#cmbptype").val());
	});
 	
 	$('#unitof').dblclick(function(){		 
		getof('building.jsp');
	});
 	
 	$('#txtsalesman').dblclick(function(){
		$('#salesmansearchwindow').jqxWindow('open');
		getSalesmanname('salesmansearch.jsp');
	});
 	
 	getCountry();
}); 

function getSalesman(event){
	 var x= event.keyCode;
	 if(x==114){ 
		 $('#Salesmansearchwindow').jqxWindow('open');
		 getSalesmanname('salesmansearch.jsp?'); 
	 } else{}	 
}

function getCountry() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var countryId  = items[0].split(",");
			var country = items[1].split(",");
			var optionscard = '<option value="">--Select--</option>';
			for (var i = 0; i < country.length; i++) {
				optionscard += '<option value="' + countryId[i] + '">'
						+ country[i] + '</option>';
			}
			$("select#cmbcountry").html(optionscard);
			if ($('#hidcmbcountry').val() != null) {
				$('#cmbcountry').val($('#hidcmbcountry').val());
			}
		} else {
		}
	};
	x.open("GET", "getCountry.jsp", true);
	x.send();
}  

function getunitof(event){
	 var x= event.keyCode;
	 if(x==114){
			getof('building.jsp');
	 } else{}
}

function getof(url) {
	$('#usearchwindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	$('#usearchwindow').jqxWindow('setContent', data);
	}); 
	}	

function getOwner(event){
    var x = event.keyCode || event.which;
    if (x == 114 || event.type == 'click') {
	    refsearchContent1('ormainsearch.jsp');
    }
}

function refsearchContent1(url) {
    $('#refnosearchwindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
}	

function ownerSearchContent(url) {
	 $.get(url).done(function (data) {
	 $('#ownersearchwindow').jqxWindow('setContent', data);
	 }); 
}
function getunit(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#unittypesearchwindow').jqxWindow('open');
	  		getUnitType('unittypesearch.jsp?docno='+$("#hidpropertytype").val());
	 } else{}
}

function getUnitType(url){
	 $.get(url).done(function (data) {
		 $('#unittypesearchwindow').jqxWindow('setContent', data);
	 	 });
}

function getProperty(event){
	 var x= event.keyCode;
	 if(x==114){
		 $('#ptytypesearchwindow').jqxWindow('open');
		 getPropertyType('propertytypesearch.jsp?'); 
	 } else{}
}

function getPropertyType(url){
	 $.get(url).done(function (data) {
		 $('#ptytypesearchwindow').jqxWindow('setContent', data);
	 	 });
}
function getSalesmanname(url){
	 $.get(url).done(function (data) {
		 $('#salesmansearchwindow').jqxWindow('setContent', data);
	 	 });
}
function getareas(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#areainfowindow').jqxWindow('open');
          areaSearchContent('area.jsp?getarea=0');  	 
	 } else{}
}
       
function areaSearchContent(url) {
 	 $.get(url).done(function (data) {
	 $('#areainfowindow').jqxWindow('setContent', data);
 	 }); 
}

function funReadOnly(){
	$('#frmpropertyMaster input').attr('readonly', true );
	$('#frmpropertyMaster input[type=radio]').attr('disabled', true);
	$('#frmpropertyMaster input[type=checkbox]').attr('disabled', true);
    $('#frmpropertyMaster select').attr('disabled', true); 
	$('#jqxdate').jqxDateTimeInput({disabled: true});	
	$('#owner').attr('disabled', true );
	$('#txtarea').attr('disabled', true );
	$('#propertytype').attr('disabled', true );
	$('#unittype').attr('disabled', true );
	
	if(mode1=="pview")
	{			  
		$('#pmode').val(mode1);		
		$('#masterdoc_no').val(pdoc);		
		$("#frmpropertyMaster").submit(); 
		
	    $('#btnApproval').attr('disabled', true);
	    $('#btnClose').attr('disabled', true);
	    $('#btnCreate').attr('disabled', true);
	    $('#btnEdit').attr('disabled', true);
	    $('#btnPrint').attr('disabled', true);
	    $('#btnExcel').attr('disabled', true);
	    $('#btnDelete').attr('disabled', true);
	    $('#btnCancel').attr('disabled', true);
	    $('#btnSearch').attr('disabled', true);
	    $('#btnGuideLine').attr('disabled', true);
	    $('#btnSendmail').attr('disabled', true);
	}
 }
 
function funRemoveReadOnly(){
	
	$('#frmpropertyMaster input').attr('readonly', false );
	$('#frmpropertyMaster input[type=radio]').attr('disabled', false);
	$('#frmpropertyMaster input[type=checkbox]').attr('disabled', false);
	$('#frmpropertyMaster select').attr('disabled', false); 
	$('#jqxdate').jqxDateTimeInput({disabled: false});
	
	$('#unitof').attr('readonly', true );
	$('#vocno').attr('readonly', true );
	$('#owner').attr('readonly', true );
	$('#txtarea').attr('readonly', true );
	$('#propertytype').attr('readonly', true );
	$('#unittype').attr('readonly', true );
	$('#owner').attr('disabled', false );
	$('#txtarea').attr('disabled', false );
	$('#propertytype').attr('disabled', false );
	$('#unittype').attr('disabled', false );
	
	$("#jqxsplinsGrid").jqxGrid({
		disabled : false
	});
	$("#jqxaccessGrid").jqxGrid({
		disabled : false
	});
	
	$("#jqxSelectedRoomGrid").jqxGrid({
		disabled : true
	});
	
	$('#divownerac').hide();
	$('#divsysgenid').hide();
	 
		 
	if ($("#mode").val() == "A" || $("#mode").val() == "E") {			 
		$("#jqxaccessGrid").jqxGrid('addrow', null, {});	
		$("#jqxSelectedRoomGrid").jqxGrid('clear');   
		$("#jqxselectedFurnfixGrid").jqxGrid('clear'); 
	}
 
	
	$('#roomsno').attr('readonly', true );
	$('#txtfor').attr('readonly', true );
	$('#parkingno').attr('readonly', true );
	$('#bayno').attr('readonly', true ); 
	checkparking();   
	if ($("#mode").val() == "view") {			 
		 $('#furni_buttons').show();
		}else{
			 $('#furni_buttons').hide();
		}
 }
 function funSearchLoad(){
	changeContent('propertyMasterSearch.jsp'); 
 }
function funFocus()
 {
 	$('#jqxdate').jqxDateTimeInput('focus'); 	    		
 }
 
 function setValues(){  
	 deletestatus();
	 if(document.getElementById("hidchequeownersname").value!=""){     
			document.getElementById("txtchequeownersname").value=document.getElementById("hidchequeownersname").value;   
	   } 
   if(document.getElementById("hidcmbptype").value!=""){     
		document.getElementById("cmbptype").value=document.getElementById("hidcmbptype").value;   
   }
   if(document.getElementById("hidarm").value!=""){                
		document.getElementById("arm").value=document.getElementById("hidarm").value;        
   }
   if(document.getElementById("hidparking").value!=""){                            
		document.getElementById("parking").value=document.getElementById("hidparking").value;        
   }
   if(document.getElementById("hidcmbcountry").value!=""){     
		document.getElementById("cmbcountry").value=document.getElementById("hidcmbcountry").value;        
   }
   if(document.getElementById("hidcmbOwCommision").value!=""){                                   
		document.getElementById("cmbOwCommision").value=document.getElementById("hidcmbOwCommision").value;        
   }
   if(document.getElementById("hidcmbOwTransferfee").value!=""){                           
		document.getElementById("cmbOwTransferfee").value=document.getElementById("hidcmbOwTransferfee").value;        
   }
   if(document.getElementById("hidcmbBuyerCommision").value!=""){                        
		document.getElementById("cmbBuyerCommision").value=document.getElementById("hidcmbBuyerCommision").value;        
   }
   if(document.getElementById("hidcmbBuyerTransferfee").value!=""){                              
		document.getElementById("cmbBuyerTransferfee").value=document.getElementById("hidcmbBuyerTransferfee").value;        
   }
   if(document.getElementById("hidparking").value!=""){                        
		document.getElementById("parking").value=document.getElementById("hidparking").value;        
   }
   if(document.getElementById("hidchkpforS").value=="Sale"){     
  	 	document.getElementById("chkpforsale").checked = true;
   }
   else{
	   document.getElementById("chkpforsale").checked = false;
   } 
   
    if(document.getElementById("hidchkpforR").value=="Rent"){ 
  	    document.getElementById("chkpforrent").checked = true;
   }
    else{
    	 document.getElementById("chkpforrent").checked =false;
    } 
    if(document.getElementById("hidchkpforHC").value=="HC"){ 
  	    document.getElementById("chkpforhc").checked = true;   
   } 
    else{
    	document.getElementById("chkpforhc").checked = false;   
    } 
   
  	      if($("#hidrdoinstype").val()!=""){  
	 	if($("#rdoinstype1").val()==$("#hidrdoinstype").val()){
	 	  document.getElementById("rdoinstype1").checked = true;
	 	}
	 	if($("#rdoinstype2").val()==$("#hidrdoinstype").val()){
 		 document.getElementById("rdoinstype2").checked = true;
 		}
	 	if($("#rdoinstype3").val()==$("#hidrdoinstype").val()){   
 		 document.getElementById("rdoinstype3").checked = true;
 		}
	 }
    if($("#hidrdoinsasper").val()!=""){    
			 	if($("#rdoinsasper1").val()==$("#hidrdoinsasper").val()){  
			 	  document.getElementById("rdoinsasper1").checked = true;
			 	}
			 	if($("#rdoinsasper2").val()==$("#hidrdoinsasper").val()){
		 		 document.getElementById("rdoinsasper2").checked = true;
		 		}
			 }
   
	 if($('#hiddate').val()){
			$("#jqxdate").jqxDateTimeInput('val', $('#hiddate').val());
		}
	 if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}	 
	 if(document.getElementById("masterdoc_no").value>0){
		 if(document.getElementById("hidchkmanagedproperty").value=="1"){                 
				  document.getElementById("chkmanagedproperty").checked = true;   
			 }
		 
		 if($("#hidcmbaccgroup").val()!=null)	     
		 {		 	
		 	$("#cmbtranstype").val($("#hidcmbaccgroup").val());		  
		 }
		 if($("#hidparking").val()!=null)		     	
		 {
		 	$("#parking").val($("#hidparking").val());
		 }
		 
		 if($("#hidarm").val()!=null)	  
		 {
		 	$("#arm").val($("#hidarm").val());
		 }
		 } 
	 
	    $('#divselectedroom').load("selectedRoomGrid.jsp?docno=" + $("#docno").val());  
		$("#splinstructionsGrid").load("splinstructionGrid.jsp?docno=" + $("#docno").val());
		$("#accessgriddiv").load("accessGrid.jsp?docno="+$("#docno").val());
		
		document.getElementById("cmbrtainerfund").style.border = "1px solid #ff1d1d";
		var owacno=$('#owacno').val();
		 if(owacno!="")
		 { 
			 $('#divownerac').show();
			 $('#lblowneraccount').text("Owner Account Number: " + owacno);
		 }
		 
		var sysid=$('#sysgenid').val();
	 
		 if(sysid!="")
			 {
				 $('#divsysgenid').show();
				 $('#lblsysgenid').text("System Generated ID: " + sysid);
			 }
		 if ($("#mode").val() == "view") {			 
			 $('#furni_buttons').show();
			}else{
				 $('#furni_buttons').hide();
			}
}
 
 function  chkval()
 {
	 if(document.getElementById("chkmanagedproperty").checked==true)
		 {
		 document.getElementById("hidchkmanagedproperty").value=1;
		 }
	 else
		 {
		 document.getElementById("hidchkmanagedproperty").value=0;
		 }     	 
 }
  
 function getcmbtranstype(){ 	 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	        
	           var optionstype = '<option value="0">--select--</option>';

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	           
	             $("select#cmbtranstype").html(optionstype); 	
	           
	             if($("#hidcmbaccgroup").val()!=null)
	             	
	             	
               	{
               	
               	$("#cmbtranstype").val($("#hidcmbaccgroup").val());
             
               	}
	         
	  
	    }
	       }
	   x.open("GET","getTranstype.jsp?",true);
		x.send();
	       
	      
	        }
 function funDateInPeriodchk(value){
	 
	    var currentDate = new Date(new Date());
	 
	     if(value>currentDate){
	     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
	    
	     return 0;
	    } 
	    
	    document.getElementById("errormsg").innerText="";
	   
	     return 1;
	 }

function funNotify(){	 
	var maindate = $('#jqxdate').jqxDateTimeInput('getDate');
	var validdate=funDateInPeriodchk(maindate);	   			  
	if(validdate==0){
	   return 0; 
	   } 
	 var owner = document.getElementById("ownerid").value;		 
	
	if(owner=="")
	{
		document.getElementById("errormsg").innerText="Owner is required ";	 
		return 0;
	}
	
	if($('#cmbptype').val()=="")
	{
		document.getElementById("errormsg").innerText="Type is required ";		 
		return 0;
	}
				 
	if($('input[name="chkpforrent"]:checked').length== 0 && $('input[name="chkpforsale"]:checked').length== 0 && $('input[name="chkpforhc"]:checked').length== 0)
	{
		document.getElementById("errormsg").innerText="Property For is required ";		 
		return 0;
	}
	
	$('#jqxdate').jqxDateTimeInput({ disabled: false});		 
		 
		 // set special instructions grid into a textbox 		 
			var splrows = $("#jqxsplinsGrid").jqxGrid('getrows');
			var spllength = 0;
			for (var i = 0; i < splrows.length; i++) {
				var chks = splrows[i].sp_inst;
				if (typeof (chks) != "undefined" && typeof (chks) != "NaN"
						&& chks != "") {
					newTextBox = $(document.createElement("input"))
					.attr("type","dil")
							.attr("id", "txtsplinstructions" + spllength)
							.attr("name", "txtsplinstructions" + spllength)
							.attr("hidden","true");
					spllength = spllength + 1;

					newTextBox.val(splrows[i].sp_inst+"::"+splrows[i].spinsid);
					newTextBox.appendTo('form');
				}
			}
			
			$('#splgridlength').val(spllength); 
			// set special instructions grid into a textbox
			
			
			// set access grid into a textbox 		 
			var accrows = $("#jqxaccessGrid").jqxGrid('getrows');
			var acclength = 0;
			for (var i = 0; i < accrows.length; i++) {
				var chks = accrows[i].acsutility;
				if (typeof (chks) != "undefined" && typeof (chks) != "NaN"
						&& chks != "") {
					newTextBox = $(document.createElement("input"))
					.attr("type","dil")
							.attr("id", "txtaccess" + acclength)
							.attr("name", "txtaccess" + acclength)
							.attr("hidden","true");
					acclength = acclength + 1;
					//						0					1						2						3				
					newTextBox.val(accrows[i].acid+"::"+accrows[i].acsutility+"::"+accrows[i].acsno+"::"+accrows[i].aqty);
					newTextBox.appendTo('form');
				}
			}
			
			$('#accgridlength').val(acclength); 
			// set access grid into a textbox
		 
		 
				// set selected furniture grid into a textbox 		 
			var sfrows = $("#jqxselectedFurnfixGrid").jqxGrid('getrows');
			var sflength = 0;
			for (var i = 0; i < sfrows.length; i++) {
				var chks = sfrows[i].chk;
				if (chks == true) {
					newTextBox = $(document.createElement("input"))
					.attr("type","dil")
							.attr("id", "txtselectedfur" + sflength)
							.attr("name", "txtselectedfur" + sflength)
							.attr("hidden","true");
					sflength = sflength + 1;

					newTextBox.val(sfrows[i].doc_no+"::"+sfrows[i].rdoc_no);
					newTextBox.appendTo('form');
				}
			}
			
			$('#selectedfurgridlength').val(sflength); 
			// set selected furniture grid into a textbox
			
			if ($("#rdoinstype1").is(":checked")) {
				$("#hidrdoinstype").val($("#rdoinstype1").val());
				}
			if ($("#rdoinstype2").is(":checked")) {
				$("#hidrdoinstype").val($("#rdoinstype2").val());
				}
			if ($("#rdoinstype3").is(":checked")) {
				$("#hidrdoinstype").val($("#rdoinstype3").val());
				}
			
			if ($("#rdoinsasper1").is(":checked")) {
				$("#hidrdoinsasper").val($("#rdoinsasper1").val());
				}
			if ($("#rdoinsasper2").is(":checked")) {
				$("#hidrdoinsasper").val($("#rdoinsasper2").val());
				}		
			
			
			if ($("#chkpforrent").is(":checked")) {
				$("#hidchkpforR").val($("#chkpforrent").val());
				}
			else
				{
				$("#hidchkpforR").val('');
				}
			if ($("#chkpforsale").is(":checked")) {
				$("hidchkpforS").val($("#chkpforsale").val());
				}
			else
				{
				$("hidchkpforS").val('');
				}
			if ($("#chkpforhc").is(":checked")) {
				$("#hidchkpforHC").val($("#chkpforhc").val());
				}
			else
				{
				$("#hidchkpforHC").val('');
				}
			
	return 1;
 		
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


   
function  editfurgrid()
{
	$("#jqxSelectedRoomGrid").jqxGrid({
		disabled : false
	});
}
		 
function  savefurgrid()
{
	// set selected furniture grid into a textbox 		 
	var sfrows = $("#jqxselectedFurnfixGrid").jqxGrid('getrows');
	
	console.log('grid rows = ' +sfrows.length);
	var sflength = 0;
	var gridarray=[];   
	for (var i = 0; i < sfrows.length; i++) {
		var chks = sfrows[i].chk;
		if (chks == true) {		 
			sflength = sflength + 1;
			gridarray.push(sfrows[i].doc_no);			 
		}
	}
	
	//console.log("array =" +gridarray);
	
	$('#selectedfurgridlength').val(sflength); 
	// set selected furniture grid into a textbox	
	 
	var pdocno= $("#docno").val();
	var mode='E';
	
	var rdocno=$('#txtroomid').val();
	
	 jsonarray=JSON.stringify(gridarray);
	
	$.ajax({
		type : "POST",
		url : 'saveFurniture.jsp',
		dataType : 'json',
		 //contentType: "application/json;charset=utf-8",
		contentType:'application/x-www-form-urlencoded',
		data:{gridarray:jsonarray,pdocno:pdocno,mode:mode,rdocno:rdocno},
		success : function(obj) {
			 console.log(obj);
			 if(obj==true)
				 {
				  //$('#ignismyModal').modal('toggle');
				  swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'  
					});  
					$('#divselectedroom').load("selectedRoomGrid.jsp?docno=" + $("#docno").val());
					 $("#jqxselectedFurnfixGrid").jqxGrid('clear');
					 $("#jqxselectedFurnfixGrid").jqxGrid({disabled:true});
					
				 }
			 else
				 {
				 swal({
						type: 'error',
						title: 'Error', 
						text: 'Not Updated'
					});  
				 }
		}
	});
	
}
		
function getPropertyType() { 
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			
			var prtypeIdItems  = items[0].split(",");
			var prtypeItems = items[1].split(",");
			
			var prtypeoptions='<option value=""> select</option>';
			for (var i = 0; i < prtypeItems.length; i++) {
				prtypeoptions += '<option value="' + prtypeIdItems[i].trim() + '">'
						+ prtypeItems[i] + '</option>';
			}
			$("select#cmbptype").html(prtypeoptions);
			   if(document.getElementById("hidcmbptype").value!=""){      
					document.getElementById("cmbptype").value=document.getElementById("hidcmbptype").value;   
			   }
		} else {
		}  
	}
	x.open("GET","getPropertyType.jsp",true);   
	x.send();
} 

function checkparking()
{
	var par= $('#parking').val();
	if(par==1)
	{ 
		$('#parkingno').attr('readonly', false );
		$('#bayno').attr('readonly', false ); 
	}
	else
	{
		$('#parkingno').attr('readonly', true );
		$('#bayno').attr('readonly', true ); 
		$('#parkingno').val('');
		$('#bayno').val('');   
	}
}

function checkaddroom()
{
	var ar=$('#arm').val();
	if(ar==1)
	{
		$('#roomsno').attr('readonly', false );
		$('#txtfor').attr('readonly', false );
	}
	else
	{
		$('#roomsno').attr('readonly', true );
		$('#txtfor').attr('readonly', true );
	}
	
}
 
function LoadRoomsFurniture(){	
	var dno=$('#masterdoc_no').val(); 
	var html='';var m=''; var i; var k=0;var j=0; var menu=''; 
	var url=document.URL;
	var reurl=url.split("com/"); 	  
	var m,menu;
	$.ajax({
		url:'getRoomsFurniture.jsp',
		data: {docno:dno},
		type:'get',
		success:function(bidata)
		{  
			var data = JSON.parse(bidata);
			 
			if(typeof(data.property[0].main) !='' && typeof(data.property[0].main)!='undefined')
			{
				for(i=0;i<data.property.length;i++ ) 
				{  
					if(m !=data.property[i].main)  { 
					  j++;		 
					  html += '<div class="panel panel-default">';
					  html += '	<div class="panel-heading" style="padding: 5px 8px;">';
					  html += '<h5 class="panel-title" style="font-size:14px;">';
					  html += '<a data-toggle="collapse" data-parent="#accordion"';
					  html += ' href="#collapse'+j+'">'+data.property[i].main+'</a>';
					  html += '</h5> </div>';
					  html += '<div id="collapse'+j+'" class="collapse panel-collapse">';
					  html += '<div class="panel-body">';  					  
					  
					  menu=data.property[i].main;	
	
					  for(k=0;k<data.property.length;k++)
						{
						   if(menu==data.property[k].main)
							   { 
								    html += '<a href="javascript:void(0);" style="line-height:2;cursor:default;text-decoration:none;color:#000;">'+data.property[k].sub+'</a> <br />';
							   } 
						} 
					  html +='</div> </div>';
					  }
					else
						{
						  html +='</div>';
						}
					
					   m=data.property[i].main;
				}
				
				$('#accordion').append(html);	
			}
			else
			{
				html+='<p>No Data Found</p>';
				$('#accordion').append(html);	
			}
		} 
	});
	
}  
function deletestatus(){  
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			
			if(parseInt(items)>0)
				{
				 $('#btnDelete').attr('disabled', true );
				}
			else
				{
				 $('#btnDelete').attr('disabled', false );   
				}   
		} else {  
		}  
	}
	x.open("GET", "getDeleteStat.jsp?masterdoc="+$('#docno').val(), true); 
	x.send();
}
</script>
</head>

<body onload="setValues();getcmbtranstype();getPropertyType();" onclick="deletestatus();">

<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmpropertyMaster" action="saveptyMaster" method="post" autocomplete="off">
        <jsp:include page="../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">

            <!-- General Info Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">General Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Doc No</label>
                    <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
                    <input type="text" id="vocno" name="vocno" style="width:120px;" value='<s:property value="vocno"/>' readonly tabindex="-1" />

                    <label class="lbl-right" style="width:80px; margin-left: 15px;">Owner</label>
                    <div class="input-search-container" style="flex:1; max-width: 300px;">
                        <input type="text" id="owner" name="owner" placeholder="Press F3" value='<s:property value="owner"/>' onkeydown="getOwner(event);" />
                        <svg class="magnifier-icon" onclick="refsearchContent1('ormainsearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="ownerid" name="ownerid" value='<s:property value="ownerid"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left: auto;">Date</label>
                    <div style="width: 120px;">
                        <div id="jqxdate" name="jqxdate" value='<s:property value="jqxdate"/>'></div>
                        <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>' />
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Opt.ID</label>
                    <input type="text" id="txtoptID" name="txtoptID" style="width:120px;" value='<s:property value="txtoptID"/>' />

                    <label class="lbl-right" style="width:80px; margin-left: 15px;">Type</label>
                    <select id="cmbptype" name="cmbptype" style="width:120px;" value='<s:property value="cmbptype"/>'></select> 
                    <input type="hidden" id="hidcmbptype" name="hidcmbptype" value='<s:property value="hidcmbptype"/>' />

                    <div style="display:flex; align-items:center; gap:10px; margin-left:15px;">
                        <label class="lbl-right">For:</label>
                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                            <input type="checkbox" class="chkpfor" name="chkpforrent" id="chkpforrent" value="Rent" style="margin:0; width:auto; height:auto!important;"/> Rent
                        </label> 
                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                            <input type="checkbox" class="chkpfor" name="chkpforsale" id="chkpforsale" value="Sale" style="margin:0; width:auto; height:auto!important;"/> Sale
                        </label> 
                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                            <input type="checkbox" class="chkpforHC" name="chkpforhc" id="chkpforhc" value="HC" style="margin:0; width:auto; height:auto!important;"/> HC
                        </label>
                        <input type="hidden" id="hidchkpfor" name="hidchkpfor" value='<s:property value="hidchkpfor"/>' />  
                        <input type="hidden" id="hidchkpforS" name="hidchkpforS" value='<s:property value="hidchkpforS"/>' />  
                        <input type="hidden" id="hidchkpforR" name="hidchkpforR" value='<s:property value="hidchkpforR"/>' />  
                        <input type="hidden" id="hidchkpforHC" name="hidchkpforHC" value='<s:property value="hidchkpforHC"/>' />
                    </div>

                    <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0 0 0 auto; cursor:pointer;">
                        <input type="checkbox" class="chkmanagedproperty" name="chkmanagedproperty" id="chkmanagedproperty" style="margin:0; width:auto; height:auto!important;" /> 
                        Managed Property
                    </label> 
                    <input type="hidden" id="hidchkmanagedproperty" name="hidchkmanagedproperty" value='<s:property value="hidchkmanagedproperty"/>' />
                </div>
            </div>
            
            <div id="divsysgenid" style="display:none; text-align:right; margin-bottom: 10px;">
                <label id="lblsysgenid" style="color: green; font-weight:bold;"></label>
            </div>

            <!-- Tabs Section -->
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Property Address</a></li>
                <li><a data-toggle="tab" href="#menu1">Property Details</a></li>
                <li><a data-toggle="tab" href="#menu2">Developer Details</a></li>
                <li id="termscondtnid"><a data-toggle="tab" href="#menu3">Terms/Conditions</a></li>         
                <li id="salestermsid"><a data-toggle="tab" id="a_salesterms">Sales Terms</a></li>
                <li><a data-toggle="tab" href="#menu5">Furniture &amp; Fixtures</a></li>
            </ul>
            
            <div class="tab-content">
                
                <!-- Tab: Property Address (#home) -->
                <div id="home" class="tab-pane fade in active">
                    <div style="display:flex; gap:15px; margin-bottom: 15px;">
                        <!-- Address Panel -->
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Address</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Address 1</label>
                                <input type="text" name="txtaddress1" id="txtaddress1" style="flex:1;" value='<s:property value="txtaddress1"/>' required>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Address 2</label>
                                <input type="text" name="txtaddress2" id="txtaddress2" style="flex:1;" value='<s:property value="txtaddress2"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Account Name</label>
                                <input type="text" name="txtaccname" id="txtaccname" style="flex:1;" value='<s:property value="txtaccname"/>' required>
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:100px;">Nearest Landmark</label>
                                <input type="text" name="txtlandmark" id="txtlandmark" style="flex:1;" value='<s:property value="txtlandmark"/>'>
                            </div>
                        </div>

                        <!-- Area Panel -->
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Area</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:120px;">Area</label>
                                <div class="input-search-container" style="flex:1;">
                                    <input type="text" id="txtarea" name="txtarea" placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);" />
                                    <svg class="magnifier-icon" onclick="$('#areainfowindow').jqxWindow('open'); areaSearchContent('area.jsp?getarea=0');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </div>
                                <input type="hidden" id="txtareadet" name="txtareadet" value='<s:property value="txtareadet"/>' /> 
                                <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>' />
                            </div>
                            <div class="field-row" style="align-items:flex-start; margin-bottom:0;">
                                <label class="lbl-right" style="width:120px; padding-top:4px;">Property Description</label>
                                <textarea name="propertydesc" id="propertydesc" style="flex:1; height:60px;" rows="3"><s:property value="propertydesc" /></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Details Panel -->
                    <div class="middle-panel">
                        <span class="middle-panel-title">Details</span>
                        
                        <div style="display:flex; gap:15px;">
                            <!-- Left Col -->
                            <div style="flex:1;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Property Type</label>
                                    <div class="input-search-container" style="flex:1;">
                                        <input type="text" name="propertytype" id="propertytype" placeholder="Press F3" value='<s:property value="propertytype"/>' onkeydown="getProperty(event);">
                                        <svg class="magnifier-icon" onclick="$('#ptytypesearchwindow').jqxWindow('open'); getPropertyType('propertytypesearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="hidden" name="hidpropertytype" id="hidpropertytype" value='<s:property value="hidpropertytype"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Contact for Rent/Sales</label>
                                    <input type="text" name="txtsalesman" id="txtsalesman" style="flex:1;" value='<s:property value="txtsalesman"/>'>
                                    <input type="hidden" name="hidcmbcontactperson" id="hidcmbcontactperson" value='<s:property value="hidcmbcontactperson"/>'> 
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Contact Number</label>
                                    <input type="text" id="txtcontactnumber" name="txtcontactnumber" style="flex:1;" value='<s:property value="txtcontactnumber"/>' tabindex="-1" />
                                </div>
                            </div>
                            
                            <!-- Mid Col -->
                            <div style="flex:1;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">No. of Rooms</label>
                                    <input type="text" name="no_of_rooms" id="no_of_rooms" style="width:100px; text-align:right;" onkeypress="javascript:return isNumber (event);" value='<s:property value="no_of_rooms"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">No. of Bathrooms</label>
                                    <input type="text" name="no_of_bath" id="no_of_bath" style="width:100px; text-align:right;" onkeypress="javascript:return isNumber (event);" value='<s:property value="no_of_bath"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Additional Rooms</label>
                                    <select id="arm" name="arm" style="width:100px;" onchange="checkaddroom();">
                                        <option value="">--Select--</option>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                    <input type="hidden" name="hidarm" id="hidarm" value='<s:property value="hidarm"/>'> 
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">No. of add. Rooms</label>
                                    <input type="text" name="roomsno" id="roomsno" style="width:60px; text-align:right;" onkeypress="javascript:return isNumber (event);" value='<s:property value="roomsno"/>'>
                                    <label class="lbl-right" style="width:30px;">For</label>
                                    <input type="text" name="txtfor" id="txtfor" style="flex:1;" value='<s:property value="txtfor"/>' placeholder="Servants, Watchmen, etc">
                                </div>
                                <div class="field-row" style="align-items:flex-start;">
                                    <label class="lbl-right" style="width:120px; padding-top:4px;">Special Notes</label>
                                    <textarea name="txtspecialnotes" id="txtspecialnotes" style="flex:1; height:40px;" rows="2"><s:property value="txtspecialnotes" /></textarea>
                                </div>
                            </div>

                            <!-- Right Col -->
                            <div style="flex:1;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Unit Number</label>
                                    <input type="text" name="unitno" id="unitno" style="flex:1;" value='<s:property value="unitno"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Unit Type</label>
                                    <div class="input-search-container" style="flex:1;">
                                        <input type="text" name="unittype" id="unittype" placeholder="Search Unit type" value='<s:property value="unittype"/>' onkeydown="getunit(event)">
                                        <svg class="magnifier-icon" onclick="$('#unittypesearchwindow').jqxWindow('open'); getUnitType('unittypesearch.jsp?docno='+$('#hidpropertytype').val());" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="hidden" name="hidunittypeid" id="hidunittypeid" value='<s:property value="hidunittypeid"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Unit of</label>
                                    <div class="input-search-container" style="flex:1;">
                                        <input type="text" name="unitof" id="unitof" placeholder="Search Building" value='<s:property value="unitof"/>' onkeydown="getunitof(event)">
                                        <svg class="magnifier-icon" onclick="getof('building.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="hidden" name="hidunitofid" id="hidunitofid" value='<s:property value="hidunitofid"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Parking</label>
                                    <select id="parking" name="parking" style="width:100px;" onchange="checkparking();">
                                        <option value="">--Select--</option>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                    <input type="hidden" name="hidparking" id="hidparking" value='<s:property value="hidparking"/>' /> 
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Parking No.</label>
                                    <input type="text" name="parkingno" id="parkingno" style="flex:1;" value='<s:property value="parkingno"/>'>
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:100px;">Bay No.</label>
                                    <input type="text" name="bayno" id="bayno" style="flex:1;" value='<s:property value="bayno"/>'>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab: Property Details (#menu1) -->
                <div id="menu1" class="tab-pane fade in">
                    <div style="display:flex; gap:15px; margin-bottom: 15px;">
                        <!-- Area Details -->
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Area Details</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Area (Sq.Ft)</label>
                                <input type="text" name="txtarea1" id="txtarea1" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtarea1"  />'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Yard</label>
                                <input type="text" name="txtyard" id="txtyard" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtyard"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Build Up (Sq.Ft)</label>
                                <input type="text" name="txtbuilduparea" id="txtbuilduparea" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtbuilduparea"/>'>
                            </div>
                            <div class="field-row" style="align-items:flex-start; margin-bottom:0;">
                                <label class="lbl-right" style="width:100px; padding-top:4px;">Property Views</label>
                                <textarea id="txtpropertyviews" name="txtpropertyviews" style="flex:1; height:60px;" rows="3"><s:property value="txtpropertyviews" /></textarea>
                            </div>
                        </div>

                        <!-- Utility Details -->
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Utility Details</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:140px;">Electricity &amp; Water No</label>
                                <input type="text" name="electricwaterno" id="electricwaterno" style="flex:1;" value='<s:property value="electricwaterno"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:140px;">Gas Connection No</label>
                                <input type="text" name="gasconnectionno" id="gasconnectionno" style="flex:1;" value='<s:property value="gasconnectionno"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:140px;">AC Connection No</label>
                                <input type="text" name="acconnectionno" id="acconnectionno" style="flex:1;" value='<s:property value="acconnectionno"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:140px;">Premises No</label>
                                <input type="text" name="premisesno" id="premisesno" style="flex:1;" value='<s:property value="premisesno"/>'>
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:140px;">Maintenance Retainer</label>
                                <input type="text" id="cmbrtainerfund" name="cmbrtainerfund" style="width:60px; text-align:right;" value='<s:property value="cmbrtainerfund"/>'> 
                                <input type="text" name="txtmaintainerfund" id="txtmaintainerfund" style="flex:1; text-align:right;" value='<s:property value="txtmaintainerfund"/>'> 
                                <input type="hidden" id="hidcmbrtainerfund" name="hid" value='<s:property value="hidcmbrtainerfund"/>' />
                            </div>
                        </div>
                    </div>

                    <!-- Keys & Controls -->
                    <div class="middle-panel">
                        <span class="middle-panel-title">Keys &amp; Controls</span>
                        <div id="accessgriddiv" class="grid-container" style="border:none;">
                            <jsp:include page="accessGrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>

                <!-- Tab: Developer Details (#menu2) -->
                <div id="menu2" class="tab-pane fade in">
                    <div style="display:flex; gap:15px;">
                        <!-- Left Col: Dev Info & Contact -->
                        <div style="flex:1;">
                            <div class="middle-panel" style="margin-bottom:15px;">
                                <span class="middle-panel-title">Developer</span>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Name</label>
                                    <input type="text" name="txtdevelopername" id="txtdevelopername" style="flex:1;" value='<s:property value="txtdevelopername"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Address 1</label>
                                    <input type="text" name="txtdevaddress1" id="txtdevaddress1" style="flex:1;" value='<s:property value="txtdevaddress1"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Address 2</label>
                                    <input type="text" name="txtdevaddress2" id="txtdevaddress2" style="flex:1;" value='<s:property value="txtdevaddress2"/>'>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Telephone</label>
                                    <input type="text" name="txtdevph" id="txtdevph" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdevph"/>'>
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:80px;">Fax</label>
                                    <input type="text" name="txtdevfax" id="txtdevfax" style="flex:1;" value='<s:property value="txtdevfax"/>'>
                                </div>
                            </div>

                            <div class="middle-panel" style="margin-bottom:0;">
                                <span class="middle-panel-title">Contact Person</span>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Name</label>
                                    <input type="text" name="txtcontactname" id="txtcontactname" style="flex:1;" value='<s:property value="txtcontactname"/>'>
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:80px;">Mobile</label>
                                    <input type="text" name="txtcontactmobile" id="txtcontactmobile" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtcontactmobile"/>'>
                                </div>
                            </div>
                        </div>

                        <!-- Right Col: Bank Details -->
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Bank Details</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Bank Name</label>
                                <input type="text" name="txtdevbankname" id="txtdevbankname" style="flex:1;" value='<s:property value="txtdevbankname"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Account No.</label>
                                <input type="text" name="txtdevaccno" id="txtdevaccno" style="flex:1;" value='<s:property value="txtdevaccno"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Address</label>
                                <input type="text" name="txtdevbankaddress" id="txtdevbankaddress" style="flex:1;" value='<s:property value="txtdevbankaddress"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Telephone</label>
                                <input type="text" name="txtdevbankph" id="txtdevbankph" style="flex:1;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdevbankph"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:100px;">Fax</label>
                                <input type="text" name="txtdevbankfax" id="txtdevbankfax" style="flex:1;" value='<s:property value="txtdevbankfax"/>'>
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:100px;">Country</label>
                                <select name="cmbcountry" id="cmbcountry" style="flex:1;" value='<s:property value="cmbcountry"/>'></select> 
                                <input type="hidden" id="hidcmbcountry" name="hidcmbcountry" value='<s:property value="hidcmbcountry"/>' />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab: Questionnaire / Terms (#menu3) -->
                <div id="menu3" class="tab-pane fade in">
                    <div style="display:flex; gap:15px;">
                        <div class="middle-panel" style="flex:1; margin-bottom:0;">
                            <span class="middle-panel-title">Questionnaire</span>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Tenancy Cheques in Owners Name</label>
                                <select name="txtchequeownersname" id="txtchequeownersname" style="width:100px;">
                                    <option value="">Select</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                                <input type="hidden" name="hidchequeownersname" id="hidchequeownersname" value='<s:property value="hidchequeownersname"/>'> 
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Rental Value</label>
                                <input type="text" name="txtrentalvaluefrom" id="txtrentalvaluefrom" style="width:100px; text-align:right;" placeholder="From" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtrentalvaluefrom"/>'>
                                <input type="text" name="txtrentalvalueto" id="txtrentalvalueto" style="width:100px; text-align:right; margin-left:10px;" placeholder="To" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtrentalvalueto"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">New Rent</label>
                                <input type="text" name="txtnewrent" id="txtnewrent" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnewrent"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Expected Sales Value</label>
                                <input type="text" name="txtexpsaleval" id="txtexpsaleval" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtexpsaleval"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Management Fee (%)</label>
                                <input type="text" name="txtmgtfeeperc" id="txtmgtfeeperc" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtmgtfeeperc"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Management Fee (Value)</label>
                                <input type="text" name="txtrntcmsnperc" id="txtrntcmsnperc" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtrntcmsnperc"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Administrative Fee</label>
                                <input type="text" name="txtadminfee" id="txtadminfee" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtadminfee"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Snagging Fee</label>
                                <input type="text" name="txtsnagfee" id="txtsnagfee" style="flex:1; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtsnagfee"/>'>
                            </div>
                            <div class="field-row">
                                <label class="lbl-right" style="width:180px;">Others</label>
                                <input type="text" name="txtothers" id="txtothers" style="flex:1;" value='<s:property value="txtothers"/>'>
                            </div>
                            <div class="field-row" style="margin-bottom:0;">
                                <label class="lbl-right" style="width:180px;">Warranty</label>
                                <div style="width: 120px;">
                                    <div id="jqxwarratydate" name="hidwarratydate" value='<s:property value="hidwarratydate"/>'></div>
                                </div>
                            </div>
                        </div>

                        <div style="flex:1;">
                            <div class="middle-panel" style="margin-bottom:15px;">
                                <span class="middle-panel-title">Inspection</span>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Type</label>
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                                            <input type="radio" id="rdoinstype1" class="rdoinstype" name="rdoinstype" value="HY" style="margin:0;" /> Half Yearly
                                        </label> 
                                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                                            <input type="radio" id="rdoinstype2" class="rdoinstype" name="rdoinstype" value="Q" style="margin:0;" /> Quaterly
                                        </label> 
                                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                                            <input type="radio" id="rdoinstype3" class="rdoinstype" name="rdoinstype" value="M" style="margin:0;" /> Monthly
                                        </label> 
                                        <input type="hidden" id="hidrdoinstype" name="hidrdoinstype" value='<s:property value="hidrdoinstype"/>' />
                                    </div>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">As Per</label>
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                                            <input type="radio" id="rdoinsasper1" name="rdoinsasper" value="T" style="margin:0;" /> Tenancy
                                        </label> 
                                        <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin:0; cursor:pointer;">
                                            <input type="radio" id="rdoinsasper2" name="rdoinsasper" value="P" style="margin:0;" /> Property
                                        </label> 
                                        <input type="hidden" id="hidrdoinsasper" name="hidrdoinsasper" value='<s:property value="hidrdoinsasper"/>' />
                                    </div>
                                </div>
                                <div class="field-row" style="align-items:flex-start; margin-bottom:0;">
                                    <label class="lbl-right" style="width:80px; padding-top:4px;">Notes</label>
                                    <textarea id="txttermsnotes" name="txttermsnotes" style="flex:1; height:40px;" rows="2"><s:property value="txttermsnotes" /></textarea>
                                </div>
                            </div>
                            
                            <div class="middle-panel" style="margin-bottom:0;">
                                <span class="middle-panel-title">Special Instructions</span>
                                <div id="splinstructionsGrid" class="grid-container" style="border:none;">
                                    <jsp:include page="splinstructionGrid.jsp"></jsp:include>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab: Sales Terms (#menu4) -->
                <div id="menu4" class="tab-pane fade in">
                    <div class="middle-panel">
                        <span class="middle-panel-title">OWNER</span>
                        <div class="field-row">
                            <label class="lbl-right" style="width:250px;">Commision from Net Selling Price</label>
                            <select id="cmbOwCommision" name="cmbOwCommision" style="width:100px;" value='<s:property value="cmbOwCommision"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select> 
                            <input type="hidden" id="hidcmbOwCommision" name="hidcmbOwCommision" value='<s:property value="hidcmbOwCommision"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">In %</label>
                            <input type="text" name="txtOwCommisionPerc" id="txtOwCommisionPerc" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtOwCommisionPerc"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">AED</label>
                            <input type="text" name="txtOwCommisionAmt" id="txtOwCommisionAmt" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtOwCommisionAmt"/>' />
                        </div>
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:250px;">Transfer Fee of Net Selling Price</label>
                            <select id="cmbOwTransferfee" name="cmbOwTransferfee" style="width:100px;" value='<s:property value="cmbOwTransferfee"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select> 
                            <input type="hidden" id="hidcmbOwTransferfee" name="hidcmbOwTransferfee" value='<s:property value="hidcmbOwTransferfee"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">In %</label>
                            <input type="text" name="txtTransferfeePerc" id="txtTransferfeePerc" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtTransferfeePerc"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">AED</label>
                            <input type="text" name="txttrnsnetselAmt" id="txttrnsnetselAmt" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txttrnsnetselAmt"/>' />
                        </div>
                    </div>
                    
                    <div class="middle-panel">
                        <span class="middle-panel-title">BUYER</span>
                        <div class="field-row">
                            <label class="lbl-right" style="width:250px;">Commision from Net Selling Price</label>
                            <select id="cmbBuyerCommision" name="cmbBuyerCommision" style="width:100px;" value='<s:property value="cmbBuyerCommision"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select> 
                            <input type="hidden" id="hidcmbBuyerCommision" name="hidcmbBuyerCommision" value='<s:property value="hidcmbBuyerCommision"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">In %</label>
                            <input type="text" name="txtBuyerCommisionPerc" id="txtBuyerCommisionPerc" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtBuyerCommisionPerc"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">AED</label>
                            <input type="text" name="txtBuyerCommisionAmt" id="txtBuyerCommisionAmt" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtBuyerCommisionAmt"/>' />
                        </div>
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:250px;">Transfer Fee of Net Selling Price</label>
                            <select id="cmbBuyerTransferfee" name="cmbBuyerTransferfee" style="width:100px;" value='<s:property value="cmbBuyerTransferfee"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select> 
                            <input type="hidden" id="hidcmbBuyerTransferfee" name="hidcmbBuyerTransferfee" value='<s:property value="hidcmbBuyerTransferfee"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">In %</label>
                            <input type="text" name="txtBuyerTransferfeePerc" id="txtBuyerTransferfeePerc" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtBuyerTransferfeePerc"/>' />
                            
                            <label class="lbl-right" style="width:60px; margin-left:15px;">AED</label>
                            <input type="text" name="txtBuyerTransferfeeAmt" id="txtBuyerTransferfeeAmt" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtBuyerTransferfeeAmt"/>' />
                        </div>
                    </div>
                    
                    <div class="middle-panel" style="margin-bottom:0;">
                        <span class="middle-panel-title">SALES</span>
                        <div class="field-row">
                            <label class="lbl-right" style="width:250px;">Net Sale Price to Owner</label>
                            <input type="text" name="txtnetsalepriceow" id="txtnetsalepriceow" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnetsalepriceow"/>' />
                            
                            <label class="lbl-right" style="width:200px; margin-left:15px;">Value to Owner after Deduction (AED)</label>
                            <input type="text" name="txtownervalueafterded" id="txtownervalueafterded" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtownervalueafterded"/>' />
                        </div>
                        <div class="field-row" style="margin-bottom:0;">
                            <label class="lbl-right" style="width:250px;">Total Selling Price (ALL FEES) (AED)</label>
                            <input type="text" name="txttotalselprice" id="txttotalselprice" style="width:120px; text-align:right;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txttotalselprice"/>' />
                        </div>
                    </div>
                </div>

                <!-- Tab: Furniture & Fixtures (#menu5) -->
                <div id="menu5" class="tab-pane fade in">
                    <div class="middle-panel" style="margin-bottom:0;">
                        <span class="middle-panel-title">Furniture &amp; Fixtures</span>
                        
                        <div id="furni_buttons" class="field-row" style="margin-bottom: 15px;">
                            <button type="button" class="myButton" id="btnfuredit" onclick="editfurgrid();" style="background: linear-gradient(135deg, #d97706 0%, #b45309 100%);">Edit</button> 
                            <button type="button" class="myButton" id="btnfursave" onclick="savefurgrid();" style="background: linear-gradient(135deg, #059669 0%, #047857 100%); margin-left:10px;">Save</button>
                        </div>
                        
                        <div style="display:flex; gap:15px;">
                            <div style="flex:1;">
                                <div id="divselectedroom" class="grid-container" style="border:none;">  
                                    <jsp:include page="selectedRoomGrid.jsp"></jsp:include>
                                </div>
                            </div>
                            <div style="flex:1.5;">
                                <div id="divselectedfurfix" class="grid-container" style="border:none;">
                                    <jsp:include page="selectedFurfixGrid.jsp"></jsp:include>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Hidden Elements Container -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /> 
                <input type="hidden" id="txtroomno" name="txtroomno" value='<s:property value="txtroomno"/>' /> 
                <input type="hidden" id="splgridlength" name="splgridlength" /> 
                <input type="hidden" id="accgridlength" name="accgridlength" /> 
                <input type="hidden" id="selectedfurgridlength" name="selectedfurgridlength" /> 
                <input type="hidden" id="txtroomid" name="txtroomid" /> 
                <input type="hidden" id="pmode" name="pmode" value='<s:property value="pmode"/>' /> 
                <input type="hidden" id="owacno" name="owacno" value='<s:property value="owacno"/>' /> 
                <input type="hidden" id="sysgenid" name="sysgenid" value='<s:property value="sysgenid"/>' />
                <input type="hidden" id="pavail" name="pavail"/>
            </div>

        </div>
    </form>
    </div>

    <!-- Modals & Search Windows -->
    <div id="ownersearchwindow"><div></div></div>
    <div id="areainfowindow"><div></div></div>
    <div id="ptytypesearchwindow"><div></div></div>
    <div id="unittypesearchwindow"><div></div></div>
    <div id="refnosearchwindow"><div></div></div>
    <div id="usearchwindow"><div></div></div>
    <div id="salesmansearchwindow"><div></div></div>

    <!-- Save succesfully modal -->
    <div class="modal fade" id="ignismyModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="border: 0px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label=""><span>×</span></button>
                </div>
                <div class="modal-body">
                    <div style="width: 100%; padding: 20px; text-align: center;">
                        <img src="http://goactionstations.co.uk/wp-content/uploads/2017/03/Green-Round-Tick.png" alt="" style="width: 50px; height: auto; margin: 0 auto; display: block; margin-bottom: 25px;">
                        <h1 style="font-size: 20px; margin-bottom: 25px; color: #5C5C5C;">Save Successfuly!</h1>
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label=""><span>close</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- rooms modal -->
    <div class="modal fade" id="roomfurnitureModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label=""><span>×</span></button>
                    <h4>Rooms -Furniture & Fixtures</h4>
                </div>
                <div class="modal-body">
                    <div id="accordion"></div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>