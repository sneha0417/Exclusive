
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

.branchs {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
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
	 
	 $("#frmdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	

	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#frmdate').jqxDateTimeInput('setDate',onemounth);
     
	 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
     
     $('#contractwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#contractwindow').jqxWindow('close');
	  
	  
	  $('#txtcontract').dblclick(function(){
	  	    $('#contractwindow').jqxWindow('open');
	   
	  	//  contractSearchContent('contractMastersearch.jsp');
	  	  contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
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
 		
	  	   JSONToCSVCon(invoicelistexcel,'Invoice List',true);
	  }

/* function funreload()
{

	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
    var id=1;
	 $("#profinvdiv").load("invoiceprocessingGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
} */
	
	
	   
	   function funClear(){
		   
		   $("#jqxpinvGrid").jqxGrid('clear'); 
			$("#jqxInvCount").jqxGrid('clear');
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtcontract").value="";
		   $("#txtcontract").attr("placeholder", "press F3 for Search");
		   
	   }
	   
	   
	   function funreload()
	   {

	   	 var clientid=$('#clientid').val();
	   	 var date=$('#todate').val();
	   	 var barchval = document.getElementById("cmbbranch").value;
	     	
	        var dtype="0";
	        var id=1;
			
	       if(id>0){
	       	countload(id);
	       }
	        
	   	}
	   
		 function countload(id){
			 
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var frmdate=$('#frmdate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			 var contract=document.getElementById("txtcontract").value;
			 
			    $("#jqxpinvGrid").jqxGrid('clear'); 
				$("#jqxInvCount").jqxGrid('clear');
				
				
				 $("#invCountgrid").load("invCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&contract="+contract+"&frmdate="+frmdate);
			
			
			 
		 }
		 
		 function getcontract(event){

				var x= event.keyCode;
			 	 if(x==114){
			 		 $('#contractwindow').jqxWindow('open');
			 		// changeContent('contractMastersearch.jsp');  
			 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
			    	 }
			 	 else{
			 		 
			 		 }
			 	 }
			    	 
			function contractSearchContent(url) {
				 $.get(url).done(function (data) {
				$('#contractwindow').jqxWindow('setContent', data);
			           	}); 
			 	}
		
 function gettaxconfig(){
					
				 document.getElementById("hidtaxconfig").value=0; 
						var x=new XMLHttpRequest();
						x.onreadystatechange=function(){
						if (x.readyState==4 && x.status==200)
							{
							 	var res= x.responseText;
							 	if(res>0){
							 		
							 		document.getElementById("hidtaxconfig").value=1; 
									  }
								}
						       else
							  {}
					     }
					      x.open("GET",'taxconfig.jsp',true);
					     x.send();
					    
					   } 
	
</script>
</head>
<body onload="getBranch();gettaxconfig();">
<form id="frmdinvoice" action=savedInvoice method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
		<table width="100%"   >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		 <tr><td width="24%"  align="right" ><label class="branch">From Date</label></td><td  align="left"><div id='frmdate' name='frmdate' value='<s:property value="frmdate"/>'></div>
                    </td></tr>
	  <tr><td  align="right" ><label class="branch">To Date</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
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
	       <td align="right"><label class="branch">Contract No</label></td>
    <td><input style="height:19px;" type="text" name="txtcontract" id="txtcontract" placeholder="Press F3 To Search"  onKeyDown="getcontract(event);" readonly value='<s:property value="txtcontract"/>'></td>
	      </tr>
	
	</table>
	<table width="100%" >
	<tr><td colspan="2" ><div id="invCountgrid"><jsp:include page="invCountgrid.jsp"></jsp:include>
	</div></td ></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>

	</table>
<input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'>
<input type="hidden" name="hidtaxconfig" id="hidtaxconfig" value='<s:property value="hidtaxconfig"/>'>
 </fieldset>
</td>
<td width="80%" >

	<table width="100%" >
		<tr><td colspan="2" ><div id="profinvdiv">
				<jsp:include page="serviceCompletionGrid.jsp"></jsp:include> 
			</div></td></tr>
			<%-- <tr><td  width="50%">
			<div id="profserdetdiv"><jsp:include page="serviceDetGrid.jsp"></jsp:include></div></td>
			<td width="50%">
				<div id="profinvdetdiv" ><jsp:include page="invDetGrid.jsp"></jsp:include></div></td> 
			</tr> --%>
		</table>
	
		</tr>
			
		
	</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="contractwindow">
   <div ></div>
</div>
              
		
			  
</div>
</form>
</body>
</html>