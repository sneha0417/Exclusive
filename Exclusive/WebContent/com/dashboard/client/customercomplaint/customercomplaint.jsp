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
<title>Customer Complaint</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">
$(document).ready(function () {
	
	document.getElementById('rdpending').checked=true;   
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    
    
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Property Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	$('#refnosearchwindow').jqxWindow('close');  
	
    $('#jobsearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Job Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
	$('#jobsearchwindow').jqxWindow('close');

	$('#refnosearchwindow1').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Tenant Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	$('#refnosearchwindow1').jqxWindow('close'); 
	
	$("#cmbbranch").hide();
    $("#branchlabel").hide();
    $("#branchdiv").hide();
    getProcess();reportTypeChange(); typechange();
    
    $('#cmbtenant').dblclick(function(){
	 	refsearchContent2('tmainsearch.jsp');
	});		
	$('#cmbproperty').dblclick(function(){
	 	refsearchContent1('pmainsearch.jsp');
	});	
	$('#cmbjob').dblclick(function(){
		jobSearchContent('jobSearch.jsp');
	});	
     
});

function getJob(event){   
	 jobSearchContent('jobSearch.jsp'); 	 
} 
function jobSearchContent(url) { 
	$('#jobsearchwindow').jqxWindow('open');
	
	 $.get(url).done(function (data) { 
		 $('#jobsearchwindow').jqxWindow('setContent', data); 
	 	 }); 
    }

function getTenant(event){
	refsearchContent2('tmainsearch.jsp');
}

function refsearchContent2(url) {
	$('#refnosearchwindow1').jqxWindow('open');
	$.get(url).done(function (data) {
	//alert(data);
		$('#refnosearchwindow1').jqxWindow('setContent', data);
	}); 
}	

function getProperty(event){
	refsearchContent1('pmainsearch.jsp');
}

function refsearchContent1(url) {
	$('#refnosearchwindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	//alert(data);
		$('#refnosearchwindow').jqxWindow('setContent', data);
	 }); 
}	

function funreload(event){
	 $("#custcomp").jqxGrid('clear');
	 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdpending").checked==true){
			 $("#custcompDiv").load("customercomplaintGrid.jsp?&type=1&check=1");
	 } else {
		 $("#custcompDiv").load("customercomplaintGrid.jsp?&type=2&check=1");
	 }
			
}

function getProcess() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbprocess").html(optionsbranch);
			
		} else {}
	}
	x.open("GET","getProcess.jsp", true);
	x.send();
}

function saveGridData(process,date,remarks,docno,processname,rdocno){
    //alert(date)
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
     			
			var items=x.responseText;
			if(items>0){
			$('#cmbprocess').val('');
			$('#date').val(new Date());
			$('#txtremarks').val('');
			$('#cmbtenant').val('');
			$('#cmbproperty').val('');
			$('#cmbjob').val('');
			 $("#documentDetailsGrid").jqxGrid('clear');
			 $("#custcomp").jqxGrid('clear');
				
			$.messager.alert('Message', '  Record Successfully Updated ', function(r){
		    });
			disable();
			}else{
				$.messager.alert('Message', '  Not Updated ', function(r){
	   });
     }
   }
}	
		
x.open("GET","saveData.jsp?process="+process+"&date="+date+"&remarks="+remarks+"&docno="+docno+"&processname="+processname+"&rdocno="+rdocno,true);
x.send();
		
}


function typechange(){
var type= $('#cmbprocess').val();
//alert(type);
if(type==43){
	  $('#cmbproperty').attr("disabled",false);
	  $('#cmbtenant').attr("disabled",false);
	  $('#btncreate').attr("disabled",false);
	  $('#cmbjob').attr("disabled",false);
	  $('#btnupdate').attr("disabled",true); 
	  $('#txtremarks').attr("disabled",true);

}else if(type==30){
	  $('#cmbproperty').attr("disabled",true);
	  $('#cmbtenant').attr("disabled",true);
	  $('#btncreate').attr("disabled",true);
	  $('#cmbjob').attr("disabled",true);
	  $('#btnupdate').attr("disabled",false); 
	  $('#txtremarks').attr("disabled",false);
	
		 
} else if(type==32){
	  $('#cmbproperty').attr("disabled",true);
	  $('#cmbtenant').attr("disabled",true);
	  $('#btncreate').attr("disabled",true);
	  $('#cmbjob').attr("disabled",true);
	  $('#btnupdate').attr("disabled",false); 
	  $('#txtremarks').attr("disabled",false);
} else{
	 $('#cmbproperty').attr("disabled",true);
	  $('#cmbtenant').attr("disabled",true);
	  $('#btncreate').attr("disabled",true);
	  $('#cmbjob').attr("disabled",true);
	  $('#btnupdate').attr("disabled",true); 
	  $('#txtremarks').attr("disabled",true);
}
	
}
function funcreatePMR (event){
	var rdocno=document.getElementById("rdocno").value;
	var hidcmbtenant=document.getElementById("hidcmbtenant").value;
	var hidcmbtenant=document.getElementById("hidcmbtenant").value;
	
	var pmrarray=new Array();
	
	var rowss = $("#custcomp").jqxGrid('getrows');

	var rows=$("#custcomp").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}  
	
	
	
	var property = $('#cmbproperty').val();
	var tenant =  $('#cmbtenant').val();
	
	if(property==''){
		 $.messager.alert('Message','Choose a Property.','warning');
		 return 0;
	 }

	 if(tenant==''){
		 $.messager.alert('Message','Choose a Tenant.','warning');   
		 return 0;
	 }
	 var i=0;;            
		var j=0;
		

	
			var hidcmbtenant =document.getElementById("hidcmbtenant").value;
			var hidcmbproperty =document.getElementById("hidcmbproperty").value;
			var job_docno =document.getElementById("hidcmbjob").value;
			var comments = document.getElementById("description").value;
			
				 
			 
		   pmrarray.push(job_docno+" :: "+hidcmbtenant+" :: "+0+" :: "+0+" :: "+0+" :: "+comments+" :: "+0);
				
		     

	 
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		savePMR(pmrarray,hidcmbproperty,hidcmbtenant,rdocno);	
	     	}
	});
}
	
function savePMR(pmrarray,hidcmbproperty,hidcmbtenant,rdocno){
    //alert(date)
    

    var reqdocno=document.getElementById("reqdocno").value;
    if(reqdocno>0){
    	 $.messager.alert('Message','Mnt Req already Created.','warning');
		 return 0;
	 }
   
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
     			
		var items= x.responseText.trim().split('####');
		if(parseInt(items[0])>0){
			
			
			$('#cmbprocess').val('');
			$('#date').val(new Date());
			$('#txtremarks').val('');
			$('#cmbtenant').val('');
			$('#cmbtenant').attr('placeholder','Press F3 to Search');
			$('#cmbproperty').val('');
			$('#cmbproperty').attr('placeholder','Press F3 to Search');
			$('#cmbjob').val('');
			$('#cmbjob').attr('placeholder','Press F3 to Search');
			$("#documentDetailsGrid").jqxGrid('clear');
			$("#custcomp").jqxGrid('clear');
		
			
			$.messager.alert('message','Mnt Req. - '+items[1]+  ' Successfully Created', function(r){
			
		    });
			
			}else{
				$.messager.alert('Message', '  Not Updated ', function(r){
	   });
     }
   }
}	
		
x.open("GET","createPMR.jsp?pmrarray="+encodeURIComponent(pmrarray)+"&hidcmbproperty="+hidcmbproperty+"&hidcmbtenant="+hidcmbtenant+"&rdocno="+rdocno,true);
x.send();
		
}
function funUpdate(event){
	var process = $('#cmbprocess').val();
	var date =  $('#date').val();
	var remarks = $('#txtremarks').val();
	var docno = $('#docno').val();
	var processname = $("#cmbprocess option:selected").text().trim();
	var rdocno = $('#rdocno').val();
	
	if(process==''){
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
	     		saveGridData(process,date,remarks,docno,processname,rdocno);	
	     	}
	});
}
function reportTypeChange(){
	if(document.getElementById("rdpending").checked==true){
		$("#custcomp").jqxGrid('clear');
	    $("#documentDetailsGrid").jqxGrid('clear');
	    $('#txtremarks').attr('disabled', false);
		$('#date').attr('disabled', false);
		$('#cmbprocess').attr('disabled', false);
		$('#clear').attr('disabled', false);
		$('#btnupdate').attr('disabled', false);
		
	}	else if(document.getElementById("rdcompleted").checked==true){
		$("#custcomp").jqxGrid('clear');
		$("#documentDetailsGrid").jqxGrid('clear');
		$('#txtremarks').attr('disabled', true);
		$('#date').attr('disabled', true);
		$('#cmbprocess').attr('disabled', true);
		$('#clear').attr('disabled', true);
		$('#btnupdate').attr('disabled', true);
		
	}
}	


function funExportBtn(){
	if(document.getElementById("rdpending").checked==true){
		
	  $("#custcompDiv").excelexportjs({
		containerid: "custcompDiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "custcomp", 
		columns: getColumns("custcomp") ,   
		worksheetName:"Customer Complaint-Pending"
		});
	} else if(document.getElementById("rdcompleted").checked==true){
		  $("#custcompDiv").excelexportjs({
				containerid: "custcompDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "custcomp", 
				columns: getColumns("custcomp") ,   
				worksheetName:"Customer Complaint-Completed"
				});  
	  }
 }

function  funClearData(){  
	$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');$('#cmbproperty').val('');$('#cmbtenant').val('');$('#hidcmbproperty').val('');$('#hidcmbtenant').val('');$('#description').val('');$('#complaint').val('');$('#jobdocno').val('');$('#reqdocno').val('');$('#cmbjob').val('');$('#hidcmbjob').val('');
	 $("#documentDetailsGrid").jqxGrid('clear');
	 $("#custcomp").jqxGrid('clear');
}
</script> 

<style type="text/css">
.rowgap{
 padding:20px;
 }
</style>

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
	
	  <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdpending" name="rdo" onchange="reportTypeChange();" value="rdpending"><label for="rdpending" class="branch">Pending</label></td>
       <td width="52%" align="center"><input type="radio" id="rdcompleted" name="rdo" onchange="reportTypeChange();" value="rdcompleted"><label for="rdcompleted" class="branch">Completed</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>

	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:90%;" name="cmbprocess"  onchange=" typechange();" value='<s:property value="cmbprocess"/>'></select></td></tr>
     
       
     <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:90%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
   
  <tr><td colspan="2">&nbsp;</td></tr>
	
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	 <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
      <tr><td><input type="hidden" name="rdocno" id="rdocno"  value='<s:property value="rdocno"/>'></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
     
     <tr><td colspan="2">
 <fieldset>
  <legend ><b><label class="branch">Maintenance Request</label></b></legend>
    <table>
                                              
     <tr><td align="right"><label class="branch">Property</label></td>
	 <td align="left"><input name="cmbproperty" id="cmbproperty" style="width:90%;" name="cmbproperty" placeholder="Press F3 to Search"  onclick="getProperty(event);" value='<s:property value="cmbproperty"/>'>
	  <input type="hidden" name="hidcmbproperty" id="hidcmbproperty" style="width:90%;" name="hidcmbproperty"></td></tr>
  
   
     <tr><td align="right"><label class="branch">Tenant</label></td>
	 <td align="left"><input name="cmbtenant" id="cmbtenant" style="width:90%;" name="cmbtenant" placeholder="Press F3 to Search" onkeydown="getTenant(event);" value='<s:property value="cmbtenant"/>'>
	 <input type="hidden" name="hidcmbtenant" id="hidcmbtenant" style="width:90%;" name="hidcmbtenant"></td></tr>
	 
   <tr><td align="right"><label class="branch">Job</label></td>
	 <td align="left"><input name="cmbjob" id="cmbjob" style="width:90%;" name="cmbjob" placeholder="Press F3 to Search" onkeydown="getJob(event);" value='<s:property value="cmbjob"/>'>
	 <input type="hidden" name="hidcmbjob" id="hidcmbjob" style="width:90%;" name="hidcmbjob"></td></tr>
   
 <tr><td><input type="hidden" name="jobdocno" id="jobdocno" style="width:90%;" name="jobdocno">
 <input type="hidden" name="complaint" id="complaint" style="width:90%;" name="complaint">
 <input type="hidden" name="description" id="description" style="width:90%;" name="description">
   <input type="hidden" name="reqdocno" id="reqdocno" style="width:90%;" name="reqdocno"></td></tr>
 
  <tr><td colspan="2">&nbsp;</td></tr>

 <tr><td colspan="2" align="center"> <button class="myButton" type="button" id="btncreate" name="btncreate" onclick="funcreatePMR(event);">Create PMR</button></td></tr>
 
  <tr><td colspan="2">&nbsp;</td></tr>
    
  
   </table>
  </fieldset>
	 </table>
</fieldset>

 
 
</td>  
	<td width="80%">
	<table width="100%">
		<tr><td><div id="custcompDiv"><jsp:include page="customercomplaintGrid.jsp"></jsp:include> </div></td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td><div id="docdetailsDiv"><jsp:include page="FollowUpGrid.jsp"></jsp:include> </div></td></tr>
	
	</table>
	</td>
</tr>
</table>

</div>
</div>
<div id="refnosearchwindow1">
			<div></div>
		</div>
		<div id="refnosearchwindow">
			<div></div>
		</div>
		<div id="jobsearchwindow">
			<div></div>
		</div>
</body>
</html>	
