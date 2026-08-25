
<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
#section {
	line-height: 50%;
	width: 90.5%;
	float: right;
	margin-width: 50%;
}
#nav {
	line-height: 250%;
	height: 90.5%;
	width: 10vw;
	float: left;
	position: absolute;
	left: 6px;
	top: 5px;
}
form label.error {
color:red;
  font-weight:bold;

}
.HeadIcons {
	font: 12px Tahoma;
	margin-top: 0px;
	line-height: 30px;
	background-color: #E0ECF8;
	height: 27px;
	width: 100%;
}
.icon {
	width: 3em;
	height: 2em;
	border: none;
	background-color: #f0f0f0;
}
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}

</style>

<script type="text/javascript">
      $(document).ready(function () { 
    	  getTariftype();
    	 
    	 
    	  
    	  getcheckbox();
     setCheck();
    	  /* Date */
    	  document.getElementById("grouplabel").style.display="none";
document.getElementById("txtclient").disabled="true";
    	  $("#jqxTariffDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffFromDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffToDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  document.getElementById("btnTarifEdit").style.display="none";

$('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clienttarifwindow').jqxWindow('close');
//$('#frmTariffManagement select').attr('disabled', false );
	selectTarif();
	//$('#frmTariffManagement select').attr('disabled', true );
	     $('#txtclient').dblclick(function(){
		    $('#clienttarifwindow').jqxWindow('open');
		$('#clienttarifwindow').jqxWindow('focus');
		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
		});
	     
      });
    
      function clientSearchContent(url) {
  	    //alert(url);
  	      $.get(url).done(function (data) {
  	//alert(data);
  	    $('#clienttarifwindow').jqxWindow('setContent', data);

  	}); 
  	}
      function getClient(event){
  	   	
          var x= event.keyCode;
          if(x==114){
        	   $('#clienttarifwindow').jqxWindow('open');
       		$('#clienttarifwindow').jqxWindow('focus');
       		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
          }
          else{
           }
          }
      function selectTarif(){
    	  $('#frmTariffManagement select').attr('disabled',false );
  		var temp=document.getElementById("cmbtariftype").value;
  		// $('#frmTariffManagement select').attr('disabled',true );
  		 if(document.getElementById("mode").value=='A'){
  			 
  		 }
  		/* if(temp=="Condition"){
  			//alert("Inside condition");
  			
			document.getElementById("fieldfoc").style.display="block";
    	  	document.getElementById("fieldweekday").style.display="block";
  			$('#txtclient').attr('disabled', true );
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: false});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else */ if(temp=="Client"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  		else if(temp=="Corporate"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}  			
  		}
  		else if(temp=="Weekend"){
  			document.getElementById("fieldweekday").style.display="block";
  			document.getElementById("fieldfoc").style.display="none";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else if(temp=="FOC"){
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldfoc").style.display="block";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else{
  			$('#txtclient').attr('disabled', true );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  	} 
	function funReset(){
    	
    		
    	}
		
    	function funReadOnly(){
			$('#frmTariffManagement input').attr('readonly', true );
			$('#frmTariffManagement select').attr('disabled', true );
			$('#frmTariffManagement textarea').attr('readonly', true );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
    		$("#jqxgridtarif").jqxGrid({ disabled: true});
    		//$("#jqxgridtarifgrp").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: true});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
    		

			
    	} 
    	
    	function funRemoveReadOnly(){
    		$('#frmTariffManagement input').attr('readonly', false );
			$('#frmTariffManagement select').attr('disabled', false );
			$('#frmTariffManagement textarea').attr('readonly', false );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxgridtarif").jqxGrid({ disabled: false});
    		//$("#jqxgridtarifgrp").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: false});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		if(document.getElementById("mode").value=='A'){
    			$("#divRegularTarif").load("gridRegularTarif.jsp");
    			 $("#divfoc").load("gridFoc.jsp");
          		 $("#divweekday").load("gridWeekday.jsp");
          		 $("#divgroup1").load("gridgroup1.jsp");
          		 $("#divgroup2").load("gridgroup2.jsp");
          		 document.getElementById("grouplabel").style.display="none";
          		 document.getElementById("btnTarifEdit").style.display="none";
          		document.getElementById("btnTarifSave").style.display="none";
          		 $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());

    		}
    	}
    	
    	function funNotify(){	
    	 	//alert("here");
    			if(document.getElementById("docno").value!=''){	
    	var rows = $("#jqxgridtarif").jqxGrid('getrows');
		/* if(!((rows[0].rate=="undefined") || (rows[0].rate==null) || (rows[0].rate==""))){ */
    	$('#gridlength').val(rows.length);
    		//alert($('#gridlength').val());
    		for(var i=0 ; i < rows.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
				
			newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
    	/* } */
    	if(document.getElementById("cmbtariftype").value=='Weekend'){
    		var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
    		
    		
    		//alert($('#weekdaylength').val(rowsweekday.length));
    		//alert(rowsweekday);
    		var j=0;
    		
    		
    		for(var i=0 ; i < rowsweekday.length ; i++){

    				newTextBoxweekday = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtweekday"+i)
    			    .attr("name", "txtweekday"+i);
    			 	//alert(rowsweekday[i].cstime.getMinutes());
    			 	//alert((rowsweekday[i].cstime.getMinutes().getMinutes()<10?'0':'') + rowsweekday[i].cstime.getMinutes().getMinutes());
    				var d=new Date(rowsweekday[i].cstime);
    				
    				var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
    				//alert(tempstarttime.toString());
    				var d1=new Date(rowsweekday[i].cetime);
    				var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
    				//alert(tempendtime.toString());
    				if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
    						typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
    					newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
    				j++;
    				newTextBoxweekday.appendTo('form');
    				}
    				
    			
    				
    				//alert("ddddd"+$("#txtweekday"+i).val());
    			}
    		$('#weekdaylength').val(j);
    	}
    	if(document.getElementById("cmbtariftype").value=='FOC'){
    		var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
    		

    		$('#foclength').val(rowsfoc.length);
    		for(var i=0 ; i < rowsfoc.length ; i++){
    
    				newTextBoxfoc = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtfoc"+i)
    			    .attr("name", "txtfoc"+i);
    				
    				newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
    			
    				newTextBoxfoc.appendTo('form');
    				//alert("ddddd"+$("#txtfoc"+i).val());
    			}
    		
    	}
    		
    		var a=document.getElementById("gridlength").value;
			var b=document.getElementById("weekdaylength").value;
			var c=document.getElementById("foclength").value;
			var d=document.getElementById("fuellength").value;
			//alert("Regular:"+a+"Weekday:"+b+"FOC:"+c+"Fuel"+d);
    			}
    			$('#frmTariffManagement select').attr('disabled',false);
    			$('#txtclient').attr('disabled',false);
			return 1;
			$('#frmTariffManagement select').attr('disabled',true);
    		
 	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

    	function funSearchLoad(){
    		changeContent('tarifSearch.jsp', $('#window')); 
    	}
    		
     	function funFocus(){
    	   	$('#jqxTariffDate').jqxDateTimeInput('focus'); 	    		
     	}
		function setCheck(){
			if(document.getElementById("chckdeliverychg").checked==true){
				document.getElementById("hidcheck").value=1;
			}
			else
				document.getElementById("hidcheck").value=0;
		}
		function getcheckbox(){
			if(document.getElementById("hidcheck").value==1){
				document.getElementById("chckdeliverychg").checked=true;
			}
			else{
				document.getElementById("chckdeliverychg").unchecked=true;
			}
		}
		function setValues(){
			document.getElementById("cmbtariftype").disabled=false;
			if(document.getElementById("cmbtariftype").value=="Weekend"){
				document.getElementById("fieldweekday").style.display="block";
	  			document.getElementById("fieldfoc").style.display="none";
			}
			if(document.getElementById("cmbtariftype").value=="FOC"){
				document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldfoc").style.display="block";
			}
			//alert("CMB"+document.getElementById("hidcmbtariftype").value);
			if(document.getElementById("docno")!=''){
				var temp=document.getElementById("docno").value;
				$("#divgroup2").load("gridgroup2.jsp?id="+temp);
				$("#divgroup1").load("gridgroup1.jsp?id="+temp);
			}
			if ($('#hidcmbtariftype').val() != null) {
				$('#cmbtariftype').val($('#hidcmbtariftype').val());
			}
			if ($('#hidcmbtariffor').val() != null) {
				$('#cmbtariffor').val($('#hidcmbtariffor').val());
			}
			if($('#hidjqxTariffDate').val()){
				$("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
			}
			if($('#hidjqxTariffFromDate').val()){
				$("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
			}
			if($('#hidjqxTariffToDate').val()){
				$("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
			}
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
if(document.getElementById("docno").value==''){
	document.getElementById("btnTarifEdit").style.display="none";
}

document.getElementById("cmbtariftype").disabled=true;
		}
		 function funTarifEdit(){
		 	 document.getElementById("cmbtariftype").disabled=false;
		 	$("#jqxgridtarifgrp").jqxGrid({ disabled:false});
		 	document.getElementById("insurexcess").readOnly=false;
		 	document.getElementById("cdwexcess").readOnly=false;
		 	document.getElementById("scdwexcess").readOnly=false;
		 	document.getElementById("securityamt").readOnly=false;
				/* if(document.getElementById("cmbtariftype").value=="Condition"){
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	        		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	        		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});

	    		} */
	    		if(document.getElementById("cmbtariftype").value=="Weekend"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:true});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="FOC"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else{
	    			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
	        		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	        		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			$("#jqxgridtarif").jqxGrid({ disabled: false});
	    		}
		/*  alert("CMB"+document.getElementById("hidcmbtariftype").value);
		
    		$("#jqxgridtarifgrp").jqxGrid({ disabled: false});
    		$("#jqxgridtarifdelivery").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		$('#frmTariffManagement select').attr('disabled', false); */
    	
		 	document.getElementById("cmbtariftype").disabled=true;
		}  
		 function funTarifSave(){
			 document.getElementById("cmbtariftype").disabled=false;
			 if(document.getElementById("cmbtariftype").value=="Weekend"){
	
				 var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
	
				 if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
			
					 document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Tariff is Mandatory";
		    			return false;
		    		}
			 }
			if(document.getElementById("docno").value!=""){
				 document.getElementById("mode").value="A";
				 $('#btnSave').mousedown();	 
			 }
			 else{
				 $.messager.alert('Warning','Please Select a Valid Document');
				 return false;
			 }
			// document.getElementById("btnTarifSave").disabled=true;
			 document.getElementById("cmbtariftype").disabled=true;
		 }
		  function isNumber(evt,id) {
		        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
		function funPrintBtn() {
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   		}
	   		var url=document.URL;
	   	 var reurl=url.split("com/");
	   	  	//var reurl=url.split("tarifMgmt.jsp");

	   	   	var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   	    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();  


	   	 }
		
		function getTariftype(){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items=items.split("***");
					var tarifitems = items[0].split(",");
					var status=items[1];				
					var optionstarif = '<option value="">--Select--</option>';
					for (var i = 0; i < tarifitems.length; i++) {
						optionstarif += '<option value="' + tarifitems[i] + '">'
								+ tarifitems[i] + '</option>';
					}
					$("select#cmbtariftype").html(optionstarif);
				 	 if ($('#hidcmbtariftype').val() != null) {
						$('#cmbtariftype').val($('#hidcmbtariftype').val());
					}
				 	/*  if(status.trim()=="1"){
			    		  document.getElementById("fieldfoc").style.display="block";
			        	  document.getElementById("fieldweekday").style.display="block";
			    	  }
			    	  else{
			    		  document.getElementById("fieldfoc").style.display="none";
			        	  document.getElementById("fieldweekday").style.display="none";	  
			    	  }   */
				 	  document.getElementById("fieldfoc").style.display="none";
		        	  document.getElementById("fieldweekday").style.display="none";	
				}
			}
			x.open("GET", "getTariftype.jsp", true);
			x.send();
		}
		
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTariffManagement" action="saveTariffManagement" autocomplete="off">
	<script>
			window.parent.formName.value="Tariff Management";
			window.parent.formCode.value="TFM";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/> 

<div class='hidden-scrollbar'>
<table width="100%" >
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="8%" align="left"><input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
      <div id='jqxTariffDate' name='jqxTariffDate' value='<s:property value="jqxTariffDate"/>'></div></td>
    <td width="5%" align="right">Tariff Type</td><!-- onchange="selectTarif();" -->
    <td width="18%" align="left"><select id="cmbtariftype" name="cmbtariftype" value='<s:property value="cmbtariftype"/>' onchange="selectTarif();" >
      <option value="">--Select--</option></select>
      
      <input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onkeydown="getClient(event);">
      <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/></td>
    <!-- <option value="Regular">Regular</option><option value="Promotion">Promotion</option><option value="Client">Client</option>
      <option value="Condition">Condition</option><option value="Corporate">Corporate</option> -->
    <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'>
    <td width="4%" align="right">Tariff For</td>
    <td width="9%" align="left"><select id="cmbtariffor" name="cmbtariffor" value='<s:property value="cmbtariffor"/>'>
      <option value="">--Select--</option><option value="Vehicle">Vehicle</option>
    </select>
      <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/></td>
    <td width="6%" align="right">Validity From</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
      <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div></td>
    <td width="5%" align="right">Validity To</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
      <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div></td>
    <td width="9%" align="left"><input type="checkbox" id="chckdeliverychg" name="chckdeliverychg"  onchange="setCheck();">
      &nbsp;&nbsp;Delivery Charge</td><input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'>
    <td width="4%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
    
    </tr>
  <tr>
    <td height="41" align="right">Notes</td>
    <td align="left" colspan="10"><textarea id="notes" name="notes" style="width:100%;resize:none;"><s:property value="notes"/></textarea></td>
    <td align="center">
    <button type="button"  id="btnTarifEdit" title="Tarif Edit" style="border:none;background:none;" onclick="funTarifEdit();">
							<img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
		  </button>
    <button type="button" id="btnTarifSave" title="Tarif Save" hidden="true" style="border:none;background:none;" onclick="funTarifSave();">
							<img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
		  </button>
    
    </td>
   <input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
<input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
<input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
<input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
<input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
<input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'> 
<input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
<input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>
  </tr>
</table>
<center><label id="grouplabel" style="color:red;font-weight:bold;"></label></center>

<table width="100%">
  <tr>
    <td width="6%" rowspan="11" ><div id="divgroup1" ><jsp:include page="gridgroup1.jsp"></jsp:include></div></td>
    <td colspan="2" align="center"><fieldset><div id="divRegularTarif"><jsp:include page="gridRegularTarif.jsp"></jsp:include></div></fieldset></td>
    <td width="6%" rowspan="11"><div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div></td></tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldextrainsur" align="left">
      
      <table width="100%">
        <tr>
          <td align="right">Security Amount</td><td align="left"><input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right">Insurance Excess</td><td align="left"><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right">CDW Excess</td><td align="left"><input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right">Super CDW Excess</td><td align="left"><input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldfoc" align="left">
      <legend>FOC Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divfoc">
            <jsp:include page="gridFoc.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
   
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldweekday" align="left">
      <legend>Week Day Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divweekday">
            <jsp:include page="gridWeekday.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
 <input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'>
  <input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'>
</table>
</form>
</div>
<div id="clienttarifwindow">
   <div ></div>
</div>
</div>
<div hidden="true">
<fieldset>
  <legend>Fuel Info</legend>
  <table width="100%">
    <tr>
      <td><div id="divfuel">
        <jsp:include page="gridfuel.jsp"></jsp:include>
      </div></td>
    </tr>
  </table>
</fieldset>
</div>

<p>&nbsp;</p>
</body>
</html>
