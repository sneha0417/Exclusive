<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
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
		 $("#serdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", value: null, enableBrowserBoundsDetection: true});
		 $("#stdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#contractDetailsWindow').jqxWindow({width: '40%', height: '50%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#contractDetailsWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
	     $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
			 	// alert(fromdates+"=="+todates);
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	   return false;
			  }   
		 });
	     
		 $('#txtclientname').dblclick(function(){
			 accountsSearchContent('clientAccountDetailsSearch.jsp');
	     });
		 
		 $('#txtcontract').dblclick(function(){
			 if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
	     });
		 
		 $('#txteditrval').val('0');$('#txteditrfillval').val('0');
		 if($("#msg").val()=="Successfully Saved" || $("#msg").val()=="Not Saved") { 
			 $.messager.alert('Message',$('#msg').val());
		}
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
	    $('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function funExportBtn(){
			JSONToCSVCon(dataExcelExport, 'ContractServiceScheduleUpdate', true);
	} 
	
	function getClientAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountsSearchContent('clientAccountDetailsSearch.jsp');
        }
        else{}
        }
	
	function getContract(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
        }
        else{}
        }
	
	function funreload(event){
		
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		 if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  }
		  
	     var branch = document.getElementById("cmbbranch").value;
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var contracttype=$('#cmbcontracttype').val();
		 var contract= $("#txtcontracttrno").val();
		 var clientid=$('#txtclientaccountdocno').val();
		 $('#txteditrval').val('0');
		 $('#txteditrfillval').val('0');
		 $("#serviceScheduleGridID").jqxGrid('clear');$("#serviceScheduleGridID").jqxGrid({ disabled: true});$("#serviceScheduleGridID").jqxGrid('clearselection');
		 disable();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#contractServiceScheduleUpdateDiv").load("contractServiceScheduleUpdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&contracttype="+contracttype+"&contract="+contract+"&clientid="+clientid);
		
		}
	
	function  funClearData(){
		 $('#cmbbranch').val('a');
   	     $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $('#todate').val(new Date());
	     
		 $('#txtclientname').val('');
		 $('#txtclientaccountdocno').val('');
		 $('#cmbcontracttype').val('ALL');
		 $('#txtcontract').val('');
		 $('#txtcontracttrno').val('');
		 $('#txtselectedcontract').val('');
		 $('#txtselectedcontractdtype').val('');
		 $('#txtcntrval').val('');
		 $('#txteditrval').val('0');
		 $('#txteditrfillval').val('0');
		 
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 if (document.getElementById("txtcontract").value == "") {
		        $('#txtcontract').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 $("#contractServiceScheduleUpdateGridID").jqxGrid('clear');$("#contractServiceScheduleUpdateGridID").jqxGrid('addrow', null, {});$("#contractServiceScheduleUpdateGridID").jqxGrid('clearselection');
		 disable();
	}
	
	function disable(){
		$('#srvcinterval').val('');$('#serdueafter').val('');$('#cmbsrvctype').val('1');$('#txteditrfillval').val('0');$('#serdate').val(null);$('#stdate').val(new Date());$('#enddate').val(new Date());
		$('#srvcinterval').attr('readonly', true);
		$('#serdueafter').attr('readonly', true);
		$('#cmbsrvctype').attr('disabled', true);
		$('#btnAdd').attr('disabled', true);
		$('#serdate').jqxDateTimeInput({disabled: true});
		$('#stdate').jqxDateTimeInput({disabled: true});
		$('#enddate').jqxDateTimeInput({disabled: true});
		$("#serviceScheduleGridID").jqxGrid('clear');$("#serviceScheduleGridID").jqxGrid({ disabled: true});$("#serviceScheduleGridID").jqxGrid('clearselection');
	}
	
	function funServiceScheduleFill(){
		
		var startdate=$("#serdate").val();
		var enddate=$("#enddate").val();
		var stdate=$("#stdate").val();
		var amount=0;
		var instno=$("#srvcinterval").val();
		var cmbpaytype=$("#cmbsrvctype").val();
		var serdueafter=$("#serdueafter").val();
		
		if($('#srvcinterval').val()==''){
			   $.messager.alert('Message','Interval is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#serdueafter').val()==''){
			   $.messager.alert('Message','Due After is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#cmbsrvctype').val()==''){
			   $.messager.alert('Message','Frequency is Mandatory.','warning');   
			   return false;
		 }
		
		if($('#serdate').jqxDateTimeInput('getDate')==null){
			   $.messager.alert('Message','Service Start Date is Mandatory.','warning');   
			   return false;
		}
		
		if($('#serdate').jqxDateTimeInput('getDate')!=null){
	  		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
	  		var status=checkScheddate(date);
	  		
	  		if(status){
	  			$('#txteditrfillval').val('1');
	  			$("#serviceScheduleDiv").load("serviceScheduleGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&serdueafter="+serdueafter+"&gridload=1");
	  		}
	  		
	  	}
	 
	}
	
	function checkScheddate(date){
		 var date1=new Date(date);
		 date1.setHours(0,0,0,0);
		 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
		 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
		 enddate.setHours(0,0,0,0);
		 
		 if(date1<stdate){
			 $.messager.alert('Message','Service Date Should not less than Start Date.','warning');   
			 return false;
		 }
		 else if(date1>enddate){
			 $.messager.alert('Message','Service Date Should not greater than End Date.','warning');   
			 return false;
		 }
		 
		 else{
			 return true;
		 }
	}
	
	function servicestartdatechange(){
		
		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
		checkScheddate(date);
  		
	  }
	
	function funServiceSchedulerUpdate(){
		
		var rows = $("#serviceScheduleGridID").jqxGrid('getrows');
		$('#serviceScheduleGridID').jqxGrid('clearfilters');
		var rowindex=0;
		if(rows.length==0){
			$("#overlay, #PleaseWait").hide();
			 $.messager.alert('Message','Service Scheduler is Unavailable.','warning');   
			 return false;
		}
		
			   $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else {
			     		 $("#overlay, #PleaseWait").show();
			     		 //var docno=$('#txtselectedcontract').val();
			     		 //var dtype=$('#txtselectedcontractdtype').val();
			    		 //var interval=$("#srvcinterval").val();
			    		// var frequency=$("#cmbsrvctype").val();
			    		// var servicedueafter=$("#serdueafter").val();
			    		// var servicestartdate=$("#serdate").val();
			    		 //var editval=$('#txteditrval').val();
			    		// var editfillval=$('#txteditrfillval').val();
			    		 for(var i=0 ; i < rows.length ; i++){
			    			 var chks2=rows[i].trno;  
			    			 var dis=0;
							    
							   if (rows[i].priority == true) {
									dis=1;
							   }
							   
							   var d=new Date(rows[i].pltime);
							   var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
			    			 if(typeof(chks2) != "undefined" && typeof(chks2) != "NaN" && chks2 != "" && chks2 != "0"){
									newTextBox = $(document.createElement("input"))
								       .attr("type", "dil")
								       .attr("id", "test"+i)
								       .attr("name", "test"+i)      
								       .attr("hidden", "true");
							   newTextBox.val(rows[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows[i].trno+" :: "+rows[i].workper+" :: "+rows[i].siteid+" :: ");  
							   newTextBox.appendTo('form');                        
							   rowindex++;       
							   $('#gridlength').val(rowindex);  
						 	   }     
						   	  
							   
							   //gridarray.push(rows[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows[i].trno+" :: "+rows[i].workper+" :: "+rows[i].siteid+" :: ");
						 
					     }
			     		 //saveGridData(docno,dtype,interval,frequency,servicedueafter,servicestartdate,editval,editfillval,gridarray);	
			     	}
			     	 document.getElementById("mode").value="A";           
					 document.getElementById("frmcontractServiceScheduleUpdate").submit(); 
			 });
		
		
	}
	
	function saveGridData(docno,dtype,interval,frequency,servicedueafter,servicestartdate,editval,editfillval,gridarray) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var docno = items[1];
				
				if(parseInt(val)>0){
					$.messager.alert('Message', ' Updated Successfully.', function(r){
					});
					
					$('#txtselectedcontract').val('');
					$('#txtselectedcontractdtype').val('');
					$('#txtcntrval').val('');
					disable();funreload(event);
				
				} else {
					$.messager.alert('Message', ' Failed.', function(r){
					});
					$("#overlay, #PleaseWait").hide();
				}
		  }
		}
			
		
	x.open("GET","saveData.jsp?docno="+docno+"&dtype="+dtype+"&interval="+interval+"&frequency="+frequency+"&servicedueafter="+servicedueafter+"&servicestartdate="+servicestartdate+"&editval="+editval+"&editfillval="+editfillval+"&gridarray="+gridarray,true);
	x.send();
	}
	
</script>
</head>
<body onload="getBranch();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmcontractServiceScheduleUpdate" action="saveContractServiceScheduleUpdate" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClientAccount(event);"/>
	<input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
    <td align="left"><select id="cmbcontracttype" name="cmbcontracttype" value='<s:property value="cmbcontracttype"/>'>
    <option value="ALL">ALL</option><option value="AMC">AMC</option><option value="SJOB">SJOB</option>
    </select></td></tr>
	<tr><td align="right"><label class="branch">Contract</label></td>
	<td align="left"><input type="text" id="txtcontract" name="txtcontract" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtcontract"/>' onkeydown="getContract(event);"/>
	<input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td></tr>
	<tr><td colspan="2"><fieldset><legend><b><label class="branch">Service Scheduler</label></b></legend>
	<table width="100%">
    <tr><td align="right"><label class="branch">Interval</label></td>
	<td align="left"><input type="text" id="srvcinterval" name="srvcinterval" style="width:96%;height:20px;" value='<s:property value="srvcinterval"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Due After</label></td>
	<td align="left"><input type="text" id="serdueafter" name="serdueafter" style="width:96%;height:20px;" value='<s:property value="serdueafter"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Service Start On</label></td>
	<td align="left"><div id="serdate" name="serdate" onchange="servicestartdatechange();" value='<s:property value="serdate" />'></div></td></tr>
	<tr><td align="right"><label class="branch">Frequency</label></td>
	<td align="left"><select name="cmbsrvctype" id="cmbsrvctype" style="width:98%;" value='<s:property value="cmbsrvctype"/>'>
    <option value="1">DAYS</option><option value="2">MONTHS</option><option value="3">YEAR</option>
    </select></td></tr>
	<tr><td align="right"><label class="branch">Start Date</label></td>
	<td align="left"><div id="stdate" name="stdate" value='<s:property value="stdate" />'></div></td></tr>
	<tr><td align="right"><label class="branch">End Date</label></td>
	<td align="left"><div id="enddate" name="enddate" value='<s:property value="enddate" />'></div></td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtcntrval" name="txtcntrval" style="width:96%;height:20px;" value='<s:property value="txtcntrval"/>'/>
	<input type="hidden" id="txtselectedcontract" name="txtselectedcontract" style="width:96%;height:20px;" value='<s:property value="txtselectedcontract"/>'/>
	<input type="hidden" id="txtselectedcontractdtype" name="txtselectedcontractdtype" style="width:96%;height:20px;" value='<s:property value="txtselectedcontractdtype"/>'/>
	<input type="hidden" id="txteditrval" name="txteditrval" style="width:96%;height:20px;" value='<s:property value="txteditrval"/>'/>
	<input type="hidden" id="txteditrfillval" name="txteditrfillval" style="width:96%;height:20px;" value='<s:property value="txteditrfillval"/>'/>
	<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>             
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
    <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/> </td></tr> 
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funServiceScheduleFill();">Fill</button></td></tr>
    </table></fieldset>
	</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnServiceSchedulerUpdate" name="btnServiceSchedulerUpdate" onclick="funServiceSchedulerUpdate();">Update</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="contractServiceScheduleUpdateDiv"><jsp:include page="contractServiceScheduleUpdateGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="serviceScheduleDiv"><jsp:include page="serviceScheduleGrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>

</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>