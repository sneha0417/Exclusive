
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

 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
    
		JSONToCSVCon(jobcloseexcel, 'Job Close', true);
	   
	}



function funreload(event)
{
	
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }
	 	 
	   var rds;
		
		 if (document.getElementById('radio_tobeclose').checked) {
				
			 rds=$("#radio_tobeclose").val();
			  
			} 
		 else{
			 rds=$("#radio_closedlist").val();
		 }
		   var barchval = document.getElementById("cmbbranch").value;
		   var fromdate= $("#fromdate").val();
		   var todate= $("#todate").val();
		   
		   $("#overlay, #PleaseWait").show();
			
		   $("#loadgriddiv").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&check=1");
	
	  
	}


function  funClearData(){
	 $('#remarks').val('');
	 $('#info').val('');
	 $('#doc').val('');
	 $('#dtyp').val('');
	 $('#trno').val('');
	
	 $('#jqxjobclosegrid').jqxGrid('clear');
	
	
	
}	

function funUpdate(event){
	
	var rdocno = $('#doc').val();
	var rdtype = $('#dtyp').val();
	var remarks = $('#remarks').val();
	var txtareainfo= $('#info').val();
	var trnos = $('#trno').val();
	var closedate = $('#closedate').val();
	
		if(txtareainfo==''){
		 $.messager.alert('Message','Please Choose a Document.','warning');
		 return 0;
	 }
	
	
	    $.messager.confirm('Message', 'Do you want to Close the job?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(rdocno,rdtype,remarks,trnos,closedate);
	     	}
	 });
}

function saveGridData(rdocno,rdtype,remarks,trnos,closedate){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			if(parseInt(items)=="1")
			{
			$.messager.alert('Message', ' '+$('#dtyp').val()+ '-'+$('#doc').val()+' Closed Successfully ');
			$('#remarks').val('');
			 $('#info').val('');
			 $('#doc').val('');
			 $('#dtyp').val('');
			 $('#trno').val('');
			 $('#jqxjobclosegrid').jqxGrid('clear');
			}
			else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
			
	  }
	}
		
x.open("GET","saveData.jsp?docno="+rdocno+"&dtype="+rdtype+"&remarks="+remarks+"&trnos="+trnos+"&closedate="+closedate,true);
x.send();
}
function funRadio()
{
	 var rad;
		
	 if (document.getElementById('radio_tobeclose').checked) {
			
		 rad=$("#radio_tobeclose").val();
		 $('#closedate').jqxDateTimeInput({ disabled: false});
		 $('#info').attr("disabled",false);
		 $('#remarks').attr("disabled",false);
		 $('#clear').attr("disabled",false);
		 $('#btnupdate').attr("disabled",false);
		 $("#jqxjobclosegrid").jqxGrid('clear');
		  
		} 
	 else{
		 rad=$("#radio_closedlist").val();
		 $('#info').val('');
			$('#remarks').val('');
			 $('#closedate').jqxDateTimeInput({ disabled: true});
		 $('#info').attr("disabled",true);
		 $('#remarks').attr("disabled",true);
		 $('#clear').attr("disabled",true);
		 $('#btnupdate').attr("disabled",true);
		 $("#jqxjobclosegrid").jqxGrid('clear');
	 }
	
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%"  >
<tr>
<td width="21%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<tr><td colspan="2">
	<jsp:include page="../../heading.jsp"></jsp:include>
	</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td width="30%" align="right" ><label class="branch">From</label></td><td align="left" width="50%"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr><td colspan="2"></td></tr> 
	<tr ><td align="right" > <label class="branch">Close</label></td> <td ><input type="radio" id="radio_tobeclose" name="category" value="TC" onclick="funRadio(this);" checked="checked"> 
	 	 &nbsp;&nbsp;&nbsp;&nbsp;<label class="branch">Closed List</label>
         <input type="radio" id="radio_closedlist" name="category" value="CL" onclick="funRadio(this);" >
         
         </td>
	 	</tr>
	 	 <tr><td colspan="2"></td></tr>

	 	<tr><td colspan="2"><hr  size=1 color="black"  width="100%"></td></tr>
        <tr><td colspan="2"></td></tr>
	  <tr><td  align="right" ><label class="branch">Close On</label></td><td align="left"><div id='closedate' name='closedate' value='<s:property value="closedate"/>'></div>
                    </td></tr>
	<tr><td colspan="2"></td></tr>
    <tr><td colspan="2" align="center"><textarea id="info" style="height:80px;width:100%;font-family:Tahoma;font-size:12px;resize:none" name="info"  readonly="readonly"  ><s:property value="info" ></s:property></textarea></td></tr>
      <tr><td colspan="2"></td></tr>
       <tr><td  align="right" ><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" style="height:25px;width:200px" name="remarks" value='<s:property value="remarks"/>'></div>
                    </td></tr>  
        
	 	<tr><td colspan="2"></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>

	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
   <input type="hidden" id="doc" name="doc" value='<s:property value="doc"/>'>
   <input type="hidden" id="dtyp" name="dtyp" value='<s:property value="dtyp"/>'>
    <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
</td>
<td width="79%">
	<table width="100%">
		<tr><div id="loadgriddiv">
				<jsp:include page="gridDetails.jsp"></jsp:include> 
			</div></tr>
		
	</table>
</tr>
</table>

</div>
 
</div>
</body>
</html>