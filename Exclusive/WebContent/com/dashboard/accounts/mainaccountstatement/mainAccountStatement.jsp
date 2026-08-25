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
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtaccid').dblclick(function(){
	    	 if($('#cmbtype').val()==''){
   			     $.messager.alert('Message','Please Choose Account Type.','warning');
   			     return 0;
   		     }
	    	 accountsSearchContent('accountsDetailsSearch.jsp');
		 });
	     
	     $("#trialDiv").hide();
	     document.getElementById("hidchckincludingzero").value=0;
	     $('#btnPrintAccount').attr('disabled', true);
	     
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
        else{
         }
        }
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'MainAccountStatement', true);
		 } else {
			 $("#mainAccountStatementGridID").jqxGrid('exportdata', 'xls', 'MainAccountStatement');
		 }
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
		 var accdocno = $('#txtdocno').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
		 
		 if(acctype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 $("#mainAccountStatementDiv").load("mainAccountStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&accdocno='+accdocno+'&includingzero='+includingzero+'&check=1');
		}
	
	function funClearInfo(){

  	     $('#cmbbranch').val('a');
  	     $('#fromdate').val(new Date());
  	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 document.getElementById("hidchckincludingzero").value = 0;
		 if(document.getElementById("hidchckincludingzero").value==0){
			 document.getElementById("chckincludingzero").checked = false;
		 }
		 
		 $('#btnPrintAccount').attr('disabled', true);
         document.getElementById("cmbtype").value="";document.getElementById("txtaccid").value="";
         document.getElementById("txtaccname").value="";document.getElementById("txtdocno").value="";
         funRoundAmt(0,"txtnetamount");
       
		 $("#mainAccountStatementGridID").jqxGrid('clear');$("#mainAccountStatementGridID").jqxGrid('addrow', null, {});
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		}
	
	function funPrintMainAccountStatement(){
    	if ($("#cmbtype").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("mainAccountStatement.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printMainAccountStatement?type="+document.getElementById("cmbtype").value+'&acno='+document.getElementById("txtdocno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&includingzero='+$('#hidchckincludingzero').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account Type is Mandatory.','warning');
			return;
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
    <option value="">--Select--</option><option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option>
    <option value="HR">HR</option></select></td></tr>
	<tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr>
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	<button class="myButton" type="button" id="btnPrintAccount" name="btnPrintAccount" onclick="funPrintMainAccountStatement(event);">Print</button></td></tr> 
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
			 <td><div id="mainAccountStatementDiv"><jsp:include page="mainAccountStatementGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="trialDiv" hidden="true">
<table width="100%">
<tr>
        <td width="98%" align="right"><input type="hidden" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
        <td width="2%">&nbsp;</td>
</tr>
</table>
</div>
</div>

<div id="accountDetailsWindow">
	<div></div>
</div>
</div>
</body>
</html>