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
	  
	  
	  $('#txtcontract').dblclick(function(){
	  	    $('#contractwindow').jqxWindow('open');
	   
	  	//  contractSearchContent('contractMastersearch.jsp');
	  	  contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
     });
	  	  
});




function getcontract(event){

	var x= event.keyCode;
 	 if(x==114){
 		 $('#contractwindow').jqxWindow('open');
 		// changeContent('contractMastersearch.jsp');  
 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
    	 }
 	 else{
 		 
 		 }
 	 }
    	 
function contractSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#contractwindow').jqxWindow('setContent', data);
           	}); 
 	}


function funFocus()
{
	//document.getElementById("txtcontract").focus();
		
}

function funReadOnly(){
	
	 $('#frmprojectproinvoice input').attr('readonly', true);
	 $('#frmprojectproinvoice input').attr('disabled', true);
	 $('#frmprojectproinvoice select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	// $("#expenseGrid").jqxGrid({ disabled: true}); 
	 $('#docno').attr('readonly', true);
	 $("#serviceGrid").jqxGrid({ disabled: true});
	
}

function funRemoveReadOnly(){
	
	 $('#frmprojectproinvoice input').attr('readonly', false);
	 $('#frmprojectproinvoice input').attr('disabled', false);
	 $('#frmprojectproinvoice select').attr('disabled', false);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	// $('#txtsite').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: false});
	// $("#expenseGrid").jqxGrid({ disabled: false}); 
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 if ($("#mode").val() == "A") {
			
		
	    /*  $("#expenseGrid").jqxGrid('clear');
	    $("#expenseGrid").jqxGrid('addrow', null, {}); */
	    
 	     $("#txtlegalamt").val(0.0);
		 $("#txtseramt").val(0.0);
		 $("#txtnettotal").val(0.0);
		 
	    $("#serviceGrid").jqxGrid('clear');
	    $("#serviceGrid").jqxGrid('addrow', null, {});
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
	 
	    $('#invgridlength').val(rows.length);
	  for(var i=0 ; i < rows.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "prjinvtest"+i)
		       .attr("name", "prjinvtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].amount+"::"+rows[i].lfee+" :: ");
	
		   newTextBox.appendTo('form');
		  
		    
		   }    
	
		return 1;
} 

function funclear()
{
		document.getElementById("txtcontract").value="";
		document.getElementById("txtclient").value="";
		document.getElementById("txtclientdet").value="";
	

}

function setValues() {
	
  var docVal1 = document.getElementById("maintrno").value.trim();
  
	if(docVal1>0)
		{
	 var indexVal2 = document.getElementById("maintrno").value.trim();
   $("#serdiv").load("serviceGrid.jsp?pjinvtrno="+indexVal2);
		}
	if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }

	
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	 
	 if($('#contypeval').val()!="")
	  {
	  $('#cmbcontracttype').val($('#contypeval').val());
	  }
	 
	 
}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	 $(function(){
	        $('#frmprojectproinvoice').validate({
	                rules: { 
	                	refno:{"required":true},
	                	cmbcontracttype:{"required":true},
	                	desc:{"required":true,maxlength:300},
	                //	desc: {maxlength:300},
	             
	                 },
	                 messages: {
	                	 refno: {required:" * Required"},
	                	 cmbcontracttype: {required:" * Required"},
	                 desc: {required:" * Required",maxlength:" Max 300 chars"},
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
		  		var costid=$('#costid').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		var reurl=url.split("com/"); 
		     
				var win= window.open(reurl[0]+"printProforma?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&costid="+costid+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			    win.focus();
					 
		
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
  }
	 
	 
</script>
</head>

<body onLoad="setValues();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmprojectproinvoice" action="saveProjectProinvoice" method="post" autocomplete="off">
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
    <td><select name="cmbcontracttype" id="cmbcontracttype" onchange="funclear();">
    <option value="">--Select--</option>
    <option value="AMC">AMC</option>
    <option value="SJOB">SJOB</option>
    </select>
    </td>
    <td align="right">Contract No</td>
    <td><input type="text" name="txtcontract" id="txtcontract" placeholder="Press F3 To Search"  onKeyDown="getcontract(event);"  value='<s:property value="txtcontract"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="3"><input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>'>
    <input type="text" name="txtclientdet" style="width:58.5%;" id="txtclientdet"  value='<s:property value="txtclientdet"/>'>
    </td>
    <td>&nbsp;</td>
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
</table>
 </tr> 
</fieldset>
<tr>
    <td>
    <fieldset><legend>Proforma Invoice Details</legend>
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
   </tr>
   
  <%--  <tr>
    <td>
    <fieldset><!-- <legend>other expenses to be invoiced</legend> -->
    <div hidden="true" id="expdiv"><jsp:include page="expenseGrid.jsp"></jsp:include></div>
     </fieldset></td>
   </tr> --%>
 <tr>
 <td>
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="costid" name="costid"  value='<s:property value="costid"/>'/>
    <input type="hidden" id="clacno" name="clacno"  value='<s:property value="clacno"/>'/>
    <input type="hidden" name="contypeval" id="contypeval" value='<s:property value="cmbcontracttype"/>'/>
    <input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
      <%--   <input type="hidden" name="searchtrno" id="searchtrno" value='<s:property value="searchtrno"/>'/> --%>
     <input type="hidden" id="invgridlength" name="invgridlength" />
     
     <input type="hidden" id="txtlegalamt" name="txtlegalamt"  value='<s:property value="txtlegalamt"/>'/>
     <input type="hidden" id="txtseramt" name="txtseramt"  value='<s:property value="txtseramt"/>'/>
     <input type="hidden" id="txtnettotal" name="txtnettotal"  value='<s:property value="txtnettotal"/>'/>
    </td>
   </tr>

</div>
<div id="contractwindow">
   <div ></div>
</div>
</form>
</div>     
</body>
</html>
