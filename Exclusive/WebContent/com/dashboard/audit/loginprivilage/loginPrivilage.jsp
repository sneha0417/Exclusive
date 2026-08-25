<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		
		 $('#userDetailsSearchWindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		 $('#userDetailsSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
		 $('#btnPrivilage').attr('disabled',true);
		 document.getElementById("rdapproved").checked=true;
		 
		 $('#txtusername').dblclick(function(){
			 userSearchContent('userDetailsSearchGrid.jsp');
	     });
	});
	
	function userSearchContent(url) {
	    $('#userDetailsSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsSearchWindow').jqxWindow('setContent', data);
		$('#userDetailsSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getUser(event){
        var x= event.keyCode;
        if(x==114){
        	userSearchContent('userDetailsSearchGrid.jsp');
        }
        else{}
        }
	
	function  funClearInfo(){
		
		$('#txtusername').val('');$('#txtuserdocno').val('');
		$('#txtprivilaging').val('');$('#txtprivilageuser').val('');$('#txtprivilagemacaddress').val('');
		document.getElementById("rdapproved").checked=true;
		
		if (document.getElementById("txtusername").value == "") {
	        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		$('#btnPrivilage').attr('disabled',true);
		$("#loginPrivilageGridID").jqxGrid('clear');
		
	}
	
	function funreload(event){
		
		 $('#txtprivilaging').val('');$('#txtprivilageuser').val('');$('#txtprivilagemacaddress').val('');
		 $('#btnPrivilage').attr('disabled',true);
		 var user = document.getElementById("txtuserdocno").value;
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdapproved").checked==true){
		 	$("#loginPrivilageDiv").load("loginPrivilageGrid.jsp?user="+user+'&rpttype=1&check=1');
		 } else if(document.getElementById("rdapproval").checked==true){
			 $("#loginPrivilageDiv").load("loginPrivilageGrid.jsp?user="+user+'&rpttype=2&check=1');
		 }
	}
	
	function funPermit(event){
		var user = $('#txtprivilageuser').val();
		var macaddress = $('#txtprivilagemacaddress').val();
		
		if(user==''){
			 $.messager.alert('Message','Choose a User.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to give privilage?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(user,macaddress);	
		     	}
		 });
	}
	
	function saveGridData(user,macaddress){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
	
				var userdocno = $('#txtuserdocno').val('');
				var username = $('#txtusername').val('');
				var privilaging = $('#txtprivilaging').val('');
				var privilageuser = $('#txtprivilageuser').val('');
				var privilagemacaddress = $('#txtprivilagemacaddress').val('');
				
				if (document.getElementById("txtusername").value == "") {
			        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?user="+user+'&macaddress='+macaddress,true);
	x.send();
	}
	
	
	
	
</script>
</head>
<body onload="getBranch();">
<form id="frmDashboardUserPrivilage" action="saveDashboardUserPrivilage" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	 
	 <tr><td align="right"><label class="branch">User</label></td>
     <td align="left"><input type="text" name="txtusername" id="txtusername"  placeholder="Press F3 To Search"  readonly="readonly"   onkeydown="getUser(event)" style="height:20px;width:70%;" value='<s:property value="txtusername"/>' >
     <input type="hidden" id="txtuserdocno" name="txtuserdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtuserdocno"/>'/></td></tr>
     <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdapproved" name="rdo" value="rdapproved"><label for="rdapproved" class="branch">Approved</label></td>
       <td width="52%" align="center"><input type="radio" id="rdapproval" name="rdo" value="rdapproval"><label for="rdapproval" class="branch">Approval</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Privilage</label></b></legend>
	   <table width="100%">
       <tr><td colspan="2" align="center"><textarea id="txtprivilaging" style="height:60px;width:200px;font: 10px Tahoma;resize:none" name="txtprivilaging"  readonly="readonly"><s:property value="txtprivilaging" ></s:property></textarea></td></tr>
       </table>
	  </fieldset>
	 </td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <button class="myButton" type="button" id="btnPrivilage" name="btnPrivilage" onclick="funPermit();">Permit</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><input type="hidden" name="txtprivilageuser" id="txtprivilageuser" style="width:100%;height:20px;" value='<s:property value="txtprivilageuser"/>'>
	 <input type="hidden" name="txtprivilagemacaddress" id="txtprivilagemacaddress" style="width:100%;height:20px;" value='<s:property value="txtprivilagemacaddress"/>'></td></tr>
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="loginPrivilageDiv"><jsp:include page="loginPrivilageGrid.jsp"></jsp:include></div><br/></td></tr>
	</table>
</tr>
</table>
</div>
<div id="userDetailsSearchWindow">
	<div></div><div></div>
</div>
</div> 
</form> 
</body>
</html>