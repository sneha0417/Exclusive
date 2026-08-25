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

.bounce {
	color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -webkit-transform: translateX(0);
    transform: translateX(0);
  }
  40% {
    -moz-transform: translateX(-30px);
    -ms-transform: translateX(-30px);
    -webkit-transform: translateX(-30px);
    transform: translateX(-30px);
  }
  60% {
    -moz-transform: translateX(-15px);
    -ms-transform: translateX(-15px);
    -webkit-transform: translateX(-15px);
    transform: translateX(-15px);
  }
} 

@media (min-width: 15px) {
  .mega {
    font-size: 15px;
    line-height: 1;
  }
}

@font-face {
  font-family: 'Roboto',comic sans ms,Tahoma;
  font-style: normal;
  font-weight: 100;
  unicode-range: U+0460-052F, U+20B4, U+2DE0-2DFF, U+A640-A69F;
}
  
@-webkit-keyframes hue {
  from {
    -webkit-filter: hue-rotate(0deg);
  }

  to {
    -webkit-filter: hue-rotate(-360deg);
  }
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM.yyyy"});
		 $("#postingDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#uptodate').focusout(function(){
			 getLastPayrollPostedDate();
		 });
		 
		 getLastPayrollPostedDate();
	});
	
	function getLastPayrollPostedDate(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  				 
  			     $('#uptodate').val(items[0]);
  			     document.getElementById("lbllastposted").innerText=items[1].trim();
  			}
		}
		x.open("GET", "getLastPayrollPostedDate.jsp", true);
		x.send();
	}
	
	function  funClearData(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');
		$('#txtselectedemployees').val('');disable();$('#txtdrtotal').val('');$('#txtcrtotal').val('');
		$("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollTotalGridID").jqxGrid('clear');
		$("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		$("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});getLastPayrollPostedDate();
		document.getElementById("gridlength").value="";document.getElementById("mode").value="";document.getElementById("msg").value="";
	 }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 
		 if(uptodate==''){
			 $.messager.alert('Message','Save Payroll and Post.','warning');
			 return;
		 }
		 
		 var check = 1;
		 $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		 $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});$('#txtdrtotal').val('');$('#txtcrtotal').val('');
		 $('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');document.getElementById("gridlength").value="";
		 document.getElementById("mode").value="";document.getElementById("msg").value="";$('#txtselectedemployees').val('');$('#btnpost').attr("disabled",true);$('#postingDate').jqxDateTimeInput({ disabled: true});
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#monthlypayrollTotalDiv").load("monthlyPayrollTotalGrid.jsp?branchval="+branchval+'&uptodate=01.'+uptodate+'&check='+check);
		 
	}

	function disable(){
		 $('#postingDate').jqxDateTimeInput({ disabled: true});
		 $('#txtremarks').attr("readonly",true);
		 $('#btnpost').attr("disabled",true);
		 $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		 $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
	}
	
	function funCalculate(){
		
		var rows = $('#monthlyPayrollPostingGridID').jqxGrid('getrows');
    	if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
			$.messager.alert('Message','Select Payroll to be Posted & Calculate.','warning');
			return 0;
		} 
		
		var rows = $('#payrollPostingJVGridID').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#payrollPostingJVGridID").jqxGrid('clear');
			$('#txtselectedemployees').val('');
		} 
		
		$("#overlay, #PleaseWait").show();
		
		var rows = $("#monthlyPayrollPostingGridID").jqxGrid('getrows');
		
		if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
			return false;
		}
		
		var selectedrows=$("#monthlyPayrollPostingGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var i=0;var tempempdocnos="",tempempcatids="";
        $('#gridlength').val(selectedrows.length);
        var j=0; var k=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==1){
						tempempdocnos=tempempdocnos+","+rows[i].employeedocno;
						tempempcatids=tempempcatids+","+rows[i].empcatid;
					} else {
						tempempdocnos=rows[i].employeedocno;
						tempempcatids=rows[i].empcatid;
						k=1;
					}
				j++; 
			  }
            }
	    
	    $('#txtselectedemployees').val(tempempdocnos);
	    $('#txtcategoryids').val(tempempcatids);
	    var checked = 1;
	    
	    $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: false});
	    $('#postingDate').jqxDateTimeInput({ disabled: false});$('#txtremarks').attr("readonly",false);$('#btnpost').attr("disabled",false);
	    $("#JVTDiv").load("monthlyJVGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate=01.'+$('#uptodate').val()+'&category='+$('#txtcategoryids').val()+'&employees='+$('#txtselectedemployees').val()+'&postdate='+$('#postingDate').val()+'&checked='+checked);
		
	}
	
	function funPost(event){
		funNotify();
	}
	
	function funNotify() {	
    	
  	     /* if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 } */
 		  
		   $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
	 		if (r){
	 				
	    	/* Journal Voucher Grid Saving */
	    	 var rows = $("#payrollPostingJVGridID").jqxGrid('getrows');
	    	 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].docno;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
				    .attr("hidden", "true");
					length=length+1;
					
				var amount,baseamount,id;
				if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
					 amount=rows[i].credit*-1;
					 baseamount=rows[i].baseamount*-1;
					 id=-1;
				}
				
				if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
					 amount=rows[i].debit;
					 baseamount=rows[i].baseamount;
					 id=1;
				}
				
				newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+baseamount+"::"+amount+":: 0::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
				
				newTextBox.appendTo('form');
				}
			 }
			 $('#gridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardMonthlyPayrollPosting").submit();
			 
	 		 }
	 		});
		 
  		return 1;
	} 
	
	function setValues(){
		
		  if($('#hiduptodate').val()){
			 $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
		  }

	      if($('#hidpostingDate').val()){
			 $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
		  }
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 getLastPayrollPostedDate();funreload(event);disable(); 
		 }
	}
	
</script>
</head>
<body onload="getBranch();disable();setValues();">
<form id="frmDashboardMonthlyPayrollPosting" action="saveDashboardMonthlyPayrollPosting" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
     <input type="hidden" id="hiduptodate" name="hiduptodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiduptodate"/>'/></td></tr>
	 <tr><td colspan="2"><p class="bounce" style="text-align: center;"><b><label id="lbllastposted"  name="lbllastposted"><s:property value="lbllastposted"/></label></b></p></td></tr>
	 <tr><td colspan="2"><div id="monthlypayrollTotalDiv"><jsp:include page="monthlyPayrollTotalGrid.jsp"></jsp:include></div></td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Posting</label></td>
     <td align="left"><div id="postingDate" name="postingDate" value='<s:property value="postingDate"/>'></div>
     <input type="hidden" id="hidpostingDate" name="hidpostingDate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidpostingDate"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" placeholder="Remarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	 <button class="myButton" type="button" id="btnpost" name="btnpost" onclick="funPost(event);">Post</button></td></tr>
	 <tr><td colspan="2"><input type="hidden" id="txtselectedemployees" name="txtselectedemployees" style="width:100%;height:20px;" value='<s:property value="txtselectedemployees"/>'/>
	 <input type="hidden" id="txtcategoryids" name="txtcategoryids" style="width:100%;height:20px;" value='<s:property value="txtcategoryids"/>'/>
	 <input type="hidden" id="txtdrtotal" name="txtdrtotal" style="width:50%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="txtdrtotal"/>'/>
	 <input type="hidden" id="txtcrtotal" name="txtcrtotal" style="width:50%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
	 <input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
	 <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'></td></tr>
  </table>
</fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="monthlyPayrollPostingDiv"><jsp:include page="monthlyPayrollPostingGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="JVTDiv"><jsp:include page="monthlyJVGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>
</div>
</div>
</form>
</body>
