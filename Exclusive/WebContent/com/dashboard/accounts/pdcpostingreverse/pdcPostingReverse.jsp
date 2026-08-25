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

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#txtaccid').dblclick(function(){
		      if($('#cmbtype').val()=='' || $('#cmbtype').val()=='0'){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
		 
		 document.getElementById("rdreceipts").checked=true;$('#btnReverse').attr('disabled', true);
		
	});
	
	function funExportBtn(){
	    /* JSONToCSVCon(data, 'PDCPostingReverse', true); */
	} 
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
		  if($('#cmbtype').val()=='' || $('#cmbtype').val()=='0'){
    		  $.messager.alert('Message','Please Choose Account Type.','warning');
    		  return 0;
    	  }
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	} 
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var check=1;
		 
		 $('#btnReverse').attr('disabled', true);
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdpayments").checked==true){
		 	$("#pdcPostingReverseDiv").load("pdcPostingReverseGrid.jsp?code=FPP&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&atype='+atype+'&accdocno='+accdocno+'&check='+check);
		 } else {
			 $("#pdcPostingReverseDiv").load("pdcPostingReverseGrid.jsp?code=FRO&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&atype='+atype+'&accdocno='+accdocno+'&check='+check);
		 }
		 
		}
	
	function funNotify(event){
		var trno = $('#txttrno').val();
		var postedtrno = $('#txtpostedtrno').val();
		
		if(trno==''){
			 $.messager.alert('Message','Select item to be reversed.','warning');
			 return 0;
		 }

		 if(postedtrno==''){
			 $.messager.alert('Message','Select item to be reversed.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to Reverse?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(trno,postedtrno);	
		     	}
		});
	}
	
	function saveGridData(trno,postedtrno){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
			var items=x.responseText.trim();
			var val = items[0];
			
				 if(parseInt(val)>0) {
					var trno = $('#txttrno').val('');
					var postedtrno = $('#txtpostedtrno').val('');
					
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
					funreload(event);
					$('#btnReverse').attr('disabled', true);
				 } else {
					 $.messager.alert('Message', '  Failed ', function(r){
					  });
				 }
				}
		}
			
	x.open("GET","saveData.jsp?trno="+trno+"&postedtrno="+postedtrno,true);
	x.send();
			
	}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
    <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr> 
    <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdpayments" name="rdo" value="rdpayments"><label for="rdpayments" class="branch">Payments</label></td>
       <td width="52%" align="center"><input type="radio" id="rdreceipts" name="rdo" value="rdreceipts"><label for="rdreceipts" class="branch">Receipts</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="0">--Select--</option><option value="BANK">Bank</option><option value="AP">AP</option><option value="AR">AR</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnReverse" name="btnReverse" onclick="funNotify();">Reverse</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" id="txttrno" name="txttrno" style="width:50%;height:20px;" value='<s:property value="txttrno"/>'/>
	<input type="hidden" id="txtpostedtrno" name="txtpostedtrno" style="width:50%;height:20px;" value='<s:property value="txtpostedtrno"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="pdcPostingReverseDiv"><jsp:include page="pdcPostingReverseGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>