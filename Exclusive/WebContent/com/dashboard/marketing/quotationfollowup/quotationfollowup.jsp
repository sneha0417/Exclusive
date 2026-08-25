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
		
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		  $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		  $('#Salesagentinfowindow').jqxWindow('close');
		     
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
		 
		 $('#txtsalman').dblclick(function(){
			  $('#Salesagentinfowindow').jqxWindow('open');
		      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
			  });

	});
	
	
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
	
	
  
	
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
	
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid("addrow", null, {}); 
		 $("#amcfollowupGrid").jqxGrid({ disabled: true});
	}
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	
	function funreload(event){
		disable();
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var salid = document.getElementById("salid").value;
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#quotationfollowupDiv").load("quotationfollowupGrid.jsp?branchval="+branchval+"&froms="+fromdate+"&tos="+todate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salid='+salid);
		}
	
	function funUpdate(event){
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0];
		var proname=pro[1];
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var rdtype = $('#conttype').val();
		
		if(bibid==''){
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
		     		saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks);	
		     	}
		});
	}
	
	
		
   
	    
	function saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")
				{	
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#enqstat').val('');
				$('#info').val('');
				$('#conttype').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ');
			//	funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
		
	x.open("GET","saveData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks,true);
	x.send();
			
	}
	
	function funtxtenable()
	{
		
	}
	
	
	
	function funExportBtn(){
		
	   
		JSONToCSVCon(qotfollowupexcel, 'Quotation Followup', true);
		JSONToCSVCon(latestqotfollowupexcel, 'Quotation Followup With Remarks', true);
		   }
	
	 function getsalesAgent(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#Salesagentinfowindow').jqxWindow('open');
     
       
      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
     	 else{
     		 }
     	 }

  function salesagentSearchContent(url) {
               //alert(url);
                 $.get(url).done(function (data) {
        //alert(data);
	           $('#Salesagentinfowindow').jqxWindow('setContent', data);

       	}); 
   }
  
  function funsalClear(){
	   
		$("#jqxloaddataGrid").jqxGrid('clear'); 
		$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
	   document.getElementById("txtsalman").value="";
	   document.getElementById("salid").value="0";
	   $("#txtsalman").attr("placeholder", "press F3 for Search");
 }

	
</script>
</head>
<body onload="getBranch();getProcess();disable();followupcheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2"></td></tr>
	  <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
       </td></tr>
        <tr>
	      <td align="right"><label class="branch">Sales Man</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsalman" id="txtsalman" value='<s:property value="txtsalman"/>' onKeyDown=" getsalesAgent(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="salid" name="salid" value='<s:property value="salid"/>'>
       <button type="button" class="bicon" id="clear" title="clear" onclick="funsalClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button>
      </td>
	      </tr>
        <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
    <tr><td colspan="2"></td></tr>
    
    	<tr><td colspan="2" align="center"><textarea id="info" style="height:50px;width:200px;font-family:Tahoma;font-size:12px;resize:none" name="info"  readonly="readonly"  ><s:property value="info" ></s:property></textarea></td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess" onChange="funtxtenable();"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtenqstat" name="txtenqstat" style="width:100%;height:20px;" value='<s:property value="txtenqstat"/>'/>
      <input type="hidden" id="conttype" name="conttype"  value='<s:property value="conttype"/>'/></td></tr>
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="quotationfollowupDiv"><jsp:include page="quotationfollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="Salesagentinfowindow">
   <div ></div>
   </div>
</div> 
</body>
</html>