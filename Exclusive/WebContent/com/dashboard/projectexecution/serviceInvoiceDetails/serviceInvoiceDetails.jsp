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
		
		$('#serInvDiv').show();
		 $('#serInvDetDiv').hide();
		  /* $('#rdet').hide(); */
		 
		 
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#contractwindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#contractwindow').jqxWindow('close');
		  
		$('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#siteinfowindow').jqxWindow('close');
	    
	    $('#statusinfowindow').jqxWindow({ width: '20%', height: '35%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Status Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#statusinfowindow').jqxWindow('close');
			  
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		
		  $('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#sertypefowindow').jqxWindow('close');
	     
		  var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
	});

	function funExportBtn(){
		 if (document.getElementById('rsumm').checked) {
			 
			 JSONToCSVCon(excelsummarydata,'Service Invoice Details(Summary)',true);
			  
			 }
			 
			 if (document.getElementById('rdet').checked) {
				 
				 JSONToCSVCon(exceldetaildata,'Service Invoice Details(Detail)',true);
				 
				 }
		
		 }
	
	
	function funreload(event){


		var prodvalue=$('#filterby').val().trim();
		
		var sertypeid;
		var branchid;
		var siteid;
		var statusid;
		var contractid;
		var clientid;
		var grpby;
		var frmdate;
		var todate;
	
		sertypeid=document.getElementById("hidsertypeid").value;
		siteid=document.getElementById("hidsiteid").value;
		statusid=document.getElementById("hidstatusid").value;
		contractid=document.getElementById("hidcontractid").value;
		clientid=document.getElementById("hidclientid").value; 
		branchid=document.getElementById("cmbbranch").value; 
		grpby=$('#grpby').val().trim();
		var id=1;
			 frmdate=$('#fromdate').jqxDateTimeInput('val');
			 //document.getElementById("fromdate").value;
			 todate=$('#todate').jqxDateTimeInput('val');
			 
			 
			 if (!(document.getElementById('rsumm').checked || document.getElementById('rdet').checked)) {
				   
				   $.messager.alert('Message','Select Summary /Detail','warning');
				   return false;
			   }
		
			 if (document.getElementById('rsumm').checked) {
				 
			   $('#serInvDiv').show();		
		       $("#overlay, #PleaseWait").show();
		 
		 $("#serInvDiv").load("serviceInvoiceGridSummary.jsp?todate="+todate+"&frmdate="+frmdate+"&sertypeid="+sertypeid+"&siteid="+siteid+"&statusid="+statusid+"&contractid="+contractid+"&clientid="+clientid+"&branchid="+branchid+"&grpby="+grpby+"&id="+id+"&type=1");
			 }
			 
			 if (document.getElementById('rdet').checked) {
				 
				   $('#serInvDetDiv').show();		
			       $("#overlay, #PleaseWait").show();
			 
			 $("#serInvDetDiv").load("serviceInvoiceGridDetail.jsp?todate="+todate+"&frmdate="+frmdate+"&sertypeid="+sertypeid+"&siteid="+siteid+"&statusid="+statusid+"&contractid="+contractid+"&clientid="+clientid+"&branchid="+branchid+"&grpby="+grpby+"&id="+id+"&type=2");
				 }
			 
			 
		}
	
	function setprodSearch(){
		var value=$('#filterby').val().trim();

		if(value=="client"){
			getclinfo();
		}
		else if(value=="site"){
			getsite();
		}
		else if(value=="service"){
			getserType();
		}
		else if(value=="contract"){
			getcontract();
		}
		else if(value=="status"){
			getstatus();
		}
		else{
			
		}
	}
	
	
	 function getsite(){
    	
		  $('#siteinfowindow').jqxWindow('open');
	      siteSearchContent('servicesitesearch.jsp');
		
	   	 }
	   	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#siteinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
	
	function getstatus(){
    	
		  $('#statusinfowindow').jqxWindow('open');
		  statusSearchContent('servicestatus.jsp');
		
	   	 }
	
	function statusSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#statusinfowindow').jqxWindow('setContent', data);

		          	}); 
			}
	
	function getserType(){
		 
		  $('#sertypefowindow').jqxWindow('open');
	  serTypeSearchContent('servicetypesearch.jsp');
		 }
		 
	function serTypeSearchContent(url) {
		 $.get(url).done(function (data) {
	$('#sertypefowindow').jqxWindow('setContent', data);

	      	}); 
		}
	
	
	function getclinfo(){
		
		  $('#clientsearch1').jqxWindow('open');
		 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
		
		 } 
	     function clientSearchContent(url) {
	           
	               $.get(url).done(function (data) {
	  
		           $('#clientsearch1').jqxWindow('setContent', data);

	    	}); 
	         	}
	     
	     function getcontract(){

		 		var cldocno=document.getElementById("hidclientid").value;
		
			 		 $('#contractwindow').jqxWindow('open');
			 		// changeContent('contractMastersearch.jsp');  
			 		 contractSearchContent('contractDetailsSearch.jsp?cldocno='+cldocno, $('#contractwindow'));
			    	
			 	 }
			    	 
			function contractSearchContent(url) {
				 $.get(url).done(function (data) {
				$('#contractwindow').jqxWindow('setContent', data);
			           	}); 
			 	}
	
	function fundisable(){
		
		if (document.getElementById('rsumm').checked) {
			
			  $('#serInvDiv').show();
			   $('#serInvDetDiv').hide();
			   $('#lblgrpby').show();
			   $('#grpby').show();
			  
			}
		 else if (document.getElementById('rdet').checked) {
			 
			  $('#serInvDiv').hide();
			  $('#serInvDetDiv').show();
			  $('#lblgrpby').hide();
			   $('#grpby').hide();
			 
			}
		 }
	
	function funClearData(){
		
		 
		 document.getElementById("hidsertypeid").value="";
		 document.getElementById("hidsiteid").value="";
		 document.getElementById("hidstatusid").value="";
		 document.getElementById("hidcontractid").value="";
		 document.getElementById("hidclientid").value=""; 
		 document.getElementById("hidsertype").value="";
		 document.getElementById("hidsite").value="";
		 document.getElementById("hidstatus").value="";
		 document.getElementById("hidcontract").value="";
		 document.getElementById("hidclient").value="";
		 document.getElementById("searchdetails").value="";
		 document.getElementById("cmbbranch").value="a";
		 
		 $("#jqxSerInvSummaryGrid").jqxGrid('clear'); 
		 $("#jqxSerInvDetailGrid").jqxGrid('clear');
			
		 
	}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail</label></td></tr>
	 <tr>
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' ></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	 <tr >
	  <td align="right"><label class="branch" id="lblgrpby">Group By</label></td>
	  <td  align="left"><select name="grpby" id="grpby" style="width:52%;">
<option value="">--Select--</option>
    <option value="site">SITE</option>
    <option value="service">SERVICE</option>
    <option value="status">STATUS</option>
    </select>
    </td>
    </tr>  
	  <tr >
	  <td align="right" width="25%"><label class="branch">Filter By</label></td>
	  <td  align="left"><select name="filterby" id="filterby" style="width:52%;">
<option value="">--Select--</option>
    <option value="service">SERVICE</option>
    <option value="site">SITE</option>
    <option value="status">STATUS</option>
    <option value="contract">CONTRACT</option>
    <option value="client">CLIENT</option>
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
	
			<tr><td>
			  <input type="hidden" name="hidsertypeid" id="hidsertypeid">
			  <input type="hidden" name="hidsiteid" id="hidsiteid">
			  <input type="hidden" name="hidstatusid" id="hidstatusid">
			  <input type="hidden" name="hidcontractid" id="hidcontractid">
			  <input type="hidden" name="hidclientid" id="hidclientid">
			 
			  <input type="hidden" name="hidsertype" id="hidsertype">
			  <input type="hidden" name="hidsite" id="hidsite">
			  <input type="hidden" name="hidstatus" id="hidstatus">
			  <input type="hidden" name="hidcontract" id="hidcontract">
			  <input type="hidden" name="hidclient" id="hidclient">
			  </td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="serInvDiv"><jsp:include page="serviceInvoiceGridSummary.jsp"></jsp:include></div></td>
		</tr>
		    <tr><td><div id="serInvDetDiv">
				 <jsp:include page="serviceInvoiceGridDetail.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
</tr>
</table>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="sertypefowindow">
   <div ></div>
</div>
<div id="siteinfowindow">
   <div ></div>
   </div>
   <div id="statusinfowindow">
   <div ></div>
   </div>
   <div id="contractwindow">
   <div ></div>
   </div>
</div>
</div>
</body>
</html>