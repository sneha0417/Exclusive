<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%-- <%
String contextPath=request.getContextPath();
%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="<%=contextPath%>/js/jquery.min.js"></script>
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="../../../../css/myButton.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%-- <jsp:include page="tab.css"/>
<jsp:include page="tab.jsp" /> --%>

<style>
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}	
#level1{  background: #E0ECF8; width: 100%; height: 100%;}
#level2{  background: #E0ECF8;  width: 100%; height: 100%;}
#level3{  background: #E0ECF8;  width: 100%; height: 100%;}
</style>
<script type="text/javascript">
$(document).ready(function () {
	document.getElementById("txtuserdoc").value="0";
	
     $('#userWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '55%' ,theme: 'energyblue',title: 'User Search' , position: { x: 150, y: 100 }, keyboardCloseKey: 27});
	 $('#userWindow').jqxWindow('close');
	
	  $('#userinfoWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' ,theme: 'energyblue',title: 'Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
      $('#userinfoWindow').jqxWindow('close');
	  $('#jqxTabs').jqxTabs({ height:"400px", width: '100%',theme: 'energyblue',animationType: 'fade' });
	  $('#doctype').dblclick(function(){
		  if ($("#mode").val() == "A") {   	 
		  	    $('#userinfoWindow').jqxWindow('open');
		  	   // $('#accountWindow').jqxWindow('focus');
		  	  
		  	
		
		  	  changeContent2('doctypesearch.jsp');
		  }
				 });
		
});
     

function funReset(){
			//$('#frmApprovalMaster')[0].reset(); 
		}
		function funReadOnly(){
					
			$("#main *").attr("disabled",true);
			$("#lev1 *").attr("disabled",true);
			$("#lev2 *").attr("disabled",true);
			$("#lev3 *").attr("disabled",true);
			//$("#lev1").attr("disabled", true);
			$('#frmApprovalMaster input').attr('readonly', true );
			$("#jqxTabs").attr("disabled",false);
			
			
			///document.getElementById("txtfirst_minapproval").value=0;
			//$('#addUser').attr('disabled', true );
			// $("table#main input").prop("disabled", true);
			/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
			
		}
		function funRemoveReadOnly(){
			$('#frmApprovalMaster input').attr('readonly', false );
			$("#main *").attr("disabled",false);
			$("#lev1 *").attr("disabled",false);
			$("#lev2 *").attr("disabled",false);
			$("#lev3 *").attr("disabled",false);
			document.getElementById("txtuserdoc").value="0";
			
			
			$("#txtfinal_user1").attr("readonly",true);
			$("#txtfinal_userfull1").attr("readonly",true);
			
			$("#txtfinal_user2").attr("readonly",true);
			$("#txtfinal_userfull2").attr("readonly",true);
			
			$("#txtfinal_user3").attr("readonly",true);
			$("#txtfinal_userfull3").attr("readonly",true);
			
			$("#txtfinal_user4").attr("readonly",true);
			$("#txtfinal_userfull4").attr("readonly",true);
			
			$("#txtfinal_user5").attr("readonly",true);
			$("#txtfinal_userfull5").attr("readonly",true);
			
			
			$("#txtsecond_user1").attr("readonly",true);
			$("#txtsecond_userfull1").attr("readonly",true);
			
			$("#txtsecond_user2").attr("readonly",true);
			$("#txtsecond_userfull2").attr("readonly",true);
			
			$("#txtsecond_user3").attr("readonly",true);
			$("#txtsecond_userfull3").attr("readonly",true);
			
			$("#txtsecond_user4").attr("readonly",true);
			$("#txtsecond_userfull4").attr("readonly",true);
			
			$("#txtsecond_user5").attr("readonly",true);
			$("#txtsecond_userfull5").attr("readonly",true);
			
			
			$("#txtfirst_user1").attr("readonly",true);
			$("#txtfirst_userfull1").attr("readonly",true);
			
			$("#txtfirst_user2").attr("readonly",true);
			$("#txtfirst_userfull2").attr("readonly",true);
			
			$("#txtfirst_user3").attr("readonly",true);
			$("#txtfirst_userfull3").attr("readonly",true);
			
			$("#txtfirst_user4").attr("readonly",true);
			$("#txtfirst_userfull4").attr("readonly",true);
			
			$("#txtfirst_user5").attr("readonly",true);
			$("#txtfirst_userfull5").attr("readonly",true);
			
			
			$('#docno').attr('readonly', true);
			$('#doctype').attr('readonly', true);
			$('#doctypename').attr('readonly', true);
			
		    
		    
		    if($('#mode').val()=="A")
		    	{
		    	 document.getElementById("txtfinal_minapproval").value="0";
				    document.getElementById("txtsecond_minapproval").value="0";
				    document.getElementById("txtfirst_minapproval").value="0";
				   
		    	view();
		    	}
		    
			
		}

	var user1 = 0;
	var j = 0;
	var k = 0;  

   //Tab1
	function addUser1(){	
	   
		
		if(document.getElementById("doctype").value=="")
			{
			
			 document.getElementById("errormsg").innerText="Search Doc Type";
			 document.getElementById("doctype").focus();
		     return 0;
			}
	   
	   if($('#mode').val()=="E")
		   
		   {

		   if(parseInt(document.getElementById("txtfinal_userdoc1").value)>0)
			  {
			   user1=1;
			   
			  } 
		   
		   if(parseInt(document.getElementById("txtfinal_userdoc2").value)>0)
			  {
			   user1=2;
			  } 
		   
		   if(parseInt(document.getElementById("txtfinal_userdoc3").value)>0)
			  {
			   user1=3;
			  } 
		   
		   if(parseInt(document.getElementById("txtfinal_userdoc4").value)>0)
			  {
			   user1=4;
			  } 
		   
		   
		   }
	   
	   
	   
	  // alert(user1);
	   user1++;
		//   alert(user1);		  
		  if(user1==1){	
			 // alert("in if"+user1);
			  $("#user1").show();
			  //alert("out if"+user1);
		  }		 
		  if(user1==2){
			 // alert(user1);
			  $("#user2").show();
		  }
		  if(user1==3){
			  $("#user3").show();
		  }
		  if(user1==4){
			  $("#user4").show();
		  }
		  if(user1==5){
			  $("#user5").show();
		  }
	}
	
	 //Tab2
	function addUsr1(){	
		if(document.getElementById("doctype").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search Doc Type";
		 document.getElementById("doctype").focus();
	     return 0;
		}
		if($('#mode').val()=="E")
			   
		   {

		   if(parseInt(document.getElementById("txtsecond_userdoc1").value)>0)
			  {
			   j=1;
			   
			  } 
		   
		   if(parseInt(document.getElementById("txtsecond_userdoc2").value)>0)
			  {
			   j=2;
			  } 
		   
		   if(parseInt(document.getElementById("txtsecond_userdoc3").value)>0)
			  {
			   j=3;
			  } 
		   
		   if(parseInt(document.getElementById("txtsecond_userdoc4").value)>0)
			  {
			   j=4;
			  } 
		   
		   
		   }
	   
		 
		 
		 
		
		  j++;		
		  if(j==1){			  
			  $("#usr1").show();			  
		  }		 
		  if(j==2){
			  $("#usr2").show();
		  }
		  if(j==3){
			  $("#usr3").show();
		  }
		  if(j==4){
			  $("#usr4").show();
		  }
		  if(j==5){
			  $("#usr5").show();
		  }
	}
	 
	  //Tab3
	function addUsers1(){
		if(document.getElementById("doctype").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search Doc Type";
		 document.getElementById("doctype").focus();
	     return 0;
		}
		if($('#mode').val()=="E")
			   
		   {

		   if(parseInt(document.getElementById("txtfirst_userdoc1").value)>0)
			  {
			   k=1;
			   
			  } 
		   
		   if(parseInt(document.getElementById("txtfirst_userdoc2").value)>0)
			  {
			   k=2;
			  } 
		   
		   if(parseInt(document.getElementById("txtfirst_userdoc3").value)>0)
			  {
			   k=3;
			  } 
		   
		   if(parseInt(document.getElementById("txtfirst_userdoc4").value)>0)
			  {
			   k=4;
			  } 
		   
		   
		   }
		  k++;		
		  if(k==1){			  
			  $("#new_user1").show();			  
		  }		 
		  if(k==2){
			  $("#new_user2").show();
		  }
		  if(k==3){
			  $("#new_user3").show();
		  }
		  if(k==4){
			  $("#new_user4").show();
		  }
		  if(k==5){
			  $("#new_user5").show();
		  }
	}
	
		  function view(){	
			  //Tab1
			 //  txtfinal_userdoc1
			  if(parseInt(document.getElementById("txtfinal_userdoc1").value)>0)
				  {
				  $("#user1").show(); 
				  }
			  else
				  {
				  $("#user1").hide(); 
				  }
			  
			  if(parseInt(document.getElementById("txtfinal_userdoc2").value)>0)
			  {
			  $("#user2").show(); 
			  }
		  else
			  {
			  $("#user2").hide(); 
			  }
		  
			  
			  if(parseInt(document.getElementById("txtfinal_userdoc3").value)>0)
			  {
			  $("#user3").show(); 
			  }
		  else
			  {
			  $("#user3").hide(); 
			  }
		  
			  if(parseInt(document.getElementById("txtfinal_userdoc4").value)>0)
			  {
			  $("#user4").show(); 
			  }
		  else
			  {
			  $("#user4").hide(); 
			  }
			  if(parseInt(document.getElementById("txtfinal_userdoc5").value)>0)
			  {
			  $("#user5").show(); 
			  }
		  else
			  {
			  $("#user5").hide(); 
			  }
			 // txtsecond_userdoc txtfirst_userdoc
			  
			/*   $("#user1").hide(); 
			  $("#user2").hide();
			  $("#user3").hide();
			  $("#user4").hide();
			  $("#user5").hide();  */
			  //Tab2
			  
			   if(parseInt(document.getElementById("txtsecond_userdoc1").value)>0)
			  {
			  $("#usr1").show(); 
			  }
		  else
			  {
			  $("#usr1").hide(); 
			  }
			   if(parseInt(document.getElementById("txtsecond_userdoc2").value)>0)
				  {
				  $("#usr2").show(); 
				  }
			  else
				  {
				  $("#usr2").hide(); 
				  }
			   
			   if(parseInt(document.getElementById("txtsecond_userdoc3").value)>0)
				  {
				  $("#usr3").show(); 
				  }
			  else
				  {
				  $("#usr3").hide(); 
				  }
			  
			   if(parseInt(document.getElementById("txtsecond_userdoc4").value)>0)
				  {
				  $("#usr4").show(); 
				  }
			  else
				  {
				  $("#usr4").hide(); 
				  }
				  
			   if(parseInt(document.getElementById("txtsecond_userdoc5").value)>0)
				  {
				  $("#usr5").show(); 
				  }
			  else
				  {
				  $("#usr5").hide(); 
				  }
	/* 		  $("#usr1").hide(); 
			  $("#usr2").hide();
			  $("#usr3").hide();
			  $("#usr4").hide();
			  $("#usr5").hide(); */
			  //Tab3
			  
			  
			  if(parseInt(document.getElementById("txtfirst_userdoc1").value)>0)
			  {
			  $("#new_user1").show(); 
			  }
		  else
			  {
			  $("#new_user1").hide(); 
			  }
			  if(parseInt(document.getElementById("txtfirst_userdoc2").value)>0)
			  {
			  $("#new_user2").show(); 
			  }
		  else
			  {
			  $("#new_user2").hide(); 
			  }
			  if(parseInt(document.getElementById("txtfirst_userdoc3").value)>0)
			  {
			  $("#new_user3").show(); 
			  }
		  else
			  {
			  $("#new_user3").hide(); 
			  }
			  if(parseInt(document.getElementById("txtfirst_userdoc4").value)>0)
			  {
			  $("#new_user4").show(); 
			  }
		  else
			  {
			  $("#new_user4").hide(); 
			  }
			  if(parseInt(document.getElementById("txtfirst_userdoc5").value)>0)
			  {
			  $("#new_user5").show(); 
			  }
		  else
			  {
			  $("#new_user5").hide(); 
			  }
		/* 	  $("#new_user1").hide(); 
			  $("#new_user2").hide();
			  $("#new_user3").hide();
			  $("#new_user4").hide();
			  $("#new_user5").hide();  */
		  } 
		   
		 
		  function getUser(event){
				 var x= event.keyCode;
				 if(x==114){
					 if ($("#mode").val() == "A") {   
					 $('#userinfoWindow').jqxWindow('open');
			
					 
				  	  changeContent2('doctypesearch.jsp');
					 }
				 }
				 else{
					 }
				 }
		   
				
		  function changeContent2(url) {
				// alert(url);
				
				    $.get(url).done(function (data) {

  $('#userinfoWindow').jqxWindow('setContent', data);
				
					
				}); 
				}
		  
		  
		  function funSearchBtn11(count,levels){
				 // alert(level);
				  //alert("sfdgfg");
				  var txtuserdoc=document.getElementById("txtuserdoc").value;
				 $('#userWindow').jqxWindow('open');
				 changeContent1('apprUserSearch.jsp?count='+count+'&levels='+levels+'&txtuserdoc='+txtuserdoc, $('#userWindow'));
			  }
		  function funFocus(){
				//document.getElementById("code").focus();
			}
		  function funSearchLoad(){
				
				changeContent('approveSearch.jsp'); 
			 }
		  
		  function changeContent1(url,fname) {
				// alert(url);
					 $.get(url).done(function (data) {
						 //alert(data);
					$(fname).jqxWindow('setContent', data);
				}); 
				}
		  function funResetbtn1(tab,resets)
		  {
			 /*  alert(tab);
			  alert(resets) */
			  var resetlevel=resets;
			  
			  if(resetlevel=="final") 
				  {
				  
			  document.getElementById('txtfinal_user'+tab).value='';
			  document.getElementById('txtfinal_userfull'+tab).value='';
			  document.getElementById('txtfinal_userdoc'+tab).value='';
			  
				  }else{}
			  if(resetlevel=="second")
			  {
			  document.getElementById('txtsecond_user'+tab).value='';
			  document.getElementById('txtsecond_userdoc'+tab).value='';			  
			  document.getElementById('txtsecond_userfull'+tab).value='';
			  
			  }else{}
			  if(resetlevel=="first")
			  {
			  document.getElementById('txtfirst_user'+tab).value='';
			  document.getElementById('txtfirst_userdoc'+tab).value='';
			  document.getElementById('txtfirst_userfull'+tab).value='';
			  }else{}
		  }
		  function funChkButton(){
				
				//alert(levels);
				
				frmApprovalMaster.submit();	
				
		  }
			function funNotify(){
				//alert(levels);
					if(document.getElementById("doctype").value=="")
		            	{
			
						 document.getElementById("errormsg").innerText="Search Doc Type";
						 document.getElementById("doctype").focus();
					     return 0;
			            }
			             return 1;
				//frmAccountmaster.submit();		
			}
			
			function setValues() {
				
	
           
				
				if(parseInt($('#chckfinalmodifyval').val())==1)
					{
					
					 document.getElementById("chckfinalmodify").checked=true;
					
			
					}
				
				
				
				
				if(parseInt($('#chcksecondmodifyval').val())==1)
				{
					
					 document.getElementById("chcksecondmodify").checked=true;
				}
				if(parseInt($('#chckfirstmodifyval').val())==1)
				{
					document.getElementById("chckfirstmodify").checked=true;
				}
			
				 if($('#msg').val()!=""){
					   $.messager.alert('Message',$('#msg').val());
					  } 
				 funSetlabel();
				 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		}
			
</script>
</head>
<body onload="view();setValues();" class='default'>
<div id="mainBG" class="homeContent" data-type="background">
  <form id="frmApprovalMaster" action="saveApprovalMaster" method="post" autocomplete="off" > 
 <jsp:include page="../../../../header.jsp"></jsp:include><br/>  
 <br>
<div style="width:100%;">
<fieldset>
<br>
<table  id="main"  width="100%"><tr><td  width="100%">
<table width="100%" >
  <tr>
    <td width="11%" align="right">Doc Type</td>
    <td width="10%"><input type="text" id="doctype" name="doctype" style="width:85%;" placeholder="Press F3 To Search" value='<s:property value="doctype"/>' required="required" onKeyDown="getUser(event);" readonly/></td>
    <td width="28%" ><input type="text" id="doctypename" name="doctypename" style="width:90%;" value='<s:property value="doctypename"/>' readonly /> </td>
    <td width="29%" align="right">Doc No</td>
    <td width="18%"><input type="text" id="docno" name="docno" tabindex="-1" style="width:50%;" value='<s:property value="docno"/>'/></td>
  </tr>
</table>
<br/>
<div id="jqxTabs" >
<ul >
    <li>Final Level</li>
    <li>Second Level</li>
    <li>First Level</li>
    </ul>
 

<div id="level1" >
<table width="100%" id="lev1">
<br/><br/><br/>
  <tr>
  <td width="6%"></td>  
    <td width="12%"><!-- <button class="myButton" id="addUser1" name="addUser1" type="button" value="Add User" onclick="addUser1();">&nbsp;&nbsp;Add User</button> -->
    <input type="button" class="myButton" id="addUser" name="addUser" value="AddUser" onclick="addUser1();" readonly >
    </td>
    <td width="8%" align="right"><input type="checkbox" id="chckfinalmodify" name="chckfinalmodify" value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)" />&nbsp;Modify
    <!-- <input type="text" id="chckfinalmodify" name="chckfinalmodify" value="0"/>  -->
   </td>
    
    <td width="11%" align="right">Min. Approval</td>
    <td width="69%"><input type="text" id="txtfinal_minapproval" name="txtfinal_minapproval" style="width:30%"  value='<s:property value="txtfinal_minapproval"/>'/></td>
    <!-- <td width="11%" align="right"><input type="checkbox" name="final_sendmail"/>&nbsp;Send Mail</td>
    <td width="11%" align="right">Forward To</td>
    <td width="33%"><input type="text" name="final_forwardto" style="width:90%"/></td> -->
    
  </tr>
</table>
<br /><br /><br /><br /><br /><br/>
<div id="users">
<div id="user1">
<table width="100%">
  <tr>                                 <!-- ---------------------------------------------------final---------------------------------------------- -->
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfinal_user1" name="txtfinal_user1"  style="width:90%" value='<s:property value="txtfinal_user1"/>'/>
    <input type="hidden" name="txtfinal_userdoc1" id="txtfinal_userdoc1" value='<s:property value="txtfinal_userdoc1"/>'>
    </td>
    <td width="31%"><input type="text" id="txtfinal_userfull1" name="txtfinal_userfull1" style="width:90%" value='<s:property value="txtfinal_userfull1"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfinal_mandatory1" name="chckfinal_mandatory1" value='<s:property value="chckfinal_mandatory1"/>'/>&nbsp;Mandatory</td> --%>
<td width="6%"><button type="button" class="icon" id="final_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level1')">
							<img alt="search" src="../../../../icons/search_new.png">
	</button></td>
<td width="31%"><button type="button" class="icon" id="final_btnCancel1" title="Remove" onclick="funResetbtn1(1,'final')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png">
	</button></td>
  </tr></table></div>
<div id="user2">
  <table   width="100%" >
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%%"><input type="text" id="txtfinal_user2" name="txtfinal_user2" style="width:90%" value='<s:property value="txtfinal_user2"/>'/>
    
     <input type="hidden" name="txtfinal_userdoc2" id="txtfinal_userdoc2" value='<s:property value="txtfinal_userdoc2"/>'>
    </td>
    <td width="31%"><input type="text" id="txtfinal_userfull2" name="txtfinal_userfull2" style="width:90%" value='<s:property value="txtfinal_userfull2"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfinal_mandatory2" name="chckfinal_mandatory2" value='<s:property value="chckfinal_mandatory2"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="final_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level1')">
							<img alt="search" src="../../../../icons/search_new.png">
	</button></td>
    <td width="31%"><button type="button" class="icon" id="final_btnCancel2" title="Remove" onclick="funResetbtn1(2,'final')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png">
	</button></td>
  </tr></table>
  
  </div>


  <div id="user3" >
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfinal_user3" name="txtfinal_user3" style="width:90%" value='<s:property value="txtfinal_user3"/>'/>
    
         <input type="hidden" name="txtfinal_userdoc3" id="txtfinal_userdoc3" value='<s:property value="txtfinal_userrole3"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtfinal_userfull3" name="txtfinal_userfull3" style="width:90%" value='<s:property value="txtfinal_userfull3"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfinal_mandatory3" name="chckfinal_mandatory3" value='<s:property value="chckfinal_mandatory3"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="final_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level1')">
							<img alt="search" src="../../../../icons/search_new.png">
	</button></td>
    <td width="31%"><button type="button" class="icon" id="final_btnCancel3" title="Remove" onclick="funResetbtn1(3,'final')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png">
	</button></td>
  </tr></table>
  </div>
  
  <div id="user4">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfinal_user4" name="txtfinal_user4" style="width:90%" value='<s:property value="txtfinal_user4"/>'/>
    <input type="hidden" name="txtfinal_userdoc4" id="txtfinal_userdoc4" value='<s:property value="txtfinal_userdoc4"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtfinal_userfull4" name="txtfinal_userfull4" style="width:90%" value='<s:property value="txtfinal_userfull4"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfinal_mandatory4" name="chckfinal_mandatory4" value='<s:property value="chckfinal_mandatory4"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="final_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level1')">
							<img alt="search" src="../../../../icons/search_new.png">
	</button></td>
    <td width="31%"><button type="button" class="icon" id="final_btnCancel4" title="Remove" onclick="funResetbtn1(4,'final')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png">
	</button></td>
  </tr></table>
  </div>
  
  <div id="user5">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfinal_user5" name="txtfinal_user5" style="width:90%" value='<s:property value="txtfinal_user5"/>'/>
    
    <input type="hidden" name="txtfinal_userdoc5" id="txtfinal_userdoc5" value='<s:property value="txtfinal_userdoc5"/>'>
  </td>
    <td width="31%"><input type="text" id="txtfinal_userfull5" name="txtfinal_userfull5" style="width:90%" value='<s:property value="txtfinal_userfull5"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfinal_mandatory5" name="chckfinal_mandatory5" value='<s:property value="chckfinal_mandatory5"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="final_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level1')">
							<img alt="search" src="../../../../icons/search_new.png">
	</button></td>
    <td width="31%"><button type="button" class="icon" id="final_btnCancel5" title="Remove" onclick="funResetbtn1(5,'final')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png">
	</button></td>
  </tr>
</table>
</div>

</div>

</div>
<div id="level2"  >
<table width="100%"  id="lev2"> 
<br/><br/><br/>
  <tr>
  <td width="6%"></td>   <!-- ---------------------------------------------------second---------------------------------------------- -->
    <td width="12%"><!-- <button class="myButton" id="addUsr" type="button" onclick="addUsr();">&nbsp;&nbsp;Add User</button> -->
    <input type="button" class="myButton" id="addUsr" value="AddUser" name="addUsr" onclick="addUsr1();">
    
    </td>
    <td width="8%" align="right"><input type="checkbox" id="chcksecondmodify" name="chcksecondmodify"   value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)" />&nbsp;Modify</td>
    <td width="11%" align="right">Min. Approval</td>
    <td width="69%"><input type="text" id="txtsecond_minapproval" name="txtsecond_minapproval" style="width:30%" value='<s:property value="txtsecond_minapproval"/>'/></td>
    <!-- <td width="11%" align="right"><input type="checkbox" name="second_sendmail"/>&nbsp;Send Mail</td>
    <td width="11%" align="right">Forward To</td>
    <td width="33%"><input type="text" name="second_forwardto" style="width:90%"/></td> -->
       
    
  </tr>
</table>
<br /><br /><br /><br /><br /><br />
<div id="usrs">
<div id="usr1">
<table width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtsecond_user1" name="txtsecond_user1" style="width:90%" value='<s:property value="txtsecond_user1"/>'/>
    <input type="hidden" name="txtsecond_userdoc1" id="txtsecond_userdoc1" value='<s:property value="txtsecond_userdoc1"/>'>
    </td>
    <td width="31%"><input type="text" id="txtsecond_userfull1" name="txtsecond_userfull1" style="width:90%" value='<s:property value="txtsecond_userfull1"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chcksecond_mandatory1" name="chcksecond_mandatory1" value='<s:property value="chcksecond_mandatory1"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="second_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level2')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="second_btnCancel1" title="Remove" onclick="funResetbtn1(1,'second')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
    </tr></table></div>
  
  <div id="usr2" >
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtsecond_user2" name="txtsecond_user2" style="width:90%" value='<s:property value="txtsecond_user2"/>'/>
        <input type="hidden" name="txtsecond_userdoc2" id="txtsecond_userdoc2" value='<s:property value="txtsecond_userdoc2"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtsecond_userfull2" name="txtsecond_userfull2" style="width:90%" value='<s:property value="txtsecond_userfull2"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chcksecond_mandatory2" name="chcksecond_mandatory2" value='<s:property value="chcksecond_mandatory2"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="second_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level2')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="second_btnCancel2" title="Remove" onclick="funResetbtn1(2,'second')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
   </tr></table>
   </div>
  
  <div id="usr3">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtsecond_user3" name="txtsecond_user3" style="width:90%" value='<s:property value="txtsecond_user3"/>'/>
        <input type="hidden" name="txtsecond_userdoc3" id="txtsecond_userdoc3" value='<s:property value="txtsecond_userdoc3"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtsecond_userfull3" name="txtsecond_userfull3" style="width:90%" value='<s:property value="txtsecond_userfull3"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chcksecond_mandatory3" name="chcksecond_mandatory3" value='<s:property value="chcksecond_mandatory3"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="second_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level2')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="second_btnCancel3" title="Remove" onclick="funResetbtn1(3,'second')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table>
  </div>
  
  <div id="usr4">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtsecond_user4" name="txtsecond_user4" style="width:90%" value='<s:property value="txtsecond_user4"/>'/>
        <input type="hidden" name="txtsecond_userdoc4" id="txtsecond_userdoc4" value='<s:property value="txtsecond_userdoc4"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtsecond_userfull4" name="txtsecond_userfull4" style="width:90%" value='<s:property value="txtsecond_userfull4"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chcksecond_mandatory4" name="chcksecond_mandatory4" value='<s:property value="chcksecond_mandatory4"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="second_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level2')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="second_btnCancel4" title="Remove" onclick="funResetbtn1(4,'second')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table>
  </div>
  
  <div id="usr5">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtsecond_user5" name="txtsecond_user5" style="width:90%" value='<s:property value="txtsecond_user5"/>'/>
        <input type="hidden" name="txtsecond_userdoc5" id="txtsecond_userdoc5" value='<s:property value="txtsecond_userdoc5"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtsecond_userfull5" name="txtsecond_userfull5" style="width:90%" value='<s:property value="txtsecond_userfull5"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chcksecond_mandatory5" name="chcksecond_mandatory5" value='<s:property value="chcksecond_mandatory5"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="second_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level2')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="second_btnCancel5" title="Remove" onclick="funResetbtn1(5,'second')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr>
</table>
</div></div>
</div>

<div id="level3" >
<table width="100%"  id="lev3">  
<br/><br/><br/> 
  <tr>
  <td width="6%"></td>   <!-- ---------------------------------------------------first---------------------------------------------- -->
    <td width="12%">
    
    <input type="button" class="myButton" id="addUsers" value="AddUser" name="addUsers" onclick="addUsers1();">
    
    </td>
    <td width="8%" align="right"><input type="checkbox" id="chckfirstmodify" name="chckfirstmodify"   value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)" />&nbsp;Modify
  
    </td>
    <td width="11%" align="right">Min. Approval</td>
    <td width="69%"><input type="text" id="txtfirst_minapproval" name="txtfirst_minapproval" style="width:30%" value='<s:property value="txtfirst_minapproval"/>'/></td>
    <!-- <td width="11%" align="right"><input type="checkbox" name="second_sendmail"/>&nbsp;Send Mail</td>
    <td width="11%" align="right">Forward To</td>
    <td width="33%"><input type="text" name="second_forwardto" style="width:90%"/></td> -->
    
    
  </tr>
</table>
<br /><br /><br /><br /><br /><br />
<div id="new_users">
<div id="new_user1">
<table width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfirst_user1" name="txtfirst_user1" style="width:90%" value='<s:property value="txtfirst_user1"/>'/>
        <input type="hidden" name="txtfirst_userdoc1" id="txtfirst_userdoc1" value='<s:property value="txtfirst_userdoc1"/>'>
    
    
    </td>
    <td width="31%"><input type="text" id="txtfirst_userfull1" name="txtfirst_userfull1" style="width:90%" value='<s:property value="txtfirst_userfull1"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfirst_mandatory1" name="chckfirst_mandatory1" value='<s:property value="chckfirst_mandatory1"/>' />&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="first_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level3')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="first_btnCancel1" title="Remove" onclick="funResetbtn1(1,'first')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table></div>
  
  <div id="new_user2">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfirst_user2" name="txtfirst_user2" style="width:90%" value='<s:property value="txtfirst_user2"/>'/>
            <input type="hidden" name="txtfirst_userdoc2" id="txtfirst_userdoc2" value='<s:property value="txtfirst_userdoc2"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtfirst_userfull2" name="txtfirst_userfull2" style="width:90%" value='<s:property value="txtfirst_userfull2"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfirst_mandatory2" name="chckfirst_mandatory2" value='<s:property value="chckfirst_mandatory2"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="first_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level3')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="first_btnCancel2" title="Remove" onclick="funResetbtn1(2,'first')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table>
  </div>
  
  <div id="new_user3">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfirst_user3" name="txtfirst_user3" style="width:90%" value='<s:property value="txtfirst_user3"/>'/>
            <input type="hidden" name="txtfirst_userdoc3" id="txtfirst_userdoc3" value='<s:property value="txtfirst_userdoc3"/>'>
    
    </td>
    <td width="31%"><input type="text" id="txtfirst_userfull3" name="txtfirst_userfull3" style="width:90%" value='<s:property value="txtfirst_userfull3"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfirst_mandatory3" name="chckfirst_mandatory3" value='<s:property value="chckfirst_mandatory3"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="first_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level3')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="first_btnCancel3" title="Remove" onclick="funResetbtn1(3,'first')"  >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table>
  </div>
  
  <div id="new_user4">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfirst_user4" name="txtfirst_user4" style="width:90%" value='<s:property value="txtfirst_user4"/>'/>
            <input type="hidden" name="txtfirst_userdoc4" id="txtfirst_userdoc4" value='<s:property value="txtfirst_userdoc4"/>'>
    
    
    </td>
    <td width="31%"><input type="text" id="txtfirst_userfull4" name="txtfirst_userfull4" style="width:90%" value='<s:property value="txtfirst_userfull4"/>'/></td>
    <%-- <td width="10"><input type="checkbox" id="chckfirst_mandatory4" name="chckfirst_mandatory4" value='<s:property value="chckfirst_mandatory4"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="first_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level3')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="first_btnCancel4" title="Remove" onclick="funResetbtn1(4,'first')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr></table>
  </div>
  
  <div id="new_user5">
  <table  width="100%">
  <tr>
    <td width="6%" align="right">User</td>
    <td width="16%"><input type="text" id="txtfirst_user5" name="txtfirst_user5" style="width:90%" value='<s:property value="txtfirst_user5"/>'/>
            <input type="hidden" name="txtfirst_userdoc5" id="txtfirst_userdoc5" value='<s:property value="txtfirst_userdoc5"/>'>
    
    
    </td>
    <td width="31%"><input type="text" id="txtfirst_userfull5" name="txtfirst_userfull5" style="width:90%" value='<s:property value="txtfirst_userfull5"/>'/></td>
    <%-- <td width="10%"><input type="checkbox" id="chckfirst_mandatory5" name="chckfirst_mandatory5" value='<s:property value="chckfirst_mandatory5"/>'/>&nbsp;Mandatory</td> --%>
    <td width="6%"><button type="button" class="icon" id="first_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level3')">
							<img alt="search" src="../../../../icons/search_new.png"></button></td>
    <td width="31%"><button type="button" class="icon" id="first_btnCancel5" title="Remove" onclick="funResetbtn1(5,'first')" >
							<img alt="Remove" src="../../../../icons/cancel_new.png"></button></td>
  </tr>
</table>
</div></div>
</div>
	</div>		 
		
		  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>		
  <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
</td>
</tr>
</table>
</fieldset>

</div>

<!-- =====================================================modify -->


 		  <input type="hidden" id="chckfinalmodifyval" name="chckfinalmodifyval"  value='<s:property value="chckfinalmodifyval"/>'/>	
 		  <input type="hidden" id="chcksecondmodifyval" name="chcksecondmodifyval"  value='<s:property value="chcksecondmodifyval"/>'/>	
 		  <input type="hidden" id="chckfirstmodifyval" name="chckfirstmodifyval"  value='<s:property value="chckfirstmodifyval"/>'/>	

<!-- =====================================================mandatory --> 

<!-- chckfinal_mandatory1 chcksecond_mandatory1 chckfirst_mandatory1 -->

                           <!--        ------------------------final   chckfinal_mandatory1-------------------------------- -->

	  <input type="hidden" id="chckfinal_mandatory1val" name="chckfinal_mandatory1val"  value='<s:property value="chckfinal_mandatory1val"/>'/>	
	  
	  <input type="hidden" id="chckfinal_mandatory2val" name="chckfinal_mandatory2val"  value='<s:property value="chckfinal_mandatory2val"/>'/>	
	  
	  <input type="hidden" id="chckfinal_mandatory3val" name="chckfinal_mandatory3val"  value='<s:property value="chckfinal_mandatory3val"/>'/>	
	  
	  <input type="hidden" id="chckfinal_mandatory4val" name="chckfinal_mandatory4val"  value='<s:property value="chckfinal_mandatory4val"/>'/>	
	  
	  <input type="hidden" id="chckfinal_mandatory5val" name="chckfinal_mandatory5val"  value='<s:property value="chckfinal_mandatory5val"/>'/>
	  
	  <input type="hidden" id="txtuserdoc" name="txtuserdoc"  value='<s:property value="txtuserdoc"/>'/>
	  

 
 
 
                 <!--        ------------------------second   chcksecond_mandatory1-------------------------------- -->

	  <input type="hidden" id="chcksecond_mandatory1val" name="chcksecond_mandatory1val"  value='<s:property value="chcksecond_mandatory1val"/>'/>	
	  
	  <input type="hidden" id="chcksecond_mandatory2val" name="chcksecond_mandatory2val"  value='<s:property value="chcksecond_mandatory2val"/>'/>	
	  
	  <input type="hidden" id="chcksecond_mandatory3val" name="chcksecond_mandatory3val"  value='<s:property value="chcksecond_mandatory3val"/>'/>	
	  
	  <input type="hidden" id="chcksecond_mandatory4val" name="chcksecond_mandatory4val"  value='<s:property value="chcksecond_mandatory4val"/>'/>	
	  
	  <input type="hidden" id="chcksecond_mandatory5val" name="chcksecond_mandatory5val"  value='<s:property value="chcksecond_mandatory5val"/>'/>	
	  
	  
	   
 
                 <!--        ------------------------second   chcksecond_mandatory1-------------------------------- -->

	  <input type="hidden" id="chckfirst_mandatory1val" name="chckfirst_mandatory1val"  value='<s:property value="chckfirst_mandatory1val"/>'/>	
	  
	  <input type="hidden" id="chckfirst_mandatory2val" name="chckfirst_mandatory2val"  value='<s:property value="chckfirst_mandatory2val"/>'/>	
	   
	  <input type="hidden" id="chckfirst_mandatory3val" name="chckfirst_mandatory3val"  value='<s:property value="chckfirst_mandatory3val"/>'/>	
	    
	  <input type="hidden" id="chckfirst_mandatory4val" name="chckfirst_mandatory4val"  value='<s:property value="chckfirst_mandatory4val"/>'/>	
	     
	  <input type="hidden" id="chckfirst_mandatory5val" name="chckfirst_mandatory5val"  value='<s:property value="chckfirst_mandatory5val"/>'/>	
	  

	  
	

</form>
<div id="userWindow">
	<div >
</div>
</div>
<div id="userinfoWindow">
	<div >
</div>
</div>


</div>

</body>
</html>