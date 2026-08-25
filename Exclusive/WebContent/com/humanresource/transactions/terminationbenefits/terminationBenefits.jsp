<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		/*  $('#btnPrint').attr('disabled', true ); */$('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#terminationBenefitsPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	     var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	    
	});
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     $('#txtchksalarypaid').val(items[3]);
	  			   
	  			     document.getElementById("errormsg").innerText="Terminal Benefits done till "+items[2]+".";
	  			     
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					if(parseInt($('#txtchksalarypaid').val())==0){  
	  					    $("#overlay, #PleaseWait").show();
	  					    $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value);
	  					    $('#txtchkgridload').val('');
	  					    $('#txtgridload').val(1);
	  					    $('#btnExcelExporter').show();
	  					} else {
	  						$.messager.alert('Message','Payroll Processing Pending.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Terminal Benefits Already Done.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Terminal Benefits date should be Month-End.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  		}
  		}
  		x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("brchName").value, true);
  		x.send();
    }
	
	 function funReadOnly(){
			$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: true});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: true});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: false});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: false});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#terminationBenefitsPostingDate').val(new Date());
				var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				
				$("#terminationBenefitsDetails").jqxGrid('clear'); 
				$("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				$("#terminationBenefitsAccounts").jqxGrid('clear');
				$("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('tebMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#terminationBenefitsPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	var rows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
				var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         }
	    	    /* Validation Ends*/
	        	
	        	/* Terminal Benefits Details Grid  Saving*/
				 var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].employeedocno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    newTextBox.val(rows[i].employeedocno+"::"+rows[i].salary+"::"+rows[i].terminalbenefitsyears+"::"+rows[i].terminalbenefitsdaystobeposted+"::"+rows[i].terminalbenefitscurrentprovision+"::"+rows[i].terminalbenefitsalreadyposted+"::"+rows[i].terminalbenefitstobeposted+"::"+rows[i].leavesalary+"::"+rows[i].leavesalarydaystobeposted+"::"+rows[i].leavesalarytotaldaysposted+"::"+rows[i].leavesalarycurrentprovision+"::"+rows[i].leavesalaryalreadyposted+"::"+rows[i].leavesalarytobeposted+"::"+rows[i].travelstotalperyear+"::"+rows[i].travelsdaystobeposted+"::"+rows[i].travelstotaldaysposted+"::"+rows[i].travelstotal+"::"+rows[i].travelsalreadyposted+"::"+rows[i].travelstobeposted);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Terminal Benefits Details Grid  Saving Ends*/	
	 		   
		 		/* Account Details Grid Saving */
		    	 var accountrows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var j=0 ; j < accountrows.length ; j++){
					var chks=accountrows[j].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
						
					var amount=0,id=1;
					if((accountrows[j].credit!=null) && (accountrows[j].credit!='undefined') &&  (accountrows[j].credit!='NaN') && (accountrows[j].credit!="") && (accountrows[j].credit!=0)){
						 amount=accountrows[j].credit*-1;
						 id=-1;
					}
					
					if((accountrows[j].debit!=null) && (accountrows[j].debit!='undefined') && (accountrows[j].debit!='NaN') && (accountrows[j].debit!="") && (accountrows[j].debit!=0)){
						 amount=accountrows[j].debit;
						 id=1;
					}
					
					newTextBox.val(accountrows[j].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidterminationBenefitsPostingDate').val()){
				 $("#terminationBenefitsPostingDate").jqxDateTimeInput('val', $('#hidterminationBenefitsPostingDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		     var indexVal = document.getElementById("txttrno").value;
			 if(indexVal>0){
	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
			 }
	         
			 var indexVal1 = document.getElementById("docno").value;
	         var indexVal2 = document.getElementById("txttrno").value;
	         if(indexVal1>0){
	         	$("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
	         } 
		}	
	  
	  function funProcessBtn(){
	      var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#terminationBenefitsPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#terminationBenefitsPostingDate').val();
			  var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  
			  $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  
			  var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
			     $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?check=2");
			  }
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
	  }
	  
	  function funExcelExporter(){
			 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'TerminalBenefits', true);
			 } else {
				 $("#terminationBenefitsDetails").jqxGrid('exportdata', 'xls', 'TerminalBenefits');
			 }
		 }
	  
	  function funExcelBtn() {
		  JSONToCSVCon(dataExcelExport, 'TerminalBenefits', true);
	  }
		
		function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("transactions");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		    var date = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	  }
	  
</script>

<style>
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}

.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTerminalBenefitsPosting" action="terminalbenefitsposting" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="24%"><div id="terminationBenefitsPostingDate" name="terminationBenefitsPostingDate"  onchange="datechange();" value='<s:property value="terminationBenefitsPostingDate"/>'></div>
    <input type="hidden" id="hidterminationBenefitsPostingDate" name="hidterminationBenefitsPostingDate" value='<s:property value="hidterminationBenefitsPostingDate"/>'/></td>
    <td width="8%" align="right"><button type="button" class="icon" id="btnExcelExporter" title="Export current Document to Excel" onclick="funExcelExporter();">
      						 <img alt="Export current Document to Excel" src="<%=contextPath%>/icons/excel_new.png">
      					</button></td>
    <td width="13%" align="right"><button type="button" id="btnProcessing" title="Process"  style="border:none;background:none;" onclick="funProcessBtn();">
      						 <img alt="Process" src="<%=contextPath%>/icons/process2.png" width="16" height="16">
      					</button></td>
    <td width="10%" align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funCalculateBtn();">
							<img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
						</button></td>
    <td width="18%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="txtjvno" value='<s:property value="txtjvno"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>
<fieldset><legend>Details</legend>
<div id="terminationBenefitsDetailsDiv"><jsp:include page="terminationBenefitsGrid.jsp"></jsp:include></div>
</fieldset>

<table width="100%">
  <tr>
    <td width="8%" align="right">Terminal Benefits</td>
    <td width="24%"><input type="text" id="txtterminalbenefitstotal" name="txtterminalbenefitstotal" style="width:50%;text-align: right;" value='<s:property value="txtterminalbenefitstotal"/>' tabindex="-1"/></td>
    <td width="5%" align="right">Leave Salary</td>
    <td width="26%"><input type="text" id="txtleavesalarytotal" name="txtleavesalarytotal" style="width:50%;text-align: right;" value='<s:property value="txtleavesalarytotal"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Travels</td>
    <td width="27%"><input type="text" id="txttravelstotal" name="txttravelstotal" style="width:50%;text-align: right;" value='<s:property value="txttravelstotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset><legend>Accounts</legend>
<div id="accountsDetailsDiv"><jsp:include page="accountsDetailsGrid.jsp"></jsp:include></div>
</fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="journalgridlength" name="journalgridlength"/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtgridload" name="txtgridload"  value='<s:property value="txtgridload"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid"  value='<s:property value="txtchksalarypaid"/>'/>
<input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
</div>
</form>
	
</div>
</body>
</html>