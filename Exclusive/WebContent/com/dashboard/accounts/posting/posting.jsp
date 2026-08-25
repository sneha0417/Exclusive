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
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '20%', height: '58%',  maxHeight: '60%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
		  
		  $('#txtibbranch').dblclick(function(){
			  branchSearchContent('branchSearchGrid.jsp?check=1');
			  });
			  
	     document.getElementById("hidchckibbranch").value=0;
	     
	     $("#postingJV").jqxGrid({ disabled: true});$("#cardCommGrid").jqxGrid('clear');$("#cardCommGrid").jqxGrid({ disabled: true});
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
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function branchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  			
  			    $('#txttypedocno').val(docNoItems);	
  			    $('#txttypeaccid').val(accountIdItems);
  			    $('#txttypeaccname').val(accountItems);
  			  	$('#txttypeatype').val(accountTypeItems);
			    $('#txttypecurid').val(accountCurIdItems);
			    $('#txttyperate').val(accountRateItems);
			    $('#txttypetype').val(accCurrTypeItems);
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
 }
	
	function getCommissionAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
				var accCosttypeItems = items[7];
  				var accCostcodeItems = items[8];
  			
  			    $('#txtcommdocno').val(docNoItems);	
  			    $('#txtcommaccid').val(accountIdItems);
  			    $('#txtcommaccname').val(accountItems);
  			  	$('#txtcommatype').val(accountTypeItems);
			    $('#txtcommcurid').val(accountCurIdItems);
			    $('#txtcommrate').val(accountRateItems);
			    $('#txtcommtype').val(accCurrTypeItems);
				$('#txtcommcosttype').val(accCosttypeItems);
			    $('#txtcommcostcode').val(accCostcodeItems);
  		}
  		}
  		x.open("GET", "getCommissionAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
    }
	
	function getTaxAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
				var accCosttypeItems = items[7];
  				var accCostcodeItems = items[8];
  				var taxPerItems = items[9];
  			
  			    $('#txttaxaccdocno').val(docNoItems);	
  			    $('#txttaxaccid').val(accountIdItems);
  			    $('#txttaxaccname').val(accountItems);
  			  	$('#txttaxaccatype').val(accountTypeItems);
			    $('#txttaxacccurid').val(accountCurIdItems);
			    $('#txttaxaccrate').val(accountRateItems);
			    $('#txttaxacccurtype').val(accCurrTypeItems);
				$('#txttaxacccosttype').val(accCosttypeItems);
			    $('#txttaxacccostcode').val(accCostcodeItems);
			    $('#txttaxpercentage').val(taxPerItems);
			    
  		}
  		}
  		x.open("GET", "getTaxAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
    }
	
	function getCardCommSeparate(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtbipostingcardcomm').val(items);
  		}
  		}
  		x.open("GET", "getCommSeparateAllowed.jsp", true);
  		x.send();
    }
	
	function getNonTaxableEntity(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('#txtnontaxableentity').val(items);
	  				
	  				if(parseInt($('#txtnontaxableentity').val().trim())==1){
	  				 	getTaxAccounts($('#cmbtype').val(),$('#date').val());
	  				}
	  		}
	  		}
	  		x.open("GET", "getNonTaxableEntity.jsp", true);
	  		x.send();
	 }
	  
	function fromdatechange(){
	    var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
    function todatechange(){
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
    function datechange(){
    	
    	if(parseInt($('#txtnontaxableentity').val().trim())==1){
    		getTaxAccounts($('#cmbtype').val(),$('#date').val());
    	}
    	
	    var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		 if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function getIbBranch(event){
        var x= event.keyCode;
        if(x==114){
        	branchSearchContent('branchSearchGrid.jsp?check=1');
        }
        else{
         }
        }
	
	function ibbranchcheck(){
		 if(document.getElementById("chckibbranch").checked){
			 document.getElementById("hidchckibbranch").value = 1;
			 $('#txtibbranch').attr('disabled', false );
		 }
		 else{
			 document.getElementById("hidchckibbranch").value = 0;
			 $('#txtibbranchid').val('');$('#txtibbranch').val('');
			 $('#txtibbranch').attr('disabled', true );
			 
			 if (document.getElementById("txtibbranch").value == "") {
			        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
			  }
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
		 var paytype = $('#cmbtype').val();
		 var check = 1;
		 
		 if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
		 
		 if(paytype==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		 
		 if(fromdate==''){
			 $.messager.alert('Message','Please Enter From Date.','warning');
			 return 0;
		 }
		 
		 if(todate==''){
			 $.messager.alert('Message','Please Enter To Date.','warning');
			 return 0;
		 }
		 
	    var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(paytype==2){
	       	 $("#postingCardDiv").load("postingCardGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else if(paytype==3){
			 $("#postingChequeDiv").load("postingChequeGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else if(paytype==4){
			 $("#postingRefundDiv").load("postingRefundGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else{
			 $("#postingCashDiv").load("postingCashGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }
		 
		 $("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		 $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
		 
		}
	
	function funCalculate(){
		
		if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
		
		var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
		
		ibvalid=document.getElementById("txtibvalidation").value;
		 if(ibvalid==1){
			 $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning');
			 return 0;
		 }
		 
		if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		
		if($('#cmbtype').val()=='3'){
			var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
			if(selectedrows.length>1){
				$.messager.alert('Message','Only One Cheque can be Posted at a Time.','warning');
				return 0;
		   }
		}
		
		if($('#txtdocno').val()==''){
			 $.messager.alert('Message','Please Choose Bank Account & Then Calculate.','warning');
			 return 0;
		 }
		
		var rows = $('#postingJV').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#postingJV").jqxGrid('clear');
			$('#txtselecteddocs').val('');$('#txtselectedrno').val('');
		} 
		
		var temp1="",tempdocs1="",temprno1="";
		
		if($('#cmbtype').val()=='1'){
			
			$("#overlay, #PleaseWait").show();
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#postingCashGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
				return false;
			}
			
			var selectedrows=$("#postingCashGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="",tempdocs="",temprno="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						if(i==0){
							temp=rows[i].tr_no;
							tempdocs=rows[i].documentno;
							temprno=rows[i].srno;
						}
						else{
							temp=temp+"::"+rows[i].tr_no;
							tempdocs=tempdocs+","+rows[i].documentno;
							temprno=temprno+","+rows[i].srno;
						}
						temp1=temp+"::";
						tempdocs1=tempdocs+",";
						temprno1=temprno+",";
						
						$("#postingCashGrid").jqxGrid('setcellvalue', i, "totalamount", $('#postingCashGrid').jqxGrid('getcellvalue', i, "netamt"));
						
					j++; 
				  }
	            }
		    $('#txtselecteddocs').val(tempdocs1);
		    $('#txtselectedrno').val(temprno1);
		    $("#postingJV").jqxGrid('setcellvalue', 0, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CASH POSTING on "+$('#date').val()+"");
		    $("#postingJV").jqxGrid('setcellvalue', 1, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CASH POSTING on "+$('#date').val()+"");
		  }
		
		if($('#cmbtype').val()=='2'){
		getCardCommSeparate();
		
		$("#overlay, #PleaseWait").show();
		
		var rows = $('#postingJV').jqxGrid('getrows');
    	var rowlength= rows.length;
    	if(rowlength==0){
    		if($('#txtbipostingcardcomm').val().trim()=="0"){
				$("#postingJV").jqxGrid('addrow', null, {});
  	    		$("#postingJV").jqxGrid('addrow', null, {});
  	    		$("#postingJV").jqxGrid('addrow', null, {});
    		}else{
    			$("#postingJV").jqxGrid('addrow', null, {});
    			$("#postingJV").jqxGrid('addrow', null, {});
    		}
    	}
		$("#postingJV").jqxGrid({ disabled: false});
			
		var rows = $("#postingCardGrid").jqxGrid('getrows');
		var paytype = $('#cmbtype').val();
		
		if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
			return false;
		}
		
		var selectedrows=$("#postingCardGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Cards to be Calculated.');
			return false;
		}
		
		var comm="",q=0;
		var cardtyperows = $("#cardCommGrid").jqxGrid('getrows');
		for (var c = 0; c < rows.length; c++) {
			if(selectedrows[q]==c){
				
			 for (var f = 0; f < cardtyperows.length; f++) {
				 if(rows[c].cardtype==cardtyperows[f].mode){
					comm= cardtyperows[f].commission;
					break;
				 }
			 }
			 
			 $("#postingCardGrid").jqxGrid('setcellvalue', c, "cardtypecomm", comm);
			 q++;
			}
		 }
		
		var i=0;var temp="",tempdocs="",temprno="";
        $('#gridlength').val(selectedrows.length);
        var j=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					cardCommission(rows[i].cardtype,rows[i].netamt,paytype,rows[i].cardtypecomm,i,selectedrows.length);
					if(i==0){
						temp=rows[i].tr_no;
						tempdocs=rows[i].documentno;
						temprno=rows[i].srno;
					}
					else{
						temp=temp+"::"+rows[i].tr_no;
						tempdocs=tempdocs+","+rows[i].documentno;
						temprno=temprno+","+rows[i].srno;
					}
					temp1=temp+"::";
					tempdocs1=tempdocs+",";
					temprno1=temprno+",";
				j++; 
			  }
            }
		  }
		
			if($('#cmbtype').val()=='3'){
			
			$("#overlay, #PleaseWait").show();
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#postingChequeGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
				return false;
			}
			
			var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="",tempdocs="",temprno="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						if(i==0){
							temp=rows[i].tr_no;
							tempdocs=rows[i].documentno;
							temprno=rows[i].srno;
						}
						else{
							temp=temp+"::"+rows[i].tr_no;
							tempdocs=tempdocs+","+rows[i].documentno;
							temprno=temprno+","+rows[i].srno;
						}
						temp1=temp+"::";
						tempdocs1=tempdocs+",";
						temprno1=temprno+",";
						
						$("#postingChequeGrid").jqxGrid('setcellvalue', i, "totalamount", $('#postingChequeGrid').jqxGrid('getcellvalue', i, "netamt"));
						
					j++; 
				  }
	            }
		    $('#txtselecteddocs').val(tempdocs1);
		    $('#txtselectedrno').val(temprno1);
		    $("#postingJV").jqxGrid('setcellvalue', 0, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CHEQUE POSTING on "+$('#date').val()+"");
		    $("#postingJV").jqxGrid('setcellvalue', 1, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CHEQUE POSTING on "+$('#date').val()+"");
		  }
			
			 if($('#cmbtype').val()=='4'){
				getCardCommSeparate();
				 
				$("#overlay, #PleaseWait").show();
				
				var rows = $('#postingJV').jqxGrid('getrows');
		    	var rowlength= rows.length;
		    	if(rowlength==0){
		    		if($('#txtbipostingcardcomm').val().trim()=="0"){
						$("#postingJV").jqxGrid('addrow', null, {});
		  	    		$("#postingJV").jqxGrid('addrow', null, {});
		  	    		$("#postingJV").jqxGrid('addrow', null, {});
		    		}else{
		    			$("#postingJV").jqxGrid('addrow', null, {});
		    			$("#postingJV").jqxGrid('addrow', null, {});
		    		}
		    	}
				$("#postingJV").jqxGrid({ disabled: false});
					
				var rows = $("#postingRefundGrid").jqxGrid('getrows');
				var paytype = $('#cmbtype').val();
				
				if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
					return false;
				}
				
				var selectedrows=$("#postingRefundGrid").jqxGrid('selectedrowindexes');
				selectedrows = selectedrows.sort(function(a,b){return a - b});
				
				if(selectedrows.length==0){
					$("#overlay, #PleaseWait").hide();
					$.messager.alert('Warning','Select Cards to be Calculated.');
					return false;
				}
				
				var comm="",q=0;
				var cardtyperows = $("#cardCommGrid").jqxGrid('getrows');
				for (var c = 0; c < rows.length; c++) {
					if(selectedrows[q]==c){
						
					 for (var f = 0; f < cardtyperows.length; f++) {
						 if(rows[c].cardtype==cardtyperows[f].mode){
							comm= cardtyperows[f].commission;
							break;
						 }
					 }
					 
					 $("#postingRefundGrid").jqxGrid('setcellvalue', c, "cardtypecomm", comm);
					 q++;
					}
				 }
				
				var i=0;var temp="",tempdocs="",temprno="";
		        $('#gridlength').val(selectedrows.length);
		        var j=0;
			    for (i = 0; i < rows.length; i++) {
						if(selectedrows[j]==i){
							cardCommission(rows[i].cardtype,rows[i].netamt,paytype,rows[i].cardtypecomm,i,selectedrows.length);
							if(i==0){
								temp=rows[i].tr_no;
								tempdocs=rows[i].documentno;
								temprno=rows[i].srno;
							}
							else{
								temp=temp+"::"+rows[i].tr_no;
								tempdocs=tempdocs+","+rows[i].documentno;
								temprno=temprno+","+rows[i].srno;
							}
							temp1=temp+"::";
							tempdocs1=tempdocs+",";
							temprno1=temprno+",";
						j++; 
					  }
		            }
				  }
		
	      $('#txttrno').val(temp1);
	      $('#txtselecteddocs').val(tempdocs1);
	      $('#txtselectedrno').val(temprno1);
	      $("#overlay, #PleaseWait").hide();
		  $('#postingCashGrid').jqxGrid({ sortable: true});
		  $('#postingCardGrid').jqxGrid({ sortable: true});
		  $('#postingChequeGrid').jqxGrid({ sortable: true});
		  $('#postingRefundGrid').jqxGrid({ sortable: true});
			
		}
	
		function cardCommission(cardtype,netamt,paytype,comm,i,length){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 items= x.responseText;
					 items=items.split(":");
					 
					 var amount=items[0];
					 var commission=items[1];
					 var index=items[2];
					 var paytype=items[3];
					 
					 if(paytype==2){
					  		$("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
					  		$("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					 }else if(paytype==4){
						  	$("#postingRefundGrid").jqxGrid('setcellvalue', index, "commission", commission);
						  	$("#postingRefundGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					}
					 
					}
				else
					{
					}
			}
			x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&comm="+comm+"&index="+i,true);
			x.send();
		}

	
      function funClearInfo(){

    	 $('#cmbbranch').val('a');
    	 $('#fromdate').val(new Date());
    	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $('#date').val(new Date());
		 
		 document.getElementById("hidchckibbranch").value = 0;
		 if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
		 $('#txtibbranchid').val('');$('#txtibbranch').val('');
		 $('#txtibbranch').attr('disabled', true );
		 
		document.getElementById("hidfromdate").value="";document.getElementById("hidtodate").value="";document.getElementById("cmbtype").value="";
		document.getElementById("hidcmbtype").value="";document.getElementById("txttypedocno").value="";document.getElementById("txttypeaccid").value="";
		document.getElementById("txttypeaccname").value="";document.getElementById("txttypeatype").value="";document.getElementById("txttypecurid").value="";
		document.getElementById("txttyperate").value="";document.getElementById("txttypetype").value="";document.getElementById("txtaccid").value="";
		document.getElementById("txtaccname").value="";document.getElementById("txtdocno").value="";document.getElementById("txtatype").value="";
		document.getElementById("txtcurid").value="";document.getElementById("txtrate").value="";document.getElementById("txtcurtype").value="";
		document.getElementById("txtcommaccid").value="";document.getElementById("txtcommaccname").value="";document.getElementById("txtcommdocno").value="";
		document.getElementById("txtcommatype").value="";document.getElementById("txtcommcurid").value="";document.getElementById("txtcommrate").value="";
		document.getElementById("txtcommtype").value="";document.getElementById("txtcommcosttype").value="";document.getElementById("txtcommcostcode").value="";
		document.getElementById("txtdrtotal").value="";document.getElementById("txtcrtotal").value="";
		document.getElementById("txttrno").value="";document.getElementById("gridlength").value="";document.getElementById("jvgridlength").value="";
		document.getElementById("jvgridlength").value="";document.getElementById("mode").value="";document.getElementById("msg").value="";
		
		$("#cardCommGrid").jqxGrid('clear');$("#cardCommGrid").jqxGrid({ disabled: true});
		$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		$("#postingCashGrid").jqxGrid('clear');$("#postingCashGrid").jqxGrid('addrow', null, {});$("#postingCashGrid").jqxGrid('clearselection');
		$("#postingCardGrid").jqxGrid('clear');$("#postingCardGrid").jqxGrid('addrow', null, {});$("#postingCardGrid").jqxGrid('clearselection');
		$("#postingChequeGrid").jqxGrid('clear');$("#postingChequeGrid").jqxGrid('addrow', null, {});$("#postingChequeGrid").jqxGrid('clearselection');
		$("#postingRefundGrid").jqxGrid('clear');$("#postingRefundGrid").jqxGrid('addrow', null, {});$("#postingRefundGrid").jqxGrid('clearselection');
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		 
		 if (document.getElementById("txtibbranch").value == "") {
		        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		 $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
		}
      
      function funGridType(){

     	 var paytype = $('#cmbtype').val();
     	// alert("paytype   "+paytype); 
     	$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		
 		 if(paytype==2){
 		       	$("#postingCardDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingChequeDiv").prop("hidden", true);
 		        $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid({ disabled: false});
 			    $("#commissionDiv").load("cardCommDetailsGrid.jsp?paytype="+paytype+"&check=1");
				
 		 }else if(paytype==3){
 			    $("#postingChequeDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingCardDiv").prop("hidden", true);
 		        $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid('clear');
 		        $("#cardCommGrid").jqxGrid({ disabled: true});
				
 		 }else if(paytype==4){
 				$("#postingRefundDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingCardDiv").prop("hidden", true);
 		        $("#postingChequeDiv").prop("hidden", true);
 		       
 		        $("#cardCommGrid").jqxGrid({ disabled: false});
			    $("#commissionDiv").load("cardCommDetailsGrid.jsp?paytype="+paytype+"&check=1");
 		       
 		 }else{
 			    $("#postingCashDiv").prop("hidden", false);
 			    $("#postingCardDiv").prop("hidden", true);
 			    $("#postingChequeDiv").prop("hidden", true);
 			    $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid('clear');
 		        $("#cardCommGrid").jqxGrid({ disabled: true});
				
 		     }
 		
 		}
      
      function funNotify(){	
	    	
    	  var paytype = $('#cmbtype').val();
    	  // alert("in "+paytype);  
    	  if($('#cmbbranch').val()=='a'){
 			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
 			 return 0;
 		 }
    	  
    	  var date = $('#fromdate').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
      
  	      var date = $('#todate').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
      
  	      var date = $('#date').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
  		
    	  if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='')){
 			 $.messager.alert('Message','Please Choose Inter-Branch & Then Post.','warning');
 			 return 0;
 		  }
		  
		var drtot = document.getElementById("txtdrtotal").value;
	 	var crtot = document.getElementById("txtcrtotal").value;
	 	
		if(drtot>crtot || drtot<crtot){
	 		$.messager.alert('Message','Invalid Transaction !!! Credit and Debit should be Equal.','warning');
            return 0;
	 	}
	 		
	 	if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 	    $.messager.alert('Message','Invalid Transaction !!! Credit and Debit should not be Zero.','warning');
	        return 0;
		}
      	  
    	  if(paytype==1){
	          
	      	   var selectedrows=$("#postingCashGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
		  			return false;
		  	   }
   		   }
   		 
   		 if(paytype==2){
	    	
	      	   var selectedrows=$("#postingCardGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Cards,Calculate & then Post.');
		  			return false;
		  	   }
   		 
   		 }
   		 
   		 if(paytype==3){
	          
	      	   var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
		  			return false;
		  	   }
 		   }
   		 
		 if(paytype==4){
	          
	      	   var selectedrows=$("#postingRefundGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Cards,Calculate & then Post.');
		  			return false;
		  	   }
 		   }

	  	   var jvrows = $("#postingJV").jqxGrid('getrows');
	  	   if(jvrows.length>0 && (jvrows[0].baseamount=="undefined" || jvrows[0].baseamount==null || jvrows[0].baseamount=="")){
	  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
	  			return false;
	  	   }
   		  
  		   $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
  	 		if (r){
  	 				
	    	/* Journal Voucher Grid Saving */
	    	 var rows = $("#postingJV").jqxGrid('getrows');
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
					
				var amount="0",baseamount="0",id="1";
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
				
				var costtype="0";var costcode="0";
				if($('#cmbtype').val()=='2') {
					if($('#txtcommdocno').val()==rows[i].docno){
						costtype=$('#txtcommcosttype').val();costcode=$('#txtcommcostcode').val();
					}
				}
				
				if($('#hidchckibbranch').val()==0){
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+"::"+costtype+"::"+costcode+"");
				} else if($('#hidchckibbranch').val()==1){
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+"::"+costtype+"::"+costcode+"");
				}
				newTextBox.appendTo('form');
				}
			 }
			 $('#jvgridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardPosting").submit();
			 
  	 		 }
  	 		});
  		 
    		return 1;
	} 
  
  
  function setValues(){
	 
	  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
	  
	  if($('#hidfromdate').val()){
			 $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		  }

	  if($('#hidtodate').val()){
			 $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		  }
	  
	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }
	  
	  if(document.getElementById("hidchckibbranch").value==1){
			 document.getElementById("chckibbranch").checked = true;
		 }
		 else if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
	  
	  if($('#msg').val()!=""){
		 $.messager.alert('Message',$('#msg').val());
		 getNonTaxableEntity();
		 funGridType();
		 funreload(event);
		 getAccounts($('#hidcmbtype').val(),$('#todate').val());
		 getCommissionAccounts($('#hidcmbtype').val(),$('#todate').val());
		 if(parseInt($('#txtnontaxableentity').val().trim())==1){
		 	getTaxAccounts($('#hidcmbtype').val(),$('#date').val());
		 }
		 
	 }
	  $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
	}
	
	function funExportBtn(){
		var type=$('#cmbtype').val();
		if(type=='1'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingCashGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='2'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingCardGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='3'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingChequeGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='4'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingRefundGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
	}

</script>
</head>
<body onload="getBranch();setValues();ibbranchcheck();getCardCommSeparate();getNonTaxableEntity();">
<form id="frmDashboardPosting" action="saveDashboardPosting" method="post">
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
    <td align="left"><div id="fromdate" name="fromdate" onchange="fromdatechange();" value='<s:property value="fromdate"/>'></div>
    <input type="hidden" id="hidfromdate" name="hidfromdate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidfromdate"/>'/></td></tr> 
    <tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" onchange="todatechange();" value='<s:property value="todate"/>'></div>
    <input type="hidden" id="hidtodate" name="hidtodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidtodate"/>'/></td></tr> 
     <tr><td align="right"><label class="branch">Post Br.</label></td>
     <td align="left"><input type="text" id="txtibbranch" name="txtibbranch" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtibbranch"/>' onkeydown="getIbBranch(event);"/>
     <input type="hidden" id="txtibbranchid" name="txtibbranchid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtibbranchid"/>'/>
	 <input type="checkbox" id="chckibbranch" name="chckibbranch" value="" onchange="ibbranchcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
      <input type="hidden" id="hidchckibbranch" name="hidchckibbranch" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidchckibbranch"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:50%;" onchange="funGridType();clearAccountInfo();getCommissionAccounts(this.value,$('#todate').val());getAccounts(this.value,$('#todate').val());getTaxAccounts(this.value,$('#date').val());" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="1">Cash</option>
    <option value="2">Card</option>
    <option value="3">Cheque/Online</option>
	<option value="4">Paid to Card</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidcmbtype"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txttypeaccid" name="txttypeaccid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypeaccid"/>' tabindex="-1"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txttypeaccname" name="txttypeaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttypedocno" name="txttypedocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypedocno"/>'/>
    <input type="hidden" id="txttypeatype" name="txttypeatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypeatype"/>'/>
    <input type="hidden" id="txttypecurid" name="txttypecurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypecurid"/>'/>
    <input type="hidden" id="txttyperate" name="txttyperate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttyperate"/>'/>
    <input type="hidden" id="txttypetype" name="txttypetype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypetype"/>'/></td></tr>
    <tr><td colspan="2"><fieldset><legend><b><label class="branch">Card Commission</label></b></legend>
	<table width="100%">
    <tr><td colspan="2"><div id="commissionDiv"><jsp:include page="cardCommDetailsGrid.jsp"></jsp:include></div></td></tr>
    </table></fieldset>
	</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Bank</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txtatype" name="txtatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtatype"/>'/>
    <input type="hidden" id="txtcurid" name="txtcurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcurid"/>'/>
    <input type="hidden" id="txtrate" name="txtrate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtrate"/>'/>
    <input type="hidden" id="txtcurtype" name="txtcurtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcurtype"/>'/></td></tr> 
    <tr><td align="right"><label class="branch">Posting</label></td>
    <td align="left"><div id="date" name="date" onchange="datechange();" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
    <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funNotify();">Post</button></td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtcommdocno" name="txtcommdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommdocno"/>'/>
	<input type="hidden" id="txtcommaccid" name="txtcommaccid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommaccid"/>'/>
	<input type="hidden" id="txtcommaccname" name="txtcommaccname" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommaccname"/>'/>
    <input type="hidden" id="txtcommatype" name="txtcommatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommatype"/>'/>
    <input type="hidden" id="txtcommcurid" name="txtcommcurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommcurid"/>'/>
    <input type="hidden" id="txtcommrate" name="txtcommrate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommrate"/>'/>
    <input type="hidden" id="txtcommtype" name="txtcommtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommtype"/>'/>
	<input type="hidden" id="txtcommcosttype" name="txtcommcosttype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommcosttype"/>'/>
    <input type="hidden" id="txtcommcostcode" name="txtcommcostcode" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommcostcode"/>'/>
    <input type="hidden" id="txttaxaccdocno" name="txttaxaccdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxaccdocno"/>'/>
	<input type="hidden" id="txttaxaccid" name="txttaxaccid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxaccid"/>'/>
	<input type="hidden" id="txttaxaccname" name="txttaxaccname" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxaccname"/>'/>
    <input type="hidden" id="txttaxaccatype" name="txttaxaccatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxaccatype"/>'/>
    <input type="hidden" id="txttaxacccurid" name="txttaxacccurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxacccurid"/>'/>
    <input type="hidden" id="txttaxaccrate" name="txttaxaccrate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxaccrate"/>'/>
    <input type="hidden" id="txttaxacccurtype" name="txttaxacccurtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxacccurtype"/>'/>
	<input type="hidden" id="txttaxacccosttype" name="txttaxacccosttype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxacccosttype"/>'/>
    <input type="hidden" id="txttaxacccostcode" name="txttaxacccostcode" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxacccostcode"/>'/>
    <input type="hidden" id="txttaxpercentage" name="txttaxpercentage" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttaxpercentage"/>'/>
    <input type="hidden" id="txtchequedescription" name="txtchequedescription" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtchequedescription"/>'/>
    <input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/>
    <input type="hidden" id="jvgridlength" name="jvgridlength" style="width:100%;height:20px;"/>
    <input type="hidden" name="txttrno" id="txttrno" style="width:100%;height:20px;" value='<s:property value="txttrno"/>'>
	<input type="hidden" name="txtselecteddocs" id="txtselecteddocs" style="width:100%;height:20px;" value='<s:property value="txtselecteddocs"/>'>
    <input type="hidden" name="txtselectedrno" id="txtselectedrno" style="width:100%;height:20px;" value='<s:property value="txtselectedrno"/>'>
    <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
	<input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
	<input type="hidden" id="txtibvalidation" name="txtibvalidation" style="width:60%;height:20px;" value='<s:property value="txtibvalidation"/>'/>
	<input type="hidden" name="txtbipostingcardcomm" id="txtbipostingcardcomm" style="width:100%;height:20px;" value='<s:property value="txtbipostingcardcomm"/>'>
	<input type="hidden" name="txtnontaxableentity" id="txtnontaxableentity" style="width:100%;height:20px;" value='<s:property value="txtnontaxableentity"/>'></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="postingCashDiv"><jsp:include page="postingCashGrid.jsp"></jsp:include></div>
		<div id="postingCardDiv" hidden="true"><jsp:include page="postingCardGrid.jsp"></jsp:include></div>
		<div id="postingChequeDiv" hidden="true"><jsp:include page="postingChequeGrid.jsp"></jsp:include></div>
		<div id="postingRefundDiv" hidden="true"><jsp:include page="postingRefundGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="JVTDiv"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div></td></tr>
		<tr><td>
		<table width="100%">
		  <tr>
		    <td width="7%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Dr. Total :&nbsp;</td>
		    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" class="textbox" style="width:15%;text-align: right;" readonly="readonly" value='<s:property value="txtdrtotal"/>'/></td>
		    <td width="6%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Cr. Total :&nbsp;</td>
		    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" class="textbox" style="width:50%;text-align: right;" readonly="readonly" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
		  </tr>
		</table>
		</td></tr>
	</table>
</tr>
</table>

</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="branchSearchWindow">
	<div></div><div></div>
</div>
</div>
</form> 
</body>
</html>