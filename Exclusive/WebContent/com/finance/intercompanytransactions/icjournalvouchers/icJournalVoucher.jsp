<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#icJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#icJournalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#icJournalVoucherGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '35%' , title: 'Inter Company / Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#icJournalVouchersDate').on('change', function (event) {
		    if ($("#mode").val() != "view") {
				var journaldate = $('#icJournalVouchersDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(journaldate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			    
			}
		 });
		 
		 $('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#icJournalVoucherGridID').jqxGrid('selectcell',0, '');
			          $('#icJournalVoucherGridID').jqxGrid('focus',0, '');
			  }
		 });
		 
	});
	
	function AccountSearchContent(url) {
		$('#icJournalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#icJournalVoucherGridWindow').jqxWindow('setContent', data);
		$('#icJournalVoucherGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getInterCompanyBranch(){
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var intrCompIdItems  = items[0].split(",");
						var compBranchItems = items[1].split(",");
						var intrBrhIdItems = items[2].split(",");
						var dbNameItems = items[3].split(",");
						
						$('#icJournalVoucherGridID').jqxGrid('setcellvalue', 0, "compbranch" ,compBranchItems);
						$('#icJournalVoucherGridID').jqxGrid('setcellvalue', 0, "intrcompid" ,intrCompIdItems);
						$('#icJournalVoucherGridID').jqxGrid('setcellvalue', 0, "intrbrhid" ,intrBrhIdItems);
						$('#icJournalVoucherGridID').jqxGrid('setcellvalue', 0, "dbname" ,dbNameItems);
						
				    }
			       else
				  {}
		     }
		      x.open("GET", "getInterCompanyBranch.jsp",true);
		     x.send();
		    
		   }
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );
					 $('#txtdrtotal').attr('readonly', true );$('#txtcrtotal').attr('readonly', true );
					 $("#icJournalVoucherGridID").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmIcJournalVoucher input').attr('readonly', true );
			$('#icJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#icJournalVoucherGridID").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
			$('#frmIcJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#icJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#icJournalVoucherGridID").jqxGrid({ disabled: false}); 
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIcJournalVoucher input').attr('readonly', true );
			    $("#icJournalVoucherGridID").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#icJournalVoucherGridID").jqxGrid('addrow', null, {});
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				$('#icJournalVouchersDate').val(new Date());
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#icJournalVoucherGridID").jqxGrid('clear');
				$("#icJournalVoucherGridID").jqxGrid('addrow', null, {});
				getInterCompanyBranch();
			}
	 }
	 
	 function funSearchLoad(){
		   changeContent('icjvMainSearch.jsp');  
	 }
	 
	 function funExcelBtn(){
		 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		 	   $("#icJournalVoucherGridID").jqxGrid('exportdata', 'xls', 'IcJournalVoucher');
		 }else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#icJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmIcJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			     
		        var journaldate = $('#icJournalVouchersDate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(journaldate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			    
				 valid=document.getElementById("txtvalidation").value;
				 if(valid==1){
					 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					 return 0;
				 }
			  
			    var drtot = document.getElementById("txtdrtotal").value;
		 		var crtot = document.getElementById("txtcrtotal").value;
		 		if(drtot>crtot || drtot<crtot){
		 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	            return 0;
		 		}
		 		
		 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
		 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		              return 0;
			 		}
		 		
		    	document.getElementById("errormsg").innerText="";
		    	/* Validation  Ends*/
		    	
		    	/* IC Journal Voucher Grid Saving */
		    	 var rows = $("#icJournalVoucherGridID").jqxGrid('getrows');
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
					
					if(rows[i].accounts==''){
						
						$.messager.alert('Message','Select an Account','warning');
						return;
					}
					
					
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].dbname+":: "+rows[i].intrbrhid+":: "+rows[i].intrcompid);
					newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
		 		/* IC Journal Voucher Grid Saving Ends */
		    	
		 		if ($("#mode").val() == "E") {
			         $('#frmIcJournalVoucher select').attr('disabled', false); 
			    }
		 		
	    		return 1;
		} 
	  
	  
	  function setValues(){
		 
		  if($('#hidicJournalVouchersDate').val()){
			 $("#icJournalVouchersDate").jqxDateTimeInput('val', $('#hidicJournalVouchersDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
		  }
		  
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check=1;
	         	 $("#icJournalVoucherDIV").load("icJournalVoucherGrid.jsp?txticjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
		}
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var reurl="";
				var url=document.URL;
				if( url.indexOf('saveIcJournalVoucher') >= 0){
					reurl=url.split("saveIcJournalVoucher");
				}else {
					reurl=url.split("icJournalVoucher.jsp");
				}
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
	 
						 var win= window.open(reurl[0]+"printIcJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{

						var win= window.open(reurl[0]+"printIcJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();

					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#icJournalVouchersDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIcJournalVoucher" action="saveIcJournalVoucher" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<table width="99%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="15%"><div id="icJournalVouchersDate" name="icJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="icJournalVouchersDate"/>'></div>
    <input type="hidden" id="hidicJournalVouchersDate" name="hidicJournalVouchersDate" value='<s:property value="hidicJournalVouchersDate"/>'/></td>
    <td width="28%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="13%" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
    <td width="6%" align="right">Doc No</td>
    <td width="21%"><input type="text" id="docno" name="txticjournalvouchersdocno" style="width:50%;" value='<s:property value="txticjournalvouchersdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Ref. No.</td>
    <td><input type="text" id="txtrefno" name="txtrefno" style="width:62%;" value='<s:property value="txtrefno"/>'/></td>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:80%;"  value='<s:property value="txtdescription"/>'/></td>
	<td align="left"><i><b><label id="lblformposted"  name="lblformposted"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="lblformposted"/></label></b></i></td>
  </tr>
  <tr>
    <td colspan="7"><div id="icJournalVoucherDIV"><jsp:include page="icJournalVoucherGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td align="right">Dr. Total</td>
    <td><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:65%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td colspan="4" align="right">Cr. Total</td>
    <td><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
</div>
</form>

<div id="icJournalVoucherGridWindow">
	<div></div><div></div>
</div>

<div id="branchSearchWindow">
	<div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>