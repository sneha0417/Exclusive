
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
	
	
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	      
			$('#userinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'User Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#userinfowindow').jqxWindow('close');
			
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
		     
		     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			    
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
			 $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				 
				 	 
				   if(fromdates<todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }   
			 });
	 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
     $('#txtuser').dblclick(function(){
		   
    	 $('#userinfowindow').jqxWindow('open');
    	 userSearchContent('userSearch.jsp');
		   		
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
    	   JSONToCSVCon(enqdata,'Estimation Center',true);  
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
		 var fromdate=$('#fromdate').val();
		 var todate=$('#todate').val();
		 var barchval = document.getElementById("cmbbranch").value;
	
		 
		 $("#estcentergrid").jqxGrid('clear'); 
			
		 $("#overlay, #PleaseWait").show();
			 $("#estcenterdiv").load("estimationCenterGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&id="+id);
		
		 
	 }
	 
	 
		
	
      function getUser(){
    	  
    	  var x= event.keyCode;
    	  
 		 if(x==114){
		  $('#userinfowindow').jqxWindow('open');
		  
		  userSearchContent('userSearch.jsp');
		  
	 	 }
 		 else{
 			 }
 		 }
	 	 
	function userSearchContent(url) {
		 $.get(url).done(function (data) {
			 
	$('#userinfowindow').jqxWindow('setContent', data);

	        	}); 
		}
	
	
function save(){

	var reftrno=document.getElementById("reftrno").value;
    var brhid1=document.getElementById("brhid1").value;
    var refdtype=document.getElementById("refdtype").value;
    var userid=document.getElementById("userid").value; 
    var amount=document.getElementById("txtamount").value;
    var remark=document.getElementById("txtremark").value;
   
	 if(userid=="")
		{
	    	$.messager.alert('Message',"select A User");
		
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
					     
					   document.getElementById("reftrno").value="";
					   document.getElementById("brhid1").value="";
					   document.getElementById("refdtype").value="";
					   document.getElementById("userid").value="";
					   document.getElementById("txtuser").value="";
					   document.getElementById("txtamount").value="";
					   document.getElementById("txtremark").value="";
			             $("#txtuser").attr("placeholder", "press F3 for Search");
			           
			         
					  }
			 	else{
			 		$.messager.alert('Message',"Not Updated");
			 	}
			 	 
				}
		       else
			  {}
	     }      
	      x.open("GET","saveData.jsp?reftrno="+reftrno+"&brhid1="+brhid1+"&refdtype="+refdtype+"&userid="+userid+"&remark="+remark+"&amount="+amount,true);
	     x.send();
	    
	   }
	   
	   function funClear(){
			$("#estcentergrid").jqxGrid('clear'); 
			
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		 
		   
	   }
	function disablebtn()
	{
		 $('#btnenquiry').attr("disabled",true);
		 $('#btnsurvey').attr("disabled",true);
		 $('#btnservicereport').attr("disabled",true);
		 $('#txtuser').attr("disabled",true); 
		 $('#btnsave').attr("disabled",true);
		 $('#txtamount').attr("disabled",true);
		 $('#txtremark').attr("disabled",true);
	}
	function btnsurvey()
	{
		var surdocno=document.getElementById("surveydocno").value;
	
		var path1="com/project/execution/surveyDetails/surveydet.jsp";
		 var name="Survey Details";
			 var url=document.URL;
			var reurl=url.split("com");

		  window.parent.formName.value="Survey Details";
		  window.parent.formCode.value="SUR";
		  var detName="Survey Details";
		  
		  var path= path1+"?modes=view&surdocno="+surdocno;
		 
		   top.addTab( detName,reurl[0]+""+path);
	}
	function btnservicereport()
	{
		var reportdocno=document.getElementById("reportdocno").value;
		
		var url=document.URL;
		var reurl=url.split("com/");
		window.parent.formName.value="Service Report";
		window.parent.formCode.value="SRVE";
		var detName= "Service Report";
		 var path1='com/project/execution/serviceReport/serviceReport.jsp';
		  
		  var path= path1+"?modes=view&reportdocno="+reportdocno;
		 
		   top.addTab( detName,reurl[0]+""+path);
	}
	function btnenquiry()
	{
		var enqdocno=document.getElementById("enqdocno").value;
		var brhid1=document.getElementById("brhid1").value;
		 var path1="com/operations/marketing/enquirynew/enquiry.jsp";
			 var name="Enquiry";
			 var url=document.URL;
			var reurl=url.split("com");

		  window.parent.formName.value="Enquiry";
		  window.parent.formCode.value="ENQ";
		  var detName="Enquiry";
		  
		  var path= path1+"?modes=view&enqdocno="+enqdocno+"&brhid="+brhid1;
		 
		   top.addTab( detName,reurl[0]+""+path);
	}
</script>
</head>
<body onload="getBranch();disablebtn();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		<tr><td colspan="2"></td></tr>
 <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
       </td></tr>
	    <tr>
	      <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
	      </tr>
	     
	   <tr><td colspan="2"></td></tr>
	 <tr><td colspan="4"><hr  size=1 color="black"  width="100%"></td></tr>  
	  <tr><td colspan="2"></td></tr>
	    
	<tr>
	<td colspan="2" align="center">
	<!-- <fieldset style="height:15px;"> -->
	<label id="test"   class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;height:10px;"></label>
	<!-- </fieldset> -->
	</td></tr>
	 <tr><td colspan="2"></td></tr> 
	
	 <tr><td colspan="2"></td></tr> 
	</table>
	
<fieldset id="viewform" >
<legend>View</legend>
<table width="100%">
	       
	<tr>
	 <td ><input type="button" id="btnenquiry" name="btnenquiry" class="myButton"
						value=" Enquiry "  onclick="btnenquiry();"/></td>
	      <td align="right"><input type="button" id="btnsurvey" name="btnsurvey" class="myButton"
						value=" Survey "  onclick="btnsurvey();" /></td>
	     
	      </tr>
	      <tr><td></td></tr>
	      <tr>
	      <td colspan="2" align="center" >
			<input type="button" id="btnservicereport" name="btnservicereport" class="myButton"
						value="Service Report"  onclick="btnservicereport();" />			
						</td>
	      
	      </tr>
	 
	      </table>
</fieldset>
	<table>
	       <tr><td colspan="2">&nbsp;</td></tr> 
	     
	<tr>
	      <td align="right"><label class="branch">Assign User</label></td>
	      <td ><input style="height:19px;" type="text" name="txtuser" id="txtuser" value='<s:property value="txtuser"/>' onKeyDown="getUser(event);" readonly placeholder="Press F3 to Search">
       <input type="hidden" id="userid" name="userid" value='<s:property value="userid"/>'></td>
	      </tr>
	   <tr>
	      <td align="right"><label class="branch">Amount</label></td>
	      <td ><input style="height:19px;" type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>' ">
	   </tr>
	   <tr>
	      <td align="right"><label class="branch">Remarks</label></td>
	      <td ><input style="height:19px;" type="text" name="txtremark" id="txtremark" value='<s:property value="txtremark"/>' ">
	   </tr>
	      </table>
	    
	      <table width="100%"><tr>
	      <tr><td colspan="2"></td></tr>
	     <td align="center"><input type="button" id="btnsave" name="btnsave" class="myButton"
						value="Save" style="width: 80px;" onclick="save();" />
	      </td>
	      
	      </tr>   
	       <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr>
	        <tr><td colspan="2">&nbsp;</td></tr> 
	         <tr><td colspan="2">&nbsp;</td></tr> 
	          <tr><td colspan="2">&nbsp;</td></tr> 
	          
	 <tr>
	      
	      <td >
     
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
     
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
       <input type="hidden" id="reportdocno" name="reportdocno" value='<s:property value="reportdocno"/>'>
       <input type="hidden" id="surveydocno" name="surveydocno" value='<s:property value="surveydocno"/>'>
       <input type="hidden" id="enqdocno" name="enqdocno" value='<s:property value="enqdocno"/>'>
       
         <input type="hidden" id="reftrno" name="reftrno" value='<s:property value="reftrno"/>'>
      <input type="hidden" id="brhid1" name="brhid1" value='<s:property value="brhid1"/>'>
      <input type="hidden" id="refdtype" name="refdtype" value='<s:property value="refdtype"/>'>
      
      </td>
	      </tr>  
	     
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%">
		<tr><div id="estcenterdiv">
				<jsp:include page="estimationCenterGrid.jsp"></jsp:include> 
			</div></tr>

	</table>
	</td>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 

<div id="userinfowindow">
   <div ></div>
</div>

</div>
</body>
</html>