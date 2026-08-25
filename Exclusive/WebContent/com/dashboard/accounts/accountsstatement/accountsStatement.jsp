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
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
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
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
		 
		 $('#txtaccid').dblclick(function(){
			  if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
			});
		 
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
		JSONToCSVCon(dataExcelExport, 'AccountsStatement', true);
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
	
	function getAccountingPeriod(date){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtaccountperiodfrom').val(items);
  		}
  		}
  		x.open("GET", "getAccountingPeriod.jsp?fromDate="+date, true);
  		x.send();
 }
	
	function getAccountFromPeriod(){
		
		 var date = $('#fromdate').val();
		 getAccountingPeriod(date);
			  
	 		if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		   }
		
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function funreload(event){
		
		if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		   }
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var acctype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 
		if(acctype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 if(accdocno==''){
			 $.messager.alert('Message','Account is Mandatory.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$('#txtaccname').val(); 
		 $("#accountsStatementDiv").load("accountsStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&check=1');
		}
	
	function funPrintAccountStatement(){
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("accountsStatement.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAccountsStatement?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmAccountStatement" action="saveAccountStatement" method="post" autocomplete="off">
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
     <td align="left"><div id="fromdate" name="fromdate" onchange="getAccountFromPeriod();" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option>
    <option value="HR">HR</option></select></td></tr>
    
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnPrintAccount" name="btnPrintAccount" onclick="funPrintAccountStatement(event);">Account Statement</button></td></tr>
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
	    <tr><td><label class="account">Account :&nbsp;</label><label class="accname" name="lblaccountname" id="lblaccountname"></label></td></tr> 
		<tr>
			 <td><div id="accountsStatementDiv"><jsp:include page="accountsStatementGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<table width="100%">
<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
</tr>
</table>

<input type="hidden" id="txtaccountperiodfrom" name="txtaccountperiodfrom" value='<s:property value="txtaccountperiodfrom"/>'/>
</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>