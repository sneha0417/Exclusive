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
	  
	      $('#contractwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	      $('#contractwindow').jqxWindow('close');
	  
		  $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#costCodeSearchWindow').jqxWindow('close');
	  
		  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		 
		  $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#printWindow').jqxWindow('close');
	 
	  $('#txtrefdetails').dblclick(function(){
		  	 /*  $('#costCodeSearchWindow').jqxWindow('open');
		  	  costCodeSearchContent('contractMastersearch.jsp?', $('#costCodeSearchWindow')); */
		  	 if(document.getElementById("cmbcontracttype").value=="SINV")
		  		 {
		  		 costCodeSearchContent("costCodeSearchGrid.jsp");
		  		 }
		  	 else{
		  $('#contractwindow').jqxWindow('open');
	 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
		  	 }
	     });
	  
	  $('#txtclient').dblclick(function(){
		   
	    	 $('#clientsearch1').jqxWindow('open');
	    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
			   		
			 });
	  $('#date').on('change', function (event) {
			
		   var invdate=new Date($('#date').jqxDateTimeInput('getDate'));
		   var curdate=new Date(); 
		   invdate.setHours(0,0,0,0);
		   curdate.setHours(0,0,0,0);
		   if(invdate>curdate){
			   
			   $.messager.alert('Message','Future Date Not Allowed','warning');   
			   $('#date').jqxDateTimeInput('setDate', new Date());
			 
		   return false;
		  }
		   funDateInPeriod(invdate);
	 });
	  	  
	  
});




function getcontract(event){
 var cmb=document.getElementById("cmbcontracttype").value;
	var x= event.keyCode;
 	 if(x==114){
 		
 		// changeContent('contractMastersearch.jsp');  
 		 
 		 if(cmb=="SINV"){
 		costCodeSearchContent("costCodeSearchGrid.jsp");
 		 }
 		 else{
 			$('#contractwindow').jqxWindow('open');
 	 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
 		 }
 		 
    	 }
 	 else{
 		 
 		 }
 	 }
    	 
function contractSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#contractwindow').jqxWindow('setContent', data);
           	}); 
 	}


function ProjectInvoicePrintContent(url) {
	$('#printWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#printWindow').jqxWindow('setContent', data);
	$('#printWindow').jqxWindow('bringToFront');
}); 
} 

function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#clientsearch1').jqxWindow('setContent', data);

   	}); 
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
	
	 $('#frmprojectinvoice input').attr('readonly', true);
	 $('#frmprojectinvoice input').attr('disabled', true);
	 $('#frmprojectinvoice select').attr('disabled', true);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtrefdetails').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $("#expenseGrid").jqxGrid({ disabled: true}); 
	 $('#docno').attr('readonly', true);
	 $("#serviceGrid").jqxGrid({ disabled: true});
	
}

function funRemoveReadOnly(){
	 
	 $('#frmprojectinvoice input').attr('readonly', false);
	 $('#frmprojectinvoice input').attr('disabled', false);
	 $('#frmprojectinvoice select').attr('disabled', false);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtrefdetails').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	// $('#txtsite').attr('readonly', true);
	 $('#docno').attr('readonly', true);
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
		 $("#serviceGrid").jqxGrid({ disabled: true});
	 }

	
}




function funNotify(){
		
		   var invdate=new Date($('#date').jqxDateTimeInput('getDate'));
		   var curdate=new Date(); 
		   invdate.setHours(0,0,0,0);
		   curdate.setHours(0,0,0,0);
		   if(invdate>curdate){
			   document.getElementById("errormsg").innerText="Future Date Not Allowed";
			   return 0;
		   }   
		   funDateInPeriod(invdate);
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
   $("#serdiv").load("serviceGrid.jsp?pjinvtrno="+docVal1);
   $("#expdiv").load("expenseGrid.jsp?trno="+docVal1+"&gridload=0");
		}
	if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }

	
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	 
	 if($('#contypeval').val()!="")
	  {
	  $('#cmbcontracttype').val($('#contypeval').val());
	  
	  }
	 
	 var ptype=document.getElementById("cmbcontracttype").value;
		
		
		if(ptype=='SINV'){
			
			document.getElementById("contrno").innerText="Cost Center";
			
		}
		else{
			document.getElementById("contrno").innerText="Contract No";
			
		}
	 
	    if(parseInt($('#txtpjivreturned').val())>0) {
			$('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		}
	 
}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	 $(function(){
	        $('#frmprojectinvoice').validate({
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
		     
		  		if (parseInt($("#txtprintwindowallowed").val())==1) {
		  			ProjectInvoicePrintContent('printVoucherWindow.jsp');
				} else if (parseInt($("#txtprintwindowallowed").val())==2) {
		  			ProjectInvoicePrintContent('hvlprintVoucherWindow.jsp');
				} else {
				 	var win= window.open(reurl[0]+"printInvoice?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&bankdocno=0&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			     	win.focus();
				}
		  	/* 	var win= window.open(reurl[0]+"printInvoicejasper?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			    win.focus();	 */ 
		
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
			 $("#txtclient").attr("placeholder", "press F3 for Search");
		}
		else{
			document.getElementById("contrno").innerText="Contract No";
			 $("#txtclient").attr("placeholder", " ");
		}
		 
	 }
	 
</script>
</head>

<body onLoad="setValues();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmprojectinvoice" action="saveProjectinvoice" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
        <br>
		<div class='hidden-scrollbar'>

<body>
<fieldset>
<table width="100%">
  <tr>
    <td align="right">Date</td>
    <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td align="right">Ref No</td>
    <td><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td align="right">Doc No</td>
    <td><input type="text" name="docno" id="docno"  value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right">Contract Type</td>
    <td><select name="cmbcontracttype" id="cmbcontracttype" value='<s:property value="cmbcontracttype"/>' onchange="refChange();">
    <option value="">--Select--</option>
    <option value="SAMC">Service-AMC</option>
    <option value="AMC">AMC</option>
    <option value="SJOB">SJOB</option>
    <option value="SINV">SINV</option>
    </select>
    </td>
    <td align="right"><label id="contrno">Contract No</label></td>
    <td><input type="text" name="txtrefdetails" id="txtrefdetails" placeholder="Press F3 To Search"   onKeyDown="getcontract(event);"  value='<s:property value="txtrefdetails"/>'></td>
    <td><input type="hidden" name="txtcontract" id="txtcontract" placeholder="Press F3 To Search"  onKeyDown="getcontract(event);"  value='<s:property value="txtcontract"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="3"><input type="text" name="txtclient" id="txtclient"  onKeyDown="getclinfo(event);" value='<s:property value="txtclient"/>'>
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
    <td colspan="3"><input type="text" name="desc" style="width:75.5%;" id="desc" value='<s:property value="desc"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Notes</td>
    <td colspan="3"><input type="text" name="txtnotes" style="width:75.5%;" id="txtnotes" value='<s:property value="txtnotes"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
 </tr> 
</fieldset>
<tr>
    <td>
    <fieldset><legend></legend>
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
   </tr>
   
   <tr>
    <td>
    <fieldset> <legend>other expenses to be invoiced</legend>
    <div id="expdiv"><jsp:include page="expenseGrid.jsp"></jsp:include></div>
     </fieldset></td>
   </tr>
 <tr>
 <td>
  <input type="hidden" id="txtlegalamt" name="txtlegalamt"  value='<s:property value="txtlegalamt"/>'/>
   <input type="hidden" id="txtseramt" name="txtseramt"  value='<s:property value="txtseramt"/>'/>
    <input type="hidden" id="txtexptotal" name="txtexptotal"  value='<s:property value="txtexptotal"/>'/>
     <input type="hidden" id="txtnettotal" name="txtnettotal"  value='<s:property value="txtnettotal"/>'/>
     
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
	<input type="hidden" id="txtpjivreturned" name="txtpjivreturned"  value='<s:property value="txtpjivreturned"/>'/> 
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="costid" name="costid"  value='<s:property value="costid"/>'/>
     <input type="hidden" id="clacno" name="clacno"  value='<s:property value="clacno"/>'/>
     <input type="hidden" name="contypeval" id="contypeval" value='<s:property value="contypeval"/>'/>
      <input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
      <%--   <input type="hidden" name="searchtrno" id="searchtrno" value='<s:property value="searchtrno"/>'/> --%>
     <input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'/>
     <input type="hidden" id="expgridlength" name="expgridlength" value='<s:property value="expgridlength"/>'/>
     <input type="hidden" name="pdid" id="pdid" value='<s:property value="pdid"/>'>
     <input type="hidden" name="ptype" id="ptype" value='<s:property value="ptype"/>'>
     <input type="hidden" name="inctax" id="inctax" value='<s:property value="inctax"/>'>
    
     
    </td>
   </tr>

</div>
<div id="contractwindow">
   <div ></div>
</div>
<div id="costCodeSearchWindow">
	<div></div><div></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 
<div id="printWindow">
	<div></div>
</div>
</form>
</div>     
</body>
</html>
