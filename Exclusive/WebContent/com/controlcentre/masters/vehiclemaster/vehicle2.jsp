<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<jsp:include page="tab.css" />
<jsp:include page="tab.jsp" />
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		document.getElementById("releasesave").style.display="none";
		$("#releasefleet").attr("disabled", true); 
		$("#cmbrlsbranch").attr("disabled", true); 
		$("#cmbrlsloc").attr("disabled", true); 
		$("#cmbrentalstatus").attr("disabled", true); 
		$('#releasedate').jqxDateTimeInput({ disabled: true}); 
  	  $("#jqxDate1").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  

		$("#jqxPurchaseDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxFinRegDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxFinRelDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxOtherRegExp").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxOtherInsExp").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxWrntyFrmDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxWrntyToDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxLstSrvcDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#releasedate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		   $('#dealerWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#dealerWindow').jqxWindow('close');
		   $('#financierWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#financierWindow').jqxWindow('close');
		   $('#insuranceWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		   $('#insuranceWindow').jqxWindow('close');
		   $('#jqxFinRegDate').on('change', function (event) 
			   		 {  
			   		     var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
			   		     var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
			   		     var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()+1));
			   		     
			   		     $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
			   		     
			   		 });
		   $('#jqxFinRelDate').on('change', function (event) 
			   		 {  
			   		     var finreldate= $('#jqxFinRelDate').jqxDateTimeInput('getDate');
			   		     var finaldate=new Date(new Date(finreldate).setMonth(finreldate.getMonth()+13));
			   		     var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()+1));
			   		     $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
			   		 });

	});
	
	 function funSearchLoad(){
			changeContent('vehicleSearch.jsp', $('#window')); 
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
    	 //alert("here"); var url=document.URL;
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
		
	function funReset() {
				 document.getElementById("frmVehicle").reset();
	}
	function funReadOnly() {
		 $('#frmVehicle input').attr('readonly', true);
		getAuth();
		getBrand();
		getPlateCode();
		getGroup();
		getModel();
		getYOM();
		getColor();
		getFinancier();
		getBrch();
		showRelease(); 
		getStatus();
		getLocation();
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
		document.getElementById("frmVehicle").submit();
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
		
	}
	function funRemoveReadOnly() {
		$('#frmVehicle input').attr('readonly', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#docno').attr('readonly', true);
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
		x.open("GET", "getAuthority.jsp", true);
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
		x.open("GET", "getColor.jsp", true);
		x.send();
	}
	function getPlateCode() {
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
		x.open("GET", "getPlateCode.jsp", true);
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
		x.open("GET", "getGroup.jsp", true);
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
		x.open("GET", "getLevel.jsp?id="+value, true);
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
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	function getModel() {
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
		x.open("GET", "getModel.jsp", true);
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
		x.open("GET", "getYOM.jsp", true);
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
		x.open("GET", "getFinancier.jsp", true);
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
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
	function getLocation()
	{
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
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
		x.open("GET","getLocation.jsp",true);
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
		x.open("GET","getStatus.jsp",true);
		x.send();
	//document.write(document.getElementById("authname").value);

	}
	function setValues() {
		if($('#hidjqxDate1').val()){
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
		if ($('#hidpurchase').val() != null) {
			$('#purchase').val($('#hidpurchase').val());
		}
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
		if(<%=!(request.getAttribute("SAVED")==null) || !(request.getAttribute("SAVED")=="") %>){
			 <%System.out.println("request.getAttribute(SAVED)"+request.getAttribute("SAVED"));%>
				if(<%=(request.getAttribute("SAVED")=="Successfully Saved") || (request.getAttribute("SAVED")=="Updated Successfully") || (request.getAttribute("SAVED")=="Successfully Deleted") || (request.getAttribute("SAVED")=="Successfully Released")%>){
					$('#eventWindowSuccess').jqxWindow('open'); 
				}
				if(<%=(request.getAttribute("SAVED")=="Not Saved") || (request.getAttribute("SAVED")=="Not Updated") || (request.getAttribute("SAVED")=="Not Deleted") || (request.getAttribute("SAVED")=="Not Released")%>){
					$('#eventWindowFailure').jqxWindow('open');
				}
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
	                regno:"required",
	                cmbbrand:"required",
	                cmbmodel:"required",
	                cmbyom:"required",
	                purchase_cost:"required",
	                cmb_availbr1:"required",
	                purchase:"required",
	                purchase_cost:"required"
	               
	                 
	                 }, 
	        messages:{
	        	cmbauthority:" *",
	        	cmbplate:" *",
	        	cmbgroup:" *",
	        	regno:" *",
	        	cmbbrand:" *",
	        	cmbmodel:" *",
	        	cmbyom:" *",
	        	purchase_cost:" *",
	        	cmb_availbr1:" *",
	        	purchase:" *",
	        	purchase_cost:" *"
	        
	        }
	                 //alert("here");
	        });
	        });
	     function funNotify(){
	    	 
	    		return 1;
		} 
	    function getTotal(){
	    	 var pcost = document.getElementById('purchase_cost').value;
	         var addit = document.getElementById('additions').value;
	         if (pcost == "")
	             pcost = 0;
	         if (addit == "")
	             addit = 0;

	         var result = parseInt(pcost) + parseInt(addit);
	         if (!isNaN(result)) {
	             document.getElementById('total').value = result;
	         }	   
	         }
	    function getFleetName(){
	    	var x = document.getElementById("cmbbrand");
	        var i = x.selectedIndex;
	        var x1=document.getElementById("cmbmodel");
	        var i1=x1.selectedindex;
	        var r=x.options[i].text;
	        var r1=x1.options[i].text;
	        //alert("***"+r+"***"+r1);
	        document.getElementById("fleetname").value = r+" "+r1;
	    }

	   
	    
</script>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css">
 </head>
<body onLoad="funReadOnly();setValues();">
	<%
		session.setAttribute("FormName", "Vehicle Master");
		session.setAttribute("Code", "VEH");
	%>
	
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmVehicle" action="saveVehicle" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp"></jsp:include>
<br />
			<fieldset>
				<legend>Vehicle Details</legend>
				<table width="100%" cellspacing="0">
					<tr>
						<td width="49" height="24" id="f" style="text-align: right"><div
								align="right">Fleet No</div></td>
						<td colspan="5">
							<input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" 
							style="width: 20%;" value='<s:property value="fleetno"/>'> 
							<input type="text" name="fleetname" id="fleetname" readonly tabindex="-1"
							style="width: 75.5%;" value='<s:property value="fleetname"/>'></td>
						<td align="right">Date</td>
						<td colspan="2" align="left"><div id='jqxDate1'
								name='jqxDate1' value='<s:property value="jqxDate1"/>'></div>
                        <input
							type="hidden" id="hidjqxDate1" name="hidjqxDate1"
							value='<s:property value="hidjqxDate1"/>' /></td>
						<td align="left">&nbsp;</td>
						<td width="46" align="right">Doc No</td>
						<td width="117" align="left"><input type="text"
							name="docno" id="docno"  readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
						
					</tr>
					<tr>
					  <td height="24" align="right">Authority</td>
					  <td><select name="cmbauthority" id="cmbauthority"
							value='<s:property value="cmbauthority"/>' style="width:94%;">
                        <option value="">--Select--</option>
                      </select>
				      <input type="hidden" id="hidcmbauthority" name="hidcmbauthority"
							value='<s:property value="hidcmbauthority"/>' /></td>
					  <td align="right">Plate Code</td>
					  <td><select name="cmbplate" id="cmbplate"
							value='<s:property value="cmbplate"/>' style="width:75%;">
                        <option>--select--</option>
                      </select>
				      <input type="hidden" id="hidcmbplate" name="hidcmbplate"
							value='<s:property value="hidcmbplate"/>' /></td>
					  <td align="right">Reg No</td>
					  <td width="105" align="left"><input type="text" name="regno" id="regno"
							style="width:89%;" value='<s:property value="regno"/>' autocomplete="off"></td>
					  <td align="right">Group</td>
					  <td colspan="3" align="left"><select name="cmbgroup"
							id="cmbgroup" value='<s:property value="cmbgroup"/>' style="width:37%;" onchange="getLevel(this.value);">
                        <option>--Select--</option>
                      </select>
				      <input type="hidden" id="hidcmbgroup" name="hidcmbgroup"
							value='<s:property value="hidcmbgroup"/>' />
				      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Level
				      <input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>' tabindex="-1"></td>
					  <td align="right">Op. Status</td>
					  <td align="left"><input type="text"
							name="opstatus" id="opstatus"  value='IN' tabindex="-1" disabled="true"></td>
				  </tr>
					<tr>
						<td height="24" align="right"><span style="text-align: right">Brand</span></td>
						<td width="91"><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:90%;">
                          <option>--Select--</option>
                        </select>
					  <input type="hidden" id="hidcmbbrand" name="hidcmbbrand"
							value='<s:property value="hidcmbbrand"/>' /></td>
						<td width="59" align="right">Model</td>
						<td width="92"><select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' style="width:75%;" onchange="getFleetName();">
                          <option>--Select--</option>
                        </select>
					  <input type="hidden" id="hidcmbmodel" name="hidcmbmodel"
							value='<s:property value="hidcmbmodel"/>' /></td>
						<td width="50" align="right">YoM</td>
						<td align="left"><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>' style="width:91%;">
                          <option>--Select--</option>
                        </select>
					  <input type="hidden" id="hidcmbyom" name="hidcmbyom"
							value='<s:property value="hidcmbyom"/>' /></td>
						<td width="50" align="right">Salik Tag</td>
						<td width="80" align="left"><input type="text" id="salik_tag" name="salik_tag"   value='<s:property value="salik_tag"/>' /></td>
						<td width="30" align="right">TC No</td>
						<td width="151" align="left"><input type="text" id="tcno" name="tcno"  value='<s:property value="tcno"/>' /></td>
						<td align="right">Ast status</td>
					    <td align="left"><input type="text"
							name="aststatus" id="aststatus"  style="align: left;" value='<s:property value="aststatus"/>'  tabindex="-1" ></td>
					</tr><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
					
				</table>
<br />

				<ul id="tabs">
					<li><a href="#" name="tab1">Induction</a></li>
					<li><a href="#" name="tab2">Services And Other Details</a></li>
					<li><a href="#" name="tab3">Specifications</a></li>
				</ul>
				<!-- <iframe  width=1100px height=400px align='center' id='page' ></iframe> -->
				<div id="content">
					<div id="tab1">
						<table width="100%">
							<tr>
							  
									<td width="25%">
                                    <fieldset><legend>Purchase Info</legend>
									  <table width="100%" >
									    <tr>
									      <td align="right">Dealer</td>
									      <td align="left"><input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' ondblclick="funSearchdblclick();" onkeydown="getDealer(event);"></td>
									      <input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
								        </tr>
									    <tr>
									      <td align="right">Deal No</td>
									      <td align="left"><input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>'/></td>
								        </tr>
									    <tr>
									      <td align="right">Purchase Type</td>
									      <td align="left"><select name="purchase" id="purchase" value='<s:property value="purchase"/>' style="width:89%;">
									        <option>--Select--</option>
									        <option value="Cash">Cash</option>
									        <option value="Credit">Credit</option>
									        </select></td>
								        </tr>
									    <tr>
									      <td align="right">LPO No</td>
									      <td align="left"><input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>'/></td>
								        </tr>
									    <tr>
									      <td align="right">Purchase Invoice</td>
									      <td align="left"><input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>'/></td>
								        </tr>
									    <tr>
									      <td align="right">Purchase Date</td>
									      <td align="left"><div id='jqxPurchaseDate' name='jqxPurchaseDate'
														value='<s:property value="jqxPurchaseDate"/>'></div>
									        <input
													type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate"
													value='<s:property value="hidjqxPurchaseDate"/>' /></td>
								        </tr>
									    <tr>
									      <td align="right">Purchase Cost</td>
									      <td align="left"><input type="text" name="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>' /></td>
								        </tr>
									    <tr>
									      <td align="right">Additions</td>
									      <td align="left"><input type="text" id="additions" name="additions" value='<s:property value="additions"/>' /></td>
								        </tr>
									    <tr>
									      <td align="right">Total</td>
									      <td align="left"><input type="text" id="total" name="total" value='<s:property value="total"/>' onfocus="getTotal();"/></td>
								        </tr>
									    <tr>
									      <td align="right">&nbsp;</td>
									      <td align="left">&nbsp;</td>
								        </tr>
								      </table>
                                      <br />
										<br /><br /><br />
                                      </fieldset>
								</td>
								<td width="25%"> 
									<fieldset>
										<legend>Finance Info</legend>
										<table width="99%">
											<tr>
												<td align="right">Financer</td>
												<td>
														<input type="text" name="financier" id="financier" value='<s:property value="financier"/>' ondblclick="funFinSearchdblclick();" onkeydown="getFin(event);">
												</select> <input type="hidden" id="hidfinancier" name="hidfinancier"
													value='<s:property value="hidfinancier"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Interest Amt</td>
												<td><input type="text" id="interest_amt" name="interest_amt" value='<s:property value="interest_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Down Payment</td>
												<td><input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;No. of Installments</td>
												<td><input type="text" id="no_installments" name="no_installments"
													 value='<s:property value="no_installments"/>'/></td>
											</tr>
											<tr>
												<td width="41%" align="right">&nbsp;Registered Date</td>
												<td width="59%"><div id='jqxFinRegDate'
														name='jqxFinRegDate' value='<s:property value="jqxFinRegDate"/>'></div>
													<input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate"
													value='<s:property value="hidjqxFinRegDate"/>' /></td>
											</tr>
											<tr>
												<td align="right">Release Date</td>
												<td><div id='jqxFinRelDate' name='jqxFinRelDate'
														value='<s:property value="jqxFinRelDate"/>'></div> <input
													type="hidden" id="hidjqxFinRelDate" name="hidjqxFinRelDate"
													value='<s:property value="hidjqxFinRelDate"/>' /></td>
											</tr>
											<tr>
												<td><div align="right">
														<span style="text-align: right">Installment Amt</span>
													</div></td>
												<td><input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;CostTran No</td>
												<td><input type="text" id="tran_no" name="tran_no" value='<s:property value="tran_no"/>' readonly tabindex="-1"/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Depr %</td>
												<td><input type="text" id="depr_perc" name="depr_perc" value='<s:property value="depr_perc"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Accu. Dep.</td>
												<td><input type="text" id="accu_dep" name="accu_dep" value='<s:property value="accu_dep"/>'/></td>
											</tr>
											<tr>
											  <td align="right">&nbsp;</td>
											  <td>&nbsp;</td>
										  </tr>
										</table>
										<br />
										<br />
									</fieldset>
								</td>

								<td width="25%">
									<fieldset>
										<legend>Other Info</legend>
										<table width="98%">
											<tr>
												<td width="39%" align="right">&nbsp;Reg. Expiry</td>
												<td width="61%"><div id='jqxOtherRegExp' name='jqxOtherRegExp'
														value='<s:property value="jqxOtherRegExp"/>'></div> <input
													type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp"
													value='<s:property value="hidjqxOtherRegExp"/>' /></td>
											</tr>
											<tr>
												<td align="right">Insurance Type</td>
												<td><select name="cmbinsurance_type"
													id="cmbinsurance_type" value='<s:property value="cmbinsurance_type"/>' style="width:94%;">
														<option value="Comprehensive">Comprehensive</option>
														<option value="3rdParty">3rd Party</option>
												</select> <input type="hidden" id="hidcmbinsurance_type"
													name="hidcmbinsurance_type"
													value='<s:property value="hidcmbinsurance_type"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;&nbsp;Insurance Comp</td>
												<td><input type="text" id="insurance_comp" name="insurance_comp"
													 value='<s:property value="insurance_comp"/>' ondblclick="funInsurSearchdblclick();" onkeydown="getInsurance(event);"/></td><input type="hidden" name="hidinsurance_comp" id="hidinsurance_comp" 
													 value='<s:property value="hidinsurance_comp"/>'>
											</tr>
											<tr>
												<td align="right">Insured Amt</td>
												<td><input type="text" id="insured_amt" name="insured_amt" value='<s:property value="insured_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">Insurance Expiry</td>
												<td><div id='jqxOtherInsExp' name='jqxOtherInsExp'
														value='<s:property value="jqxOtherInsExp"/>'></div> <input
													type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp"
													value='<s:property value="hidjqxOtherInsExp"/>' /></td>
											</tr>
											<tr>
												<td align="right">Premium %</td>
												<td><input type="text" id="premium_perc" name="premium_perc" value='<s:property value="premium_perc"/>' /></td>
											</tr>
											<tr>
												<td align="right">Policy No</td>
												<td><input type="text" id="policy_no" name="policy_no" value='<s:property value="policy_no"/>' /></td>
											</tr>
											<tr>
												<td align="right">Premium Amt</td>
												<td><input type="text" id="premium_amt" name="premium_amt" value='<s:property value="premium_amt"/>' /></td>
											</tr>
										</table>
										<br /><br /><br /><br /><br /><br /><br /><br />
									</fieldset>
								</td>
								<td width="25%">
                                <fieldset id="releaseid"><legend>Fleet Release Info</legend>
								  <table width="100%">
								    <tr>
								      <td width="26%" align="right">Fleet No</td>
								      <td width="74%" align="left"><input type="text" name="releasefleet" id="releasefleet" value='<s:property value="releasefleet"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Branch</td>
								      <td align="left"><select name="cmbrlsbranch" id="cmbrlsbranch" value='<s:property value="cmbrlsbranch"/>' style="width:77%;">
								        <option value="">--Select--</option>
								        </select>
                                      <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Location</td>
								      <td align="left"><select name="cmbrlsloc" id="cmbrlsloc" value='<s:property value="cmbrlsloc"/>' style="width:77%;">
								        <option value="">--Select--</option>
								        </select>
							          <input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Rental Status</td>
								      <td align="left"><select name="cmbrentalstatus" id="cmbrentalstatus" value='<s:property value="cmbrentalstatus"/>' style="width:77%;">

								         <option value="R" >Rental</option>
								        <option value="L">Lease</option>
								        <option value="LM">Limousine</option>
								        <option value="A">All</option>
								        </select>
                                      <input type="hidden"  name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'></td>
							        </tr>
								    <tr>
								      <td align="right">Date</td>
								      <td align="left"><div id="releasedate" name="releasedate" value='<s:property value="releasedate"/>'> </td>
                                      <input type="hidden" name="hidreleasedate" id="hidreleasedate" value='<s:property value="hidreleasedate"/>'>
							        </tr>
								    <tr>
								      <td colspan="2" align="center"><input type="button" name="btnrelease" id="btnrelease" class="myButton"  value="Release" onclick="funEnable();"><input type="button" name="releasesave" id="releasesave" class="myButton" value="Save" onclick="funRelease();"></td>
							        </tr>
						          </table>
                                  <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /> 
										
										
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
												<td width="11%" height="28" align="right">Engine No</td>
												<td width="14%" align="left"><input type="text"
													id="engine_no" name="engine_no" value='<s:property value="engine_no"/>'/></td>
												<td width="7%" align="right" >VIN</td>
												<td width="12%" align="left"><input type="text"
													name="vin" id="vin" value='<s:property value="vin"/>' /></td>
												<td width="15%" align="right">Chasis No</td>
												<td width="17%" align="left"><input type="text"
													id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>' /></td>
												<td width="9%" align="right">Color</td>
												<td width="15%" align="left"><select
													name="cmbveh_color" id="cmbveh_color" value='<s:property value="cmbveh_color"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbveh_color" name="hidcmbveh_color"
													value='<s:property value="hidcmbveh_color"/>' /></td>
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
												<td width="11%" height="28" align="right">Warranty
													Period</td>
												<td width="13%" align="left"><input type="text"
													id="warranty_period" name="warranty_period" value='<s:property value="warranty_period"/>'/></td>
												<td width="8%" align="right">From Date</td>
												<td width="12%" align="left"><div id='jqxWrntyFrmDate'
														name='jqxWrntyFrmDate'
														value='<s:property value="jqxWrntyFrmDate"/>'></div>
														 <input
													type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate"
													value='<s:property value="hidjqxWrntyFrmDate"/>' /></td>
												<td width="15%" align="right">To Date</td>
												<td width="17%" align="left"><div id='jqxWrntyToDate'
														name='jqxWrntyToDate'
														value='<s:property value="jqxWrntyToDate"/>'></div> 
														<input
													type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate"
													value='<s:property value="hidjqxWrntyToDate"/>' /></td>
												<td width="9%" align="right">Warranty KM</td>
												<td width="15%" align="left"><input type="text"
													name="warranty_km" id="warranty_km"  value='<s:property value="warranty_km"/>' /></td>
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
												<td width="11%" height="28" align="right">Service KM</td>
												<td width="13%" align="left"><input type="text"
													id="service_km" name="service_km" value='<s:property value="service_km"/>'/></td>
												<td width="8%" align="right">Last Srvc. Date</td>
												<td width="12%" align="left">
														<div id='jqxLstSrvcDate'
														name='jqxLstSrvcDate'
														value='<s:property value="jqxLstSrvcDate"/>'></div> 
														<input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate"
													value='<s:property value="hidjqxLstSrvcDate"/>' /></td>
												<td width="15%" align="right">Last Service KM</td>
												<td width="17%" align="left"><input type="text"
													id="last_srvc_km" name="last_srvc_km" value='<s:property value="last_srvc_km"/>'/></td>
												<td width="9%"></td>
												<td width="15%"></td>
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
												<td width="8%" height="30" align="right">Current KM</td>
												<td width="13%" align="left"><input type="text"
													id="current_km" name="current_km" value='<s:property value="current_km"/>'/></td>
												<td width="8%" align="right">Fuel</td>
											<td width="12%" align="left"><select name="cmbfuel" 
													id="cmbfuel" value='<s:property value="cmbfuel"/>'>
														<option value="E" selected>Empty</option>
														<option value="H">Half</option>
														<option value="T">TriQuarter</option>
														<option value="F">Full</option>
												</select> 
												<input type="hidden" id="hidcmbfuel" name="hidcmbfuel"
													value='<s:property value="hidcmbfuel"/>' /></td>
												<td width="15%" align="right">Branded</td>
												<td width="17%" align="left"><select name="branded" id="branded" value='<s:property value="branded"/>'>
														
														<option value="Y" selected>Y</option>
														<option value="N">N</option>
												</select>
												<input type="hidden" id="hidbranded" name="hidbranded"
													value='<s:property value="hidbranded"/>' />
												</td>
												<%-- <td width="9%" align="right">Rent Type</td>
												<td width="15%" align="left"><select
													name="cmbrent_type" id="cmbrent_type" value='<s:property value="cmbrent_type"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbrent_type" name="hidcmbrent_type"
													value='<s:property value="hidcmbrent_type"/>' /></td> --%>
											</tr>
											<tr>
												<td height="30"></td>
												<td></td>
												<td align="right">Avail. Br.</td>
												<td colspan="5" align="left"><select
													name="cmbavail_br1" id="cmbavail_br1" value='<s:property value="hidcmbavail_br1"/>' >
												</select> <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1"
													value='<s:property value="hidcmbavail_br1"/>' /> 
													<input type="text" id="tcno2" name="tcno2" style="width: 275px;" value='<s:property value="tcno2"/>'/></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
						</table>
					</div>

					<div id="tab3">
						<center><jsp:include page="specificationGrid.jsp"></jsp:include></center>
						<br />
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