 
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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
	$('#audit').attr('disabled',true);
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	$('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#clientsearch1').jqxWindow('close');
	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	$('#todate').on('change', function (event) {
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		  var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		  if(fromdates>todates){
			  $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			  return false;
		  }   
	});
	
	  $('#txtclient').dblclick(function(){
		   
	    	 $('#clientsearch1').jqxWindow('open');
	    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
			   		
			 });
	
	
});
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#clientsearch1').jqxWindow('setContent', data);

   	}); 
        	}

function funExportBtn(){
	JSONToCSVConvertor(exceldata, 'Service Report', true);
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
   // alert("arrData");
    var CSV = '';    
    //Set Report title in first row or line
    CSV += ReportTitle + '\r\n\n';
    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }
        row = row.slice(0, -1);
        //append Label row with line break
        CSV += row + '\r\n';
    }
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }
        row.slice(0, row.length - 1);
        //add a line break after each row
        CSV += row + '\r\n';
    }
    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    //Generate a file name
    var fileName = "";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

  
	 
function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	
	if(fromdates>todates){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
		return false;
	} 
	else
	{
		var clientid= document.getElementById("clientid").value;
		var barchval = document.getElementById("cmbbranch").value;
		var fromdate= $("#fromdate").val();
		var todate= $("#todate").val();
		$("#overlay, #PleaseWait").show();
		$('#audit').attr('disabled',false);
		$("#listdiv").load("serviceReportGrid.jsp?clientid="+clientid+"&barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	}
}
function  funAudit(){
	
	var rows = $("#jqxloaddataGrid").jqxGrid('getrows');
	
	var selectedrows=$("#jqxloaddataGrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});
	
	if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select Items to be Audited.');
		return false;
	}
	
	$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		if(r==false)
		{
			return false; 
		}
		else
		{
			$("#overlay, #PleaseWait").show();
			
			var i=0;var temptrno="";
		    var j=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						if(i==0){
							var srvdetmtrno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', i, "srvdetmtrno").split(' ');
							temptrno=srvdetmtrno;
						}
						else{
							var srvdetmtrno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', i, "srvdetmtrno").split(' ');
							temptrno=temptrno+","+srvdetmtrno;
						}
						temptrno1=temptrno+",";
					j++; 
				  }
		        }
		    $('#srvdetmtrno').val(temptrno1);
		    
			savegriddata($('#srvdetmtrno').val());	
		}
	});
}

function savegriddata(srvdetmtrno)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items=x.responseText;
		if(parseInt(items)>=1)
		{
			$.messager.alert('Message', ' Successfully Updated ');
			$("#jqxloaddataGrid").jqxGrid('clear');
			$('#srvdetmtrno').val("");
			$('#audit').attr('disabled',true);
			funreload(event); 
		}
		else
		{
			$.messager.alert('Message', ' Not Updated ');
		}
	}   
	}
	x.open("GET","savedata.jsp?srvdetmtrno="+srvdetmtrno,true);
	x.send();
}
function funClear(){
		$("#jqxloaddataGrid").jqxGrid('clear'); 
		
	   document.getElementById("txtclient").value="";
	   document.getElementById("clientid").value="0";
	   
	    $("#txtclient").attr("placeholder", "press F3 for Search");
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
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
      </td></tr>
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
      </td></tr>
    <tr>      
           <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
    <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
    </tr>
      
 <tr><td colspan="2">&nbsp;</td></tr> 

 <tr><td colspan="2" align="center"><input type="button" class="myButton" name="audit" id="audit"  value="Audit" onclick="funAudit()"></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
	</tr>	
	</table>
	<br><br><br>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   <input type="hidden" id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="serviceReportGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clientsearch1">
   <div ></div>
</div> 
</div>
</body>
</html>