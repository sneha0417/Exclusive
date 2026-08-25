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

<style>
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();

System.out.println("====masterdocno===="+request.getParameter("mastertrno"));

String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
%>

<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
	$(document).ready(function() {
		

		 $("#callRegisterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#contractDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#contractTime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
		
		 /* Searching Window */
     	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#clientDetailsWindow').jqxWindow('close');
  		 
  		 $('#contractDetailsWindow').jqxWindow({width: '30%', height: '53%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#contractDetailsWindow').jqxWindow('close');
  		 
 		 $('#siteDetailsWindow').jqxWindow({width: '25%', height: '53%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Site Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#siteDetailsWindow').jqxWindow('close');
 		 
 		 $('#callRegisterServiceGridWindow').jqxWindow({width: '30%', height: '53%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Service Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#callRegisterServiceGridWindow').jqxWindow('close');
		 
		 $('#callRegisterGridWindow').jqxWindow({width: '30%', height: '53%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Complaints Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#callRegisterGridWindow').jqxWindow('close');
		
 $('#calledbyWindow').jqxWindow({width: '25%', height: '53%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Called By Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#calledbyWindow').jqxWindow('close'); 

  		 $('#txtclientname').dblclick(function(){
  			clientSearchContent("clientDetailsSearch.jsp");
		  });
  		 
  		 $('#txtcontractno').dblclick(function(){
  			if($("#txtclientdocno").val()==''){
				 $.messager.alert('Message','Choose Client & Search.','warning');
				 if($("#txtclientdocno").val()==''){
				 	$('#txtclientname').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
  			if($("#cmbcontracttype").val()==''){
				 $.messager.alert('Message','Choose Contract Type & Search.','warning');
				 if($("#txtcontractno").val()==''){
				 	$('#txtcontractno').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
  			contractSearchContent("contractDetailsSearch.jsp");
		  });
  		
  		 $('#txtsite').dblclick(function(){
		    if($("#txtcontractno").val()==''){
				 $.messager.alert('Message','Contract No. is Mandatory.','warning');
				 if($("#txtsite").val()==''){
				 	$('#txtsite').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
  			siteSearchContent("siteDetailsSearch.jsp");
		  });

 $('#txtcontactperson').dblclick(function(){
			  if($("#txtclientdocno").val()==''){
					 $.messager.alert('Message','Choose Client & Search.','warning');
					 if($("#txtclientdocno").val()==''){
					 	$('#txtclientname').attr('placeholder', 'Press F3 to Search');
					 }
					 return 0;
				}
			
	  			calledbySearchContent("calledbyDetailsSearchGrid.jsp?cldocno="+document.getElementById("txtclientdocno").value);
			  });
  		 
	});
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
	 	$('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function siteSearchContent(url) {
	 	$('#siteDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#siteDetailsWindow').jqxWindow('setContent', data);
		$('#siteDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function calledbySearchContent(url) {
	 	$('#calledbyWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			
		$('#calledbyWindow').jqxWindow('setContent', data);
		$('#calledbyWindow').jqxWindow('bringToFront');
	}); 
	}
	function serviceSearchContent(url) {
	 	$('#callRegisterServiceGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#callRegisterServiceGridWindow').jqxWindow('setContent', data);
		$('#callRegisterServiceGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function complaintSearchContent(url) {
	 	$('#callRegisterGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#callRegisterGridWindow').jqxWindow('setContent', data);
		$('#callRegisterGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccountBalance(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  			    $('#txtaccountbalance').val(items[0]);
  		}
  		};
  		x.open("GET", "getAccountBalance.jsp?accountno="+a+'&cldocno='+b, true);
  		x.send();
 	}
	
	function getClientInfo(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent("clientDetailsSearch.jsp");
        }
        else{}
      }
	 
	 function getContractDetails(event){
        var x= event.keyCode;
        if(x==114){
        	if($("#txtclientdocno").val()==''){
				 $.messager.alert('Message','Choose Client & Search.','warning');
				 if($("#txtclientdocno").val()==''){
				 	$('#txtclientname').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
        	if($("#cmbcontracttype").val()==''){
				 $.messager.alert('Message','Choose Contract Type & Search.','warning');
				 if($("#txtcontractno").val()==''){
				 	$('#txtcontractno').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
        	contractSearchContent("contractDetailsSearch.jsp");
        }
        else{}
     }
	 
	 function getSiteDetails(event){
        var x= event.keyCode;
        if(x==114){
		    if($("#txtcontractno").val()==''){
				 $.messager.alert('Message','Contract No. is Mandatory.','warning');
				 if($("#txtsite").val()==''){
				 	$('#txtsite').attr('placeholder', 'Press F3 to Search');
				 }
				 return 0;
			}
        	siteSearchContent("siteDetailsSearch.jsp");
        }
        else{}
     }
	
function getCalledbyDetails(event){
	        var x= event.keyCode;
	        if(x==114){
	        	if($("#txtclientdocno").val()==''){
					 $.messager.alert('Message','Choose Client & Search.','warning');
					 if($("#txtclientdocno").val()==''){
					 	$('#txtclientname').attr('placeholder', 'Press F3 to Search');
					 }
					 return 0;
				}
	        	
	        	calledbySearchContent("calledbyDetailsSearchGrid.jsp?cldocno="+document.getElementById("txtclientdocno").value);
	        }
	        else{}
	     }

	 function funReadOnly(){
			$('#frmCallRegister input').attr('readonly', true );
			$('#frmCallRegister select').attr('disabled', true);
			$('#callRegisterDate').jqxDateTimeInput({disabled: true});
			$('#contractDate').jqxDateTimeInput({disabled: true});
			$('#contractTime').jqxDateTimeInput({disabled: true});
			$("#contractDetailsGridID").jqxGrid({ disabled: true});
			$("#callRegisterGridID").jqxGrid({ disabled: true});
			$("#callRegisterPendingGridID").jqxGrid({ disabled: true});
			
			if(modes=="view")
			{
			
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
			
			 $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false);
			
			document.getElementById("docno").value=mastertrno;
			document.getElementById("mode").value=modes;
			
			//alert("==document.getElementById().value==="+document.getElementById("mode").value);
			 var names = [];
			$("form").each(function() {
			  //alert(this.id);
			   names.push(this.id);
			}); 
			var form=names[0];
			   document.forms[form].submit(); 
			
			   $('#docno').attr('disabled', false);
				 $('#mode').attr('disabled', false);
			   
			}
			
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmCallRegister input').attr('readonly', false );
			$('#frmCallRegister select').attr('disabled', false);
			$('#callRegisterDate').jqxDateTimeInput({disabled: false});
			$('#contractDate').jqxDateTimeInput({disabled: false});
			$('#contractTime').jqxDateTimeInput({disabled: false});
			$("#contractDetailsGridID").jqxGrid({ disabled: false});
			$("#callRegisterGridID").jqxGrid({ disabled: false});
			$("#callRegisterPendingGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "E") {
				$('#frmCallRegister input').attr('readonly', false );
   			    $('#frmCallRegister select').attr('disabled', false);
   			    $("#callRegisterGridID").jqxGrid('addrow', null, {});
			  }
			
			if ($("#mode").val() == "A") {
				$('#callRegisterDate').val(new Date());
				$('#contractDate').val(new Date());
				$('#contractTime').val(new Date(<%=new java.util.Date().getTime()%>));
				/*var settime=new Date();
				settime.setHours(0,0,0,0);
				$('#contractTime').jqxDateTimeInput('setDate',settime);*/
				$("#contractDetailsGridID").jqxGrid('clear');
				$("#contractDetailsGridID").jqxGrid('addrow', null, {});
				$("#callRegisterGridID").jqxGrid('clear');
				$("#callRegisterGridID").jqxGrid('addrow', null, {});
				$("#callRegisterPendingGridID").jqxGrid('clear');
				$("#callRegisterPendingGridID").jqxGrid('addrow', null, {});
			}
			
			$('#docno').attr('readonly', true);
			$('#txtclientname').attr('readonly', true );
			$('#txtclientdetails').attr('readonly', true );
			$('#txtclienttele').attr('readonly', true );
			$('#txtclientmobile').attr('readonly', true );
			$('#txtclientmail').attr('readonly', true );
			$('#txtcontractno').attr('readonly', true );
			$('#txtcontractdetails').attr('readonly', true );
			$('#txtsite').attr('readonly', true );
			
	 }
	 
	 function funSearchLoad(){
		  changeContent('cregMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#callRegisterDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  $(function(){
	        $('#frmCallRegister').validate({
	                rules: {
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			
			client=document.getElementById("txtclientdocno").value;
			 if(client==""){
				 document.getElementById("errormsg").innerText="Client is Mandatory.";
				 return 0;
			 }
			 
			 contracttype=document.getElementById("cmbcontracttype").value;
			 if(contracttype==""){
				 document.getElementById("errormsg").innerText="Contract Type is Mandatory.";
				 return 0;
			 }
			 
			 contractno=document.getElementById("txtcontracttrno").value;
			 if(contractno==""){
				 document.getElementById("errormsg").innerText="Contract No. is Mandatory.";
				 return 0;
			 }
			 
			 site=document.getElementById("txtsiteid").value;
			 if(site==""){
				 document.getElementById("errormsg").innerText="Site is Mandatory.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
	        	/* Complaints Grid  Saving*/
				 var rows = $("#callRegisterGridID").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].description;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							
							var chks=rows[i].complaintid;
							if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == ""){
								 document.getElementById("errormsg").innerText="Complaint is Mandatory for Service "+rows[i].stype+".";
								 return 0;
							}
							document.getElementById("errormsg").innerText="";
							 
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    newTextBox.val(rows[i].sertypeid+":: "+rows[i].item+":: "+rows[i].complaintid+":: "+rows[i].description);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Complaints Grid  Saving Ends*/	 
	 		   
	    	return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbcontracttype").value=document.getElementById("hidcmbcontracttype").value;
		  
		  if($('#hidcallRegisterDate').val()!=""){
				 $("#callRegisterDate").jqxDateTimeInput('val', $('#hidcallRegisterDate').val());
			  } 
		  
		  if($('#hidcontractDate').val()!=""){
				 $("#contractDate").jqxDateTimeInput('val', $('#hidcontractDate').val());
			  } 
		  
		  if($('#hidcontractTime').val()!=""){
				 $("#contractTime").jqxDateTimeInput('val', $('#hidcontractTime').val());
			  } 

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  var indexVal = $('#docno').val();
		  if(indexVal>0){
	         $("#callRegisterDiv").load("callRegisterGrid.jsp?docno="+$('#txtcallregistertrno').val());
	         $("#contractDetailsDiv").load("contractDetailsGrid.jsp?docno="+indexVal+"&cldocno="+$('#txtclientdocno').val());
	         $("#callRegisterPendingDiv").load("callRegisterPendingGrid.jsp?docno="+$('#txtcallregistertrno').val()+"&contractno="+$('#txtcontracttrno').val());
	         getAccountBalance($('#txtclientacno').val(),$('#txtclientdocno').val());
		  }
			
		}
	  
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				 
				var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				var trno=$("#txtcallregistertrno").val();
				 var url=document.URL;
			     var reurl=url.split("saveCallRegister");
			     $("#docno").prop("disabled", false);
				
			     var win= window.open(reurl[0]+"printCallRegister?docno="+document.getElementById("docno").value+"&brhid="+brhid+"&trno="+trno+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
					win.focus();
			     
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  
	  function refChange(){
		  
			document.getElementById("txtcontractno").value="0";
			document.getElementById("txtcontracttrno").value="0";
			document.getElementById("txtcontractdetails").value="";
			document.getElementById("txtsite").value="";
			document.getElementById("txtsiteid").value="0";
			document.getElementById("txtdescription").value=" ";
			 
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
<form id="frmCallRegister" action="saveCallRegister" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="callRegisterDate" name="callRegisterDate" value='<s:property value="callRegisterDate"/>'></div>
    <input type="hidden" id="hidcallRegisterDate" name="hidcallRegisterDate" value='<s:property value="hidcallRegisterDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcallregisterdocno" style="width:50%;" value='<s:property value="txtcallregisterdocno"/>' tabindex="-1"/>
    <input type="hidden" id="txtcallregistertrno" name="txtcallregistertrno"  value='<s:property value="txtcallregistertrno"/>'/></td>
  </tr>
</table>

<table width="100%">
<tr><td width="65%">
<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Client Details</font></legend>
<table width="100%">
  <tr>
    <td width="10%" align="right">Client</td>
    <td width="24%"><input type="text" id="txtclientname" name="txtclientname" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>'  onkeydown="getClientInfo(event);"/>
    <input type="hidden" id="txtclientdocno" name="txtclientdocno" style="width:90%;" value='<s:property value="txtclientdocno"/>'/>
    <input type="hidden" id="txtclientacno" name="txtclientacno" style="width:90%;" value='<s:property value="txtclientacno"/>'/></td>
    <td width="15%" align="right">Client Details</td>
    <td colspan="3"><input type="text" id="txtclientdetails" name="txtclientdetails" style="width:90%;" value='<s:property value="txtclientdetails"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Tele.</td>
    <td><input type="text" id="txtclienttele" name="txtclienttele" style="width:75%;" value='<s:property value="txtclienttele"/>' tabindex="-1"/></td>
    <td align="right">Mobile</td>
    <td width="14%"><input type="text" id="txtclientmobile" name="txtclientmobile" style="width:95%;" value='<s:property value="txtclientmobile"/>' tabindex="-1"/></td>
    <td width="4%" align="right">Mail</td>
    <td width="33%"><input type="text" id="txtclientmail" name="txtclientmail" style="width:84%;" value='<s:property value="txtclientmail"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Called By</td>
    <td>
    <input type="text" id="txtcontactperson" name="txtcontactperson" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtcontactperson"/>'  onkeydown="getCalledbyDetails(event);"/>
</td>
    <td align="right">Tele.</td>
    <td><input type="text" id="txtcontactpersontele" name="txtcontactpersontele" style="width:95%;" value='<s:property value="txtcontactpersontele"/>'/></td>
    <td align="right">Mobile</td>
    <td><input type="text" id="txtcontactpersonmob" name="txtcontactpersonmob" style="width:45%;" value='<s:property value="txtcontactpersonmob"/>'/></td>
  </tr>
  <tr>
    <td align="right">Mail</td>
    <td><input type="text" id="txtcontactpersonmail" name="txtcontactpersonmail" style="width:98%;" value='<s:property value="txtcontactpersonmail"/>'/></td>
    <td align="right">Date</td>
    <td><div id="contractDate" name="contractDate" value='<s:property value="contractDate"/>'></div>
    <input type="hidden" id="hidcontractDate" name="hidcontractDate" value='<s:property value="hidcontractDate"/>'/></td>
    <td align="right">Time</td>
    <td><div id="contractTime" name="contractTime" value='<s:property value="contractTime"/>'></div>
    <input type="hidden" id="hidcontractTime" name="hidcontractTime" value='<s:property value="hidcontractTime"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="10%" align="right">Contract Type</td>
    <td width="24%"><select id="cmbcontracttype" name="cmbcontracttype" style="width:71%;" onchange="refChange();" value='<s:property value="cmbcontracttype"/>'>
      <option value=''>-- Select --</option><option value='AMC'>AMC</option><option value='SJOB'>SJOB</option></select>
      <input type="hidden" id="hidcmbcontracttype" name="hidcmbcontracttype" value='<s:property value="hidcmbcontracttype"/>'/></td>
    <td width="10%" align="right">Contract No.</td>
    <td width="17%"><input type="text" id="txtcontractno" name="txtcontractno" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtcontractno"/>'  onkeydown="getContractDetails(event);"/>
    <input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td>
    <td width="39%"><input type="text" id="txtcontractdetails" name="txtcontractdetails" style="width:85%;" value='<s:property value="txtcontractdetails"/>'  tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Site</td>
    <td><input type="text" id="txtsite" name="txtsite" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtsite"/>'  onkeydown="getSiteDetails(event);"/>
      <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:90%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="35%">
<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Account Details</font></legend>
<table width="100%">
  <tr>
    <td width="25%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Account Balance :</td>
    <td width="75%" align="left"><input type="text" class="textbox" id="txtaccountbalance" name="txtaccountbalance" style="width:30%;text-align: right;" value='<s:property value="txtaccountbalance"/>'/></td>
  </tr>
</table>
</fieldset>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Active Contract/Job Details</font></legend>
	  <div id="contractDetailsDiv"><jsp:include page="contractDetailsGrid.jsp"></jsp:include></div>
</fieldset>
</td>
</tr></table>

<table width="100%">
<tr><td width="65%">
<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Complaints</font></legend>
<div id="callRegisterDiv"><jsp:include page="callRegisterGrid.jsp"></jsp:include></div>
</fieldset></td>
<td width="35%">
<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Pending Complaints</font></legend>
<div id="callRegisterPendingDiv"><jsp:include page="callRegisterPendingGrid.jsp"></jsp:include></div>
</fieldset>
</tr></table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
</div>
</form>

<div id="clientDetailsWindow">
   <div></div>
</div>
<div id="contractDetailsWindow">
   <div></div>
</div>
<div id="siteDetailsWindow">
   <div></div>
</div>
<div id="callRegisterServiceGridWindow">
   <div></div>
</div>
<div id="callRegisterGridWindow">
   <div></div>
</div>	
<div id="calledbyWindow">
   <div></div>
</div>	
</div>
</body>
</html>
