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
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $("#trialDiv").hide();
	     document.getElementById("hidchckincludingzero").value=0;
	     getTrialBalancePrintConfig();
	});
	
	function getTrialBalancePrintConfig(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    
  			  	if(parseInt(items)==1){
  				 	 $("#btnprint").show();
	  			 } else {
	  				 $("#btnprint").hide();
  				 }
  		}
  		}
  		x.open("GET", "getTrialBalancePrintConfig.jsp", true);
  		x.send();
    }
	
	function funExportBtn(){
		
		// 
		JSONToCSVCon(exceldata, 'Trial Balance', true);
	    /* $("#trialBalanceDiv").excelexportjs({
	    	containerid: "trialBalanceDiv", 
	    	datatype: 'json', 
	    	dataset: null, 
	    	gridId: "trialBalance", 
	    	columns: getColumns("trialBalance") ,               
	    	worksheetName:"Trial Balance"
	    	}); */
	} 
    
	function includingzerocheck(){
		 if(document.getElementById("chckincludingzero").checked){
			 document.getElementById("hidchckincludingzero").value = 1;
		 }
		 else{
			 document.getElementById("hidchckincludingzero").value = 0;
		 }
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var acctype = $('#cmbtype').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#trialBalanceDiv").load("trialBalanceGrid.jsp?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1');
		}

	function funPrint(){
		var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var acctype = $('#cmbtype').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
				var url=document.URL;
				var reurl=url.split("com");
				/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
				var path= "com/dashboard/accounts/trialbalance/trialbalancelist.action?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1';
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
				win.focus();		
			 
			
		}
	function disableprint() {
		$('#btnprint').attr("disabled",true);
	}
	
</script>
</head>
<body onload="getBranch();disableprint();">
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
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2"><input type="checkbox" id="chckincludingzero" name="chckincludingzero" value="" onchange="includingzerocheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
      <input type="hidden" id="hidchckincludingzero" name="hidchckincludingzero" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidchckincludingzero"/>'/></td></tr> 
	 <tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" value='<s:property value="cmbtype"/>'>
    <option value="">All</option><option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option>
    <option value="HR">HR</option></select></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><button type="button" class="myButton" id="btnprint" onclick="funPrint();">Print</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
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
			 <td><div id="trialBalanceDiv"><jsp:include page="trialBalanceGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="trialDiv" hidden="true">
<table width="100%">
<tr>
        <td width="98%" align="right"><input type="text" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
        <td width="2%">&nbsp;</td>
</tr>
</table>
</div>
</div>
</div>
</body>
</html>