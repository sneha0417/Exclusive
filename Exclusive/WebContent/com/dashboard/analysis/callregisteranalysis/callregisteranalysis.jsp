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
<%
	String contextPath=request.getContextPath();
 %>
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
		$('#sumloadgriddata').hide();
		$('#callregisterSumDiv').show();
		$('#callregisterDetDiv').hide();
		 document.getElementById('rsumm').checked=true;
		  $('#summs').show();
	      $('#detial').hide();
		 
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		  $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#clientDetailsWindow').jqxWindow({width: '55%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#clientDetailsWindow').jqxWindow('close');
  		 
  		$('#docnowindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Docno' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#docnowindow').jqxWindow('close');

		   $('#typewindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Type' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#typewindow').jqxWindow('close');
  		 
		   $('#clwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#clwindow').jqxWindow('close');
  		 
         $('#vehicleWindow').jqxWindow({width: '25%', height: '53%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#vehicleWindow').jqxWindow('close'); 
 		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		    
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			  }  
		 }); 
 		$('#txtclientname').dblclick(function(){
 		   
 	    	 $('#clientDetailsWindow').jqxWindow('open');
 	    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientDetailsWindow')); 
 			   		
 			 });
 	     $('#txtvehicle').dblclick(function(){
 			  $('#vehicleWindow').jqxWindow('open');
 		      vehSearchContent('SearchVeh.jsp?', $('#vehicleWindow'));
 			  });
	});

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
	  
		           $('#clientDetailsWindow').jqxWindow('setContent', data);

	    	}); 
	         	}
	     
	     function getvehinfo(event){
	     	 var x= event.keyCode;
	     	 if(x==114){
	     	  $('#vehicleWindow').jqxWindow('open');
	     
	       
	      vehSearchContent('SearchVeh.jsp?', $('#vehicleWindow')); }
	     	 else{
	     		 }
	     	 }

	  function vehSearchContent(url) {
	               //alert(url);
	                 $.get(url).done(function (data) {
	        //alert(data);
		           $('#vehicleWindow').jqxWindow('setContent', data);

	       	}); 
	   }
	  
	  function getdocnodetails(brhid,tr_no){
			 
		  $('#docnowindow').jqxWindow('open');
	
	      docnoSearchContent('docnoPopUpGrid.jsp?brhid='+brhid+'&docno='+tr_no);
	   	 }
		
		function docnoSearchContent(url) {
			
			 $.get(url).done(function (data) {
				
		$('#docnowindow').jqxWindow('setContent', data);
		
		           	}); 
		 	}
	  
		function gettypedetails(type){
			 
			  
		      typeSearchContent('typePopUpGrid.jsp?type='+type);
		   	 }
			
			function typeSearchContent(url) {
				$('#typewindow').jqxWindow('open');
				 $.get(url).done(function (data) {
				$('#typewindow').jqxWindow('setContent', data);
			
			           	}); 
			 	}
			function getclientdetails(client){
				 
				 
			      clSearchContent('clientPopUpGrid.jsp?client='+client);
			   	 }
				
				function clSearchContent(url) {
					 $('#clwindow').jqxWindow('open');
					 $.get(url).done(function (data) {
					 $('#clwindow').jqxWindow('setContent', data);
				
				           	}); 
				 	}
	function funExportBtn(){

		 }
	

			
			
			function funClearData(){
				//$('#txtrepeated').val('');
				$('#txtsumtype').val('docno');
				$('#txtvehicle').val('');
				$('#txtclientname').val('');
				$('#cmbtype').val('');
				$('#secGrid').jqxGrid('clear');
				$('#callregisterDetGridID').jqxGrid('clear');
				$('#callregisterSumGridID').jqxGrid('clear');
				funsumm();
			}
	 	
 	 function funsumm(){
 		
 		var summtype=document.getElementById("txtsumtype").value;
		 		
 		
 			if(summtype=="client" ||summtype=="type")
				{
				$('#callregisterSumDiv').hide();
				$('#callregisterDetDiv').hide();
				$('#sumloadgriddata').show();
				
				}
			
			else if(summtype=="docno")
				{
				$('#callregisterDetDiv').hide();
				$('#callregisterSumDiv').show();
				$('#sumloadgriddata').hide();
				}
			else{
				
				$('#callregisterDetDiv').hide();
				$('#callregisterSumDiv').hide();
				$('#sumloadgriddata').show();
			}
 		
 		
			if(summtype=="client")
			{
			
				$('#secGrid').jqxGrid('hidecolumn', 'type');
				$('#secGrid').jqxGrid('showcolumn', 'client');
			}
		else{
			$('#secGrid').jqxGrid('showcolumn', 'type');
			$('#secGrid').jqxGrid('hidecolumn', 'client');
		}

 	 }
			
			
	function funreload(event){
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));


		//out date
			 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 
		if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		return false;
		       } 
		else
			   {
			 var barchval = document.getElementById("cmbbranch").value;
		     var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 var clientid=$('#txtclientdocno').val();
			 var vehno=$('#txtvehicle').val();
			 var type=document.getElementById("cmbtype").value;
			 var summtype=document.getElementById("txtsumtype").value;
		 		
			 var repeated=document.getElementById("txtrepeated").value;
				//alert(repeated);
			 $("#overlay, #PleaseWait").show();
			 
				if(document.getElementById('rsumm').checked && summtype=="docno")
				{
					  $("#callregisterSumDiv").load("callregGridSummary.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&vehno="+vehno+"&type="+type+"&repeated="+repeated+"&summtype="+summtype);
				}
				
				
				else if(document.getElementById('rdet').checked)
				{
					
						$("#callregisterDetDiv").load("callregGridDetail.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&vehno="+vehno+"&type="+type+"&repeated="+repeated);
					
				}
				else{
					
				}
				
				if(summtype=="client" || summtype=="type" ) {
					
					 $("#sumloadgriddata").load("secGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&vehno="+vehno+"&type="+type+"&repeated="+repeated+"&summtype="+summtype);
	
				 }

				else{
					
				}
			   }	 
		}

	function fundisable(){
		
		if (document.getElementById('rsumm').checked) {
			  $('#callregisterSumDiv').show();
			   $('#callregisterDetDiv').hide();
			   $('#sumloadgriddata').hide();
				  $('#summs').show();
				  $('#detial').hide();
			}
		 else if (document.getElementById('rdet').checked) {
			  $('#callregisterSumDiv').hide();
			  $('#callregisterDetDiv').show();
			  $('#sumloadgriddata').hide();
			  $('#summs').hide();
			  $('#detial').show();
			}   
		 }
   
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2" align="center">
	 <input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail</label></td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' ></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	  <tr>
	   <td align="right"><label class="branch">Client</label></td>  
       <td><input type="text" id="txtclientname" name="txtclientname" style="height:20px;" onKeyDown="getclinfo(event);" readonly  placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>'/>
       <input type="hidden" id="txtclientdocno" name="txtclientdocno" style="height:20px;" value='<s:property value="txtclientdocno"/>'/></td>
	  </tr>
	  <tr>  
	   <td align="right"><label class="branch">Vehicle</label></td>
      <td><input type="text" id="txtvehicle" name="txtvehicle"  value='<s:property value="txtvehicle"/>'  style="height:20px;" onKeyDown="getvehinfo(event);" readonly  placeholder="Press F3 to Search"/>
      <input type="hidden" id="txtvehicleno" name="txtvehicleno" style="height:20px;" value='<s:property value="txtvehicleno"/>'/></td>
	  </tr>
	
	 <tr>  
    <td align="right"><label class="branch">Type</label></td>
    <td width="24%"><select id="cmbtype" name="cmbtype" style="width:68%;height:20px;"  value='<s:property value="cmbtype"/>'>
      <option value=''>-- Select --</option><option value='1'>Break Down</option><option value='2'>Accident</option>
      <option value='3'>Registration</option><option value='4'>Traffic Inbounding</option><option value='5'>New Enquiry</option><option value='6'>Other</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
	  </tr>
	  <tr>
	   <td align="right"><label class="branch">Repeated</label></td>
<%--      <td width="14%"><input type="checkbox" id="txtrepeated" onchange="check();" name="txtrepeated" value='<s:property value="txtrepeated"/>' tabindex="-1"/></td> --%>
	 <td width="14%"><select id="txtrepeated" name="txtrepeated" style="width:68%;height:20px;"  value='<s:property value="txtrepeated"/>'>
	 <option value='ALL'>ALL</option><option value='1'>YES</option>
      <option value='0'>NO</option></select>
	  </tr> 
	  <tr>
	   <td align="right"><label class="branch">Summ Type</label></td>
<%--      <td width="14%"><input type="checkbox" id="txtrepeated" onchange="check();" name="txtrepeated" value='<s:property value="txtrepeated"/>' tabindex="-1"/></td> --%>
	 <td width="14%"><select id="txtsumtype" name="txtsumtype" onchange="funsumm();" style="width:68%;height:20px;"  value='<s:property value="txtsumtype"/>'>
	 <option value='docno'>Docno</option>
	 <option value='client'>Client</option>
	 <option value='type'>Type</option>
      
      </select>
	  </tr> 
	  <tr>
	<td colspan="2"  align="center">
	 
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
    </td>
	</tr>
	  	<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
	</table>   
	</fieldset>
</td>

<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="callregisterSumDiv"><jsp:include page="callregGridSummary.jsp"></jsp:include></div></td>
		</tr>
		    <tr><td><div id="callregisterDetDiv">
				 <jsp:include page="callregGridDetail.jsp"></jsp:include> 
				</div></td></tr> 
				<tr>
			  <td><div id="sumloadgriddata"  ><jsp:include page="secGrid.jsp"></jsp:include></div></td>
			 
		</tr>
		
	</table>
</tr>
</table>
<div id="clientDetailsWindow">
   <div></div>
</div>
<div id="vehicleWindow">
   <div></div>
</div>
<div id="docnowindow">
   <div ></div>
</div>
<div id="typewindow">
   <div ></div>
</div>
<div id="clwindow">
   <div ></div>
</div>
</div>
</div>
</body>
</html>