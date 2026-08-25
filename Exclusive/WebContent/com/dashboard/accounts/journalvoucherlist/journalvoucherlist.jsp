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

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
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
	
    });      
     
function funreload(event){   
	 var branchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var jvtype = $('#cmbprocess').val();     
		 var check=1;
	 $("#overlay, #PleaseWait").show();
	 var dtype=document.getElementById("cmbchoose").value;
	 $("#jvlistDiv").load("jvListGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check='+check+'&dtype='+dtype+'&jvtype='+jvtype);
	}      
	
	function funExportBtn(){
	  	JSONToCSVCon(dataExcelExport, 'Journal Voucher List', true);   
}
	
	   function funPrint(){
			var selectedrows=$("#jqxJournalVoucher").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length>100){
				$.messager.alert('Message','Selected documents not more than 100...!!!','warning');	
			}else{
					var i=0;var temptrno="0",tempdocno="0";
				    var j=0;
				    for (i = 0; i < selectedrows.length; i++) {
								var srvdetmdocno= $('#jqxJournalVoucher').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
										tempdocno=tempdocno+","+srvdetmdocno;
										var srvdetmtrno= $('#jqxJournalVoucher').jqxGrid('getcellvalue', selectedrows[i], "tr_no");
										temptrno=temptrno+","+srvdetmtrno;
				         
				    }  
				    $('#srvdetmdocno').val(tempdocno); 
				    $('#srvdetmtrno').val(temptrno);
				        var url=document.URL;
				        var reurl=url.split("journalvoucherlist.jsp");
				        var win= window.open(reurl[0]+"printjournalvoucherlist?docno="+$('#srvdetmdocno').val()+"&trno="+$('#srvdetmtrno').val()+"&branch="+document.getElementById("cmbbranch").value+"&dtype="+document.getElementById("cmbchoose").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        win.focus();
			}	        
		}                          
	    function getJVType() {     
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
					$("select#cmbprocess").html(optionsbranch);
					
				} else {}
			}
			x.open("GET","getjvtypes.jsp", true);
			x.send();
		}  
	  
</script>                               
</head>
<body onload="getBranch();getJVType();">
<form id="frmJVList" action="saveJVList" method="post">   
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >    
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
    <td align="left"><div id="fromdate" name="fromdate"  value='<s:property value="fromdate"/>'></div>
    <input type="hidden" id="hidfromdate" name="hidfromdate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidfromdate"/>'/></td></tr> 
    <tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate"  value='<s:property value="todate"/>'></div>
    <input type="hidden" id="hidtodate" name="hidtodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidtodate"/>'/></td></tr> 
  <tr><td align="right"><label class="branch">Type</label></td>
      <td colspan="2"><select id="cmbchoose" name="cmbchoose" style="width:60%;" value='<s:property value="cmbchoose"/>'>
      <option value="JVT">JVT</option><option value="IJV">IJV</option></select>&nbsp;&nbsp;
      <input type="hidden" id="hidcmbtype" name="hidcmbtype" style="width:50%;height:20px;" value='<s:property value="hidcmbtype"/>'/>
      </td>
    </tr>
     <tr><td align="right"> <label class="branch">JV Type</label></td>
			<td colspan="2"><select name="cmbprocess" id="cmbprocess" style="width:60%; value='<s:property value="cmbprocess"/>'"></select> 
			 <input type="hidden" id="hidcmbprocess" name="hidcmbprocess" value='<s:property value="hidcmbprocess"/>'/></td>   
    </tr>   
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr> <td colspan="2" align="center"><input type="button" name="btnprint" id="btnprint" class="myButtons" value="print" style="width: 80px;" onclick="funPrint();"/>
      <input type="hidden" id="srvdetmtrno" name="srvdetmtrno" style="width:50%;height:20px;" value='<s:property value="srvdetmtrno"/>'/>
    <input type="hidden" id="srvdetmdocno" name="srvdetmdocno" style="width:50%;height:20px;" value='<s:property value="srvdetmdocno"/>'/></td></tr>
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
		    <td><div id="jvlistDiv"><jsp:include page="jvListGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</tr>
</table>
</div>
</div>
</form> 
</body>
</html>