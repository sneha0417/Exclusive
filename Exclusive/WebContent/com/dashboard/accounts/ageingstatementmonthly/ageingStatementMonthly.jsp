<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

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
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px', formatString: 'Y'});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtaccid').dblclick(function(){
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
		 
		 datechange();
		 $('#btnIndividual').attr('disabled',true);
		 
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getSalesPerson() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesagentItems = items[0].split(",");
				var salesagentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesagentItems.length; i++) {
					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
							+ salesagentItems[i] + '</option>';
				}
				$("select#cmbsalesperson").html(optionssalesagent);
				if ($('#hidcmbsalesperson').val() != null) {
					$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
				}
			} else {
			}
		}
		x.open("GET", "getSalesPerson.jsp", true);
		x.send();
	}
  
   function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
		x.send();
	}
   
   function getMonthNames(a){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				items = items.split('####');
 				var currentMonthItems = items[0];
 				var previousMonth1Items  = items[1];
 				var previousMonth2Items = items[2];
 				var previousMonth3Items = items[3];
 				var previousMonth4Items  = items[4];
 				var previousMonth5Items = items[5];
 				var previousMonth6Items = items[6];
				var previousMonth7Items = items[7];
 				var previousMonth8Items = items[8];
 				var previousMonth9Items = items[9];
 			
 			    $('#txtcurrentmonth').val(currentMonthItems);	
 			    $('#txtpreviousmonth1').val(previousMonth1Items);
 			    $('#txtpreviousmonth2').val(previousMonth2Items);
 			  	$('#txtpreviousmonth3').val(previousMonth3Items);
 			  	$('#txtpreviousmonth4').val(previousMonth4Items);
 			  	$('#txtpreviousmonth5').val(previousMonth5Items);
 			  	$('#txtpreviousmonth6').val(previousMonth6Items);
 			  	$('#txtpreviousmonth7').val(previousMonth7Items);
 			  	$('#txtpreviousmonth8').val(previousMonth8Items);
 			  	$('#txtpreviousmonth9').val(previousMonth9Items);
 		}
 		}
 		x.open("GET", "getMonthNames.jsp?date="+a, true);
 		x.send();
   }
	
	function getAccType(event){
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
	    JSONToCSVCon(data, 'AgeingStatementMonthWise', true);
	}
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		 
		if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		}
	} 
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatementMonthly.jsp");
	        var uptodate = $('#uptodate').jqxDateTimeInput('getDate');
			var uptodate1=uptodate.getFullYear()+"-"+(parseInt(uptodate.getMonth())+parseInt(1))+"-"+(uptodate.getDate()<10?"0"+uptodate.getDate():uptodate.getDate());
			 
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingsStatementMonthly?acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&branch='+document.getElementById("txtbranch").value+'&uptoDate='+uptodate1,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus(); 
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').jqxDateTimeInput('getDate');
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var check=1;
		 
		 var uptodate1=uptodate.getFullYear()+"-"+(parseInt(uptodate.getMonth())+parseInt(1))+"-"+(uptodate.getDate()<10?"0"+uptodate.getDate():uptodate.getDate());
		 
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 getMonthNames(uptodate1);
		 $("#ageingStatementMonthlyDiv").load("ageingStatementMonthlyGrid.jsp?branchval="+branchval+'&uptodate='+uptodate1+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
		 
		}
	
		function funClearInfo(){

	   	 	 $('#cmbbranch').val('a');
			 $('#uptodate').val(new Date());
			 
			 $('#cmbtype').val('');$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');$('#cmbsalesperson').val('');$('#cmbcategory').val('');
			 
			 $('#btnIndividual').attr('disabled',true);
			 
			 $("#ageingStatement").jqxGrid('clear');$("#ageingStatement").jqxGrid('addrow', null, {});$("#ageingStatement").jqxGrid('clearselection');
			
			 if (document.getElementById("txtaccid").value == "") {
			        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
			 } 
			 
			 $('#txtcurrentmonth').val('');$('#txtpreviousmonth1').val('');$('#txtpreviousmonth2').val('');$('#txtpreviousmonth3').val('');$('#txtpreviousmonth4').val('');
			 $('#txtpreviousmonth5').val('');$('#txtpreviousmonth6').val('');$('#txtpreviousmonth7').val('');$('#txtpreviousmonth8').val('');$('#txtpreviousmonth9').val('');
		 
			 var uptodate = $('#uptodate').jqxDateTimeInput('getDate');
			 var uptodate1=uptodate.getFullYear()+"-"+(parseInt(uptodate.getMonth())+parseInt(1))+"-"+(uptodate.getDate()<10?"0"+uptodate.getDate():uptodate.getDate());
			 getMonthNames(uptodate1);
		}
		
		function datechange(){
			var uptodate = $('#uptodate').jqxDateTimeInput('getDate');
			var uptodate1=uptodate.getFullYear()+"-"+(parseInt(uptodate.getMonth())+parseInt(1))+"-"+(uptodate.getDate()<10?"0"+uptodate.getDate():uptodate.getDate());
			getMonthNames(uptodate1);
		}
	
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
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
	 <td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" onblur="datechange();" onchange="datechange();" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="AR" selected>AR</option><option value="AP">AP</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Salesman</label></td>
	<td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	<td><select id="cmbcategory" name="cmbcategory" style="width:100%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;
	<button class="myButton" type="button" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	<input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
	<input type="hidden" id="txtcurrentmonth" name="txtcurrentmonth" value='<s:property value="txtcurrentmonth"/>'/>
	<input type="hidden" id="txtpreviousmonth1" name="txtpreviousmonth1" value='<s:property value="txtpreviousmonth1"/>'/>
	<input type="hidden" id="txtpreviousmonth2" name="txtpreviousmonth2" value='<s:property value="txtpreviousmonth2"/>'/>
	<input type="hidden" id="txtpreviousmonth3" name="txtpreviousmonth3" value='<s:property value="txtpreviousmonth3"/>'/>
	<input type="hidden" id="txtpreviousmonth4" name="txtpreviousmonth4" value='<s:property value="txtpreviousmonth4"/>'/>
	<input type="hidden" id="txtpreviousmonth5" name="txtpreviousmonth5" value='<s:property value="txtpreviousmonth5"/>'/>
	<input type="hidden" id="txtpreviousmonth6" name="txtpreviousmonth6" value='<s:property value="txtpreviousmonth6"/>'/>
	<input type="hidden" id="txtpreviousmonth7" name="txtpreviousmonth7" value='<s:property value="txtpreviousmonth7"/>'/>
	<input type="hidden" id="txtpreviousmonth8" name="txtpreviousmonth8" value='<s:property value="txtpreviousmonth8"/>'/>
	<input type="hidden" id="txtpreviousmonth9" name="txtpreviousmonth9" value='<s:property value="txtpreviousmonth9"/>'/>
	</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="ageingStatementMonthlyDiv"><jsp:include page="ageingStatementMonthlyGrid.jsp"></jsp:include></div></td>
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