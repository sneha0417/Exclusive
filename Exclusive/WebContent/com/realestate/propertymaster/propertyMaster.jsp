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
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
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
		//$('#masterdoc_no').val(pdoc);				 
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
		 else
		 {
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
		else
		{
			$('#hidchkpforHC').val(''); 
		}
		  //$('.chkpfor').not(this).prop('checked', false);	//unckeck other checkboxes with class = chkpfor
		 
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
	//roomSearchContent('roomSearchGrid.jsp');
	
	$("#splinstructionsGrid").load("splinstructionGrid.jsp?docno=" + $("#docno").val());
	
	$("#jqxmodifieddate").jqxDateTimeInput({ width: '80%', height: '23px', formatString:"dd.MM.yyyy"});
	$("#jqxwarratydate").jqxDateTimeInput({ width: '80%', height: '23px', formatString:'dd.MM.yyyy',enableBrowserBoundsDetection: true});
	/* Date */
 	$("#jqxdate").jqxDateTimeInput({ width: '80%', height: '23px', formatString:"dd.MM.yyyy"});
 	$('#jqxdate').on('change', function (event) {		  
		    var maindate = $('#jqxdate').jqxDateTimeInput('getDate');
		  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
		    funDateInPeriodchk(maindate);	
		  	 }
		   });
 	
 	/* $('#roomwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Rooms' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#roomwindow').jqxWindow('close'); */
	$('#salesmansearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'SalesMan Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#salesmansearchwindow').jqxWindow('close');

	$('#ownersearchwindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Owner Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#ownersearchwindow').jqxWindow('close');
	$('#areainfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	$('#ptytypesearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Property Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#ptytypesearchwindow').jqxWindow('close');
	$('#unittypesearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Unit Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#unittypesearchwindow').jqxWindow('close');	
	
	$('#usearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#usearchwindow').jqxWindow('close');
	
	$('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
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
 	//Load_ddlRooms(); 	
 	/* $('#ddlRoom').on('change', function() { 		
		var pdocno= $("#docno").val();	
		alert(this.value);
		var rdocno = $(this).val()  ; 
		$("#txtroomno").val(rdocno);
		$("#divselectedfurfix").load("selectedFurfixGrid.jsp?rdocno=" + rdocno+"&pdocno="+pdocno); 
 	}); */
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

/* function Load_ddlRooms() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var roomId  = items[0].split(",");
			var room = items[1].split(",");
			var optionscard = '<option value="">--Select Room--</option>';
			for (var i = 0; i < room.length; i++) {
				optionscard += '<option value="' + roomId[i] + '">'
						+ room[i] + '</option>';
			}
			$("select#ddlRoom").html(optionscard);
			if ($('#hdnddlRoom').val() != null) {
				$('#ddlRoom').val($('#hdnddlRoom').val());
			}
		} else {
		}
	};
	x.open("GET", "getRooms.jsp", true);
	x.send();
}   */

function getunitof(event){
	 var x= event.keyCode;
	 if(x==114){
			getof('building.jsp');
	 } else{}
}

function getof(url) {

	$('#usearchwindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	//alert(data);
	$('#usearchwindow').jqxWindow('setContent', data);
	}); 
	}	
function getOwner(event){
	refsearchContent1('ormainsearch.jsp');
}


function refsearchContent1(url) {

$('#refnosearchwindow').jqxWindow('open');
  $.get(url).done(function (data) {
//alert(data);
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
	 $
	 ('#areainfowindow').jqxWindow('setContent', data);
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
	 
	 //LoadRoomsFurniture(); 
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
 /*   if(document.getElementById("hidcmbrtainerfund").value!=""){                                                 
		document.getElementById("cmbrtainerfund").value=document.getElementById("hidcmbrtainerfund").value;        
   } */
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
   if(document.getElementById("hidparking").value!=""){                         
		document.getElementById("parking").value=document.getElementById("hidparking").value;        
   }
   if(document.getElementById("hidparking").value!=""){                         
		document.getElementById("parking").value=document.getElementById("hidparking").value;        
   }
   if(document.getElementById("hidparking").value!=""){                         
		document.getElementById("parking").value=document.getElementById("hidparking").value;        
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
		
		// border color red to maintancence retainer fund		
		document.getElementById("cmbrtainerfund").style.border = "1px solid #ff1d1d";
		
		// show owner account
		var owacno=$('#owacno').val();
		
		 if(owacno!="")
		 { 
			 $('#divownerac').show();
			 $('#lblowneraccount').text("Owner Account Number: " + owacno);
		 }
		 
		// show system generated id for property
		 
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
			// var propertyname = document.getElementById("propertyname").value;
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
	
	/* if(propertyname=="")
	{
	document.getElementById("errormsg").innerText="Property Name is required ";
	 
	return 0;
	}
		 */
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


	
// load rooms
/* function getrooms(){ 
	 
	$('#roomwindow').jqxWindow('open');
	roomSearchContent('roomSearchGrid.jsp');
} */

/* function roomSearchContent(url) {
	 $.get(url).done(function (data) {
	 $ ('#roomwindow').jqxWindow('setContent', data);
	 }); 
} */
    
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
			 
			//console.log(data.property[0].main);			
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
					    
					   //console.log(m+"::"+i+"::"+data.property[i].main); 
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

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}

/*--thank you pop starts here--*/
.thank-you-pop {
	width: 100%;
	padding: 20px;
	text-align: center;
}

.thank-you-pop img {
	width: 50px;
	height: auto;
	margin: 0 auto;
	display: block;
	margin-bottom: 25px;
}

.thank-you-pop h1 {
	font-size: 20px;
	margin-bottom: 25px;
	color: #5C5C5C;
}

.thank-you-pop p {
	font-size: 15px;
	margin-bottom: 27px;
	color: #5C5C5C;
}

.thank-you-pop h3.cupon-pop {
	font-size: 15px;
	margin-bottom: 40px;
	color: #222;
	display: inline-block;
	text-align: center;
	padding: 10px 20px;
	border: 2px dashed #222;
	clear: both;
	font-weight: normal;
}

.thank-you-pop h3.cupon-pop span {
	color: #03A9F4;
}

.thank-you-pop a {
	display: inline-block;
	margin: 0 auto;
	padding: 9px 20px;
	color: #fff;
	text-transform: uppercase;
	font-size: 12px;
	background-color: #8BC34A;
	border-radius: 17px;
}

.thank-you-pop a i {
	margin-right: 5px;
	color: #fff;
}

#ignismyModal .modal-header {
	border: 0px;
}
/*--thank you pop ends here--*/
</style>

</head>
<body onload="setValues();getcmbtranstype();getPropertyType();" onclick="deletestatus();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmpropertyMaster" action="saveptyMaster" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include><br />

			<div class='hidden-scrollbar'>
				<div class="container-fluid">
					<div class="row" style="padding: 0.5em;">
						<div class="col-md-2" style="padding: 0;">
							<div class="col-md-5">Doc No</div>
							<div class="col-md-7">
								<input type="hidden" id="docno" name="docno"
									value='<s:property value="docno"/>' /> <input type="text"
									style="width: 100%" id="vocno" name="vocno"
									value='<s:property value="vocno"/>' />
							</div>
						</div>
						<div class="col-md-6" style="padding: 0;">
							<div class="col-md-1">Owner</div>
							<div class="col-md-11">
								<input type="text" id="owner" name="owner" style="width: 100%;"
									value='<s:property value="owner"/>'
									placeholder="Press F3 To Search" onkeydown="getOwner();" /> <input
									type="hidden" id="ownerid" name="ownerid"
									value='<s:property value="ownerid"/>'> <span
									style="color: red;" id="msgowner"></span>
							</div>
						</div>
						<div class="col-md-2" style="padding-left: 0;">
							<div class="col-md-3">Date</div>
							<div class="col-md-9">
								<div id="jqxdate" name="jqxdate"
									value='<s:property value="jqxdate"/>'></div>
								<input type="hidden" id="hiddate" name="hiddate"
									value='<s:property value="hiddate"/>' />
							</div>
						</div>
						<div class="col-md-2">
							<div id="divownerac" style="display: none;">
								<label id="lblowneraccount" style="color: green;"></label>

							</div>
						</div>

					</div>

					<div class="row" style="padding: 0.5em;">
						<div class="col-md-2" style="padding: 0;">
							<div class="col-md-5">Opt.ID</div>
							<div class="col-md-7">
								<input type="text" id="txtoptID" name="txtoptID"
									style="width: 100%;" value='<s:property value="txtoptID"/>' />
							</div>
						</div>
						<div class="col-md-2" style="padding-right: 0;">
							<div class="col-md-2" style="padding: 0;">Type</div>
							<div class="col-md-8">
								<select id="cmbptype" name="cmbptype"
									value='<s:property value="cmbptype"/>' style="width: 100%;">
									<!-- 	<option value="">---Select--</option>       
									<option value="BLD">BLD</option>
									<option value="VIL">VIL</option>
									<option value="PTH">PTH</option>
									<option value="APT">APT</option>
									<option value="SHP">SHP</option>
									<option value="OFF">OFF</option>
									<option value="OTH">OTH</option> -->
								</select> <input type="hidden" id="hidcmbptype" name="hidcmbptype"
									value='<s:property value="hidcmbptype"/>' />
							</div>
						</div>
						<div class="col-md-2" style="padding: 0;">
							<div class="col-md-1" style="padding: 0;">For</div>
							<div class="col-md-8" style="padding: 0; text-align: right;">
								<%-- <label for="chkpforrent"><input type="checkbox"
									class="chkpfor" name="chkpforrent" id="chkpforrent"
									value="Rent" style="vertical-align: middle;" /> Rent</label> <label><input
									class="chkpfor" type="checkbox" name="chkpforsale"
									id="chkpforsale" value="Sale" /> Sale</label> <label><input
									class="chkpfor" type="checkbox" name="chkpforhc" id="chkpforhc"
									value="HC" /> HC</label> <input type="hidden" id="hidchkpfor"
									name="hidchkpfor" value='<s:property value="hidchkpfor"/>' /> --%>
									 <label for="chkpforrent"><input type="checkbox"
									class="chkpfor" name="chkpforrent" id="chkpforrent"
									value="Rent" style="vertical-align: middle;" /> Rent</label> <label><input
									class="chkpfor" type="checkbox" name="chkpforsale"
									id="chkpforsale" value="Sale" /> Sale</label> <label><input
									class="chkpforHC" type="checkbox" name="chkpforhc" id="chkpforhc"
									value="HC" /> HC</label>
									
									 <input type="hidden" id="hidchkpfor"
									name="hidchkpfor" value='<s:property value="hidchkpfor"/>' />  
									
									<input type="hidden" id="hidchkpforS"
									name="hidchkpforS" value='<s:property value="hidchkpforS"/>' />  
									<input type="hidden" id="hidchkpforR"
									name="hidchkpforR" value='<s:property value="hidchkpforR"/>' />  
									<input type="hidden" id="hidchkpforHC"
									name="hidchkpforHC" value='<s:property value="hidchkpforHC"/>' />  
							</div>
						</div>
						<div class="col-md-2" style="padding: 0;">
							<div class="col-md-8">
								<label><input type="checkbox" class="chkmanagedproperty"
									name="chkmanagedproperty" id="chkmanagedproperty" />Managed
									Property</label> <input type="hidden" id="hidchkmanagedproperty"
									name="hidchkmanagedproperty"
									value='<s:property value="hidchkmanagedproperty"/>' />
							</div>
						</div>
						<div class="col-md-4">
							<div id="divsysgenid" style="display: none;">
								<label id="lblsysgenid" style="color: green;"></label>
							</div>
						</div>

					</div>
					<div role="tabpanel">
						<ul class="nav nav-tabs" style="background: #d9edf7;"
							role="tablist">
							<li class="active"><a data-toggle="tab" href="#home">Property
									Address</a></li>
							<li><a data-toggle="tab" href="#menu1">Property Details</a></li>
							<li><a data-toggle="tab" href="#menu2">Developer Details</a></li>
							<li id="termscondtnid"><a data-toggle="tab" href="#menu3">Terms/Conditions</a></li>         
							<li id="salestermsid"><a data-toggle="tab" id="a_salesterms">Sales Terms</a></li>
							<li><a data-toggle="tab" href="#menu5">Furniture &amp;
									Fixtures</a></li>
							<!-- 	<li><a data-toggle="tab" href="#menu7">Account Details</a></li> -->
						</ul>
						<div class="tab-content">
							<div id="home" class="tab-pane fade in active">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-6">
										<div class="panel panel-default"
											style="font-size: 1em; height: 187px;">
											<div class="panel-heading">Address</div>
											<div class="panel-body" style="height: 165px;">
												<div class="row">
													<div class="col-md-3">Address 1</div>
													<div class="col-md-8">
														<input type="text" name="txtaddress1" id="txtaddress1"
															value='<s:property value="txtaddress1"/>'
															style="width: 100%;" required>
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Address2</div>
													<div class="col-md-8">
														<input type="text" name="txtaddress2" id="txtaddress2"
															value='<s:property value="txtaddress2"/>'
															style="width: 100%;">
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Account Name</div>
													<div class="col-md-8">
														<input type="text" name="txtaccname" id="txtaccname"
															value='<s:property value="txtaccname"/>'
															style="width: 100%;" required>
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Nearest Landmark</div>
													<div class="col-md-8">
														<input type="text" name="txtlandmark" id="txtlandmark"
															value='<s:property value="txtlandmark"/>'
															style="width: 100%;">
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="panel panel-default"
											style="font-size: 1em; height: 187px;">
											<div class="panel-heading">Area</div>
											<div class="panel-body" style="height: 165px;">
												<div class="row">
													<div class="col-md-4">Area</div>
													<div class="col-md-8">
														<input type="text" id="txtarea" name="txtarea"
															value='<s:property value="txtarea"/>' style="width: 60%;"
															placeholder="press F3 to search"
															onKeyDown="getareas(event);" /> <input type="hidden"
															id="txtareadet" name="txtareadet" readonly
															style="width: 68%;"
															value='<s:property value="txtareadet"/>' /> <input
															type="hidden" id="txtareaid" name="txtareaid"
															value='<s:property value="txtareaid"/>' />
													</div>
												</div>
												<div class="row">
													<div class="col-md-4">Property Description</div>
													<div class="col-md-8">
														<textarea name="propertydesc" style="width: 100%;"
															id="propertydesc" rows="3"><s:property
																value="propertydesc" /></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Details</div>
											<div class="panel-body">
												<div class="col-md-3">
													<div class="col-md-12" style="display: none">Property
														Type</div>
													<div class="col-md-12" style="display: none">
														<input type="text" name="propertytype" id="propertytype"
															value='<s:property value="propertytype"/>'
															style="width: 100%;" placeholder="Press F3 To Search"
															onkeydown="getProperty(event);"> <input
															type="hidden" name="hidpropertytype" id="hidpropertytype"
															value='<s:property value="hidpropertytype"/>'>
													</div>
													<div class="col-md-12">Contact for Rent/Sales</div>
													<div class="col-md-12">
														<input type="text" name="txtsalesman" id="txtsalesman"
															value='<s:property value="txtsalesman"/>'
															style="width: 100%;"><input    
															type="hidden" name="hidcmbcontactperson"
															id="hidcmbcontactperson"
															value='<s:property value="hidcmbcontactperson"/>'> 
														<%-- <select id="cmbcontactperson" name="cmbcontactperson"
															style="height: 23px; padding: 0px; width: 100%;display:none;">
														</select> --%>
													</div>
													<div class="col-md-12">Contact Number</div>
													<div class="col-md-12">
														<input type="text" id="txtcontactnumber"
															name="txtcontactnumber" style="width: 100%;"
															value='<s:property value="txtcontactnumber"/>'
															tabindex="-1" />
													</div>
												</div>
												<div class="col-md-5">
													<div style="border: 1px solid #ccc; padding: 1em;">
														<div class="row">
															<div class="col-md-4">No.of Rooms</div>
															<div class="col-md-8">
																<input type="text" name="no_of_rooms" id="no_of_rooms"
																	onkeypress="javascript:return isNumber (event);"
																	value='<s:property value="no_of_rooms"/>'
																	style="width: 50%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">No.of Bathrooms</div>
															<div class="col-md-8">
																<input type="text" name="no_of_bath" id="no_of_bath"
																	onkeypress="javascript:return isNumber (event);"
																	value='<s:property value="no_of_bath"/>'
																	style="width: 50%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Additional Rooms</div>
															<div class="col-md-8">
																<input type="hidden" name="hidarm" id="hidarm"
																	value='<s:property value="hidarm"/>'
																	style="width: 50%;"> <select id="arm"
																	onchange="checkaddroom();"
																	style="height: 23px; padding: 0px; width: 25%;"
																	name="arm">
																	<option value="">select</option>
																	<option value="1">Yes</option>
																	<option value="0">No</option>
																</select>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">No.of.add.Rooms</div>
															<div class="col-md-8">
																<div class="col-md-3" style="padding-left: 0px;">
																	<input type="text" name="roomsno" id="roomsno"
																		onkeypress="javascript:return isNumber (event);"
																		value='<s:property value="roomsno"/>'
																		style="width: 100%">
																</div>
																<div class="col-md-9">
																	For <input type="text" name="txtfor" id="txtfor"
																		value='<s:property value="txtfor"/>' style="">
																</div>
																<p>(eg:Servants,Watchmen,Maintenance etc)</p>
															</div>
														</div>

														<div class="row">
															<div class="col-md-4">Special Notes</div>
															<div class="col-md-8">
																<textarea rows="3" style="width: 100%;"
																	name="txtspecialnotes" id="txtspecialnotes">
																	<s:property value="txtspecialnotes" />
																	</textarea>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div style="border: 1px solid #ccc; padding: 1em;">
														<div class="row">
															<div class="col-md-4">Unit Number</div>
															<div class="col-md-8">
																<input type="text" name="unitno" id="unitno"
																	value='<s:property value="unitno"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Unit Type</div>
															<div class="col-md-8">
																<input type="text" name="unittype" id="unittype"
																	value='<s:property value="unittype"/>'
																	style="width: 100%;" onkeydown="getunit()"
																	placeholder="search Unit type"> <input
																	type="hidden" name="hidunittypeid" id="hidunittypeid"
																	value='<s:property value="hidunittypeid"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Unit of</div>
															<div class="col-md-8">
																<input type="text" name="unitof" id="unitof"
																	value='<s:property value="unitof"/>'
																	style="width: 100%;" onkeydown="getunitof()"
																	placeholder="search Building "> <input
																	type="hidden" name="hidunitofid" id="hidunitofid"
																	value='<s:property value="hidunitofid"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Parking</div>
															<div class="col-md-8">
																<input type="hidden" name="hidparking" id="hidparking"
																	value='<s:property value="hidparking"/>'
																	style="width: 100%;" /> <select id="parking"
																	onchange="checkparking();"
																	style="height: 23px; padding: 0px; width: 25%;"
																	name="parking">
																	<option value="">select</option>
																	<option value="1">Yes</option>
																	<option value="0">No</option>
																</select>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Parking No.</div>
															<div class="col-md-8">
																<input type="text" name="parkingno" id="parkingno"
																	value='<s:property value="parkingno"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">Bay No.</div>
															<div class="col-md-8">
																<input type="text" name="bayno" id="bayno"
																	value='<s:property value="bayno"/>'
																	style="width: 100%;">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div id="menu1" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Area Details</div>
											<div class="panel-body">
												<div class="col-md-2">
													<div class="row">
														<div class="col-md-2">Area</div>
														<div class="col-md-8">
															<input type="text" name="txtarea1" id="txtarea1"
																onkeypress="javascript:return isNumber(event)"
																value='<s:property value="txtarea1"  />'
																style="width: 100%;"> (In Sq.Ft)
														</div>
													</div>
													<div class="row">
														<div class="col-md-2">Yard</div>
														<div class="col-md-8">
															<input type="text" name="txtyard" id="txtyard"
																onkeypress="javascript:return isNumber(event)"
																value='<s:property value="txtyard"/>'
																style="width: 100%;">
														</div>
													</div>
												</div>
												<div class="col-md-6">
													<div class="row">
														<div class="col-md-2">Build Up Area</div>
														<div class="col-md-3">
															<input type="text" name="txtbuilduparea"
																onkeypress="javascript:return isNumber(event)"
																id="txtbuilduparea"
																value='<s:property value="txtbuilduparea"/>'
																style="width: 100%;"> (In Sq.Ft)
														</div>
													</div>
													<div class="row">
														<div class="col-md-2">Property Views</div>
														<div class="col-md-8">
															<textarea rows="3" id="txtpropertyviews"
																name="txtpropertyviews" style="width: 100%;"><s:property
																	value="txtpropertyviews" /></textarea>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Utlity Details</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-md-6">Electricity &amp; Water No</div>
													<div class="col-md-6">
														<input type="text" name="electricwaterno"
															id="electricwaterno"
															value='<s:property value="electricwaterno"/>'
															style="width: 100%;">
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">Gas Connection No</div>
													<div class="col-md-6">
														<input type="text" name="gasconnectionno"
															id="gasconnectionno"
															value='<s:property value="gasconnectionno"/>'
															style="width: 100%;">
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">AC Connection No</div>
													<div class="col-md-6">
														<input type="text" name="acconnectionno"
															id="acconnectionno"
															value='<s:property value="acconnectionno"/>'
															style="width: 100%;">
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">Premises No</div>
													<div class="col-md-6">
														<input type="text" name="premisesno" id="premisesno"
															value='<s:property value="premisesno"/>'
															style="width: 100%;">
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">Maintenance Retainer Fund</div>
													<div class="col-md-6">
														<input type="text" id="cmbrtainerfund" style="width: 40%;"
															name="cmbrtainerfund"
															value='<s:property value="cmbrtainerfund"/>'> <input
															type="text" name="txtmaintainerfund"
															id="txtmaintainerfund"
															value='<s:property value="txtmaintainerfund"/>'
															style="width: 58%;"> <input type="hidden"
															id="hidcmbrtainerfund" name="hid"
															value='<s:property value="hidcmbrtainerfund"/>' />
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Keys &amp; Controls</div>
											<div class="panel-body" style="">
												<div id="accessgriddiv">
													<jsp:include page="accessGrid.jsp"></jsp:include><br />
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>
							<div id="menu2" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Developer Details</div>
											<div class="panel-body" style="">
												<div class="col-md-6">
													<div class="row">
														<div class="col-md-6">Name</div>
														<div class="col-md-6">
															<input type="text" name="txtdevelopername"
																id="txtdevelopername"
																value='<s:property value="txtdevelopername"/>'
																style="width: 100%;">
														</div>
													</div>
													<div class="row">
														<div class="col-md-6">Address1</div>
														<div class="col-md-6">
															<input type="text" name="txtdevaddress1"
																id="txtdevaddress1"
																value='<s:property value="txtdevaddress1"/>'
																style="width: 100%;">
														</div>
													</div>
													<div class="row">
														<div class="col-md-6">Address2</div>
														<div class="col-md-6">
															<input type="text" name="txtdevaddress2"
																id="txtdevaddress2"
																value='<s:property value="txtdevaddress2"/>'
																style="width: 100%;">
														</div>
													</div>
													<div class="row">
														<div class="col-md-6">Telephone</div>
														<div class="col-md-6">
															<input type="text" name="txtdevph" id="txtdevph"
																onkeypress="javascript:return isNumber(event)"
																value='<s:property value="txtdevph"/>'
																style="width: 100%;">
														</div>
													</div>
													<div class="row">
														<div class="col-md-6">Fax</div>
														<div class="col-md-6">
															<input type="text" name="txtdevfax" id="txtdevfax"
																value='<s:property value="txtdevfax"/>'
																style="width: 100%;">
														</div>
													</div>
													<div class="panel panel-default" style="font-size: 1em;">
														<div class="panel-heading">Contact Person</div>
														<div class="panel-body" style="">
															<div class="row">
																<div class="col-md-6">Name</div>
																<div class="col-md-6">
																	<input type="text" name="txtcontactname"
																		id="txtcontactname"
																		value='<s:property value="txtcontactname"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Mobile</div>
																<div class="col-md-6">
																	<input type="text" name="txtcontactmobile"
																		onkeypress="javascript:return isNumber(event)"
																		id="txtcontactmobile"
																		value='<s:property value="txtcontactmobile"/>'
																		style="width: 100%;">
																</div>
															</div>
														</div>
													</div>

												</div>
												<div class="col-md-6">
													<div class="panel panel-default" style="font-size: 1em;">
														<div class="panel-heading">Bank Details</div>
														<div class="panel-body" style="">
															<div class="row">
																<div class="col-md-6">Bank Name</div>
																<div class="col-md-6">
																	<input type="text" name="txtdevbankname"
																		id="txtdevbankname"
																		value='<s:property value="txtdevbankname"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Account No.</div>
																<div class="col-md-6">
																	<input type="text" name="txtdevaccno" id="txtdevaccno"
																		value='<s:property value="txtdevaccno"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Address</div>
																<div class="col-md-6">
																	<input type="text" name="txtdevbankaddress"
																		id="txtdevbankaddress"
																		value='<s:property value="txtdevbankaddress"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Telephone</div>
																<div class="col-md-6">
																	<input type="text" name="txtdevbankph"
																		onkeypress="javascript:return isNumber(event)"
																		id="txtdevbankph"
																		value='<s:property value="txtdevbankph"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Fax</div>
																<div class="col-md-6">
																	<input type="text" name="txtdevbankfax"
																		id="txtdevbankfax"
																		value='<s:property value="txtdevbankfax"/>'
																		style="width: 100%;">
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">Country</div>
																<div class="col-md-6">
																	<select name="cmbcountry" id="cmbcountry"
																		style="width: 100%;"
																		value='<s:property value="cmbcountry"/>'></select> <input
																		type="hidden" id="hidcmbcountry" name="hidcmbcountry"
																		value='<s:property value="hidcmbcountry"/>' />
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="menu3" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Questionanaire</div>
											<div class="panel-body">
												<div class="row">

													<div class="col-md-5">
														<div class="row">
															<div class="col-md-6">Tenancy Cheques in Owners
																Name</div>
															<div class="col-md-6">
																<select name="txtchequeownersname" id="txtchequeownersname" style="width: 50%;">
																	<option value="">Select</option>
																	<option value="Y">Yes</option>
																	<option value="N">No</option>
																</select>

																 <input type="hidden" name="hidchequeownersname"
																	id="hidchequeownersname"
																	value='<s:property value="hidchequeownersname"/>'
																	style="width: 100%;"> 
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Rental Value</div>
															<div class="col-md-3">
																<input type="text" name="txtrentalvaluefrom"
																	id="txtrentalvaluefrom"
																	onkeypress="javascript:return isNumber(event)"
																	value='<s:property value="txtrentalvaluefrom"/>'
																	style="width: 100%;">
															</div>
															<div class="col-md-3">
																<input type="text" name="txtrentalvalueto"
																	onkeypress="javascript:return isNumber(event)"
																	id="txtrentalvalueto"
																	value='<s:property value="txtrentalvalueto"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">New Rent</div>
															<div class="col-md-6">
																<input type="text" name="txtnewrent" id="txtnewrent"
																	onkeypress="javascript:return isNumber(event)"
																	value='<s:property value="txtnewrent"/>'
																	style="width: 100%;">
															</div>

														</div>
														<div class="row">
															<div class="col-md-6">Expected Sales Value</div>
															<div class="col-md-6">
																<input type="text" name="txtexpsaleval"
																	onkeypress="javascript:return isNumber(event)"
																	id="txtexpsaleval"
																	value='<s:property value="txtexpsaleval"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Management Fee in Percentage</div>
															<div class="col-md-6">
																<input type="text" name="txtmgtfeeperc"
																	onkeypress="javascript:return isNumber(event)"
																	id="txtmgtfeeperc"
																	value='<s:property value="txtmgtfeeperc"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Management Fee in            
																Value</div>
															<div class="col-md-6">
																<input type="text" name="txtrntcmsnperc"
																	onkeypress="javascript:return isNumber(event)"
																	id="txtrntcmsnperc"
																	value='<s:property value="txtrntcmsnperc"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Administrative Fee</div>
															<div class="col-md-6">
																<input type="text" name="txtadminfee" id="txtadminfee"
																	onkeypress="javascript:return isNumber(event)"
																	value='<s:property value="txtadminfee"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Snagging Fee</div>
															<div class="col-md-6">
																<input type="text" name="txtsnagfee" id="txtsnagfee"
																	onkeypress="javascript:return isNumber(event)"
																	value='<s:property value="txtsnagfee"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Others</div>
															<div class="col-md-6">
																<input type="text" name="txtothers" id="txtothers"
																	value='<s:property value="txtothers"/>'
																	style="width: 100%;">
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">Warranty</div>
															<div class="col-md-6">
																<div id="jqxwarratydate" name="hidwarratydate"
																	value='<s:property value="hidwarratydate"/>'></div>
																<%-- <input type="hidden" id="hidwarratydate"
																	name="hidwarratydate"
																	value='<s:property value="hidwarratydate"/>' /> --%>
															</div>
														</div>
													</div>
													<div class="col-md-7">
														<div class="row">
															<div id="splinstructionsGrid">
																<jsp:include page="splinstructionGrid.jsp"></jsp:include>
															</div>
														</div>
														<div class="row">
															<div class="panel panel-default" style="font-size: 1em;">
																<div class="panel-heading">Inspection</div>
																<div class="panel-body">
																	<div class="row">
																		<div class="col-md-2">Type</div>
																		<div class="col-md-10">
																			<div>
																				<label> <input type="radio" id="rdoinstype1"
																					class="rdoinstype" name="rdoinstype" value="HY" />
																					Half Yearly
																				</label> <label> <input type="radio"
																					id="rdoinstype2" class="rdoinstype"
																					name="rdoinstype" value="Q" /> Quaterly
																				</label> <label> <input type="radio"
																					id="rdoinstype3" class="rdoinstype"
																					name="rdoinstype" value="M" /> Monthly
																				</label> <input type="hidden" id="hidrdoinstype"
																					name="hidrdoinstype"
																					value='<s:property value="hidrdoinstype"/>' />

																			</div>
																		</div>
																	</div>
																	<div class="row" style="padding: 0.5em;">
																		<div class="col-md-2">As Per</div>
																		<div class="col-md-10">
																			<div>
																				<label> <input type="radio"
																					id="rdoinsasper1" name="rdoinsasper" value="T" />
																					Tenancy
																				</label> <label> <input type="radio"
																					id="rdoinsasper2" name="rdoinsasper" value="P" />
																					Property
																				</label> <input type="hidden" id="hidrdoinsasper"
																					name="hidrdoinsasper"
																					value='<s:property value="hidrdoinsasper"/>' />
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-2">Notes</div>
															<div class="col-md-10">
																<textarea rows="3" style="width: 100%;"
																	id="txttermsnotes" name="txttermsnotes"><s:property
																		value="txttermsnotes" /></textarea>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="menu4" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">OWNER</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-md-3">Commision from Net Selling
														Price</div>
													<div class="col-md-2">
														<select id="cmbOwCommision" name="cmbOwCommision"
															value='<s:property value="cmbOwCommision"/>'
															style="width: 100%;">
															<option value="">--Select--</option>
															<option value="1">Yes</option>
															<option value="0">No</option>
														</select> <input type="hidden" id="hidcmbOwCommision"
															name="hidcmbOwCommision"
															value='<s:property value="hidcmbOwCommision"/>' />
													</div>
													<div class="col-md-2">
														<label class="">In % </label><input type="text"
															name="txtOwCommisionPerc" id="txtOwCommisionPerc"
															onkeypress="javascript:return isNumber(event)"
															value='<s:property value="txtOwCommisionPerc"/>' />
													</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txtOwCommisionAmt"
															onkeypress="javascript:return isNumber(event)"
															id="txtOwCommisionAmt"
															value='<s:property value="txtOwCommisionAmt"/>' />
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Transfer Fee of Net Selling
														Price</div>
													<div class="col-md-2">
														<select id="cmbOwTransferfee" name="cmbOwTransferfee"
															value='<s:property value="cmbOwTransferfee"/>'
															style="width: 100%;">
															<option value="">--Select--</option>
															<option value="1">Yes</option>
															<option value="0">No</option>
														</select> <input type="hidden" id="hidcmbOwTransferfee"
															name="hidcmbOwTransferfee"
															value='<s:property value="hidcmbOwTransferfee"/>' />
													</div>
													<div class="col-md-2">
														<label class="">In % </label> <input type="text"
															name="txtTransferfeePerc" id="txtTransferfeePerc"
															onkeypress="javascript:return isNumber(event)"
															value='<s:property value="txtTransferfeePerc"/>' />
													</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txttrnsnetselAmt"
															onkeypress="javascript:return isNumber(event)"
															id="txttrnsnetselAmt"
															value='<s:property value="txttrnsnetselAmt"/>' />
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">BUYER</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-md-3">Commision from Net Selling
														Price</div>
													<div class="col-md-2">
														<select id="cmbBuyerCommision" name="cmbBuyerCommision"
															value='<s:property value="cmbBuyerCommision"/>'
															style="width: 100%;">
															<option value="">--Select--</option>
															<option value="1">Yes</option>
															<option value="0">No</option>
														</select> <input type="hidden" id="hidcmbBuyerCommision"
															name="hidcmbBuyerCommision"
															value='<s:property value="hidcmbBuyerCommision"/>' />
													</div>
													<div class="col-md-2">
														<label class="">In % </label> <input type="text"
															name="txtBuyerCommisionPerc" id="txtBuyerCommisionPerc"
															onkeypress="javascript:return isNumber(event)"
															value='<s:property value="txtBuyerCommisionPerc"/>' />
													</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txtBuyerCommisionAmt"
															onkeypress="javascript:return isNumber(event)"
															id="txtBuyerCommisionAmt"
															value='<s:property value="txtBuyerCommisionAmt"/>' />
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Transfer Fee of Net Selling
														Price</div>
													<div class="col-md-2">
														<select id="cmbBuyerTransferfee"
															name="cmbBuyerTransferfee"
															value='<s:property value="cmbBuyerTransferfee"/>'
															style="width: 100%;">
															<option value="">--Select--</option>
															<option value="1">Yes</option>
															<option value="0">No</option>
														</select> <input type="hidden" id="hidcmbBuyerTransferfee"
															name="hidcmbBuyerTransferfee"
															value='<s:property value="hidcmbBuyerTransferfee"/>' />
													</div>
													<div class="col-md-2">
														<label class="">In % </label> <input type="text"
															onkeypress="javascript:return isNumber(event)"
															name="txtBuyerTransferfeePerc"
															id="txtBuyerTransferfeePerc"
															value='<s:property value="txtBuyerTransferfeePerc"/>' />
													</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txtBuyerTransferfeeAmt"
															onkeypress="javascript:return isNumber(event)"
															id="txtBuyerTransferfeeAmt"
															value='<s:property value="txtBuyerTransferfeeAmt"/>' />
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">SALES</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-md-3">Net Sale Price to Owner</div>
													<div class="col-md-2">
														<input type="text" name="txtnetsalepriceow"
															onkeypress="javascript:return isNumber(event)"
															id="txtnetsalepriceow"
															value='<s:property value="txtnetsalepriceow"/>' />
													</div>
													<div class="col-md-2">Value to Owner after Deduction
													</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txtownervalueafterded"
															onkeypress="javascript:return isNumber(event)"
															id="txtownervalueafterded"
															value='<s:property value="txtownervalueafterded"/>' />
													</div>
												</div>
												<div class="row">
													<div class="col-md-offset-5 col-md-2">Total Selling
														Price (ALL FEES)</div>
													<div class="col-md-offset-2 col-md-2">
														(AED)<input type="text" name="txttotalselprice"
															onkeypress="javascript:return isNumber(event)"
															id="txttotalselprice"
															value='<s:property value="txttotalselprice"/>' />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="menu5" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-12">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading" style="height: 38px !important;">
												<div id="furni_buttons">
													<!-- <input type="button" class="btn btn-info" id="btnfuredit"
														value="View" data-toggle="modal"
														data-target="#roomfurnitureModal"> --> <input
														type="button" class="btn btn-warning" id="btnfuredit"
														value="Edit" onclick="editfurgrid();"> <input
														type="button" class="btn btn-success" id="btnfursave"
														onclick="savefurgrid();" value="Save">
												</div>
											</div>
											<div class="panel-body">
												<div class="row" style="padding: 0;"></div>
												<div class="row">
													<div class="col-md-5">
														<!-- 	<input type="button" id="btnAddRoom" value="+"
														onclick="getrooms()" /> -->
														<div id="divselectedroom">  
															<jsp:include page="selectedRoomGrid.jsp"></jsp:include>
														</div>
														<%-- 	<select name="ddlRoom" id="ddlRoom"
																		style="width: 100%;"></select> <input type="hidden"
																		id="hdnddlRoom" name="hdnddlRoom" />		 --%>
													</div>

													<div class="col-md-7">
														<div id="divselectedfurfix">
															<jsp:include page="selectedFurfixGrid.jsp"></jsp:include>
														</div>
													</div>
												</div>
												<!-- 	<div class="col-md-7">
													<div id="divselectedfurfix"></div>
												</div> -->
											</div>
										</div>
									</div>
								</div>
							</div>

							<div id="menu7" class="tab-pane fade in ">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-5">
										<div class="panel panel-default" style="font-size: 1em;">
											<div class="panel-heading">Account Details</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-md-3">Group</div>
													<div class="col-md-4">
														<select id="cmbaccgroup" name="cmbaccgroup"
															style="width: 100%;"
															value='<s:property value="cmbaccgroup"/>'></select> <input
															type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup"
															value='<s:property value="hidcmbaccgroup"/>' />
													</div>
													<div class="col-md-5">
														<input type="text" name="txtaccgroupcode"
															id="txtaccgroupcode"
															value='<s:property value="txtaccgroupcode"/>'
															style="width: 100%;" />
													</div>
												</div>
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<input type="text" name="txtaccgroup" id="txtaccgroup"
															value='<s:property value="txtaccgroup"/>'
															style="width: 100%;" />
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">A/C</div>
													<div class="col-md-4">
														<select id="cmbacc1" name="cmbacc1" style="width: 100%;"
															value='<s:property value="cmbacc1"/>'></select> <input
															type="hidden" id="hidcmbacc1" name="hidcmbacc1"
															value='<s:property value="hidcmbacc1"/>' />
													</div>
												</div>
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<input type="text" name="txtacc1" id="txtacc1"
															value='<s:property value="txtacc1"/>'
															style="width: 100%;" />
													</div>
												</div>
												<div class="row">
													<div class="col-md-3">Currency</div>
													<div class="col-md-4">
														<select id="cmbaccCurrency" name="cmbaccCurrency"
															style="width: 100%;"
															value='<s:property value="cmbaccCurrency"/>'></select> <input
															type="hidden" id="hidcmbaccCurrency"
															name="hidcmbaccCurrency"
															value='<s:property value="hidcmbaccCurrency"/>' />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>

					</div>
					<div class="row" style="padding: 0.5em; display: none;">
						<div class="col-md-6">
							<div class="panel panel-default" style="font-size: 1em;">
								<div class="panel-heading">Last Modified</div>
								<div class="panel-body">
									<div class="row" style="padding: 0.3em;">
										<div class="col-md-1">By</div>
										<div class="col-md-2">
											<input type="text" name="txtmodifiedby" id="txtmodifiedby"
												value='<s:property value="txtmodifiedby"/>'
												style="width: 100%;">
										</div>
										<div class="col-md-1">On</div>
										<div class="col-md-2">

											<div id="jqxmodifieddate" name="txtmodifieddate"
												value='<s:property value="txtmodifieddate"/>'></div>

										</div>
										<div class="col-md-6" style="text-align: right;">
											<input type="button" class="btn btn-info" value="History">
										</div>
									</div>
									<div class="row">
										<div class="col-md-1">Comments</div>
										<div class="col-md-11">
											<textarea rows="3" style="width: 100%;"
												name="txtmodifiedcomments" id="txtmodifiedcomments"></textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- container-fluid -->
			</div>
			<!-- hidden-scrollbar -->

			<br /> <input type="hidden" id="mode" name="mode"
				value='<s:property value="mode"/>' /> <input type="hidden"
				id="masterdoc_no" name="masterdoc_no"
				value='<s:property value="masterdoc_no"/>' /> <input type="hidden"
				id="deleted" name="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" id="msg" name="msg"
				value='<s:property value="msg"/>' /> <input type="hidden"
				id="txtroomno" name="txtroomno"
				value='<s:property value="txtroomno"/>' /> <input type="hidden"
				id="splgridlength" name="splgridlength" /> <input type="hidden"
				id="accgridlength" name="accgridlength" /> <input type="hidden"
				id="selectedfurgridlength" name="selectedfurgridlength" /> <input
				type="hidden" id="txtroomid" name="txtroomid" /> <input
				type="hidden" id="pmode" name="pmode"
				value='<s:property value="pmode"/>' /> <input type="hidden"
				id="owacno" name="owacno" value='<s:property value="owacno"/>' /> <input
				type="hidden" id="sysgenid" name="sysgenid"
				value='<s:property value="sysgenid"/>' />
				<input type="hidden" id="pavail" name="pavail"/>

		</form>
	</div>

	<!-- <div id="roomwindow">
		<div></div>
	</div> -->
	<div id="ownersearchwindow">
		<div></div>
	</div>
	<div id="areainfowindow">
		<div></div>
	</div>
	<div id="ptytypesearchwindow">
		<div></div>
	</div>
	<div id="unittypesearchwindow">
		<div></div>
	</div>
	<div id="refnosearchwindow">
		<div></div>
	</div>
	<div id="usearchwindow">
		<div></div>
	</div>
	<div id="salesmansearchwindow">
		<div></div>
	</div>


	<!-- Save succesfully modal -->
	<div class="modal fade" id="ignismyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="thank-you-pop">
						<img
							src="http://goactionstations.co.uk/wp-content/uploads/2017/03/Green-Round-Tick.png"
							alt="">
						<h1>Save Successfuly!</h1>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							aria-label="">
							<span>close</span>
						</button>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Save succesfully modal -->

	<!-- rooms modal -->
	<div class="modal fade" id="roomfurnitureModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">

					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
					<h4>Rooms -Furniture & Fixtures</h4>
				</div>

				<div class="modal-body">
					<div id="accordion"></div>
				</div>

			</div>
		</div>
	</div>

	<!-- rooms modal -->
</body>
</html>