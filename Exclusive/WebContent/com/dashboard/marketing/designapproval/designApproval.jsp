
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
	
	/* $('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide(); */
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			  
			$('#assigninfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Method' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#assigninfowindow').jqxWindow('close');
			
			  
			  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			
			  
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#pdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#pdate').jqxDateTimeInput('setDate', new Date());
     
     $('#txtclient').dblclick(function(){
	     $('#clientsearch1').jqxWindow('open');
     	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
     });
     $('#txtassignarea').dblclick(function(){
    	 $('#areainfowindow').jqxWindow('open');
 		areaSearchContent('area.jsp');
     });
	 
     
     $('#cmbprocess').attr("disabled",true);
     $('#assignfield').attr("disabled",true);
// 	  $('#adate').jqxDateTimeInput({ disabled: true});
	  
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

     function funExportBtn(){
    	   //$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
    //	   JSONToCSVCon(exceldata,'Service Scheduler',true);
     }
    
    function getareas(event){
    	var x= event.keyCode;
    	if(x==114){
    		$('#areainfowindow').jqxWindow('open');
    		areaSearchContent('area.jsp');
    	}
    }
	     	 
	function areaSearchContent(url) {
		$.get(url).done(function (data) {
			$('#areainfowindow').jqxWindow('setContent', data);
		}); 
	}

function funreload()
{
	var id=1;
    if(id>0){
    	gridload(id);
    }
}
	
		

	 function gridload(id){
		 
		 var clientid=$('#clientid').val();
		 var date=$('#todate').val();
		 var barchval = document.getElementById("cmbbranch").value;
	
		 var area=document.getElementById("txtareaid").value;
		 
		 $("#enqschedulegrid").jqxGrid('clear'); 
			
		 $("#overlay, #PleaseWait").show();
			 $("#enqschedulediv").load("enqScheduleDetails.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&area="+area);
		
		 
	 }
	 
	 
function save(){
		
	var description=document.getElementById("txtdescription").value;
    var process=document.getElementById("cmbprocess").value;
    var docno=document.getElementById("hiddocno").value;
    var date=$("#pdate").jqxDateTimeInput('val');
	 if($('#rowindex').val()== "")
		{
	    	$.messager.alert('Message',"select a document");
	    	return 0;
		}
	 if($("#pdate").jqxDateTimeInput('val')== "")
		{
	    	$.messager.alert('Message',"Select a date");
	    	return 0;
		}
	 if($('#cmbprocess').val()== "")
		{
	    	$.messager.alert('Message',"Select Process");
	    	return 0;
		}
    if(process=="FUP"&&description== "")
	{
    	$.messager.alert('Message',"Enter description");
    	return 0;
	}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	 items=items.split('###');
		 	 var res=items[0];
		 	if(res>0){
		 		$.messager.alert('Message',"Saved Successfully");
		 		document.getElementById("txtdescription").value="";
		 		document.getElementById("cmbprocess").value="";
		 		$('#pdate').jqxDateTimeInput('setDate', new Date());
		 		
		 		$("#enqschedulegrid").jqxGrid('clear');
		 		$("#siteGrid").jqxGrid('clear');
		 		$("#enqschedulediv").load("enqScheduleDetails.jsp?barchval="+$('#cmbbranch').val()+"&date="+$('#todate').val()+"&clientid="+$('#clientid').val()+"&id=1&area="+$('#txtareaid').val());
		 	}
		 	else{
		 		$.messager.alert('Message',"Not Updated");
		 	}
		}
		else
		{}
		}
		x.open("GET","saveEnqschedule.jsp?docno="+docno+"&description="+description+"&date="+date+"&process="+process,true);
		x.send();
}
	   
	   function funClear(){
			$("#enqschedulegrid").jqxGrid('clear'); 
			$("#siteGrid").jqxGrid('clear'); 
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("hiddocno").value="";
		   document.getElementById("rowindex").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		 
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   
	   }
	function funCmbChange()
	{
	}
	
	function funAttach(){
		var docno=$("#hiddocno").val();
		var brchid=$("#cmbbranch").val(); 
 		var frmdet="CREG";
 		var url=document.URL;
		var reurl=url.split("com");
		if ($("#docno").val()!=""){
		   var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet
					 +"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					  myWindow.focus();
		}else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
</script>
</head>
<body onload="getBranch();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
<fieldset style="background: #ECF8E0;">
<table width="100%"  >
<jsp:include page="../../heading.jsp"></jsp:include>
<tr><td colspan="2"></td></tr>
<tr><td width="27%"  align="right" ><label class="branch">Upto Date</label></td>
<td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>
<tr>
<td align="right"><label class="branch">Client</label></td>
<td>
<input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
<button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"><img alt="clear" src="<%=contextPath%>/icons/clear.png"></button>
</td>
</tr>
<tr><td align="right">
<label class="branch"> Area</label>
</td>
<td>
<input style="height:19px;" type="text" name="txtassignarea" id="txtassignarea" value='<s:property value="txtassignarea"/>' onKeyDown="getareas(event);" readonly placeholder="Press F3 to Search">
<input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
</td>
</tr>


<tr><td colspan="4"><hr  size=1 color="black"  width="100%"></td></tr>  
<tr><td colspan="2"></td></tr>
<!-- <tr><td colspan="2" align="center">
<fieldset style="height:12px;">
<label id="test"   class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;height:10px;"></label>
</fieldset>
</td></tr> -->
<tr><td colspan="2"></td></tr> 
<tr><td align="right"><label class="branch">Process</label></td>
<td align="left"><select id="cmbprocess" style="width:60%;" onchange="funCmbChange();"  value='<s:property value="cmbprocess"/>'>
<option value="">--Select--</option>
<option value="FUP">FOLLOWUP</option>
<option value="DHO">DESIGN APPROVAL</option>
</select></td></tr>
<tr><td width="27%"  align="right" ><label class="branch">Date</label></td>
<td width="73%" align="left"><div id='pdate' name='pdate' value='<s:property value="pdate"/>'></div></td></tr>
<tr>
<td align="right"><label class="branch">Description</label></td>
<td colspan="2">
<input style="height:19px;" type="text" name="txtdescription" id="txtdescription" value='<s:property value="txtdescription"/>'>
</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">
<table width="100%">
<tr>
<td width="50%" align="right">
<input type="button" name="btnsave" class="myButton" value="Save" style="width: 80px;" onclick="save();"/>
</td>
<td width="50%" align="left">
<input type="button" name="btnAttach" class="myButton" value="Attach" style="width: 80px;" onclick="funAttach();"/>
</td>
</tr></table>
</td></tr>
</table>
<input type="hidden" id="hiddocno" name="hiddocno" value='<s:property value="hiddocno"/>'>
<input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
<input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
<br><br><br><br><br><br><br><br><br><br><br><br>

</fieldset>
</td>
<td width="80" style=" vertical-align: top;">
<table width="100%">
<tr><td><div id="enqschedulediv"><jsp:include page="enqScheduleDetails.jsp"></jsp:include></div><br/></td></tr>
<tr><td><div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div></td></tr>
</table>
</td>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 
<div id="grpinfowindow">
   <div ></div>
</div>
<div id="teaminfowindow">
   <div ></div>
</div>
<div id="assigninfowindow">
   <div ></div>
</div>

   <div id="areainfowindow">
   <div ></div>
</div>
</div>
</body>
</html>