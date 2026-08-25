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
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#expiryDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	});

	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}

	function  funClearData(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#clientinfo').val('');$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
		$('#expiryDate').val(new Date());$('#txtcldocno').val('');$('#txtdriver').val('');$('#txtbranch').val('');$('#txtdocument').val('');disable();
		$("#documentExpiry").jqxGrid('clear');$("#documentExpiry").jqxGrid('addrow', null, {});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();

		 $('#cmbprocess').val('');$('#date').val(new Date());$('#expiryDate').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#txtremarks').val('');
		 $('#txtdriver').val('');$('#txtdocument').val('');$('#btnupdate').attr("disabled",true);$('#cmbprocess').attr("disabled",true);$('#date').jqxDateTimeInput({ disabled: true});
		 $("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
		 $("#overlay, #PleaseWait").show();
		 
		 $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate);
	}

	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var cldocno = $('#txtcldocno').val();
		var expirydate = $('#expiryDate').val();
		var remarks = $('#txtremarks').val();
		var driversrno = $('#txtdriver').val();
		var document = $('#txtdocument').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document);	
		     	}
		});
	}
	
	function saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				var process = $('#cmbprocess').val('');
				$('#date').val(new Date());
				var branchid = $('#txtbranch').val('');
				var cldocno = $('#txtcldocno').val('');
				$('#expiryDate').val(new Date());
				var remarks = $('#txtremarks').val('');
				var driversrno = $('#txtdriver').val('');
				var document = $('#txtdocument').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				funreload(event); 
				disable();
				$('#clientinfo').val('');
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&driversrno="+driversrno+"&document="+document,true);
	x.send();
			
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'DocumentExpiry', true);
		 } else {
			 $("#documentExpiry").jqxGrid('exportdata', 'xls', 'DocumentExpiry');
		 }
	}
	
</script>
</head>
<body onload="getBranch();getProcess();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2" align="center"><textarea id="clientinfo" style="height:80px;width:200px;font: 10px Tahoma;resize:none" name="clientinfo"  readonly="readonly"><s:property value="clientinfo" ></s:property></textarea></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	 <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><div hidden="true" id='expiryDate' name='expiryDate' value='<s:property value="expiryDate"/>'></div>
	 <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/>
     <input type="hidden" id="txtdriver" name="txtdriver" style="width:100%;height:20px;" value='<s:property value="txtdriver"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtdocument" name="txtdocument" style="width:100%;height:20px;" value='<s:property value="txtdocument"/>'/></td></tr>
  </table>
</fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="documentExpiryDiv"><jsp:include page="documentExpiryGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>
</div>
</div>
</body>
