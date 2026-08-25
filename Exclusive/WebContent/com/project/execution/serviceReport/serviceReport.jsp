<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%
 String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
 System.out.println("mastertrno"+mastertrno);
 String mod =request.getParameter("mod")==null?"view":request.getParameter("mod").toString();
 String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
 String ctype=request.getParameter("ctype")==null?"0":request.getParameter("ctype").toString();
 String cno=request.getParameter("cno")==null?"0":request.getParameter("cno").toString();
String site=request.getParameter("site")==null?"0":request.getParameter("site").toString();
String area=request.getParameter("area")==null?"0":request.getParameter("area").toString();
String scheduleno=request.getParameter("scheduleno")==null?"0":request.getParameter("scheduleno").toString();
String cldocno2=request.getParameter("cldocno2")==null?"":request.getParameter("cldocno2").toString();
String clacno=request.getParameter("clacno")==null?"":request.getParameter("clacno").toString();
String claddress2=request.getParameter("claddress2")==null?"":request.getParameter("claddress2").toString();
String conttrno=request.getParameter("conttrno")==null?"":request.getParameter("conttrno").toString();
String contdet=request.getParameter("contdet")==null?"":request.getParameter("contdet").toString();
String siteid=request.getParameter("siteid")==null?"":request.getParameter("siteid").toString();
String areaid=request.getParameter("areaid")==null?"":request.getParameter("areaid").toString();
String serdocno=request.getParameter("serdocno")==null?"":request.getParameter("serdocno").toString();
String cregtrno=request.getParameter("cregtrno")==null?"":request.getParameter("cregtrno").toString();
String cregdoc=request.getParameter("cregdoc")==null?"":request.getParameter("cregdoc").toString();
//String maintrno=request.getParameter("maintrno")==null?"":request.getParameter("maintrno").toString();

//view from report
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();

String reportdocno =request.getParameter("reportdocno")==null?"0":request.getParameter("reportdocno").toString();

%>

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

<script type="text/javascript">
var mod1='<%=mod%>';
var modes='<%=modes%>';
var reportdocno='<%=reportdocno%>';
	$(document).ready(function() {
		
		
		   
		   $("#serviceReportDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		
		   $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Customer Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		   $('#customerDetailsWindow').jqxWindow('close');
  		 
		   $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		   $('#contractDetailsWindow').jqxWindow('close');

		   $('#activityGridWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Activity Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		   $('#activityGridWindow').jqxWindow('close');
		   
		   $('#sidesearchwndow').jqxWindow({ width: '55%', height: '92%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
		   $('#sidesearchwndow').jqxWindow('close'); 
		   
		   $('#workstatuswindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '68%' ,maxWidth: '30%' ,title: 'Work status ' , position: { x: 260, y: 87 } ,theme: 'energyblue', keyboardCloseKey: 27});
		   $('#workstatuswindow').jqxWindow('close');
		   
		   
		   $('#ServiceTypeWindow').jqxWindow({width: '30%', height: '53%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Service Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
			 $('#ServiceTypeWindow').jqxWindow('close');
		   
		   $('#txtcustomer').dblclick(function(){
	  			customerSearchContent("customerDetailsSearch.jsp");
		   });
		   
		   $('#txtcontractno').dblclick(function(){
			   if($("#mode").val() == "A" || $("#mode").val() == "E") {
				   if($("#txtcustomerdocno").val()==''){
						 $.messager.alert('Message','Customer is Mandatory.','warning');
						 if($("#txtcustomerdocno").val()==''){
						 	$('#txtcustomer').attr('placeholder', 'Press F3 to Search');
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
				   contractSearchContent("contractDetailsSearch.jsp?docno="+document.getElementById("cmbcontracttype").value);
			   }
		   });
		   
	});
	
	function customerSearchContent(url) {
	 	$('#customerDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#customerDetailsWindow').jqxWindow('setContent', data);
		$('#customerDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
		$('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function activitySearchContent(url) {
		$('#activityGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#activityGridWindow').jqxWindow('setContent', data);
		$('#activityGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function productSearchContent(url) {
        $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
	  }); 
	  }
	
	 function serviceSearchContent(url) {
		 	$('#ServiceTypeWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#ServiceTypeWindow').jqxWindow('setContent', data);
			$('#ServiceTypeWindow').jqxWindow('bringToFront');
		}); 
		}
	 
	function getCustomerInfo(event){
        var x= event.keyCode;
        if(x==114){
        	customerSearchContent("customerDetailsSearch.jsp");
        }
        else{}
    }
	
	function getContractDetails(event){
		
        var x= event.keyCode;
        if(x==114){
	        	if($("#txtcustomerdocno").val()==''){
					 $.messager.alert('Message','Customer is Mandatory.','warning');
					 if($("#txtcustomerdocno").val()==''){
					 	$('#txtcustomer').attr('placeholder', 'Press F3 to Search');
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
	           
			   contractSearchContent("contractDetailsSearch.jsp?docno="+document.getElementById("cmbcontracttype").value);
        } else{ }
        }
	
	 function clearContractInfo(){
		 $("#txtcontractno").val('');$("#txtcontractdetails").val('');$("#txtcontracttrno").val('');$("#txtsitename").val('');$("#txtsiteid").val('');
		 $("#txtareaname").val('');$("#txtareaid").val('');$("#txtscheduleno").val('');
		 
		 if($("#txtcontractno").val()==''){
			 	$('#txtcontractno').attr('placeholder', 'Press F3 to Search');
		 }
		 $("#hidcmbcontracttype").val(document.getElementById("cmbcontracttype").value);
		 
		 $("#activityDetailsGridID").jqxGrid('clear');
		 $("#activityDetailsGridID").jqxGrid('addrow', null, {});
			
	 }
	  function funsetmod()
	 {
		 mod1="view";
	 } 
	
	 function funReadOnly(){
			$('#frmServiceReport input').attr('readonly', true );
			$('#frmServiceReport select').attr('disabled', true);  
			$('#serviceReportDate').jqxDateTimeInput({disabled: true});
			$("#activityDetailsGridID").jqxGrid({ disabled: true});
			$("#materialDetailsGridID").jqxGrid({ disabled: true});
			$('#textrect').attr('readonly', true);
			$('#btnwork').attr('disabled', true);
			 if(document.getElementById("status").value.trim()=="0" )
				{
				mod1="view";
				}
			if(mod1=="A")
				{
				
				 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();
				}
			
			if(modes=="view")
			{
			
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
			
			 $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false);
			
			document.getElementById("docno").value=reportdocno;
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
			$('#frmServiceReport input').attr('readonly', false );
			$('#frmServiceReport select').attr('disabled', false);
			$('#serviceReportDate').jqxDateTimeInput({disabled: false});
			$("#activityDetailsGridID").jqxGrid({ disabled: false});
			$("#materialDetailsGridID").jqxGrid({ disabled: false});
			$('#textrect').attr('readonly', true);
			
			var chk_rect_val= $('#chkrect').val();
			if(chk_rect_val>0){
            	document.getElementById("chkrectification").checked=true;
            	rectification();
			}
            
			if ($("#mode").val() == "E") {
				$('#btnwork').attr('disabled', false);
				$('#frmServiceReport input').attr('readonly', false );
   			    $('#frmServiceReport select').attr('disabled', false);
   			    $("#materialDetailsGridID").jqxGrid('addrow', null, {});
   			 
   			    //$("#activityDiv").load("activityDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val()+"&contractno="+$('#txtcontracttrno').val()+"&mode="+$('#mode').val());
   			      //$("#activityDiv").load("activityDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val());
			  }
			
			if ($("#mode").val() == "A") {
				$('#serviceReportDate').val(new Date());
				
				$("#activityDetailsGridID").jqxGrid('clear');
				$("#activityDetailsGridID").jqxGrid('addrow', null, {});
				$("#materialDetailsGridID").jqxGrid('clear');
				$("#materialDetailsGridID").jqxGrid('addrow', null, {});
				$('#btnwork').attr('disabled', false);
			}
			
			<%-- var mod1='<%=mod%>'; --%>
			var contrno='<%=conttrno%>';
			
			
			if(mod1=="A")
				{
				var cregdoc='<%=cregdoc%>';
				var serdocno='<%=serdocno%>';
				var cregtrno='<%=cregtrno%>';
				var ctype='<%=ctype%>';
				 if(ctype=="CREG")
				{
					document.getElementById("txtcontractno").value='<%=cno%>';
					document.getElementById("txtcontracttrno").value='<%=cregtrno%>';
				}
			else
				{
				document.getElementById("txtcontractno").value='<%=cregdoc%>';
				document.getElementById("txtcontracttrno").value='<%=cregtrno%>';
				}
				 document.getElementById("hidserviceReportDate").value="";
				document.getElementById("txtcustomer").value='<%=client%>';
				document.getElementById("hidcmbcontracttype").value='<%=ctype%>';
			
				document.getElementById("txtsitename").value='<%=site%>';
				document.getElementById("txtareaname").value='<%=area%>';
				document.getElementById("txtscheduleno").value='<%=scheduleno%>';
				document.getElementById("txtcustomerdocno").value='<%=cldocno2%>';
				document.getElementById("txtcustomeracno").value='<%=clacno%>';
				document.getElementById("txtcustomerdetails").value='<%=claddress2%>';
				
				document.getElementById("txtcontractdetails").value='<%=contdet%>';
				document.getElementById("txtsiteid").value='<%=siteid%>';
				document.getElementById("txtareaid").value='<%=areaid%>';
				
				if(contrno>0)
					{
					if(ctype=="CREG")
						{
						 $("#activityDiv").load("activityDetailsGrid.jsp?contractno="+cregtrno+"&serdocno="+serdocno+"&dtype="+ctype);	
						}
					else
						{
						 $("#activityDiv").load("activityDetailsGrid.jsp?contractno="+contrno+"&serdocno="+serdocno+"&dtype="+ctype);
						}
					}
				
				
				}
			
			$('#docno').attr('readonly', true);
			$('#txtcustomer').attr('readonly', true );
			$('#txtcustomerdetails').attr('readonly', true );
			$('#txtcontractno').attr('readonly', true );
			$('#txtcontractdetails').attr('readonly', true );
			$('#txtsitename').attr('readonly', true );
			$('#txtareaname').attr('readonly', true );
			$('#txtscheduleno').attr('readonly', true );
			
	 }
	 
	 function funSearchLoad(){
		changeContent('srveMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#serviceReportDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  $(function(){
	        $('#frmServiceReport').validate({
	                rules: {
	                txtcompletionperc:{"required":true,number:true}
	                 },
	                 messages: {
	                 txtcompletionperc:{required:" *",number:"Invalid"}
	                 }
	        });}); 
	   
	  function funNotify(){	
	        	 customer=document.getElementById("txtcustomerdocno").value;
				 if(customer==""){
					 document.getElementById("errormsg").innerText="Customer is Mandatory.";
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
				 
				 scheduleno=document.getElementById("txtscheduleno").value;
				 if(scheduleno==""){
					 document.getElementById("errormsg").innerText="Schedule No is Mandatory.";
					 return 0;
				 }
				 var chkrectid=document.getElementById("chkrect").value;
				 var rectdes=document.getElementById("textrect").value;
				
				 if(chkrectid=="1" && rectdes==""){
					 document.getElementById("errormsg").innerText="Rectification Description is Mandatory.";
					 return 0;
				 }
				 document.getElementById("errormsg").innerText="";
				 
		        	/* Activity Grid  Saving*/
					 var rows = $("#activityDetailsGridID").jqxGrid('getrows');
		        	
					 var length=0;
						 for(var i=0 ; i < rows.length ; i++){

							
							var chk=rows[i].description;
							var sert=rows[i].sertypeid;
							if(typeof(sert) != "undefined" && typeof(sert) != "NaN" && sert != ""){
							/* if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){ */
								
								var chks=rows[i].numbers;
								if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == "" || chks =="0"){
									 document.getElementById("errormsg").innerText="Nos is Mandatory for Service "+rows[i].stype+".";
									 return 0;
								}
								
								document.getElementById("errormsg").innerText="";
								
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "test"+length)
							    .attr("name", "test"+length)
								.attr("hidden", "true");
								length=length+1;
								
					    newTextBox.val(rows[i].sertypeid+":: "+rows[i].item+":: "+rows[i].numbers+":: "+rows[i].activityid+":: "+rows[i].description);
						newTextBox.appendTo('form');
							}
						/*  } */
						}
						
			 		 $('#activitygridlength').val(length);
		 		   /* Activity Grid  Saving Ends*/	 
		 		   
			 		/* To Be Invoiced Grid  Saving*/
					 var rows = $("#materialDetailsGridID").jqxGrid('getrows');
					 var length=0;
						 for(var i=0 ; i < rows.length ; i++){
							var chk=rows[i].total;
							if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){

								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "tests"+length)
							    .attr("name", "tests"+length)
								.attr("hidden", "true");
								length=length+1;
								
					    newTextBox.val(rows[i].desc1+":: "+rows[i].prodoc+":: "+rows[i].psrno+":: "+rows[i].unitdocno+":: "+rows[i].specid+":: "+rows[i].qty+":: "+rows[i].amount+":: "+rows[i].total+":: "+rows[i].invoiced);
						newTextBox.appendTo('form');
						 }
						}
			 		 $('#tobeinvoicedgridlength').val(length);
		 		   /* To Be Invoiced Grid  Saving Ends*/	 
		 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $("#materialDetailsGridID").jqxGrid('clear');
			$("#materialDetailsGridID").jqxGrid('addrow', null, {});
		  
		  document.getElementById("cmbcontracttype").value=document.getElementById("hidcmbcontracttype").value;
		  
		  if($('#hidserviceReportDate').val()){
				 $("#serviceReportDate").jqxDateTimeInput('val', $('#hidserviceReportDate').val());
			  } 
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  var indexVal = $('#docno').val();
		  if(indexVal>0){
	         $("#activityDiv").load("activityDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val());
	         $("#materialDiv").load("materialDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val());
		  }
		  var chk_rect_val= $('#chkrect').val();
			if(chk_rect_val>0){
          	document.getElementById("chkrectification").checked=true;
          	rectification();
			}
		}
	  
	  function funPrintBtn() {
				
		  var dtype=document.getElementById("hidcmbcontracttype").value;
		 
		  
			if (($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="AMC") {
				
				 var url=document.URL;
			     var reurl=url.split("saveServiceReport");
			     var branch=<%=session.getAttribute("BRANCHID").toString()%>;
			     var trno=document.getElementById("txtservicereporttrno").value;
			    // alert(trno);
			     $("#docno").prop("disabled", false);
					
			     var win= window.open(reurl[0]+"printServiceReportAMC?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();  
			     
		     }
		    else if(($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="SJOB")
		    {
		    	 var url=document.URL;
			     var reurl=url.split("saveServiceReport");
			     var branch=<%=session.getAttribute("BRANCHID").toString()%>;
			     var trno=document.getElementById("txtservicereporttrno").value;
			    // alert(trno);
			     $("#docno").prop("disabled", false);
					
			     var win= window.open(reurl[0]+"printServiceReportSJOB?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();  
			}
		    else if(($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="CREG")
		    	{
		    	var url=document.URL;
			     var reurl=url.split("saveServiceReport");
			     var branch=<%=session.getAttribute("BRANCHID").toString()%>;
			     var trno=document.getElementById("txtservicereporttrno").value;
			    // alert(trno);
			     $("#docno").prop("disabled", false);
					
			     var win= window.open(reurl[0]+"printServiceReportCREG?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus(); 
		    	}
		    else {
				$.messager.alert('Message','Please Select a Client.','warning');
				return;
			}
	    }
	 
	  function rectification(){
			 if(document.getElementById("chkrectification").checked){
				 
				 $('#textrect').attr('readonly', false);
				 $('#chkrect').val("1");
			 }
			 else{
				 $('#textrect').attr('readonly', true);
				 $('#textrect').val("");
				 $('#chkrect').val("0");
			 }
			 
			}
	  function gettobeinvconfig(){
			$("#tobeinv").hide();
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 	var res= x.responseText;
						 
					 	if(res>0){
					 		$("#tobeinv").show();
							  }
						}
				       else
					  {}
			     }
			      x.open("GET",'gridHideconfig.jsp',true);
			     x.send();
			    
			   }
	  function funWorkstatus()
	  {
		 
		  $('#workstatuswindow').jqxWindow('open');
	      wrkStatusContent('workstatus.jsp?trno='+$('#txtservicereporttrno').val());  
	  }
	  function wrkStatusContent(url) {
			//alert(url);
				 $.get(url).done(function (data) {
					 //alert(data);
			$('#workstatuswindow').jqxWindow('setContent', data);

			          	}); 
				}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();gettobeinvconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmServiceReport" action="saveServiceReport" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="serviceReportDate" name="serviceReportDate" value='<s:property value="serviceReportDate"/>'></div>
    <input type="hidden" id="hidserviceReportDate" name="hidserviceReportDate" value='<s:property value="hidserviceReportDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtservicereportdocno" style="width:50%;" value='<s:property value="txtservicereportdocno"/>' tabindex="-1"/>
    <input type="hidden" id="txtservicereporttrno" name="txtservicereporttrno" style="width:50%;" value='<s:property value="txtservicereporttrno"/>'/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Customer</td>
    <td colspan="2"><input type="text" id="txtcustomer" name="txtcustomer" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtcustomer"/>'  onkeydown="getCustomerInfo(event);"/>
    <input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno" value='<s:property value="txtcustomerdocno"/>'/>
   <input type="hidden" id="txtcustomeracno" name="txtcustomeracno" value='<s:property value="txtcustomeracno"/>'/></td>
    <td colspan="5"><input type="text" id="txtcustomerdetails" name="txtcustomerdetails" style="width:98%;" value='<s:property value="txtcustomerdetails"/>' tabindex="-1"/>
    <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>' />   
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' /></td>
  </tr>
  <tr>
    <td align="right">Contract Type</td>
    <td width="14%"><select id="cmbcontracttype" name="cmbcontracttype" style="width:97%;" onchange="clearContractInfo();" value='<s:property value="cmbcontracttype"/>'>
      <option value=''>--Select--</option><option value='AMC'>AMC</option><option value='SJOB'>SJOB</option><option value='CREG'>Ticket No</option></select>
     <input type="hidden" id="hidcmbcontracttype" name="hidcmbcontracttype" value='<s:property value="hidcmbcontracttype"/>'/></td>
    <td width="12%" align="right">Contract No.</td>
    <td width="17%"><input type="text" id="txtcontractno" name="txtcontractno" style="width:98%;" placeholder="Press F3 to Search" value='<s:property value="txtcontractno"/>'  onkeydown="getContractDetails(event);"/>
    <input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td>
    <td width="10%" align="right">Contract Details</td>
    <td colspan="3"><input type="text" id="txtcontractdetails" name="txtcontractdetails" style="width:97%;" value='<s:property value="txtcontractdetails"/>'  tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Site</td>
    <td><input type="text" id="txtsitename" name="txtsitename" style="width:97%;" value='<s:property value="txtsitename"/>' tabindex="-1"/>
    <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/></td>
    <td align="right">Area</td>
    <td><input type="text" id="txtareaname" name="txtareaname" style="width:97%;" value='<s:property value="txtareaname"/>' tabindex="-1"/>
    <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/></td>
    <td align="right">Schedule No.</td>
    <td width="21%"><input type="text" id="txtscheduleno" name="txtscheduleno" style="width:85%;" value='<s:property value="txtscheduleno"/>' tabindex="-1"/></td>
    <td width="6%" align="right">Completion %</td>
    <td width="14%"><input type="text" id="txtcompletionperc" name="txtcompletionperc" style="width:90%;" value='<s:property value="txtcompletionperc"/>'/>
    </td>
  </tr>
  <tr>
    <td align="right"><input type="checkbox" name="chkrectification" id="chkrectification"  onchange="rectification();">
      <label for="chklegaldoc">Rectification</label>
      <input type="hidden" id="chkrect" name="chkrect"  value='<s:property value="chkrect"/>'/></td>
    <td colspan="3"><input type="text" id="textrect" name="textrect" style="width:85%;"value='<s:property value="textrect"/>'/> </td>
  <td align="center"><button class="myButton" type="button" id="btnwork" name="btnwork" onclick="funWorkstatus();">Work status</button></td> </tr>
  </table>
</fieldset>

<fieldset><legend>Activity Details</legend>
<div id="activityDiv"><jsp:include page="activityDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<fieldset id="tobeinv"><legend>To be Invoiced</legend>
<div id="materialDiv"><jsp:include page="materialDetailsGrid.jsp"></jsp:include></div>
<input type="hidden" id="txttobeinvoicednettotal" name="txttobeinvoicednettotal"  value='<s:property value="txttobeinvoicednettotal"/>'/>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="activitygridlength" name="activitygridlength"  value='<s:property value="activitygridlength"/>'/>
<input type="hidden" id="tobeinvoicedgridlength" name="tobeinvoicedgridlength"  value='<s:property value="tobeinvoicedgridlength"/>'/>

</div>
</form>
	
<div id="customerDetailsWindow">
   <div></div>
</div>
<div id="contractDetailsWindow">
   <div ></div>
</div>
<div id="activityGridWindow">
   <div ></div>
</div>
<div id="sidesearchwndow">
    <div ></div>
 </div>
 <div id="workstatuswindow">
   <div ></div>
</div>
<div id="ServiceTypeWindow">
   <div></div>
</div>
</div>
</body>
</html>
