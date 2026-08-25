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

<script type="text/javascript">
	$(document).ready(function () {
		$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM-yyyy"});
		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#extdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM-yyyy"});
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	    var uptodate = $('#uptodate').val();
	    $('#txtuptodate').val(uptodate);
	});
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
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
	
	function funreload(event){
		 $('#gridload').val("1");
		 var gridload = $('#gridload').val();
		 var branchval = $('#cmbbranch').val();
		 var rentaltype = $('#rentaltype').val();
		 var uptodate = $('#txtuptodate').val();
		 
		$('#cmbprocess').val('');$('#date').val(new Date());$('#extdate').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#txtremarks').val('');
		$('#txtexpirydate').val('');$('#txtagreementno').val('');$('#txtcardno').val('');$('#txtpytdocno').val('');$('#btnupdate').attr("disabled",true);
		$('#cmbprocess').attr("disabled",true);$("#extdate").prop("hidden", true);$("#date").prop("hidden", false);$('#date').jqxDateTimeInput({ disabled: true});
		$('#extdate').jqxDateTimeInput({ disabled: true});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#creditCardFollowUpDiv").load("creditCardFollowUpGrid.jsp?branchval="+branchval+'&rentaltype='+rentaltype+'&uptodate='+uptodate+'&gridload='+gridload);
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
		var extdate =  $('#extdate').val();
		var branchid = $('#txtbranch').val();
		var cldocno = $('#txtcldocno').val();
		var expirydate = $('#txtexpirydate').val();
		var remarks = $('#txtremarks').val();
		var rentaltype = $('#rentaltype').val();
		var agreementno = $('#txtagreementno').val();
		var cardno = $('#txtcardno').val();
		var pytdocno = $('#txtpytdocno').val();
		
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
		     		saveGridData(process,date,extdate,branchid,cldocno,expirydate,remarks,rentaltype,agreementno,cardno,pytdocno);	
		     	}
		});
	}
	
	function saveGridData(process,date,extdate,branchid,cldocno,expirydate,remarks,rentaltype,agreementno,cardno,pytdocno){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				var process = $('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#extdate').val(new Date());
				var branchid = $('#txtbranch').val('');
				var cldocno = $('#txtcldocno').val('');
				var remarks = $('#txtremarks').val('');
				var expirydate = $('#txtexpirydate').val('');
				var agreementno = $('#txtagreementno').val('');
				var cardno = $('#txtcardno').val('');
				var pytdocno = $('#txtpytdocno').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				funreload(event); 
				disable();
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&extdate="+extdate+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&rentaltype="+rentaltype+"&agreementno="+agreementno+"&cardno="+cardno+"&pytdocno="+pytdocno,true);
	x.send();
			
	}
	
	function funExtendedDate(){
		var process=$('#cmbprocess').val();
        if(process==23){
       	 $("#extdate").prop("hidden", true); 
       	 $("#date").prop("hidden", false);
        }
        else{
       	 $("#date").prop("hidden", true);
       	 $("#extdate").prop("hidden", false);
        }
	 }

	function datechange(){
		var uptodate = $('#uptodate').val();
	    $('#txtuptodate').val(uptodate);
	  }
	  
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'CreditCardFollowUp', true);
		 } else {
			 $("#creditCardFollowUp").jqxGrid('exportdata', 'xls', 'CreditCardFollowUp');
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
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="rentaltype" name="rentaltype"  value='<s:property value="rentaltype"/>'>
     <option value="RAG">Rental</option><option value="LAG">Lease</option>
     </select></td></tr>
     <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" onchange="datechange();" value='<s:property value="uptodate"/>'></div></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"  onchange="funExtendedDate();" value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>
     <div hidden="true" id="extdate" name="extdate" value='<s:property value="extdate"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/>
	 <input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;" value='<s:property value="txtagreementno"/>'/>
	 <input type="hidden" id="txtexpirydate" name="txtexpirydate" style="width:100%;height:20px;" value='<s:property value="txtexpirydate"/>'/> 
	 <input type="hidden" id="txtcardno" name="txtcardno" style="width:100%;height:20px;" value='<s:property value="txtcardno"/>'/>
	 <input type="hidden" id="txtpytdocno" name="txtpytdocno" style="width:100%;height:20px;" value='<s:property value="txtpytdocno"/>'/>
	 <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
	 <input type="hidden" id="gridload" name="gridload" style="width:100%;height:20px;" value='<s:property value="gridload"/>'/>
	 <input type="hidden" id="txtuptodate" name="txtuptodate" style="width:100%;height:20px;" value='<s:property value="txtuptodate"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="creditCardFollowUpDiv"><jsp:include page="creditCardFollowUpGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
</html>