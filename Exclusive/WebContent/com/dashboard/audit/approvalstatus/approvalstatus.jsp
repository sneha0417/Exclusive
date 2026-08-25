 <jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="javascript" sr="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	// $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    // $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	 document.getElementById("rdsummary").checked=true;
	$('#Approvalwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Approval Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#Approvalwindow').jqxWindow('close');
	// $("#dateDue").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#appdoc_no').dblclick(function(){
	   $('#Approvalwindow').jqxWindow('open');

   approvalSearchContent('documentnosearch.jsp?', $('#Approvalwindow')); 
});
});

function getFormName1() {
	 //alert("passing");
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			//alert("item "+items);
			var Dtype  = items[0].split(",");
			var menu_name = items[1].split(",");
			//alert(menu_name);
			var optionsmenuname = '';
			for (var i = 0; i < menu_name.length; i++) {
				optionsmenuname += '<option value="' + Dtype[i].trim() + '">'
						+ menu_name[i] + '</option>';
			}
			$("select#formname1").html(optionsmenuname);
			/* if ($('#hidcmbbranch').val() != null) {
				$('#cmbbranch').val($('#hidcmbbranch').val());
			} */
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getFormName.jsp", true);
	x.send();
}
function  funcleardata()
{
	
	document.getElementById("appdoc_no").value="";
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 
}
 function funreload(event)
 {
 	
	 var barchval = document.getElementById("cmbbranch").value;
 	var formname = document.getElementById("formname1").value;
 	var docno = document.getElementById("appdoc_no").value;
 	var approvaltype = " ";
 	//alert(formname);
 	 //$("#overlay, #PleaseWait").show();
 	
 	    if(document.getElementById("rdsummary").checked==true){
 	     $("#approvaldatediv").load("appmainGrid.jsp?barchval="+barchval+"&formname="+formname+"&docno="+docno+'&check=1');	    
   	     $("#duedetailsgrid").jqxGrid('clear');
 	
 	}
 	    else if(document.getElementById("rddetailed").checked==true){
 	    $("#approvaldatediv").load("appmainGrid.jsp?barchval="+barchval+"&formname="+formname+"&docno="+docno+'&check=2');
 	    }
 }
 function approvalSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#Approvalwindow').jqxWindow('open');
 		$('#Approvalwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
 function getapprovaldata(event)
 {
 //alert("passing");
	 var x= event.keyCode;
	 if(x==114){
		//alert("yes");
	  $('#Approvalwindow').jqxWindow('open');


	  approvalSearchContent('documentnosearch.jsp?dtype=', $('#Approvalwindow'));     }
	 else{
		 }
	 }

function funExportBtn(){
	JSONToCSVCon(approvalstatusexcel, 'Approval Status', true);
	 }
	 
	 </script>
</head>
<body onload="getFormName1();getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Approval Status</label></b></legend>
	  <table width="100%">
	 <tr> <td align="left"><lebal class="branch">Form_Name</lebal></td>
	 <td align="right"> 
	 <select name="formname1" id="formname1" style="width:100%;"  value='<s:property value="formname1"/>'  >
       </select></td></tr>
	 <tr><td align="left"><label class="branch">Doc_No</label></td>
	  <td align="left"><input type="text" id="appdoc_no" style="height:20px;width:100%;" name="appdoc_no"; placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="appdoc_no"/>' onkeydown="getapprovaldata(event);"/> </td></tr>
	
	<tr>
       <td width="48%" align="center"><input type="radio" id="rdsummary" name="rdo" onchange="radioClick();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
       <td width="52%" align="center"><input type="radio" id="rddetailed" name="rdo" onchange="radioClick();" value="rddetailed"><label for="rddetailed" class="branch">Detailed</label></td>
       </tr>

        <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
     <tr><td colspan="2"></td>
	  </tr>
       </table>
       </fieldset>
       
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
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>

 </table>
 
 
<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
 <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
	 
	    <input type="hidden" name="grgid" id="grgid" style="height:20px;width:70%;" value='<s:property value="grgid"/>' >
 <input type="hidden" name="fleetno" id="fleetno" style="height:20px;width:70%;" value='<s:property value="fleetno"/>' >
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
	<tr>
			  <td><div id="approvaldatediv"><jsp:include page="appmainGrid.jsp"></jsp:include></div><br>
			  </td> 
		</tr>
		
	</table>
	</td>
</tr>
</table>
</div>
<div id="Approvalwindow"><div></div>
</div>
</div>
</body>
</body>
</html>