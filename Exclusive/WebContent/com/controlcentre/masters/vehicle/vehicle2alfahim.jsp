<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="tab.css" />
<jsp:include page="tab.jsp" />
<style>
form label.error {
color:red;
  font-weight:bold;

}
  .sep {
        border-bottom:1px solid black;
    }
    .alignright{
    
    text-align:
    }
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
document.getElementById("lbllastsrvkm").style.display="none";			//Hiding Last Service Km Label
		document.getElementById("last_srvc_km").style.display="none";			//Hiding Last Service Km
	document.getElementById("fleetwarning").style.display="none";
		document.getElementById("releasesave").style.display="none";
		$("#releasefleet").attr("disabled", true); 
		$("#cmbrlsbranch").attr("disabled", true); 
		$("#cmbrlsloc").attr("disabled", true); 
		$("#cmbrentalstatus").attr("disabled", true); 
		//$('#releasedate').jqxDateTimeInput({ disabled: true}); 
			 $("#releasetime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });

  	  $("#jqxDate1").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  

		$("#jqxPurchaseDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxFinRegDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxFinRelDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxOtherRegExp").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxOtherInsExp").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy"	,value:null});
		$("#jqxWrntyFrmDate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxWrntyToDate").jqxDateTimeInput({width : '125px',	height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#jqxLstSrvcDate").jqxDateTimeInput({	width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		$("#releasedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy",value:null});
		
		//$('#jqxFinRelDate').jqxDateTimeInput('hideCalendar'); 
		   $('#dealerWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#dealerWindow').jqxWindow('close');
		   $('#financierWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#financierWindow').jqxWindow('close');
		   $('#insuranceWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#insuranceWindow').jqxWindow('close');
		   $('#specwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#specwindow').jqxWindow('close'); 
		   if(document.getElementById("mode").value=="A"){
			   changeDate();   
		   }
		   
		   $('#jqxFinRegDate').on('change', function (event) 
			   		 {  
			   		   
			   		     changeDate();
			   		 });
		   $('#jqxPurchaseDate').on('change', function (event) 
			   		 {  
			   		    var purdate= $('#jqxPurchaseDate').jqxDateTimeInput('getDate');
			   		 $('#jqxWrntyFrmDate ').jqxDateTimeInput('setDate', new Date(purdate));
			   		 });
		 /*   $('#jqxWrntyToDate').on('change', function (event) 
			   		 {  
			   		
			   			 var fromdate= new Date($('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate')).getMonth();
			   			 var todate= new Date($('#jqxWrntyToDate ').jqxDateTimeInput('getDate')).getMonth();
			   		 var diff=todate-fromdate;
			   		 var diff1=$('#jqxWrntyToDate ').jqxDateTimeInput('getDate')-$('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate');
			   		alert(diff1);
			   		 if(new Date($('#jqxWrntyToDate ').jqxDateTimeInput('getDate'))<new Date($('#jqxWrntyFrmDate ').jqxDateTimeInput('getDate'))){
			   			 document.getElementById("errormsg").innerText="To Date cannot be Less than From Date";
			   			// document.getElementById("warranty_period").value="";
			   			 return false;
			   		 }
			   		 document.getElementById("errormsg").innerText="";
			   		 document.getElementById("warranty_period").value=diff;x`
			   		 
			   		 }); */
		  //getAuth();
			 getTestPlateCode();

		    getTestModel();
		   
		   getTestLocation(); 

		    $('#mortgaged').dblclick(function(){
				
			    $('#financierWindow').jqxWindow('open');
			$('#financierWindow').jqxWindow('focus');
			financierSearchContent('mortgagedGrid.jsp?', $('#financierWindow'));
				 
				 });
				 
	});
	  function getMortgaged(event){
       	
        var x= event.keyCode;
        if(x==114){
      	 //alert("here");
       	/*  var url=document.URL;
		     var reurl=url.split("com/"); */
		     financierSearchContent('mortgagedGrid.jsp');
        }
        else{
         }
        }
	function changeDate(){
		  var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
 		     var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
 		     var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()-1));
 		     $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
 		     var insexp1=new Date(new Date(new Date(finregdate).setMonth(finregdate.getMonth()+13)));
 		     var insexp2=new Date(new Date(insexp1).setDate(insexp1.getDate()-1));
 		    $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(insexp2));
	  }
	 function funSearchLoad(){
			changeContent('masterSearch.jsp', $('#window')); 
		 }
	  function dealerSearchContent(url) {
		  $('#dealerWindow').jqxWindow('open');
			 $.get(url).done(function (data) {
				// alert(data);
			$('#dealerWindow').jqxWindow('setContent', data);
		}); 
		}
	
     function funSearchdblclick(){
       	 //alert("here");

		//  $('#txtaccname').dblclick(function(){
			var url=document.URL;
			     var reurl=url.split("com/");
			  dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
			//  });  
	}
    function getDealer(event){
   	
         var x= event.keyCode;
         if(x==114){
       	 //alert("here");
        	 var url=document.URL;
		     var reurl=url.split("com/");
		  dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
         }
         else{
          }
         }
    function financierSearchContent(url) {
		   $('#financierWindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				// alert(data);
				
			$('#financierWindow').jqxWindow('setContent', data);
		}); 
		}
     function specSearchContent(url) {
		   $('#specwindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				// alert(data);
				
			$('#specwindow').jqxWindow('setContent', data);
		}); 
		}
  function funFinSearchdblclick(){
    	// alert("here");

		//  $('#txtaccname').dblclick(function(){
			 var url=document.URL;
		     var reurl=url.split("com/");
			  financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
			//  });  
	}
 function getFin(event){
	
      var x= event.keyCode;
      if(x==114){
    	 //alert("here"); 
    	 var url=document.URL;
		     var reurl=url.split("com/");
			  financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
      }
      else{
       }
      }
 function insuranceSearchContent(url) {
	   $('#insuranceWindow').jqxWindow('open');

		 $.get(url).done(function (data) {
			// alert(data);
		$('#insuranceWindow').jqxWindow('setContent', data);
	}); 
	}
function funInsurSearchdblclick(){
	// alert("here");

	//  $('#txtaccname').dblclick(function(){
		 var url=document.URL;
		     var reurl=url.split("com/");
		  insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
		//  });  
}
function getInsurance(event){

var x= event.keyCode;
if(x==114){
	 //alert("here");
	  var url=document.URL;
		     var reurl=url.split("com/");
	 insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
}
else{
 }
}



/* 	function getDealer(event){
			 var x= event.keyCode;
			 if(x==114){
			  $('#accountWindow').jqxWindow('open');
	  	    $('#accountWindow').jqxWindow('focus');
			 }
			 else{
				 }
			 }  */
		
	
	function funReadOnly() {
		 $('#frmVehicle input').attr('readonly', true);
		 $('#frmVehicle select').attr('disabled', true);
		 $('#insurmember').attr('readonly',true);
		 $('#jqxDate1').jqxDateTimeInput({ disabled: true}); 
		 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxFinRegDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxFinRelDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: true});
		 $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: true});
		 $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
		 $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true}); 
		 $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: true}); 
		 $('#releasedate').jqxDateTimeInput({ disabled: true}); 
		 $('#releasetime').jqxDateTimeInput({ disabled: true}); 
		 getAuth();
		getBrand();
		//getPlateCode();
		getGroup();
		//getModel();
		getYOM();
		getColor();
		getFinancier();
		getBrch();
		showRelease(); 
		getStatus();
		//getLocation();
/* 		document.getElementById("frmVehicle").disabled=true;
		document.getElementById("btnrelease").disabled=false; */
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function showRelease(){
		//$("#aststatus").attr("disabled", false); 
		 var temp=$("#aststatus").val();
		if(temp=="INDUCTED"){
			//document.getElementById("releaseid").style.display="block";
			/* var temp=document.getElementById("fleetno").value;
			$('#releasefleet').val(temp); */
			document.getElementById("btnrelease").value="To Be Released";
			/* document.getElementById("releasfuel").value=$("#cmbfuel option:selected").text();
			document.getElementById("releasekm").value=document.getElementById("current_km").value; */
		}
		else if(temp=="LIVE"){
			/* document.getElementById("btnrelease").value="Released Fleet";
			document.getElementById("btnrelease").disabled=true; */
			document.getElementById("btnrelease").style.display="none";
			document.getElementById("releasesave").style.display="none";
		}
		else{
			document.getElementById("btnrelease").disabled=true;
		}
			//document.getElementById("releaseid").style.display="none";
		//$("#aststatus").attr("disabled", true);
	}
	function funRelease(){
		
		$('#mode').val("R");
		$("#cmbrlsbranch").attr("disabled", false); 
		var testfleet=document.getElementById("releasefleet").value;
		var testbranch=document.getElementById("cmbrlsbranch").value;
		var testloc=document.getElementById("cmbrlsloc").value;
		var testkm=document.getElementById("releasekm").value;
		var testfuel=document.getElementById("releasefuel").value;
		
		if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
			document.getElementById("fleetwarning").style.display="block";
			return false;
		}
		else{
			document.getElementById("fleetwarning").style.display="none";
			 $('#cmbfuel').attr('disabled', false); 
			 if(document.getElementById("releasefleet").value<=0){
				 return false;
			 }
			 $('#jqxDate1').jqxDateTimeInput({disabled:false});
			$('#jqxPurchaseDate').jqxDateTimeInput({disabled:false});
			$('#jqxFinRegDate').jqxDateTimeInput({disabled:false});
			$('#jqxFinRelDate').jqxDateTimeInput({disabled:false});
			$('#jqxOtherRegExp').jqxDateTimeInput({disabled:false});
			$('#jqxOtherInsExp').jqxDateTimeInput({disabled:false});
			$('#jqxWrntyFrmDate').jqxDateTimeInput({disabled:false});
			$('#jqxWrntyToDate').jqxDateTimeInput({disabled:false});
			$('#jqxLstSrvcDate').jqxDateTimeInput({disabled:false});
			document.getElementById("frmVehicle").submit();
			$("#cmbrlsbranch").attr("disabled", true); 
			 $('#cmbfuel').attr('disabled', true); 
			
		}
		
	}
	function funEnable(){
		document.getElementById("btnrelease").style.display="none";
		document.getElementById("releasesave").style.display="block";
		$("#releasefleet").attr("disabled", false); 
		$("#cmbrlsbranch").attr("disabled", false); 
		$("#cmbrlsloc").attr("disabled", false); 
		$("#cmbrentalstatus").attr("disabled", false); 
		$("#cmbrentalstatus").val("R");
		$('#releasedate').jqxDateTimeInput({ disabled: false});
		$('#releasetime').jqxDateTimeInput({ disabled: false});
		 $("#releasekm").prop("readonly", true);
		$("#releasefuel").prop("readonly", true); 
		$("#cmbrlsbranch").attr("disabled", true); 
		if(document.getElementById("aststatus").value=='INDUCTED'){
			//alert("INSIDE");
			document.getElementById("releasekm").value=document.getElementById("current_km").value;
			document.getElementById("releasefuel").value=$("#cmbfuel option:selected").text();
			$('#cmbrlsbranch').val($('#cmbavail_br1').val());
			getLocation($('#cmbrlsbranch').val());
		}
		
	}
	function getTestPlateCode(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var plateItems = items[0].split(",");
				var plateIdItems = items[1].split(",");
				var optionsplate = '<option value="">--Select--</option>';
				for (var i = 0; i < plateItems.length; i++) {
					optionsplate += '<option value="' + plateIdItems[i] + '">'
							+ plateItems[i] + '</option>';
				}
				$("select#cmbplate").html(optionsplate);
			 	 if ($('#hidcmbplate').val() != null) {
					$('#cmbplate').val($('#hidcmbplate').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
		x.send();
	}
	
	function funRemoveReadOnly() {
		$('#frmVehicle input').attr('readonly', false);
		$('#frmVehicle select').attr('disabled', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#docno').attr('readonly', true);
		$('#dealer').attr('readonly', true);
		$('#financier').attr('readonly', true);
		$('#insurance_comp').attr('readonly', true);
		$('#mortgaged').attr('readonly', true);
		 $('#jqxDate1').jqxDateTimeInput({ disabled: false}); 
		 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxFinRegDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxFinRelDate').jqxDateTimeInput({ disabled: false});
		 $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: false});
		 $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: false});
		// $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
		// $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false}); 
		 $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: false}); 
		 $("#releasefleet").attr("disabled", true); 
			$("#cmbrlsbranch").attr("disabled", true); 
			$("#cmbrlsloc").attr("disabled", true); 
			$("#cmbrentalstatus").attr("disabled", true); 
			$('#releasedate').jqxDateTimeInput({ disabled: true});
			$('#releasetime').jqxDateTimeInput({ disabled: true});
			$("#releasekm").attr("readonly",true);
			$("#releasefuel").attr("readonly", true);
		/*  $('#releasedate').jqxDateTimeInput({ disabled: false}); 
		 $('#releasetime').jqxDateTimeInput({ disabled: false});  */
		 if(document.getElementById("mode").value=='A'){
			 $("#jqxSpecification").jqxGrid("clear");
	    	 $("#jqxSpecification").jqxGrid("addrow", null, {});
	    	 $("#jqxFinRegDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxPurchaseDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxFinRelDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#releasedate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxWrntyFrmDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxWrntyToDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#jqxLstSrvcDate").jqxDateTimeInput('setDate', new Date());
	    	 $("#releasetime").jqxDateTimeInput('setDate', new Date());
	    	 changeDate(); 
			 document.getElementById("accu_dep").value="0";
		 }
if(document.getElementById("cmbbrand").value!=""){
    getModel(document.getElementById("cmbbrand").value);
   }
	$('#fleetno').attr('readonly', true);
	$('#insurmember').attr('readonly',true);
	}
	function getAuth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var authItems = items[0].split(",");
				var authIdItems = items[1].split(",");
				var optionsauth = '<option value="">--Select--</option>';
				for (var i = 0; i < authItems.length; i++) {
					optionsauth += '<option value="' + authIdItems[i] + '">'
							+ authItems[i] + '</option>';
				}
				$("select#cmbauthority").html(optionsauth);
				if ($('#hidcmbauthority').val() != null) {
					$('#cmbauthority').val($('#hidcmbauthority').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getAuthority.jsp", true);
		x.send();
	}
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#cmbveh_color").html(optionscolor);
				if ($('#hidcmbveh_color').val() != null) {
					$('#cmbveh_color').val($('#hidcmbveh_color').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getColor.jsp", true);
		x.send();
	}
	function getPlateCode(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var plateItems = items[0].split(",");
				var plateIdItems = items[1].split(",");
				var optionsplate = '<option value="">--Select--</option>';
				if(plateItems!=''){
				for (var i = 0; i < plateItems.length; i++) {
					optionsplate += '<option value="' + plateIdItems[i] + '">'
							+ plateItems[i] + '</option>';
				}
				}
				$("select#cmbplate").html(optionsplate);
			 	/* if ($('#hidcmbplate').val() != null) {
					$('#cmbplate').val($('#hidcmbplate').val());
				} */ 
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getPlateCode.jsp?id="+value, true);
		x.send();
	}
	function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#cmbgroup").html(optionsgroup);
				
				if ($('#hidcmbgroup').val() != null) {
					$('#cmbgroup').val($('#hidcmbgroup').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	function getLevel(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				$('#group_name').val(items);
				
			} else {
			}
			
		}
		x.open("GET", "../vehiclemaster/getLevel.jsp?id="+value, true);
		x.send();
	}
	function getBrand() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbbrand").html(optionsbrand);
				if ($('#hidcmbbrand').val() != null) {
					$('#cmbbrand').val($('#hidcmbbrand').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getBrand.jsp", true);
		x.send();
	}
	function getTestModel(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="">--Select--</option>';
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != null) {
					$('#cmbmodel').val($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
		x.send();
	}
	function getModel(value) {
		//document.getElementById("fleetname").value="";
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				//alert("Response"+x.responseText);
				items = items.split('####');
				var modelItems = items[0].split(",");
				//alert("=="+modelItems+"==");
				var modelidItems = items[1].split(",");
				//alert("=="+modelidItems+"==");
				var optionsmodel = '<option value="">--Select--</option>';
				if(modelItems!=''){
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != null) {
					$('#cmbmodel').val($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getModel.jsp?id="+value, true);
		x.send();
	}
	function getYOM() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var yomItems = items[0].split(",");
				var yomidItems = items[1].split(",");
				var optionsyom = '<option value="">--Select--</option>';
				for (var i = 0; i < yomItems.length; i++) {
					optionsyom += '<option value="' + yomidItems[i] + '">'
							+ yomItems[i] + '</option>';
				}
				$("select#cmbyom").html(optionsyom);
				if ($('#hidcmbyom').val() != null) {
					$('#cmbyom').val($('#hidcmbyom').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getYOM.jsp", true);
		x.send();
	}
	function getFinancier() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var finItems = items[0].split(",");
				var finidItems = items[1].split(",");
				var optionsfin = '<option value="">--Select--</option>';
				for (var i = 0; i < finItems.length; i++) {
					optionsfin += '<option value="' + finidItems[i] + '">'
							+ finItems[i] + '</option>';
				}
				$("select#cmbfinancer").html(optionsfin);
				if ($('#hidcmbfinancer').val() != null) {
					$('#cmbfinancer').val($('#hidcmbfinancer').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getFinancier.jsp", true);
		x.send();
	}
	function getBrch() {
		var x = new XMLHttpRequest();
		var items, brchItems, currItems;
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmbavail_br1").html(optionsbrch);
				$("select#cmbrlsbranch").html(optionsbrch);
				if ($('#hidcmbavail_br1').val() != null) {
					$('#cmbavail_br1').val($('#hidcmbavail_br1').val());
				}
				if ($('#hidcmbrlsbranch').val() != null) {
					$('#cmbrlsbranch').val($('#hidcmbrlsbranch').val());
				}
			} else {
			}
		}
		x.open("GET", "../vehiclemaster/getBranch.jsp", true);
		x.send();
	}
	function getLocation(value)
	{
		//alert(here);
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
						//alert(items);
				 	items=items.split('***');
			        var locationItems=items[0].split(",");
			        var locationidItems=items[1].split(",");
			        	var optionslocation = '<option value="">--Select--</option>';
			       for ( var i = 0; i < locationItems.length; i++) {
			    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
			        }
			       $("select#cmbrlsloc").html(optionslocation);
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbrlsloc').val() != null) {
				$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getLocation.jsp?id="+value,true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}
	function getTestLocation(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
						//alert(items);
				 	items=items.split('***');
			        var locationItems=items[0].split(",");
			        var locationidItems=items[1].split(",");
			        	var optionslocation = '<option value="">--Select--</option>';
			       for ( var i = 0; i < locationItems.length; i++) {
			    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
			        }
			       $("select#cmbrlsloc").html(optionslocation);
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbrlsloc').val() != null) {
				$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getTestLocation.jsp",true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}

	function getStatus()
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var status=items[0].split(",");
			        var stdesc=items[1].split(",");
			        	var optionsstatus = '<option value="">--Select--</option>';
			       for ( var i = 0; i < stdesc.length; i++) {
			    	   optionsstatus += '<option value="' + status[i] + '">' + stdesc[i] + '</option>';
			        }
			       
			       $("select#cmbstatus").html(optionsstatus);
			       
				   //	$('#accno').val($('#accnohidden').val()) ;
				   	if ($('#hidcmbstatus').val() != null) {
				$('#cmbstatus').val($('#hidcmbstatus').val());
			}
				}
			else
				{
				}
		}
		x.open("GET","../vehiclemaster/getStatus.jsp",true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		/* if($('#hidreleasedate').val()){
			$("#releasedate").jqxDateTimeInput('val', $('#hidreleasedate').val());
		}
 */
		if($('#hidreleasetime').val()){
			$("#releasetime").jqxDateTimeInput('val', $('#hidreleasetime').val());
		}
		if ($('#hidcmbfueltype').val() != null) {
			$('#cmbfueltype').val($('#hidcmbfueltype').val());
		}
	/* 	if($('#hidjqxDate1').val()){
			$("#jqxDate1").jqxDateTimeInput('val', $('#hidjqxDate1').val());
		}
		if($('#hidjqxPurchaseDate').val()){
			$("#jqxPurchaseDate").jqxDateTimeInput('val', $('#hidjqxPurchaseDate').val());
		}
		if($('#hidjqxFinRegDate').val()){
			$("#jqxFinRegDate").jqxDateTimeInput('val', $('#hidjqxFinRegDate').val());
		}
		if($('#hidjqxFinRelDate').val()){
			$("#jqxFinRelDate").jqxDateTimeInput('val', $('#hidjqxFinRelDate').val());
		}
		if($('#hidjqxOtherRegExp').val()){
			$("#jqxOtherRegExp").jqxDateTimeInput('val', $('#hidjqxOtherRegExp').val());
		}
		if($('#hidjqxOtherInsExp').val()){
			$("#jqxOtherInsExp").jqxDateTimeInput('val', $('#hidjqxOtherInsExp').val());
		}
		if($('#hidjqxWrntyFrmDate').val()){
			$("#jqxWrntyFrmDate").jqxDateTimeInput('val', $('#hidjqxWrntyFrmDate').val());
		}
		if($('#hidjqxWrntyToDate').val()){
			$("#jqxWrntyToDate").jqxDateTimeInput('val', $('#hidjqxWrntyToDate').val());
		}
		if($('#hidjqxLstSrvcDate').val()){
			$("#jqxLstSrvcDate").jqxDateTimeInput('val', $('#hidjqxLstSrvcDate').val());
		}
	 */	if ($('#hidpurchase').val() != null) {
			$('#purchase').val($('#hidpurchase').val());
		}
	 	if ($('#hidcmbplate').val() != null) {
			$('#cmbplate').val($('#hidcmbplate').val());
		} 
		/*if ($('#hidcmbmodel').val() != null) {
			$('#cmbmodel').val($('#hidcmbmodel').val());
		}
		if ($('#hidcmbrlsloc').val() != null) {
			$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
		}   */
		if ($('#hidcmbinsurance_type').val() != null) {
			$('#cmbinsurance_type').val($('#hidcmbinsurance_type').val());
		}
		if ($('#hidcmbfuel').val() != null) {
			$('#cmbfuel').val($('#hidcmbfuel').val());
		}
		/* if ($('#hidcmbrentalstatus').val() != null) {
			$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
			
		} */
		 if ($('#hidcmbrentalstatus').val() != null) {
			$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
			
		} 
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 // document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// alert(document.getElementById("docno").value);
		 
		 if(document.getElementById("docno").value!=''){
			 var docno1=document.getElementById("docno").value.trim();
			 $("#specdiv").load("specificationGrid.jsp?aaa=aaa&docno1="+docno1);
			 //$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1);
			}
	}

	 function funFocus()
	    {
	    	document.getElementById("cmbauthority").focus();
	    		
	    }
	    $(function(){
	        $('#frmVehicle').validate({
	                 rules: {
	                cmbauthority:"required",
	                cmbplate:"required",
	                cmbgroup:"required",
	                //regno:"required",
	                cmbbrand:"required",
	                cmbmodel:"required",
	                cmbyom:"required",
	                cmbavail_br1:"required",
	                purchase:"required",
	                cmbfueltype:"required",
	                fuelcapacity:"required",
	                cmbfuel:"required",
	                purchase_cost:"number",
	                additions:"number",
	                current_km:"required",
	                accu_dep:"required"
	               
	                 
	                 }, 
	        messages:{
	        	cmbauthority:" *",
	        	cmbplate:" *",
	        	cmbgroup:" *",
	        	//regno:" *",
	        	cmbbrand:" *",
	        	cmbmodel:" *",
	        	cmbyom:" *",
	        	cmbavail_br1:" *",
	        	purchase:" *",
	        	cmbfueltype:" *",
	        	fuelcapacity:" *",
	        	cmbfuel:" *",
	        	purchase_cost:"Digits",
	        	additions:"Digits",
	        	current_km:"*",
	        	accu_dep:"*"
	        
	        }
	                 //alert("here");
	        });
	        });
	     function funNotify(){
	    	 if(document.getElementById("cmbfueltype").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Fuel Type is Mandatory";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("cmbfueltype").focus();
	    		 return 0;
	    	 }
	    	 if(document.getElementById("fuelcapacity").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Fuel Capacity is Mandatory";
	    		 document.getElementById("fuelcapacity").focus();
	    		 return 0;
	    	 }
	    	
	    	 if(document.getElementById("cmbfuel").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Fuel is Mandatory";
	    		 document.getElementById("cmbfuel").focus();
	    		 return 0;
	    	 }
	    	 if(document.getElementById("cmbavail_br1").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 $('#servtab').trigger('click');
	    		 document.getElementById("errormsg").innerText="Available Branch is Mandatory";
	    		 document.getElementById("cmbavail_br1").focus();
	    		 return 0;
	    	 }
		 
	    	/*  if(parseFloat(document.getElementById("current_km").value)<parseFloat(document.getElementById("last_srvc_km").value)){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Current KM cannot be less than Last Service KM";
	    		 document.getElementById("current_km").focus();
	    		 return 0;
	    	 } */
	    	 var rows = $("#jqxSpecification").jqxGrid('getrows');
	 		if(!((rows[0].doc_no=="undefined") || (rows[0].doc_no==null) || (rows[0].doc_no==""))){
	     	$('#gridlength').val(rows.length);
	     		//alert($('#gridlength').val());
	     		for(var i=0 ; i < rows.length ; i++){
	 			//	var myvar = rows[i].tarif; 
	 				newTextBox = $(document.createElement("input"))
	 			    .attr("type", "dil")
	 			    .attr("id", "test"+i)
	 			    .attr("name", "test"+i)
	 			    .attr("hidden", "true");
	 				
	 			newTextBox.val(rows[i].doc_no+"::");
	 			
	 			newTextBox.appendTo('form');
	 			
	 				//alert("ddddd"+$("#test"+i).val());
	 			}
	     	}
	 		//alert($('#gridlength').val());
	 		$('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
	 		$('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false});
	 		document.getElementById("errormsg").innerText="";
	    		return 1;
	    		$('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
	    		$('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true});
	     } 
	    function getTotal(){
	    	 var pcost = document.getElementById('purchase_cost').value;
	         var addit = document.getElementById('additions').value;
	         if (pcost == "")
	             pcost = 0;
	         if (addit == "")
	             addit = 0;

	         var result = parseFloat(pcost) + parseFloat(addit);
	         if (!isNaN(result)) {
	             document.getElementById('total').value = result;
	         }	   
	         }
	    function getFleetName(){
	    	//alert("here");
	    	document.getElementById("fleetname").value="";
	    	/* var x = document.getElementById("cmbbrand");
	        var i = x.selectedIndex;
	        var x1=document.getElementById("cmbmodel");
	        var i1=x1.selectedindex;
	        var r=x.options[i].text;
	        var r1=x1.options[i].text; */
	        //alert("***"+r+"***"+r1);
	        var r=$("#cmbbrand option:selected").text();
	        var r1=$("#cmbmodel option:selected").text();
	        document.getElementById("fleetname").value = r+" "+r1;
	    }
function depr_percent(value){
	if(value>100){
		document.getElementById("errormsg").innerText="Depr.Percent Must be less than 100%";
		document.getElementById("depr_perc").focus();
	}else{
		document.getElementById("errormsg").innerText="";	
	}
}
function getWarrantyDate(value){
	
	
	if(value!=''){
	var fvalue=parseInt(value);
		var tempdate= $('#jqxWrntyFrmDate').jqxDateTimeInput('getDate');
		     var finaldate=new Date(new Date(tempdate).setMonth(tempdate.getMonth()+fvalue));
		    // alert(finaldate);
		     $('#jqxWrntyToDate ').jqxDateTimeInput('setDate', new Date(finaldate));
	}
	
}
function getservtab(){
	
	$('#servtab').trigger('click');
	
}
function getspectab(){
	$('#spectab').trigger('click');
}
function checkRegNo(){
	var mode=document.getElementById("mode").value;
	var docno=document.getElementById("docno").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(parseInt(items)>0){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Reg No Already Exists";
				document.getElementById("regno").focus();
				return false;
			}
			document.getElementById("errormsg").innerText="";
		} else {
		}
	}
	x.open("GET", "checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplate").value+"&mode="+mode+"&docno="+docno, true);
	x.send();
}
/* 	function funsavefocus(){
		document.getElementById("releasesave").focus();
	} */
</script>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
 </head>
<body onLoad="setValues();">
	
	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmVehicle" action="saveVehicle" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
				<fieldset><legend>Vehicle Details</legend>
				<table width="100%" cellspacing="0">
					<tr>
						<td width="68" height="24" id="f" style="text-align: right"><div
								align="right">Fleet No</div></td>
						<td colspan="5">
							<input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" 
							style="width: 20%;" value='<s:property value="fleetno"/>'> 
							<input type="text" name="fleetname" id="fleetname" readonly tabindex="-1"
							style="width: 75.5%;" value='<s:property value="fleetname"/>'></td>
						<td align="right">Date</td>
						<td colspan="2" align="left"><div id='jqxDate1'
								name='jqxDate1' value='<s:property value="jqxDate1"/>'></div>
                        </td><input
							type="hidden" id="hidjqxDate1" name="hidjqxDate1"
							value='<s:property value="hidjqxDate1"/>' />
						<td align="left">&nbsp;</td>
						<td width="64" align="right">Doc No</td>
						<td width="168" align="left"><input type="text"
							name="docno" id="docno"  readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
						
					</tr>
					<tr>
					  <td height="24" align="right">Authority</td>
					  <td><select name="cmbauthority" id="cmbauthority"
							value='<s:property value="cmbauthority"/>' style="width:81%;" onchange="getPlateCode(this.value);">
                        <option value="">--Select--</option>
                      </select>
				      </td><input type="hidden" id="hidcmbauthority" name="hidcmbauthority"
							value='<s:property value="hidcmbauthority"/>' />
					  <td align="right">Plate Code</td>
					  <td><select name="cmbplate" id="cmbplate"
							value='<s:property value="cmbplate"/>' style="width:75%;">
                        <option>--select--</option>
                      </select>
				      <input type="hidden" id="hidcmbplate" name="hidcmbplate"
							value='<s:property value="hidcmbplate"/>' /></td>
					  <td align="right">Reg No</td>
					  <td width="146" align="left"><input type="text" name="regno" id="regno"
							style="width:89%;" value='<s:property value="regno"/>' autocomplete="off" onblur="checkRegNo();"></td>
					  <td align="right">Group</td>
					  <td align="left"><select name="cmbgroup"
							id="cmbgroup" value='<s:property value="cmbgroup"/>' style="width:74%;" onchange="getLevel(this.value);">
                        <option>--Select--</option>
                      </select>
				      </td><input type="hidden" id="hidcmbgroup" name="hidcmbgroup"
							value='<s:property value="hidcmbgroup"/>' />
					  <td align="right">Level</td>
					  <td align="left"><input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>' tabindex="-1"></td>
					  <td align="right">&nbsp;</td>
					  <td align="left">&nbsp;</td>
				  </tr>
					<tr>
						<td height="24" align="right"><span style="text-align: right">Brand</span></td>
						<td width="142"><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:81%;" onchange="getModel(this.value);">
                          <option>--Select--</option>
                        </select>
					  </td><input type="hidden" id="hidcmbbrand" name="hidcmbbrand"
							value='<s:property value="hidcmbbrand"/>' />
						<td width="66" align="right">Model</td>
						<td width="128"><select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' style="width:75%;" onchange="getFleetName();">
                          <option>--Select--</option>
                        </select>
					  <input type="hidden" id="hidcmbmodel" name="hidcmbmodel"
							value='<s:property value="hidcmbmodel"/>' /></td>
						<td width="70" align="right">YoM</td>
						<td align="left"><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>' style="width:91%;">
                          <option>--Select--</option>
                        </select>
					  </td><input type="hidden" id="hidcmbyom" name="hidcmbyom"
							value='<s:property value="hidcmbyom"/>' />
						<td width="70" align="right">Salik Tag</td>
						<td width="166" align="left"><input type="text" id="salik_tag" name="salik_tag"   value='<s:property value="salik_tag"/>' /></td>
						<td width="39" align="right">TC No</td>
						<td width="123" align="left"><input type="text" id="tcno" name="tcno"  value='<s:property value="tcno"/>' /></td>
						<td align="right">&nbsp;</td>
					    <td align="left">&nbsp;</td>
					</tr><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
					
				</table>
<br />

				<ul id="tabs">
					<li><a href="#" name="tab1" id="inductiontab">Induction</a></li>
					<li><a href="#" name="tab2" id="servtab">Services And Other Details</a></li>
					<li><a href="#" name="tab3" id="spectab">Specifications</a>
					  
					
					<input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>' hidden="true"/>
					
					<input type="text" id="interest_amt"  name="interest_amt" value='<s:property value="interest_amt"/>' hidden="true"/>
			
					<input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>' hidden="true"/>
					
					<input type="text" id="no_installments" name="no_installments"
													 value='<s:property value="no_installments"/>' hidden="true"/>
			
														<span style="text-align: right"></span>
														<input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>' hidden="true"/>
														
														<input type="text" id="insured_amt" name="insured_amt"  hidden="true" value='<s:property value="insured_amt"/>'/>
 
					<select name="purchase" id="purchase"  hidden="true"  value='<s:property value="purchase"/>' style="width:89%;">
					  <option>--Select--</option>
					  <option value="Cash" selected>Cash</option>
					  <option value="Credit">Credit</option>
					  </select>
					
					<input type="text" id="premium_perc" name="premium_perc"  hidden="true" value='<s:property value="premium_perc"/>' />
					
					<input type="text" id="premium_amt" name="premium_amt"  hidden="true" value='<s:property value="premium_amt"/>' />
					</li>
				</ul>
				<!-- <iframe  width=1100px height=400px align='center' id='page' ></iframe> -->
				<div id="content">
					<div id="tab1">
						<table width="100%">
							<tr>
									<td width="25%">
                                    <fieldset><legend>Info</legend>
									  <table width="100%" >
									    <tr>
									      <td align="right">&nbsp;Registered Date</td>
									      <td align="left"><div id='jqxFinRegDate'
														name='jqxFinRegDate' value='<s:property value="jqxFinRegDate"/>'></div></td>
									      <input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
								        </tr>
									    <tr>
									      <td align="right">&nbsp;Reg. Expiry</td>
									      <td align="left"><div id='jqxOtherRegExp' name='jqxOtherRegExp'
														value='<s:property value="jqxOtherRegExp"/>'></div></td>
								        </tr>
									    <tr>
									      <td align="right">Insurance Expiry</td>
									      <td align="left"><div id='jqxOtherInsExp' name='jqxOtherInsExp'
														value='<s:property value="jqxOtherInsExp"/>'></div></td>
									        <input type="hidden" name="hidpurchase" id="hidpurchase" value='<s:property value="hidpurchase"/>'>
								        </tr>
									    <tr>
									      <td align="right">Purchase Cost</td>
									      <td align="left"><input type="text" name="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>' style="text-align:right;" onblur="getTotal();" required/></td>
								        </tr>
									    <tr>
									      <td align="right">Additions</td>
									      <td align="left"><input type="text" id="additions" name="additions" value='<s:property value="additions"/>' style="text-align:right;" onblur="getTotal();"/></td>
								        </tr>
									    <tr>
									      <td align="right">Total</td>
									      <td align="left"><input type="text" id="total" name="total" value='<s:property value="total"/>'  style="text-align:right;" readonly/></td><input
													type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate"
													value='<s:property value="hidjqxPurchaseDate"/>' />
								        </tr>
									    <tr>
									      <td align="right">&nbsp;Depr %</td>
									      <td align="left"><input type="text" id="depr_perc" name="depr_perc" value='<s:property value="depr_perc"/>' style="text-align:right;" onblur="depr_percent(this.value);"/></td>
								        </tr>
									    <tr>
									      <td align="right">&nbsp;Accu. Dep.</td>
									      <td align="left"><input type="text" id="accu_dep" name="accu_dep" value='<s:property value="accu_dep"/>' style="text-align:right;" /></td>
								        </tr>
									    <tr>
									      <td align="right">&nbsp;CostTran No</td>
									      <td align="left"><input type="text" id="tran_no" readonly name="tran_no" value='<s:property value="tran_no"/>'  tabindex="-1"/></td>
								        </tr>
									    <tr>
									      <td align="right">VSB No</td>
									      <td align="left"><input type="text" readonly name="insurmember" id="insurmember" value='<s:property value="insurmember"/>' /></td>
								        </tr>
									    <tr>
									      <td align="right">Tracking ID</td>
									      <td align="left"><input type="text" name="trackid" id="trackid" value='<s:property value="trackid"/>' /></td>
								        </tr>
								      </table>
                                      <br />
										<br />
										<br /><br /><br />
										
										
										
										
                                      </fieldset>
								</td>
								<td width="25%"> 
									<fieldset>
									  <legend>Other Info</legend>
										<table width="99%">
											<tr>
											  <td align="right">Dealer</td>
											  <td align="left"><input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' onDblClick="funSearchdblclick();" onKeyDown="getDealer(event);" placeholder="Press F3 to Search"></td>
										  </tr>
											<tr>
											  <td align="right">LPO No</td>
											  <td><input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>'/></td>
										  </tr>
											<tr>
											  <td align="right">Purchase Invoice</td>
											  <td><input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>'/></td>
										  </tr>
											<tr>
											  <td align="right">Purchase Date</td>
											  <td><div id='jqxPurchaseDate' name='jqxPurchaseDate'
														value='<s:property value="jqxPurchaseDate"/>'></div></td>
										  </tr>
											<tr>
												<td align="right">Financer</td>
												<td>
														<input type="text" name="financier" id="financier" value='<s:property value="financier"/>' ondblclick="funFinSearchdblclick();" onkeydown="getFin(event);" placeholder="Press F3 to Search">
												</select> <input type="hidden" id="hidfinancier" name="hidfinancier"
													value='<s:property value="hidfinancier"/>' /></td>
											</tr>
											<tr>
												<td align="right">Release Date</td>
												<td align="left"><div id='jqxFinRelDate' name='jqxFinRelDate'  
														value='<s:property value="jqxFinRelDate"/>'></div></td>
											</tr>
											<tr>
												<td align="right">Insurance Type</td>
												<td><select name="cmbinsurance_type"
													id="cmbinsurance_type" value='<s:property value="cmbinsurance_type"/>' style="width:54%;">
													<option value="">--Select--</option>
												  <option value="Comprehensive">Comprehensive</option>
												  <option value="3rdParty">3rd Party</option>
											    </select></td>
											</tr>
											<tr>
												<td align="right">&nbsp;&nbsp;Insurance Comp</td>
												<td><input type="text" id="insurance_comp" name="insurance_comp" placeholder="Press F3 to Search" 
													 value='<s:property value="insurance_comp"/>' ondblclick="funInsurSearchdblclick();" onkeydown="getInsurance(event);"/></td>
											</tr>
											<tr>
												<td width="41%" align="right">Policy No</td>
												<td width="59%"><input type="text" id="policy_no" name="policy_no" value='<s:property value="policy_no"/>' onblur="getservtab();" /></td><input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate"
													value='<s:property value="hidjqxFinRegDate"/>' />
											</tr>
											<tr>
											  <td align="right">File No</td>
											  <td><input type="text" name="fileno" id="fileno" value='<s:property value="fileno"/>' /></td>
										  </tr>
										  <tr>
											  <td align="right">Mortgaged To</td>
											  <td><input type="text" name="mortgaged" id="mortgaged" value='<s:property value="mortgaged"/>' placeholder="Press F3 to Search" readonly onkeydown="getMortgaged(event);"/></td>
                                              <input type="hidden" name="hidmortgaged" id="hidmortgaged" value='<s:property value="hidmortgaged"/>'/>
										  </tr>
                                            
										</table>
									
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
										
                                       
                                        
                                        
                                        
									</fieldset>
								</td>
<input type="hidden" name="hidinsurance_comp" id="hidinsurance_comp" 
													 value='<s:property value="hidinsurance_comp"/>'>
                                                     <input
													type="hidden" id="hidjqxFinRelDate" name="hidjqxFinRelDate"
													value='<s:property value="hidjqxFinRelDate"/>' /><input type="hidden" id="hidcmbinsurance_type"
													name="hidcmbinsurance_type"
													value='<s:property value="hidcmbinsurance_type"/>' /><input
													type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp"
													value='<s:property value="hidjqxOtherRegExp"/>' />
                                                    <input
													type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp"
													value='<s:property value="hidjqxOtherInsExp"/>' />
								<td width="25%">
                                <fieldset id="releaseid"><legend>Fleet Release Info</legend>
								  <table width="100%">
								    <tr>
								      <td colspan="3" align="center"><input type="button" name="releasesave" id="releasesave" class="myButton" value="Save" onClick="funRelease();"><input type="button" name="btnrelease" id="btnrelease" class="myButton"  value="Release" onClick="funEnable();"></td>
							        </tr>
								    <tr>
								      <td width="36%" align="right">Fleet No</td>
								      <td colspan="2" align="left"><input type="text" name="releasefleet" id="releasefleet" value='<s:property value="releasefleet"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Branch</td>
								      <td colspan="2" align="left"><select name="cmbrlsbranch"  id="cmbrlsbranch" value='<s:property value="cmbrlsbranch"/>' onChange="getLocation(this.value);" style="width:50.5%;"  >
								        <option value="">--Select--</option>
								        </select>
                                      <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>' ></td>
							        </tr>
								    <tr>
								      <td align="right">Location</td>
								      <td colspan="2" align="left"><select name="cmbrlsloc" id="cmbrlsloc" value='<s:property value="cmbrlsloc"/>' style="width:50%;" >
								        <option value="">--Select--</option>
								        </select>
							          <input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Rental Status</td>
								      <td colspan="2" align="left"><select name="cmbrentalstatus" id="cmbrentalstatus" value='<s:property value="cmbrentalstatus"/>' style="width:50%;">
 										<option value="R" >Rental</option>
								        <option value="L">Lease</option>
								        <option value="LM">Limousine</option>
								        <option value="A">All</option>
								        </select>
                                      <input type="hidden"  name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Date</td>
								      <td colspan="2" align="left"><div id="releasedate" name="releasedate" value='<s:property value="releasedate"/>'> </td>
                                      <input type="hidden" name="hidreleasedate" id="hidreleasedate" value='<s:property value="hidreleasedate"/>'>
							        </tr>
								    <tr>
								      <td align="right">Time</td>
								      <td colspan="2" align="left"><div id="releasetime" name="releasetime" value='<s:property value="releasetime"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">KM</td>
								      <td width="32%" align="left"><input type="text" name="releasekm" id="releasekm" value='<s:property value="releasekm"/>' tabindex="-1" readonly></td>
								      <td width="32%" align="left">&nbsp;</td>
							        </tr>
								    <tr>
								      <td align="right">Fuel</td>
								      <td align="left"><input type="text" name="releasefuel" id="releasefuel" value='<s:property value="releasefuel"/>' tabindex="-1" readonly></td>
								      <td align="left">&nbsp;</td>
							        </tr>
								    <tr>
								      <td align="right">Op. Status</td>
								      <td align="left"><input type="text"
							name="opstatus" id="opstatus"  value='IN' tabindex="-1" disabled="true"></td>
								      <td align="left">&nbsp;</td>
							        </tr>
								    <tr>
								      <td align="right">Ast status</td>
								      <td align="left"><input type="text"
							name="aststatus" id="aststatus"  style="align: left;" value='<s:property value="aststatus"/>'  tabindex="-1" ></td>
								      <td align="left">&nbsp;</td>
							        </tr>
								    <tr>
								      <td colspan="3" align="right"><div id="fleetwarning" align="center" style="color:red;font-weight:bold;">All fields are Mandatory</div></td>
							        </tr>
								    
						          </table>
                                  <br /><br /><br /><br />
										
										
                                </fieldset>
                                </td>
							</tr>
						</table>
					</div>

					<div id="tab2">
						<table width="100%">
							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Vehicle Info</legend>
										<table width="100%">
											<tr>
												<td width="7%" height="28" align="right">Engine No</td>
												<td width="10%" align="left"><input type="text"
													id="engine_no" name="engine_no" value='<s:property value="engine_no"/>'style="text-transform:uppercase;"/></td>
												<td width="5%" align="right" >Chasis No</td>
												<td width="10%" align="left"><input type="text"
													id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>' style="text-transform:uppercase;"/></td>
												<td width="5%" align="right">VIN</td>
											  <td width="11%" ><input type="text"
													name="vin" id="vin" value='<s:property value="vin"/>' /></td>
												<td width="9%" align="right">Fuel Type</td>
												<td width="8%" align="left"><select name="cmbfueltype" id="cmbfueltype" >
												  <option value="">--Select--</option>
												  <option value="P">Petrol</option>
												  <option value="D">Diesel</option>
											    </select></td>
												<td width="10%" align="right">Fuel Tank Capacity</td>
												<td width="10%" align="left"><input type="text" name="fuelcapacity" id="fuelcapacity" value='<s:property value="fuelcapacity"/>'/></td>
												<td width="3%" align="right">Color</td>
												<td width="12%" align="left"><select
													name="cmbveh_color" id="cmbveh_color" value='<s:property value="cmbveh_color"/>'>
														<option>--Select--</option>
												</select> </td>
												<input type="hidden" name="hidcmbveh_color" id="hidcmbveh_color" value='<s:property value="hidcmbveh_color"/>'>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Warranty Info</legend>
										<table width="100%">
											<tr>
												<td width="9%" height="28" align="right">Warranty
													Period</td>
												<td width="9%" align="left"><input type="text"
													id="warranty_period" name="warranty_period" value='<s:property value="warranty_period"/>' onblur="getWarrantyDate(this.value);"/></td>
												<td width="7%" align="right">From Date</td>
												<td width="8%" align="left"><div id='jqxWrntyFrmDate'
														name='jqxWrntyFrmDate'
														value='<s:property value="jqxWrntyFrmDate"/>'></div>
														 </td><input
													type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate"
													value='<s:property value="hidjqxWrntyFrmDate"/>' />
												<td width="9%" align="right">To Date</td>
												<td width="12%" align="left"><div id='jqxWrntyToDate'
														name='jqxWrntyToDate'
														value='<s:property value="jqxWrntyToDate"/>'></div> 
														</td><input
													type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate"
													value='<s:property value="hidjqxWrntyToDate"/>' />
												<td width="8%" align="right">Warranty KM</td>
												<td width="38%" align="left"><input type="text"
													name="warranty_km" id="warranty_km"  value='<s:property value="warranty_km"/>' style="text-align:right;"/></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td colspan="8" align="right"></td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Service Info</legend>
										<table width="100%">
											<tr>
												<td width="106" height="28" align="right">Service Duration (KM)</td>
												<td width="116" align="left"><input type="text"
													id="service_km" name="service_km" value='<s:property value="service_km"/>' style="text-align:right;"/></td>
												<td width="79" align="right">Last Srvc. Date</td>
												<td width="130" align="left">
														<div id='jqxLstSrvcDate'
														name='jqxLstSrvcDate'
														value='<s:property value="jqxLstSrvcDate"/>'></div> 
														</td><input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate"
													value='<s:property value="hidjqxLstSrvcDate"/>' />
												<td width="105" align="right"><label id="lbllastsrvkm">Last Service KM</label></td>
												<td width="400" align="left"><input type="text"
													id="last_srvc_km" name="last_srvc_km" value='<s:property value="last_srvc_km"/>' style="text-align:right;"/></td>
												<td width="109" align="right">&nbsp;</td>
												<td width="185" align="left">&nbsp;</td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
									  <legend>Release Info</legend>
										<table width="100%">
											<tr>
												<td width="107" height="30" align="right">Current KM</td>
												<td width="149" align="left"><input type="text"
													id="current_km" name="current_km" value='<s:property value="current_km"/>' style="text-align:right;"/></td>
												<td width="45" align="right">Fuel</td>
												<td width="139" align="left"><select name="cmbfuel" 
													id="cmbfuel" value='<s:property value="cmbfuel"/>'><option value=0.000>Level 0/8</option><option value=0.125 selected>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
											    </select>
											    <input type="hidden" id="hidcmbfuel" name="hidcmbfuel"
													value='<s:property value="hidcmbfuel"/>' /></td><input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
											  <td width="88" align="right">Avail. Br.</td>
											<td width="134" align="left"><select
													name="cmbavail_br1" id="cmbavail_br1" value='<s:property value="cmbavail_br1"/>'>
											  </select>
											  <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1"
													value='<s:property value="hidcmbavail_br1"/>' />
											  <input type="hidden" id="tcno2" name="tcno2" style="width: 275px;" value='<s:property value="tcno2"/>'/></td>
											  <td width="251" align="right">Calibration Km</td>
											<td width="503" align="left"><input type="text" name="calibrationkm" id="calibrationkm" value='<s:property value="calibrationkm"/>' style="text-align:right;"  onblur="getspectab();"></td>
											<td width="172" align="left"><select name="branded" id="branded" value='<s:property value="branded"/>' hidden="true">
														
													<option value="Y" selected>Y</option>
													<option value="N">N</option>
											  </select>
											  <input type="hidden" id="hidbranded" name="hidbranded"
													value='<s:property value="hidbranded"/>' />
											  </td>
											  <input type="hidden" name="hidreleasetime" id="hidreleasetime" value='<s:property value="hidreleasetime"/>'>
												<%-- <td width="9%" align="right">Rent Type</td>
												<td width="15%" align="left"><select
													name="cmbrent_type" id="cmbrent_type" value='<s:property value="cmbrent_type"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbrent_type" name="hidcmbrent_type"
													value='<s:property value="hidcmbrent_type"/>' /></td> --%>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
						</table>
					</div>

					<div id="tab3"><table width="100%" >
					<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  <tr><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
    <td><div id="specdiv"><center><jsp:include page="specificationGrid.jsp"></jsp:include></center></div></td>
    </tr>
</table>

						
						
					</div>

				</div>
			</fieldset>
		</form>
<br/>
<div id="dealerWindow">
				<div></div><div></div>
				</div>
<div id="financierWindow">
				<div></div><div></div>
				</div>
<div id="insuranceWindow">
				<div></div><div></div>
				</div>
				<div id="specwindow">
				<div></div>
				</div>
<div id="releaseWindow">
				<div></div><div style="background-color:#E0ECF8;"></div>
				
				</div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="vehicleSearch.jsp"></jsp:include>
	</div></div>
<div id="accountWindow">
	<div class="windowsHead">
	<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Dealer
	</span>
	</div>
	<div class="windowsCont">
	<jsp:include page="../../../search/masterssearch/dealerMSearch.jsp"></jsp:include>
	</div>
	 </div>  
	 <div id="financierWindow">
	<div class="windowsHead">
	<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Financier
	</span>
	</div>
	<div class="windowsCont">
	<jsp:include page="../../../search/masterssearch/financierMSearch.jsp"></jsp:include>
	</div>
	 </div> --%>
	</div>
</body>
</html>