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
		// $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		
		
		
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Job Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 
		 
		 
		 
		 
		 $('#txtaccid').dblclick(function(){
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
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
			JSONToCSVCon(data, 'ARProjectAllocation', true);
	} 
	
	
	
	
	function fromdatechange(){
	    var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
    function todatechange(){
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
   
	
	
	
	
	
	
	
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	 function  funClearInfo(){
		 
		 $('#fromdate').val(new Date());
    	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $('#date').val(new Date());
		 
		 
		 
		 
			$('#cmbbranch').val('a');$('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$('#txtaccemail').val('');
			document.getElementById("hidfromdate").value="";document.getElementById("hidtodate").value="";document.getElementById("cmbtype").value="";
		    $("#arProjectAllocationGridId").jqxGrid('clear');$("#arProjectAllocationGridId").jqxGrid('addrow', null, {});
		    
		    if (document.getElementById("txtdocno").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
		    
		 }
	 
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var accdocno = $('#txtdocno').val();
		 
		 /* var date = $('#fromdate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
				return 0;	
			 }
	    
		    var date = $('#todate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
				return 0;	
			 } */
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#arProjectAllocationDiv").load("arProjectAllocationGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&check=1');
		}
	
	function saveGridData(docno,dtype,acno,tranid,jobno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				if(parseInt(items)>0){
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
					});
					funreload(event); 
				} else {
					$.messager.alert('Message', '  Failed ', function(r){
					});
				}
				
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&dtype="+dtype+"&acno="+acno+"&tranid="+tranid+"&jobno="+jobno,true);
	x.send();
	}
	
	
	
	
	
	function removeGridData(docno,dtype,acno,tranid,jobno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				$("#overlay, #PleaseWait").hide();
				if(parseInt(items)>0){
					$.messager.alert('Message', '  Record Successfully Removed ', function(r){
					});
					funreload(event); 
				}else {
					$.messager.alert('Message', '  Failed ', function(r){
					});
				}
				
		  }
		}
			
	x.open("GET","removeData.jsp?docno="+docno+"&dtype="+dtype+"&acno="+acno+"&tranid="+tranid+"&jobno="+jobno,true);
	x.send();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmARProjectAllocation" action="saveARProjectAllocation" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	
	
	
	
	
	<td align="right"><label class="branch">From</label></td>
    <td align="left"><div id="fromdate" name="fromdate" onchange="fromdatechange();" value='<s:property value="fromdate"/>'></div>
    <input type="hidden" id="hidfromdate" name="hidfromdate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidfromdate"/>'/></td></tr> 
    <tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" onchange="todatechange();" value='<s:property value="todate"/>'></div>
    <input type="hidden" id="hidtodate" name="hidtodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidtodate"/>'/></td></tr> 
	
	
	
	
	
	
	
	
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"  align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
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
			 <td><div id="arProjectAllocationDiv"><jsp:include page="arProjectAllocationGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 
</div> 
</body>
</html>