
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	
	   //$("test").hide();
	   
	   $("#test").hide();
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     
     document.getElementById("rdp").checked="true";
     document.getElementById("isradio").value=1;
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
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
	
	   
	   function funClear(){
		    $("#jqxpinvGrid").jqxGrid('clear');
		    $("#jqxInvCount").jqxGrid('clear');
		    $("#jqxpsrvDetGrid").jqxGrid('clear');
			$("#jqxpinvDetGrid").jqxGrid('clear'); 
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
	   }
	   
	   function setValues(){

			 if($('#msg').val()!=""){
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	   
	   
	   function funreload()
	   {

	   	 var clientid=$('#clientid').val();
	   	 var date=$('#todate').val();
	   	 var barchval = document.getElementById("cmbbranch").value;
	        var dtype="0";
	        var id=1;
	        hidcolumn(0);
			$("#test").hide();
				
			var isradio=document.getElementById("isradio").value;
			
			if(!(isradio==1 || isradio==2 )){
				 $.messager.alert('Message','Select Report Type');
				 return 0;
			}
			
	       if(id>0){
	       	countload(id);
	       }
	        
	   	}
	   
		 function countload(id){
			 
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			 var isradio =document.getElementById("isradio").value;
			 
			    $("#jqxpinvGrid").jqxGrid('clear'); 
				$("#jqxpinvDetGrid").jqxGrid('clear');
				$("#jqxpsrvDetGrid").jqxGrid('clear'); 
				
				   $("#jqxpinvGrid").jqxGrid('addrow', null, {});
				   $("#overlay, #PleaseWait").show();
				   $("#invCountgrid").load("invCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isradio="+isradio);

		 }
		 function getProcess() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						
						var srno  = items[0].split(",");
						var process = items[1].split(",");
						var optionsbranch = '<option value="" selected>-- Select -- </option>';
						for (var i = 0; i < process.length; i++) {
							optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
									+ process[i] + '</option>';
						}
						$("select#cmbprocess").html(optionsbranch);
						
					} else {}
				}
				x.open("GET","getProcess.jsp", true);
				x.send();
			}
		 
		 function funNotify(){
				
			 var dtype=$('#dtype').val();
		     var trno=$('#trno').val();
		     var docno=$('#docno').val();
		     var brch=$('#brch').val();
		     var prtype=$('#cmbpaytype').val();
		     
			saveGridData(dtype,trno,docno,brch,prtype);
		}

		 function saveGridData(dtype,trno,docno,brch,prtype){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						if(parseInt(items)=="1")
						{
						$.messager.alert('Message', ' '+dtype+ ' - '+docno+' completed Successfully ');
						
						$('#dtype').val('');
            		     $('#trno').val('');
            		     $('#docno').val('');
            		     $('#brch').val('');
						 
						}
						else
							{
							$.messager.alert('Message', '  Not Updated  ');
							}
						
				  }
				}
			
					
			x.open("GET","saveData.jsp?docno="+docno+"&dtype="+dtype+"&process="+prtype+"&trnos="+trno+"&brhid="+brch,true);
			x.send();
	}	
		 
		 
		 function hidcolumn(iserv){
			 
			 if(iserv>0){
			    	$('#jqxpsrvDetGrid').jqxGrid('showcolumn','amt');
			    	$('#jqxpsrvDetGrid').jqxGrid('showcolumn','invno');
			    }
			    else{
			    	$('#jqxpsrvDetGrid').jqxGrid('hidecolumn','amt');
			    	$('#jqxpsrvDetGrid').jqxGrid('hidecolumn','invno');
			    }
			 
		 }
		 
		 function workper(){
			 var rowlen = $("#jqxpsrvDetGrid").jqxGrid('getrows');
        	 if(rowlen.length>0){
     
        	 var aid=0;
        	 var workper=0;
        	 for(var i=0 ; i < rowlen.length; i++){
        		 
        		 workper =parseFloat(workper) + parseFloat($('#jqxpsrvDetGrid').jqxGrid('getcellvalue', i, "workper"));
        	
       
      		}
        	 aid=workper/rowlen.length;
        	 if(aid==100){
        		 $("#test").show();
        	 }
        	 else{
        		 $("#test").hide();
        	 }
       
		 }
        	 
		 } 	 
		 
		 function stacheck(){
			 
			 if(document.getElementById("rdp").checked==true){
				 
				 document.getElementById("isradio").value=1;
			 }
			 if(document.getElementById("rdc").checked==true){
				 
				 document.getElementById("isradio").value=2;
			 }
			
		 }
	     function funExportBtn(){
	 		
		  	   JSONToCSVCon(perdata1,'Contract Status Check',true);
		  	   JSONToCSVCon(perdata2,'Contract Status Check',true);
		  	   JSONToCSVCon(perdata3,'Contract Status Check',true);
		  }
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmdinvoice" action=savedInvoice method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
		<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
	  <tr><td width="27%"  align="right" ><label class="branch">Upto Date</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    
	    <tr>
	      <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
	      </tr>
	
	</table>
	<table width="100%" >
	<tr>
       <td align="right"><input type="radio" id="rdp" name="rd" value="rdp"  onclick="$(this).attr('value', this.checked ? 'rdp' : 'rdc');stacheck();"></td>
       <td align="left"><label for="lblrdp" id="lblrdp" class="branch">Progress</label>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdc" name="rd" value="rdc" onclick="$(this).attr('value', this.checked ? 'rdc' : 'rdp' );stacheck();">
       <label for="lblrdc" id="lblrdc" class="branch">Completed</label></td>
    </tr>
	
	 <tr><td colspan="2" ><div id="invCountgrid"><jsp:include page="invCountgrid.jsp"></jsp:include>
	</div></td ></tr>
	<tr><td colspan="2"><div id="test">
	<table width="100%" >
      <tr><td align="center"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbpaytype" id="cmbpaytype" style="width:60%;">
      <option value="3">Complete</option>
    </select></td></tr>             
      <tr>
	<td colspan="2"><center><input type="button" name="btncmplete" id="btncmplete" class="myButton" value="Update" onclick="funNotify();"></center></td>
	</tr> 
	</table></div></td></tr>           
	<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
	<!-- <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> -->
	<!-- <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> -->
	<tr><td colspan="2">&nbsp;</td></tr>
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
		<tr><td colspan="2"><div id="profinvdiv">
				<jsp:include page="serviceCompletionGrid.jsp"></jsp:include> 
			</div></td></tr>
			
			<tr><td  width="50%">
			<div id="profserdetdiv"><jsp:include page="serviceDetGrid.jsp"></jsp:include></div></td>
			<td width="50%">
				<div id="profinvdetdiv" ><jsp:include page="invDetGrid.jsp"></jsp:include></div></td> 
			</tr>
		</table>
		</td></tr>
			
		
	</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
              <input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'> 
			  <input type="hidden" name="formcode" id="formcode" value='<s:property value="formcode"/>'>
			  <input type="hidden" name="ptype" id="ptype" value='<s:property value="ptype"/>'>
			  <input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
			  <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'>
			  <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
			  <input type="hidden" name="brch" id="brch" value='<s:property value="brch"/>'>
			  <input type="hidden" name="isradio" id="isradio" value='<s:property value="isradio"/>'>
			
			  
</div>
</form>
</body>
</html>