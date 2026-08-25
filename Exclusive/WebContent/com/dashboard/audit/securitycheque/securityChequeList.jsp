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
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#chequeDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtremarks').attr('readonly', true);$('#btnupdate').attr("disabled",true);
		 
	});
	
	function funreload(event){
		 $('#txtremarks').val('');$('#txtdocno').val('');$('#txtbrhid').val('');
		 $('#btnupdate').attr("disabled",true);
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#securityChequeListDiv").load("securityChequeListGrid.jsp?branchval="+branchval+'&uptodate='+uptodate);
		}
	
	function funUpdate(event){
		var docno = $('#txtdocno').val();
		var date = $('#date').val();
		var chequeno = $('#txtchequeno').val();
		var chequedate = $('#chequeDate').val();
		var branchid = $('#txtbrhid').val();
		var remarks = $('#txtremarks').val();
				
		if(docno==''){
			 $.messager.alert('Message','Please Choose a Cheque.','warning');
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
		     		 saveGridData(docno,date,chequeno,chequedate,branchid,remarks);	
		     	}
		 });
	}
	
	function saveGridData(docno,date,chequeno,chequedate,branchid,remarks) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var docno = $('#txtdocno').val('');
				var date = $('#date').val(new Date());
				var chequeno = $('#txtchequeno').val('');
				var chequedate = $('#chequeDate').val(new Date()); 
				var branchid = $('#txtbrhid').val('');
				var remarks = $('#txtremarks').val('');
				var info = $('#txtinfo').val(' ');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&date="+date+"&chequeno="+chequeno+"&chequedate="+chequedate+"&branchid="+branchid+"&remarks="+remarks,true);
	x.send();
	}

	function funExportBtn(){
		 JSONToCSVCon(data, 'Security Cheque List', true);
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
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><textarea id="txtinfo" style="height:80px;width:200px;font: 10px Tahoma;resize:none" name="txtinfo"  readonly="readonly"  ><s:property value="txtinfo" ></s:property></textarea></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Remarks</label></td>
	<td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Close</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>  
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtchequeno" name="txtchequeno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtchequeno"/>'/>
	<div hidden="true" id='chequeDate' name='chequeDate' value='<s:property value="chequeDate"/>'></div>
	<div hidden="true" id='date' name='date' value='<s:property value="date"/>'></div>
	<input type="hidden" name="txtbrhid" id="txtbrhid" style="height:20px;width:70%;" value='<s:property value="txtbrhid"/>'>
	<input type="hidden" id="txtdocno" name="txtdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtdocno"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="securityChequeListDiv"><jsp:include page="securityChequeListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

</div> 
</body>
</html>