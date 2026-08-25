<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#deductionScheduleDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#startDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  //$("#empDateOfBirth").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
    	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#employeeDetailsWindow').jqxWindow('close');
 		 
 		 $('#txtemployeedetails').dblclick(function(){
 			employeeSearchContent("employeeDetailsSearch.jsp");
		  });
 		 
      }); 
      
      function employeeSearchContent(url) {
		 	$('#employeeDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#employeeDetailsWindow').jqxWindow('setContent', data);
			$('#employeeDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function getEmployeeDetails(event){
          var x= event.keyCode;
          if(x==114){
        	  employeeSearchContent("employeeDetailsSearch.jsp");
          }
          else{}
          }
      
      function funInstAmount(){
 		 var amount=$('#txtamount').val();
 		 var instno=$('#txtinstnos').val();
 		 
 		if(amount==""){ 
			document.getElementById("errormsg").innerText="Amount is Mandatory.";
	         return 0;  
        }
 		
 		 if(instno==""){ 
				document.getElementById("errormsg").innerText="Installment number is Mandatory.";
		         return 0;  
	     }
 		 
 		if(instno=="0"){ 
			document.getElementById("errormsg").innerText="Installment number is Invalid.";
	         return 0;  
       }
 		
 		document.getElementById("errormsg").innerText="";
 		
 		 if(!isNaN(amount)){
 		     var result = amount / instno;
 			 $('#txtinstamt').val(result);
 			 }
 			 else if(isNaN(amount)){
 			 	 $('#txtinstamt').val(0.0);
 			 }
 	 }
      
      function deductionGridLoading(){
		  var startdate = $('#startDate').jqxDateTimeInput('getText');
		  var amount = document.getElementById("txtamount").value;
		  var instno = document.getElementById("txtinstnos").value;
		  var instamt = document.getElementById("txtinstamt").value;
		  
		  $("#deductionScheduleDiv").load('deductionScheduleGrid.jsp?startdate='+startdate+'&amount='+amount+'&instno='+instno+'&instamt='+instamt);
	  }
      
      $(function(){
	        $('#frmDeductionSchedule').validate({
	                rules: {
	                	txtemployeedetails:"required",
	                 },
	                 messages: {
	                	 txtemployeedetails:" *",
	                 }
	        });});
 	 
	 function funReadOnly(){
			$('#frmDeductionSchedule input').attr('readonly', true );
			$('#frmDeductionSchedule select').attr('disabled', true);
			$('#deductionScheduleDate').jqxDateTimeInput({disabled: true});
			$('#startDate').jqxDateTimeInput({disabled: true});
			$('#btnDistributionSubmit').attr('disabled', true);
			
			$("#deductionScheduleGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmDeductionSchedule input').attr('readonly', false );
			$('#frmDeductionSchedule select').attr('disabled', false);
			$('#deductionScheduleDate').jqxDateTimeInput({disabled: false});
			$('#startDate').jqxDateTimeInput({disabled: false});
			$('#txtemployeedetails').attr('readonly', true );
			$('#docno').attr('readonly', true);
			$('#btnDistributionSubmit').attr('disabled', false);
			
			$("#deductionScheduleGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "A") {
					 $('#deductionScheduleDate').val(new Date());
					 
					 $("#deductionScheduleGridID").jqxGrid('clear'); 
				     $("#deductionScheduleGridID").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funNotify(){	
		 /* Validation */
		 
		 
		 
		// document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/
		 
		 /* Deduction Schedule Grid  Saving*/
		  var rows = $("#deductionScheduleGridID").jqxGrid('getrows');
		  var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].amount;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					length=length+1;
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+i)
					    .attr("name", "test"+i)
						.attr("hidden", "true");
					
					newTextBox.val(rows[i].sr_no+"::"+rows[i].date+"::"+rows[i].amount+"::"+rows[i].posted+"::"+rows[i].rowno+"::"+rows[i].postedtrno);
					newTextBox.appendTo('form');
					}
				}
		 		 $('#gridlength').val(length);
				/*Deduction Schedule Grid  Saving Ends*/	 
 		 
			return 1;	    	
		} 
	 
	 function funSearchLoad(){
			 changeContent('dscMainSearch.jsp'); 
		 }
	 
	 function funFocus(){
	    	$('#deductionScheduleDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
			 if($('#hiddeductionScheduleDate').val()){
				 $("#deductionScheduleDate").jqxDateTimeInput('val', $('#hiddeductionScheduleDate').val());
			  }
			 
			 if($('#hidstartDate').val()){
				 $("#startDate").jqxDateTimeInput('val', $('#hidstartDate').val());
			  }
			 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 $("#deductionScheduleDiv").load("deductionScheduleGrid.jsp?docno="+indexVal);
			 }
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
		
		
	function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("transactions");
			     $("#docno").prop("disabled", false);   
				 var win= window.open(reurl[0]+"transactions/deductionschedule/printDeduction?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				 win.focus();	
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
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
<form id="frmDeductionSchedule" action="saveDeductionSchedule" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset>
<table width="99%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="20%"><div id="deductionScheduleDate" name="deductionScheduleDate" value='<s:property value="deductionScheduleDate"/>'></div>
    <input type="hidden" id="hiddeductionScheduleDate" name="hiddeductionScheduleDate" value='<s:property value="hiddeductionScheduleDate"/>'/></td>
    <td width="19%" align="right">Ref. No.</td>
    <td width="20%"><input type="text" id="txtemployeerefno" name="txtemployeerefno" placeholder="Ref. No." style="width:50%;" value='<s:property value="txtemployeerefno"/>'/></td>
    <td width="17%" align="right">Doc No </td>
    <td width="19%"><input type="text" id="docno" name="txtdeductionscheduledocno" style="width:70%;" tabindex="-1" value='<s:property value="txtdeductionscheduledocno"/>'/></td>
  </tr>
</table>
</fieldset><br/>
<fieldset>
<table width="99%">
  <tr>
    <td width="5%" align="right">Employee</td>
    <td width="95%"><input type="text" id="txtemployeedetails" name="txtemployeedetails" placeholder="Press F3 to Search" style="width:94%;" onkeydown="getEmployeeDetails(event);" value='<s:property value="txtemployeedetails"/>'/>
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="99%">
<tr><td  width="40%">
<fieldset style="background-color: #EBDEF0;">
<table width="99%">
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%" align="right">Amount</td>
    <td width="90%"><input type="text" id="txtamount" name="txtamount" placeholder="Amount" style="width:30%;text-align: right;" onblur="funRoundAmt(this.value,this.id);funInstAmount();" value='<s:property value="txtamount"/>'/></td>
  </tr>
  <tr>
    <td align="right">Inst. Nos</td>
    <td><input type="text" id="txtinstnos" name="txtinstnos" placeholder="Inst. Nos" style="width:10%;" onblur="funInstAmount();" value='<s:property value="txtinstnos"/>'/>
    <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>'/>
    <input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/></td>
  </tr>
  <tr>
    <td align="right">Start Date</td>
    <td><div id="startDate" name="startDate" value='<s:property value="startDate"/>'></div>
    <input type="hidden" id="hidstartDate" name="hidstartDate" value='<s:property value="hidstartDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td><input type="text" id="txtdescription" name="txtdescription" placeholder="Description" style="width:85%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><button class="myButton" type="button" id="btnDistributionSubmit" name="btnDistributionSubmit" onclick="deductionGridLoading();">Submit</button></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
</fieldset>
</td>
<td  width="60%">
<div id="deductionScheduleDiv"><jsp:include page="deductionScheduleGrid.jsp"></jsp:include></div>
</td></tr></table>
</fieldset>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
<div id="employeeDetailsWindow">
   <div></div>
</div>

</div>
</body>
</html>
