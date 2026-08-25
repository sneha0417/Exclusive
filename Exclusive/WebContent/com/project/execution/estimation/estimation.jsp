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
    box-shadow: 1px 1px 0 0 #FFE4E1, 5px 5px 40px 2px #FFE4E1 inset;
    -moz-box-shadow: 1px 1px 0 0 #FFE4E1, 5px 5px 40px 2px #FFE4E1 inset;
    -webkit-box-shadow: 1px 1px 0 0 #FFE4E1, 5px 5px 40px 2px #FFE4E1 inset;
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
		$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
		$('#sidesearchwndow').jqxWindow('close'); 
		$('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#enquirywindow').jqxWindow('close');
		 refChange();
 	  $('#txtclient').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   	 $('#clientsearch1').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
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
 	 
 	 $('#txtactivityname').dblclick(function(){
 		 
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
  			$('#activitysearchwindow').jqxWindow('open');
  	 	    refsearchContent('activitysearch.jsp');
    		}
  		  });
 		 
      }); 
      
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
		
		$('#frmEstimation input').attr('readonly', true );
		$('#frmEstimation select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		$('#btnSummary').attr('disabled', true );
		
		$("#activityDetailsGridID").jqxGrid({ disabled: true});
		$("#materialDetailsGridID").jqxGrid({ disabled: true});
		$("#equipmentDetailsGridID").jqxGrid({ disabled: true});
		$("#labourDetailsGridID").jqxGrid({ disabled: true});
		
		if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		  $('#doc_no').attr('disabled', false);
	 		 $('#masterdoc_no').attr('disabled', false);
	 		 $('#mode').attr('disabled', false);
	 		 $('#cmbreftype').attr('disabled', false);
	    	 $('#date').jqxDateTimeInput({ disabled: false}); 
		
		document.getElementById("masterdoc_no").value=mastertrno;
		document.getElementById("mode").value=modes;
		var loadid=2;
		var docno=mastertrno;

		  document.getElementById("docno").value= '<%=docno%>';
	         document.getElementById("txtreviseno").value='<%=reviseno%>';
	         $('#date').jqxDateTimeInput('val','<%=date%>');
	         $('#hiddate').jqxDateTimeInput('val','<%=date%>');
	         document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("clientid").value='<%=cldocno%>';
	         document.getElementById("cmbreftype").value='<%=ref_type%>';
	         document.getElementById("hidcmbreftype").value='<%=ref_type%>';
	         document.getElementById("txtenquiry").value='<%=refdocno%>';
	         document.getElementById("enquiryid").value='<%=reftrno%>';
	         document.getElementById("txtmatotal").value='<%=material%>';
	         document.getElementById("txtlabtotal").value='<%=labour%>';
	         document.getElementById("txteqptotal").value='<%=machine%>';
	         document.getElementById("txtnetotal").value='<%=nettotal%>';
	         document.getElementById("txtnettotal").value='<%=nettotal%>';
	         document.getElementById("txtclientdet").value='<%=address%>';
	         var cmbreftype=$('#cmbreftype').val();
	         if(cmbreftype!='DIR'){
	        	 $('#cmbreftype').attr('disabled', false);
	         }
	         refChange();
		 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
		 $("#labourDiv").load("labourDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
		 $("#equipmentsDiv").load("equipmentDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
		 $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
		
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
	
		$('#frmEstimation input').attr('readonly', false );
		$('#frmEstimation select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#btnSummary').attr('disabled', false );
		$('#docno').attr('readonly', true);
		$('#txtactivityname').attr('readonly', true );
		$('#txtclient').attr('readonly', true );
		$('#txtclientdet').attr('readonly', true );
		$('#txtreftype').attr('readonly', true );
		$("#activityDetailsGridID").jqxGrid({ disabled: false});
		$("#materialDetailsGridID").jqxGrid({ disabled: false});
		$("#equipmentDetailsGridID").jqxGrid({ disabled: false});
		$("#labourDetailsGridID").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "E") {
			    //refChange();
			    $('#txtenquiry').attr('disabled', false );
			    $('#enquiryid').attr('disabled', false );
			    $('#clientid').attr('disabled', false );
			    $('#cmbreftype').attr('disabled', false );
				$('#frmEstimation input').attr('readonly', true );
			    $("#activityDetailsGridID").jqxGrid('addrow', null, {});
			    $("#materialDetailsGridID").jqxGrid('addrow', null, {});
			    $("#equipmentDetailsGridID").jqxGrid('addrow', null, {});
			    $("#labourDetailsGridID").jqxGrid('addrow', null, {});
		  }
		
		if ($("#mode").val() == "A") {
			$("#activitiesid").val("0");
			$("#txtreviseno").val("0");
			$('#date').val(new Date());
			$("#activityDetailsGridID").jqxGrid('clear');
			$("#activityDetailsGridID").jqxGrid('addrow', null, {});
			$("#materialDetailsGridID").jqxGrid('clear');
			$("#materialDetailsGridID").jqxGrid('addrow', null, {});
			$("#equipmentDetailsGridID").jqxGrid('clear');
			$("#equipmentDetailsGridID").jqxGrid('addrow', null, {});
			$("#labourDetailsGridID").jqxGrid('clear');
			$("#labourDetailsGridID").jqxGrid('addrow', null, {}); 
		}
		if(mod1=="A")
		{
			
			 document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("clientid").value='<%=cldocno%>';
	         document.getElementById("txtclientdet").value='<%=address%>';
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
	
	function getlcharge(rowBoundIndex){
		 
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
		  	}
	  	
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
	 
	 function funNotify(){
     	
     	
     	if($('#clientid').val()=="")
     	{
     	document.getElementById("errormsg").innerText="select a Client";
     	return 0;
     	}
     
     	 var rows1 = $("#materialDetailsGridID").jqxGrid('getrows');
         var rows2 = $("#labourDetailsGridID").jqxGrid('getrows');
     	 var rows3 = $("#equipmentDetailsGridID").jqxGrid('getrows');
     	 var rows4 = $("#activityDetailsGridID").jqxGrid('selectedrowindexes');
     	
     	 /* if(!(rows1>0)|| !(rows2>0) || !(rows3>0) ){
     		document.getElementById("errormsg").innerText="select atleast one activity";
         	return 0;
     	 } */
     	document.getElementById("errormsg").innerText="";

     	 $('#matgridlen').val(rows1.length);
     	 $('#labgridlen').val(rows2.length);
     	 $('#eqgridlen').val(rows3.length);
     	$('#actgridlen').val(rows4.length);
     	    
     	 for(var i=0 ; i < rows1.length ; i++){
     		     newTextBox = $(document.createElement("input"))
     		       .attr("type", "dil")
     		       .attr("id", "mate"+i)
     		       .attr("name", "mate"+i)
     		       .attr("hidden", "true"); 
     		    
     		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].netotal+" :: "+rows1[i].activityid+" :: ");
     		   newTextBox.appendTo('form');
     		  
     				}	 
     	 
     	 
     	  for(var i=0 ; i < rows2.length ; i++){
     			
     		  
     		    newTextBox = $(document.createElement("input"))
     		       .attr("type", "dil")
     		       .attr("id", "lab"+i)
     		       .attr("name", "lab"+i)
     		       .attr("hidden", "true"); 
    
     		   newTextBox.val(rows2[i].docno+" :: "+rows2[i].desc2+" :: "+rows2[i].hrs+" :: "+rows2[i].min+" :: "+rows2[i].rate+" :: "+rows2[i].total1+" :: "+rows2[i].margin1+" :: "+rows2[i].netotal1+" :: "+rows2[i].activityid+" :: ");
     		
     		   newTextBox.appendTo('form');
     		  
     				}
     	  
     		
     	   for(var i=0 ; i < rows3.length ; i++){
     			
     		    newTextBox = $(document.createElement("input"))
     		       .attr("type", "dil")
     		       .attr("id", "equip"+i)
     		       .attr("name", "equip"+i)
     		       .attr("hidden", "true"); 
     		    
     		   newTextBox.val(rows3[i].docno+" :: "+rows3[i].desc1+" :: "+rows3[i].hrs2+" :: "+rows3[i].min2+" :: "+rows3[i].rate2+" :: "+rows3[i].total2+" :: "+rows3[i].margin2+" :: "+rows3[i].netotal2+" :: "+rows2[i].activityid+" :: ");
     		
     		   newTextBox.appendTo('form');
     		  
     				}
     	   
     	  for(var i=0 ; i < rows4.length ; i++){
      		 
     		 var row = $("#activityDetailsGridID").jqxGrid('getrowdata', rows4[i]);
     		 
   		    newTextBox = $(document.createElement("input"))
   		       .attr("type", "dil")
   		       .attr("id", "act"+i)
   		       .attr("name", "act"+i)
   		       .attr("hidden", "true"); 
   		    
   		   newTextBox.val(row.tr_no+" :: "+row.sectionid+" :: "+row.projectid+" :: ");
   		   newTextBox.appendTo('form');
   		  
   				}
     			
     	
     		return 1;
     } 


	 
	 function funFocus(){
		    document.getElementById("txtclient").focus();
		
	    }
	 
	 function setValues(){
		  
		  var docno=$("#masterdoc_no").val();
		  var loadid=2;
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }
		  if($('#hidcmbreftype').val()!=""){
				 $("#cmbreftype").val($('#hidcmbreftype').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  if(docno>0){
			     
				 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
				 $("#labourDiv").load("labourDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
				 $("#equipmentsDiv").load("equipmentDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
				 $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
				 
			}
	 }
	 
	 function getactivity(event)
	 {
	  
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
	 	  $('#activitysearchwindow').jqxWindow('open');
	 	
	 	  refsearchContent('activitysearch.jsp');  }
	 	 else{
	 		 }
}  
	 	
	 	  function refsearchContent(url) {
	    
	       $.get(url).done(function (data) {
	
	     $('#activitysearchwindow').jqxWindow('setContent', data);

	 	}); 
	 	}
	 	  
	 	  function loadgrid(){
	 		  
	 		 var rows = $("#activityDetailsGridID").jqxGrid('selectedrowindexes');
	 		   var aid=0;
	 		    var loadid=1;
	 		    for (var m = 0; m < rows.length; m++) {
	 		        var row = $("#activityDetailsGridID").jqxGrid('getrowdata', rows[m]);
	 		       if(typeof(row.tr_no) != "undefined" && typeof(row.tr_no) != "NaN" && row.tr_no != ""){
		     	       aid=aid+row.tr_no+",";
		     	      
	 		       }
	 		       	}
	 		   aid=aid.replace(/,(?=[^,]*$)/, '');
	 		  document.getElementById("activitiesid").value=aid;
	 		     $("#materialDiv").load("materialDetailsGrid.jsp?docno="+aid+"&loadid="+loadid);
				 $("#labourDiv").load("labourDetailsGrid.jsp?docno="+aid+"&loadid="+loadid);
				 $("#equipmentsDiv").load("equipmentDetailsGrid.jsp?docno="+aid+"&loadid="+loadid);
	 		  
	 	  }
	 	  
	 	 function loadgridReload(){
	 		  
	 		 var rows = $("#activityDetailsGridID").jqxGrid('selectedrowindexes');
	 		   var aid=0;
	 		    var loadid=2;
	 		    for (var m = 0; m < rows.length; m++) {
	 		        var row = $("#activityDetailsGridID").jqxGrid('getrowdata', rows[m]);
	 		       if(typeof(row.tr_no) != "undefined" && typeof(row.tr_no) != "NaN" && row.tr_no != ""){
		     	       aid=aid+row.tr_no+",";
		     	     
	 		       }
	 		       	}
	 		   aid=aid.replace(/,(?=[^,]*$)/, '');
	 		  document.getElementById("activitiesid").value=aid;
	 		  if(typeof(aid) != "undefined" && typeof(aid) != "NaN" && aid != ""){
	 			 var docno=$("#masterdoc_no").val();
	 		    $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid+"&aid="+aid);
				$("#labourDiv").load("labourDetailsGrid.jsp?trno="+docno+"&loadid="+loadid+"&aid="+aid);
				$("#equipmentsDiv").load("equipmentDetailsGrid.jsp?trno="+docno+"&loadid="+loadid+"&aid="+aid);
				 
	 		  }
	 		  
	 	  }
	 	  
	 	  function loadSubmit(){
	 		  
	 		 var docno=$("#masterdoc_no").val();
	 		 
	 		 if(docno>0){
	 			
	 			loadgridReload();
	 		 }
	 		 else{
	 			loadgrid();
	 		 }
	 		  
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
<form id="frmEstimation" action="saveEstimation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="99%" >
  <tr >
    <td width="27%">
<fieldset style="background-color: #FFE4E1;">
<table width="100%">
 <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
   <tr>
    <td width="20%"  align="right">Activity</td>
    <td width="80%"><input type="text" id="txtactivityname" name="txtactivityname" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtactivityname"/>'  onkeydown="getactivity(event);"/>
    <input type="hidden" id="txtactivityid" name="txtactivityid" value='<s:property value="txtactivityid"/>'/></td> 
  </tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2"><div id="activityDetailsDiv"><jsp:include page="activityDetailsGrid.jsp"></jsp:include></div></td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2" align="center"><input type="button" class="myButtonses" name="btnLoad" id="btnLoad"  value="Submit" onclick="loadSubmit();"></td></tr> 
   <tr><td colspan="2">&nbsp;</td></tr> 
  <tr>
<td  colspan="1" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Total :</td>
    <td align="left"  colspan="1"><input type="text" class="textbox" id="txtnettotal" name="txtnettotal" style="width:40%;text-align: right;" value='<s:property value="txtnettotal"/>' tabindex="-1"/></td>
</tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  
</table>
</fieldset></td>

<td width="80%">

<table width="100%">

  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="15%" align="left">&nbsp;</td>
    <td width="10%" align="right">Revise No.</td>
    <td width="28%"><input type="text" id="txtreviseno" name="txtreviseno" style="width:50%;" value='<s:property value="txtreviseno"/>'/></td>
    <td width="8%" align="right">Doc No.</td>
    <td width="25%"><input type="text" id="docno" name="docno" style="width:70%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Customer</td>
    <td width="19%"><input type="text" id="txtclient" name="txtclient" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>'  onKeyDown="getclinfo(event);"/></td>
    <td width="36%"><input type="text" id="txtclientdet" name="txtclientdet" style="width:95%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
    <td width="7%" align="right">Ref. Type</td>
    <td width="11%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      <option value="SRVE">SRVE</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <td width="21%"><input type="text" id="txtenquiry" name="txtenquiry" style="width:98%;"  placeholder="Press F3 to Search" value='<s:property value="txtenquiry"/>'  onKeyDown="getEnquiry(event);"/></td>
  </tr>
</table></fieldset>

<fieldset><legend>Material Details</legend>
<div id="materialDiv"><jsp:include page="materialDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<fieldset><legend>Labour Details</legend>
<div id="labourDiv"><jsp:include page="labourDetailsGrid.jsp"></jsp:include></div>
</fieldset>


<fieldset><legend>Equipments Details</legend>
<div id="equipmentsDiv"><jsp:include page="equipmentDetailsGrid.jsp"></jsp:include></div>
</fieldset>


<table width="100%">
  <tr>
    <td width="87%" align="right">Total</td>
    <td width="13%"><input type="text" id="txtnetotal" name="txtnetotal" style="width:94%;text-align: right;" value='<s:property value="txtnetotal"/>'/></td>
  </tr>
</table>

</td>
</tr>
</table>
<input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
<input type="hidden" id="enquiryid" name="enquiryid"  value='<s:property value="enquiryid"/>'/>
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
</div>
</body>
</html>
