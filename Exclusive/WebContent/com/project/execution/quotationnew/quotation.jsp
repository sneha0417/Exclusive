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
String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
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
String contrtype=request.getParameter("contrtype")==null?"0":request.getParameter("contrtype").toString();
String surtrnof=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").toString();
String esttrnof=request.getParameter("esttrno")==null?"0":request.getParameter("esttrno").toString();
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String cpersondet=request.getParameter("cpersondet")==null?"0":request.getParameter("cpersondet").toString();
String sjobtype=request.getParameter("sjobtype")==null?"0":request.getParameter("sjobtype").toString();
String clienttaxper=request.getParameter("clienttaxper")==null?"0":request.getParameter("clienttaxper").toString();

System.out.println("ref_type=="+ref_type);
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
	  $('#sidesearchwndow').jqxWindow({ width: '30%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
		$('#sidesearchwndow').jqxWindow('close');
	  
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
		
		 $('#scopesearchwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#scopesearchwindow').jqxWindow('close');
		  
		 $('#templatesearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Template Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	 	 $('#templatesearchwindow').jqxWindow('close'); 
	 	  
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
	  
	  $('#txtsite').dblclick(function(){
	 		 
	 		if($('#mode').val()!= "view")
	   		{
	 			if(document.getElementById("cmbreftype").value!="DIR"){
		 			$('#siteinfowindow').jqxWindow('open');
				      	 siteSearchContent("servicesitesearch.jsp?gridtextbox=1"); 
	 			} else {
	 				$('#txtsite').attr('readonly', false );
	 				$('#txtsite').val('');$('#txtsiteid').val('');
	 			}
	   		}
	 	});
	  
	  $('#txttemplatecode').dblclick(function(){
			 
	 		if($('#mode').val()!= "view")
	   		{
	 			 $('#templatesearchwindow').jqxWindow('open');
	 			templateSearchContent('templatesDetailsSearch.jsp?', $('#templatesearchwindow'));    	
	   		}
	 	});
	  
	  getPreSalesScopeAllowed();
	  funcomprehensivetext();
  		 
	});
	
	function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 document.getElementById("errormsg").innerText="Enter Numbers Only.";
		             $("#"+id+"").focus();
		             return false;
		            
		         }
				
			    document.getElementById("errormsg").innerText="";
		        return true;
		    }
	
	function funmaxlength(value,id){
		if(parseFloat(value)>100){
			 document.getElementById("errormsg").innerText="Enter Numbers Upto 100.";
             $("#"+id+"").focus();
             $("#"+id+"").val(100);
             return false;
		}
		 document.getElementById("errormsg").innerText="";
	     return true;
	}
	
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
	
function templateSearchContent(url) {
	$('#templatesearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#templatesearchwindow').jqxWindow('setContent', data);
		$('#templatesearchwindow').jqxWindow('bringToFront');
	});
}

function scopeSearchContent(url) {
	$('#scopesearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#scopesearchwindow').jqxWindow('setContent', data);
		$('#scopesearchwindow').jqxWindow('bringToFront');
	});
}

function getPreSalesScopeAllowed(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		    $('#presalesscopeallowed').val(items);
		    
		  if(parseInt(items)==1){
				$('#tblpresalesscope').show();
  			    $('#serviceGrid').jqxGrid('showcolumn', 'scope');
			    $('#serviceGrid').jqxGrid('showcolumn', 'scopeamount'); 
		    } else {
		    	$('#tblpresalesscope').hide();
		        $('#serviceGrid').jqxGrid('hidecolumn', 'scope');
				$('#serviceGrid').jqxGrid('hidecolumn', 'scopeamount'); 
		    }
	}
	}
	x.open("GET", "getPreSalesScopeAllowed.jsp", true);
	x.send();
}

function getTaxDetails(netamount,date,inter,cldocno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var taxPerItems = items[0];
			var taxAmtItems  = items[1];
		
			$('#txttaxper').val(taxPerItems);	
			$('#txttaxamt').val(taxAmtItems);
	}
	}
	x.open("GET", "getTaxDetails.jsp?netamount="+netamount+"&date="+date+"&inter="+inter+"&cldocno="+cldocno, true);
	x.send();
}

function getTemplate(event){
	 var x= event.keyCode;
	 if(x==114){
		$('#templatesearchwindow').jqxWindow('open');
		templateSearchContent('templatesDetailsSearch.jsp?', $('#templatesearchwindow'));
	 }
	 else{
		 }
	 }
	 
	function getsites(event){
		 var x= event.keyCode;
		 if(x==114){
			 
		 		if($('#mode').val()!= "view")
		   		{
		 			if(document.getElementById("cmbreftype").value!="DIR"){
			 			$('#siteinfowindow').jqxWindow('open');
					    siteSearchContent("servicesitesearch.jsp?gridtextbox=1"); 
				    	  
		 			} else {
		 				$('#txtsite').attr('readonly', false );
		 				$('#txtsite').val('');$('#txtsiteid').val('');
		 			}
		   		}   
		 }
		 else{ }
		 }
	  	
	  	
	function getsite(rowBoundIndex){
		 
		  $('#siteinfowindow').jqxWindow('open');

	// $('#accountWindow').jqxWindow('focus');
	      siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&gridtextbox=2');
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
	  	
	  	 function productSearchContent(url) {
	      	// alert(url);
	      		 $.get(url).done(function (data) {
	      			 
	      			 $('#sidesearchwndow').jqxWindow('open');
	      		$('#sidesearchwndow').jqxWindow('setContent', data);
	      
	      	}); 
	      } 
	 function funReadOnly(){
			$('#frmQuotation input').attr('readonly', true );
			$('#frmQuotation select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#serviceGrid").jqxGrid({ disabled: true});
			$("#siteGrid").jqxGrid({ disabled: true});
			$("#jqxTerms").jqxGrid({ disabled: true});
		 $('#btnLoad').attr('disabled', true);
			
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
	 function getCompanyName(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#cmp').val(items);
	  			    
  			  var companyname=$("#cmp").val().trim();
  			  var filenametolad="";  //check company name to popup windows for print
	  			//alert("inc="+companyname);
	  			
	  			  if(companyname=="1"){
					  filenametolad="fire7PrintVoucher.jsp";
				  }
				
 else if(companyname=="2"){
	 $("#docno").prop("disabled", false);
	 $("#masterdoc_no").prop("disabled", false);
	 $("#formdetailcode").prop("disabled", false);
	 
	var docno=$('#docno').val();
		var trno=$('#masterdoc_no').val();
		var dtype=$('#formdetailcode').val();
		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		var url=document.URL;
		//alert("=url==="+url);
		var reurl=url.split("com/"); 
		var hedderstat=1;
		var reviseno=$("#txtrevise").val();
		var totalstat=1;
		//alert("=reurl[0]==="+reurl[0]);
		var id=1;
			  var win= window.open(reurl[0]+"printQuotationnew?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&hedderstat="+hedderstat+"&header=1"+"&reviseno="+reviseno+"&totalstat="+totalstat,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			 
			  win.focus();  

 }
else if(companyname=="3"){  //for star
	  filenametolad="starPrintVoucher.jsp";
 } 
 				 else{
					  filenametolad="printVoucherWindow.jsp";
				  } 
	  			      if (($("#mode").val() == "view") && $("#docno").val()!="" ) {
	  			    
	  			    	  if(companyname!="2"){
	  					PrintContent(filenametolad);
	  			    	  }
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
	 
	 function funRemoveReadOnly(){
		 gridLoad();
		 refChange();
		 getPreSalesScopeAllowed();
		 
			$('#frmQuotation input').attr('readonly', false );
			$('#frmQuotation select').attr('disabled', false);
			$('#date').jqxDateTimeInput({disabled: false});
			$("#serviceGrid").jqxGrid({ disabled: false});
			$("#siteGrid").jqxGrid({ disabled: false});
			$("#jqxTerms").jqxGrid({ disabled: false});
			$('#txtgrtotal').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#txttemplatecode').attr('readonly', true );
			$('#txttemplatename').attr('readonly', true );
			$('#cmbprocess').attr('disabled', false);
		//	$('#btnRevision').attr('disabled', false);
			 $('#btnLoad').attr('disabled', true);
$('#txtdcdamount').attr('disabled', true);
			 var islegaldoc=$("#islegaldoc").val();
				
				if(islegaldoc>0){
					document.getElementById("chklegaldoc").checked=true;
					legChange();
				}

			if ($("#mode").val() == "E") {
				document.getElementById("formdetailcode").value="SQOT";
				$('#frmQuotation input').attr('readonly', false );
   			    $('#frmQuotation select').attr('disabled', false);
   			//    $("#siteGrid").jqxGrid('addrow', null, {});
   			 //   $("#serviceGrid").jqxGrid('addrow', null, {});
   			//  $("#serviceGrid").jqxGrid({ disabled: true});
 			// $("#siteGrid").jqxGrid({ disabled: true});
 			
 			$('#txtgrtotal').attr('readonly', true );
 		//	$('#txtdisper').attr('readonly', true );
 		//	$('#txtdisamt').attr('readonly', true );
 			$('#txttotalamt').attr('readonly', true );
 			//$('#txttaxper').attr('readonly', true );
 			//$('#txttaxamt').attr('readonly', true );
 			$('#txtnettotal').attr('readonly', true );
 			
   			    
			  }
			
			if ($("#mode").val() == "A") {
				$('#hidradio').val('AMC');
				getsjobtype();
			    document.getElementById("formdetailcode").value="SQOT";
				$("#txtgrtotal").val(0.0);
				$("#txtdisper").val(0.0);
				$("#txtdisamt").val(0.0);
				$("#txttotalamt").val(0.0);
				$("#txttaxper").val(0.0);
				$("#txttaxamt").val(0.0);
				$("#txtnettotal").val(0.0);
				$("#txtdcdamount").val(0.0);
				
				$('#txtgrtotal').attr('readonly', true );
		 		$('#txttotalamt').attr('readonly', true );
		 		$('#txtnettotal').attr('readonly', true );
				
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
		         
		         document.getElementById("cpersonid").value='<%=cpersonid%>';
		         document.getElementById("txtcontact").value='<%=cperson%>';
		         document.getElementById("txtcontactdetails").value='<%=cpersondet%>';
		         document.getElementById("txttaxper").value='<%=clienttaxper%>'; 
		         
		         var cmbreftype=$('#cmbreftype').val();
		         if(cmbreftype!='DIR'){
		        	 $('#cmbreftype').attr('disabled', false);
		         }
		         refChange();
		         if('<%=contrtype%>'!="CREG")
		        	 {
		         document.getElementById("hidradio").value='<%=contrtype%>';
		         getsjobtype();
		         
		        	 }
		       if('<%=ref_type%>'=="ENQ")
		    	   {
		    	   var esttrno='<%=esttrnof%>';
		    	 
   	            var surtrno='<%=surtrnof%>';
		    	 	  if(esttrno>0){
		    	 	 $('#btnLoad').attr('disabled', false);
		    	 	  }
		    	
		    	      document.getElementById("hidesttrno").value=esttrno;
		    	        	var tr_no=document.getElementById("enquiryid").value;
		    	        	var reftype='<%=ref_type%>';
		    	        	
		    	            	$("#siteDetailsDiv").load("siteGrid.jsp?trno="+tr_no+"&surtrno="+surtrno+"&reftype="+reftype);
		    	    			 $("#serviceDetailsDiv").load("serviceGrid.jsp?trno="+tr_no+"&surtrno="+surtrno);
		    	    			 
		    	    			 document.getElementById("hidcmbprocess").value='<%=sjobtype%>';
		    	   }
		            
		         if('<%=ref_type%>'=="SRVE")
	    	   {
	    	   			var esttrno='<%=esttrnof%>';
	            		var surtrno='<%=surtrnof%>';
	            		var reftype='<%=ref_type%>';
	    	 	        document.getElementById("hidesttrno").value=esttrno;
	    	        	var tr_no=document.getElementById("enquiryid").value;
	    	        	if(surtrno>0){
	   		    	 	 $('#btnLoad').attr('disabled', false);
	   		    	 	  }
	    	            	$("#siteDetailsDiv").load("siteGrid.jsp?trno="+tr_no+"&surtrno="+surtrno+"&reftype="+reftype);
	    	   
	    	   }
		         
			}
			chkproductconfig();
			$('#gridtext').attr('readonly', false );
			$('#gridtext1').attr('readonly', false );
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
	 function checkestamount()
	 {
	     var enqid=document.getElementById("enquiryid").value;
		 var qotnettot1=document.getElementById("txtnettotal").value;
		 //var qotnettot=qotnettot1.replace(",","");
		 var qotnettot=qotnettot1.replace(/,/g,'');

		 //alert(parseFloat(qotnettot));
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	 items=items.split('###');
				
				 	var estamt=items[0];
				 	//alert(estamt);
				 	if(parseFloat(estamt)>parseFloat(qotnettot)) 
		        	{
						document.getElementById("errormsg").innerText="Amount Mismatch";
			        }else{
			        	saveest();
			        }
				 
				 	 
					}
			       else
				  {}
		     }
		      x.open("GET","getEstAmount.jsp?enqid="+enqid+"&dtype="+$('#cmbreftype').val(),true);
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
			    if(mode=='E' || mode=='R'){
			    	
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
			    
			   newTextBox.val(rows1[i].stypeid+" :: "+rows1[i].item+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].desc1+" :: "+rows1[i].siteid+" :: "+rows1[i].unitid+" :: "+rows1[i].revision_no+" :: "+rows1[i].psrno+" :: "+rows1[i].scopeid+" :: "+rows1[i].scopeamount+" :: "+rows1[i].stdprice+" :: "+rows1[i].lbrchg+" :: "+rows1[i].scopestdcost+" :: ");
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
		  var enqid=document.getElementById("enquiryid").value;
			  var rows1 = $("#serviceGrid").jqxGrid('getrows');
	          for(var i=0 ; i < rows1.length-1 ; i++){        
	          var item=$("#serviceGrid").jqxGrid('getcellvalue',rows1[i],'item');
			  var desc1=$("#serviceGrid").jqxGrid('getcellvalue',rows1[i],'desc1');
			  var stypeid=$("#serviceGrid").jqxGrid('getcellvalue',rows1[i],'stypeid');    
			  if((item==null || item=="" || typeof(item)=="undefined" || typeof(item)=="NaN") && (desc1==null || desc1=="" || typeof(desc1)=="undefined" || typeof(desc1)=="NaN") && (stypeid==null || stypeid=="" || typeof(stypeid)=="undefined" || typeof(stypeid)=="NaN"))
			  {
			  document.getElementById("errormsg").innerText="Please select either Item,Service Type or Description";
			  return 0;
			  }
			  }   
			if($('#clientid').val()== "")
			{
			document.getElementById("errormsg").innerText="select Client";
			return 0;
			}
			
			var cmbreftype=$('#cmbreftype').val();
			
	         var esttrno=document.getElementById("hidesttrno").value;
	         if(cmbreftype=='ENQ' && enqid>0 && esttrno>0){
	        	//alert("incheck");
	        	funconfig();
	        	
	        	
	         }
	         else
	        	 {
	        	 saveest();
	        	 }
			
		} 
 
	   function legChange(){
			 if(document.getElementById("chklegaldoc").checked){
				 
				 document.getElementById("islegaldoc").value=1;
				 $('#txtdcdamount').attr('disabled', false);
				 
			 }
			 else{
				 document.getElementById("islegaldoc").value=0;
				 $('#txtdcdamount').attr('disabled', true);
				
			 }
			 
			}
	  
	  function setValues(){
		  
		/*   if($('#revcheck').val()==1){
			  $('#btnRevision').attr('disabled', false);
			  }
		  else{
			  $('#btnRevision').attr('disabled', true);
			  } */
			
		  var netval=document.getElementById('txtnettotal').value;
			  var grtotal=(parseFloat(netval));
			  if(!netval.includes(",")){
        		 var newgrtot=grtotal.toLocaleString(undefined, {maximumFractionDigits:2});
        		 if(!newgrtot.includes("."))
        			 {
        			newgrtot=newgrtot+".00";
        			 }
        		
		  	 		document.getElementById('txtnettotal').value=newgrtot;
			  }
			  
			var islegaldoc=$("#islegaldoc").val();
			
			if(islegaldoc>0){
				document.getElementById("chklegaldoc").checked=true;
				legChange();
			}

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
				if(document.getElementById("termstatus").value==1){
				document.getElementById("formdetailcode").value="SQOT-AMC";
				}
				
			}
			if(rdo=='SJOB'){
				document.getElementById("rsjob").checked=true;
				if(document.getElementById("termstatus").value==1){
				document.getElementById("formdetailcode").value="SQOT-SJOB";
				}
			}
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
				if(document.getElementById("hideditdisable").value=="1"){
			    $('#btnEdit').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );
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
	  
	  
	 /*  function funPrintBtn() {
			
		  if (($("#mode").val() == "view") && $("#docno").val()!="") {
				PrintContent('printVoucherWindow.jsp');
			  }
			else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
      } */
      function funPrintBtn() {
    	  if(document.getElementById("formdetailcode").value=="SQOT-AMC" || document.getElementById("formdetailcode").value=="SQOT-SJOB"){
    		    document.getElementById("formdetailcode").value="SQOT";
    		    }
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
					  $('#txtsite').attr('readonly', false);
					  $('#txtsite').val('');$('#txtsiteid').val('');
				 }
				 else{
					  $('#txtenquiry').attr('disabled', false);
					  $('#txtenquiry').attr('readonly', true);
					  $('#txtsite').attr('readonly', true);
					  $('#txtsite').val('');$('#txtsiteid').val('');
					  if (document.getElementById("txtsiteid").value == "") {
					        $('#txtsite').attr('placeholder', 'Press F3 to Search'); 
					  }
				 }
				 
				}
			
			function funTemplateLoadAdd(){
				var siteid=$('#txtsiteid').val();
				var templateid=$('#txttemplateid').val();
				var site=$('#txtsite').val();
				
				 if(site==''){
					  document.getElementById("errormsg").innerText="Site is Mandatory.";
				 	  return 0;
				 }
				 
				 if(templateid==''){
					  document.getElementById("errormsg").innerText="Template is Mandatory.";
				 	  return 0;
				 }
				 document.getElementById("errormsg").innerText="";
				 
				 $("#overlay, #PleaseWait").show();
		         getTemplateDetailsADD(templateid,site,siteid);
		         
			}
			
		function funClearDiscount(){
			funRoundAmt(0,"txtdisper");
	        funRoundAmt(0,"txtdisamt");
	        getNetTotalValue();
		}
		
		function funClearTaxDetails(){
			funRoundAmt(0,"txttaxper");
	        funRoundAmt(0,"txttaxamt");
	        getNetTotalValue();
		}
			 		  		
		function getNetTotalValue(){
	  		
	  		var grtotal = $('#txtgrtotal').val();
	        var discountper = $('#txtdisper').val();
	        var discountamt = $('#txtdisamt').val();
			var additionamt = $('#txtadditionalamt').val();
	        var totalamt = $('#txttotalamt').val();
	        var taxper = $('#txttaxper').val();
	        var taxamt=$('#txttaxamt').val();
	        var nettotal=$('#txtnettotal').val();
	        var nettotal1="0",discountper1="0",discountamt1="0",additionamt1="0",totalamt1="0",taxper1="0",taxamt1="0";
	        
	        if(grtotal!=''){
	        	nettotal1=(parseFloat(grtotal));
	        	totalamt1=(parseFloat(grtotal));
	      	}
	        
	        if(discountamt!='' && discountamt!='0' && discountamt!='0.00'){
	        	discountamt1=discountamt;
	        	taxper1=taxper;
	        	taxamt=taxamt1;
	        	discountper1=(parseFloat(discountamt)/parseFloat(grtotal))*100;
	        	discountper=discountper1;
	        	totalamt1=parseFloat(grtotal)-parseFloat(discountamt1);
	        	nettotal1=(parseFloat(totalamt1));
	        }
	        
	        if(discountper!='' && discountper!='0' && discountper!='0.00'){
	        	discountper1=discountper;
	        	taxper1=taxper;
	        	taxamt=taxamt1;
	        	discountamt1=parseFloat(grtotal)*(parseFloat(discountper)/100);
	        	discountamt=discountamt1;
	        	totalamt1=parseFloat(grtotal)-parseFloat(discountamt1);
	        	nettotal1=(parseFloat(totalamt1));
	        } 
			
			if(additionamt!='' && additionamt!='0' && additionamt!='0.00'){
	        	discountamt1=discountamt;
	        	taxper1=taxper;
	        	taxamt=taxamt1;
	        	discountper=discountper1;
	        	additionamt1=additionamt;
	        	totalamt1=(parseFloat(grtotal)-parseFloat(discountamt1))+parseFloat(additionamt1);
	        	nettotal1=(parseFloat(totalamt1));
	        }
	        
	        if(taxper!='' && taxper!='0' && taxper!='0.00'){
	        	taxper1=taxper;
	        	taxamt1=parseFloat(totalamt1)*(parseFloat(taxper)/100);
	        	taxamt=taxamt1;
	        	nettotal1=parseFloat(totalamt1)+parseFloat(taxamt1);
	        }
	        
	        if(taxamt!='' && taxamt!='0' && taxamt!='0.00'){
	        	taxamt1=taxamt;
	        	taxper1=(parseFloat(taxamt1)/parseFloat(totalamt1))*100;
	        	taxper=taxper1;
	        	nettotal1=parseFloat(totalamt1)+parseFloat(taxamt1);
	        }
	        
	        funRoundAmt(discountper1,"txtdisper");
	        funRoundAmt(discountamt1,"txtdisamt");
			funRoundAmt(additionamt1,"txtadditionalamt");
	        funRoundAmt(totalamt1,"txttotalamt");
	        funRoundAmt(taxper1,"txttaxper");
	        funRoundAmt(taxamt1,"txttaxamt");
	        funRoundAmt(nettotal1,"txtnettotal");
	        
			var grtotal=(parseFloat(document.getElementById('txtnettotal').value));
       		var newgrtot=grtotal.toLocaleString(undefined, {maximumFractionDigits:2});
       		if(!newgrtot.includes(".")) {
       			newgrtot=newgrtot+".00";
       		}
	  	 	document.getElementById('txtnettotal').value=newgrtot;
	  	 	
	  	}
		
	  	function funSearchLoad(){
			 changeContent('Mastersearch.jsp'); 
		}
		
		function funconfig()
  		{
  		//alert("in config");
  		var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	
				 	if(items==1) 
		        {
				 		 checkestamount();
							
							
		        }else{
		        
		         saveest();
		        }
				 
				 	 
					}
			       else
				  {}
		     }
		      x.open("GET","getDisConfig.jsp",true);
		     x.send();
  		
  		
  		
  		
  		} 
	  	
	  	function funcheck(){
	  	
			if (document.getElementById('ramc').checked) {
				
				document.getElementById("hidradio").value="AMC";
				//$('#cmbprocess').val('');
	     		
	     		 document.getElementById("hidcmbprocess").value=0;
	     		//$('#cmbprocess').attr('disabled', true);
				  
				}
			 else if (document.getElementById('rsjob').checked) {
				 
				 document.getElementById("hidradio").value="SJOB";
				// $('#cmbprocess').attr('disabled', false);
				 
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
	 						$('#cmbprocess').attr('disabled', false);
	 						funcomprehensivetext();
	 						if($('#mode').val()=='view'){
	 				  			$('#cmbprocess').attr('disabled', true);
	 				  		}
	 				 } 
	 			} else {}
	 		}
	 		x.open("GET","getsjobtype.jsp?processtype="+$('#hidradio').val(), true);
	 		x.send();
	 	}
	  	 
	  	 function funcomprehensivetext(){

	  		 if($('#hidradio').val()=='AMC'){
	  			if($('#cmbprocess').find('option:selected').text()=='Comprehensive'){
	  				$('#lblThresholdLimit').show();$('#lblPartLimitPerc').show();
					$('#txtthresholdlimit').show();$('#txtpartlimitperc').show();
					if($('#mode').val()!='view'){
						$('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
					}
	  			} else {
	  				$('#lblThresholdLimit').hide();$('#lblPartLimitPerc').hide();
					$('#txtthresholdlimit').hide();$('#txtpartlimitperc').hide();
					if($('#mode').val()!='view'){
						$('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
					}
	  			}
					
				} else if($('#hidradio').val()=='SJOB'){
					$('#lblThresholdLimit').hide();$('#lblPartLimitPerc').hide();
					$('#txtthresholdlimit').hide();$('#txtpartlimitperc').hide();
					if($('#mode').val()!='view'){
						$('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
					}
				}
	  		
	  	 }
	    
	  /* 	function funrevision()
	  	{
	  	funEditBtn();
	  	document.getElementById('mode').value="R";
	  	}  	 */
	  	
	  	function loadEstimation()
	  	{
	  		var enqno=document.getElementById("enquiryid").value;
	  		
	  		$("#serviceGrid").jqxGrid('clear');
			//$("#serviceGrid").jqxGrid('addrow', null, {});       
	  		$("#serviceDetailsDiv").load("serviceGrid.jsp?enqno="+enqno+"&dtype="+$('#cmbreftype').val()+"&surtrno=2");  
	  	}
	  	
	  	function getTemplateDetailsADD(docno,site,siteid){
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    			    
    			    var splt=items.split(",");
    		    	 
    		    	 for(var i=0;i<splt.length;i++)
    		    	 {
    		    		 var data=splt[i].split("::");
    		    		 
    		    		 var desc1=data[0].trim()=="undefined" || data[0].trim()=="NaN" || data[0].trim()==""|| data[0]==null?"0":data[0].trim();
    		    		 var scope=data[1].trim()=="undefined" || data[1].trim()=="NaN" || data[1].trim()==""|| data[1]==null?"0":data[1].trim();
    		    		 var scopeid=data[2].trim()=="undefined" || data[2].trim()=="NaN" || data[2].trim()==""|| data[2]==null?"0":data[2].trim();
    		    		 var product=data[3].trim()=="undefined" || data[3].trim()=="NaN" || data[3].trim()==""|| data[3]==null?"0":data[3].trim();
    		    		 var productid=data[4].trim()=="undefined" || data[4].trim()=="NaN" || data[4].trim()==""|| data[4]==null?"0":data[4].trim();
    		    		 var activity=data[5].trim()=="undefined" || data[5].trim()=="NaN" || data[5].trim()==""|| data[5]==null?"0":data[5].trim();
    		    		 var activityid=data[6].trim()=="undefined" || data[6].trim()=="NaN" || data[6].trim()==""|| data[6]==null?"0":data[6].trim();
    		    		 var brandname=data[7].trim()=="undefined" || data[7].trim()=="NaN" || data[7].trim()==""|| data[7]==null?"0":data[7].trim();
    		    		 var unit=data[8].trim()=="undefined" || data[8].trim()=="NaN" || data[8].trim()==""|| data[8]==null?"0":data[8].trim();
    		    		 var scopeamount=data[9].trim()=="undefined" || data[9].trim()=="NaN" || data[9].trim()==""|| data[9]==null?"0":data[9].trim();
    		    		 var amount=data[10].trim()=="undefined" || data[10].trim()=="NaN" || data[10].trim()==""|| data[10]==null?"0":data[10].trim();
    		    		 var total=data[11].trim()=="undefined" || data[11].trim()=="NaN" || data[11].trim()==""|| data[11]==null?"0":data[11].trim();
    		    		 var nettotal=data[12].trim()=="undefined" || data[12].trim()=="NaN" || data[12].trim()==""|| data[12]==null?"0":data[12].trim();
    		    		 var margin=data[13].trim()=="undefined" || data[13].trim()=="NaN" || data[13].trim()==""|| data[13]==null?"0":data[13].trim();
    		    		 var invoiced=data[14].trim()=="undefined" || data[14].trim()=="NaN" || data[14].trim()==""|| data[14]==null?"0":data[14].trim();
    		    		 var proname=data[15].trim()=="undefined" || data[15].trim()=="NaN" || data[15].trim()==""|| data[15]==null?"0":data[15].trim();
    		    		 var prodoc=data[16].trim()=="undefined" || data[16].trim()=="NaN" || data[16].trim()==""|| data[16]==null?"0":data[16].trim();
    		    		 var unitdocno=data[17].trim()=="undefined" || data[17].trim()=="NaN" || data[17].trim()==""|| data[17]==null?"0":data[17].trim();
    		    		 var psrno=data[18].trim()=="undefined" || data[18].trim()=="NaN" || data[18].trim()==""|| data[18]==null?"0":data[18].trim();
    		    		 var proid=data[19].trim()=="undefined" || data[19].trim()=="NaN" || data[19].trim()==""|| data[19]==null?"0":data[19].trim();
    		    		 var specid=data[20].trim()=="undefined" || data[20].trim()=="NaN" || data[20].trim()==""|| data[20]==null?"0":data[20].trim();
    		    		 var stypeid=data[21].trim()=="undefined" || data[21].trim()=="NaN" || data[21].trim()==""|| data[21]==null?"0":data[21].trim();
    		    		 var site=data[22].trim()=="undefined" || data[22].trim()=="NaN" || data[22].trim()==""|| data[22]==null?"0":data[22].trim();
    		    		 var sertype=data[23].trim()=="undefined" || data[23].trim()=="NaN" || data[23].trim()==""|| data[23]==null?"0":data[23].trim();
    		    		 var brandid=data[24].trim()=="undefined" || data[24].trim()=="NaN" || data[24].trim()==""|| data[24]==null?"0":data[24].trim();
    		    		 var sitesrno=data[25].trim()=="undefined" || data[25].trim()=="NaN" || data[25].trim()==""|| data[25]==null?"0":data[25].trim();
    		    		 var stdprice=data[26].trim()=="undefined" || data[26].trim()=="NaN" || data[26].trim()==""|| data[26]==null?"0":data[26].trim();
    		    		 var marginper=data[27].trim()=="undefined" || data[27].trim()=="NaN" || data[27].trim()==""|| data[27]==null?"0":data[27].trim();
    		    		 var lbrchg=data[28].trim()=="undefined" || data[28].trim()=="NaN" || data[28].trim()==""|| data[28]==null?"0":data[28].trim();
    		    		 var scopestdcost=data[29].trim()=="undefined" || data[29].trim()=="NaN" || data[29].trim()==""|| data[29]==null?"0":data[29].trim();
    		    		 var qty=data[30].trim()=="undefined" || data[30].trim()=="NaN" || data[30].trim()==""|| data[30]==null?"0":data[30].trim();
    		          	 
    		    		 var rows = $("#serviceGrid").jqxGrid('getrows');
    		    		 
    		    		 var rowindex=((rows.length)-1);
    		    		 
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "site" ,site);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "siteid" ,sitesrno);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "stype" ,sertype);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "stypeid" ,stypeid);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "scope" ,scope);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "item" ,product);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "unit" ,unit);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "qty" ,qty);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "unitid" ,unitdocno);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "amount" ,amount);

    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "scopeamount" ,scopeamount);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "total" ,total);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue',rowindex , "desc1" ,desc1);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "psrno" ,psrno);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "prdname" ,proname);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "scopeid" ,scopeid);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "stdprice" ,stdprice);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "lbrchg" ,lbrchg);
    		    		 $('#serviceGrid').jqxGrid('setcellvalue', rowindex, "scopestdcost" ,scopestdcost);
    		    		 
    		    	 }
    		    	 
    			    $("#overlay, #PleaseWait").hide();
    			  
    		}
    		}
    		x.open("GET", "getTemplateDetails.jsp?docno="+docno+"&sitename="+site.replace(/ /g, "%20")+"&siteid="+siteid, true);
    		x.send();
    }
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
<form id="frmQuotation" action="saveQuotationnew" method="post" autocomplete="off">
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
 Revision
   <input type="text" id="txtrevise" name="txtrevise" style="width:30%;" value='<s:property value="txtrevise"/>'/>
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
    <td width="7%" align="right"><input type="radio" id="ramc" name="rdo" onchange="funcheck();getsjobtype();" value="AMC">AMC</td>
    <td width="5%" align="center"><input type="radio" id="rsjob" name="rdo" onchange="funcheck();getsjobtype();" value="SJOB">SJOB</td>
    <td width="3%" align="right">Type</td>
    <td width="8%"><select name="cmbprocess" id="cmbprocess" style="width:100%;" name="cmbprocess" onchange="funcomprehensivetext();funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /></td>
      <td width="7%" align="right"><label id="lblThresholdLimit">Threshold Limit</label></td>
    <td width="7%"><input type="text" id="txtthresholdlimit" name="txtthresholdlimit" style="width:90%;text-align:right;" onkeypress="javascript:return isNumber (event,id)" value='<s:property value="txtthresholdlimit"/>'/></td>
    <td width="7%" align="right"><label id="lblPartLimitPerc">Part Limit %</label></td>
    <td width="7%"><input type="text" id="txtpartlimitperc" name="txtpartlimitperc" style="width:90%;text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funmaxlength(this.value,this.id);" value='<s:property value="txtpartlimitperc"/>'/></td>
    <td width="6%" align="right"><input type="checkbox" name="chklegaldoc" id="chklegaldoc"  onchange="legChange();"> &nbsp;Legal Fee</td>
    <td width="8%"><input type="text" id="txtdcdamount" name="txtdcdamount" style="width:90%;text-align: right;" value='<s:property value="txtdcdamount"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="6%" align="right">Ref. Type</td>
    <td width="5%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      <option value="SRVE">SRVE</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <td width="10%"><input type="text" id="txtenquiry" name="txtenquiry" style="width:90%;" placeholder="Press F3 to Search" value='<s:property value="txtenquiry"/>' onKeyDown="getEnquiry(event);"/></td>
  </tr>
  <tr>
    <td align="right">Subject</td>
    <td colspan="6"><input type="text" id="txtsubject" name="txtsubject" style="width:88%;" value='<s:property value="txtsubject"/>'/></td>
    <td align="right">Client Ref.</td>
    <td colspan="5"><input type="text" id="txtclientref" name="txtclientref" style="width:73%;" value='<s:property value="txtclientref"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="12"><input type="text" id="txtdesc1" name="txtdesc1" style="width:88%;" value='<s:property value="txtdesc1"/>'/></td>
  </tr>
</table>
</fieldset>

<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Site Details</font></legend>
<div id="siteDetailsDiv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
</fieldset>
<table width="100%">
<tr>
<td><button class="myButton" type="button" id="btnLoad" name="btnLoad" onclick="loadEstimation();">Load</button></td>
  </tr>
</table>
<fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Service Details</font></legend>
<table id="tblpresalesscope" width="100%">
   <tr>
    <td width="7%" align="right">Site</td>
    <td width="26%"><input type="text" id="txtsite" name="txtsite" style="width:97%;" value='<s:property value="txtsite"/>'  onKeyDown="getsites(event);"/>
    <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/></td>
    <td width="10%" align="right">Template</td>
    <td width="16%"><input type="text" id="txttemplatecode" name="txttemplatecode" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txttemplatecode"/>'  onKeyDown="getTemplate(event);"/>
    <input type="hidden" id="txttemplateid" name="txttemplateid" value='<s:property value="txttemplateid"/>'/></td>
    <td colspan="2"><input type="text" id="txttemplatename" name="txttemplatename" style="width:97%;" tabindex="-1" value='<s:property value="txttemplatename"/>'/></td>
    <td width="9%" align="center"><button class="myButton" type="button" id="btntemplateadd" name="btntemplateadd" onclick="funTemplateLoadAdd();">ADD</button></td>
  </tr>
</table>
<input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
<input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' /> 
<div id="serviceDetailsDiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
</fieldset>

<table width="100%">   
  <tr>
    <td width="4%" height="42" align="right">Gr. Total</td>
    <td width="8%"><input type="text" id="txtgrtotal" name="txtgrtotal" style="width:90%;text-align: right;" value='<s:property value="txtgrtotal"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="5%" align="right"><label ondblclick="funClearDiscount();">Discount %</label></td>
    <td width="7%"><input type="text" id="txtdisper" name="txtdisper" style="width:75%;text-align: right;" value='<s:property value="txtdisper"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="4%" align="right"><label ondblclick="funClearDiscount();">Discount</label></td>
    <td width="8%"><input type="text" id="txtdisamt" name="txtdisamt" style="width:90%;text-align: right;" value='<s:property value="txtdisamt"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="4%" align="right">Addition</td>
    <td width="8%"><input type="text" id="txtadditionalamt" name="txtadditionalamt" style="width:90%;text-align: right;" value='<s:property value="txtadditionalamt"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="4%" align="right">Total</td>
    <td width="10%"><input type="text" id="txttotalamt" name="txttotalamt" style="width:80%;text-align: right;" value='<s:property value="txttotalamt"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="4%" align="right"><label ondblclick="funClearTaxDetails();">Tax %</label></td>
    <td width="7%"><input type="text" id="txttaxper" name="txttaxper" style="width:80%;text-align: right;" value='<s:property value="txttaxper"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="3%" align="right"><label ondblclick="funClearTaxDetails();">Tax</label></td>
    <td width="8%"><input type="text" id="txttaxamt" name="txttaxamt" style="width:90%;text-align: right;" value='<s:property value="txttaxamt"/>' onblur="funRoundAmt(this.value,this.id);getNetTotalValue();" /></td>
    <td width="6%" align="right">Net Total</td>
    <td width="10%"><input type="text" id="txtnettotal" name="txtnettotal" style="width:81%;text-align: right;" value='<s:property value="txtnettotal"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);" /></td>
  </tr>
  <tr><td colspan="9" align="right">Signed By</td>
  <td colspan="3" >
  <input type="text" id="txtsignedby" name="txtsignedby" width="100%" value='<s:property value="txtsignedby"/>' />
  </td>
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
<input type="hidden" id="presalesscopeallowed" name="presalesscopeallowed"  value='<s:property value="presalesscopeallowed"/>'/>
<input type="hidden" id="servicelen" name="servicelen"  value='<s:property value="servicelen"/>'/>
<input type="hidden" id="sitelen" name="sitelen"  value='<s:property value="sitelen"/>'/>
<input type="hidden" id="termsgridlen" name="termsgridlen"  value='<s:property value="termsgridlen"/>'/>
<input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
<input type="hidden" id="salid" name="salid"  value='<s:property value="salid"/>'/>
<input type="hidden" id="revcheck" name="revcheck"  value='<s:property value="revcheck"/>'/>
<input type="hidden" id="hidestamt" name="hidestamt"  value='<s:property value="hidestamt"/>'/> 
<input type="hidden" id="cmp" name="cmp"  value='<s:property value="cmp"/>'/>  
<input type="hidden" id="hidesttrno" name="hidesttrno"  value='<s:property value="hidesttrno"/>'/> 
<input type="hidden" id="hideditdisable" name="hideditdisable"  value='<s:property value="hideditdisable"/>'/>
<input type="hidden" id="islegaldoc" name="islegaldoc"  value='<s:property value="islegaldoc"/>'/>
<input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
<input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid"  value='<s:property value="txtgridservicetypeid"/>' />  
<input type="hidden" id="txtgridscopeid" name="txtgridscopeid"  value='<s:property value="txtgridscopeid"/>' /> 
</div>
<canvas id="canvas"></canvas>
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
   <div id="sidesearchwndow">
   <div ></div> 
</div>
   <div id="printWindow">
	<div></div><div></div>
</div>
<div id="templatesearchwindow">
	<div ></div>
</div>
<div id="scopesearchwindow">
	<div ></div>
</div>
</div>
</body>
</html>
