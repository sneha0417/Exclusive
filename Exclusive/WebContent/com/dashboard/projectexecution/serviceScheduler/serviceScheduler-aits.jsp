
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
	  pChange();
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			  
			$('#assigninfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Method' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#assigninfowindow').jqxWindow('close');
			
			 $('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#siteinfowindow').jqxWindow('close');
			  
			  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			
			  
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#adate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#atime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",showCalendarButton: false});
	
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#adate').jqxDateTimeInput('setDate', new Date());
     $('#atime').jqxDateTimeInput('setDate', new Date());
	/*  $('#todate').on('change', function (event) {
			
		   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(todates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 }); */
	 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
     $('#txtgroup').dblclick(function(){
		   
    	 $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp');
		   		
		 });
     
     $('#txtsite').dblclick(function(){
		   
    	 $('#siteinfowindow').jqxWindow('open');
	      siteSearchContent('servicesitesearch.jsp');
		   		
		 });
     
     
     $('#txtgrpmember').dblclick(function(){
		   
    	 var assgnid=document.getElementById("groupid").value;
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid);
		   		
		 });
     
     
     $('#txtassign').dblclick(function(){
		   
    	 $('#assigninfowindow').jqxWindow('open');
		  assignSearchContent('assignmodesearch.jsp');
		   		
		 });
	  
     $('#txtassignarea').dblclick(function(){
		   
    	 $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
		   		
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

     function funExportBtn(){
			
    	   //$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
    	   
    	   JSONToCSVCon(exceldata,'Service Scheduler',true);
    	 

    }
     
     
     function getsite(event){
    	 var x= event.keyCode;
		 if(x==114){
		  $('#siteinfowindow').jqxWindow('open');
	      siteSearchContent('servicesitesearch.jsp');
		 }
	   	 }
	   	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#siteinfowindow').jqxWindow('setContent', data);

	          	}); 
		}

    function getareas(event){
   	 var x= event.keyCode;
   	 if(x==114){
		  $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
	     	 }
    }
	     	 
	function areaSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#areainfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}

function funreload()
{

	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
     var dtype="0";
     var id=1;
   // $("#overlay, #PleaseWait").show();
   var isprior=document.getElementById("isprior").value;
   
    if(id>0){
    	//$("#serschedulediv").load("serScheduleDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype+"&id="+id+"&isprior="+isprior);
    	countload(id);
    }
     
	}
	
	
function pChange(){
	 if(document.getElementById("priority").checked){
		 
		 document.getElementById("isprior").value=1;
		
	 }
	 else{
		 document.getElementById("isprior").value=0;
		
	 }
	}

	 function countload(id){
		 
		 var clientid=$('#clientid').val();
		 var date=$('#todate').val();
		 var barchval = document.getElementById("cmbbranch").value;
		 var isprior=document.getElementById("isprior").value;
		 var site=document.getElementById("txtsite").value;
		 var area=document.getElementById("txtareaid").value;
		 var bttnview=document.getElementById("bttnview").value;
		 
		 $("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			//site=site.replace(' ', '%20').replace(' ', '%20').replace(' ', '%20');
		    site=site.replace(/ /g, "%20");
			 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+"&site="+site+"&area="+area+"&bttnview="+bttnview);
	 }
	 
	 function getgrpcode(event){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp');
	   	 }
		 else{
			 }
		 }
	   	 
	function grpSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#grpinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
		
	function getteam(event){
		 var x= event.keyCode;
		 if(x==114){
		var assgnid=document.getElementById("groupid").value;
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid);
	 	 }
		 else{
			 }
		 }
	 	 
	function teamSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#teaminfowindow').jqxWindow('setContent', data);

	        	}); 
		}	
	
	
      function getassign(event){
    	  
    	  var x= event.keyCode;
    	  
 		 if(x==114){
		  $('#assigninfowindow').jqxWindow('open');
		  
		  assignSearchContent('assignmodesearch.jsp');
		  
	 	 }
 		 else{
 			 }
 		 }
	 	 
	function assignSearchContent(url) {
		 $.get(url).done(function (data) {
			 
	$('#assigninfowindow').jqxWindow('setContent', data);

	        	}); 
		}
	
	
function save(){
		
	var groupid=document.getElementById("groupid").value;
    var grpmemberid=document.getElementById("grpmemberid").value;
    var grpempid=document.getElementById("grpempid").value;
    var assignid=document.getElementById("assignid").value;
    var trno=document.getElementById("trno").value;
    var srno=document.getElementById("srno").value;
    var clientid=document.getElementById("clientid").value;
    var dtype=document.getElementById("dtype").value;
    var brchid=document.getElementById("cmbbranch").value;
    var desc=document.getElementById("txtdesc").value;
    var rowindex=document.getElementById("rowindex").value;
    var pdate=$('#adate').val();
	 var ptime=$('#atime').val();
	 if($('#rowindex').val()== "")
		{
	    	$.messager.alert('Message',"select a document");
		
		return 0;
		}
    if($('#groupid').val()== "")
	{
    	$.messager.alert('Message',"select Assign Group");
	
	return 0;
	}
	
	if($('#grpmemberid').val()== "")
	{
		$.messager.alert('Message',"select Group Member");
	
	return 0;
	}
	
	if($('#assignid').val()== "")
	{
		$.messager.alert('Message',"Select Assign Method");
	//document.getElementById("errormsg").innerText="Select Assign Method";
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
					   
					   var clientid=$('#clientid').val();
		    			 var date=$('#todate').val();
		    			 var barchval = document.getElementById("cmbbranch").value;
			             var dtype=document.getElementById("dtype").value;
			             var rowindex=document.getElementById("rowindex").value;
			             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
			             
			             
			             document.getElementById("groupid").value="";
			             document.getElementById("grpmemberid").value="";
			            document.getElementById("grpempid").value="";
			             document.getElementById("assignid").value="";
			            document.getElementById("trno").value="";
			             document.getElementById("srno").value="";
			            document.getElementById("dtype").value="";
			             document.getElementById("txtgroup").value="";
			             document.getElementById("txtgrpmember").value="";
			             document.getElementById("txtassign").value="";
			             document.getElementById("txtdesc").value="";
			             $("#txtgroup").attr("placeholder", "press F3 for Search");
			             $("#txtgrpmember").attr("placeholder", "press F3 for Search");
			             $("#txtassign").attr("placeholder", "press F3 for Search");
			            /* $('#adate').val("");
			         	$('#atime').val(""); */
			         	$('#adate').jqxDateTimeInput('setDate', new Date());
			            $('#atime').jqxDateTimeInput('setDate', new Date());
			         
			   		 var isprior=document.getElementById("isprior").value;
			   		 var id=1;
			   			 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior);
			             
			             
		    		//$("#serschedulediv").load("serScheduleDetails.jsp?clientid"+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype);
		    		
		    		
					  }
			 	else{
			 		$.messager.alert('Message',"Not Updated");
			 	}
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","saveSchedule.jsp?groupid="+groupid+"&grpmemberid="+grpmemberid+"&grpempid="+grpempid+"&assignid="+assignid+"&trno="+trno+"&srno="+srno+"&clientid="+clientid+"&dtype="+dtype+"&brchid="+brchid+"&desc="+desc+"&pdate="+pdate+"&ptime="+ptime,true);
	     x.send();
	    
	   }
function serviceview(){
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			 	 var res=items[0];
			 	
			 	if(res>0){             
			            
			 		document.getElementById("bttnview").value="1";
			   			
		    		
					  }
			 	else{
			 		document.getElementById("bttnview").value="0";
			 	}
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","viewSchedule.jsp?",true);
	     x.send();
	    
	   }
	   
	   function funClear(){
			$("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtsite").value="";
		   document.getElementById("siteid").value="0";
		   $("#txtsite").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   
	   }
		 
	   function  funPrint()
		  {
		   
			 var doccno=$('#doccno').val();
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			
			 var isprior=document.getElementById("isprior").value;
			 var site=document.getElementById("txtsite").value;
			 var area=document.getElementById("txtareaid").value;
			  if(doccno==''){
					 $.messager.alert('Message','Please Select a Row.','warning');
					 return 0;
				 }
		   			
			 	    if ($("#doccno").val()!="") {
				        var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printservicescheduler?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
				     }
				    else {
						$.messager.alert('Message','Please Select a Client.','warning');
						return;
					}
				   }
	   function printcheck(){
			//alert("gfdyukgfy");
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					//alert("vguyewrtwyurtwy");
				 	var items= x.responseText.trim();
				 	//alert(items);
				 	document.getElementById("confvalue").value=items;
				   	
		      }
			}
		      x.open("GET","viewprint.jsp",true);
		     x.send();
		    
		   
	       }
	   function  funPrintbutton()
		  {
		  
			 var doccno=$('#doccno').val();
			 
			 var dtype=document.getElementById("dtyp").value;
			 //alert(dtype);
			 var barchval = document.getElementById("cmbbranch").value;
			
			
			 
			  if(doccno==''){
					 $.messager.alert('Message','Please Select a Row.','warning');
					 return 0;
				 }
		   			
			 	    if ($("#doccno").val()!="" && dtype=="AMC") {
				        var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printserviceschedulerAMC?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
				     }
			 	     else if($("#doccno").val()!="" && dtype=="SJOB"){
			 	    	
			 	    	var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printserviceschedulerSjob?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
			 	    	
			 	    }
			 	     
			 	    else {
						$.messager.alert('Message','Please Select a Client.','warning');
						return;
					}
				   }
	   function configCheck()
      {
			 // alert("///");
			  
			 var confvalue=document.getElementById("confvalue").value;
			// alert("confvalue:"+confvalue);
			  
			  if(confvalue==1){
				  
				  funPrintbutton();
			  }
			  else
				  {
				  funPrint();
				  }
			  }
	
	
</script>
</head>
<body onload="getBranch();serviceview();printcheck();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
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
	      <tr>
	      <td align="right"><label class="branch">Site</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsite" id="txtsite" value='<s:property value="txtsite"/>' onKeyDown="getsite(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="siteid" name="siteid" value='<s:property value="siteid"/>'></td>
	      </tr>
	       <tr>
	      <td align="right"><label class="branch"> Area</label></td>
	      <td ><input style="height:19px;" type="text" name="txtassignarea" id="txtassignarea" value='<s:property value="txtassignarea"/>' onKeyDown="getareas(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
	      </td></tr>
	      <tr>
	     <td colspan="2"  align="center"><label class="branch">Priority</label>	        
	     <input type="checkbox" name="priority" id="priority" onchange="pChange();"></td>
       
	      
	      </tr>
	    <tr>
	<td colspan="2" ><div id="serCountgrid"><jsp:include page="serCountgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	<tr>
	<td colspan="2">
	<fieldset style="height:15px;">
	<label id="test"  class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;height:10px;"></label>
	</fieldset>
	</td></tr>
	
	</table>
	<!-- </fieldset>
	<fieldset style="background: #ECF8E0;"> -->
	<table>
	      
	<tr>
	      <td align="right"><label class="branch">Assign Group</label></td>
	      <td ><input style="height:19px;" type="text" name="txtgroup" id="txtgroup" value='<s:property value="txtgroup"/>' onKeyDown="getgrpcode(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="groupid" name="groupid" value='<s:property value="groupid"/>'></td>
	      </tr>
	      
	 <tr>
	      <td align="right"><label class="branch">Group Member</label></td>
	      <td ><input style="height:19px;" type="text" name="txtgrpmember" id="txtgrpmember" value='<s:property value="txtgrpmember"/>' onKeyDown="getteam(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="grpmemberid" name="grpmemberid" value='<s:property value="grpmemberid"/>'>
      <input type="hidden" id="grpempid" name="grpempid" value='<s:property value="grpempid"/>'>
      </td>
	      </tr>  
	      
	       <tr>
	      <td align="right"><label class="branch">Assign Method</label></td>
	      <td ><input style="height:19px;" type="text" name="txtassign" id="txtassign" value='<s:property value="txtassign"/>' onKeyDown="getassign(event);" readonly placeholder="Press F3 to Search">
     
      
      </td>
	      </tr>  
	       <tr>
	      <td align="right"><label class="branch">Planned Date</label></td>
	      <td ><div id='adate' name='adate' value='<s:property value="adate"/>'></div> 
      	  </td>
	      </tr>  
	      
	      
	       <tr>
	      <td align="right"><label class="branch">Planned Time</label></td>
	      <td ><div id='atime' name='atime' value='<s:property value="atime"/>'></div>
	     <%--  <input style="height:19px;" type="text" name="txtptime" id="txtptime" value='<s:property value="txtptime"/>'  readonly > --%>
         </td>
	      </tr>
	     
	      
	      <tr>
	      <td align="right"><label class="branch">Description</label></td>
	      <td ><input style="height:19px;" type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
         </td>
	      </tr> 
	      
	       <tr>
	      <td></td>
	     <td align="left"><input type="button" name="btnsave" class="myButton"
						value="Save" style="width: 80px;" onclick="save();" />
	      </td>
	       <td align="left"><input type="button" name="btnprint" class="myButton"
						value="print" style="width: 80px;visibility:hidden;" onclick="configCheck()" hidden="true" />
	      </td>
	      
	      </tr>    
	 <tr>
	      
	      <td >
      <input type="hidden" id="assignid" name="assignid" value='<s:property value="assignid"/>'>
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
      <input type="hidden" id="bttnview" name="bttnview" value='<s:property value="bttnview"/>'>
      <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'>
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
      <input type="hidden" id="doccno" name="doccno" value='<s:property value="doccno"/>'>
      <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
      <input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
      <input type="hidden" id="confvalue" name="confvalue" value='<s:property value="confvalue"/>'>
       <input type="hidden" id="dtyp" name="dtyp">
      </td>
	      </tr>  
	     
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%">
		<tr><div id="serschedulediv">
				<jsp:include page="serScheduleDetails.jsp"></jsp:include> 
			</div></tr>
		
<%-- <tr><div id="loadtrafficdata">
				 <jsp:include page="SATTrafficloadDetails.jsp"></jsp:include> 
				</div></tr> --%>
	</table>
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
<div id="siteinfowindow">
   <div ></div>
   </div>
   <div id="areainfowindow">
   <div ></div>
</div>
</div>
</body>
</html>