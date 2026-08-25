<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();


%>

<!DOCTYPE html>
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

String surdocno =request.getParameter("surdocno")==null?"0":request.getParameter("surdocno").toString();
%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var masterdocno1='<%=surdocno%>';

	$(document).ready(function() {
  	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
  	  
  	$('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#enquirywindow').jqxWindow('close');
	
	$('#sertypesearchwindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, keyboardCloseKey: 27});
	$('#sertypesearchwindow').jqxWindow('close'); 
	    
	$('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	
	$('#serviceinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#serviceinfowindow').jqxWindow('close');
	 
	 
	$('#txtenquiry').dblclick(function(){
		/*  $('#enquirywindow').jqxWindow('open'); */
		 changeContent('enqMastersearch.jsp');  
		  });
	
	$('#txtsertype').dblclick(function(){
		
		 $('#sertypesearchwindow').jqxWindow('open');
	 	  refsearchContent('sertypeSearch.jsp');
	 	  
		  });
	
	$('#surveyedby').dblclick(function(){
		$('#employeeDetailsWindow').jqxWindow('open');
	   	 employeeSearchContent('employeeDetailsSearch.jsp');
		  });
	
	});
	function funReadOnly() {
		$('#frmSurveydet input').attr('readonly', true);
		 $('#frmSurveydet input').attr('disabled', true);
		 $('#frmSurveydet select').attr('disabled', true);
		 $('#txtsertype').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: true}); 
		 $("#serviceGrid").jqxGrid({ disabled: true});
		 $("#siteGrid").jqxGrid({ disabled: true});
		 $("#sertypeGrid").jqxGrid({ disabled: true});
		 if(modes=="view")
			{
			  document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				Setviewmode(masterdocno1);
			}
	}
	function funRemoveReadOnly() {
		$('#frmSurveydet input').attr('readonly', false);
		 $('#frmSurveydet select').attr('disabled', false);
		$('#frmSurveydet input').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#txtenquiry').attr('readonly', true);
		$('#txtcontact').attr('readonly', false);
		$('#contactnumber').attr('readonly', true);
		$('#surveyedby').attr('readonly', true);
		$('#txtsertype').attr('readonly', true);
		
		 $('#date').jqxDateTimeInput({ disabled: false}); 
		 $("#serviceGrid").jqxGrid({ disabled: false});
		 $("#siteGrid").jqxGrid({ disabled: false});
		 $("#sertypeGrid").jqxGrid({ disabled: false});
		 
		 if($('#mode').val()=='A'){
			 
			$("#serviceGrid").jqxGrid('clear');
			$("#serviceGrid").jqxGrid('addrow', null, {});
				
			$("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
					
		    $("#sertypeGrid").jqxGrid('clear');
			$("#sertypeGrid").jqxGrid('addrow', null, {});
						
			$("#servtypeDetailsGridID").jqxGrid('clear');
			//$("#servtypeDetailsGridID").jqxGrid('addrow', null, {});
						
						
			
		 }
		 
	}
	function Setviewmode(masterdoc){
		
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	 items=items.split('###');
				 	 
				 	 $('#date').jqxDateTimeInput({ disabled: false}); 
				 	 $('#date').jqxDateTimeInput('val',items[0]);
			         document.getElementById("hiddate").value=items[0];
			         document.getElementById("masterdoc_no").value=items[1];
			         document.getElementById("docno").value=items[2];
			         document.getElementById("enqdoc_no").value=items[3];
			         document.getElementById("txtenquiry").value=items[4]; 
			         document.getElementById("txtclient").value=items[5];
			         document.getElementById("clientid").value=items[6];
			         document.getElementById("txtclientdet").value=items[7];
			         document.getElementById("txtcontact").value=items[8];
			         document.getElementById("cpersonid").value=items[9];
			         document.getElementById("contactnumber").value= items[10];
			         document.getElementById("surveyedby").value=items[11]; 
			         document.getElementById("empid").value=items[12];
			         document.getElementById("txtdesc").value=items[13];
			         document.getElementById("txtcontractr").value=items[14];
			         
			         var docno=$('#masterdoc_no').val();
			    	if(docno>0){
			 			$("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?trno="+docno);
			 			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 			 $("#servicediv").load("serviceGrid.jsp?docno="+docno);
			  			
			 		}
					
				 	 
					}
			       else
				  {}
		     }
		      x.open("GET","setViewMode.jsp?masterdoc="+masterdoc,true);
		     x.send();
		    
		   }
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		
		var docno=$('#masterdoc_no').val();
		var sid=$('#sertypeids').val();
		//alert(document.getElementById("hidsuredit").value);
		if(document.getElementById("hidsuredit").value=="1"){
		    $('#btnEdit').attr('disabled', true );
	  } else {
		    $('#btnEdit').attr('disabled', false );
	  } 
		if(docno>0){
			$("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?trno="+docno);
			/* $("#sertypeDiv").load("ServiceTypeGrid.jsp?docno="+docno+"&sid="+sid); */
			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 $("#servicediv").load("serviceGrid.jsp?docno="+docno);
		}
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	function getemployee(event){
		var x= event.keyCode;
	 	 if(x==114){
		   
   	  $('#employeeDetailsWindow').jqxWindow('open');
   	 employeeSearchContent('employeeDetailsSearch.jsp'); 
          	 }
	 	 else{
	 		 
	 	
	 	 }
	}

	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	 function funFocus()
	    {
	    	document.getElementById("txtenquiry").focus();
	    		
	    }
	 
	  function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	    
	 function getEnquiry(event){

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
	 
	     	     
	    function funNotify(){
    	 
    	 
    	 var rows = $("#sertypeGrid").jqxGrid('getrows');
    	 var rows2 = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
		 var rows3 = $("#siteGrid").jqxGrid('getrows');
		 var rows4 = $("#serviceGrid").jqxGrid('getrows');
		
		 $('#sertypegridlen').val(rows.length);
		 $('#servtypdetgridlen').val(rows2.length);
		 $('#sitelen').val(rows3.length);
		 $('#servlen').val(rows4.length);
		 
		 
		   for(var i=0 ; i < rows.length ; i++){
					 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+i)
		       .attr("name", "test"+i)
		       .attr("hidden", "true"); 

		   newTextBox.val(rows[i].specid+" :: "+rows[i].details+" :: "+rows[i].desc1+" :: "+rows[i].servtypeid+" :: ");
					
		   newTextBox.appendTo('form');
		  
			}
		   
		   for(var i=0 ; i < rows2.length ; i++){
			   
			   var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows2[i]);
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "sertyp"+i)
			       .attr("name", "sertyp"+i)
			       .attr("hidden", "true"); 
			   newTextBox.val(row.doc_no+" :: ");
			   newTextBox.appendTo('form');
			  
					}
				
		   for(var i=0 ; i < rows3.length ; i++){
			   
	
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "site"+i)
			       .attr("name", "site"+i)
			       .attr("hidden", "true"); 
			 
			   newTextBox.val(rows3[i].site+" :: "+rows3[i].areaid+" :: ");
			   newTextBox.appendTo('form');
			  
					}
			
				
		   for(var i=0 ; i < rows4.length ; i++){
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "serv"+i)
			       .attr("name", "serv"+i)
			       .attr("hidden", "true"); 
			   newTextBox.val(rows4[i].serid+" :: ");
			   newTextBox.appendTo('form');
			  
					}
		
    		return 1;
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
	   
	   function getservice(rowBoundIndex){
	     	 
	    	  $('#serviceinfowindow').jqxWindow('open');
	    
	       // $('#accountWindow').jqxWindow('focus');
	              serviceSearchContent('service.jsp?rowBoundIndex='+rowBoundIndex);
	           	 }
	           	 
	   function serviceSearchContent(url) {
	    //alert(url);
	    	 $.get(url).done(function (data) {
	   		 //alert(data);
	   $('#serviceinfowindow').jqxWindow('setContent', data);

	                  	}); 
	        	}
	   
	   
	   function getsertype(event)
		 {
		  
		 	 var x= event.keyCode;
		 	 if(x==114){
		 	  $('#sertypesearchwindow').jqxWindow('open');
		 	
		 	  refsearchContent('sertypeSearch.jsp');  }
		 	 else{
		 		 }
	}  
		 	
		 	  function refsearchContent(url) {
		    
		       $.get(url).done(function (data) {
		
		     $('#sertypesearchwindow').jqxWindow('setContent', data);

		 	}); 
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
		 	  
		 	  function loadgrid(){
		 		  
			 		 var rows = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
			 		   var sid=0;
			 		    var loadid=1;
			 		    for (var m = 0; m < rows.length; m++) {
			 		        var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows[m]);
			 		       if(typeof(row.doc_no) != "undefined" && typeof(row.doc_no) != "NaN" && row.doc_no != ""){
				     	       sid=sid+row.doc_no+",";
				     	      
			 		       }
			 		       	}
			 		   //sid=sid.replace(/,(?=[^,]*$)/, '');
			 		  document.getElementById("sertypeids").value=sid;
			 		 $("#sertypeDiv").load("ServiceTypeGrid.jsp?sid="+sid+"&gridload=1");
			 	  }
			 	  
			 	 function loadgridReload(){
			 		  
			 		 var rows = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
			 		   var sid=0;
			 		    var loadid=2;
			 		    for (var m = 0; m < rows.length; m++) {
			 		        var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows[m]);
			 		       if(typeof(row.doc_no) != "undefined" && typeof(row.doc_no) != "NaN" && row.doc_no != ""){
				     	       sid=sid+row.doc_no+",";
				     	     
			 		       }
			 		       	}
			 		   //sid=sid.replace(/,(?=[^,]*$)/, '');
			 		  document.getElementById("sertypeids").value=sid;
			 		  if(typeof(sid) != "undefined" && typeof(sid) != "NaN" && sid != ""){
			 			 var docno=$("#masterdoc_no").val();
			 		   
			 			$("#sertypeDiv").load("ServiceTypeGrid.jsp?docno="+docno+"&sid="+sid);	 
			 		
			 		  }
			 		  
			 	  }
			 	 
			 	 
			 	 
				  function funPrintBtn() {
						
				
				  		
						if (($("#mode").val() == "view") && $("#docno").val()!="") {

							 $("#docno").prop("disabled", false);
							 $("#masterdoc_no").prop("disabled", false);
							 $("#formdetailcode").prop("disabled", false);
							 
							var docno=$('#docno').val();
					  		var trno=$('#masterdoc_no').val();
					  		var dtype=$('#formdetailcode').val();
					  		var sertypeids=$('#sertypeids').val();
					  	  var brhid=document.getElementById("brchName").value
					  		
					  		var url=document.URL;
					  		var reurl=url.split("com/"); 
					     
					  		 var win= window.open(reurl[0]+"printSurvey?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&sertypeids="+sertypeids+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
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
	
	  <form id="frmSurveydetails" action="saveSurveydetails" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
		<div class='hidden-scrollbar'>
   <table width="100%">
  <tr>
    <td width="11%" align="right">Date</td>
    <td width="18%"><div id="date" name="date" value='<s:property value="date" />'></div></td>
    <td width="10%" align="right">Enquiry No</td>
    <td width="30%"><input type="text" onKeyDown="getEnquiry(event);" name="txtenquiry" placeholder="press F3 for Search" value='<s:property value="txtenquiry" />' id="txtenquiry"></td>
    <td width="8%" align="right">Doc No</td>
    <td width="23%"><input type="text" name="docno" value='<s:property value="docno" />' id="docno" tabindex="-1" readonly></td>
  </tr>
  <tr>
   <td align="right">Client</td>
    <td><input type="text" name="txtclient" id="txtclient" style="width:95%;" value='<s:property value="txtclient" />'></td>
    <td colspan="2" align="left"><input type="text" name="txtclientdet" id="txtclientdet" style="width:90%;" value='<s:property value="txtclientdet" />'></td>
     <td align="right">Existing Contractor</td>
    <td><input type="text" name="txtcontractr" id="txtcontractr" style="width:65%;"  value='<s:property value="txtcontractr" />'></td>
  </tr>
  <tr>
    <td align="right">Contact Person</td>
    <td><input type="text" name="txtcontact" id="txtcontact" value='<s:property value="txtcontact" />'></td>
    <td align="right">Contact Number</td>
    <td><input type="text" name="contactnumber" id="contactnumber" value='<s:property value="contactnumber" />'></td>
    <td align="right">Surveyed By</td>
    <td><input type="text" name="surveyedby" id="surveyedby" onKeyDown="getemployee(event);" placeholder="press F3 for Search" value='<s:property value="surveyedby" />'></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" name="txtdesc" id="txtdesc"  value='<s:property value="txtdesc" />' style="width:95%;"></td>
  </tr>
</table>
<table width="100%">
  <tr>
    <td><fieldset><legend>Site Details</legend>
    <div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
    </fieldset></td>
   
    <td>
    <fieldset><legend>Service Details</legend>
    <div id="servicediv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
    </fieldset></td>
   
  </tr>
</table>

    <fieldset><legend>Service Type Details</legend>
    <table width="100%" >
  <tr >
    <td width="23%">
<fieldset style="background-color: #DCD0CD;">
<table width="100%">
 	 <tr><td colspan="2">&nbsp;</td></tr>
   <tr>
    <td width="20%"  align="right">Service Type</td>
    <td width="80%"><input type="text" id="txtsertype" name="txtsertype" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtsertype"/>'  onkeydown="getsertype(event);"/>
    <input type="hidden" id="txtsertypeid" name="txtsertypeid" value='<s:property value="txtsertypeid"/>'/></td> 
  </tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2"><div id="servtypeDetailsDiv"><jsp:include page="servtypeDetailsGrid.jsp"></jsp:include></div></td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2" align="center"><input type="button" class="myButtonses" name="btnLoad" id="btnLoad"  value="Submit" onclick="loadSubmit();"></td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
  <tr>
</tr> 
</table>
</fieldset>
</td>

<td width="85%">

<table width="100%">

  <tr>
    <td>
    <div id="sertypeDiv"><jsp:include page="ServiceTypeGrid.jsp"></jsp:include></div>
    </td>
  </tr> 
   <tr><td colspan="2">&nbsp;</td></tr>
</table>
 
</td>
</tr>
<tr><td>
    <input type="hidden" id="hiddate" name="hiddate"  value='<s:property value="hiddate"/>'/>
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="cpersonid" name="cpersonid"  value='<s:property value="cpersonid"/>'/>
    <input type="hidden" id="sertypeids" name="sertypeids"  value='<s:property value="sertypeids"/>'/>
    <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
    <input type="hidden" id="enqdoc_no" name="enqdoc_no"  value='<s:property value="enqdoc_no"/>'/>
    <input type="hidden" id="empid" name="empid"  value='<s:property value="empid"/>'/>
    <input type="hidden" id="sertypegridlen" name="sertypegridlen"  value='<s:property value="sertypegridlen"/>'/>
    <input type="hidden" id="servtypdetgridlen" name="servtypdetgridlen"  value='<s:property value="servtypdetgridlen"/>'/>
    <input type="hidden" id="servlen" name="servlen"  value='<s:property value="servlen"/>'/>
    <input type="hidden" id="sitelen" name="sitelen"  value='<s:property value="sitelen"/>'/>
     <input type="hidden" id="hidsuredit" name="hidsuredit"  value='<s:property value="hidsuredit"/>'/>
    </td></tr>
</table>
  </fieldset>       
   </div>
   
      
<div id="enquirywindow">
   <div ></div>
</div>
<div id="employeeDetailsWindow">
   <div></div>
</div>
<div id="areainfowindow">
   <div ></div>
   </div>
   <div id="serviceinfowindow">
   <div ></div>
   </div> 
   <div id="sertypesearchwindow">
	<div></div>
</div>     
</form>
</div>
</body>
</html>