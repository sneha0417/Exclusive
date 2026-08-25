<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#manPowerGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#manPowerGridWindow').jqxWindow('close');
		 
		 $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#jobDetailsWindow').jqxWindow('close');
	     
	     $('#consumedDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#consumedDetailsWindow').jqxWindow('close');
	     
	     $('#assignedDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#assignedDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdjobno").checked=true;
	     $('#txtemployee').attr('disabled', true);$('#txtjobno').attr('disabled', false);
	     $('#cmbjobtype').attr('disabled', false);$('#btnSaving').attr('disabled', true);
		 $("#deployTechnicianDetailsGridId").jqxGrid('clear');$("#deployTechnicianDetailsGridId").jqxGrid("addrow", null, {});$("#deployTechnicianDetailsGridId").jqxGrid({ disabled: true});
	     $("#manPowerAssignedGridID").jqxGrid('clear');$("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"});$("#manPowerAssignedGridID").jqxGrid({ disabled: true});
	     
	     $('#txtemployee').dblclick(function(){
	    	 manPowerSearchContent('employeeDetailsSearch.jsp?id=0');
		 });
	     
	     $('#txtjobno').dblclick(function(){
	    	 if($('#cmbjobtype').val()=='' || $('#cmbjobtype').val()=='0'){
	     		  $.messager.alert('Message','Job Type is Mandatory.','warning');
	     		  return;
	     	   }
	    	 jobSearchContent('jobDetailsSearch.jsp?dtype='+$('#cmbjobtype').val());
	      });
	});
	
	function manPowerSearchContent(url) {
		$('#manPowerGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#manPowerGridWindow').jqxWindow('setContent', data);
		$('#manPowerGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function jobSearchContent(url) {
		$('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function consumedDetailsContent(url) {
		$('#consumedDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#consumedDetailsWindow').jqxWindow('setContent', data);
		$('#consumedDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function assignedDetailsContent(url) {
		$('#assignedDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#assignedDetailsWindow').jqxWindow('setContent', data);
		$('#assignedDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	manPowerSearchContent('employeeDetailsSearch.jsp?id=0');
        }
        else{}
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
	
	function getManPowerConsumed(costtype,costcode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				if(!(isNaN(items))){
	  			    var budget = $('#txtbudget').val();
	      		    var balance = parseFloat(budget) - parseFloat(items);
	           	    funRoundAmt(items,"txtconsumed");
	           	    funRoundAmt(balance,"txtbalance");
  				} else if(isNaN(items)){
  	            	 funRoundAmt(0.00,"txtconsumed");
  	            	 funRoundAmt(0.00,"txtbalance");
  	        	}
  		}
  		}
  		x.open("GET", "getManPowerConsumed.jsp?costtype="+costtype+'&costcode='+costcode, true);
  		x.send();
   }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 $("#overlay, #PleaseWait").show();
		 $('#btnSaving').attr('disabled', true);
		 $("#deployTechnicianDetailsGridId").jqxGrid('clear');$("#deployTechnicianDetailsGridId").jqxGrid("addrow", null, {});$("#deployTechnicianDetailsGridId").jqxGrid({ disabled: true});
	     $("#manPowerAssignedGridID").jqxGrid('clear');$("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"});$("#manPowerAssignedGridID").jqxGrid({ disabled: true});
	     document.getElementById("txtbudget").value="";document.getElementById("txtconsumed").value="";document.getElementById("txtbalance").value="";
	     document.getElementById("txtcosttype").value="";document.getElementById("txtcostcode").value="";document.getElementById("txtsite").value="";
		 $("#deployTechnicianGridDiv").load("deployTechnicianGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
		}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'DeployTechnician', true);
		 } else {
			 $("#deployTechnicianGridID").jqxGrid('exportdata', 'xls', 'DeployTechnician');
		 }
	 }
	
	function funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("rdjobno").checked=true;
		$('#date').val(new Date());
		
		document.getElementById("txtbudget").value="";document.getElementById("txtconsumed").value="";document.getElementById("txtbalance").value="";
		document.getElementById("txtcosttype").value="";document.getElementById("txtcostcode").value="";document.getElementById("txtsite").value="";
		document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";document.getElementById("cmbjobtype").value="amc";
		document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";
		
		if (document.getElementById("txtjobid").value == "") {
	        $('#txtjobno').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		if (document.getElementById("txtemployeedocno").value == "") {
	        $('#txtemployee').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		$("#deployTechnicianGridID").jqxGrid('clear');
		
		$("#deployTechnicianDetailsGridId").jqxGrid('clear');
		$("#deployTechnicianDetailsGridId").jqxGrid("addrow", null, {}); 
		$("#deployTechnicianDetailsGridId").jqxGrid({ disabled: true});
		
		$("#manPowerAssignedGridID").jqxGrid('clear');
		$("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"}); 
		$("#manPowerAssignedGridID").jqxGrid({ disabled: true});
		$('#btnSaving').attr('disabled', true);
	}
	
	function funSaving(event){

		 var costtype = $('#txtcosttype').val();
		 var costcode = $('#txtcostcode').val();
		 var site = $('#txtsite').val();
		 var budget = $('#txtbudget').val();
		 var consumed = $('#txtconsumed').val();
		 var balance = $('#txtbalance').val();
		 
		 if(costtype==''){
			 $.messager.alert('Message','Please select an item.','warning');
			 return 0;
		 }
		 
		 if(costcode==''){
			 $.messager.alert('Message','Please select an item.','warning');
			 return 0;
		 }
		 
		 var rows = $("#manPowerAssignedGridID").jqxGrid('getrows');
		 var gridarray=new Array();
		 for(var i=0;i<rows.length;i++){
			
			var chk=rows[i].actualhrs;
			var chks=rows[i].empdocno;
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
		    	if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					var date=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'date');
					var empid=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'empdocno');
					var intime=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'intime');
					var outtime=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'outtime');
					var hrs=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'hrs');
					var actualhrs=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'actualhrs');
					var stdcost=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'stdcost');
					var total=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'total');
					
					gridarray.push(date+":: "+empid+":: "+intime+":: "+outtime+":: "+hrs+":: "+actualhrs+":: "+stdcost+":: "+total+":: "+costtype+":: "+costcode+":: "+site.replace(/,/g , "#"));
		    	}
		    }
		 }
		 	
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 saveGridData(costtype,costcode,budget,consumed,balance,gridarray);	
		     	}
		 });
	}
	
	function saveGridData(costtype,costcode,budget,consumed,balance,gridarray) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var docno = items[1];
				
				if(parseInt(val)>0){
					$.messager.alert('Message', ' Record Successfully Saved.', function(r){
					});
					
					var costtype = $('#txtcosttype').val('');
					var costcode = $('#txtcostcode').val('');
					var site = $('#txtsite').val('');
					var budget = $('#txtbudget').val('');
					var consumed = $('#txtconsumed').val('');
					var balance = $('#txtbalance').val('');
					$("#deployTechnicianDetailsGridId").jqxGrid('clear');
					$("#deployTechnicianDetailsGridId").jqxGrid("addrow", null, {}); 
					$("#deployTechnicianDetailsGridId").jqxGrid({ disabled: true});
					$("#manPowerAssignedGridID").jqxGrid('clear');
					$("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"}); 
					$("#manPowerAssignedGridID").jqxGrid({ disabled: true});
					$('#btnSaving').attr('disabled', true);
					funreload(event);
				} else if(parseInt(val)==-1){
					 $.messager.alert('Message','Already Exists.');
					 return 0;
				} else {
					$.messager.alert('Message','Failed');
					 return 0;
				}
		  }
		}
			
		
	x.open("GET","saveData.jsp?costtype="+costtype+"&costcode="+costcode+"&budget="+budget+"&consumed="+consumed+"&balance="+balance+"&gridarray="+gridarray,true);
	x.send();
	}
	
	function funPrintDetails(){
		 var date = $('#date').val();
		 var employeedocno = $('#txtemployeedocno').val();
		 var jobno = $('#txtjobid').val();
		
         var url=document.URL;
         var reurl=url.split("deployTechnician.jsp");
        
         var win= window.open(reurl[0]+"printDeployTechnician?date="+date+'&employeedocno='+employeedocno+'&jobno='+jobno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
         win.focus();
		     
	   }
	
	function funRadioType(){
		if(document.getElementById("rdjobno").checked==true){
			document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";document.getElementById("cmbjobtype").value="amc";
			$('#txtjobno').attr('disabled', false);$('#cmbjobtype').attr('disabled', false);$('#txtemployee').attr('disabled', true);
			if (document.getElementById("txtjobid").value == "") {
		        $('#txtjobno').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		} else if(document.getElementById("rdemployee").checked==true){
			document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";document.getElementById("cmbjobtype").value="amc";
			$('#txtemployee').attr('disabled', false);$('#txtjobno').attr('disabled', true);$('#cmbjobtype').attr('disabled', true);
			if (document.getElementById("txtemployeedocno").value == "") {
		        $('#txtemployee').attr('placeholder', 'Press F3 to Search'); 
		    }
		}
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
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td align="right"><label class="branch">Budget</label></td>
    <td align="left"><input type="text" id="txtbudget" name="txtbudget" style="width:100%;height:20px;text-align: right;" readonly value='<s:property value="txtbudget"/>'/></td>
	</tr> 
	<tr><td align="right"><label class="branch">Consumed</label></td>
    <td align="left"><input type="text" id="txtconsumed" name="txtconsumed" style="width:100%;height:20px;text-align: right;" readonly value='<s:property value="txtconsumed"/>'/></td>
	</tr>  
	<tr><td align="right"><label class="branch">Balance</label></td>
    <td align="left"><input type="text" id="txtbalance" name="txtbalance" style="width:100%;height:20px;text-align: right;" readonly value='<s:property value="txtbalance"/>'/></td>
	</tr> 
	<tr>
       <td colspan="2" align="center"><input type="radio" id="rdjobno" onchange="funRadioType();" name="rdo" value="rdjobno"><label for="rdjobno" class="branch">Job</label>&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" id="rdemployee" onchange="funRadioType();" name="rdo" value="rdemployee"><label for="rdemployee" class="branch">Employee</label></td>
    </tr>
	<tr>
	 <td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    </tr>
    <tr><td align="right"><label class="branch">Job Type</label></td>
     <td align="left"><select id="cmbjobtype" name="cmbjobtype"  value='<s:property value="cmbjobtype"/>'>
     <option value="amc">AMC</option><option value="sjob">SJOB</option>
     </select></td></tr> 
	<tr>
	<td align="right"><label class="branch">Job No</label></td>
    <td align="left"><input type="text" id="txtjobno" name="txtjobno" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getJob(event);" value='<s:property value="txtjobno"/>'/>
    <input type="hidden" id="txtjobid" name="txtjobid" style="width:100%;height:20px;" value='<s:property value="txtjobid"/>'/></td>
	</tr>  
	<tr>
	<td align="right"><label class="branch">Employee</label></td>
    <td align="left"><input type="text" id="txtemployee" name="txtemployee" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getEmployee(event);" value='<s:property value="txtemployee"/>'/>
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" style="width:100%;height:20px;" value='<s:property value="txtemployeedocno"/>'/></td>
	</tr>	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;&nbsp;&nbsp;
	<button class="myButton" type="button" id="btnPrint" name="btnPrint" onclick="funPrintDetails();">Print</button></td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnSaving" name="btnSaving" onclick="funSaving(event);">Save</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtcosttype" name="txtcosttype" style="width:100%;height:20px;" readonly value='<s:property value="txtcosttype"/>'/>
	<input type="hidden" id="txtcostcode" name="txtcostcode" style="width:100%;height:20px;" readonly value='<s:property value="txtcostcode"/>'/>
	<input type="hidden" id="txtsite" name="txtsite" style="width:100%;height:20px;" readonly value='<s:property value="txtsite"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td colspan="2"><div id="deployTechnicianGridDiv"><jsp:include page="deployTechnicianGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			 <td width="40%"><div id="deployTechnicianDetailsGridDiv"><jsp:include page="deployTechnicianDetailsGrid.jsp"></jsp:include></div></td>
			 <td width="60%"><div id="manPowerAssignedGridDiv"><jsp:include page="manPowerAssignedGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</div>
<div id="manPowerGridWindow">
	<div></div><div></div>
</div> 
<div id="jobDetailsWindow">
	<div></div><div></div>
</div> 
<div id="consumedDetailsWindow">
	<div></div><div></div>
</div>
<div id="assignedDetailsWindow">
	<div></div><div></div>
</div>
</body>
</html>