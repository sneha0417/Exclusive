<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    height: 550px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function() {
	      $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  
	      $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Project Invoice Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
		  $('#refnosearchwindow').jqxWindow('close');
		    
		  $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#costCodeSearchWindow').jqxWindow('close');
	  
		  $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#printWindow').jqxWindow('close');
	 
		  $('#rrefno').dblclick(function(){
		     	
	     	if($('#mode').val()!= "view") {
	 	  	  refnoSearchContent('pjivMastersearch.jsp');
	 		}
		     	
		  }); 
});

function ProjectInvoiceReturnPrintContent(url) {
	$('#printWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#printWindow').jqxWindow('setContent', data);
	$('#printWindow').jqxWindow('bringToFront');
}); 
} 

function refnoSearchContent(url) {
	$('#refnosearchwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#refnosearchwindow').jqxWindow('setContent', data);
	$('#refnosearchwindow').jqxWindow('bringToFront');
}); 
} 				
	
	function getrefnosearch(event){
		 var x= event.keyCode;
			if($('#mode').val()!= "view")
   		{
				 if(x==114){
				  refnoSearchContent('pjivMastersearch.jsp');   }
				 else{
					 }
   		}
		 
	} 
    
    function getPrintWindowAllowed() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#txtprintwindowallowed').val(items);
		}
		}
		x.open("GET", "getPrintWindowAllowed.jsp", true);
		x.send();
	}


function funFocus()
{
	//document.getElementById("txtcontract").focus();
		
}


function costCodeSearchContent(url) {
    $('#costCodeSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#costCodeSearchWindow').jqxWindow('setContent', data);
	$('#costCodeSearchWindow').jqxWindow('bringToFront');
}); 
}

function funReadOnly(){
	
	 $('#frmprojectinvoicereturn input').attr('readonly', true);
	 $('#frmprojectinvoicereturn input').attr('disabled', true);
	 $('#frmprojectinvoicereturn select').attr('disabled', true);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtrefdetails').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $("#expenseGrid").jqxGrid({ disabled: true}); 
	 $('#docno').attr('readonly', true);
	 $("#serviceGrid").jqxGrid({ disabled: true});
	
}

function funRemoveReadOnly(){
	 
	 $('#frmprojectinvoicereturn input').attr('readonly', false);
	 $('#frmprojectinvoicereturn input').attr('disabled', false);
	 $('#frmprojectinvoicereturn select').attr('disabled', false);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtrefdetails').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	// $('#txtsite').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#rrefno').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $("#expenseGrid").jqxGrid({ disabled: false}); 
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 
	 if ($("#mode").val() == "A") {
		 
		 $("#txtlegalamt").val(0.0);
		 $("#txtseramt").val(0.0);
		 $("#txtexptotal").val(0.0);
		 $("#txtnettotal").val(0.0);
		 
		$("#expenseGrid").jqxGrid('clear');
	    $("#expenseGrid").jqxGrid('addrow', null, {});
	    $("#serviceGrid").jqxGrid('clear');
	    $("#serviceGrid").jqxGrid('addrow', null, {});
	   }
	 
	 if ($("#mode").val() == "E") {
		 $("#expenseGrid").jqxGrid({ disabled: true}); 
		 $("#serviceGrid").jqxGrid({ disabled: false});
	 }

	
}




function funNotify(){
	var contrno=document.getElementById("txtcontract").value;
	var amount=$('#serviceGrid').jqxGrid('getcellvalue',0,'amount');
	var legalfee=$('#serviceGrid').jqxGrid('getcellvalue',0,'lfee');
	if(amount=="" || amount=="undefined" || typeof(amount)=="undefined" || amount==null){
		document.getElementById("errormsg").innerText="Amount is Mandatory";
		
		return 0;
	}
	
	if(contrno=="")
		{
		 document.getElementById("errormsg").innerText=" Select Contract No.";
		return 0;
		}
	
	  var rows = $("#serviceGrid").jqxGrid('getrows');
	  var rows1 = $("#expenseGrid").jqxGrid('getrows');
	 
	    $('#invgridlength').val(rows.length);
	    $('#expgridlength').val(rows1.length);
	    
	  for(var i=0 ; i < rows.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "inv"+i)
		       .attr("name", "inv"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].amount+"::"+rows[i].lfee+" :: ");
	
		   newTextBox.appendTo('form');
		  
		    
		   }
	  
	  
	  for(var i=0 ; i < rows1.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "exp"+i)
		       .attr("name", "exp"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prdid+" :: "+rows1[i].psrno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: ");
	
		   newTextBox.appendTo('form');
		  
		    
		   }
	
		return 1;
} 



function setValues() {
	getPrintWindowAllowed();
	
  	var docVal1 = document.getElementById("maintrno").value.trim();
  
	if(docVal1>0)
		{
   			$("#serdiv").load("serviceGrid.jsp?trno="+docVal1+"&gridload=0");
   			//$("#expdiv").load("expenseGrid.jsp?trno="+docVal1+"&gridload=0");
		}
	
	if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	}

	
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	 
	 /* if($('#contypeval').val()!="")
	  {
	  $('#cmbcontracttype').val($('#contypeval').val());
	  
	  } */
	  
	  if($('#hidnireftype').val()!="") {
	  	document.getElementById("nireftype").value=document.getElementById("hidnireftype").value;
	  }
	  
	 var ptype=document.getElementById("cmbcontracttype").value;
		
		
		if(ptype=='SINV'){
			
			document.getElementById("contrno").innerText="Cost Center";
			
		}
		else{
			document.getElementById("contrno").innerText="Contract No";
			
		}
	 
	 
}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	
	 $(function(){
	        $('#frmprojectinvoicereturn').validate({
	                rules: { 
	                	
	                	cmbcontracttype:{"required":true},
	                	
	                //	desc: {maxlength:300},
	             
	                 },
	                 messages: {
	                	 
	                	 cmbcontracttype: {required:" * Required"},
	                
	               //  desc: {maxlength:" Max 300 chars"},
	                 
	                
	              
	                 }
	        });});
	 
	 
	 function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {

				 $("#docno").prop("disabled", false);
				 $("#maintrno").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#maintrno').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		var reurl=url.split("com/"); 
		     
			 	var win= window.open(reurl[0]+"printInvoiceReturn?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     	win.focus();
				 
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	}
	 
	 function refChange(){
		
		var ptype=document.getElementById("cmbcontracttype").value;
		
		if(ptype=='SAMC'){
			document.getElementById("ptype").value=2;
		}
		else{
			document.getElementById("ptype").value=1;
		}
		
		if(ptype=='SINV'){
			document.getElementById("contypeval").value=ptype;
			document.getElementById("contrno").innerText="Cost Center";
		}
		else{
			document.getElementById("contrno").innerText="Contract No";
		}
		 
	 }
	 
</script>
</head>

<body onLoad="setValues();"><br/> 
<div id="mainBG" class="homeContent" data-type="background"> 	
<form id="frmprojectinvoicereturn" action="saveProjectinvoicereturn" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br>
<div class='hidden-scrollbar'>

<fieldset>
<table width="100%">
  <tr>
    <td width="13%" align="right">Date</td>
    <td width="16%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td align="right" width="8%" >Ref Type</td>
    <td align="left" width="10%" ><select name="nireftype" id="nireftype" style="width:99%;"  value='<s:property value="nireftype"/>' >
    <option value="PJIV" >PJIV</option></select>
    <input type="hidden" name="hidnireftype" id="hidnireftype" value='<s:property value="hidnireftype"/>'></td>
    <td align="left" width="15%" ><input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:95%;" value='<s:property value="rrefno"/>' onKeyDown="getrefnosearch(event);">
    <input type="hidden" name="rreftrno" id="rreftrno" value='<s:property value="rreftrno"/>'></td>
    <td width="7%" align="right">Ref No</td>
    <td width="21%"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td width="7%" align="right">Doc No</td>
    <td width="21%"><input type="text" name="docno" id="docno"  value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right">Contract Type</td>
    <td><input type="text" name="cmbcontracttype" id="cmbcontracttype" onchange="refChange();" onload="refChange();" onblur="refChange();" value='<s:property value="cmbcontracttype"/>'>
    <input type="hidden" name="cmbcontracttypeid" id="cmbcontracttypeid" value='<s:property value="cmbcontracttypeid"/>'></td>
    <td align="right"><label id="contrno">Contract No</label></td>
    <td colspan="5"><input type="text" name="txtrefdetails" id="txtrefdetails" value='<s:property value="txtrefdetails"/>'></td>
    <td><input type="hidden" name="txtcontract" id="txtcontract"  value='<s:property value="txtcontract"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="6"><input type="text" name="txtclient" id="txtclient"  value='<s:property value="txtclient"/>'>
    <input type="text" name="txtclientdet" style="width:58.5%;" id="txtclientdet"  value='<s:property value="txtclientdet"/>'>
    </td>
    <td>&nbsp; <input type="hidden" name="txtprintwindowallowed" id="txtprintwindowallowed" value='<s:property value="txtprintwindowallowed"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <%-- <tr>
    <td align="right">Site</td>
    <td><input type="text" name="txtsite" id="txtsite" value='<s:property value="txtsite"/>'></td>
    <td align="right">Status</td>
    <td><select name="cmbstatus" id="cmbstatus">
      <option value="">--Select--</option>
      <option value="Completed">Completed</option>
      <option value="Closed">Closed</option>
      <option value="Pending">Pending</option>
    </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> --%>
  <tr>
    <td align="right">Description</td>
    <td colspan="6"><input type="text" name="desc" style="width:75.5%;" id="desc" value='<s:property value="desc"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Notes</td>
    <td colspan="6"><input type="text" name="txtnotes" style="width:75.5%;" id="txtnotes" value='<s:property value="txtnotes"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset>
    
<fieldset><legend></legend>
<div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
</fieldset>
  
<fieldset style="border-color: #E0ECF8;">
<div id="expdiv" hidden="true"><jsp:include page="expenseGrid.jsp"></jsp:include></div>
</fieldset>
     
<input type="hidden" id="txtlegalamt" name="txtlegalamt"  value='<s:property value="txtlegalamt"/>'/>
<input type="hidden" id="txtseramt" name="txtseramt"  value='<s:property value="txtseramt"/>'/>
<input type="hidden" id="txtexptotal" name="txtexptotal"  value='<s:property value="txtexptotal"/>'/>
<input type="hidden" id="txtnettotal" name="txtnettotal"  value='<s:property value="txtnettotal"/>'/>
<input type="hidden" id="txtpjivnettotal" name="txtpjivnettotal"  value='<s:property value="txtpjivnettotal"/>'/>
<input type="hidden" id="txtpjivnetlegalamt" name="txtpjivnetlegalamt"  value='<s:property value="txtpjivnetlegalamt"/>'/>
<input type="hidden" id="txtpjivnetrettotal" name="txtpjivnetrettotal"  value='<s:property value="txtpjivnetrettotal"/>'/>
<input type="hidden" id="txtpjivnetretlegalamt" name="txtpjivnetretlegalamt"  value='<s:property value="txtpjivnetretlegalamt"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
<input type="hidden" id="costid" name="costid"  value='<s:property value="costid"/>'/>
<input type="hidden" id="clacno" name="clacno"  value='<s:property value="clacno"/>'/>
<input type="hidden" name="contypeval" id="contypeval" value='<s:property value="contypeval"/>'/>
<input type="hidden" name="pdid" id="pdid" value='<s:property value="pdid"/>'>
<input type="hidden" name="ptype" id="ptype" value='<s:property value="ptype"/>'>
<input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
<input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'/>
<input type="hidden" id="expgridlength" name="expgridlength" value='<s:property value="expgridlength"/>'/>

<input type="hidden" name="inctax" id="inctax" value='<s:property value="inctax"/>'>   

</div>

<div id="refnosearchwindow">
	<div></div>
</div>
<div id="costCodeSearchWindow">
	<div></div><div></div>
</div>
<div id="printWindow">
	<div></div>
</div>
</form>
</div>     
</body>
</html>
