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
String mod = request.getParameter("mod") == null ? "view" : request
		.getParameter("mod").toString();
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();

String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();

String pertel=request.getParameter("pertel")==null?"0":request.getParameter("pertel").toString();
String per_mob=request.getParameter("per_mob")==null?"0":request.getParameter("per_mob").toString();
String mail1=request.getParameter("mail1")==null?"0":request.getParameter("mail1").toString();
String salname=request.getParameter("salname")==null?"0":request.getParameter("salname").toString();
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid").toString();


%>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mod1='<%=mod%>';
var mastertrno='<%=mastertrno%>';

	$(document).ready(function() {
		
	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
      $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch1').jqxWindow('close');
	  $('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#cpinfowindow').jqxWindow('close');
	  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#areainfowindow').jqxWindow('close');
	  $('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#siteinfowindow').jqxWindow('close');
	  $('#grpinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#grpinfowindow').jqxWindow('close');
	  $('#teaminfowindow').jqxWindow({ width: '30%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#teaminfowindow').jqxWindow('close');
	  $('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#sertypefowindow').jqxWindow('close');
	  $('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
			x : 420,
			y : 87
		}, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');
	     $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
	    $('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#enquirywindow').jqxWindow('close'); 
		$('#unitsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Unit Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#unitsearchwindow').jqxWindow('close');
		
		 //refChange();
	 
	  $('#txtclient').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   	 $('#clientsearch1').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
		   		}
		 });
	  
	  
	  $('#txtcontact').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   		var clientid=document.getElementById("clientid").value;
		  		
		  		if(clientid==""){
		  			document.getElementById("errormsg").innerText=" Select Client";
		  			return 0;
		  		}
		  		
		  	 	  $('#cpinfowindow').jqxWindow('open');
		  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid); 
		   		}
		 });
	  
	  $('#txtenquiry').dblclick(function(){
	 		 
			var clientid=document.getElementById("clientid").value;
		 	
		 	if(clientid>0){
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		 	else{
		 		document.getElementById("errormsg").innerText="Select a client";
		 		
		 		return 0;
		 	} 
	 		 
	 		if($('#mode').val()!= "view")
	   		{
	 		 changeContent('enqMastersearch.jsp'); 
	   		}
	 		  });
  		 
	});
	
	function getareas(rowBoundIndex){
		 
		  $('#areainfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	     	 
	function areaSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#areainfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	
	function unitSearchContent(url) {
		$('#unitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#unitsearchwindow').jqxWindow('setContent', data);
			$('#unitsearchwindow').jqxWindow('bringToFront');
		});
	}
	  	
	  	
	function getsite(rowBoundIndex){
		 
		  $('#siteinfowindow').jqxWindow('open');

	// $('#accountWindow').jqxWindow('focus');
	      siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex);
	   	 }
	   	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#siteinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
	  	
	  	
	  	
	function getgrpcode(rowBoundIndex){
		 
		  $('#grpinfowindow').jqxWindow('open');

	// $('#accountWindow').jqxWindow('focus');
	      grpSearchContent('servicegrpsearch.jsp?rowBoundIndex='+rowBoundIndex);
	   	 }
	   	 
	function grpSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#grpinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
		
	function getteam(rowBoundIndex,assgnid){
		 
		  $('#teaminfowindow').jqxWindow('open');

	//$('#accountWindow').jqxWindow('focus');
	    teamSearchContent('servicegrptoearch.jsp?rowBoundIndex='+rowBoundIndex+'&assgnid='+assgnid);
	 	 }
	 	 
	function teamSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#teaminfowindow').jqxWindow('setContent', data);

	        	}); 
		}
		
		
	function getserType(rowBoundIndex){
		 
		  $('#sertypefowindow').jqxWindow('open');

	//$('#accountWindow').jqxWindow('focus');
	  serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex='+rowBoundIndex);
		 }
		 
	function serTypeSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sertypefowindow').jqxWindow('setContent', data);

	      	}); 
		}

	function termsSearchContent(url) {
 	   $('#searchwndow').jqxWindow('open');
          $.get(url).done(function (data) {
        $('#searchwndow').jqxWindow('setContent', data);
        $('#searchwndow').jqxWindow('bringToFront');

	}); 
    	} 
	
	function PrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		//$('#printWindow').jqxWindow('bringToFront');
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
	      
	      
	      function getcontact(event){
	  	  	
	  		var clientid=document.getElementById("clientid").value;
	  		
	  		if(clientid==""){
	  			document.getElementById("errormsg").innerText=" Select Client";
	  			return 0;
	  		}
	  		var x= event.keyCode;
	  		 if(x==114){
	  	 	  $('#cpinfowindow').jqxWindow('open');
	  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid); 
	  	        	 }
	  		 else{
	  			 }
	  		 }
	  	        	 
	  	function cpSearchContent(url) {
	  		 //alert(url);
	  	 	 $.get(url).done(function (data) {
	  				 //alert(data);
	  		$('#cpinfowindow').jqxWindow('setContent', data);

	  	               	}); 
	  	     	}

function getCompanyName(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#cmp').val(items);
	  			    
	  			  var companyname=$("#cmp").val();
	  			  var filenametolad="";  //check company name to popup windows for print
	  			 // alert("c="+companyname+"=");
				  if(companyname=="FIRE 7 LLC  "){
					  filenametolad="fire7PrintVoucher.jsp";
				  }
				  else{
					  filenametolad="printVoucherWindow.jsp";
				  }
	  			      if (($("#mode").val() == "view") && $("#docno").val()!="") {
	  					PrintContent(filenametolad);
	  				  }
	  				else {
	  						$.messager.alert('Message','Select a Document....!','warning');
	  						return;
	  					}
	  		}
	  		}
	  		x.open("GET", "getCompany.jsp", true);
	  		x.send();
	 }
	
	 function funReadOnly(){
			$('#frmQuotation input').attr('readonly', true );
			$('#frmQuotation select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#serviceGrid").jqxGrid({ disabled: true});
			$("#siteGrid").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
		//	 $('#btnRevision').attr('disabled', true);
			
			if(modes=="view")
			{
			
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
			
			 $('#masterdoc_no').attr('disabled', false);
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
			
	 }
	 
	 function funRemoveReadOnly(){
		 gridLoad();
		 refChange();
		 
			$('#frmQuotation input').attr('readonly', false );
			$('#frmQuotation select').attr('disabled', false);
			$('#date').jqxDateTimeInput({disabled: false});
			$("#serviceGrid").jqxGrid({ disabled: false});
			$("#siteGrid").jqxGrid({ disabled: false});
			$("#jqxTerms").jqxGrid({ disabled: false});
			$('#txtgrtotal').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#cmbprocess').attr('disabled', true);
		//	$('#btnRevision').attr('disabled', false);
			
			if ($("#mode").val() == "E") {
				$('#frmQuotation input').attr('readonly', false );
   			    $('#frmQuotation select').attr('disabled', false);
   			//    $("#siteGrid").jqxGrid('addrow', null, {});
   			 //   $("#serviceGrid").jqxGrid('addrow', null, {});
   			/*  $("#serviceGrid").jqxGrid({ disabled: true});
 			$("#siteGrid").jqxGrid({ disabled: true});
 			
 			$('#txtgrtotal').attr('readonly', true );
 			$('#txtdisper').attr('readonly', true );
 			$('#txtdisamt').attr('readonly', true );
 			$('#txttotalamt').attr('readonly', true );
 			$('#txttaxper').attr('readonly', true );
 			$('#txttaxamt').attr('readonly', true );
 			$('#txtnettotal').attr('readonly', true ); */
 		
   			    
			  }
			
			if ($("#mode").val() == "A") {
				$("#txtgrtotal").val(0.0);
				$("#txtdisper").val(0.0);
				$("#txtdisamt").val(0.0);
				$("#txttotalamt").val(0.0);
				$("#txttaxper").val(0.0);
				$("#txttaxamt").val(0.0);
				$("#txtnettotal").val(0.0);
				$("#txtdcdamount").val(0.0);
				
				$('#date').val(new Date());
				document.getElementById("ramc").checked=true;
				funcheck();
				$("#siteGrid").jqxGrid('clear');
				$("#siteGrid").jqxGrid('addrow', null, {});
				$("#serviceGrid").jqxGrid('clear');
				$("#serviceGrid").jqxGrid('addrow', null, {});
				$("#jqxTerms").jqxGrid('clear');
				$("#jqxTerms").jqxGrid('addrow', null, {});
			}
			
			$('#docno').attr('readonly', true);
			$('#txtrevise').attr('readonly', true);
			$('#txtclient').attr('readonly', true );
			$('#txtclientdet').attr('readonly', true );
			$('#txttel').attr('readonly', true );
			$('#txtmob').attr('readonly', true );
			$('#txtemail').attr('readonly', true );
			$('#txtcontact').attr('readonly', true );
			$('#txtcontactdetails').attr('readonly', true );
			
			if(mod1=="A")
			{
			
				 document.getElementById("clientid").value= '<%=cldocno%>';
	               document.getElementById("txtclient").value='<%=client%>';
	               document.getElementById("txtclientdet").value='<%=address%>';
	               document.getElementById("txtmob").value='<%=per_mob%>';
	               document.getElementById("txtemail").value='<%=mail1%>';
	               document.getElementById("txttel").value='<%=pertel%>';
	               document.getElementById("txtsalman").value='<%=salname%>';
	               document.getElementById("salid").value='<%=salid%>';
	               
		         document.getElementById("cmbreftype").value='<%=ref_type%>';
		         document.getElementById("hidcmbreftype").value='<%=ref_type%>';
		         document.getElementById("txtenquiry").value='<%=refdocno%>';
		         document.getElementById("enquiryid").value='<%=reftrno%>';
		         var cmbreftype=$('#cmbreftype').val();
		         if(cmbreftype!='DIR'){
		        	 $('#cmbreftype').attr('disabled', false);
		         }
		         refChange();
			}
			
			
	 }
	 
	 function funSearchLoad(){
		  /* changeContent('cregMainSearch.jsp'); */ 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  $(function(){
	        $('#frmQuotation').validate({
	                rules: {
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	 function checkestamount(enqid)
	 {
		 var qotnettot=document.getElementById("txtnettotal").value;
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	 items=items.split('###');
				
				 	var estamt=items[0];
				 	
				 	if(estamt!=qotnettot) 
		        {
				 		
							document.getElementById("errormsg").innerText="Amount Mismatch";
							
		        }else{
		        	saveest();
		        }
				 
				 	 
					}
			       else
				  {}
		     }
		      x.open("GET","getEstAmount.jsp?enqid="+enqid,true);
		     x.send();
		 
	 }
	 function saveest()
	 {
		
		 var rows1 = $("#serviceGrid").jqxGrid('getrows');
		 var rows2 = $("#siteGrid").jqxGrid('getrows');
		 var rows3 = $("#jqxTerms").jqxGrid('getrows');
		 
		 var mode=$("#mode").val();
	
		 $('#servicelen').val(rows1.length);
		 $('#sitelen').val(rows2.length);
		 $('#termsgridlen').val(rows3.length);
		 
				   
		 for(var i=0 ; i < rows2.length ; i++){
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "site"+i)
			       .attr("name", "site"+i)
			       .attr("hidden", "true"); 
			    
			    if(mode=='A'){
			    	 newTextBox.val(rows2[i].site+" :: "+rows2[i].areaid+" :: ");
			    }
			    if(mode=='E'){
			    	
			    	 newTextBox.val(rows2[i].site+" :: "+rows2[i].areaid+" :: "+rows2[i].rowno+" :: ");
			    }
			    
			  
			   newTextBox.appendTo('form');
			  
					}	 
		 
	 
			
		   for(var i=0 ; i < rows1.length ; i++){
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "service"+i)
			       .attr("name", "service"+i)
			       .attr("hidden", "true"); 
			    
			   
			    
			   newTextBox.val(rows1[i].stypeid+" :: "+rows1[i].item+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].desc1+" :: "+rows1[i].siteid+" :: "+rows1[i].unitid+" :: "+rows1[i].revision_no+" :: ");
			
			   newTextBox.appendTo('form');
			  
					}
		   
		   
		   for(var i=0 ; i < rows3.length ; i++){
			   
			   newTextBox = $(document.createElement("input"))
			      .attr("type", "dil")
			      .attr("id", "termg"+i)
			      .attr("name", "termg"+i)
			      .attr("hidden", "true");
			   
			   
			  newTextBox.val(rows3[i].voc_no+"::"+rows3[i].dtype+"::"+rows3[i].terms+"::"+rows3[i].conditions+"::");
			  
			  newTextBox.appendTo('form');
			  }
	
		   $("#frmQuotation").submit();
	 }
	  function funNotify(){
			
			
			if($('#clientid').val()== "")
			{
			document.getElementById("errormsg").innerText="select Client";
			return 0;
			}
			
			var cmbreftype=$('#cmbreftype').val();
			var enqid=document.getElementById("enquiryid").value;
	         if(cmbreftype=='ENQ' && enqid>0){
	        	
	        	checkestamount(enqid);
	        	
	         }
	         else
	        	 {
	        	 saveest();
	        	 }
			
		} 
 
	  
	  
	  function setValues(){
		  
		/*   if($('#revcheck').val()==1){
			  $('#btnRevision').attr('disabled', false);
			  }
		  else{
			  $('#btnRevision').attr('disabled', true);
			  } */
		  
		  if($('#hiddate').val()!=""){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }
		  
		  if($('#hidcmbreftype').val()!=""){
				 $("#cmbreftype").val($('#hidcmbreftype').val());
			  }

		  var docno=$("#masterdoc_no").val();
		  var reviseno=$("#txtrevise").val();
			var rdo=document.getElementById("hidradio").value;
			
			if(rdo=='AMC'){
				document.getElementById("ramc").checked=true;
				
			}
			if(rdo=='SJOB'){
				document.getElementById("rsjob").checked=true;
				
			}
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
			
			if(docno>0){
				var dtype=$('#formdetailcode').val().trim();
				refChange();
				 $("#siteDetailsDiv").load("siteGrid.jsp?docno="+docno);
				 $("#serviceDetailsDiv").load("serviceGrid.jsp?docno="+docno+"&reviseno="+reviseno); 
				 $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno);
				
			}
			 funSetlabel();
			
		}
	  
	<%--   function funPrint(id) {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {

				 $("#docno").prop("disabled", false);
				 $("#masterdoc_no").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#masterdoc_no').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		var reurl=url.split("com/"); 
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						  var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						 var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
		        });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
    } --%>
	  
	  
	<%--  function funPrintBtn() {
			
		  if (($("#mode").val() == "view") && $("#docno").val()!="") {
				PrintContent('printVoucherWindow.jsp');
			  }
			else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
      }--%>


 function funPrintBtn() {
		  getCompanyName();
      }
	  
	  
	  
	  <%-- 
	  function funPrintBtn() {
	  		
	  		var docno=$('#docno').val();
	  		var trno=$('#masterdoc_no').val();
	  		var dtype=$('#formdetailcode').val();
	  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  		var url=document.URL;
	  		var reurl=url.split("com/"); 
	  	    var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	  	} --%>
	  
	  
	  function gridLoad(){
		  var dtype=document.getElementById("formdetailcode").value;
		  $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
		  
		 
	  }
	  
	  function getEnquiry(event){
	 		 
	 		var clientid=document.getElementById("clientid").value;
		 	
		 	if(clientid>0){
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		 	else{
		 		document.getElementById("errormsg").innerText="Select a client";
		 		
		 		return 0;
		 	} 

				var x= event.keyCode;
			 	 if(x==114){
				   
			 		 changeContent('enqMastersearch.jsp');  
				
			    	 }
			 	 else{
			 		 }
			 	 }
			    	 
			function enquirySearchContent(url) {
				 $.get(url).done(function (data) {
				$('#enquirywindow').jqxWindow('setContent', data);
			           	}); 
			 	}
			
			function refChange(){
				 var reftype=$('#cmbreftype').val();

				 if(reftype=='DIR'){
					  
					  $('#txtenquiry').attr('disabled', true);
				 }
				 else{
					  
					  $('#txtenquiry').attr('disabled', false);
					  $('#txtenquiry').attr('readonly', true);
					  
				 }
				 
				}
			
		  		
		  	function fundisamt()
		  		{
		  		
		  	
		  		var  Total=parseFloat(document.getElementById('txtgrtotal').value);
		  		var  disprc=parseFloat(document.getElementById('txtdisper').value);
		  		var  disamt=parseFloat(document.getElementById('txtdisamt').value);
		  		var descper=0;
		  	 	   descper=(parseFloat(disamt)/parseFloat(Total))*100;
		  	 		var netval=parseFloat(Total)-parseFloat(disamt);
		  	 		document.getElementById('txtdisper').value=descper;
		  	 		document.getElementById('txttotalamt').value=netval;
		  	 		document.getElementById('txtnettotal').value=netval;
		  	 	
		  	
		  		}
		  	 function fundisper()
	  		{
		  		var  Total=parseFloat(document.getElementById('txtgrtotal').value);
		  		var  disprc=parseFloat(document.getElementById('txtdisper').value);
		  		var descvalue=parseFloat(Total)*(parseFloat(disprc)/100);
			  		var netval=parseFloat(Total)-parseFloat(descvalue);
			  		document.getElementById('txtdisamt').value=descvalue;
			  		document.getElementById('txttotalamt').value=netval;
			  		document.getElementById('txtnettotal').value=netval;
		  	 	
	  		} 
		  	 
		  	function funtaxamt()
	  		{
	  		
	  	
	  		var  Total=parseFloat(document.getElementById('txttotalamt').value);
	  		var  disprc=parseFloat(document.getElementById('txttaxper').value);
	  		var  disamt=parseFloat(document.getElementById('txttaxamt').value);
	  		var descper=0;
	  	 	   descper=(parseFloat(disamt)/parseFloat(Total))*100;
	  	 	descper=descper.toFixed(2);	
	  	 		var netval=parseFloat(Total)+parseFloat(disamt);
	  	 	netval=netval.toFixed(2);	
	  	 		document.getElementById('txttaxper').value=descper;
	  	 		document.getElementById('txtnettotal').value=netval;
	  	 	
	  	
	  		}
	  	 function funtaxper()
  		{
	  		var  Total=parseFloat(document.getElementById('txttotalamt').value);
	  		var  disprc=parseFloat(document.getElementById('txttaxper').value);
	  		var descvalue=parseFloat(Total)*(parseFloat(disprc)/100);
	  		descvalue=descvalue.toFixed(2);
		  		var netval=parseFloat(Total)+parseFloat(descvalue);
		  		netval=netval.toFixed(2);	
		  		document.getElementById('txttaxamt').value=descvalue;
		  		document.getElementById('txtnettotal').value=netval;
	  	 	
  		} 
		  		
		  	
	  	function funSearchLoad(){
			 changeContent('Mastersearch.jsp'); 
		}
	  	
	  	function funcheck(){
	  	
				
			if (document.getElementById('ramc').checked) {
				
				document.getElementById("hidradio").value="AMC";
				$('#cmbprocess').val('');
	     		
	     		 document.getElementById("hidcmbprocess").value=0;
	     		$('#cmbprocess').attr('disabled', true);
				  
				}
			 else if (document.getElementById('rsjob').checked) {
				 
				 document.getElementById("hidradio").value="SJOB";
				 $('#cmbprocess').attr('disabled', false);
				 
				}
			 }
	  	 function getsjobtype() {
	 		var x = new XMLHttpRequest();
	 		x.onreadystatechange = function() {
	 			if (x.readyState == 4 && x.status == 200) {
	 				var items = x.responseText;
	 				items = items.split('####');
	 				
	 				var srno  = items[0].split(",");
	 				var process = items[1].split(",");
	 				var optionsbranch = '<option value="" selected>-- Select -- </option>';
	 				for (var i = 0; i < process.length; i++) {
	 					optionsbranch += '<option  value="' + srno[i].trim()+'">'
	 					+ process[i] + '</option>';
	 				}
	 				$("select#cmbprocess").html(optionsbranch);
	 				 if ($('#hidcmbprocess').val()>0) {
	 						$('#cmbprocess').val($('#hidcmbprocess').val());
	 						} 
	 			} else {}
	 		}
	 		x.open("GET","getsjobtype.jsp", true);
	 		x.send();
	 	}
	    
	  /* 	function funrevision()
	  	{
	  	funEditBtn();
	  	document.getElementById('mode').value="R";
	  	}  	 */
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}


</style>

</head>
<body onload="setValues();getsjobtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuotation" action="saveQuotation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:30%;" value='<s:property value="txtrefno"/>'/>
 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
    <input type="hidden" id="txtrevise" name="txtrevise" style="width:30%;" value='<s:property value="txtrevise"/>'/>
 </td>
 
 
    <td width="6%" align="right">Doc No.</td>
    <td width="11%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Client Details</font></legend>
<table width="100%" >
  <tr>
    <td width="7%" align="right">Client</td>
    <td width="24%"><input type="text" id="txtclient" name="txtclient" style="width:90%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>'  onKeyDown="getclinfo(event);"/></td>
    <td width="9%" align="right">Client Details</td>
    <td colspan="3"><input type="text" id="txtclientdet" name="txtclientdet" style="width:84%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Tele.</td>
    <td><input type="text" id="txttel" name="txttel" style="width:65%;" value='<s:property value="txttel"/>' tabindex="-1"/></td>
    <td align="right">Mobile</td>
    <td width="16%"><input type="text" id="txtmob" name="txtmob" style="width:95%;" value='<s:property value="txtmob"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Mail</td>
    <td width="39%"><input type="text" id="txtemail" name="txtemail" style="width:72%;" value='<s:property value="txtemail"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Sales Man</td>
    <td><input type="text" id="txtsalman" name="txtsalman" style="width:65%;"    value='<s:property value="txtsalman"/>' /></td>
    <td align="right">Contact Person</td>
    <td width="16%"><input type="text" id="txtcontact" name="txtcontact" style="width:95%;" placeholder="Press F3 to Search" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);"/></td>
    <td width="10%" align="right">Contact Person Details</td>
    <td align="left" width="39%"><input type="text" id="txtcontactdetails" name="txtcontactdetails" style="width:72%;" value='<s:property value="txtcontactdetails"/>' tabindex="-1"/></td>
    
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right"><input type="radio" id="ramc" name="rdo" onchange="funcheck();" value="AMC">AMC</td>
    <td width="21%" align="center"><input type="radio" id="rsjob" name="rdo" onchange="funcheck();" value="SJOB">SJOB
    &nbsp;&nbsp;&nbsp;&nbsp;Type&nbsp;<select name="cmbprocess" id="cmbprocess" style="width:50%;" name="cmbprocess" onchange="funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /> 
	  
    </td>
    <td width="9%" align="right">Legal Fee</td>
    <td width="21%"><input type="text" id="txtdcdamount" name="txtdcdamount" style="width:70%;text-align: right;" value='<s:property value="txtdcdamount"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="7%" align="right">Ref. Type</td>
    <td width="11%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      <option value="SRVE">SRVE</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <td width="24%"><input type="text" id="txtenquiry" name="txtenquiry" style="width:60%;" placeholder="Press F3 to Search" value='<s:property value="txtenquiry"/>' onKeyDown="getEnquiry(event);"/></td>
  </tr>
  <tr>
    <td align="right">Subject</td>
    <td colspan="3"><input type="text" id="txtsubject" name="txtsubject" style="width:88%;" value='<s:property value="txtsubject"/>'/></td>
    <td align="right">Client Ref.</td>
    <td colspan="2"><input type="text" id="txtclientref" name="txtclientref" style="width:73%;" value='<s:property value="txtclientref"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="6"><input type="text" id="txtdesc1" name="txtdesc1" style="width:90%;" value='<s:property value="txtdesc1"/>'/></td>
  </tr>
</table>
</fieldset>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Site Details</font></legend>
<div id="siteDetailsDiv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
</fieldset>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Service Details</font></legend>
<div id="serviceDetailsDiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
</fieldset>

<table width="100%">   
  <tr>
    <td width="5%" height="42" align="right">Gr. Total</td>
    <td width="10%"><input type="text" id="txtgrtotal" name="txtgrtotal" style="width:80%;text-align: right;" value='<s:property value="txtgrtotal"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="5%" align="right">Discount %</td>
    <td width="7%"><input type="text" id="txtdisper" name="txtdisper" style="width:75%;text-align: right;" value='<s:property value="txtdisper"/>' onblur="fundisper();" /></td>
    <td width="5%" align="right">Discount</td>
    <td width="10%"><input type="text" id="txtdisamt" name="txtdisamt" style="width:80%;text-align: right;" value='<s:property value="txtdisamt"/>' onblur="fundisamt();" /></td>
    <td width="4%" align="right">Total</td>
    <td width="10%"><input type="text" id="txttotalamt" name="txttotalamt" style="width:80%;text-align: right;" value='<s:property value="txttotalamt"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="4%" align="right">Tax %</td>
    <td width="9%"><input type="text" id="txttaxper" name="txttaxper" style="width:80%;text-align: right;" value='<s:property value="txttaxper"/>' onblur="funtaxper();" /></td>
    <td width="3%" align="right">Tax</td>
    <td width="10%"><input type="text" id="txttaxamt" name="txttaxamt" style="width:80%;text-align: right;" value='<s:property value="txttaxamt"/>' onblur="funtaxamt();" /></td>
    <td width="6%" align="right">Net Total</td>
    <td width="10%"><input type="text" id="txtnettotal" name="txtnettotal" style="width:81%;text-align: right;" value='<s:property value="txtnettotal"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
  </tr>
</table>

<!-- <fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Terms & Conditions</font></legend> -->
<div id="termsDiv" hidden="true" ><jsp:include page="termsGrid.jsp"></jsp:include></div>
<!-- </fieldset> -->

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="cpersonid" name="cpersonid" value='<s:property value="cpersonid"/>'/>
<input type="hidden" id="enquiryid" name="enquiryid" value='<s:property value="enquiryid"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="servicelen" name="servicelen"  value='<s:property value="servicelen"/>'/>
<input type="hidden" id="sitelen" name="sitelen"  value='<s:property value="sitelen"/>'/>
<input type="hidden" id="termsgridlen" name="termsgridlen"  value='<s:property value="termsgridlen"/>'/>
<input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
<input type="hidden" id="salid" name="salid"  value='<s:property value="salid"/>'/>
<input type="hidden" id="revcheck" name="revcheck"  value='<s:property value="revcheck"/>'/>
<input type="hidden" id="hidestamt" name="hidestamt"  value='<s:property value="hidestamt"/>'/>
<input type="hidden" id="cmp" name="cmp"  value='<s:property value="cmp"/>'/>  
</div>
</form>

<div id="clientsearch1">
   <div></div>
</div>
<div id="cpinfowindow">
   <div></div>
</div>
<div id="areainfowindow">
   <div ></div>
</div>
<div id="grpinfowindow">
   <div ></div>
</div>
<div id="teaminfowindow">
   <div ></div>
</div>
<div id="sertypefowindow">
   <div ></div>
</div>
<div id="siteinfowindow">
   <div ></div>
   </div>
<div id="searchwndow">
   <div ></div>
   </div>
   <div id="enquirywindow">
   <div ></div>
   </div>
   <div id="unitsearchwindow">
   <div ></div>
   </div>
   <div id="printWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>
