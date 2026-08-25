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

.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}

</style>
<script type="text/javascript">
    
	var selectedBox = null;
	
	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#cmbchoose').val('4');$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
 		 
	     $("#overlay, #PleaseWait").show();
	});
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getGridColumnCalculation(fromdate,todate,frequencytype,noofdays){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			      var frequencyType=items[0];
		          var difference=items[1];
		          var columns=items[2];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else{
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		     		  $("#analysisDiv").load("accountAnalysisGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&frequencytype='+frequencytype+'&noofdays='+noofdays+'&check='+check);
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate+"&frequencytype="+frequencytype+"&noofdays="+noofdays, true);
		x.send();
   }

	
	function noOfDays(){
		if($('#cmbchoose').val()==1){
			$('#txtnoofdays').attr('readonly', false );$('#txtnoofdays').val('0');			
		}else{
			$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
		}
	}
	
	 function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var frequencytype = $('#cmbchoose').val();
		 var noofdays = $('#txtnoofdays').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
        }
		 
		 getGridColumnCalculation(fromdate,todate,frequencytype,noofdays);
		 
		
		 
		}
	 
	 function  funClearInfo(){
	        $('#cmbbranch').val('a');
			$('#fromdate').val(new Date());
			var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
		    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		     
			$('#todate').val(new Date());
			$('#cmbchoose').val('4');
			$('#txtnoofdays').val('');
			$('#txtnoofdays').attr('readonly', true );
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'AccountAnalysis', true);
		 } else {
			 $("#analysisGrid").jqxTreeGrid('exportData', 'xls');
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
     <tr><td align="right"><label class="branch">Period</label></td>
         <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
     </tr> 
     <tr><td align="right"><label class="branch">To</label></td>
         <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
     </tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><table width="100%">
    <tr>
	  <td align="right"><label class="branch">Type</label></td>
      <td><select id="cmbchoose" name="cmbchoose" style="width:60%;" onchange="noOfDays();" value='<s:property value="cmbchoose"/>'>
      <option value="2">Monthly</option><option value="3">Quarterly</option><option value="4">Yearly</option></select>&nbsp;&nbsp;
      <input type="hidden" id="txtnoofdays" name="txtnoofdays" style="width:50%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnoofdays"/>'/>
      </td>
    </tr>
    </table></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
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
	<table width="100%">
		 <tr>
		    <td><div id="analysisDiv"><jsp:include page="accountAnalysisGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td></tr>
</table>
</div>

</div> 
</body>
</html>