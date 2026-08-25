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
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#clientDetailsWindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $('#estimationDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Estimation Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#estimationDetailsWindow').jqxWindow('close');
		 
		 $('#referenceDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Reference Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#referenceDetailsWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#txtclient').dblclick(function(){
			 clientSearchContent('clientDetailsSearch.jsp');
	     });
		 
		 $('#txtestimationno').dblclick(function(){
			 estimationSearchContent('estimationDetailsSearch.jsp');
	     });
		 
		 $('#txtreferencevocno').dblclick(function(){
			 var reftype=$('#cmbreftype').val();

        	 if(reftype==''){
    			 $.messager.alert('Message','Ref. Type is Mandatory.','warning');
    			 return 0;
    		 }
        	 
    		 if(reftype=='DIR'){
    			 $.messager.alert('Message','For Direct, Reference No is Unavailable.','warning');
    			 return 0;
    		 }
			 referenceSearchContent('referenceDetailsSearch.jsp?reftype='+$('#cmbreftype').val());
	     });
		 
		 refChange();
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function estimationSearchContent(url) {
	    $('#estimationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#estimationDetailsWindow').jqxWindow('setContent', data);
		$('#estimationDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function referenceSearchContent(url) {
	    $('#referenceDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#referenceDetailsWindow').jqxWindow('setContent', data);
		$('#referenceDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
			JSONToCSVCon(dataExcelExport, 'EstimationAnalysis', true);
	} 
	
	function getCustomer(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent('clientDetailsSearch.jsp');
        }
        else{}
        }
	
	function getEstimationNo(event){
        var x= event.keyCode;
        if(x==114){
        	estimationSearchContent('estimationDetailsSearch.jsp');
        }
        else{}
        }
	
	function getReferenceNo(event){
        var x= event.keyCode;
        if(x==114){
        	 var reftype=$('#cmbreftype').val();

        	 if(reftype==''){
    			 $.messager.alert('Message','Ref. Type is Mandatory.','warning');
    			 return 0;
    		 }
        	 
    		 if(reftype=='DIR'){
    			 $.messager.alert('Message','For Direct, Reference No is Unavailable.','warning');
    			 return 0;
    		 }
    		 
        	referenceSearchContent('referenceDetailsSearch.jsp?reftype='+$('#cmbreftype').val());
        }
        else{}
        }
	
	function refChange(){
		 var reftype=$('#cmbreftype').val();

		 if(reftype=='DIR'){
			  $('#txtreferenceno').attr('disabled', true);
		 }
		 else{
			  
			  $('#txtreferenceno').attr('disabled', false);
			  $('#txtreferenceno').attr('readonly', true);
		 }
		 
		}
	
	function funreload(event){

		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var clientdocno = $('#txtclientdocno').val();
		 var estimationtrno = $('#txtestimationtrno').val();
		 var reftype = $('#cmbreftype').val();
		 var referencedocno = $('#txtreferencedocno').val();
		
    	 if(estimationtrno==''){
			 $.messager.alert('Message','Estimation No. is Mandatory.','warning');
			 return 0;
		 }
    	 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#estimationAnalysisDiv").load("estimationAnalysisGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&clientdocno='+clientdocno+'&estimationtrno='+estimationtrno+'&reftype='+reftype+'&referencedocno='+referencedocno+'&check=1');
		}
	
	function funClearInfo(){

	   	 $('#cmbbranch').val('a');
	   	 $('#fromdate').val(new Date());
	   	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 $('#txtclient').val('');$('#txtclientdocno').val('');$('#txtestimationno').val('');$('#txtestimationtrno').val('');
		 $('#cmbreftype').val('');$('#txtreferencevocno').val('');$('#txtreferencedocno').val('');
		 
		$("#estimationAnalysisGridId").jqxGrid('clear');$("#estimationAnalysisGridId").jqxGrid('addrow', null, {});$("#estimationAnalysisGridId").jqxGrid('clearselection');
		
		 if (document.getElementById("txtclientdocno").value == "") {
		        $('#txtclient').attr('placeholder', 'Press F3 to Search'); 
		  }
		 
		 if (document.getElementById("txtestimationtrno").value == "") {
		        $('#txtestimationno').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		 if (document.getElementById("txtreferencedocno").value == "") {
		        $('#txtreferencevocno').attr('placeholder', 'Press F3 to Search'); 
		  }
		 
		}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmEstimationAnalysis" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td align="right"><label class="branch">Customer</label></td>
	<td align="left"><input type="text" id="txtclient" name="txtclient" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onkeydown="getCustomer(event);"/>
	<input type="hidden" id="txtclientdocno" name="txtclientdocno" value='<s:property value="txtclientdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Estimation</label></td>
	<td align="left"><input type="text" id="txtestimationno" name="txtestimationno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtestimationno"/>' onkeydown="getEstimationNo(event);"/>
	<input type="hidden" id="txtestimationtrno" name="txtestimationtrno" value='<s:property value="txtestimationtrno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Ref. Type</label></td>
	<td><select id="cmbreftype" name="cmbreftype" style="width:30%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="">--select--</option>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      <option value="SRVE">SRVE</option>
      </select></td></tr>
	<tr><td align="right"><label class="branch">Ref. No.</label></td>
	<td align="left"><input type="text" id="txtreferencevocno" name="txtreferencevocno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtreferencevocno"/>' onkeydown="getReferenceNo(event);"/>
	<input type="hidden" id="txtreferencedocno" name="txtreferencedocno" value='<s:property value="txtreferencedocno"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
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
			 <td><div id="estimationAnalysisDiv"><jsp:include page="estimationAnalysisGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</form>
<div id="clientDetailsWindow">
	<div></div>
</div>
<div id="estimationDetailsWindow">
	<div></div>
</div>
<div id="referenceDetailsWindow">
	<div></div>
</div>
</div> 
</body>
</html>