<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();

String vocno =request.getParameter("vocno")==null?"0":request.getParameter("vocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();


String docno= request.getParameter("docno")==null?"0":request.getParameter("docno").toString();

String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String contrmode=request.getParameter("contrmode")==null?"0":request.getParameter("contrmode").toString();
String mail=request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String mob=request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks").toString();
String telno=request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String source=request.getParameter("source")==null?"0":request.getParameter("source").toString();
String sourceid=request.getParameter("sourceid")==null?"0":request.getParameter("sourceid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String sjobtype=request.getParameter("sjobtype")==null?"0":request.getParameter("sjobtype").toString();

%>
<script type="text/javascript">
var modes='<%=modes%>';
var masterdoc='<%=docno%>';
var enqdocno='<%=enqdocno%>';
 $(document).ready(function () {
	 
   	 $("#EnquiryDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
     $('#sourcesearchwndow').jqxWindow('close');
     $('#cpinfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#cpinfowindow').jqxWindow('close');
     
    $('#cmbclient').dblclick(function(){
	  	    $('#clientsearch1').jqxWindow('open');
	   
	       clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
       });
    
    $('#txtsource').dblclick(function(){
    	$('#sourcesearchwndow').jqxWindow('open');
		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
   });
    
    $('#txtcontact').dblclick(function(){
    	
    	var clientid=document.getElementById("cmbclient").value;
		
		if(clientid==""){
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		}
    	
    	$('#cpinfowindow').jqxWindow('open');
    	cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid, $('#cpinfowindow'));  
   });
    
    if(document.getElementById("txtradio").value==1)
    	{
    	//document.getElementById("r2").checked = true;
    
		$("#cmbclient").hide();
		$("#btnnewclient").hide();
    	}
  
   if(document.getElementById("txtradio").value=="")
	   {
	
	   $("#cmbclient").hide();
		$("#btnnewclient").hide();
	   }
   
	
	  
   
 		/* $("#r1").click(function() {
 			
			document.getElementById("r2").checked = false;
			
			$('#cmbclient').attr('readonly', false );
			$('#txtclientname').attr('readonly', false );
			$('#txtaddress').attr('readonly', false );
			$('#txtmobile').attr('readonly', false );
			$('#txtemail').attr('readonly', false );
			$('#txtRemarks').attr('readonly', false );
		
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById("txtradio").value="1";
			 
			$("#btnnewclient").hide();
			$("#cmbclient").hide();
 			
 			
		});
		$("#r2").click(function() { */
			
		//	document.getElementById("r1").checked = false;
			$('#cmbclient').attr('readonly', true );
			$('#txtclientname').attr('readonly', true );
			$('#txtaddress').attr('readonly', true );
			$('#txtmobile').attr('readonly', true );
			$('#txtemail').attr('readonly', true );
			$('#txtRemarks').attr('readonly', false );
			$("#cmbclient").show();
			$('#txtcontact').attr('placeholder', 'Press F3 to Search');
			$('#txtcontact').attr('readonly', true );
			$("#jqxEnquiry").jqxGrid({ disabled: false});
			 document.getElementById("txtradio").value="2";
			   document.getElementById("errormsg").innerText="";
			$("#btnnewclient").show();
			
	//	}); 
    
	});
 
 
 function getcontact(event){
	  	
		var clientid=document.getElementById("cmbclient").value;
		
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
	     	

 
          function brandinfoSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#brandsearchwndow').jqxWindow('open');
      		$('#brandsearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 
          function modelinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#modelsearchwndow').jqxWindow('open');
           		$('#modelsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
          function sourceinfoSearchContent(url) {
            	 //alert(url);
            		 $.get(url).done(function (data) {
            			 
            			 $('#sourcesearchwndow').jqxWindow('open');
            		$('#sourcesearchwndow').jqxWindow('setContent', data);
            
            	}); 
            	} 
    
	       function text()
	       {
	    	   var url=document.URL;
	      
			var reurl=url.split("com/");
	       top.addTab("Client",reurl[0]+"com/controlcentre/masters/client/clientMaster.jsp");
	     
	       }
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmEnquiry input').prop('readonly', true );
		
		$('#frmEnquiry textarea').attr('readonly', true );
		$('#frmEnquiry select').attr('disabled', true);
		$('#btnnewclient').attr('disabled', true);
	//	$('#r1').attr('disabled', true);
	//	$('#r2').attr('disabled', true);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEnquiry").jqxGrid({ disabled: true});
		
	    if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		Setviewmode(enqdocno);
		 <%--  $('#docno').attr('disabled', false);
	 		 $('#masterdoc_no').attr('disabled', false);
	 		 $('#mode').attr('disabled', false);
	 		 $('#EnquiryDate').jqxDateTimeInput({ disabled: false}); 
		
		document.getElementById("masterdoc_no").value=masterdoc;
		document.getElementById("mode").value=modes;
		
		  document.getElementById("docno").value= '<%=vocno%>';
		  $('#EnquiryDate').jqxDateTimeInput('val','<%=date%>');
		  document.getElementById("txtaddress").value='<%=address%>'; 
          
          document.getElementById("cmbclient").value='<%=cldocno%>';
                   
          document.getElementById("txtclientname").value='<%=client%>';
          document.getElementById("hidradio").value='<%=contrmode%>';
          document.getElementById("txtemail").value='<%=mail%>';
          document.getElementById("txtmobile").value='<%=mob%>';
          document.getElementById("txtRemarks").value='<%=remarks%>';
          document.getElementById("txttelno").value='<%=telno%>';
          document.getElementById("txtsource").value='<%=source%>';
          document.getElementById("sourceid").value='<%=sourceid%>';
          document.getElementById("txtcontact").value='<%=cperson%>';
          document.getElementById("cpersonid").value='<%=cpersonid%>';
          document.getElementById("cmbprocess").value='<%=sjobtype%>';
          
          var rdo=document.getElementById("hidradio").value;
          var sjobtype='<%=sjobtype%>';
         
  		if(rdo=='AMC'){
  			document.getElementById("c1").checked=true;
  			
  		}
  		
  		if(rdo=='SJOB'){
  			document.getElementById("c2").checked=true;
  			if(sjobtype>0){
     			 document.getElementById("hidcmbprocess").value=sjobtype;
     			}
  		}
          
          document.getElementById("gridval").value=1;		
     
      	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
      	
          document.getElementById("frmEnquiry").submit();
		// $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
		
		  $('#masterdoc_no').attr('disabled', false);
		   $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false); --%>
		   
		}
	
	}
	function funRemoveReadOnly(){
		
		$('#frmEnquiry input').attr('readonly', false );
		
		$('#frmEnquiry textarea').attr('readonly', false );
		$('#frmEnquiry select').attr('disabled', false);
		$('#btnnewclient').attr('disabled', false);
		$('#txtsource').attr('readonly', true);
	//	$('#r1').attr('disabled', false);
	//	$('#r2').attr('disabled', false);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		$('#cmbprocess').attr('disabled', true);
		$("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			
			 $('#EnquiryDate').val(new Date());
		     $("#jqxEnquiry").jqxGrid('clear');
		    $("#jqxEnquiry").jqxGrid('addrow', null, {});
		   }
		
		if ($("#mode").val() == "E") {
			 $("#jqxEnquiry").jqxGrid('addrow', null, {});
			/* if(document.getElementById("txtradio").value==1)
				{
					
					$('#r2').attr('disabled', true);	
				}
				else
					{
					$('#r1').attr('disabled', true);
					} */
			
		}
	
		$('#txtsource').attr('readonly', true );
		$('#txtclientname').attr('readonly', true );
		
		
	}
	function Setviewmode(enqdocno){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			
			 	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			 	document.getElementById("txttelno").value=items[0];
			 	 document.getElementById("masterdoc_no").value=items[1];
	              document.getElementById("docno").value=items[2];
	      	       $('#EnquiryDate').val(items[3]) ;
			       document.getElementById("txtRemarks").value=items[4];
			       document.getElementById("cmbclient").value=items[5];
		              document.getElementById("txtclientname").value=items[6];
			           document.getElementById("txtaddress").value=items[7]; 
			           document.getElementById("txtmobile").value=items[8];
			           document.getElementById("txtemail").value=items[9];
			           var cldocnval=items[10];
			           document.getElementById("sourceid").value=items[11];
			           document.getElementById("txtsource").value=items[12];
			              document.getElementById("txtcontact").value=items[13];
			              document.getElementById("cpersonid").value=items[14];
			              document.getElementById("hidradio").value=items[15];
			              
			              var rdo=document.getElementById("hidradio").value;
			              var sjobtype=items[16];
			             
			      		if(rdo=='AMC'){
			      			document.getElementById("c1").checked=true;
			      			
			      		}
			      		if(rdo=='SJOB'){
			      			document.getElementById("c2").checked=true;
			      			if(sjobtype>0){
			         			 document.getElementById("hidcmbprocess").value=sjobtype;
			         			}
			      		}
			              
			        	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			     	
			         document.getElementById("frmEnquiry").submit();
			 
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","setViewMode.jsp?masterdoc="+enqdocno,true);
	     x.send();
	    
	   }
	
	function getSource(event){
		 var x= event.keyCode;
    	 if(x==114){
    		 $('#sourcesearchwndow').jqxWindow('open');
    		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
    	}
    	 else{
    		 
    	 }
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
	       
	       
	function funNotify(){	
		
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		
		
		var valid2=document.getElementById("txtclientname").value;
		
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
		
		
		var fromval=document.getElementById("fromdatesval").value;
		if(parseInt(fromval)==1)
			{
			
			document.getElementById("errormsg").innerText="From Date Less Than Current Date";
			return 0;
			
			}
		var toval=document.getElementById("todateval").value;
		if(parseInt(toval)==1)
			{
			document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
			return 0;
			
			}
		
		
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		 
			
		   for(var i=0 ; i < rows.length ; i++){
		    	
		 
			
		    if(parseInt(rows[i].brdid)>0)
  		  {
		    
	  
	 	        if(rows[i].hidfromdate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidfromdate)=="undefined"||typeof(rows[i].hidfromdate)=="NaN")
  		
				{
				document.getElementById("errormsg").innerText="Enter From Date";  
		    	return 0;
				}
	 	        
	 	       if(rows[i].hidtodate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidtodate)=="undefined"||typeof(rows[i].hidtodate)=="NaN")
	 	    		
				{
				document.getElementById("errormsg").innerText="Enter To Date";  
		    	return 0;
				}
	 
		
	  	       
  	       	} 
   	            
		   }
	
	
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].descritpion+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		//frmEnquiry.submit();
	}

	function funSearchLoad(){
		 changeContent('enqMastersearch.jsp'); 
	}
    $(function(){
        $('#frmEnquiry').validate({
                rules: { 
                txtclientname:{"required":true},
                txtmobile:{number:true,maxlength:12,minlength:12},
                txttelno:{number:true,maxlength:15},
             //   txtemail:"",
                txtaddress: {maxlength:200},
                txtRemarks:{maxlength:200}
                 },
                 messages: {
                 txtRemarks: {maxlength:" Max 200 chars"},
                 txtclientname: {required:" *required"},
                 txtaddress: {maxlength:" Max 200 chars"},
                 txtmobile:{number:" Invalid MOB NO",maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
                 txttelno:{number:" Invalid Tel No",maxlength:" Max 15 chars" },
              //   txtemail:" *Enter Valid Email",
              
                 }
        });});
    
		
	function funFocus(){
		 
	   /* 	$('#EnquiryDate').jqxDateTimeInput('focus');  */
	   
	   
/* 	   
		document.getElementById("r1").checked=1; */
	//	document.getElementById("r1").focus();
	   
	   
	}
	function reqdata()
	{
 		 /* if((document.getElementById("r1").checked=="")&&(document.getElementById("r2").checked==""))
 				 
         	
    		{ 
     	  
     	       document.getElementById("errormsg").innerText=" Select One Option";
     	      $('#frmEnquiry input').attr('readonly', true );
     			$('#frmEnquiry textarea').attr('readonly', true );
     			
     		
     	        return false;			            	              		          	  
   		}  
		 else 
	         	
 		{ 
			 document.getElementById("errormsg").innerText="";	
			 
			 $('#frmEnquiry input').attr('readonly', false );
				$('#frmEnquiry textarea').attr('readonly', false );
		}     */
}
	
	
	function chkChange()
    {
		/* if($('#txtradio').val()!="")
			{
  	  if(document.getElementById("txtradio").value==2)
  		  {
  		document.getElementById("r2").checked = true;
  		document.getElementById("r1").checked = false;  */
  	 	$("#cmbclient").show();
  		$("#btnnewclient").show(); 
  	    $('#frmEnquiry input').attr('readonly', true );
		$('#frmEnquiry textarea').attr('readonly', true );
        $('#docno').attr('readonly', true);
		
		/* 
		
  		  }
  	  else 
  		  {
  	
  		  document.getElementById("r1").checked = true;
  		 document.getElementById("r2").checked = false;
  		  $('#frmEnquiry input').attr('readonly', true );
			$('#frmEnquiry textarea').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			
  		  }
			}
		else{}
 
    
	     */
    } 
	
	
	 function disfields()
	 {
		 $('#docno').attr('readonly', true);
		 $('#cmbclient').attr('readonly', true );
		/*  if( document.getElementById("r2").checked == true)
			 { */
				$('#txtclientname').attr('readonly', true );
		    	$('#txtaddress').attr('readonly', true );
		    	$('#txtmobile').attr('readonly', true );
		    	$('#txtemail').attr('readonly', true );
		    	$('#txttelno').attr('readonly', true );
		    	$('#txtcontact').attr('readonly', true );
		    	
		//	 }
			if ($("#mode").val() == "view") {
	    	$('#txtclientname').attr('readonly', true );
	    	$('#txtaddress').attr('readonly', true );
	    	$('#txtmobile').attr('readonly', true );
	    	$('#txtemail').attr('readonly', true );
	    	$('#txtRemarks').attr('readonly', true ); 
	    	$('#txttelno').attr('readonly', true ); 
	    	
			}
	 }
	 
	 
	function setValues() {
		  document.getElementById("formdetail").value="Enquiry";
	   		document.getElementById("formdetailcode").value="ENQ";  
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
		var rdo=document.getElementById("hidradio").value;
		
		if(rdo=='AMC'){
			document.getElementById("c1").checked=true;
			
		}
		if(rdo=='SJOB'){
			document.getElementById("c2").checked=true;
			
		}
		  
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
		 var indexVal2 = document.getElementById("masterdoc_no").value;
     	  
         $("#enqdiv").load("enquiryDetails.jsp?enqrdocno="+indexVal2);
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	
      	
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	 
     	chkChange();
	}

	
	
    
    function funPrintBtn(){
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

        var reurl=url.split("saveEnquiry");
   
        $("#docno").prop("disabled", false);                
        
  
var win= window.open(reurl[0]+"printEnq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
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
    function jobChange()
    {
    	
    	if(document.getElementById("c1").checked==true)
    		{
    		$('#cmbprocess').val('');
    		
    		 document.getElementById("hidcmbprocess").value=0;
    		$('#cmbprocess').attr('disabled', true);
    		
    		}
    	else
    		{
    		$('#cmbprocess').attr('disabled', false);
    		}
    }
	
</script>
</head>
<body onload="setValues();getsjobtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEnquiry" action="saveEnquiry" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset>
<legend>Customer Enquiry</legend>          <!-- EnquiryDate, docno,cmbclientb,txtclientname,txtaddress -->
<table width="100%" >                        
  <tr>
    <td width="11%" align="right">Date</td>
    <td colspan="2"><div id='EnquiryDate' name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
                     <input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/></td>
    <!--  <td width="32%" align="right">User Name</td> -->
    <%-- <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
    <td width="36%" align="right">User Name : <label ><font size="2PX"><%=session.getAttribute("USERNAME")%></font></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
    <td width="33%">Doc No&nbsp;<input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
  </tr>
  <%--  <tr>
    <td align="right">&nbsp;</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  >General</td>
    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
  </tr>  --%>
       
  <tr>
    <td align="right">Client</td>     
    <td colspan="3"><input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" onfocus="disfields();">
		<input type="text" id="txtclientname" name="txtclientname" style="width: 40%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();"></td>
     <td><button type="button" id="btnnewclient"  class="myButton" onclick="text();">Create new Client</button></td>
  </tr>
 
</table>
  <table width="100%" >
  <tr>
  <td width="10.8%" align="right">Contact person</td>
    <td><input type="text" id="txtcontact" name="txtcontact" style="width:25%;" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);"></td>
  </tr>
   <tr>
    <td width="10.8%" align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:76.7%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  </table>
<table  width="100%" >
  <tr>
    <td align="right" width="10.8%">MOB</td>
    <td width="20%" ><input type="text" id="txtmobile" name="txtmobile" style="width:60%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();"></td>
        <td align="right" width="3%" >Tel</td>
    <td width="20%"> <input type="text" id="txttelno" name="txttelno" style="width: 60%;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();"></td>
    <td align="right" width="3%" >Email</td>
    <td > <input type="email" id="txtemail" name="txtemail" style="width: 51.5%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  
  <tr>
    <td align="right" width="150">Contract Type</td>
    <td width="148"><input type="radio" id="c1" name="cnt" value="AMC" onClick="jobChange();">AMC
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" id="c2" name="cnt" value="SJOB" onClick="jobChange();" >
    SJOB</td>
    <td align="right">Type</td>
	  <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:62%;" name="cmbprocess" onchange="funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /> 
	  </td>
    <td align="right" >Source</td>
  <td align="left"><input type="text" id="txtsource" name="txtsource" style="width:52%;" readonly placeholder="Press F3 To Search" onKeyDown="getSource(event);" value='<s:property value="txtsource"/>'></td>
  
	 
  </tr>
  </table>
  <table  width="100%" >
  <tr>
  <td align="right" width="10.8%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:76.6%;" value='<s:property value="txtRemarks"/>'onfocus="reqdata();disfields();"></td>

  </tr>
</table> 
</fieldset>
<br/>
<fieldset>
<div id="enqdiv">
<jsp:include page="enquiryDetails.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />
<input type="hidden" id="enqgridlenght" name="enqgridlenght" />
<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />
<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
<input type="hidden" name="sourceid" id="sourceid" value='<s:property value="sourceid"/>'/>
<input type="hidden" name="cpersonid" id="cpersonid" value='<s:property value="cpersonid"/>'/>
<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' />  


<input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>


<div id="sourcesearchwndow">
   <div ></div>
 </div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="cpinfowindow">
   <div ></div>
   </div>
</div>
</body>
</html>