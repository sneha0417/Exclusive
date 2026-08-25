<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdpayment").checked=true;
	     document.getElementById("rdall").checked=true;
	     document.getElementById("chckunclrposted").checked = false;
	     $('#chckunclrposted').attr('disabled', true);
 		 $('#hidchckunclrposted').val('0');
	     
		 $('#txtaccid').dblclick(function(){
			 if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
			  accountsSearchContent('accountsDetailsSearch.jsp');
			});
		 
			 document.getElementById('rdall').addEventListener('change', function (e) {
				 $('#cmbcriteria').attr('disabled', false);
				 document.getElementById("chckunclrposted").checked = false;
		 		 $('#hidchckunclrposted').val('0');
		 		 $('#chckunclrposted').attr('disabled', true);
			 });
			 
			 document.getElementById('rdpdc').addEventListener('change', function (e) {
				 $('#cmbcriteria').attr('disabled', false);
				 document.getElementById("chckunclrposted").checked = false;
		 		 $('#hidchckunclrposted').val('0');
		 		 $('#chckunclrposted').attr('disabled', true);
			 });
			 
			 document.getElementById('rduncleared').addEventListener('change', function (e) {
				 $('#cmbcriteria').attr('disabled', true);
				 $('#cmbcriteria').val('1');
		 		 document.getElementById("chckunclrposted").checked = false;
		 		 $('#hidchckunclrposted').val('0');
		 		 $('#chckunclrposted').attr('disabled', false);
			 });

	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
    		if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	 function dateDisable(){
		 var posted=$('#cmbcriteria').val();
         if(posted==2){
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
         }else{
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
         }
	  }
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }

	}
	
	function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("rdpayment").checked=true;
		document.getElementById("rdall").checked=true;
		
		$('#cmbbranch').val('a');$('#cmbcriteria').val('1');$('#cmbcriteria').attr('disabled', false);
		$('#cmbdistribution').val('');$('#cmbgroup').val('');$('#cmbtype').val('0');
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		$('#hidchckunclrposted').val('0');$('#chckunclrposted').attr('disabled', false);
		document.getElementById("chckunclrposted").checked = false;
		
		$("#jqxPdcList").jqxGrid('clear');
		$("#jqxPdcList").jqxGrid('addrow', null, {});
		$("#jqxPdcListGroup").jqxGrid('clear');
		$("#jqxDistributionGrid").jqxGrid('clear');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		$("#pdcListDiv").prop("hidden", false);
   	 	$("#pdcListGroupDiv").prop("hidden", true);
   	    $("#pdcListDistributionDiv").prop("hidden", true);
   	    
		}

	function funreload(event){
		     funGroupDistributionGrid();
		     
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 var criteria = $('#cmbcriteria').val();
			 var distribution = $('#cmbdistribution').val();
			 var group = $('#cmbgroup').val();
			 var acctype = $('#cmbtype').val();
			 var accno = $('#txtdocno').val();
			 var unclrposted = $('#hidchckunclrposted').val();
			 var reporttype = "";
			 
			 if(document.getElementById("rdall").checked==true){
				 reporttype = $('#rdall').val();
			 }else if(document.getElementById("rdpdc").checked==true){
				 reporttype = $('#rdpdc').val();
			 }else if(document.getElementById("rduncleared").checked==true){
				 reporttype = $('#rduncleared').val();
			 }
			 
			 $("#overlay, #PleaseWait").show();
			 
			 if(document.getElementById("rdreceipt").checked==true){
				 if(group=='' && distribution==''){
					  $("#pdcListDiv").load("pdcListGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');								 
			     }else if(group!='' && distribution==''){
			    	 $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
				 }else{
					 $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
				 }
			 }else{
				 if(group=='' && distribution==''){
					  $("#pdcListDiv").load("pdcListGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');								 
			     }else if(group!='' && distribution==''){
			    	 $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
				 }else{
					 $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
				 }
			    }
			}
	
	function funGroupDistributionGrid(){
		var group=$('#cmbgroup').val();
		var distribution=$('#cmbdistribution').val();
		if(group=='' && distribution==''){
			$("#pdcListDiv").prop("hidden", false);
       	 	$("#pdcListGroupDiv").prop("hidden", true);
       	    $("#pdcListDistributionDiv").prop("hidden", true);
        }else if(group!='' && distribution==''){
       	 	$("#pdcListDiv").prop("hidden", true); 
       	 	$("#pdcListGroupDiv").prop("hidden", false);
       	    $("#pdcListDistributionDiv").prop("hidden", true);
        }else{
        	$("#pdcListDiv").prop("hidden", true); 
       	 	$("#pdcListGroupDiv").prop("hidden", true);
       	    $("#pdcListDistributionDiv").prop("hidden", false);
        }
	}
	
	function checkunclrposted() {
		if(document.getElementById("chckunclrposted").checked) {
			 document.getElementById("hidchckunclrposted").value = 1;
		 } else {
			 document.getElementById("hidchckunclrposted").value = 0;
		 }
	 }
	
	function funExportBtn(){
		 var distribute = $('#cmbdistribution').val();
		 var grouping = $('#cmbgroup').val();
		 
		if(grouping=='' && distribute==''){
    		if(parseInt(window.parent.chkexportdata.value)=="1") {
    		  	JSONToCSVCon(data, 'PdcList', true);
    		 } else {
    			 $("#jqxPdcList").jqxGrid('exportdata', 'xls', 'PdcList');
    		 }
    	}

		if(grouping!='' && distribute==''){
    		if(parseInt(window.parent.chkexportdata.value)=="1") {
    		  	JSONToCSVCon(data1, 'PdcList', true);
    		 } else {
    			 $("#jqxPdcListGroup").jqxGrid('exportdata', 'xls', 'PdcList');
    		 }
	  	}
		
		if(!((grouping=='' && distribute=='') && (grouping!='' && distribute==''))){
			if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data3, 'PdcList', true);
			 } else {
				 $("#jqxDistributionGrid").jqxGrid('exportdata', 'xls', 'PdcList');
			 }
	 	}
	}
	function funprint(){
		var url=document.URL;
		var reurl=url.split("com");
		var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var criteria = $('#cmbcriteria').val();
		 var distribution = $('#cmbdistribution').val();
		 var group = $('#cmbgroup').val();
		 var acctype = $('#cmbtype').val();
		 var accno = $('#txtdocno').val();
		 var unclrposted = $('#hidchckunclrposted').val();
		 var reporttype = "";
		 
		 if(document.getElementById("rdall").checked==true){
			 reporttype = $('#rdall').val();
		 }else if(document.getElementById("rdpdc").checked==true){
			 reporttype = $('#rdpdc').val();
		 }else if(document.getElementById("rduncleared").checked==true){
			 reporttype = $('#rduncleared').val();
		 }
		//alert(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?branch="+document.getElementById("cmbbranch").value+"&fromdate="+fromdate+"&todate="+todate+"&reporttype="+reporttype+"&criteria="+criteria+"&distribution="+distribution+"&group="+group+"&acctype="+acctype+"&accno="+accno);
		 
		//var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?branchval="+branchval+"&fromdate="+fromdate+"&todate="+todate+"&reporttype="+reporttype+"&criteria="+criteria+"&distribution="+distribution+"&group="+group+"&acctype="+acctype+"&accno="+accno,"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
		
		if(document.getElementById("rdreceipt").checked==true){
			var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
		 }else{
			 var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
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
    <tr><td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>  
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdpayment" name="rdo" value="FPP"><label for="rdpayment" class="branch">Payment</label></td>
       <td width="52%" align="center"><input type="radio" id="rdreceipt" name="rdo" value="FRO"><label for="rdreceipt" class="branch">Receipt</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdall" name="rdos" value="rdall"><label for="rdall" class="branch">All</label></td>
       <td width="52%" align="center"><input type="radio" id="rdpdc" name="rdos" value="rdpdc"><label for="rdpdc" class="branch">PDC</label></td>
       </tr>
       <tr>
       <td colspan="2" align="center"><input type="radio" id="rduncleared" name="rdos" value="rduncleared"><label for="rduncleared" class="branch">Uncleared</label>&nbsp;&nbsp;
       <input type="checkbox" id="chckunclrposted" name="chckunclrposted" value="" onchange="checkunclrposted();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Uncleared Posted</label>
	    <input type="hidden" id="hidchckunclrposted" name="hidchckunclrposted" value='<s:property value="hidchckunclrposted"/>'/></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td align="right"><label class="branch">Criteria</label></td>
	<td align="left"><select id="cmbcriteria" name="cmbcriteria" style="width:75%;" onchange="dateDisable();" value='<s:property value="cmbcriteria"/>'>
    <option value="1">All</option><option value="2">To be Posted</option><option value="3">Posted PDC</option>
    <option value="4">Returned PDC</option><option value="5">Dishonoured PDC</option></select></td></tr>
    <tr><td align="right"><label class="branch">Distribution</label></td>
	<td align="left"><select id="cmbdistribution" name="cmbdistribution" style="width:60%;" value='<s:property value="cmbdistribution"/>'>
    <option value="">--Select--</option><option value="monthwise">Month-Wise</option><option value="bankwise">Bank-Wise</option></select></td></tr>
    <tr><td align="right"><label class="branch">Grouping</label></td>
	<td align="left"><select id="cmbgroup" name="cmbgroup" style="width:40%;" value='<s:property value="cmbgroup"/>'>
    <option value="">--Select--</option><option value="date">Date</option><option value="month">Month</option>
    <option value="bank">Bank</option></select></td></tr> 
	<tr><td align="right"><label class="branch">Acc. Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="0">--Select--</option><option value="BANK">Bank</option><option value="AP">AP</option><option value="AR">AR</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;
    <input type="button" class="myButtons" name="Print" id="print"  value="print" onclick="funprint();"></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="pdcListDiv"><jsp:include page="pdcListGrid.jsp"></jsp:include></div>
			 <div id="pdcListGroupDiv" hidden="true"><jsp:include page="pdcListGroupingGrid.jsp"></jsp:include></div>
			 <div id="pdcListDistributionDiv" hidden="true"><jsp:include page="pdcListDistributionGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>