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

<script type="text/javascript">

$(document).ready(function () {
	 $('#clientWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Client Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
});

	function getClientMaster(){
		var client = $('#txtcldocno').val();
		
		if(client==''){
			 $.messager.alert('Message','Choose an Client.','warning');
			 return 0;
		 }
		
		var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Client";
		window.parent.formCode.value="CRM";
		
		var detName= "Client";
		var path= "com/operations/clientrelations/client/clientAudit.action?mode=view&txtclientdocno="+client;
		top.addTab( detName,reurl[0]+""+path);
	}	
	
	function clientSearchContent(url) {
		 $('#clientWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#clientWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funreload(event){
		     $('#txtclientname').val('');$('#txtcldocno').val('');
			 var branchval = document.getElementById("cmbbranch").value;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#auditDiv").load("auditGrid.jsp?branchval="+branchval);
	}
	
	function funAudit(event){
		var cldocno = $('#txtcldocno').val();
		var branchid = $('#txtbranchid').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,cldocno);	
		     	}
		 });
	}
	
	function saveGridData(branchid,cldocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var branchid = $('#txtbrhid').val('');
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&cldocno="+cldocno,true);
	x.send();
	}
	
	function funClientAttach(){
		if ($("#txtcldocno").val()!="") {
			$("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
			changeDashBoardAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);		
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
	function funExportBtn(){
		 JSONToCSVCon(data1, 'Client Audit List', true);
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
    <tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><button class="myButton" type="button" id="btnclient" name="btnclient" onclick="getClientMaster(event);">Client</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button class="myButton" type="button" id="btnattach" name="btnattach" onclick="funClientAttach(event);">Attach</button></td></tr>
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
			 <td><div id="auditDiv"><jsp:include page="auditGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<input type="hidden" name="txtbranchid" id="txtbranchid" style="height:20px;width:70%;" value='<s:property value="txtbranchid"/>'>

<div id="clientWindow">
<div></div>
</div>
</div> 
</body>
</html>