
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

<style>
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
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  
	 $("#cmbbranch").attr('hidden',true); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	  
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		   if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		  	   return false;
		  }   
	 });
	 
});

	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
			 $('#todate').jqxDateTimeInput({ disabled: true});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
			 $('#todate').jqxDateTimeInput({ disabled: false});
		 }
	}
	
	function disable(){	
		$('#followupdate').jqxDateTimeInput({ disabled: true});
	}
	
	function hiddenbrh(){
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
	}
	
	function funcleardata() {
	    $("#executiveGridID").jqxGrid('clear');
	    $("#executiveGridID").jqxGrid('addrow', null, {});
    }
	
	function funreload(event) {
		
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		 if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  } 
		  else {
		
				var fromdate= $("#fromdate").val();
				var todate= $("#todate").val(); 
				var chkfollowup = $('#hidchckfollowup').val();
				var followupdate = $('#followupdate').val();
				var activitystatus = $('#cmbactivitystatus').val();
				var check ="1"; 
			   
				$("#overlay, #PleaseWait").show();
			 
				$("#executiveDiaryDiv").load("executiveDiaryGrid.jsp?check="+check+"&from="+fromdate+"&to="+todate+'&followupdate='+followupdate+'&chkfollowup='+chkfollowup+'&activitystatus='+activitystatus);

	 	  }
		}
	
		function funExportBtn(){
			JSONToCSVCon(leadexceldata, 'ExecutiveDiary', true);
	   }
	 
	  
	 
</script>
</head>
<body onload="getBranch();hiddenbrh();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td></tr>
     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                     
                     
     <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
     <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
	 <tr><td align="right"><label class="branch">Status</label></td>
     <td><select id="cmbactivitystatus" name="cmbactivitystatus" style="width:65%;" value='<s:property value="cmbactivitystatus"/>'>
      <option value="">--Select--</option>
      <option value="1">Submitted</option>
      <option value="0">To be Submitted</option></select></td></tr>
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
	 <tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
	
</td>
<td width="80%">
	<div  id="executiveDiaryDiv"><jsp:include page="executiveDiaryGrid.jsp"></jsp:include></div></td>
	</tr>
	</table>
</div>
</div>
</body>
</html>
