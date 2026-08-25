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
	
	        pChange();
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
		  
		    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	        $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	        $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	        
	 $("#adate").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#atime").jqxDateTimeInput({ width: '35px', height: '15px',formatString:"HH:mm",showCalendarButton: false});
	 
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
		   
    	 var id=2;
    	 $('#grpinfowindow').jqxWindow('open');
	      //grpSearchContent('servicegrpsearch.jsp');
    	 grpSearchContent('servicegrpsearch.jsp?id='+id);
		   		
		 });
     
     
     $('#txtgrpmember').dblclick(function(){
		   
    	 var id=2;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       	if(id==2){
        	
       		assgnid=document.getElementById("groupid").value;
       	}
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
     $('#txtstatus').dblclick(function(){
		   
    	 $('#assigninfowindow').jqxWindow('open');
		  assignSearchContent('assignstatussearch.jsp');
		   		
		 });
     
     //-----------------------------------------------------------------------
      $('#txtsergroup').dblclick(function(){
		   
    	 var id=1;
    	 $('#grpinfowindow').jqxWindow('open');
	      //grpSearchContent('servicegrpsearch.jsp');
    	 grpSearchContent('servicegrpsearch.jsp?id='+id);
		   		
		 });
     
     
     $('#txtsergrpemp').dblclick(function(){
		   
    	 var id=1;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       	if(id==2){
        	
       		assgnid=document.getElementById("groupid").value;
       	}
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
     $('#txtassignarea').dblclick(function(){
		   
    	 $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
		   		
		 });
    
    //---------------------------------------------------------------------------
	  
});

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

	function funExportBtn(){
		
	  	   JSONToCSVCon(exceldata,'AssignJobFollowUpStatus',true);
	  	  }

    function funreload()
    {
	 $("#assignSubGridDetails").jqxGrid('clear');
	 
	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
     var dtype="0";
     var id=1;
   // $("#overlay, #PleaseWait").show();
   var isprior=document.getElementById("isprior").value;
   
    if(id>0){
    	//$("#serschedulediv").load("serScheduleDetails.jsp?clientid"+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype+"&id="+id+"&isprior="+isprior);
    	countload(id);
    }
     
	}
	
    function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtdesc').attr("readonly",true);
		 $('#btnsave').attr("disabled",true);
		 $("#assignSubGridDetails").jqxGrid('clear');
		 $("#assignSubGridDetails").jqxGrid("addrow", null, {}); 
		 $("#assignSubGridDetails").jqxGrid({ disabled: true});
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
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var barchval = document.getElementById("cmbbranch").value;
		 var isprior=document.getElementById("isprior").value;
		 
		 var grp=document.getElementById("sergroupid").value;
		 var emp=document.getElementById("grpserempid").value;
		 var mem=document.getElementById("grpsermemberid").value;
		 var area=document.getElementById("txtareaid").value;
		
		 
		    $("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		 
$("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+"&grp="+grp+"&emp="+emp+"&mem="+mem+"&area="+area+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate);
		
		
		 
	 }
	 
	 
	 function getgrpcode(event,id){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp?id='+id);
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
		
	function getteam(event,id){
		 var x= event.keyCode;
		 if(x==114){
			 var assgnid;
			 if(id==1){
        			
				 assgnid=document.getElementById("sergroupid").value;
       	    }
           	if(id==2){
            	
           		assgnid=document.getElementById("groupid").value;
           	}	
			 
		
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
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
		  
		   assignSearchContent('assignstatussearch.jsp');
		  
	 	   }
 		 else{
 			 }
 		 }
	 	 
	function assignSearchContent(url) {
		 $.get(url).done(function (data) {
			 
	$('#assigninfowindow').jqxWindow('setContent', data);

	        	}); 
		}
		function funClear(){
			$("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			$("#assignSubGridDetails").jqxGrid('clear');
			$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   
		   document.getElementById("txtsergroup").value="";
		   document.getElementById("sergroupid").value="0";
		   
		   document.getElementById("txtsergrpemp").value="";
		   document.getElementById("grpsermemberid").value="0";
		   document.getElementById("grpserempid").value="0";
		   
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   
		   document.getElementById("txtstatus").value="";
		   document.getElementById("txtstatusid").value="0";
		   document.getElementById("txtstatusid2").value="0";
		   
		   document.getElementById("txtgroup").value="";
		   document.getElementById("groupid").value="0";
		  
		   document.getElementById("txtgrpmember").value="";
		   document.getElementById("grpmemberid").value="0";
		   document.getElementById("grpempid").value="0";
		   document.getElementById("test").innerText="";
		   
		   $('#date').val(new Date());
		   document.getElementById("cmbprocess").value="";
			 
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   $("#txtsergroup").attr("placeholder", "press F3 for Search");
		   $("#txtsergrpemp").attr("placeholder", "press F3 for Search");
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   
		   $("#txtstatus").attr("placeholder", "press F3 for Search");
		   $("#txtgroup").attr("placeholder", "press F3 for Search");
		   $("#txtgrpmember").attr("placeholder", "press F3 for Search");
		   disable();
		  }
	   
	   function save(){
		   
		    var docno1=document.getElementById("docno1").value;
		    var brhid1=document.getElementById("brhid1").value;
		    var area=document.getElementById("txtareaid").value;
		    var bttnview=document.getElementById("bttnview").value;
			var mem=document.getElementById("grpsermemberid").value;
			var emp=document.getElementById("grpserempid").value;
			var grp=document.getElementById("sergroupid").value;
			var groupid=document.getElementById("groupid").value;
		    var grpmemberid=document.getElementById("grpmemberid").value;
		    var grpempid=document.getElementById("grpempid").value;
		    var assignid=document.getElementById("assignid").value;
		    var statusid=document.getElementById("txtstatusid").value;
		    var statusid2=document.getElementById("txtstatusid2").value;
		    var trno=document.getElementById("trno").value;
		    var srno=document.getElementById("srno").value;
		    var clientid=document.getElementById("clientid").value;
		    var dtype=document.getElementById("dtype").value;
		    var brchid=document.getElementById("cmbbranch").value;
		    var desc=document.getElementById("txtdesc").value;
		    var rowindex=document.getElementById("rowindex").value;
		    
		    var pdate=$('#adate').val();
			var ptime=$('#atime').val();
			var process = $('#cmbprocess').val();
		    var processname = $("#cmbprocess option:selected").text().trim();
			var date =  $('#date').val();
			
			if(rowindex=='') {
			    $.messager.alert('Message',"Select a document.");
				return 0;
			}
			
			if(process==''){
				 $.messager.alert('Message','Choose a Process.','warning');
				 return 0;
			 }

			 if(desc==''){
				 $.messager.alert('Message','Please Enter Remarks.','warning');   
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
							     $.messager.alert('Message',"Updated Successfully");
							   
							     var clientid=$('#clientid').val();
				    			 var date=$('#todate').val();
				    			 var chkfromdate = $('#hidchckfromdate').val();
				    			 var fromdate = $('#fromdate').val();
				    			
				    			 var barchval = document.getElementById("cmbbranch").value;
					             var dtype=document.getElementById("dtype").value;
					             var rowindex=document.getElementById("rowindex").value;
					             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
					             
								 $('#date').val(new Date());
								 document.getElementById("cmbprocess").value="";
					             document.getElementById("groupid").value="";
					             document.getElementById("grpmemberid").value="";
					             document.getElementById("grpempid").value="";
					             document.getElementById("assignid").value="";
					             document.getElementById("trno").value="";
					             document.getElementById("srno").value="";
					             document.getElementById("dtype").value="";
					             document.getElementById("txtgroup").value="";
					             document.getElementById("txtgrpmember").value="";
					             document.getElementById("txtstatus").value="";
					             document.getElementById("txtdesc").value="";
					             document.getElementById("txtstatusid2").value="";
					             document.getElementById("test").innerText="";
					             statusid2="";
					             
					             $("#txtgroup").attr("placeholder", "press F3 for Search");
					             $("#txtgrpmember").attr("placeholder", "press F3 for Search");
					             $("#txtstatus").attr("placeholder", "press F3 for Search");
					             /* $('#adate').val("");
					         	 $('#atime').val(""); */
					         	 $('#adate').jqxDateTimeInput('setDate', new Date());
					             $('#atime').jqxDateTimeInput('setDate', new Date());
					        	 $("#assignSubGridDetails").jqxGrid('clear');
					   		     var isprior=document.getElementById("isprior").value;
					   		     var id=1;
					   			 $("#serCountgrid").load("serCountgrid.jsp?grp="+grp+"&barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate);
					   		     $("#overlay, #PleaseWait").show();
					   			 $("#serschedulediv").load("serScheduleDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&assignstatus="+statusid2+"&id="+id+"&isprior="+isprior+"&grp="+grp+"&emp="+emp+"&mem="+mem+"&area="+area+"&bttnview="+bttnview+"&chkfromdate="+chkfromdate+"&fromdate="+fromdate);
					   			 //$("#assignSubDiv").load("assignSubGrid.jsp?docno="+docno1+"&brchid="+brhid1);
					   			disable();
					             
				    		 }
					 	else{
					 		$.messager.alert('Message',"Not Updated");
					 	}
					 	 
						}
				       else
					  {}
			     }
			      x.open("GET","saveSchedule.jsp?process="+process+"&processname="+processname+"&date="+date+"&groupid="+groupid+"&grpmemberid="+grpmemberid+"&grpempid="+grpempid+"&assignid="+assignid+"&statusid="+statusid+"&trno="+trno+"&srno="+srno+"&clientid="+clientid+"&dtype="+dtype+"&brchid="+brchid+"&desc="+desc+"&pdate="+pdate+"&ptime="+ptime,true);
			     x.send();
			    
	 }
	   
	   
		  function funPrintBtn() {
					 
					var docno=$('#docno').val();
			  		var trno=$('#masterdoc_no').val();
			  		var dtype=$('#formdetailcode').val();
			  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
			  		var url=document.URL;
			  		var reurl=url.split("com/"); 
			     
			  		
			  		var win= window.open(reurl[0]+"printAssignjob?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			  		
			   
			    
	  }
		  function fromdatecheck(){
				 if(document.getElementById("chckfromdate").checked){
					 document.getElementById("hidchckfromdate").value = 1;
					 $('#fromdate').jqxDateTimeInput({ disabled: false});
				 }
				 else{
					 document.getElementById("hidchckfromdate").value = 0;
					 $('#fromdate').jqxDateTimeInput({ disabled: true});
				 }
			 }
	
		  function  funPrint()
		  {
		  
			 var doccno=$('#doccno').val();
			 
			
			 var barchval = document.getElementById("cmbbranch").value;
			
			
			 
			  if(doccno==''){
					 $.messager.alert('Message','Please Select a Row.','warning');
					 return 0;
				 }
		   			
			 	    if ($("#doccno").val()!="") {
				        var url=document.URL;
				        var reurl=url.split("assignmentFollowUp.jsp");
			
				        var win= window.open(reurl[0]+"printassignmentfollowup?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
				     }
				    else {
						$.messager.alert('Message','Please Select a Document.','warning');
						return;
					}
				   }
</script>
</head>
<body onload="getBranch();disable();fromdatecheck();serviceview();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		

	  <tr><td width="27%"  align="right" ><label class="branch">Upto</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>
   <tr>
	      <td colspan="2" align="right"></td>
	      </tr>
	    <tr>
	<td colspan="2" ><div id="serCountgrid"><jsp:include page="serCountgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	 <tr>
		<td colspan="2" align="center">
		<!-- <fieldset> -->&nbsp;
		<label id="test"  class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;"></label>
		<!-- </fieldset> -->
		</td></tr>
	</table>
	
	<table>
	
	<tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:70%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'>
	 <option value="">--Select--</option><option value="1">Follow-Up</option><option value="2">Drop</option>
	 </select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtdesc" name="txtdesc" style="width:100%;height:20px;" value='<s:property value="txtdesc"/>'/></td></tr>
	      <tr>
	     <td colspan="2" align="center"><input type="button" name="btnsave" class="myButton"
						value="Save" style="width: 80px;" onclick="save();" />
	      </td></tr>   
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	
	<table>
	
	       
	       <tr>
	      
	      <td >
    <input type="hidden" id="docno1" name="docno1" value='<s:property value="docno1"/>'>
      <input type="hidden" id="brhid1" name="brhid1" value='<s:property value="brhid1"/>'> 
      
      <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'>
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
      <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
      <input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
      <input type="hidden" id="bttnview" name="bttnview" value='<s:property value="bttnview"/>'>
      <input type="checkbox" id="chckfromdate" hidden="true"  name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
      <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/>
      <div id="fromdate" hidden="true" name="fromdate" value='<s:property value="fromdate"/>'></div>
      <input style="height:19px;" type="hidden" name="txtsergrpemp" id="txtsergrpemp" value='<s:property value="txtsergrpemp"/>' onKeyDown="getteam(event,1);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="grpsermemberid" name="grpsermemberid" value='<s:property value="grpsermemberid"/>'>
      <input type="hidden" id="grpserempid" name="grpserempid" value='<s:property value="grpserempid"/>'>
      <input style="height:19px;" type="hidden" name="txtassignarea" id="txtassignarea" value='<s:property value="txtassignarea"/>' onKeyDown="getareas(event);" readonly placeholder="Press F3 to Search">
	  <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
	  <input type="checkbox" hidden="true" name="priority" id="priority" onchange="pChange();">
	  <button type="button" class="icon" id="btnPrint" hidden="true" title="Print current Document" onclick="funPrintBtn()">  
	  <img alt="printDocument" src="<%=contextPath%>/icons/print_new.png"></button>
	  <div  id='adate' hidden="true" name='adate' value='<s:property value="adate"/>' ></div>
	  <div id='atime' hidden="true" name='atime' value='<s:property value="atime"/>' ></div>
	  <input style="height:19px;" type="hidden" name="txtptime" id="txtptime" value='<s:property value="txtptime"/>'  readonly >
	  <input style="height:19px;" type="hidden" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      <input style="height:19px;" type="hidden" name="txtsergroup" id="txtsergroup" value='<s:property value="txtsergroup"/>' onKeyDown="getgrpcode(event,1);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="sergroupid" name="sergroupid" value='<s:property value="sergroupid"/>'>
      <input style="width: 100%;height:20px;" type="hidden" name="txtgroup" id="txtgroup" value='<s:property value="txtgroup"/>' onKeyDown="getgrpcode(event,2);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="groupid" name="groupid" value='<s:property value="groupid"/>'>
      <input style="width: 100%;height:20px;" type="hidden" name="txtgrpmember" id="txtgrpmember" value='<s:property value="txtgrpmember"/>' onKeyDown="getteam(event,2);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="grpmemberid" name="grpmemberid" value='<s:property value="grpmemberid"/>'>
      <input type="hidden" id="grpempid" name="grpempid" value='<s:property value="grpempid"/>'>	
      <input style="width: 100%;height:20px;" type="hidden" name="txtstatus" id="txtstatus" value='<s:property value="txtstatus"/>' onKeyDown="getassign(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="txtstatusid" name="txtstatusid" value='<s:property value="txtstatusid"/>'>
      <input type="hidden" id="txtstatusid2" name="txtstatusid2" value='<s:property value="txtstatusid2"/>'>
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
      <input type="hidden" id="assignid" name="assignid" value='<s:property value="assignid"/>'>
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
      <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'>
      <input type="hidden" id="doccno" name="doccno" value='<s:property value="doccno"/>'>
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
      <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
      <input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
      </td>
	      </tr>  
	      
	
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%"  >
		<tr><td><div id="serschedulediv">
				<jsp:include page="serScheduleDetails.jsp"></jsp:include> 
			</div>
			<br/>
			</td>
			</tr>
<tr><td><div id="assignSubDiv"><jsp:include page="assignSubGrid.jsp"></jsp:include></div></td></tr>
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