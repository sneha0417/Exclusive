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
<style type="text/css">

.myButtonses {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
 background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
 background-color:#599bb3;
 -moz-border-radius:4px;
 -webkit-border-radius:4px;
 border-radius:4px;
 display:inline-block;
 cursor:pointer;
 color:#ffffff;
 font-family:Verdana;
 font-size:10px;
 padding:4px 8px;
 text-decoration:none;
}
.myButtonses:hover {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
 background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
 background-color:#408c99;
}
.myButtonses:active {
 position:relative;
 top:1px;
}
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
String mod =request.getParameter("mod")==null?"view":request.getParameter("mod").toString();
System.out.println("====masterdocno===="+request.getParameter("mastertrno"));

String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();


String docno= request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();

String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String material=request.getParameter("material")==null?"0":request.getParameter("material").toString();
String labour=request.getParameter("labour")==null?"0":request.getParameter("labour").toString();
String machine=request.getParameter("machine")==null?"0":request.getParameter("machine").toString();
String nettotal=request.getParameter("nettotal")==null?"0":request.getParameter("nettotal").toString();
String surtrno=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").toString();
%>
<script type="text/javascript">
var mod1='<%=mod%>';
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
      $(document).ready(function () {
    	  
    	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
     	$('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	    $('#clientsearch1').jqxWindow('close');
  		$('#activitysearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
 	    $('#activitysearchwindow').jqxWindow('close'); 
 	    $('#lchargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Labour Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#lchargeinfowindow').jqxWindow('close');
		$('#echargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Equipment Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#echargeinfowindow').jqxWindow('close');
		$('#sidesearchwndow').jqxWindow({ width: '30%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
		$('#sidesearchwndow').jqxWindow('close');
		$('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#enquirywindow').jqxWindow('close');
		
		 $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#servicetypewindow').jqxWindow('close');
		  
		  $('#scopetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#scopetypewindow').jqxWindow('close');
		  
		  $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#sitewindow').jqxWindow('close');
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
		 
		 
 	  
 	
 	 
 	
 		 
      }); 
      function unitSearchContent(url) {
  		$('#unitsearchwindow').jqxWindow('open');
  		$.get(url).done(function(data) {
  			$('#unitsearchwindow').jqxWindow('setContent', data);
  			$('#unitsearchwindow').jqxWindow('bringToFront');
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
	function funReadOnly(){
		
		$('#frmTemplate input').attr('readonly', true );
		$('#frmTemplate select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		$('#btnSummary').attr('disabled', true );
		$("#materialGrid").jqxGrid({ disabled: true});
		
		
		if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		  $('#doc_no').attr('disabled', false);
	 		 $('#masterdoc_no').attr('disabled', false);
	 		 $('#mode').attr('disabled', false);
	 		 
	    	 $('#date').jqxDateTimeInput({ disabled: false}); 
		
		document.getElementById("masterdoc_no").value=mastertrno;
		document.getElementById("mode").value=modes;
		var loadid=2;
		var docno=mastertrno;

		  document.getElementById("docno").value= '<%=docno%>';
	         
	         $('#date').jqxDateTimeInput('val','<%=date%>');
	         $('#hiddate').jqxDateTimeInput('val','<%=date%>');
	        
	         document.getElementById("clientid").value='<%=cldocno%>';
	         
	        
	         document.getElementById("txtenquiry").value='<%=refdocno%>';
	         document.getElementById("enquiryid").value='<%=reftrno%>';
	         document.getElementById("txtmatotal").value='<%=material%>';
	        
	         document.getElementById("txtnettotal").value='<%=nettotal%>';
	         document.getElementById("txtnettotalshow").value='<%=nettotal%>';
	     
	        
	         
		 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
		
		
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
	
		$('#frmTemplate input').attr('readonly', false );
		$('#frmTemplate select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#btnSummary').attr('disabled', false );
		$('#docno').attr('readonly', true);
		$('#txtactivityname').attr('readonly', true );
		
		$('#txtreftype').attr('readonly', true );
		$("#materialGrid").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "E") {
			    //refChange();
			    $('#txtenquiry').attr('disabled', false );
			    $('#enquiryid').attr('disabled', false );
			    $('#clientid').attr('disabled', false );
			    
				//$('#frmTemplate input').attr('readonly', true );
			    $("#materialGrid").jqxGrid('addrow', null, {});
			    
				$('#gridtext').attr('readonly', false );
				$('#gridtext1').attr('readonly', false );
				
			    
			    
			    
		  }
		
		if ($("#mode").val() == "A") {
			$("#activitiesid").val("0");
		
			$('#date').val(new Date());
			$("#materialGrid").jqxGrid('clear');
			$("#materialGrid").jqxGrid('addrow', null, {});
			
		}
		if(mod1=="A")
		{
			
	         document.getElementById("clientid").value='<%=cldocno%>';
	         
	         
	         
	         document.getElementById("txtenquiry").value='<%=refdocno%>';
	         document.getElementById("enquiryid").value='<%=reftrno%>';
	         document.getElementById("hidenqtrno").value='<%=reftrno%>';
	         document.getElementById("hidsurtrno").value='<%=surtrno%>';
	         
	      
	         
	        	 $("#materialDiv").load("materialDetailsGrid.jsp?enqtrno="+'<%=reftrno%>'+"&loadid=3");
	         
	       
		}
		
		chkproductconfig();
	
	}
	
	/* function getlcharge(rowBoundIndex){
		 
		  $('#lchargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        lchargeSearchContent('chargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function lchargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#lchargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	}
	  	
	
	function getecharge(rowBoundIndex){
		 
		  $('#echargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        echargeSearchContent('equipchargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function echargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#echargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	} */

			  


	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      } 
	
	 function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	
	 
	function getservicetype(rowBoundIndex){
		 
		  $('#servicetypewindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        serviceSearchContent('servicesearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	     	 
	function serviceSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#servicetypewindow').jqxWindow('setContent', data);
	
	            	}); 
	  	}
	
	
	function getscopetype(rowBoundIndexx){
		 
		  $('#scopetypewindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        scopeSearchContent('scopesearch.jsp?rowBoundIndex='+rowBoundIndexx);
	     	 }
	     	 
	function scopeSearchContent(url) {
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#scopetypewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	
	
	
	
	 function funNotify(){
     	
     	
     	if($('#clientid').val()=="")
     	{
     	document.getElementById("errormsg").innerText="select a Client";
     	return 0;
     	}
     
     	 var rows1 = $("#materialGrid").jqxGrid('getrows');
    
     	document.getElementById("errormsg").innerText="";

     	 $('#matgridlen').val(rows1.length);

	 	var griddesc="";
     	 var errorstatus=0;
     	if(rows1.length=="0"){
    		$.messager.alert('Message','Enter Proper Details','warning');
    		   	errorstatus=1;
    			return 0;
    		 }
    		 else{
     	 
     	 for(var i=0;i<rows1.length-1;i++){
     		/*  alert(rows1[i].desc1);
     		alert(rows1[i].stypeid); */
     		/*  alert(rows1[i].prodoc);   
     		alert(rows1[i].stdprice); */
     		 if(rows1[i].prodoc>0)
     			 {
     			
     			 if(rows1[i].stdprice>=rows1[i].amount){
     				document.getElementById("errormsg").innerText="Amount Should Be Greater than Standard Price ("+rows1[i].stdprice+")";
     				return 0;
     				errorstatus=1;
     			 }
     			 }
     		 else{
     			document.getElementById("errormsg").innerText="";
     			 errorstatus=0;
     		 }
     		 if((rows1[i].desc1=="undefined" || typeof(rows1[i].desc1)=="undefined" || rows1[i].desc1==null || rows1[i].desc1=="") &&
     				(rows1[i].stypeid=="undefined" || typeof(rows1[i].stypeid)=="undefined" || rows1[i].stypeid==null || rows1[i].stypeid=="" )&&
     				(rows1[i].prodoc=="undefined" || typeof(rows1[i].prodoc)=="undefined" || rows1[i].prodoc==null || rows1[i].prodoc=="" )
     				 ){
     			$.messager.alert('Message','Enter Proper Details','warning');
  			   	errorstatus=1;
     			return 0;
     		 }
     		 else{
     			 errorstatus=0;
     		 }
     	 }
    		 }
     	 
     	 if(errorstatus==1){
     		 return 0;
     	 }

  
     
     	   var srno=0; 
     	 for(var i=0 ; i < rows1.length ; i++){
     		     newTextBox = $(document.createElement("input"))
     		       .attr("type", "dil")
     		       .attr("id", "mate"+i)
     		       .attr("name", "mate"+i)
     		       .attr("hidden", "true"); 
 
     		    	
     		     
     		   newTextBox.val(rows1[i].stypeid+" :: "+rows1[i].scopeid+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].specid+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].scope_amount+" :: "+rows1[i].total+" :: "+rows1[i].desc1+" :: "+rows1[i].scopestdcost+" :: "+rows1[i].lbrchg+" :: "+rows1[i].stdprice+" :: "+srno+" :: " );
     		   newTextBox.appendTo('form');
     		  
     				}	 
         			
     	
     		return 1;
     } 


	 
	  function funFocus(){
		    document.getElementById("txtcodeno").focus();
		
	    } 

			
			  function funPrintBtn(){
		<%-- 	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			 	  
			 	   var url=document.URL;

			        var reurl=url.split("saveEstimationnew");
			        
			        $("#docno").prop("disabled", false);                
			        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				     var dtype=$('#formdetailcode').val();
				  
							 var win= window.open(reurl[0]+"printestimation?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			  
			/* var win= window.open(reurl[0]+"printpurchaseorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			   */   
			win.focus();
			 	   } 
			 	  
			 	   else {
				    	      $.messager.alert('Message','Select a Document....!','warning');
				    	      return false;
				    	     }
				    	 --%>
			 	}

			  
	 
	 function setValues(){
		  
		  var docno=$("#docno").val();
		
		  var loadid=2;
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }
		
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		 /*  if(document.getElementById("hidestedit").value=="1"){
			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
		  } */
		  if(docno>0){
			  
			     
				 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
				 
			}
	 }
	 	  
	 	/*  function getEnquiry(event){
	 		 
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
				   
			 		 changeContent('enqMastersearch.jsp?reftype='+reftype);  
				
			    	 }
			 	 else{
			 		 }
			 	 } */
			    	 
			function enquirySearchContent(url) {
				 $.get(url).done(function (data) {
				$('#enquirywindow').jqxWindow('setContent', data);
			           	}); 
			 	}
	 
			
	        
			 	function funExcelBtn(){
				    if(parseInt(window.parent.chkexportdata.value)=="1") {
				      JSONToCSVCon(materialexcel,$("#docno").val(), true);
				    } else {
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
<form id="frmTemplate" action="saveTemplatemaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">

  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="15%" align="left">&nbsp;</td>
    <td width="8%" align="right">Doc No.</td>
    <td width="25%"><input type="text" id="docno" name="docno" style="width:70%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
   <td width="10%" align="right">Code</td>
    <td width="10%"><input type="text" id="txtcodeno" name="txtcodeno"  value='<s:property value="txtcodeno"/>'/></td>
   <td width="10%" align="right">Name</td>
    <td width="28%"><input type="text" id="txtname" name="txtname" style="width:50%;" value='<s:property value="txtname"/>'/></td>
   
  </tr>
</table>
</fieldset>
 
<table width="100%">
 
<fieldset><legend>Material Details</legend>
 <input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' /> 
<div id="materialDiv"><jsp:include page="materialDetailsGrid.jsp"></jsp:include></div>

</fieldset></table> 
<table width="100%">
  <tr>
    <td width="87%" align="right">Total</td>
    <td width="13%">
    
    <input type="hidden" id="txtnettotal" name="txtnettotal" style="width:94%;text-align: right;" value='<s:property value="txtnettotal"/>'/>
    <input type="text" id="txtnettotalshow" name="txtnettotalshow" style="width:94%;text-align: right;" value='<s:property value="txtnettotal"/>'/>
    </td>
  </tr>
</table>

<input type="hidden" id="activitiesid" name="activitiesid"  value='<s:property value="activitiesid"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtmatotal" name="txtmatotal"  value='<s:property value="txtmatotal"/>'/>
<input type="hidden" id="txtlabtotal" name="txtlabtotal"  value='<s:property value="txtlabtotal"/>'/>
<input type="hidden" id="txteqptotal" name="txteqptotal"  value='<s:property value="txteqptotal"/>'/>
<input type="hidden" id="matgridlen" name="matgridlen"  value='<s:property value="matgridlen"/>'/>
<input type="hidden" id="labgridlen" name="labgridlen"  value='<s:property value="labgridlen"/>'/>
<input type="hidden" id="eqgridlen" name="eqgridlen"  value='<s:property value="eqgridlen"/>'/>
<input type="hidden" id="actgridlen" name="actgridlen"  value='<s:property value="actgridlen"/>'/>
  <input type="hidden" id="hidestedit" name="hidestedit"  value='<s:property value="hidestedit"/>'/>
  
  <input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
  <input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
  <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />  
<input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid"  value='<s:property value="txtgridservicetypeid"/>' />  
<input type="hidden" id="txtgridscopeid" name="txtgridscopeid"  value='<s:property value="txtgridscopeid"/>' />
</div>
</form>

<div id="customerDetailsWindow">
   <div></div>
</div>
<div id="activitysearchwindow">
	<div></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="sidesearchwndow">
   <div ></div> 
</div>
<div id="lchargeinfowindow">
   <div ></div>
</div>
<div id="echargeinfowindow">
   <div ></div>
</div>
<div id="enquirywindow">
   <div ></div>
</div>

<div id="servicetypewindow">
   <div ></div>
</div>
<div id="scopetypewindow">
   <div ></div>
</div>

<div id="sitewindow">
   <div ></div>
</div>
<div id="unitsearchwindow">
   <div ></div>
   </div>
</div>
</body>
</html>
