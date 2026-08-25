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
    
	$(document).ready(function () {
		 
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdsummary").checked=true;
	});
	
	 function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var accounttype = $('#cmbtype').val();
		 
		 if($('#cmbtype').val()==''){
    		 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
    	 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdsummary").checked==true){
			 var check=1;
			 $("#summaryDiv").load("summaryAccountStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accounttype='+accounttype+'&reporttype=1'+'&check='+check);
		 } else if(document.getElementById("rddetailed").checked==true){
			 var check=1;
			 $("#detailedDiv").load("detailedAccountStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accounttype='+accounttype+'&reporttype=2'+'&check='+check);
		 }
		}
	
	 function summaryHide(){
			if(document.getElementById("rdsummary").checked==true){
				$('#detailedDiv').hide();$('#summaryDiv').show();
				$("#detailedAccountsStatementGrid").jqxGrid('clear');
			}else if(document.getElementById("rddetailed").checked==true){
				$('#summaryDiv').hide();$('#detailedDiv').show();
				$("#summaryAccountStatementGrid").jqxTreeGrid('clear');
			}
	 }
	 
	 function funExportBtn(){
		 if(document.getElementById("rdsummary").checked==true){
			 $("#summaryAccountStatementGrid").jqxTreeGrid('exportData', 'xls');
    	} else if(document.getElementById("rddetailed").checked==true){
    		$("#detailedAccountsStatementGrid").jqxGrid('exportdata', 'xls', 'DetailedAccountStatement');	
    		//JSONToCSVConvertor(dataExcelExport, 'DetailedAccountStatement', true);
    	}
	}
	
		function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
			
		    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		    
		    var CSV = '';    
		    
		    CSV += ReportTitle + '\r\n\n';

		    //This condition will generate the Label/Header
		    if (ShowLabel) {
		        var row = "";
		        
		        //This loop will extract the label from 1st index of on array
		        for (var index in arrData[0]) {
		            
		            //Now convert each value to string and comma-seprated
		            row += index + ',';
		        }

		        row = row.slice(0, -1);
		        
		        //append Label row with line break
		        CSV += row + '\r\n';
		    }
		    
		    //1st loop is to extract each row
		    for (var i = 0; i < arrData.length; i++) {
		        var row = "";
		        
		        //2nd loop will extract each column and convert it in string comma-seprated
		        for (var index in arrData[i]) {
		            row += '"' + arrData[i][index] + '",';
		        }

		        row.slice(0, row.length - 1);
		        
		        //add a line break after each row
		        CSV += row + '\r\n';
		    }

		    if (CSV == '') {        
		        alert("Invalid data");
		        return;
		    }   
		    
		    //Generate a file name
		    var fileName = "";
		    //this will remove the blank-spaces from the title and replace it with an underscore
		    fileName += ReportTitle.replace(/ /g,"_");   
		    
		    //Initialize file format you want csv or xls
		    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		    
		    // Now the little tricky part.
		    // you can use either>> window.open(uri);
		    // but this will not work in some browsers
		    // or you will not get the correct file extension    
		    
		    //this trick will generate a temp <a /> tag
		    var link = document.createElement("a");    
		    link.href = uri;
		    
		    //set the visibility hidden so it will not effect on your web-layout
		    link.style = "visibility:hidden";
		    link.download = fileName + ".csv";
		    
		    //this part will append the anchor tag and remove it after automatic click
		    document.body.appendChild(link);
		    link.click();
		    document.body.removeChild(link);
		}

	 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
  <tr>
    <td width="20%">
	<fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	<tr><td colspan="2">&nbsp;</td></tr>	
	<tr><td align="right"><label class="branch">Period</label></td>
	    <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
	</tr>
	<tr><td  align="right"><label class="branch">To</label></td>
		 <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="AP">AP</option><option value="AR" selected>AR</option><option value="GL">GL</option>
    <option value="HR">HR</option></select></td></tr>
    
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	  <table width="100%">
      <tr>
      <td width="50%" align="left"><input type="radio" id="rdsummary" name="rdo" onclick="summaryHide();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
      <td width="50%" align="center"><input type="radio" id="rddetailed" name="rdo" onclick="summaryHide();" value="rddetailed"><label for="rddetailed" class="branch">Detailed</label></td>
      </tr>
      </table></fieldset>
    </td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table></fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="summaryDiv"><jsp:include page="summaryAccountStatementGrid.jsp"></jsp:include></div>
		    <div id="detailedDiv" hidden="true"><jsp:include page="detailedAccountStatementGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td></tr>
</table>
</div>

</div> 
</body>
</html>