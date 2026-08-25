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
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	     var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	    
	});
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     
	  			     document.getElementById("errormsg").innerText="Depreciation done till "+items[2]+".";
	  			     
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					  $("#overlay, #PleaseWait").show();
	  					  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value);
	  					  $('#txtchkgridload').val('');
	  					  $('#txtgridload').val(1);
	  					  $('#btnExcelExporter').show();
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Depreciation Pending for Last-Month.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Depreciation Already Done.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Depreciation date should be Month-End.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
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
			$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: true});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: true});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: false});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: false});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#jqxVehDepreciationPostingDate').val(new Date());
				var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				
				$("#jqxvehicleDetails").jqxGrid('clear'); 
				$("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				$("#jqxVehicleAccounts").jqxGrid('clear');
				$("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('vdpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxVehDepreciationPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
				var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         }
		         
		        var txtdrtotal=parseFloat($('#txtdrtotal').val()==''?0.0:$('#txtdrtotal').val());
		        var txtcrtotal=parseFloat($('#txtcrtotal').val()==''?0.0:$('#txtcrtotal').val());
		        if(txtdrtotal==0.0 || txtcrtotal==0.0){
		        	document.getElementById("errormsg").innerText="";
		        	document.getElementById("errormsg").innerText="Dedit/Credit Total cannot be zero";
		        	return 0;
		        }
	    	    /* Validation Ends*/
	        	
	        	/* Vehicle Details Grid  Saving*/
				 var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].fleet_no;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    newTextBox.val(rows[i].fleet_no+"::"+rows[i].depr_amt+"::"+rows[i].frmdate+"::"+rows[i].depr+"::"+rows[i].bookvalue);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Vehicle Details Grid  Saving Ends*/	
	 		   
		 		/* Account Details Grid Saving */
		    	 var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chks=rows[i].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
						
					var amount,id;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 id=-1;
					}
					
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 id=1;
					}
					
					newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidjqxVehDepreciationPostingDate').val()){
				 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput('val', $('#hidjqxVehDepreciationPostingDate').val());
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
	         $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
	         } 
		}	
	  
	  function funProcessBtn(){
	      var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#jqxVehDepreciationPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#jqxVehDepreciationPostingDate').val();
			  var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  
			  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  
			  var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
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
			  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
			 } else {
				 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
			 }
		 }
	  
	  function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
			 } else {
				 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
			 }
		  }
	  }
		
		function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("posting");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"posting/vehicledepreciationposting/printVehicleDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"posting/vehicledepreciationposting/printVehicleDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		    var date = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
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
<form id="frmVehicleDepreciationPosting" action="vehicledepreciationposting" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="24%"><div id="jqxVehDepreciationPostingDate" name="jqxVehDepreciationPostingDate"  onchange="datechange();" value='<s:property value="jqxVehDepreciationPostingDate"/>'></div>
    <input type="hidden" id="hidjqxVehDepreciationPostingDate" name="hidjqxVehDepreciationPostingDate" value='<s:property value="hidjqxVehDepreciationPostingDate"/>'/></td>
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
<div id="vehiclesDetailsDiv"><jsp:include page="vehiclesDetailsGrid.jsp"></jsp:include></div>
</fieldset>
<table width="100%">
  <tr>
    <td width="83%" align="right">Depr. Total</td>
    <td width="17%"><input type="text" id="txtdeprtotal" name="txtdeprtotal" style="width:50%;text-align: right;" value='<s:property value="txtdeprtotal"/>' tabindex="-1"/></td>
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
<input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
</div>
</form>
	
</div>
</body>
</html>