
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
			$("#assignDiv input").attr('disabled', true);$("#assignDiv button").attr('disabled', true);
	        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			$('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			  
			$('#assigninfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Method' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#assigninfowindow').jqxWindow('close');
	   		
			$('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#areainfowindow').jqxWindow('close');
			
	        $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		    $('#clientsearch1').jqxWindow('close');
		  
	     $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     

     $('#txtclient').dblclick(function(){

    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
     });
	 
     $('#txtgroup').dblclick(function(){

    	 var id=2;
    	 $('#grpinfowindow').jqxWindow('open');
    	 grpSearchContent('servicegrpsearch.jsp?id='+id+'&typeid='+$("#hidtypeid").val());
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
    	 teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id+'&typeid='+$("#hidtypeid").val());
     });
     
     $('#txtstatus').dblclick(function(){
    	 $('#assigninfowindow').jqxWindow('open');
    	 assignSearchContent('assignstatussearch.jsp?typeid='+$("#hidtypeid").val());
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
function getgrpcode(event,id){
	var x= event.keyCode;
	if(x==114){
		$('#grpinfowindow').jqxWindow('open');
		grpSearchContent('servicegrpsearch.jsp?id='+id+'&typeid='+$("#hidtypeid").val());
  	 }
	 else{
		 }
}
  	 
function grpSearchContent(url) {
	 $.get(url).done(function (data) {
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
		teamSearchContent('servicegrptoearch.jsp?typeid='+$("#hidtypeid").val()+'&assgnid='+assgnid+'&id='+id);
	}
	else{
	}
}
	 
function teamSearchContent(url) {
	$.get(url).done(function (data) {
		$('#teaminfowindow').jqxWindow('setContent', data);
	}); 
}	

function getassign(event){
	  var x= event.keyCode;
	  if(x==114){
	  $('#assigninfowindow').jqxWindow('open');
		  assignSearchContent('assignstatussearch.jsp?typeid='+$("#hidtypeid").val());
	  }
	 else{
		 }
}
	 
function assignSearchContent(url) {
	$.get(url).done(function (data) {
		$('#assigninfowindow').jqxWindow('setContent', data);
	}); 
}

function funreload()
{
	$("#assignSubGridDetails").jqxGrid('clear');
	var id=1;
	if(id>0){
		countload(id);
	}
}

function countload(id){
	 
	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
	    
	 $("#jqxloaddataGrid").jqxGrid('clear'); 
	 $("#jqxSerCount").jqxGrid('clear');
	 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
}
function funClear(){
	$("#jqxloaddataGrid").jqxGrid('clear');    
	$("#jqxSerCount").jqxGrid('clear');
	$("#assignSubGridDetails").jqxGrid('clear');
	$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
	
   	document.getElementById("txtclient").value="";
   	document.getElementById("clientid").value="0";
   
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
   
   	$("#txtclient").attr("placeholder", "press F3 for Search");
   	$("#txtsergrpemp").attr("placeholder", "press F3 for Search");
   	$("#txtassignarea").attr("placeholder", "press F3 for Search");
   
   	$("#txtstatus").attr("placeholder", "press F3 for Search");
   	$("#txtgroup").attr("placeholder", "press F3 for Search");
   	$("#txtgrpmember").attr("placeholder", "press F3 for Search");
}

function save(){
	var groupid=document.getElementById("groupid").value;
    var grpmemberid=document.getElementById("grpmemberid").value;
    var statusid=document.getElementById("txtstatusid").value;
    var trno=document.getElementById("trno").value;
    var brchid=document.getElementById("cmbbranch").value;
    var desc=document.getElementById("txtdesc").value;
    

    if(trno== "")
    {
    	$.messager.alert('Message',"select a document");
    	return 0;
    }
    if(groupid== "")
	{
    	$.messager.alert('Message',"select Assign Group");
    	return 0;
	}
	
	if(grpmemberid== "")
	{
		$.messager.alert('Message',"select Group Member");
	
	return 0;
	}
	
	if($('#statusid').val()== "")
	{
		$.messager.alert('Message',"Select Status Method");
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
// 			             var rowindex=document.getElementById("rowindex").value;
// 			             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
			             
			             
			             document.getElementById("groupid").value="";
			             document.getElementById("grpempid").value="";
			             document.getElementById("trno").value="";
			             document.getElementById("txtgroup").value="";
			             document.getElementById("txtgrpmember").value="";
			             document.getElementById("txtstatus").value="";
			             document.getElementById("txtdesc").value="";
			             document.getElementById("hidstatusid").value="";
			             statusid2="";
			             
			             $("#txtgroup").attr("placeholder", "press F3 for Search");
			             $("#txtgrpmember").attr("placeholder", "press F3 for Search");
			             $("#txtstatus").attr("placeholder", "press F3 for Search");
 			        	 $("#assignSubGridDetails").jqxGrid('clear');
			   		 	
 			        	 var id=1;
 			        	 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
			   			 $("#serschedulediv").load("serScheduleDetailsGrid.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&assignstatus="+statusid2+"&check="+id);
			   			 $("#assignDiv input").attr('disabled', true);$("#assignDiv button").attr('disabled', true);
			 	}
			 	else{
			 		$.messager.alert('Message',"Not Updated");
			 	}
			}
		    
		else
		{}
}

	      x.open("GET","saveSchedule.jsp?groupid="+groupid+"&grpmemberid="+grpmemberid+"&statusid="+statusid+"&trno="+trno+"&brchid="+brchid+"&desc="+desc+"&oldstatus="+$("#hidstatusid").val(),true);
	     x.send();
	    
}

function funExportBtn(){   
	JSONToCSVCon(dataexcel, 'Call Register Followup', true);
 }
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		

	  <tr><td width="27%"  align="right" ><label class="branch">Upto</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
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
	<td colspan="2" ><div id="serCountgrid"><jsp:include page="serCountgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	 <tr>
		<td colspan="2" align="center">
		<!-- <fieldset> -->
		<label id="test"  class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;"></label>
		<!-- </fieldset> -->
		</td></tr>
	</table>
	<div id="assignDiv">
	<table>
	 
	<tr>
	      <td width="32%" align="right"><label class="branch">Assign Group</label></td>
	      <td colspan="2" ><input style="width: 100%;height:20px;" type="text" name="txtgroup" id="txtgroup" value='<s:property value="txtgroup"/>' onKeyDown="getgrpcode(event,2);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="groupid" name="groupid" value='<s:property value="groupid"/>'></td>
	      </tr>
	      
	 <tr>
	      <td align="right"><label class="branch">Assign Member</label></td>
	      <td colspan="2" ><input style="width: 100%;height:20px;" type="text" name="txtgrpmember" id="txtgrpmember" value='<s:property value="txtgrpmember"/>' onKeyDown="getteam(event,2);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="grpmemberid" name="grpmemberid" value='<s:property value="grpmemberid"/>'>
      <input type="hidden" id="grpempid" name="grpempid" value='<s:property value="grpempid"/>'>
      </td>
	      </tr>  
	      
	       <tr>
	      <td align="right"><label class="branch">Status</label></td>
	      <td colspan="2" ><input style="width: 100%;height:20px;" type="text" name="txtstatus" id="txtstatus" value='<s:property value="txtstatus"/>' onKeyDown="getassign(event);" readonly placeholder="Press F3 to Search">
          <input type="hidden" id="txtstatusid" name="txtstatusid" value='<s:property value="txtstatusid"/>'>
          <input type="hidden" id="txtstatusid2" name="txtstatusid2" value='<s:property value="txtstatusid2"/>'>
      
      
      </td>
	      </tr>  
	      
	      
	      <tr>
	      <td align="right"><label class="branch">Description</label></td>
	      <td colspan="2" ><input style="width: 100%;height:20px;" type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
         </td>
	      </tr> 
	     	
	     
	      <tr>
	      <td></td>
	     <td colspan="2" align="center"><input type="button" name="btnsave" class="myButton" value="Update" onclick="save();" style="width: 80px;"  />
	      </td></tr>     
	<tr><td colspan="2">&nbsp;
	<input type="hidden" id="assignid" name="assignid" value='<s:property value="assignid"/>'>
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
      <input type="hidden" id="doccno" name="doccno" value='<s:property value="doccno"/>'>
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
      <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
      <input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
      <input type="hidden" id="hidtypeid" name="hidtypeid" value='<s:property value="hidtypeid"/>'>
      <input type="hidden" id="hidstatusid" name="hidstatusid" value='<s:property value="hidstatusid"/>'>
       
      <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'>
      <input type="hidden" id="grpsermemberid" name="grpsermemberid" value='<s:property value="grpsermemberid"/>'>
      <input type="hidden" id="grpserempid" name="grpserempid" value='<s:property value="grpserempid"/>'>
	</td></tr>
	</table>  
	</div>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%"  >
		<tr><td><div id="serschedulediv"> 
				<jsp:include page="serScheduleDetailsGrid.jsp"></jsp:include> 
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