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
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
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
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	
  
	
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		
		 $("#followUpDetailsGrid").jqxGrid('clear');
		 $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
		 $("#followUpDetailsGrid").jqxGrid({ disabled: true});
	}
	
	
	function funreload(event){
		disable();
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
			 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#proformaInvFollowupDiv").load("proformaInvFollowupGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate);
		}
	
	function funUpdate(event){
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0].trim();
		var proname=pro[1].trim();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var rdtype = $('#conttype').val();
	
		
		if(bibid==''){
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
		     		saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks);	
		     	}
		});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
		
   
	    
	function saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")
				{	
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#contno').val('');
				$('#conttype').val('');
			
				
				$.messager.alert('Message', '  Record Successfully Updated ');
			//	funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
			
	x.open("GET","saveData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks,true);
	x.send();
			
	}
	
	
	
	
	function funExportBtn(){
	    

		JSONToCSVCon(proformainvfolwuptexcel, 'Proforma Invoice Followup', true);
		   }
	
</script>
</head>
<body onload="getBranch();getProcess();disable();followupcheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td width="20%" align="right"><label class="branch">Up To</label></td> 
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
     
     <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
    <tr><td colspan="2"></td></tr>
   
    <tr><td align="right"><label class="branch">Doc No.</label></td>
	 <td align="left"><input type="text" id="contno" name="contno" style="height:20px;" readonly="readonly" value='<s:property value="contno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Doc Type</label></td>
	 <td align="left"><input type="text" id="conttype" name="conttype" style="height:20px;" readonly="readonly" value='<s:property value="conttype"/>'/></td></tr>
	 
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"   value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
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
	
	 
	   
	 
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/></td></tr>
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="proformaInvFollowupDiv"><jsp:include page="proformaInvFollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>

</div> 
</body>
</html>