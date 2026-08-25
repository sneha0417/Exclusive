<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
		 
		 $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Users Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#userDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtusername').dblclick(function(){
			  userDetailsSearchContent('userDetailsSearch.jsp');
		 });
		 
	     document.getElementById("rdlinking").checked=true;
	     $('#btnlinking').attr("disabled",true);
	     $('#btnremovelinking').attr("disabled",true);
	     
	});

	function userDetailsSearchContent(url) {
	    $('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getUserDetails(event){
        var x= event.keyCode;
        if(x==114){
        	userDetailsSearchContent('userDetailsSearch.jsp');
        }
        else{}
        }
	
	function funreload(event){
		 $('#txtsalesmanid').val('');$('#txtsalesmaninfo').val(' ');     
		 $('#btnlinking').attr("disabled",true);
	     $('#btnremovelinking').attr("disabled",true);
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdlinking").checked==true){
		 	$("#salesUserLinkDiv").load("salesUserLinkGrid.jsp?rpttype=1&check=1");
		 } else if(document.getElementById("rddelete").checked==true){
		 	$("#salesUserLinkDiv").load("salesUserLinkGrid.jsp?rpttype=2&check=1");
		 }
	}
	
	function funLinking(event){
		var userdocno = $('#txtuserdocno').val();
		var salesmanid = $('#txtsalesmanid').val();
		var rpttype="0";
		if(document.getElementById("rdlinking").checked==true){
			rpttype="1";
		}
		
		if(userdocno==''){
			 $.messager.alert('Message','Choose a User.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to link Salesman with User?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(salesmanid,userdocno,rpttype);	
		     	}
		 });
	}
	
	function funRemoveLinking(event){
		var userdocno = $('#txtuserdocno').val();
		var salesmanid = $('#txtsalesmanid').val();
		var rpttype="0";
		if(document.getElementById("rddelete").checked==true){
			rpttype="2";
		}
			
		    $.messager.confirm('Message', 'Do you want to remove link ?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		removeGridData(salesmanid,userdocno,rpttype);	
		     	}
		 });
	}
	
	function saveGridData(salesmanid,userdocno,rpttype) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				$.messager.alert('Message', '  Record Successfully Linked ', function(r){
			  });
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
	x.send();
	}
	
	function removeGridData(salesmanid,userdocno,rpttype) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				$.messager.alert('Message', '  Record Successfully Removed ', function(r){
			  });
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
	x.send();
	}
	
	function funExportBtn(){
		 JSONToCSVCon(data, 'SalesUserLink', true);
	 }
	
	function  funClearInfo() {
		    $('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=true;
			document.getElementById("rddelete").checked=false;
			$("#salesUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
	}
	
	function funClearRadioInfo() {
		
		if(document.getElementById("rdlinking").checked==true){
			$('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=true;
			document.getElementById("rddelete").checked=false;
			$("#salesUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
		} else if(document.getElementById("rddelete").checked==true){
			$('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=false;
			document.getElementById("rddelete").checked=true;
			$("#salesUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
		}
	}

	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="radio" id="rdlinking" name="rdo" onchange="funClearRadioInfo();" value="rdlinking"><label for="rdlinking" class="branch">Linking</label>&nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="radio" id="rddelete" name="rdo" onchange="funClearRadioInfo();" value="rddelete"><label for="rddelete" class="branch">Remove Linking</label></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">User</label></td>
	<td align="left"><input type="text" id="txtusername" name="txtusername" style="width:100%;height:20px;" placeholder="Press F3 to Search" readonly="readonly" onkeydown="getUserDetails(event);" value='<s:property value="txtusername"/>'/>
    <input type="hidden" id="txtuserdocno" name="txtuserdocno" value='<s:property value="txtuserdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><textarea id="txtsalesmaninfo" style="height:80px;width:200px;font: 10px Tahoma;resize:none" name="txtsalesmaninfo"  readonly="readonly"><s:property value="txtsalesmaninfo" ></s:property></textarea></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnlinking" name="btnlinking" onclick="funLinking(event);">Linking</button>&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="myButton" type="button" id="btnremovelinking" name="btnremovelinking" onclick="funRemoveLinking(event);">Remove Linking</button></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2"><input type="hidden" name="txtsalesmanid" id="txtsalesmanid" style="height:20px;width:70%;" value='<s:property value="txtsalesmanid"/>'></td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="salesUserLinkDiv"><jsp:include page="salesUserLinkGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="userDetailsWindow">
<div></div>
</div>
</div> 
</body>
</html>