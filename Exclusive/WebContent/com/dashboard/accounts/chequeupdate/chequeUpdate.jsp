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
		 $("#chequedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#printWindow').jqxWindow({width: '51%', height: '48%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cheque Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
			
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdosingle").checked=true;
	     
		 $('#txtchequeno').attr('readonly', true);$('#chequedate').jqxDateTimeInput({disabled: true});
	});
	
	function ChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 $('#txtchequeno').val('');$('#chequedate').val('');$('#txtbranch').val('');$('#txttrno').val('');$('#txtdocumentno').val('');$('#txtdoctype').val('');
			 $('#chequedate').jqxDateTimeInput({disabled: true});
			 $("#overlay, #PleaseWait").show();
			 var check = 1;
			 
			 $("#chequeUpdateDiv").load("chequeUpdateGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check='+check);
	}
	
	function getChequeNoAlreadyExists(chequeno,bankacno,docno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','Cheque No. Already Exists.','warning');
  					 return 0;
  				 }else{
  					funUpdate(event);
  				 }
  			   
  		}
	}
	x.open("GET", "getChequeNoAlreadyExists.jsp?chequeno="+chequeno+'&bankacno='+bankacno+'&docno='+docno, true);
	x.send();
   }
   
   function getChequePrintAvailability(bankacno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==0){
  					$.messager.alert('Message','Cheque Print is Unavailable.','warning');
  					 return 0;
  				 }else if(parseInt(items)==1){
  					 
  					if(document.getElementById("rdosingle").checked==true){
	  				    var url=document.URL;
	  				    var reurl=url.split("com");
	  				    $("#docno").prop("disabled", false);  
	  				    
	  					var win= window.open(reurl[0]+"printPaymentCheques?docno="+document.getElementById("txtdocumentno").value+"&dtype="+document.getElementById("txtdoctype").value+"&branch="+document.getElementById("txtbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	  				    win.focus(); 
	  				    
  					} 		    
  				 }
  		}
	}
	x.open("GET", "getChequePrintAvailable.jsp?bankacno="+bankacno, true);
	x.send();
   } 
	
	function funUpdate(event){
		var chequeno = $('#txtchequeno').val();
		var chequedate = $('#chequedate').val();
		var branchid = $('#txtbranch').val();
		var trno = $('#txttrno').val();
		var docno = $('#txtdocumentno').val();
		var dtype = $('#txtdoctype').val();
		
		if(chequeno==''){
			 $.messager.alert('Message','Please Enter Cheque No.','warning');
			 return 0;
		 }
		
		if(chequedate==''){
			 $.messager.alert('Message','Please Enter Cheque Date.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,chequeno,chequedate,trno,docno,dtype);	
		     	}
		 });
	}
	
	function saveGridData(branchid,chequeno,chequedate,trno,docno,dtype){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				$('#fromdate').val(new Date());
		    	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
			    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
				$('#todate').val(new Date());
				var chequeno = $('#txtchequeno').val('');
				var chequedate = $('#chequedate').val('');
				var branchid = $('#txtbranch').val('');
				var trno = $('#txttrno').val('');
				var docno = $('#txtdocumentno').val('');
				var dtype = $('#txtdoctype').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&chequeno="+chequeno+"&chequedate="+chequedate+"&trno="+trno+"&docno="+docno+"&dtype="+dtype,true);
	x.send();
	}
	
	function funChequePrint(){
		if(document.getElementById("rdosingle").checked==true){
			var rows = $('#chequeUpdate').jqxGrid('getrows');
	    	var rowlength= rows.length;
	    	if(rowlength==0){
	    		$.messager.alert('Message','Submit & Please Select a Cheque.','warning');
				return;
	    	}
	    	
			if ($("#txtdocumentno").val()!="") {
				getChequePrintAvailability($('#txtbankacno').val());
			 }
		    else {
				$.messager.alert('Message','Please Select a Cheque.','warning');
				return;
			}
		} else {
			 $('#chequedate').val(null);$("#txtchequeno").val('');$("#txtchqbankname").val('');$("#txtchqbankdocno").val('');
			 $("#txtbankacno").val('');$("#txtdocumentno").val('');$("#txtdoctype").val('');$("#printdocno").val('');$("#printdtype").val('');
			 $('#txtchequeno').attr('readonly', true);$('#chequedate').jqxDateTimeInput({disabled: true});$("#chequeUpdate").jqxGrid('clear');	
			 ChequePrintContent('printChequeVoucherWindow.jsp');
		}
    }
	
	function funClearInfo(){

   	     $('#cmbbranch').val('a');
   	     $('#fromdate').val(new Date());
   	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $('#chequedate').val(null);
		 $("#txtchequeno").val('');$("#txtbranch").val('');$("#txtbankacno").val('');$("#txtdocumentno").val('');
		 $("#txtdoctype").val('');$("#txtchqbankname").val('');$("#txtchqbankdocno").val('');$("#printdocno").val('');$("#printdtype").val('');
		 document.getElementById("rdosingle").checked=true;document.getElementById("rdomultiple").checked=false;
		 $('#txtchequeno').attr('readonly', true);$('#chequedate').jqxDateTimeInput({disabled: true});
		 
		 $("#chequeUpdate").jqxGrid('clear');	
		 $('#accountDetailsWindow').jqxWindow('close');$('#printWindow').jqxWindow('close');  
		 
		 if (document.getElementById("txtchqbankname").value == "") {
		        $('#txtchqbankname').attr('placeholder', 'Press F3 to Search'); 
		  }
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data1, 'ChequeUpdate', true);
		 } else {
			 $("#chequeUpdate").jqxGrid('exportdata', 'xls', 'ChequeUpdate');
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
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Cheque Date</label></td>
     <td align="left"><div id="chequedate" name="chequedate" value='<s:property value="chequedate"/>'></div></td></tr> <tr>
	<tr><td align="right"><label class="branch">Cheque No.</label></td>
	<td align="left"><input type="text" id="txtchequeno" name="txtchequeno" style="width:80%;height:20px;" value='<s:property value="txtchequeno"/>'/></td></tr>
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Print Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdosingle" name="rdoprint" value="rdosingle" checked><label for="rdosingle" class="branch">Single</label></td>
       <td width="52%" align="center"><input type="radio" id="rdomultiple" name="rdoprint" value="rdomultiple"><label for="rdomultiple" class="branch">Multiple</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onclick="getChequeNoAlreadyExists($('#txtchequeno').val(),$('#txtbankacno').val(),$('#txtdocumentno').val());">Update</button>
	<button class="myButton" type="button" id="btnChequePrint" name="btnChequePrint" onclick="funChequePrint();">Cheque Print</button></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2"><input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" style="width:100%;height:20px;" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="txtbankacno" name="txtbankacno" style="width:100%;height:20px;" value='<s:property value="txtbankacno"/>'/>
    <input type="hidden" id="txtdocumentno" name="txtdocumentno" style="width:100%;height:20px;" value='<s:property value="txtdocumentno"/>'/>
    <input type="hidden" id="txtdoctype" name="txtdoctype" style="width:100%;height:20px;" value='<s:property value="txtdoctype"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="chequeUpdateDiv"><jsp:include page="chequeUpdateGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="printWindow">
	<div></div><div></div>
</div> 

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>

</div> 
</body>
</html>