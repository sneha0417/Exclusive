<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;

  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>

<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mastertrno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
String brch1 =request.getParameter("brch")==null?"0":request.getParameter("brch").toString();
%>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var brhidview='<%=brch1%>';
$(document).ready(function() {
	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#stdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#enddate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#finsdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy",enableBrowserBoundsDetection:true });
	  $("#serdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" ,enableBrowserBoundsDetection:true});
	  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch1').jqxWindow('close');
	  $('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#cpinfowindow').jqxWindow('close');
	  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#areainfowindow').jqxWindow('close');
		$('#siteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#siteinfowindow').jqxWindow('close');
		$('#grpinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#grpinfowindow').jqxWindow('close');
		$('#teaminfowindow').jqxWindow({ width: '30%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#teaminfowindow').jqxWindow('close');
		$('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#sertypefowindow').jqxWindow('close');
		$('#schserchinfowindow').jqxWindow({ width: '80%', height: '60%',  maxHeight: '90%' ,maxWidth: '90%' ,title: 'Schedule Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
		$('#schserchinfowindow').jqxWindow('close');
		  $('#serviceteamwindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Team Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#serviceteamwindow').jqxWindow('close');
				
	  refChange();getsjobtype();
	  
	  $('#txtclient').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   	 $('#clientsearch1').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
		   		}
		 });
	  
	  
	  $('#srvsite').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   		$('#siteinfowindow').jqxWindow('open');
		   	      siteSearchContent('servicesitesearch.jsp?rowBoundIndex=1');
		   		}
		 });
	  
	  
	  $('#srvser').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   		$('#sertypefowindow').jqxWindow('open');
		   	  serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex=1&sert=2');
		   		}
		 });
	  
	  
	  $('#rrefno').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   	 changeContent('enqMastersearch.jsp');  
		   		}
		 });
	  
	  
	  $('#txtcontact').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   		var clientid=document.getElementById("clientid").value;
		  		
		  		if(clientid==""){
		  			document.getElementById("errormsg").innerText=" Select Client";
		  			return 0;
		  		}
		  		
		  		 var type=1;
		  		 var rowBoundIndex=0;
	  	 	  $('#cpinfowindow').jqxWindow('open');
	  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowBoundIndex+'&type='+type); 
		   		}
		 });
	  
	  
	  $('#finsdate').on('change', function (event) 
  			{  
  	
  	if($('#finsdate').jqxDateTimeInput('getDate')!=null){
  		var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
  		var status=checkInstdate(date);//Checking Future date.Written on 11-07-2016	
  		if(status){
  			document.getElementById("errormsg").innerText="";
  			return true;
  		}
  		else{
  			$('#finsdate').jqxDateTimeInput('focus');
  			return false;
  		}
  	}
  	});
	  
	  $('#serdate').on('change', function (event) 
	  			{  
	  	
	  	if($('#serdate').jqxDateTimeInput('getDate')!=null){
	  		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
	  		var status=checkScheddate(date);//Checking Future date.Written on 11-07-2016	
	  		if(status){
	  			document.getElementById("errormsg").innerText="";
	  			return true;
	  		}
	  		else{
	  			$('#serdate').jqxDateTimeInput('focus');
	  			return false;
	  		}
	  	}
	  	});
	  
	  
});

function isNumber(evt,id) {
	//Function to restrict characters and enter number only
		  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 document.getElementById("errormsg").innerText="Enter Numbers Only.";
	             $("#"+id+"").focus();
	             return false;
	            
	         }
			
		    document.getElementById("errormsg").innerText="";
	        return true;
	    }

function funmaxlength(value,id){
	if(parseFloat(value)>100){
		 document.getElementById("errormsg").innerText="Enter Numbers Upto 100.";
         $("#"+id+"").focus();
         $("#"+id+"").val(100);
         return false;
	}
	 document.getElementById("errormsg").innerText="";
     return true;
}


function getareas(rowBoundIndex){
	 
	  $('#areainfowindow').jqxWindow('open');

 // $('#accountWindow').jqxWindow('focus');
        areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
     	 }
     	 
function areaSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#areainfowindow').jqxWindow('setContent', data);

            	}); 
  	}
  	
function getserviceteam(rowBoundIndex){
	 
	  $('#serviceteamwindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
      serviceteamContent('serviceteam.jsp?rowBoundIndex='+rowBoundIndex);
   	 }
   	 
function serviceteamContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#serviceteamwindow').jqxWindow('setContent', data);

          	}); 
	}
  	
function schSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#schserchinfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}
  	
function getEnquiry(event){
	 
		var clientid=document.getElementById("clientid").value;
 	
 	if(clientid>0){
 		
 		document.getElementById("errormsg").innerText="";
 		
 	}
 	else{
 		document.getElementById("errormsg").innerText="Select a client";
 		
 		return 0;
 	} 

		var x= event.keyCode;
	 	 if(x==114){
		   
	 		 changeContent('enqMastersearch.jsp');  
		
	    	 }
	 	 else{
	 		 }
	 	 }
	 	 
function getsjobtype() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim()+'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
				 if ($('#hidcmbprocess').val()>0) {
						$('#cmbprocess').val($('#hidcmbprocess').val());
				 } 
			} else {}
		}
		x.open("GET","getsjobtype.jsp", true);
		x.send();
	}
	
function funcomprehensivetext(){
		 
			if($('#cmbprocess').find('option:selected').text()=='Comprehensive'){
				$('#lblThresholdLimit').show();$('#lblPartLimitPerc').show();
				$('#txtthresholdlimit').show();$('#txtpartlimitperc').show();
				if($('#mode').val()!='view'){
					$('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
				}
			} else {
				$('#lblThresholdLimit').hide();$('#lblPartLimitPerc').hide();
				$('#txtthresholdlimit').hide();$('#txtpartlimitperc').hide();
				if($('#mode').val()!='view'){
					$('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
				}
			}
			
	 }
  	
function checkInstdate(date){
	 var date1=new Date(date);
	 date1.setHours(0,0,0,0);
	 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
	 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
	 enddate.setHours(0,0,0,0);
	 
	 if(date1<stdate){
		 
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="First Inst Date Should not less than Start Date";
	     //$('#finsdate').jqxDateTimeInput('setDate', new Date());
	     
		 return false;
	 }
	 else if(date1>enddate){
		 
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="First Inst Date Should not greater than End Date";
	     //$('#finsdate').jqxDateTimeInput('setDate', new Date());
	     
		 return false;
	 }
	 
	 else{
		 document.getElementById("errormsg").innerText="";
		 return true;
	 }
}

function checkScheddate(date){
	 var date1=new Date(date);
	 date1.setHours(0,0,0,0);
	 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
	 stdate.setHours(0,0,0,0);
	 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
	 enddate.setHours(0,0,0,0);
	 
	 if(date1<stdate){
		 
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Service Date Should not less than Start Date";
		 //$('#serdate').jqxDateTimeInput('setDate', new Date());
		 return false;
	 }
 else if(date1>enddate){
		 
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Service Date Should not greater than End Date";
	     //$('#finsdate').jqxDateTimeInput('setDate', new Date());
	     
		 return false;
	 }
	 else{
		 document.getElementById("errormsg").innerText="";
		 return true;
	 }
}


/* function chkdate(date1,date2,date3,id){
	var datee=new Date(date1);
	datee.setHours(0,0,0,0);
	var dates=new Date(date2);
	dates.setHours(0,0,0,0);
	var dated=new Date(date3);
	dated.setHours(0,0,0,0);
	
 if(dated<datee ){
		 if(id>0){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Install Date Should not less than Start Date";
		 }
		 //$('#serdate').jqxDateTimeInput('setDate', new Date());
		 return false;
	 }
	
	
} */
  	
  	
function getsite(rowBoundIndex){
	 
	  $('#siteinfowindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
     var type=1;
      siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&type='+type);
   	 }
   	 
function siteSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#siteinfowindow').jqxWindow('setContent', data);
$('#siteinfowindow').jqxWindow('bringToFront');

          	}); 
	}
  	
  	
  	
function getgrpcode(rowBoundIndex){
	 
	  $('#grpinfowindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
      grpSearchContent('servicegrpsearch.jsp?rowBoundIndex='+rowBoundIndex);
   	 }
   	 
function grpSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#grpinfowindow').jqxWindow('setContent', data);

          	}); 
	}
	
function getteam(rowBoundIndex,assgnid){
	 
	  $('#teaminfowindow').jqxWindow('open');

//$('#accountWindow').jqxWindow('focus');
    teamSearchContent('servicegrptoearch.jsp?rowBoundIndex='+rowBoundIndex+'&assgnid='+assgnid);
 	 }
 	 
function teamSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#teaminfowindow').jqxWindow('setContent', data);

        	}); 
	}
	
	
function getserType(rowBoundIndex,sert){
	 
	  $('#sertypefowindow').jqxWindow('open');

//$('#accountWindow').jqxWindow('focus');
  serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex='+rowBoundIndex+'&sert='+sert);
	 }
	 
function serTypeSearchContent(url) {
//alert(url);
	 $.get(url).done(function (data) {
		 //alert(data);
$('#sertypefowindow').jqxWindow('setContent', data);
$('#sertypefowindow').jqxWindow('bringToFront');

      	}); 
	}



function getclinfo(event){
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
      
      
      function getcontact(event,rowindex){
  	  	
  		var clientid=document.getElementById("clientid").value;
  		
  		if(clientid==""){
  			document.getElementById("errormsg").innerText=" Select Client";
  			return 0;
  		}
  		var x= event.keyCode;
  		 if(x==114){
  			 var type=1;
  	 	  $('#cpinfowindow').jqxWindow('open');
  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowindex+'&type='+type); 
  	        	 }
  		 else{
  			 }
  		 }
  	        	 
  	function cpSearchContent(url) {
  		 //alert(url);
  	 	 $.get(url).done(function (data) {
  				 //alert(data);
  		$('#cpinfowindow').jqxWindow('setContent', data);

  	               	}); 
  	     	}


function funFocus()
{
	//document.getElementById("txtenquiry").focus();
		
}

function funReadOnly(){
	

	
	 $('#frmservicecontract input').attr('readonly', true);
	 $('#frmservicecontract input').attr('disabled', true);
	 $('#frmservicecontract select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $('#stdate').jqxDateTimeInput({ disabled: true});
	 $('#enddate').jqxDateTimeInput({ disabled: true});
	 $('#finsdate').jqxDateTimeInput({ disabled: true});
	 $('#serdate').jqxDateTimeInput({ disabled: true});
	  $("#serviceGrid").jqxGrid({ disabled: true});
	 $("#servscGrid").jqxGrid({ disabled: true});
	 $("#paymentGrid").jqxGrid({ disabled: true});
	 $("#siteGrid").jqxGrid({ disabled: true});
	 $('#btnvaluechange').hide();
	 $('#btnsearch').hide();
	 $('#chkinv').hide();
	 $('#chklblinv').hide();
	 $('#txtprogperiod').attr('readonly', true);
	  $('#txtprogper').attr('readonly', true);
	 if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		
		 $('#docno').attr('disabled', false);
		 $('#mode').attr('disabled', false);
		 $('#hidbrhid').attr('disabled', false);
		document.getElementById("docno").value=mastertrno;
		document.getElementById("mode").value=modes;
		window.parent.branchid.value=brhidview;
		setapprbrch(brhidview);
		 var names = [];
		$("form").each(function() {
		  //alert(this.id);
		   names.push(this.id);
		}); 
		var form=names[0];
		   document.forms[form].submit(); 
		
		   $('#masterdoc_no').attr('disabled', false);
			 $('#mode').attr('disabled', false);
		   		 $('#hidbrhid').attr('disabled', false);
		}
	 	
}

function funRemoveReadOnly(){
	
	 $('#frmservicecontract input').attr('disabled', false);
	 $('#frmservicecontract input').attr('readonly', false);
	 $('#frmservicecontract select').attr('disabled', false);
	 funsercheck();
	 $('#chkinv').hide();
	 $('#chklblinv').hide();
	 $('#temp1').attr('disabled', true);
	 $('#temp2').attr('disabled', true);
	 $('#rrefno').attr('disabled', true);
	 $('#rrefno').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	 $('#txtmob1').attr('readonly', true);
	 $('#txtmob2').attr('readonly', true);
	 $('#txtemail').attr('readonly', true);
	 $('#txtcontact').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#isproformainv').val(0);
	 $("#editval").val(0);
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#stdate').jqxDateTimeInput({ disabled: false});
	 $('#enddate').jqxDateTimeInput({ disabled: false});
	 $('#finsdate').jqxDateTimeInput({ disabled: false});
	 $('#serdate').jqxDateTimeInput({ disabled: false});
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 $("#servscGrid").jqxGrid({ disabled: false});
	 $("#paymentGrid").jqxGrid({ disabled: false});
	 $("#siteGrid").jqxGrid({ disabled: false});
	 funcmbprog();
	 refChange();
	 var islegaldoc=$("#islegaldoc").val();
		
		if(islegaldoc>0){
			document.getElementById("chklegaldoc").checked=true;
			legChange();
		}
		
		if($("#mode").val()=="A"){
			getsjobtype();
			$('#date').jqxDateTimeInput('setDate', new Date());
			 $('#stdate').jqxDateTimeInput('setDate', new Date());
			 $('#enddate').jqxDateTimeInput('setDate', new Date());
 			$('#finsdate').jqxDateTimeInput('setDate', new Date());
			 $('#serdate').jqxDateTimeInput('setDate', new Date());
			$("#installments").val(0);
			$("#paydueafter").val(0);
			$("#srvcinterval").val(0);
			$("#serdueafter").val(0);
			$("#txttaxper").val(0);
			funRoundAmt(0,"txtcntrval");
			$("#salesincentive").val(0);
			$("#incentive").val(0);
			
			$("#serviceGrid").jqxGrid('clear');
			$("#serviceGrid").jqxGrid('addrow', null, {});
			$("#servscGrid").jqxGrid('clear');
			$("#servscGrid").jqxGrid('addrow', null, {});
			$("#paymentGrid").jqxGrid('clear');
			$("#paymentGrid").jqxGrid('addrow', null, {});
			$("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
		}
		else if($("#mode").val()=="E"){
			funsercheck();
			 $('#btnvaluechange').show();
			 $("#serviceGrid").jqxGrid({ disabled: true});
			 $("#servscGrid").jqxGrid({ disabled: true});
			 $("#paymentGrid").jqxGrid({ disabled: true});
			 $("#siteGrid").jqxGrid({ disabled: true});
			 var chkserv=$("#chkserv").val();
			 if(chkserv>0){
					$('#chkserv').attr('disabled', true);
			
				}
			 
		}
	
}


function funwarningopen(){
	
	if($("#mode").val()=="E"){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    	  
	    	   $("#serviceGrid").jqxGrid({ disabled: false});
				 $("#servscGrid").jqxGrid({ disabled: false});
				 $("#paymentGrid").jqxGrid({ disabled: false});
				 $("#siteGrid").jqxGrid({ disabled: false});
				 $("#editval").val(1);
	       }
	       else{
	    	   
	    	   $("#serviceGrid").jqxGrid({ disabled: true});
				 $("#servscGrid").jqxGrid({ disabled: true});
				 $("#paymentGrid").jqxGrid({ disabled: true});
				 $("#siteGrid").jqxGrid({ disabled: true});
				 $("#editval").val(0);
				 
	       }
	       
	      });
	   
	 } 
	   }

function funpay(){
	
	var startdate=$("#finsdate").val();
	var stdate=$("#stdate").val();
	var enddate=$("#enddate").val();
	var amount=$("#txtcntrval").val();
	var instno=$("#installments").val();
	var cmbpaytype=$("#cmbpaytype").val();
	var paydueafter=$("#paydueafter").val();
	document.getElementById("cvalchnge").value=0;
	if($("#mode").val()=="E"){
		$("#editval").val(1);
	}
	if($('#finsdate').jqxDateTimeInput('getDate')!=null){
	
  		var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
  		var status=checkInstdate(date);//Checking Future date.Written on 11-07-2016	
  		
  		if(status){
  			document.getElementById("errormsg").innerText="";
  			
  			 $("#paydiv").load("paymentGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&paydueafter="+paydueafter+"&gridload=1");
  		}
  		
  	}
 
}


function funscheduler(){
	
	var startdate=$("#serdate").val();
	var enddate=$("#enddate").val();
	var stdate=$("#stdate").val();
	var amount=0;
	var instno=$("#srvcinterval").val();
	var cmbpaytype=$("#cmbsrvctype").val();
	var serdueafter=$("#serdueafter").val();
	
	
	if($('#serdate').jqxDateTimeInput('getDate')!=null){
  		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
  		var status=checkScheddate(date);//Checking Future date.Written on 11-07-2016	
  		
  		if(status){
  			$("#schediv").load("serviceScheduleGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&serdueafter="+serdueafter+"&gridload=1");
  		}
  		
  	}
	
	/*  $("#schediv").load("serviceScheduleGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&serdueafter="+serdueafter+"&gridload=1"); */
}


function funNotify(){
	
	if($('#cmbprog').val()==2)
	{
		if($('#txtprogperiod').val()=="" || $('#txtprogper').val()=="" || $('#txtprogperiod').val()==0 || $('#txtprogper').val()==0){  
	document.getElementById("errormsg").innerText="Progressive With Retention , Period And Percentage Mandatory ";
	return 0;
		}
	}
	
	
	if($('#clientid').val()== "")
	{
	document.getElementById("errormsg").innerText="select Client";
	return 0;
	}
	$('#chkserv').attr('disabled', false);
	/* if($('#cpersonid').val()== "")
	{
	document.getElementById("errormsg").innerText="select Contact Person";
	return 0;
	} */
	
	if($('#txtcntrval').val()== "")
	{
	document.getElementById("errormsg").innerText="Enter contract value";
	return 0;
	}
	
 
	 var rows1 = $("#paymentGrid").jqxGrid('getrows');
     var rows2 = $("#serviceGrid").jqxGrid('getrows');
	 var rows3 = $("#siteGrid").jqxGrid('getrows');
	 var rows4 = $("#servscGrid").jqxGrid('getrows');
	 var cvalchnge=$("#cvalchnge").val();
	 var msgid=0;
	 if(cvalchnge>0){
		 document.getElementById("errormsg").innerText="Contract value Changed,Payment data showuld be changed";
			return 0;
	 }
	 $('#paymentlen').val(rows1.length);
	 $('#servicelen').val(rows2.length);
	 $('#sitelen').val(rows3.length);
	 $('#serviceSchedulelen').val(rows4.length);
	
	   
	 for(var i=0 ; i < rows3.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "site"+i)
		       .attr("name", "site"+i)
		       .attr("hidden", "true"); 
		    if($('#siteGrid').jqxGrid('iscolumnvisible', 'serviceteam'))
			 {
		    if((rows3[i].site!="undefined" && rows3[i].site!=null && rows3[i].site!="" ))
		    	{
		    	if(rows3[i].steamid=="undefined" || rows3[i].steamid==null || rows3[i].steamid=="")
		    		{
		    	msgid++;
		    	break;
		    		}
		    	}
}
		   newTextBox.val(rows3[i].site+" :: "+rows3[i].areaid+" :: "+rows3[i].siteadd+" :: "+rows3[i].contid+" :: "+rows3[i].rowno+" :: "+rows3[i].steamid+" :: ");
		   newTextBox.appendTo('form');
		  
				}
if($('#siteGrid').jqxGrid('iscolumnvisible', 'serviceteam'))
			 {	 
	 
	 if(msgid>0)
		 {
		 document.getElementById("errormsg").innerText="Service Team Is Mandatory In Site Details";
			return 0;
		 }
}
	   for(var i=0 ; i < rows1.length ; i++){
			
		   var dueafterser="";
		   
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "pay"+i)
		       .attr("name", "pay"+i)
		       .attr("hidden", "true"); 
		    
		    if (rows1[i].terms =="LEGAL DOCUMENT") {
		    	dueafterser=99;
			}
		    if (rows1[i].terms =="SERVICE") {
		    	dueafterser=rows1[i].service;
			}
		    if (rows1[i].terms =="PROFORMA INVOICE") {
		    	dueafterser=98;
		    	document.getElementById("isproformainv").value=1;
			}
		 
		   newTextBox.val(rows1[i].duedate+" :: "+rows1[i].amount+" :: "+rows1[i].runtotal+" :: "+rows1[i].desc1+" :: "+rows1[i].terms+" :: "+dueafterser+" :: "+rows1[i].service+" :: "+rows1[i].rowno+" :: ");
		
		   newTextBox.appendTo('form');
		  
				}
	   
	  
		
	   for(var i=0 ; i < rows2.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "service"+i)
		       .attr("name", "service"+i)
		       .attr("hidden", "true"); 
		    
		   
		    
		   newTextBox.val(rows2[i].stypeid+" :: "+rows2[i].item+" :: "+rows2[i].qty+" :: "+rows2[i].amount+" :: "+rows2[i].total+" :: "+rows2[i].desc1+" :: "+rows2[i].trno+" :: "+rows2[i].srno+" :: ");
		
		   newTextBox.appendTo('form');
		  
				}
			
        for(var i=0 ; i < rows4.length ; i++){
		   
		   var dis=0;
		   var valu=0;
		   var chkserv=document.getElementById("chkserv").value;
			 
			  newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "sersc"+i)
		       .attr("name", "sersc"+i)
		       .attr("hidden", "true");
			  
			  
			  if (rows4[i].priority == true) {
					dis=1;
				}
			  
			  
			  var d=new Date(rows4[i].pltime);
			  var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
			  
			  
			  if(chkserv==0){
				  
		      newTextBox.val(rows4[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows4[i].trno+" :: "+rows4[i].type+" :: ");
		   
			  }
			  
			  else if(chkserv==1){
				  
				  newTextBox.val(rows4[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows4[i].serviceid+"::"+rows4[i].siteid+"::"+rows4[i].value+"::"+rows4[i].trno+" :: "+rows4[i].type+" :: ");
			  } 
		   
		   newTextBox.appendTo('form');
		  
				}
		
		
	
		return 1;
} 

function refChange(){
	 var reftype=$('#cmbreftype').val();

	 if(reftype=='DIR'){
		  
		  $('#rrefno').attr('disabled', true);
	 }
	 else{
		  
		  $('#rrefno').attr('disabled', false);
	 }
	 
	}
	
	
function legChange(){
	 if(document.getElementById("chklegaldoc").checked){
		 
		 document.getElementById("islegaldoc").value=1;
		 $('#temp1').attr('disabled', false);
		 $('#temp2').attr('disabled', false);
		 $('#temp2').attr('readonly', true);
	 }
	 else{
		 document.getElementById("islegaldoc").value=0;
		 $('#temp1').attr('disabled', true);
		 $('#temp2').attr('disabled', true);
	 }
	 
	}
	
	
	
	function setValues(){
		
	//	funcmbprog();
		var docno=$("#masterdoc_no").val();
		var islegaldoc=$("#islegaldoc").val();
		
		var chkincltax=$("#chkincltax").val();
		var chkserv=$("#chkserv").val();
		
		
		if(islegaldoc>0){
			document.getElementById("chklegaldoc").checked=true;
			legChange();
		}
		if(chkincltax>0){
			document.getElementById("chkincltax").checked=true;
		}
		if(chkserv>0){
			document.getElementById("chkserv").checked=true;
			$('#chkserv').attr('disabled', true);
			var chkinv=$("#chkinv").val();
			if(chkinv>0){
				document.getElementById("chkinv").checked=true;
			}
			
			funsercheck();
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		if($('#hidcmbsrvctype').val()!="")
		  {  
		  $('#cmbsrvctype').val($('#hidcmbsrvctype').val());
		  }
		
		if($('#hidcmbpaytype').val()!="")
		  {  
		  $('#cmbpaytype').val($('#hidcmbpaytype').val());
		  }
		
		if($('#hidcmbreftype').val()!="")
		  {  
		  $('#cmbreftype').val($('#hidcmbreftype').val());
		  }
		if($('#hidcmbprog').val()!="")
		  {  
		  $('#cmbprog').val($('#hidcmbprog').val());
		 // funcmbprog();
		  }
		/* if(document.getElementById("hidcontredit").value=="1"){
		    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
	  } else {
		    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
	  } */
		if(docno>0){
			
			 $("#schediv").load("serviceScheduleGrid.jsp?docno="+docno);
			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 $("#paydiv").load("paymentGrid.jsp?docno="+docno);
			 $("#serdiv").load("serviceGrid.jsp?docno="+docno);
		}
		 funSetlabel();funchkforedit();
		
	}
	function funchkforedit()
    {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
				{
					$("#btnEdit").attr('disabled', true );
					$("#btnDelete").attr('disabled', true ); 
					
				}
				else
				{
				}
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?docno="+document.getElementById("masterdoc_no").value, true);
		x.send();
	}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	
	function cvalChnge(){
		if($("#mode").val()=="E"){
			
			document.getElementById("cvalchnge").value=1;
			$("#editval").val(1);
			document.getElementById("errormsg").innerText="Contract value Changed,Payment details should be changed";
			 
			
		}
	}
	
	
	
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {

				 $("#docno").prop("disabled", false);
				 $("#masterdoc_no").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#masterdoc_no').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		var reurl=url.split("com/"); 
		     
		  		
		  		 var win= window.open(reurl[0]+"printAmcContract?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					  win.focus(); 
		  			  	/*  var win= window.open(reurl[0]+"PRINTamcContract?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
		  	  		win.focus(); */
		        /* $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						  var win= window.open(reurl[0]+"printAmcContract?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						 var win= window.open(reurl[0]+"printAmcContract?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
		        }); */
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
  }
	  
	  
	  function daycheck(){
		  
		  var aid=0;
	
		 if(document.getElementById("mon").checked){
			 aid=aid+0+",";
		  }
		 if(document.getElementById("tue").checked){
			 aid=aid+1+",";	  
		 }
		 if(document.getElementById("wed").checked){
			 aid=aid+2+",";
		 }
		 if(document.getElementById("thu").checked){
			 aid=aid+3+",";
		 }
		 if(document.getElementById("fri").checked){
			 aid=aid+4+",";
		 }
		 if(document.getElementById("sat").checked){
			 aid=aid+5+",";
		 }
		 if(document.getElementById("sun").checked){
			 aid=aid+6+",";
		 }
		 
		 document.getElementById("cmbsrvday").value=aid;
		  
	  }
	  
	  
	  function schSearch(){
		  
		  
		  
		  $('#schserchinfowindow').jqxWindow('open');
		  schSearchContent('scheduleSearch.jsp');
	  }
	  
	  
	  function funsercheck(){
		  
		 var chkserv=document.getElementById("chkserv").value;
		  if(chkserv==1){
		  $('#btnsearch').show();
		  $('#chkinv').show();
		  $('#chklblinv').show();
		  $('#srvcinterval').attr('disabled', true);
		  $('#serdueafter').attr('disabled', true);
		  $('#cmbsrvctype').attr('disabled', true);
		 // $('#serdate').jqxDateTimeInput({ disabled: true});
		  $('#btnSchAdd').hide();
		  $('#servscGrid').jqxGrid('showcolumn','site');
		  $('#servscGrid').jqxGrid('showcolumn','service');
		  $('#servscGrid').jqxGrid('showcolumn','value');
		  $('#servscGrid').jqxGrid('showcolumn','site');
		  $('#servscGrid').jqxGrid('showcolumn','days');
		  
		  }
		  else{
			  $('#chkinv').hide();
			  $('#chklblinv').hide();
			  
			  $('#btnSchAdd').show();
			  $('#srvcinterval').attr('disabled', false);
			  $('#serdueafter').attr('disabled', false);
			  $('#cmbsrvctype').attr('disabled', false);
			 // $('#serdate').jqxDateTimeInput({ disabled: false});
			  $('#btnsearch').hide();
			  //$('#servscGrid').jqxGrid('hidecolumn','site');
			  $('#servscGrid').jqxGrid('hidecolumn','service');
			  $('#servscGrid').jqxGrid('hidecolumn','value');
			  //$('#servscGrid').jqxGrid('hidecolumn','site');
			  $('#servscGrid').jqxGrid('hidecolumn','days');
		  }
		  
	  }
	function funcmbprog()
	{
		var cmbprog=document.getElementById("cmbprog").value;
		
	 if(cmbprog==2)
		{
		 $('#txtprogperiod').attr('readonly', false);
		  $('#txtprogper').attr('readonly', false);
		}
	 else{
		 $('#txtprogperiod').val(0);
		  $('#txtprogper').val(0);
		 $('#txtprogperiod').attr('readonly', true);
		  $('#txtprogper').attr('readonly', true);
	 }
	}
	 
 function chkprogressive()
		    {
		     
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      var items= x.responseText.trim();
			     
			      if(parseInt(items)>0)
			       {
			    	 
			    	  
			    	  $('#prog').show();
			    	 
			    	  
			        }
			          else
			      {
			        	  $('#prog').hide();
			        	 
				    	  
			      
			      }
			      
			       }}
			   x.open("GET","checkprogressive.jsp?",true);
				x.send();
			 
			      
			        
		    	
		    }   
	  
</script>
</head>

<body onLoad="setValues();funcmbprog();chkprogressive();getsjobtype();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmservicecontract" action="saveServicecontract" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
        <br>
		<div class='hidden-scrollbar'>

<body>
	<table width="100%">
    <tr>
      <td width="10%" align="right">Date</td>
      <td width="17%"><div id="date" name="date" value='<s:property value="date" />'></div></td>
      <td width="12%" align="right">Ref  No</td>
      <td width="30%"><input type="text"  name="txtrefno"  value='<s:property value="txtrefno" />' id="txtrefno"></td>
      <td width="18%" align="right">Doc No</td>
      <td width="13%"><input type="text" name="docno" value='<s:property value="docno" />' id="docno" tabindex="-1" readonly></td>
    </tr>
	  <tr>
	    <td colspan="6"><fieldset><legend>Client Details</legend>
        <table width="100%">
  <tr>
    <td width="10%" align="right">Client</td>
    <td width="19%"><input type="text" name="txtclient" id="txtclient" style="width:95%;" placeholder="Press F3 for Search" onKeyDown="getclinfo(event);" value='<s:property value="txtclient" />'></td>
    <td width="10%" align="right">Client Details</td>
    <td width="36%"><input type="text" name="txtclientdet" id="txtclientdet" style="width:90%;" value='<s:property value="txtclientdet" />'></td>
  </tr>
  <tr>
    <td align="right">Tele.</td>
    <td><input type="text" name="txtmob1" id="txtmob1" style="width:70%;" value='<s:property value="txtmob1" />'></td>
    <td align="right">Mobile</td>
    <td colspan="3"><input type="text" name="txtmob2" id="txtmob2" style="width:16%;" value='<s:property value="txtmob2" />'>
    <label>Sales Man</label>
    <input type="text" name="txtsalman" id="txtsalman" style="width:30%;" value='<s:property value="txtsalman" />'></td>
  </tr>
  <tr>
    <td align="right">Mail</td>
    <td><input type="text" name="txtemail" id="txtemail" style="width:95%;"  value='<s:property value="txtemail" />'></td>
    <td align="right">Contact Person</td>
    <td><input type="text" name="txtcontact" id="txtcontact" placeholder="Press F3 for Search" style="width:90%;" onKeyDown="getcontact(event,0);" value='<s:property value="txtcontact" />'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

        </fieldset> 
        </td>
      </tr>
<tr>                            
<td colspan="6">
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Type</td>
    <td width="8%"><select name="cmbprocess" id="cmbprocess" style="width:100%;" name="cmbprocess" onchange="funcomprehensivetext();"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /></td>
  <td >&nbsp;</td> 
    <td width="7%" align="right"> <label id="lblThresholdLimit">Threshold Limit</label></td>
    <td width="7%"><input type="text" id="txtthresholdlimit" name="txtthresholdlimit" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" value='<s:property value="txtthresholdlimit"/>'/></td>
    
    <td width="7%" align="right"><label id="lblPartLimitPerc">Part Limit %</label></td>
    <td width="7%"><input type="text" id="txtpartlimitperc" name="txtpartlimitperc" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funmaxlength(this.value,this.id);" value='<s:property value="txtpartlimitperc"/>'/></td>
   <%--  <td width="6%" align="right">Ref. Type</td>
    <td width="5%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="SQOT">SQOT</option>
      <option value="ENQ">ENQ</option>
      </select></td>
    <td width="10%"><input type="text" id="rrefno" name="rrefno" placeholder="Press F3 to Search" style="width:90%;"  onKeyDown="getEnquiry(event);" value='<s:property value="rrefno"/>'/></td>
  --%>  
 
    <td width="7%" align="right">Contract Value</td>
    <td width="7%"><input type="text" id="txtcntrval" name="txtcntrval" style="text-align: right;" onKeyUp="cvalChnge();" onchange="funwarningopen();" onblur="funRoundAmt(this.value,this.id);"  value='<s:property value="txtcntrval"/>'/></td>
    <td width="7%" align="center">Incl tax
    <input type="checkbox" name="chkincltax" id="chkincltax" value='<s:property value="chkincltax" />' onclick="$(this).attr('value', this.checked ? 1 : 0);"></td>
     <%--  <td width="6%" align="right">Tax Per</td>
    <td width="7%"><input type="text" id="txttaxper" name="txttaxper"  value='<s:property value="txttaxper"/>' /></td>   --%>
  </tr>
  <tr>
    <td align="right"><input type="checkbox" name="chklegaldoc" id="chklegaldoc"  onchange="legChange();">
      <label for="chklegaldoc">Legal Fee</label></td>
    <td><input type="text" id="temp1" name="temp1" value='<s:property value="temp1"/>'/></td>
    <td><input type="text" id="temp2" name="temp2" value='<s:property value="temp2"/>' /></td>
  <%--   <td align="right">St.Date</td>
    <td><div id="stdate" name="stdate" value='<s:property value="stdate" />'></div></td>
    <td align="right">End Date</td>
    <td><div id="enddate" name="enddate" value='<s:property value="enddate" />'></div></td>
     --%><td align="right">Incentive</td>
    <td><input type="text" name="incentive" id="incentive" value='<s:property value="incentive"/>'></td>
    <td align="right">Sales Incentive</td>
    <td> <input type="text" name="salesincentive" id="salesincentive" value='<s:property value="salesincentive"/>'></td>
     <td width="9%" align="right">Budget</td>
     <td width="14%"><input type="text" id="txtbudget" name="txtbudget" style="text-align: right;"  value='<s:property value="txtbudget"/>'/></td>
    <td colspan="3" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
  <tr>
     <td width="6%" align="right">Ref. Type</td>
     <td width="5%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="SQOT">SQOT</option>
      <option value="ENQ">ENQ</option>
      </select></td>
      <td width="10%"><input type="text" id="rrefno" name="rrefno" placeholder="Press F3 to Search" style="width:90%;"  onKeyDown="getEnquiry(event);" value='<s:property value="rrefno"/>'/></td>
      <td align="right">St.Date</td>
    <td><div id="stdate" name="stdate" value='<s:property value="stdate" />'></div></td>
    <td align="right">End Date</td>
    <td><div id="enddate" name="enddate" value='<s:property value="enddate" />'></div></td>
    
      
  </tr>
  
</table>
  </fieldset>
</td>
      </tr>
      
      <table width="100%">

    <tr>
    <td>
    <fieldset><legend>Site Details</legend>
    <div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
    </fieldset>
    </td>
  </tr> 
  
  <tr>
    <td>
    
     <fieldset><legend>Payment Details</legend>
  <table width="100%">
  <tr>
    <td width="10%" align="right">Installments</td>
    <td width="11%"><input type="text" name="installments" id="installments" value='<s:property value="installments"/>'></td>
    <td width="12%" align="right">Due After</td>
    <td width="9%"><input type="text" name="paydueafter" id="paydueafter" value='<s:property value="paydueafter"/>'></td>
    <td width="12%" align="right">Frequency</td>
    <td width="14%"><select name="cmbpaytype" id="cmbpaytype" style="width:98%;">
      <option value="1">DAYS</option>
      <option value="2">MONTHS</option>
      <option value="3">YEAR</option>
    </select></td>
    <td width="15%" align="right">First Inst.On</td>
    <td width="17%" align="left"><div id="finsdate" name="finsdate" value='<s:property value="finsdate" />'></div></td>
    <td width="17%" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funpay();">Fill</button></td>
  </tr>
  
    <tr id="prog">
    <td  align="right">Terms</td>
    <td ><select id="cmbprog" name="cmbprog" style="width:150px;" onchange="funcmbprog();" value='<s:property value="cmbprog"/>'>
      <option value="">--Select--</option>
      <option value="1">PROGRESSIVE</option>
      <option value="2">PROGRESSIVE WITH RETENTION</option>
      </select></td>
    <td  align="right">Period(in months)</td>
    <td ><input type="text" id="txtprogperiod" name="txtprogperiod" value='<s:property value="txtprogperiod"/>'/></td>
   <td  align="right">Percentage</td>
    <td ><input type="text" id="txtprogper" name="txtprogper" value='<s:property value="txtprogper"/>'/></td>
    <td align="right">&nbsp;</td>
    <td >&nbsp;</td> 
  </tr>
  
  
</table>
    
     <div id="paydiv"><jsp:include page="paymentGrid.jsp"></jsp:include></div>
     </fieldset></td>
     
  </tr>
 
   <tr>
    <td>
    <fieldset><legend>Service Details</legend>
    <table width="100%" >
  <tr>
    <td width="10%" align="right">Special Instruction</td>
    <td>
     <input type="text" id="txtsplinstruct" name="txtsplinstruct" style="width:800px;" value='<s:property value="txtsplinstruct"/>'/>
   </td>
   </tr>
   </table>
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
    
  </tr> 
  
    <tr>
    <td>
    <fieldset><legend>Service Scheduler</legend>
    <div id="schserdiv">
   <table width="100%">
  	<tr>
  	<td width="7%" align="center"><label for="chkserv">Service </label><input type="checkbox" name="chkserv" id="chkserv" value='<s:property value="chkserv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);funsercheck();"></td>
  	<td width="7%" align="center"><label id="chklblinv">To Be Invoiced </label><input type="checkbox" name="chkinv" id="chkinv" value='<s:property value="chkinv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);"></td></div>
  	<td width="7%" align="center"><button class="myButton" type="button" id="btnsearch" name="btnsearch" onclick="schSearch();">Search</button></td>
  	<td width="4%" align="right">Interval</td>
    <td width="12%"><input type="text" name="srvcinterval" id="srvcinterval" value='<s:property value="srvcinterval"/>'></td>
    <td width="4%" align="right">Due After</td>
    <td width="12%"><input type="text" name="serdueafter" id="serdueafter" value='<s:property value="serdueafter"/>'></td>
    <td width="4%" align="right">Frequency</td>
    <td width="8%"><select name="cmbsrvctype" id="cmbsrvctype" style="width:80%;">
      <option value="1">DAYS</option>
      <option value="2">MONTHS</option>
      <option value="3">YEAR</option>
    </select></td>
    <td width="8%" align="right">Service Start On</td>
    <td width="9%" align="left"><div id="serdate" name="serdate" value='<s:property value="serdate" />'></div></td>
    <td width="9%" align="center"><button class="myButton" type="button" id="btnSchAdd" name="btnSchAdd" onclick="funscheduler();">Fill</button></td>
   </tr>
</table></div>

    <div id="schediv"><jsp:include page="serviceScheduleGrid.jsp"></jsp:include></div>
     </fieldset></td>
    
  </tr> 
 
 <tr>
 <td>
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="islegaldoc" name="islegaldoc"  value='<s:property value="islegaldoc"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
    <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no"  value='<s:property value="refmasterdoc_no"/>'/>
    <input type="hidden" id="cpersonid" name="cpersonid"  value='<s:property value="cpersonid"/>'/>
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype"  value='<s:property value="hidcmbpaytype"/>'/>
    <input type="hidden" id="hidcmbsrvctype" name="hidcmbsrvctype"  value='<s:property value="hidcmbsrvctype"/>'/>
    <input type="hidden" id="hidcmbreftype" name="hidcmbreftype"  value='<s:property value="hidcmbreftype"/>'/>
    <input type="hidden" id="hidcmbprog" name="hidcmbprog"  value='<s:property value="hidcmbprog"/>'/>
    <input type="hidden" id="rrefdoc_no" name="rrefdoc_no"  value='<s:property value="rrefdoc_no"/>'/>
    <input type="hidden" id="serviceSchedulelen" name="serviceSchedulelen"  value='<s:property value="serviceSchedulelen"/>'/>
    <input type="hidden" id="servicelen" name="servicelen"  value='<s:property value="servicelen"/>'/>
    <input type="hidden" id="paymentlen" name="paymentlen"  value='<s:property value="paymentlen"/>'/>
    <input type="hidden" id="sitelen" name="sitelen"  value='<s:property value="sitelen"/>'/>
    <input type="hidden" id="isproformainv" name="isproformainv"  value='<s:property value="isproformainv"/>'/>
    <input type="hidden" id="salid" name="salid"  value='<s:property value="salid"/>'/>
    <input type="hidden" id="editval" name="editval"  value='<s:property value="editval"/>'/>
    <input type="hidden" id="cvalchnge" name="cvalchnge"  value='<s:property value="cvalchnge"/>'/>
    <input type="hidden" id="cmbsrvday" name="cmbsrvday"  value='<s:property value="cmbsrvday"/>'/>
    <input type="hidden" id="hidsiteid" name="hidsiteid"  value='<s:property value="hidsiteid"/>'/>
     <input type="hidden" id="hidcontredit" name="hidcontredit"  value='<s:property value="hidcontredit"/>'/> 
    <input type="hidden" id="hidbrhid" name="hidbrhid"  value='<s:property value="hidbrhid"/>'/>
 </td>
 </tr>
</table>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="areainfowindow">
   <div ></div>
</div>
<div id="grpinfowindow">
   <div ></div>
</div>
<div id="teaminfowindow">
   <div ></div>
</div>
<div id="sertypefowindow">
   <div ></div>
</div>
<div id="cpinfowindow">
   <div ></div>
   </div>
   <div id="siteinfowindow">
   <div ></div>
   </div>
   <div id="schserchinfowindow">
   <div ></div>
   </div>
    <div id="serviceteamwindow">
   <div ></div>
   </div>
   
</form>
</div>     
</body>
</html>
