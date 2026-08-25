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
		    $('#jobDiv').show();
		    $('#deployTechnicianDetailsGridDiv').show();
		    $('#manPowerConsumedDiv').show();
		    document.getElementById('rjob').checked=true;
		    $('#empDiv').hide();
		    $('#emp2Div').hide();
		    $('#txtjobno').attr('disabled', false);
			$('#txtsergroup').attr('disabled', true);
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#jobDetailsWindow').jqxWindow('close');
	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Team Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#grpinfowindow').jqxWindow('close');
		
	       
	     $('#txtjobno').dblclick(function(){
	    	 if($('#cmbjobtype').val()=='' || $('#cmbjobtype').val()=='0'){
	     		  $.messager.alert('Message','Job Type is Mandatory.','warning');
	     		  return;
	     	   }
	    	 jobSearchContent('jobDetailsSearch.jsp?dtype='+$('#cmbjobtype').val());
	      });
	     $('#txtsergroup').dblclick(function(){
			   
	    	 var id=1;
	    	 $('#grpinfowindow').jqxWindow('open');
		      //grpSearchContent('servicegrpsearch.jsp');
	    	 grpSearchContent('servicegrpsearch.jsp?id='+id);
			   		
			 });
	
	});
  	 
	function grpSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#grpinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
 function getgrpcode(event,id){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp?id='+id);
	   	 }
		 else{
			 }
		 }
	function jobSearchContent(url) {
		$('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function getJob(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbjobtype').val()=='' || $('#cmbjobtype').val()=='0'){
	     		  $.messager.alert('Message','Job Type is Mandatory.','warning');
	     		  return;
	     	   }
	    	 jobSearchContent('jobDetailsSearch.jsp?dtype='+$('#cmbjobtype').val());
        }
        else{}
    }
	
	function fundisable(){
		
	      if (document.getElementById('rjob').checked) {
		
		   $('#jobDiv').show();
		   $('#deployTechnicianDetailsGridDiv').show();
		   $('#manPowerConsumedDiv').show();
		   $('#empDiv').hide();
		   $('#emp2Div').hide();
		   $('#txtjobno').attr('disabled', false);
		   $('#txtsergroup').attr('disabled', true);
		   }
	     else if (document.getElementById('remp').checked) {
	    	   $('#txtjobno').attr('disabled', true);
			   $('#txtsergroup').attr('disabled', false);
		  $('#jobDiv').hide();
		  $('#deployTechnicianDetailsGridDiv').hide();
		  $('#manPowerConsumedDiv').hide();
		  $('#empDiv').show();
		  $('#emp2Div').show();
		 }
	   }
	function funExportBtn(){
		if (document.getElementById('rjob').checked) {
			JSONToCSVCon(Exceldata1, 'Job Wise Deploy Technician Details', true);
		}
		if (document.getElementById('remp').checked) {
			JSONToCSVCon(Exceldata2, 'Employee Wise Deploy Technician Details', true);
			}
		 }
	function funreload(event){
		     var jobno=document.getElementById("txtjobno").value;
		     var sergroup=document.getElementById('txtsergroup').value;
		     var sergroupid=document.getElementById('sergroupid').value;
			 var frmdate=$('#fromdate').val();
			 var todate=$('#todate').val();
			// alert("jobno"+jobno+"jobtype"+sergroup);
			 
		     if (document.getElementById('rjob').checked) {
			   $('#jobDiv').show();
			   $("#overlay, #PleaseWait").show(); 
			   var load="yes";
		       $("#jobDiv").load("jobGrid.jsp?jobno="+jobno+"&frmdate="+frmdate+"&todate="+todate+"&id="+1);
			 }
			 if (document.getElementById('remp').checked) {
				 
		        $('#empDiv').show();		
			    $("#overlay, #PleaseWait").show();
			    var load="yes";
			    $("#empDiv").load("employeeGrid.jsp?sergroupid="+sergroupid+"&frmdate="+frmdate+"&todate="+todate+"&id="+1);
			 }
	    }
      function getServTeam(event,id){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#teaminfowindow').jqxWindow('open');
	      teamSearchContent('serviceTeamSearch.jsp?id='+id);
	   	 }
		 else{
			 }
		 }
      function funClear(){
			$("#manPowerConsumedGridId").jqxGrid('clear'); 
			$("#jqxjobGrid").jqxGrid('clear');
			$("#jqxemp2Grid").jqxGrid('clear');
			$("#jqxempGrid").jqxGrid('clear'); 
			$("#deployTechnicianDetailsGridId").jqxGrid('clear');
			document.getElementById("txtsergroup").value="";
		    document.getElementById("sergroupid").value="0";
		    document.getElementById("txtjobno").value="";
		    document.getElementById("txtjobid").value="0";
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
			
		<tr>
		<td colspan="2" align="center"><input type="radio" id="rjob" name="stkled" onchange="fundisable();" value="rjob"><label for="rjob" class="branch">Job Wise</label>
		&nbsp;&nbsp;<input type="radio" id="remp" name="stkled" onchange="fundisable();" value="remp"><label for="remp" class="branch">Employee Wise</label></td>
		</tr>
		
		 <tr>
		 <td align="right"><label class="branch">From</label></td>
	     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
		<tr>
		<td align="right"><label class="branch">To</label></td>
	    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
		</tr>
		   <tr><td align="right"><label class="branch">Job Type</label></td>
               <td align="left"><select id="cmbjobtype" name="cmbjobtype"  value='<s:property value="cmbjobtype"/>'>
                <option value="amc">AMC</option><option value="sjob">SJOB</option>
                </select>
            <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button> </td>
            </tr> 
	     <tr>
	 	<tr>
		<td align="right"><label class="branch">Job No</label></td>
          <td align="left"><input type="text" id="txtjobno" name="txtjobno" style="width:70%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getJob(event);" value='<s:property value="txtjobno"/>'/>
          <input type="hidden" id="txtjobid" name="txtjobid" style="width:70%;height:20px;" value='<s:property value="txtjobid"/>'/></td>
        </tr>
         <tr>
	      <td align="right"><label class="branch">Service Team</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsergroup" id="txtsergroup" value='<s:property value="txtsergroup"/>' onKeyDown="getgrpcode(event,1);" readonly placeholder="Press F3 to Search">
          <input type="hidden" id="sergroupid" name="sergroupid" value='<s:property value="sergroupid"/>'></td>
	      </tr>
	         
	     
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
			 <td colspan="2"><div id="jobDiv"><jsp:include page="jobGrid.jsp"></jsp:include></div></td>
	        </tr>
	        <tr>
            <td width="40%"><div id="deployTechnicianDetailsGridDiv"><jsp:include page="deployTechnicianDetailsGrid.jsp"></jsp:include></div></td>
	        <td width="60%"><div id="manPowerConsumedDiv"><jsp:include page="manPowerConsumedGrid.jsp"></jsp:include></div></td>
	        </tr>
	        <tr>  
	         <td width="100%"><div id="empDiv"><jsp:include page="employeeGrid.jsp"></jsp:include></div></td>
		   </tr>
		   <tr>
		   <td width="100%"><div id="emp2Div"><jsp:include page="employeeGrid2.jsp"></jsp:include></div></td>
		   </tr>
		   
	</table>
	</td>
  </tr>
</table> 
</div>
</div>  
<div id="jobDetailsWindow"> 
	<div></div><div></div>  
</div>
<div id="grpinfowindow">
   <div ></div>
</div>
</body>
</html>
	
	
	