
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

	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#invdate').jqxDateTimeInput('setDate', "");
    
	  $('#invdate').on('change', function (event) {
			
		   var invdate=new Date($('#invdate').jqxDateTimeInput('getDate'));
		   var curdate=new Date(); 
		   invdate.setHours(0,0,0,0);
		   curdate.setHours(0,0,0,0);
		   if(invdate>curdate){
			   
			   $.messager.alert('Message','Future Date Not Allowed','warning');   
			   $('#invdate').jqxDateTimeInput('setDate', new Date());
			 
		   return false;
		  }   
	 });
	 
	 
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

     function funExportBtn(){
       
  	   JSONToCSVCon(perdata,'ProformaInvoice',true);
  	 
      }



function funreload()
{

	 var clientid=$('#clientid').val();
	 
	 
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
    var id=1;
	 $("#profinvdiv").load("proformaInvoiceGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
	}
	
	
	
function funNotify(){
	
	 var invdate=$('#invdate').val();
	 
	 if(invdate==""){
		 $.messager.alert('Warning','Invoice Date is Madatory');
		 return false;
	 }
	
	var z=0;
			    var rows = $("#jqxproinvGrid").jqxGrid('getrows');                    
	if(rows.length>0 && (rows[0].tr_no=="undefined" || rows[0].tr_no==null || rows[0].tr_no=="")){
		return false;
	}
			    var selectedRecords = new Array();
                var selectedrows=$("#jqxproinvGrid").jqxGrid('selectedrowindexes');
    
	if(selectedrows.length==0){
		$.messager.alert('Warning','Select a document');
		return false;
	}
	   $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
 				
 				var i=0;
                $('#invgridlength').val(selectedrows.length);
			    for (i = 0; i < rows.length; i++) {
					for(var j=0;j<selectedrows.length;j++){
						if(selectedrows[j]==i){
							
							//alert("Inside"+z);
							//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "prinv"+z)
						    .attr("name", "prinv"+z)
						    .attr("hidden","true");
							
						newTextBox.val(rows[i].tr_no+"::"+rows[i].doc_no+"::"+rows[i].dtype+"::"+rows[i].refdtype+"::"+rows[i].sdate
								+"::"+rows[i].edate+"::"+rows[i].cval+"::"+rows[i].duedate+"::"+rows[i].lfee+"::"+rows[i].clientid
								+"::"+rows[i].cpersonid+"::"+rows[i].brch+"::"+rows[i].clacno+"::"+rows[i].client);
						
						newTextBox.appendTo('form');
						z++;
						//alert("ddddd"+$("#testinvoice"+z).val());
						}
					}
					if(i==rows.length-1){
						
						 document.getElementById("mode").value="A";
						  document.getElementById("formcode").value="PINV";
						 
						 $("#overlay, #PleaseWait").show();
						 document.getElementById("frmprofinvoice").submit();
					}
		}
			 
		 			}
		 	 		});
	
}
	   
	   function funClear(){
			$("#jqxproinvGrid").jqxGrid('clear'); 
			$("#jqxproinvGrid").jqxGrid('addrow', null, {});
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
  document.getElementById("txtdesc").value="";
	   }
	   
	   function setValues(){

			 if($('#msg').val()!=""){
 document.getElementById("txtclient").value="";
				   document.getElementById("clientid").value="0";
				   $("#txtclient").attr("placeholder", "press F3 for Search");
				 document.getElementById("txtdesc").value="";
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmprofinvoice" action=saveproformaInvoice method="post">
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
	<table width="100%">
	<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
	 <tr><td width="27%"  align="right" ><label class="branch">Inv Date</label></td><td width="73%" align="left">
	 <div id='invdate' name='invdate' value='<s:property value="invdate"/>'></div>
                    </td></tr>
 <tr>
	      <td align="right"><label class="branch">Description</label></td>
	      <td ><input style="height:19px;width:200px" type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
						</td>
	      </tr>
      <tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>              
	<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
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

 </fieldset>
</td>
<td width="40">

	<table width="100%">
		<tr><div id="profinvdiv">
				<jsp:include page="proformaInvoiceGrid.jsp"></jsp:include> 
			
			  <%-- <input type="hidden" name="formcodes" id="formcodes" value='<s:property value="formcodes"/>'> --%>
			</div></tr>
		
	</table>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
  <input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'> 
			  <input type="hidden" name="formcode" id="formcode" value='<s:property value="formcode"/>'>
</div>
</form>
</body>
</html>