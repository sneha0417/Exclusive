
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


    
     
   
});

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var rentaltype=document.getElementById("rentaltype").value;
	   $("#overlay, #PleaseWait").show();
	  $("#cradfwdiv").load("cardfollowupGrid.jsp?barchval="+barchval+'&type='+rentaltype);
	
	
	}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(expdata, 'Card Block Followup', true);
		 } else {
			 $("#followup").jqxGrid('exportdata', 'xls', 'Card Block Followup');
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
	  <tr>
	  
	<td align="left" colspan="2"><table><tr><td><label class="branch">Rental Type&nbsp;&nbsp;&nbsp;</label></td>
            <td align="left"><select id="rentaltype" name="rentaltype"  value='<s:property value="rentaltype"/>'>
     <!--  <option value="">--Select--</option> -->
       <option value="RAG">Rental</option>
        <option value="LAG">Lease</option>
      
      
      </select></td></tr></table></td>
	</tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 

	<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="cradfwdiv"><jsp:include page="cardfollowupGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
</html>