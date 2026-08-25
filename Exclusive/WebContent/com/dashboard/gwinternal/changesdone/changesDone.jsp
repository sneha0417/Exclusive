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
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#clientDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Clients Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdtobecopied").checked=true;
	     
	     $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
	     });
	     
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getProjects() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var projectNameItems = items[0].split(",");
  				var projectIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < projectNameItems.length; i++) {
  					optionsproject += '<option value="' + projectIdItems[i] + '">'
  							+ projectNameItems[i] + '</option>';
  				}
  				$("select#cmbproject").html(optionsproject);
  				if ($('#hidcmbproject').val() != null) {
  					$('#cmbproject').val($('#hidcmbproject').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getProjects.jsp", true);
  		x.send();
  	}
	
	function funExportBtn(){
		 JSONToCSVCon(data, 'ChangesDone', true);
	 }
	
	function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent('clientDetailsSearch.jsp');
        }
        else{}
        }

	function funreload(event){
		     
		     var branchval = document.getElementById("cmbbranch").value;
		     var fromdate = $('#fromdate').val();
		 	 var todate = $('#todate').val();
		 	 var cldocno = $('#txtcldocno').val();
			 var project = $('#cmbproject').val();
			 
			  $("#changesDoneGridID").jqxGrid('clear');
			  $("#changesDoneGridID").jqxGrid('addrow', null, {});
			  
			 if(document.getElementById("rdtobecopied").checked==true){
				 $("#overlay, #PleaseWait").show();
			 	 $("#changesDoneDiv").load("changesDoneGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&project='+project+'&check=1');
			 } else if(document.getElementById("rdcopied").checked==true){
				 
				 if(cldocno==''){
					 $.messager.alert('Message','Choose a Client.','warning');
					 return 0;
				 }
				 
				 $("#overlay, #PleaseWait").show();
				 $("#changesDoneDiv").load("changesDoneGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&project='+project+'&check=1');
			 }
		}
	
	function getUpdate(event){
		 var cldocno = $('#txtcldocno').val();
		 
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		 }
		
		var selectedrows=$("#changesDoneGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select Items to be Updated.');
			return false;
		}
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 
		     		var rows = $('#changesDoneGridID').jqxGrid('getrows');
		     		var i=0;var temp="";
			        $('#gridlength').val(selectedrows.length);
			        var j=0;
				    for (i = 0; i < rows.length; i++) {
							if(selectedrows[j]==i){
								
								if(i==0){
									temp=rows[i].doc_no;
								}
								else{
									temp=temp+"::"+rows[i].doc_no;
								}
								temp1=temp;
							j++; 
						  }
			            }
				    $('#txtselecteddocs').val(temp1);
				    
		     		 saveGridData(cldocno,$('#txtselecteddocs').val()); 	
		     	}
		 });
	}
	
	function saveGridData(cldocno,docnos){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				 $('#cmbbranch').val('a');
		    	 $('#fromdate').val(new Date());
		    	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
			     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			     
				 $('#todate').val(new Date());
				 
				 $('#txtselecteddocs').val('');$('#gridlength').val('');
				
				 document.getElementById("rdtobecopied").checked=true;
				 
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?cldocno="+cldocno+"&docnos="+docnos,true);
	x.send();
	}
	
	function funClearInfo(){

   	 	 $('#cmbbranch').val('a');
   	     $('#fromdate').val(new Date());
   	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());

		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#cmbproject').val('');
		 
		 $('#txtselecteddocs').val('');$('#gridlength').val('');
			
		 document.getElementById("rdtobecopied").checked=true;
		
		 $("#changesDoneGridID").jqxGrid('clear');$("#changesDoneGridID").jqxGrid('addrow', null, {});$("#changesDoneGridID").jqxGrid('clearselection');
		
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		  }
		 
		
		}
	
</script>

</head>
<body onload="getBranch();getProjects();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
    <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
    <tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly"  placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);"/>
	<input type="hidden" id="txtcldocno" name="txtcldocno" style="width:75%;height:20px;" value='<s:property value="txtcldocno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Project</label></td>
	<td align="left"><select id="cmbproject" name="cmbproject" style="width:71%;" value='<s:property value="cmbproject"/>'>
      <option></option></select></td></tr> 
    <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="52%" align="center"><input type="radio" id="rdtobecopied" name="rdo" value="rdtobecopied"><label for="rdtobecopied" class="branch">To be Copied</label></td>
       <td width="48%" align="center"><input type="radio" id="rdcopied" name="rdo" value="rdcopied"><label for="rdcopied" class="branch">Copied</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;&nbsp;
	<button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onclick="getUpdate(event);">Update</button></td></tr>
	<tr><td colspan="2"><input type="hidden" name="txtselecteddocs" id="txtselecteddocs" style="width:100%;height:20px;" value='<s:property value="txtselecteddocs"/>'>
	<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>  
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="changesDoneDiv"><jsp:include page="changesDoneGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div>
</div>

</div> 
</body>
</html>