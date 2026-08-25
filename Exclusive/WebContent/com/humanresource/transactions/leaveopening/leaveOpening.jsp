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
		
		 $("#leaveOpeningDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsGridWindow').jqxWindow('close');
		 
		 $('#leaveDetailsGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Leave Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#leaveDetailsGridWindow').jqxWindow('close');
			 
	});
	
	function EmployeeSearchContent(url) {
	 	$('#employeeDetailsGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsGridWindow').jqxWindow('setContent', data);
		$('#employeeDetailsGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function LaeaveSearchContent(url) {
	 	$('#leaveDetailsGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#leaveDetailsGridWindow').jqxWindow('setContent', data);
		$('#leaveDetailsGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function funReadOnly(){
			$('#frmLeaveOpening input').attr('readonly', true );
			$('#leaveOpeningDate').jqxDateTimeInput({disabled: true});
			$("#leaveOpeningGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmLeaveOpening input').attr('readonly', false );
			$('#leaveOpeningDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#leaveOpeningGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "E") {
   			    $("#leaveOpeningGridID").jqxGrid('addrow', null, {});
			  }
			// alert("===="+$("#mode").val()+"==");
			if ($("#mode").val() == "A") {
				$('#leaveOpeningDate').val(new Date());
				$("#leaveOpeningGridID").jqxGrid('clear'); 
				$("#leaveOpeningGridID").jqxGrid('addrow', null, {});
				
				//$("#leaveOpeningDiv").load("leaveOpeningGrid.jsp");
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('lopMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#leaveOpeningDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   /* $(function(){
	        $('#frmLeaveOpening').validate({
	                rules: {
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); */
	   
	  function funNotify(){	
		  
		  /* Validation */
	    	document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
	    		
	     /* Leave Opening Grid  Saving*/
				 var rows = $("#leaveOpeningGridID").jqxGrid('getrows');
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
							
				    newTextBox.val(rows[i].employeedocno+"::"+rows[i].leaveid+"::"+rows[i].opnleaves);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Leave Opening Grid  Saving Ends*/	 
	 		
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidleaveOpeningDate').val()){
				 $("#leaveOpeningDate").jqxDateTimeInput('val', $('#hidleaveOpeningDate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  var indexVal = document.getElementById("docno").value;
		  if(indexVal>0){
         	$("#leaveOpeningDiv").load("leaveOpeningGrid.jsp?docno="+indexVal);
		  } 
	         
		}
	   
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveLeaveOpening");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 /* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus(); */
						 }
						else{
							/* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus(); */
						}
					   });
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
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmLeaveOpening" action="saveLeaveOpening" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="11%"><div id="leaveOpeningDate" name="leaveOpeningDate" value='<s:property value="leaveOpeningDate"/>'></div>
    <input type="hidden" id="hidleaveOpeningDate" name="hidleaveOpeningDate" value='<s:property value="hidleaveOpeningDate"/>'/></td>
    <td align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtleaveopeningdocno" style="width:50%;" value='<s:property value="txtleaveopeningdocno"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset><br/>
<div id="leaveOpeningDiv"><jsp:include page="leaveOpeningGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>

</div>
</form>
<div id="employeeDetailsGridWindow">
   <div></div>
</div>
<div id="leaveDetailsGridWindow">
   <div></div>
</div>	
</div>
</body>
</html>
