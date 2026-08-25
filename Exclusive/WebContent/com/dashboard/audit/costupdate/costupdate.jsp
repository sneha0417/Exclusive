<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#costCodeDetailsWindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Cost Detail Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#costCodeDetailsWindow').jqxWindow('close');
	 
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
       
       $('#costmissingdiv').hide();
       document.getElementById("rdomissing").checked=true;
       setCosttype();
       getCostType();
       
       
       
       $('#costcode').dblclick(function(){
			 if(document.getElementById("cmbcosttype").value==""){
						$.messager.alert('warning','Cost Type is Mandatory');
						return false;
				}
		    $('#costCodeDetailsWindow').jqxWindow('open');
		$('#costCodeDetailsWindow').jqxWindow('focus');
		costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
			 
			 });
     });


function getCostCodeKey(event){
	 if(document.getElementById("cmbcosttype").value==""){
			$.messager.alert('warning','Cost Type is Mandatory');
			return false;
	}
	 var x= event.keyCode;
   if(x==114){
	   $('#costCodeDetailsWindow').jqxWindow('open');
		$('#costCodeDetailsWindow').jqxWindow('focus');
		costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
			 
   }
   else{
    }
}

function costCodeDetailsContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#costCodeDetailsWindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	  //	alert(fromdate+"==="+todate);
	    	 $("#overlay, #PleaseWait").show();
	    	 if(document.getElementById("rdomissing").checked==true){
	    		 $("#costmissingdiv").load("costMissingGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
	 		}
	 		else if(document.getElementById("rdodifference").checked==true){

		    	 $("#costupdatediv").load("costupdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");   	 
	 		}
	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
		   $("#overlay, #PleaseWait").hide();
   		  }
		
		 
	}
	
	function funExportBtn(){
		JSONToCSVCon(costmissingdataExcel, 'Job Cost Update', true);
		
	}
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		
	}

	function funPost(){
		var rows = $("#costupdateGrid").jqxGrid('selectedrowindexes');
		document.getElementById("hidtrno").value="";
		document.getElementById("hidgridacno").value="";
		/* for(var i=0;i<rows.length;i++){
    		var trno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
    		var acno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
    		if(rows.length==1){
    			document.getElementById("hidtrno").value=dummy+",";
    			document.getElementById("hidgridacno").value=acno+"::"+$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no')+",";
    		}
    		else{
    			document.getElementById("hidtrno").value+=acno+",";
    			document.getElementById("hidgridacno").value+=acno+",";
    		}
    	}
		if(document.getElementById("rdodifference").checked==true){
			document.getElementById("mode").value="A";
			$("#overlay, #PleaseWait").show();
			document.getElementById("frmCostUpdate").submit();			
		} */
		for(var i=0;i<rows.length;i++){
			var trno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
    		var acno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
    		if(i==0){
    			document.getElementById("hidgridacno").value=acno+"::"+trno;
    		}
    		else{
    			document.getElementById("hidgridacno").value+=","+acno+"::"+trno;
    		}
		}
		if(document.getElementById("rdodifference").checked==true){
			document.getElementById("mode").value="A";
			$("#overlay, #PleaseWait").show();
			document.getElementById("frmCostUpdate").submit();			
		}
	}
	
	function setCosttype(){
		if(document.getElementById("rdomissing").checked==true){
			$('#costupdatediv').hide();
			$('#costmissingdiv').show();
			$('#btncostupdate').show();
		}
		else if(document.getElementById("rdodifference").checked==true){
			$('#costmissingdiv').hide();
			$('#costupdatediv').show();
			$('#btncostupdate').hide();
		}
	}
	
	
	function getCostType() {
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
		    $("select#cmbcosttype").html(optionsbranch);
		    
		   } else {}
		  }
		  x.open("GET","getCostType.jsp", true);
		  x.send();
		 }
	
	
	function funClearCosts(){
		$('#costcode,#costcodename,#hidcostcode').val('');
		$('#costcode').attr('placeholder','Press F3 to Search');
	}
	
	
	function funMissingUpdate(){
		if(document.getElementById("rdomissing").checked==false){
			$.messager.alert('warning','Please Enable the missing option');
			return false;
		}
		if(document.getElementById("cmbcosttype").value==""){
			$.messager.alert('warning','Please choose cost type');
			return false;
		}
		if(document.getElementById("costcode").value==""){
			$.messager.alert('warning','Please choose cost code');
			return false;
		}
		var selectedrows=$('#costMissingGrid').jqxGrid('selectedrowindexes');
		var trno ="";
		for( var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("missingtrno").value+=$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tranid');
			}
			else{
				document.getElementById("missingtrno").value+=","+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tranid');
			}
		}
		document.getElementById("mode").value="MU";
		$("#overlay, #PleaseWait").show();
		document.getElementById("frmCostUpdate").submit();		
		
	}
	function funUpdateMissing(trno,costtype,costcode){
		//alert(trno+"::"+costtype+"::"+costcode);
	/* 	  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var items = x.responseText.trim();
		    if(items=="1"){
		    	$.messager.alert('warning','Updated Successfully');
		    	funreload("");
		    }
		    else{
		    	$.messager.alert('warning','Not Updated');
		    	funreload("");
		    }
		   } else {}
		  }
		  x.open("POST","updateCostMissing.jsp?trno="+trno+"&costtype="+costtype+"&costcode="+costcode, true);
		  x.send();
	 */
	 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="99%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 

 
	<tr>
	  <td colspan="2"  align="center">
      <input type="radio" name="rdocosttype" id="rdomissing" onchange="setCosttype();"><label for="rdomissing" class="branch">Manual</label>
      &nbsp;&nbsp;
		<input type="radio" name="rdocosttype" hidden="true" id="rdodifference" onchange="setCosttype();"><label for="rdodifference" class="branch"><!-- Automatic --></label>
      </td>
	  </tr>
	<tr>
	  <td  align="right"><label class="branch">Cost Type</label></td>
	  <td align="left"><select name="cmbcosttype" id="cmbcosttype" onchange="funClearCosts();"><option value="">--Select--</option></select></td>
	  </tr>
	<tr>
	  <td  align="right"><label class="branch">Cost Code</label></td>
	  <td  align="left"><input type="text" name="costcode" id="costcode" placeholder="Press F3 to Search" readonly onkeydown="getCostCodeKey(event);" style="height:18px;"></td>
	  </tr>
	<tr>
	  <td  align="center">&nbsp;</td>
	  <td  align="left"><input type="text" name="costcodename" id="costcodename"  readonly style="height:18px;"></td>
	  </tr>
	<tr>
	  <td colspan="2"  align="center"><button type="button" name="btncostupdate" id="btncostupdate" class="myButtons" onClick="funMissingUpdate();">Update</button></td>
	  </tr>
	<tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	 
	<center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="hidden" hidden="true" name="btnpost" id="btnpost" value="Post" class="myButtons" onclick="funPost();">
	</center>
   
    </td>
	</tr>
		  <tr>
   <td colspan="2" align="right">
 <br><br><br><br><br><br><br><br><br><br><br>
   </td>
 </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <%-- <div id="costupdatediv"> <jsp:include page="costupdateGrid.jsp"></jsp:include></div> --%>
			 <div id="costmissingdiv" > <jsp:include page="costMissingGrid.jsp"></jsp:include> </div> 		
			 </td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidtrno" id="hidtrno">
			  <input type="hidden" name="hidgridacno" id="hidgridacno">
			  <input type="hidden" name="hidcostcode" id="hidcostcode">
			  <input type="hidden" name="missingtrno" id="missingtrno" value='<s:property value="missingtrno"/>'>
			  
		</tr>
	</table>
</tr>
</table>
</div>
<div id="costCodeDetailsWindow">
   <div ></div>
</div>
</div>

</form>
</body>
</html>