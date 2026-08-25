<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
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
	  // setType(null);
	   document.getElementById("rdomonthwise").disabled=true;
	   document.getElementById("rdomonthwise").style.display="none";
	   document.getElementById("lblmonthwise").style.display="none";
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",disabled:true});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",disabled:true});
	 $('#clientwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientsearchwindow').jqxWindow('close');
	   $('#salesagentwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#salesagentwindow').jqxWindow('close');
	   $('#rentalagentwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#rentalagentwindow').jqxWindow('close');
	   $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   $('#chartwindow').jqxWindow({ width: '52%',height: '65%',  maxHeight: '65%'  ,maxWidth: '52%' , title: 'Chart' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
	   $('#chartwindow').jqxWindow('close');
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
      
});


function getClient(){
	 
   	  $('#clientsearchwindow').jqxWindow('open');
 		$('#clientsearchwindow').jqxWindow('focus');
 		 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
  
}


function getClientcat(){
	 
  	  $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientcatSearchContent('clientCatSearch.jsp?id=1', $('#clientwindow'));
 
}

function getSalesAgent(){
	
	  $('#salesagentwindow').jqxWindow('open');
		$('#salesagentwindow').jqxWindow('focus');
		 salesagentSearchContent('salesAgentSearch.jsp?id=1', $('#salesagentwindow'));

}

function getRentalAgent(){

	  $('#rentalagentwindow').jqxWindow('open');
		$('#rentalagentwindow').jqxWindow('focus');
		 rentalagentSearchContent('rentalAgentSearch.jsp?id=1', $('#rentalagentwindow'));
}


function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}

	
function clientcatSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientsearchwindow').jqxWindow('setContent', data);

}); 
}

function salesagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#salesagentwindow').jqxWindow('setContent', data);

}); 
}

function rentalagentSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#rentalagentwindow').jqxWindow('setContent', data);

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

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){

     if(document.getElementById("hidrdobetweendates").value=="0" && document.getElementById("hidrdomonthwise").value=="0"){
    	 $.messager.alert('Warning','Monthwise/Period is Mandatory');
    	 return false;
     }
     
     var branch=document.getElementById("cmbbranch").value;
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
     var grpby1=document.getElementById("grpby1").value;
     var hidclientcat=document.getElementById("hidclientcat").value;
     var hidclient=document.getElementById("hidclient").value;
     var hidsalesman=document.getElementById("hidsalesman").value;
     var hidrentalagent=document.getElementById("hidrentalagent").value;
     var hidbrand=document.getElementById("hidbrand").value;
     var hidmodel=document.getElementById("hidmodel").value;
     var hidgroup=document.getElementById("hidgroup").value;
     var hidyom=document.getElementById("hidyom").value;
     var distribution=document.getElementById("distribution").value;
     var cmbfrequency='';
     if(distribution=='branchwise'){
    	 cmbfrequency='1';
     }
     else if(distribution=='monthwise'){
    	 cmbfrequency='2';
     }
     else if(distribution=='quarterwise'){
    	 cmbfrequency='3';
     }
     else if(distribution=='yearwise'){
    	 cmbfrequency='4';
     }
     else if(distribution=='clientcat'){
    	 cmbfrequency='5';
     }
     else if(distribution=='salesman'){
    	 cmbfrequency='6';
     }
     else if(distribution=='rentalagent'){
    	 cmbfrequency='7';
     }
     else if(distribution=='brand'){
    	 cmbfrequency='8';
     }
     else if(distribution=='model'){
    	 cmbfrequency='9';
     }
     else if(distribution=='group'){
    	 cmbfrequency='10';
     }
     else if(distribution=='yom'){
    	 cmbfrequency='11';
     }
     else{
    	 
    	 
     }
     if(document.getElementById("grpby1").value==document.getElementById("distribution").value && (document.getElementById("grpby1").value!='' && document.getElementById("distribution").value!='')){
    	 $.messager.alert('Warning','Grouping and Distribution cannot be Same');
    	 document.getElementById("distribution").focus();
    	 return false;
     }
   //  if(document.getElementById("hidrdobetweendates").value=="1"){
    	 
    	 if($('#distribution').val()!=''){
    		if($('#distribution').val()=='quarterwise'){
    			var d1=$('#fromdate').jqxDateTimeInput('getDate');
       		 var d2=$('#todate').jqxDateTimeInput('getDate');
       		 months = (d2.getFullYear() - d1.getFullYear()) * 12;
       		    months -= d1.getMonth() + 1;
       		    months += d2.getMonth();
       		    months=months <= 0 ? 0 : months;
       		    
       		    if(months<3){
       		    	$.messager.alert('Warning','Quarterwise must contain minimum 3 months');
       		    	return false;
       		    }
       		 	
    		}
    		    $("#overlay, #PleaseWait").show();
    		$('#distributiondiv').show();
    		$('#salesinvoicediv').hide();
    		
    		 $("#distributiondiv").load("salesMonthwiseGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&distribution="+cmbfrequency+"&check=1&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidrentalagent="+hidrentalagent);
    	 }
    	 else{
    		
    		 $("#overlay, #PleaseWait").show();
    		 $('#distributiondiv').hide();
     		$('#salesinvoicediv').show();
     		
    		 $("#salesinvoicediv").load("salesInvListGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidrentalagent="+hidrentalagent+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1");	 
    	 }
    	  
   //  }

	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		 var value=document.getElementById("rdobetweendates").value;
		 document.getElementById("rdobetweendates").checked=true;
		 setType(value);
		 document.getElementById("rdobetweendates").style.display="none";
		 document.getElementById("lblbetweendates").style.display="none";
	//	 $('#salesbranchwisediv').hide();
	}
	function funExportBtn(){
		JSONToCSVCon(invoicedatedata, 'Sales', true);
		// $("#salesInvListGrid").jqxGrid('exportdata', 'xls', 'Sales Invoices');
		 //alert(invoicedata);
	   // window.open('data:application/vnd.ms-excel,' + invoicedata);
	    //e.preventDefault();
	    
		
	}
	function setType(value){
		if(value=="dates"){
			$('#fromdate').jqxDateTimeInput({disabled:false});
			$('#todate').jqxDateTimeInput({disabled:false});
			document.getElementById("hidrdobetweendates").value="1";
			document.getElementById("hidrdomonthwise").value="0";
		}
		else if(value=="monthwise"){
			if($('#fromdate').jqxDateTimeInput('disabled')==false){
				$('#fromdate').jqxDateTimeInput({disabled:true});
				$('#todate').jqxDateTimeInput({disabled:true});
				document.getElementById("hidrdobetweendates").value="1";
				document.getElementById("hidrdomonthwise").value="0";
			
			}
		}
		else{
			
			document.getElementById("hidrdobetweendates").value="0";
			document.getElementById("hidrdomonthwise").value="0";
		}
	}
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
	//	$('input[type=radio]').prop("checked", false);
		$('textarea').val('');
		$('#grpby1').val('');
		$('#searchby').val('');
		$('#distribution').val('');
		
	}
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientcat();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="salesman"){
			getSalesAgent();
		}
		else if(value=="rentalagent"){
			getRentalAgent();
		}
		else if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else{
			
		}



	}
	function setRemove(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientcat").value="";
			document.getElementById("hidclientcat").value="";
			document.getElementById("searchdetails").value=document.getElementById("client").value;
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			
		}
		else if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}		
			}
		else if(value=="rentalagent"){
			document.getElementById("searchdetails").value="";
			document.getElementById("rentalagent").value="";
			document.getElementById("hidrentalagent").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}	
		}
		else if(value=="salesman"){
			document.getElementById("searchdetails").value="";
			document.getElementById("salesman").value="";
			document.getElementById("hidsalesman").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}	
		}
		else if(value=="brand"){
			document.getElementById("searchdetails").value="";
			document.getElementById("brand").value="";
			document.getElementById("hidbrand").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";
			document.getElementById("model").value="";
			document.getElementById("hidmodel").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";
			document.getElementById("group").value="";
			document.getElementById("hidgroup").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";
			document.getElementById("yom").value="";
			document.getElementById("hidyom").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("rentalagent").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("rentalagent").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
		}
	}
function getChart(){
	var grpby1=document.getElementById("grpby1").value;
	if(grpby1==""){
		$.messager.alert('warning','Please Select a Grouping');
		return false;
	}
	if(grpby1=="client"){
		$.messager.alert('warning','Client cannot be shown on chart');
		return false;
	}  
	  
	$('#chartwindow').jqxWindow('open');
	$('#chartwindow').jqxWindow('focus');
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
    var branch=document.getElementById("cmbbranch").value;
    chartSearchContent('chartSearch.jsp?id=1&grpby1='+grpby1+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch, $('#chartwindow'));
	 //var chartOffset = $('#saleschart1').offset();
	// $("#loadingImage").css({ "display": "block", "left": (chartOffset.left + $("#saleschart1").width() / 2 - 16), "top": (chartOffset.top + $("#saleschart1").height() / 2 - 16) });
	 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
}

function chartSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#chartwindow').jqxWindow('setContent', data);

}); 
}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
<tr><td colspan="2" align="center"><input type="radio" name="rdotype" id="rdomonthwise" value="monthwise" onchange="setType(this.value);">&nbsp;<label class="branch" id="lblmonthwise">Monthwise</label>&nbsp;
<input type="radio" name="rdotype" id="rdobetweendates" value="dates" onchange="setType(this.value);" onclick="setType(this.value);">&nbsp;<label class="branch" id="lblbetweendates">Period</label>
</td></tr>
<input type="hidden" name="hidrdobetweendates" id="hidrdobetweendates"/>
<input type="hidden" name="hidrdomonthwise" id="hidrdomonthwise"/>
<tr>
  <td colspan="2">
  <table width="100%">
  <tr>
    <td width="29%" align="right"><label class="branch">Grouping</label></td>
    <td width="71%" align="left"><select name="grpby1" id="grpby1">
    <option value="">--Select--</option>
    <option value="clientcat">Client Category</option>
    <option value="client">Client</option>
    <option value="salesman">Salesman</option>
    <option value="rentalagent">Rental Agent</option>
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    </select>
    </td>
  </tr>
  <tr>
    <td width="29%" align="right"><label class="branch">Distribution</label></td>
    <td width="71%" align="left"><select name="distribution" id="distribution">
    <option value="">--Select--</option>
    <option value="branchwise">Branchwise</option>
    <option value="monthwise">Monthwise</option>
    <option value="quarterwise">Quarterwise</option>
    <option value="yearwise">Yearwise</option>
    <option value="clientcat">Client Category</option>
    <option value="salesman">Salesman</option>
    <option value="rentalagent">Rental Agent</option>
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    </select>&nbsp;&nbsp;<input type="button" name="btnChart" id="btnChart" value="Chart" onclick="getChart();" class="myButtons" style="display:none;">
    </td>
  </tr>
</table>
</td>
</tr>

	<tr >
	  <td align="right"><label class="branch">Filter</label></td>
	  <td  align="left"><select name="searchby" id="searchby">
<option value="">--Select--</option>
    <option value="clientcat">Client Category</option>
    <option value="client">Client</option>
    <option value="salesman">Salesman</option>
    <option value="rentalagent">Rental Agent</option>
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;" rows="18" cols="50" readonly></textarea></td>
	  </tr>
	<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
		<tr><td>&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="salesinvoicediv"><jsp:include page="salesInvListGrid.jsp"></jsp:include></div>
			 <div id="distributiondiv"  hidden="true"><jsp:include page="salesMonthwiseGrid.jsp"></jsp:include></div>
			 
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidclientcat" id="hidclientcat">
			  <input type="hidden" name="hidclient" id="hidclient">
			  <input type="hidden" name="hidgroup" id="hidgroup">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidrentalagent" id="hidrentalagent">
			  <input type="hidden" name="hidsalesman" id="hidsalesman">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="clientcat" id="clientcat">
			  <input type="hidden" name="client" id="client">
			  <input type="hidden" name="group" id="group">
			  <input type="hidden" name="model" id="model">
			  <input type="hidden" name="rentalagent" id="rentalagent">
			  <input type="hidden" name="salesman" id="salesman">
			  <input type="hidden" name="yom" id="yom">
			  <input type="hidden" name="brand" id="brand">
			 </td>
			 
		</tr>
		
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="clientsearchwindow">
<div></div>
</div>
<div id="salesagentwindow">
<div></div>
</div>
<div id="rentalagentwindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="groupwindow">
<div></div>
</div>
<div id="yomwindow">
<div></div>
</div>
<div id="chartwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;" /></div>
</div>
</div>
</form>
</body>
</html>