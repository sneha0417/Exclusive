<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<% String contextPath=request.getContextPath();%>
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

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}

</style>
  
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 
	 
	 $("#clientname").dblclick(function(){
			
		 clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/nipurchase/nisalesreport/clientSearch.jsp");

		});
	 
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
			clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/nipurchase/nisalesreport/clientSearch.jsp");
	
	
	}
}

function clientSearchContent(url) {
 	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var type=$('#cmbtype').val();

    $("#overlay, #PleaseWait").show();
    if($( "#chkdetail:checked" ).length==1){
    	$("#griddiv").load("nisalesreportGrid.jsp?id=2&fromdate="+fromdate+"&todate="+todate+"&client="+$('#cldocno').val()+"&type="+type);
	}else{
		$("#griddiv").load("nisalesreportGrid.jsp?id=1&fromdate="+fromdate+"&todate="+todate+"&client="+$('#cldocno').val()+"&type="+type);
	}
}
function funExportBtn(){
	
	 JSONToCSVCon(rdatas, 'NI Sales Report', true);
}

function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('#fromdate').jqxDateTimeInput('setDate',new Date());
	$('#todate').jqxDateTimeInput('setDate',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 

}

</script>

</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">  
<div class='hidden-scrollbar'>                               
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0; height: 520px;">
	<table width="100%" cellspacing="5" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		<tr><td  width="10%">&nbsp;</td><td  width="80%">&nbsp;</td></tr>
 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left">
	  <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left">
      <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>

	<tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left">
	 <input type="text" id="clientname" name="clientname" value='<s:property value="clientname"/>' style="width:72%; height:20px;" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="clientname"/>' style="height: 20px;" onkeydown="searchClient(event);"/>
	 </td></tr>
	 <tr>
    <td align="right"><label class="branch">Type</label></td>
    <td><select name="cmbtype" id="cmbtype" value='<s:property value="cmbtype"/>' style="width:125px;">
    <option value="ctodr">CUTING ORDER</option>
    <option value="dlnot">DELIVERY NOTE</option>
    <option value="ctinv">CUTTING INVOICE</option></select></td>
  </tr>
	 
	 <tr><td align="right"><input type="checkbox" id="chkdetail" name="chkdetail" value='<s:property value="chkdetail"/>'></td>
  <td><label for="detail" class="branch">Detail</label></td></tr>
	 
	 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;"><br>
		<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;
		
	</div>
    </td>
</tr>
	 </table>
	 </fieldset>
	 </td>
	 <td>
	 <div id="griddiv"><jsp:include page="nisalesreportGrid.jsp"></jsp:include></div>
	 </td></tr>
	 
	 </table>
	 
<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >	 


<div id="clientSearchWindow">
	<div></div>
</div>

	 </div></div>
</body>
</html>