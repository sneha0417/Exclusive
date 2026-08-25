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
		 $("#btnGridLoad").hide();
		 $("#budgetDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#assessmentYearDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"MM.yyyy"});		 
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 $('#budgetDate').on('change', function (event) {
				 var budgetdate = $('#budgetDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(budgetdate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
		 });
	});
	
	function BudgetPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmBudget input').attr('readonly', true );
			$('#frmBudget select').attr('disabled', true);
			$('#budgetDate').jqxDateTimeInput({disabled: true});
			$('#assessmentYearDate').jqxDateTimeInput({disabled: true});
			$("#budgetIncomeGridID").jqxGrid({ disabled: true});
			$("#budgetExpenditureGridID").jqxGrid({ disabled: true});
			$("#budgetIncomeGridID11").jqxGrid({ disabled: true});
			$("#btnGridLoad").hide();
	 }
	 
	 function funRemoveReadOnly(){
			$("#budgetIncomeGridID11").jqxGrid({ disabled: true});    
			$('#frmBudget input').attr('readonly', false );
			$('#frmBudget select').attr('disabled', false);
			$('#txttotalincome').attr('readonly', true );
			$('#txttotalexpenditure').attr('readonly', true );
			$('#budgetDate').jqxDateTimeInput({disabled: false});
			$('#assessmentYearDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#btnGridLoad").show();
			if ($("#mode").val() == "A") {
				$('#budgetDate').val(new Date());
				$('#assessmentYearDate').val(new Date());
				$("#budgetIncomeGridID").jqxGrid('clear'); 
				$("#budgetExpenditureGridID").jqxGrid('clear');
				$("#budgetIncomeGridID11").jqxGrid('clear');
			}
			
			if ($("#mode").val() == "E") {
				$("#budgetIncomeGridID").jqxGrid({ disabled: false});
				$("#budgetExpenditureGridID").jqxGrid({ disabled: false});
				$("#incomeDiv").load("budgetIncomeGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+$('#docno').val()+'&check=3');
		 	    $("#expenditureDiv").load("budgetExpenditureGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+$('#docno').val()+'&check=3');
		 	    $("#totalDiv").load("budgettotalGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+$('#docno').val()+'&check=3');
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('bgtMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
	 }
	 
	 function funFocus() {
	    	$('#budgetDate').jqxDateTimeInput('focus'); 	    		
	 }
	 
	  /* Validations */
	  $(function(){
	        $('#frmBudget').validate({
	                rules: {
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	  });});
	   
	  function funNotify(){	
		  /* Validation */
			
		    var budgetdate = $('#budgetDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(budgetdate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		    }
		  
		    var incometot = parseFloat(document.getElementById("txttotalincome").value);
	 		var expendituretot = parseFloat(document.getElementById("txttotalexpenditure").value);
	 		
	 		if(incometot=="" || expendituretot=="" || incometot=="NaN" || expendituretot=="NaN" || incometot==0 || expendituretot==0 || incometot==0.0 || expendituretot==0.0 || incometot==0.00 || expendituretot==0.00){
	 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Income and Expenditure should not be Zero.";
	              return 0;
		 		}
	 		
	    	document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
	    
	    	/* Income Grid  Saving*/
	  		  var rows = $("#budgetIncomeGridID").jqxGrid('getrows');
	  		  var incomelength=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].netincome;
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "test"+incomelength)
	  				    .attr("name", "test"+incomelength)
	  				    .attr("hidden", "true");
	  					incomelength=incomelength+1;
	  					
	  				newTextBox.val(rows[i].acno+":: "+rows[i].monthamt1+":: "+rows[i].monthamt2+":: "+rows[i].monthamt3+":: "+rows[i].monthamt4+":: "+rows[i].monthamt5+":: "+rows[i].monthamt6+":: "+rows[i].monthamt7+":: "+rows[i].monthamt8+":: "+rows[i].monthamt9+":: "+rows[i].monthamt10+":: "+rows[i].monthamt11+":: "+rows[i].monthamt12+":: "+rows[i].grtype+":: "+rows[i].netincome);
	  				newTextBox.appendTo('form');
	  			  }
			    }
			    $('#incomegridlength').val(incomelength);
	  	 		/* Income Grid  Saving Ends*/
	  	 		
			    /* Expenditure Grid  Saving*/
		  		  var rows = $("#budgetExpenditureGridID").jqxGrid('getrows');
		  		  var expenditurelength=0;
				  for(var i=0 ; i < rows.length ; i++){
					    var chks=rows[i].netincome;
					    if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
		  					newTextBox = $(document.createElement("input"))
		  				    .attr("type", "dil")
		  				    .attr("id", "tests"+expenditurelength)
		  				    .attr("name", "tests"+expenditurelength)
		  				    .attr("hidden", "true");
		  					expenditurelength=expenditurelength+1;
		  					
		  				newTextBox.val(rows[i].acno+":: "+rows[i].monthamt1+":: "+rows[i].monthamt2+":: "+rows[i].monthamt3+":: "+rows[i].monthamt4+":: "+rows[i].monthamt5+":: "+rows[i].monthamt6+":: "+rows[i].monthamt7+":: "+rows[i].monthamt8+":: "+rows[i].monthamt9+":: "+rows[i].monthamt10+":: "+rows[i].monthamt11+":: "+rows[i].monthamt12+":: "+rows[i].grtype+":: "+rows[i].netincome);
		  				newTextBox.appendTo('form');
		  			  }
				    }
				    $('#expendituregridlength').val(expenditurelength);
		  	 	/* Expenditure Grid  Saving Ends*/
		  	 		
				/* Columns Name*/
				    $('#incomegridcolumn').val($('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'acno', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt1', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt2', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt3', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt4', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt5', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt6', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt7', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt8', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt9', 'text')+"::"+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt10', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt11', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'monthamt12', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'grtype', 'text')+":: "+$('#budgetIncomeGridID').jqxGrid('getcolumnproperty', 'acno', 'netincome'));
				    $('#expendituregridcolumn').val($('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'acno', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt1', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt2', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt3', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt4', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt5', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt6', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt7', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt8', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt9', 'text')+"::"+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt10', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt11', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'monthamt12', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'grtype', 'text')+":: "+$('#budgetExpenditureGridID').jqxGrid('getcolumnproperty', 'acno', 'netincome'));
				/* Columns Name Ends*/
	  				 
 			 $('#budgetDate').jqxDateTimeInput({disabled: false});
	         $('#assessmentYearDate').jqxDateTimeInput({disabled: false});
		         
	    	 return 1;
	  } 
	  
	  function setValues(){
		  
		  if($('#hidbudgetDate').val()){
				 $("#budgetDate").jqxDateTimeInput('val', $('#hidbudgetDate').val());
			  }
		  
		  if($('#hidassessmentYearDate').val()){
				 $("#assessmentYearDate").jqxDateTimeInput('val', $('#hidassessmentYearDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  var indexVal = document.getElementById("docno").value;
	      if(indexVal>0) {
	          $("#incomeDiv").load("budgetIncomeGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+indexVal+'&check=2');
	 		  $("#expenditureDiv").load("budgetExpenditureGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+indexVal+'&check=2');
	 		 $("#totalDiv").load("budgettotalGrid.jsp?assessmentyear=01."+$('#assessmentYearDate').val()+'&docno='+indexVal+'&check=2');
	      }      
			 
		}
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveBudget");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"printBudget?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"printBudget?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  
		  var date = $('#budgetDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
	  function assessmentyeardatechange() {
		  $("#budgetIncomeGridID").jqxGrid({ disabled: true});$("#budgetExpenditureGridID").jqxGrid({ disabled: true});
		  $("#budgetIncomeGridID11").jqxGrid({ disabled: true});$("#budgetIncomeGridID11").jqxGrid('clear'); $("#budgetIncomeGridID").jqxGrid('clear');$("#budgetExpenditureGridID").jqxGrid('clear');  
	  }  
	      
	  function funGridLoad(){
		 
		  $("#budgetIncomeGridID").jqxGrid({ disabled: false});
		  $("#budgetExpenditureGridID").jqxGrid({ disabled: false});
	   
		  var assessmentyear = $('#assessmentYearDate').val();
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
 		  $("#incomeDiv").load("budgetIncomeGrid.jsp?assessmentyear=01."+assessmentyear+'&check='+check);
 		  $("#expenditureDiv").load("budgetExpenditureGrid.jsp?assessmentyear=01."+assessmentyear+'&check='+check);
 		  $("#totalDiv").load("budgettotalGrid.jsp?assessmentyear=01."+assessmentyear+'&check='+check);
 		 $("#budgetIncomeGridID11").jqxGrid({ disabled: true});
	  }
	  
	  function funExcelBtn(){
			 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(dataExcelExport, 'Income', true);
			  	JSONToCSVCon(dataExcelExport1, 'Expenditure', true);
			 } else {
				 $("#budgetIncomeGridID").jqxGrid('exportdata', 'xls', 'Income');
				 $("#budgetExpenditureGridID").jqxGrid('exportdata', 'xls', 'Expenditure');
			 }
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
<form id="frmBudget" action="saveBudget" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr height="42">
    <td width="3%" align="right">Date</td>
    <td width="11%"><div id="budgetDate" name="budgetDate" onchange="datechange();" onblur="datechange();" value='<s:property value="budgetDate"/>'></div>
    <input type="hidden" id="hidbudgetDate" name="hidbudgetDate" value='<s:property value="hidbudgetDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Assessment Year</td>
    <td width="29%"><div id="assessmentYearDate" name="assessmentYearDate" onchange="assessmentyeardatechange();" value='<s:property value="assessmentYearDate"/>'></div>
    <input type="hidden" id="hidassessmentYearDate" name="hidassessmentYearDate" value='<s:property value="hidassessmentYearDate"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtbudgetdocno" style="width:50%;" value='<s:property value="txtbudgetdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:70%;" value='<s:property value="txtdescription"/>'/></td>
    <td colspan="2" align="center"><button class="myButton" type="button" id="btnGridLoad" name="btnGridLoad" onclick="funGridLoad();">Submit</button></td>
  </tr>
</table>

<fieldset>
<legend>Income</legend>
<div id="incomeDiv"><center><jsp:include page="budgetIncomeGrid.jsp"></jsp:include></center></div> 
</fieldset>
<fieldset>
<legend>Expenditure</legend>
<div id="expenditureDiv"><center><jsp:include page="budgetExpenditureGrid.jsp"></jsp:include></center></div>
</fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Total Income</td>
    <td width="68%"><input type="text" id="txttotalincome" name="txttotalincome" style="width:15%;text-align: right;" value='<s:property value="txttotalincome"/>'/></td>
    <td width="6%" align="right">Total Expenditure</td>
    <td width="19%"><input type="text" id="txttotalexpenditure" name="txttotalexpenditure" style="width:50%;text-align: right;" value='<s:property value="txttotalexpenditure"/>' tabindex="-1"/></td>
  </tr>
</table>   
<table>
  <tr>
  <div id="totalDiv"><center><jsp:include page="budgettotalGrid.jsp"></jsp:include></center></div>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="incomegridlength" name="incomegridlength"/>
<input type="hidden" id="expendituregridlength" name="expendituregridlength"/>
<input type="hidden" id="incomegridcolumn" name="incomegridcolumn"/>
<input type="hidden" id="expendituregridcolumn" name="expendituregridcolumn"/>

</div>
</form>

<div id="printWindow">
	<div></div><div></div>
</div> 
</div>
</body>
</html>
