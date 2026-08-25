
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	  
});

function funExportBtn(){
	   $("#orderlist").jqxGrid('exportdata', 'xls', 'Puchase Order List');
	 }


function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
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
	 var statusselect=$("#statusselect").val();
	   $("#overlay, #PleaseWait").show();
	  $("#enqlistdiv").load("orderlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect);
	
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
 
	 	<tr ><td align="right" > <label class="branch">Status</label></td> <td ><select id="statusselect" name="statusselect" style="width:70%;">
	<option value="All">All</option>
	<option value="PED">Pending</option>
		<option value="PUH">Purchase</option>   
		<option value="CLS">Close</option>	
	
	 </select> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
  


 <tr><td colspan="2">&nbsp;</td></tr> 
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="enqlistdiv"><jsp:include page="orderlistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>