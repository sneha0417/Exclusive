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

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
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
		  
	     document.getElementById("rdall").checked=true;
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
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	} 
	
	function funClearInfo(){

   	    $('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#cmbtype').val('AR');$('#txtdocno').val('');
   	    $('#txtaccid').val('');$('#txtaccname').val('');$('#cmbsalesperson').val('');$('#cmbcategory').val('');
		
		$("#individualAgeing").jqxGrid('clear');$("#individualAgeing").jqxGrid('addrow', null, {});
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		 document.getElementById("rdall").checked=true;
		 
		}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var check=1;
		 
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }

		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			$("#individualAgeingSummary").jqxGrid('clear');
			$("#individualAgeingDiv").prop("hidden", false);
 		    $("#summaryDiv").prop("hidden", true);
 		    
		 	$("#individualAgeingDiv").load("individualAgeingGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
		 }else if(document.getElementById("rdsummary").checked==true){
		 	//$("#summaryDiv").load("summaryGrid.jsp?rpttype=1&branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
			$("#individualAgeingDiv").jqxGrid('clear');
		 	$("#individualAgeingDiv").prop("hidden", true);
		 	$("#summaryDiv").prop("hidden", false);
		 	
		 	$("#summaryDiv").load("summaryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
		 }
		 
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'IndividualAgeing', true);
		 } else {
			 $("#individualAgeing").jqxGrid('exportdata', 'xls', 'IndividualAgeing');
		 }
	    }
		
			    
	    function funPrint(){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 //alert("print");
		
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		var url=document.URL;

	     var reurl=url.split("individualAgeing.jsp");
		 var brhid=<%=session.getAttribute("BRANCHID").toString()%>
	    	 var win= window.open(reurl[0]+"individualAgeing?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&check=1',"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	    	 win.focus();
	    	
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
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="AR" selected>AR</option><option value="AP">AP</option></select></td></tr>
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdall" name="rdo" value="rdall"><label for="rdall" class="branch">All</label></td>
       <td width="52%" align="center"><input type="radio" id="rdsummary" name="rdo" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Sales Person</label></td>
	<td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	<td><select id="cmbcategory" name="cmbcategory" style="width:100%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="1" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td>
	<td colspan="1"><center><button class="myButton" type="button" id="btnprint" name="btnprint" onclick="funPrint();">Print</button></center></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	<input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="individualAgeingDiv"><jsp:include page="individualAgeingGrid.jsp"></jsp:include></div>
			     <div id="summaryDiv" hidden="true"><jsp:include page="summaryGrid.jsp"></jsp:include></div></td>
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