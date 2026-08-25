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
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();

System.out.println("====masterdocno===="+request.getParameter("mastertrno"));

String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String masterdocno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var masterdocno='<%=masterdocno%>';

$(document).ready(function() {
	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#activityinfowindow').jqxWindow('close');
	  
	  $('#salesmanwindow').jqxWindow({ width: '25%', height: '50%',  maxHeight: '75%' ,maxWidth: '35%' ,title: ' Salesman Search' , position: { x: 800, y: 60 }, keyboardCloseKey: 27});
	  $('#salesmanwindow').jqxWindow('close');
	  $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#areainfowindow').jqxWindow('close');
	  $('#enqurywindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 650, y: 90 }, keyboardCloseKey: 27});
	  $('#enqurywindow').jqxWindow('close');
	  
	  $('#txtsalesman').dblclick(function(){
	  	    $('#salesmanwindow').jqxWindow('open');
	   
	  	//  salesmanSearchContent('salesmansearch.jsp');
	  	  salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
     });
	 $('#txtenqsource').dblclick(function(){
	  	  $('#enqurywindow').jqxWindow('open');
	  	  enquirySearchContent('enquirySearch.jsp?', $('#enqurywindow'));
     });
	  	  
	  $('#txtarea').dblclick(function(){
		  $('#areainfowindow').jqxWindow('open');
		  areaSearchContent('area.jsp?getarea=0');
		  });
});

function getareas(event){
 	 var x= event.keyCode;
 	 //alert("x===="+x);
 	 if(x==114){
 	  $('#areainfowindow').jqxWindow('open');

           areaSearchContent('area.jsp?getarea=0');  	 }
  	 else{
  		
 		 }
        	 }
 
        	 
function areaSearchContent(url) {
 //alert(url);
 	 $.get(url).done(function (data) {
		 //alert(data);
$('#areainfowindow').jqxWindow('setContent', data);

               	}); 
     	}

function getsalesman(event){

	var x= event.keyCode;
 	 if(x==114){
 		 $('#salesmanwindow').jqxWindow('open');
 		// changeContent('salesmansearch.jsp');  
 		 salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
    	 }
 	 else{
 		 
 		 }
 	 }
    	 
function salesmanSearchContent(url) {
	 $.get(url).done(function (data) {
	 $('#salesmanwindow').jqxWindow('setContent', data);
           	}); 
 	}
 	
function getEnquiry(event){
		var x= event.keyCode;
 		 if(x==114){
 		 $('#enqurywindow').jqxWindow('open');
 		 enquirySearchContent('enquirySearch.jsp?', $('#enqurywindow'));
    	 }
 	 else{
 		 
 		 }
 }
    	 
function enquirySearchContent(url) {
	 $.get(url).done(function (data){
	 $('#enqurywindow').jqxWindow('setContent', data);
     }); 
 } 	


function funFocus()
{
	//document.getElementById("txtsalesman").focus();
		
}

function funReadOnly(){
	
	 $('#frmprospectiveclient input').attr('readonly', true);
	 $('#frmprospectiveclient input').attr('disabled', true);
	 $('#frmprospectiveclient select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	// $("#expenseGrid").jqxGrid({ disabled: true}); 
	 $('#docno').attr('readonly', true);
	 $("#contactGrid").jqxGrid({ disabled: true});
	 
	 if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		
		 $('#maintrno').attr('disabled', false);
		 $('#docno').attr('disabled', false);
		 $('#mode').attr('disabled', false);
		 document.getElementById("maintrno").value=mastertrno;
		//document.getElementById("docno").value=masterdocno;
		document.getElementById("mode").value=modes;
		document.getElementById("frmprospectiveclient").submit();
		
	/* 	
	
		 var names = [];
		$("form").each(function() {
		  //alert(this.id);
		   names.push(this.id);
		}); 
		var form=names[0];
		   document.forms[form].submit(); 
		 //  document.getElementById("frmprospectiveclient").submit();
		    $('#maintrno').attr('disabled', false);
		 //  $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false);  */
		   
		}
	 
	
}

function funRemoveReadOnly(){
	
	 $('#frmprospectiveclient input').attr('readonly', false);
	 $('#frmprospectiveclient input').attr('disabled', false);
	 $('#frmprospectiveclient select').attr('disabled', false);
	 $('#txtsalesman').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	// $('#txtsite').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: false});
	// $("#expenseGrid").jqxGrid({ disabled: false}); 
	 $("#contactGrid").jqxGrid({ disabled: false});
	 if ($("#mode").val() == "A") {
		 getsalesmanonload();
	    $("#contactGrid").jqxGrid('clear');
	    $("#contactGrid").jqxGrid('addrow', null, {});
	   }
	
}


function mobileValid(value){
	   if(value!=""){ 
	    var phoneno = /^\d{12}$/;  
		if(value.match(phoneno)){
			document.getElementById("errormsg").innerText="";
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Invalid Mobile Number";
			//$('#txtmobilevalidation').val(1);
			return false;
		}
	    } 
	   return true;
}

function validateEmail($email) {
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if(emailReg.test( $email )){
		  document.getElementById("errormsg").innerText="";
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Email Address Not Valid";
			//$('#txtmobilevalidation').val(1);
			return false;
		}
	  return true;
	}

function funNotify(){
	if(document.getElementById("txtname").value=="")
	{
	document.getElementById("errormsg").innerText="Name Mandatory";
	return 0;
	}
	if(document.getElementById("txtsalesman").value=="")
		{
		document.getElementById("errormsg").innerText="Salesman Mandatory";
		return 0;
		}
	
	if(!mobileValid($("#txtmob").val())){
		 return 0;
	 }
	
	if(!validateEmail($("#txtemail").val())){
		 return 0;
	 }
	
	 var rows = $("#contactGrid").jqxGrid('getrows');
	   
	    var len=0;
	   for(var i=0;i<rows.length;i++){
		   
	    var cpersion= $.trim(rows[i].cpersion);
	   
		if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" )
			{
			
			
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+len)
		       .attr("name", "test"+len)
		       .attr("hidden", "true");
		    
			   
			
	   newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "
			   +rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "+rows[i].activity_id+"");
	   
	   newTextBox.appendTo('form'); 
	   
	   len=len+1;
			 }
	   
	   }
	   $('#contactGridlength').val(len);
	
		return 1;
} 

function funclear()
{
		/* document.getElementById("txtsalesman").value="";
		document.getElementById("txtclient").value="";
		document.getElementById("txtclientdet").value=""; */
	

}

function setValues() {

  var docVal1 = document.getElementById("maintrno").value.trim();
 
	if(docVal1>0)
		{
		
	 var indexVal2 = document.getElementById("maintrno").value.trim();
	
   $("#contactGriddiv").load("contactGrid.jsp?cptrno="+indexVal2);
		}
	if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }

	
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	
	 
}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	 $(function(){
	        $('#frmprospectiveclient').validate({
	                rules: { 
	                	txtsalesman:{"required":true},
	                	desc:{"required":true,maxlength:300},
	                //	desc: {maxlength:300},
	             
	                 },
	                 messages: {
	                	 txtsalesman: {required:" * Required"},
	                	 
	                 desc: {required:" * Please Fill",maxlength:" Max 300 chars"},
	               //  desc: {maxlength:" Max 300 chars"},
	                 
	                
	              
	                 }
	        });
	        });
	 
	 
	  function funPrintBtn() {
			
			<%-- if (($("#mode").val() == "view") && $("#docno").val()!="") {

				 $("#docno").prop("disabled", false);
				 $("#maintrno").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#maintrno').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		var reurl=url.split("com/"); 
		     
				var win= window.open(reurl[0]+"printProforma?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			    win.focus();
					 
		
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			} --%>
  }

	  function getsalesmanonload(){
			
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 	var res= x.responseText;
						 var ressplt=res.split("::");
						 var salname=ressplt[0].trim();
						 var salid=ressplt[1].trim();
					 	if(salid>0){
					 		document.getElementById("txtsalesman").value=salname;
					 		document.getElementById("txtsalid").value=salid;
							  }
						}
				       else
					  {}
			     }
			      x.open("GET",'salesmanonload.jsp',true);
			     x.send();
			    
			   }
	 
</script>
</head>

<body onLoad="setValues();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmprospectiveclient" action="saveProspectiveClient" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
        <br>
		<div class='hidden-scrollbar'>

<!-- <body> -->
<fieldset style="background-color: 	#FAEBD7;">
<table width="100%" >
<tr>
  <td><div align="right">Date</div></td>
  <td width="283"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="96"><div align="right">Enquiry Source</div></td>
  <td width="358">
  	<input type="text" name="txtenqsource" id="txtenqsource" style="width:72%;" placeholder="Press F3 To Search"  value='<s:property value="txtenqsource"/>'>
  	<input type="hidden" name="txtenqsourceid" id="txtenqsourceid" value='<s:property value="txtenqsourceid"/>'/>	
  </td>
  <td width="95"><div align="right">Doc No</div></td>
  <td width="112"><input type="text" name="docno" id="docno"  value='<s:property value="docno"/>'></td>
</tr>
<tr>
  <td><div align="right">Name</div></td>
  <td><input type="text"  name="txtname" id="txtname" style="width:70%;" value='<s:property value="txtname"/>'></td>
   <td><div align="right">Mob No.</div></td>
  <td colspan="3"><input type="text" name="txtmob" id="txtmob" style="width:43%;" onblur="mobileValid(this.value);" placeholder="mobile number with country code" value='<s:property value="txtmob"/>'></td>
  
</tr>
<tr>

<td align="right">Telephone</td>
<td><input type="text" id="txttelephone" name="txttelephone" style="width:70%;" value='<s:property value="txttelephone"/>'/></td>
<td align="right">Fax</td>
<td colspan="3"><input type="text" id="txtfax" name="txtfax" style="width:43%;" value='<s:property value="txtfax"/>'/></td>
<tr>
<tr>
  <td><div align="right">Email</div></td>
  <td><input type="text" name="txtemail" id="txtemail" style="width:70%;" placeholder="someone@example.com" onblur="validateEmail(this.value);" value='<s:property value="txtemail"/>'></td>
  <td><div align="right">Salesman</div></td>
  <td colspan="3"><input type="text" name="txtsalesman" id="txtsalesman" style="width:43%;" placeholder="Press F3 To Search"  onKeyDown="getsalesman(event);"  value='<s:property value="txtsalesman"/>'>
   <input type="hidden" name="txtsalid" id="txtsalid" value='<s:property value="txtsalid"/>'/>
  </td>
</tr>
<tr>
<td align="right">Area</td>
<td ><input type="text" id="txtarea" name="txtarea" style="width:70%;" readonly placeholder="press F3 to search" value='<s:property value="txtarea"/>' onKeyDown=" getareas(event);"/></td>
 <td colspan="4"><input type="text" id="txtareadet" name="txtareadet" readonly style="width:51.3%;" value='<s:property value="txtareadet"/>'/>
 <input type="hidden" id="txtareaid" name="txtareaid"  value='<s:property value="txtareaid"/>'/>
 </td></tr> 
<tr>
  <td width="96"><div align="right">Description</div></td>
  <td colspan="5"><input type="text" name="desc" style="width:70%;" id="desc" value='<s:property value="desc"/>'></td>
  </tr>
  

  
</table>
 
</fieldset>
<fieldset><legend>Contact Person Details</legend>
<table width="100%">

<tr>
    <td>
    
    <div id="contactGriddiv"><jsp:include page="contactGrid.jsp"></jsp:include></div>
    </td>
   </tr>
 </table>
  </fieldset>
  <table><tr>
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
     <input type="hidden" id="contactGridlength" name="contactGridlength" />
    </td>
   </tr>
</table>
</div>
<div id="activityinfowindow">
   <div ></div>
   </div>
<div id="salesmanwindow">
   <div ></div>
</div>
<div id="enqurywindow">
   <div ></div>
</div>
<div id="areainfowindow">
   <div ></div>
   </div>
</form>
</div>     
</body>
</html>
