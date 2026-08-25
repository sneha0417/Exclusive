
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
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		$('#clusterDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cluster Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#clusterDetailsWindow').jqxWindow('close');
		 
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#txtclustername').dblclick(function(){
	    	clusterSearchContent('clusterDetailsSearch.jsp');
			});
	    
	    $('#txtclusteraccount').val(0);
	    
	});

	function clusterSearchContent(url) {
	    $('#clusterDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clusterDetailsWindow').jqxWindow('setContent', data);
		$('#clusterDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClusterAccounts(event){
        var x= event.keyCode;
        if(x==114){
        	clusterSearchContent('clusterDetailsSearch.jsp');
        }
        else{}
        }
	
   function funreload(event) {
	
	 var branchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var clusterdocno = $('#txtclusterdocno').val();

	 $("#overlay, #PleaseWait").show();
	 $("#accountDetailsGridID").jqxGrid('clear');
	  
	  $("#clusterAccountDiv").load("clusterAccountDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&clusterdocno='+clusterdocno+'&check=1');
	
	  $("#clusterAccountStatementDiv").load("clusterAccountStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&clusterdocno='+clusterdocno+'&clusteraccount=0'+'&check=1');
		 
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data1, 'ClusterAccountStatement', true);
		 } else {
			 $("#detailedAccountsStatementGrid").jqxGrid('exportdata', 'xls', 'ClusterAccountStatement');
		 }
	 }
 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Cluster</label></td>
	<td align="left"><input type="text" id="txtclustername" name="txtclustername" style="width:95%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclustername"/>' onkeydown="getClusterAccounts(event);"/>
	<input type="hidden" id="txtclusterdocno" name="txtclusterdocno" readonly="readonly"  value='<s:property value="txtclusterdocno"/>'/></td></tr>
	<tr><td colspan="2"><div id="clusterAccountDiv"><jsp:include page="clusterAccountDetailsGrid.jsp"></jsp:include></div></td></tr> 
	<tr><td colspan="2"><input type="hidden" id="txtclusteraccount" name="txtclusteraccount" readonly="readonly"  value='<s:property value="txtclusteraccount"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="clusterAccountStatementDiv"><jsp:include page="clusterAccountStatementGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td>
</tr>
</table>
</div>
</div>
<div id="clusterDetailsWindow">
	<div></div><div></div>
</div>
</body>
</html>
