<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
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

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">


$(document).ready(function () {   
	
	    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $('#clientsearch1').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		$('#clientsearch1').jqxWindow('close');
		$('#portsearch').jqxWindow({ width: '20%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Port Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		$('#portsearch').jqxWindow('close');
		
	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
	   	  
	    $('#txtclient').dblclick(function(){
	    	 $('#clientsearch1').jqxWindow('open');
	    	 clientSearchContent('clsearch.jsp?', $('#clientsearch1')); 
		});
	    $('#txtport').dblclick(function(){
	    	 $('#portsearch').jqxWindow('open');
	    	 portSearchContent('portsearch.jsp?', $('#portsearch')); 
		});
	    
	    
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

});
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#clientsearch1').jqxWindow('setContent', data);

   	}); 
    }
    
    function getport(event){
   	 var x= event.keyCode;
   	 if(x==114){
   	  $('#portsearch').jqxWindow('open');
   	 portSearchContent('portsearch.jsp?', $('#portsearch'));    }
   	 else{
   		 }
   	 } 
        function portSearchContent(url) {
              
                  $.get(url).done(function (data) {
     
   	           $('#portsearch').jqxWindow('setContent', data);

       	}); 
 }
        

 function funreload(event){
	 
	 var sortby = document.getElementById("cmbsortby").value;
	 var clientid=document.getElementById("clientid").value;
	 var portid=document.getElementById("portid").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var id=1;
	 $("#overlay, #PleaseWait").show();
	 $("#listdiv").load("invoiceDetailsGrid.jsp?sortby="+sortby+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&portid="+portid+"&id="+id);
	}

 function funExportBtn(){
	  JSONToCSVCon(data,'Invoice Details',true);
 } 
 function funClear(){
		$("#invoicedetailsgrid").jqxGrid('clear'); 
// 		$("#jqxSerCount").jqxGrid('clear');
			
		document.getElementById("txtclient").value="";
		document.getElementById("clientid").value="0";
		document.getElementById("txtport").value="";
		document.getElementById("portid").value="0";
		//document.getElementById("cmbsortby").value="";
		//document.getElementById("hidcmbsortby").value="0";
		$("#txtclient").attr("placeholder", "press F3 for Search");
		$("#txtport").attr("placeholder", "press F3 for Search");
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
           <tr>
             <td  align="right" ><label class="branch">From</label></td>
             <td align="left"><div id='fromdate' style="width: 73%;height:20px;" name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           </tr>
           <tr>
             <td  align="right" ><label class="branch">To</label></td>
             <td align="left"><div id='todate' style="width: 73%;height:20px;" name='todate' value='<s:property value="todate"/>'></div></td>
           </tr>
           <tr><td colspan="2">&nbsp;</td></tr>
	      <tr>
	        <td align="right"><label class="branch">Client</label></td>
	        <td ><input style="width: 73%;height:20px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
            <input type="hidden" id="clientid" name="client_id" value='<s:property value="client_id"/>'>
            <button type="button" class="bicon" id="clear" title="clear" onclick="funClear();"> 
			<img alt="clear" src="<%=contextPath%>/icons/clear.png"></button></td>
          </tr>
            <tr>
	        <td align="right"><label class="branch">Port</label></td>
	        <td ><input style="width: 73%;height:20px;" type="text" name="txtport" id="txtport" value='<s:property value="txtport"/>' onKeyDown="getport(event);" readonly placeholder="Press F3 to Search">
            <input type="hidden" id="portid" name="portid" value='<s:property value="portid"/>'>
          </tr>
           <tr>
             <td align="right"><label class="branch">Group By</label></td>
             <td colspan="4"><select id="cmbsortby" name="cmbsortby"  style="width: 73%;height:20px;" value='<s:property value="cmbsortby"/>'>
            <option value="date">Date</option><option value="client">Client</option><option value="port">Port</option></select>
             <input type="hidden" id="hidcmbsortby" name="hidcmbsortby" value='<s:property value="hidcmbsortby"/>'/>
           </tr>
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
			 <td><div id="listdiv"><jsp:include page="invoiceDetailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="portsearch">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
</div>
</div>
</body>
</html>