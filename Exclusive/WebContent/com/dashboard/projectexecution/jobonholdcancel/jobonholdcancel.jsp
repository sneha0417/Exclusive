
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

</style>

<script type="text/javascript">

$(document).ready(function () {

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

/* 
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
 */	
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
	 
	   
	  
});

function funExportBtn(){
    

	JSONToCSVCon(jobholdcancelexcel, 'Job On HoldCancel', true);
	   }



function funreload(event)
{
	var pro= $('#cmbprocess').val().split(":");
 	var bibid=pro[0]; 
	var process=pro[1];
		if(bibid==''){
		 $.messager.alert('Message','Choose a Process.','warning');
		 return 0;
	 }
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }
	 	 
	  
		   var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	$("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&process="+process);
	
	  
	}


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

function  funClearData(){
	 $('#remarks').val('');
	 $('#info').val('');
	 $('#doc').val('');
	 $('#dtyp').val('');
	 $('#trno').val('');
	 $('#cmbprocess').val('');
	 $('#jqxloaddataGrid').jqxGrid('clear');
	
	
	
}	

function funUpdate(event){
	var pro= $('#cmbprocess').val().split(":");
	var bibid=pro[0].trim();
	var proname=pro[1].trim();
	var rdocno = $('#doc').val();
	var rdtype = $('#dtyp').val();
	var remarks = $('#remarks').val();
	var txtareainfo= $('#info').val();
	var trnos = $('#trno').val();
		if(txtareainfo==''){
		 $.messager.alert('Message','Please Choose a Document.','warning');
		 return 0;
	 }
	
	
	    $.messager.confirm('Message', 'Do you want to '+proname+' the job?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(rdocno,rdtype,remarks,bibid,trnos,proname);
	     	}
	 });
}

function saveGridData(rdocno,rdtype,remarks,bibid,trnos,proname){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			if(parseInt(items)=="1")
			{
			$.messager.alert('Message', ' '+$('#dtyp').val()+ '-'+$('#doc').val()+' '+proname+' Successfully ');
			$('#remarks').val('');
			 $('#info').val('');
			 $('#doc').val('');
			 $('#dtyp').val('');
			 $('#trno').val('');
			 $('#jqxloaddataGrid').jqxGrid('clear');
			}
			else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
			
	  }
	}
		
x.open("GET","saveData.jsp?docno="+rdocno+"&dtype="+rdtype+"&remarks="+remarks+"&process="+proname+"&trnos="+trnos+"&bibid="+bibid,true);
x.send();
}
function funprocess()
{
	 $('#remarks').val('');
	 $('#info').val('');
	 $('#doc').val('');
	 $('#dtyp').val('');
	 $('#trno').val('');
	 $('#jqxloaddataGrid').jqxGrid('clear');
	}
</script>
</head>
<body onload="getBranch();getProcess();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100% "  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr><td colspan="2">&nbsp;</td></tr> 
	 	
        <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"   value='<s:property value="cmbprocess"/>' onchange="funprocess();"></select></td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>    
       	<tr><td colspan="2" align="center"><textarea id="info" style="height:80px;width:200px;font-family:Tahoma;font-size:12px;resize:none" name="info"  readonly="readonly"  ><s:property value="info" ></s:property></textarea></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
      
       <tr><td  align="right" ><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" style="height:25px;width:200px" name="remarks" value='<s:property value="remarks"/>'></div>
                    </td></tr>  
        
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>


	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
   <input type="hidden" id="doc" name="doc" value='<s:property value="doc"/>'>
   <input type="hidden" id="dtyp" name="dtyp" value='<s:property value="dtyp"/>'>
    <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr><div id="loadgriddata">
				<jsp:include page="gridDetails.jsp"></jsp:include> 
			</div></tr>
		
	</table>
</tr>
</table>

</div>
 
</div>
</body>
</html>