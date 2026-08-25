<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<script type="text/javascript">
$(document).ready(function () {
	  /* Date */
	  $("#cnddate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	  $("#cnddob").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	  
	  /* Searching Window */
	 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 1002, y: 153 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#nationalityWindow').jqxWindow('close');
	 
	 $('#qualificationWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Qualification Search',position: { x: 104, y: 174 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#qualificationWindow').jqxWindow('close');
	 
	 $('#designationWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Designation Search',position: { x: 104, y: 174 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#designationWindow').jqxWindow('close');
	 
	  $('#txtnationality').dblclick(function(){
		nationalitySearchContent("nationSearchGrid.jsp");
	  }); 
	  $('#txtqualification').dblclick(function(){
		  qualificationSearchContent("qualificationGrid.jsp");
	  });
	  $('#txtdesignation').dblclick(function(){
		  designationSearchContent("designationGrid.jsp");
	  });
	 
}); 


function nationalitySearchContent(url) {
 	$('#nationalityWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#nationalityWindow').jqxWindow('setContent', data);
	$('#nationalityWindow').jqxWindow('bringToFront');
	}); 
}
function qualificationSearchContent(url) {
 	$('#qualificationWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#qualificationWindow').jqxWindow('setContent', data);
	$('#qualificationWindow').jqxWindow('bringToFront');
	}); 
}
function designationSearchContent(url) {
 	$('#designationWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#designationWindow').jqxWindow('setContent', data);
	$('#designationWindow').jqxWindow('bringToFront');
	}); 
}

function getNations(event){
    var x= event.keyCode;
    if(x==114){
  	  nationalitySearchContent("nationSearchGrid.jsp");
    }
    else{}
}
function getQualification(event){
    var x= event.keyCode;
    if(x==114){
    	qualificationSearchContent("qualificationGrid.jsp");
    }
    else{}
}
function getDesignation(event){
    var x= event.keyCode;
    if(x==114){
    	designationSearchContent("designationGrid.jsp");
    }
    else{}
}

function funReadOnly(){
	$('#frmCandidateMaster input').attr('readonly', true );
	$('#frmCandidateMaster select').attr('readonly', true); 
	//$('#frmCandidateMaster input').attr('disabled', true );
	//$('#frmCandidateMaster select').attr('disabled', true); 
	$('#cnddate').jqxDateTimeInput({disabled: true});
	$('#cnddob').jqxDateTimeInput({disabled: true});
	$("#cvAnalyseGridID").jqxGrid({ disabled: true});
}

function funRemoveReadOnly(){
	$('#frmCandidateMaster input').attr('readonly', false );
	
	$('#frmCandidateMaster input').attr('disabled', false );
	$('#frmCandidateMaster select').attr('disabled', false);
	$('#cnddate').jqxDateTimeInput({disabled: false});
	$('#cnddob').jqxDateTimeInput({disabled: false});
	$('#docno').attr('readonly', true);
	
	$("#cvAnalyseGridID").jqxGrid({ disabled: false});
	
	if ($("#mode").val() == "A") {
			 $('#cnddate').val(new Date());
			 $('#cnddob').val(new Date());
			 
			 $("#cvAnalyseGridID").jqxGrid('clear'); 
		     $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
		     
		   //  $("#cvAnalyseGridID").load("cvAnalyseGrid.jsp?mode="+$("#mode").val());
	}
	
	if ($("#mode").val() == "E") {
		     $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
		     /* var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#cvAnalyseGridID").load("cvAnalyseGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
			 }  */
	}
}

function funFocus(){
	$('#cnddate').jqxDateTimeInput('focus'); 	    		
}

function funNotify(){
	var rows = $("#cvAnalyseGridID").jqxGrid('getrows');
	 var cvlength=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].questions;
			if(typeof(chk) != "undefined"){
				cvlength=cvlength+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "txtcvanalyse"+i)
			    .attr("name", "txtcvanalyse"+i)
			    .attr("hidden", "true");
		
				newTextBox.val(rows[i].questions+" :: "+rows[i].remarks+" :: "+rows[i].grade);
				newTextBox.appendTo('form');
		 }
		}
	 $('#cvarraygridlength').val(cvlength);
	 $("#frmCandidateMaster").submit();
}

function setValues(){
	if($('#hidcnddate').val()){
		 $("#cnddate").jqxDateTimeInput('val', $('#hidcnddate').val());
	  }
	if($('#hidcnddob').val()){
		 $("#cnddob").jqxDateTimeInput('val', $('#hidcnddob').val());
	  }
	 if($('#hidcmbgender').val()!=""){
		 $('#cmbgender').val($('#hidcmbgender').val());
	 }
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	 funSetlabel();
	 var indexVal = document.getElementById("docno").value;
	 if(indexVal!=""){
     	 $("#cvanalyseDiv").load("cvAnalyseGrid.jsp?docno="+indexVal);
	 }
}

function funPrintBtn(){
	
}
function funChkButton() {
	/* funReset(); */
}
function funSearchLoad(){
	changeContent('cdmMainSearch.jsp'); 
 }
 
function isNumber(evt,id) {
	//Function to restrict characters and enter number only
		  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	            return false;
	            
	         }
	        
	        return true;
	    }
 
$(function(){
    $('#frmCandidateMaster').validate({
            rules: {
            	txtcndname:"required",
            	txtqualification:"required",
            	txtrefno:"required",
            //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
             
             },
             messages: {
            	 txtcndname:" *",
            	 txtqualification:" *",
            	 txtrefno:" *",
             //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
             }
    });});
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCandidateMaster" action="saveCandidateMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   
<div class='hidden-scrollbar'>	
	
	<fieldset style="padding:10px;">
	<table width="100%" border="0">
	  <tr>
	    <td width="6%" align="right" >Date</td>
	    <td width="25%"><div id="cnddate" name="cnddate" value='<s:property value="cnddate"/>'></div></td>
	    <td width="13%" align="right">Ref No</td>
	    <td width="35%"><input type="text" id="txtrefno" name="txtrefno" placeholder="Ref No" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
	    <td width="8%" align="right">Doc No</td>
	    <td width="13%"><input type="text" id="docno" name="docno" placeholder="Doc No" style="width:100%;" value='<s:property value="docno"/>'/></td>
	  </tr>
	</table>
	</fieldset><br/>
	
	<fieldset style="padding:10px;"><legend></legend>
	<table width="100%" border="0">
	  <tr>
	    <td width="6%" align="right">Name</td>
	    <td width="25%" ><input type="text" id="txtcndname" name="txtcndname" placeholder="Candidate Name" style="width:100%;" value='<s:property value="txtcndname"/>'/></td>
	    <td width="13%" align="right">Gender</td>
	    <td width="11%">
	    	<select id="cmbgender" name="cmbgender" style="width:100%;" value='<s:property value="cmbgender"/>'>
      			<option value="">--Select--</option>
      			<option value="M">Male</option>
      			<option value="F">Female</option>
      		</select>
	    </td>
	    <td width="12%" align="right">DOB</td>
	    <td width="12%"><div id="cnddob" name="cnddob" value='<s:property value="cnddob"/>'></div></td>
	    <td width="8%" align="right">Nationality</td>
	    <td width="13%"><input type="text" id="txtnationality" name="txtnationality" placeholder="Press F3 to Search" onkeydown="getNations(event);" style="width:100%;" value='<s:property value="txtnationality"/>'/></td>
	  </tr>
	  <tr>
	    <td align="right">Qualification</td>
	    <td><input type="text" id="txtqualification" name="txtqualification" placeholder="Press F3 to Search" style="width:100%;" onkeydown="getQualification(event);" value='<s:property value="txtqualification"/>'/></td>
	    <td align="right">Experience In Years</td>
	    <td><input type="text" id="txtexpyear" name="txtexpyear" placeholder="Experience In Years" style="width:100%;" onkeypress="javascript:return isNumber (event,id)" value='<s:property value="txtexpyear"/>'/></td>
	    <td align="right">Post Applied For</td>
	    <td colspan="3"><input type="text" id="txtpostapplied" name="txtpostapplied" placeholder="Post Applied For" style="width:100%;" value='<s:property value="txtpostapplied"/>'/></td>
	  </tr>
	  <tr>
	    <td align="right">Suitable For</td>
	    <td><input type="text" id="txtdesignation" name="txtdesignation" placeholder="Press F3 to Search" style="width:100%;" onkeydown="getDesignation(event);" value='<s:property value="txtdesignation"/>'/></td>
	    <td align="right">Remarks</td>
	    <td colspan="5"><input type="text" id="txtremarks" name="txtremarks" placeholder="Remarks" style="width:100%;" value='<s:property value="txtremarks"/>'/></td>
	    </tr>
	</table>
	</fieldset>
	
	<fieldset style="background: #F8E0F7;">
		<legend><b>CV Analyse</b></legend>
		<div id="cvanalyseDiv"><jsp:include page="cvAnalyseGrid.jsp"></jsp:include></div><br/>
	</fieldset>
	
</div>
	<input type="hidden" id="mode" name="mode"/>
	<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
	
	<input type="hidden" id="hidnationid" name="hidnationid"  value='<s:property value="hidnationid"/>'/>
	<input type="hidden" id="hidqualificationid" name="hidqualificationid"  value='<s:property value="hidqualificationid"/>'/>
	<input type="hidden" id="hidmasterdocno" name="hidmasterdocno"  value='<s:property value="hidmasterdocno"/>'/>
	<input type="hidden" id="hiddesignationid" name="hiddesignationid"  value='<s:property value="hiddesignationid"/>'/>
	<input type="hidden" id="cvarraygridlength" name="cvarraygridlength"  value='<s:property value="cvarraygridlength"/>'/>
	<input type="hidden" id="hidcnddate" name="hidcnddate"  value='<s:property value="hidcnddate"/>'/>
	<input type="hidden" id="hidcnddob" name="hidcnddob"  value='<s:property value="hidcnddob"/>'/>
	<input type="hidden" id="hidcmbgender" name="hidcmbgender"  value='<s:property value="hidcmbgender"/>'/>
	
	
</form>

	<div id="nationalityWindow">
	   <div></div>
	</div>
	<div id="qualificationWindow">
	   <div></div>
	</div>
	<div id="designationWindow">
	   <div></div>
	</div>
	
</div>
</body>
</html>