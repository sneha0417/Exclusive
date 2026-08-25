
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
			
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		  $('#Salesagentinfowindow').jqxWindow('close');
		  
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#frmdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 

	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#frmdate').jqxDateTimeInput('setDate', onemounth);
     
    
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
     $('#txtsalman').dblclick(function(){
		  $('#Salesagentinfowindow').jqxWindow('open');
	      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
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
     
     function getsalesAgent(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#Salesagentinfowindow').jqxWindow('open');
     
       
      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
     	 else{
     		 }
     	 }

  function salesagentSearchContent(url) {
               //alert(url);
                 $.get(url).done(function (data) {
        //alert(data);
	           $('#Salesagentinfowindow').jqxWindow('setContent', data);

       	}); 
   }


function funExportBtn(){
	
	//$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
	   
	   JSONToCSVCon(pdata,'ProjectWiseBalanceReport',true);
	 

}


function funreload()
{
	if(document.getElementById("rpdsummary").checked==true){
		$('#radval').val(2);
		
	}
	else if(document.getElementById("rpddetail").checked==true){
		$('#radval').val(1);
	}
	else{
		$('#radval').val(0);
	}
	
	 var radval=$('#radval').val().trim();
	 if(radval==0){
		 $.messager.alert('Message',"select a Report Type");
    	 return 0;
	 }
	 var clientid=$('#clientid').val();
	 var salid=$('#salid').val();
	 var date=$('#todate').val();
	 var frmdate=$('#frmdate').val();
	 var barchval = document.getElementById("cmbbranch").value;
     var dtype=$('#cmbreftype').val();
     
     var id=1;
     
    if(id>0){
    	$("#saldiv").load("salesIncentiveDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype+"&id="+id+"&radval="+radval+"&salid="+salid+"&frmdate="+frmdate);
    
    }
     
	}
	
			
	   
	   function funClear(){
		   
			$("#jqxsalincGrid").jqxGrid('clear'); 
			$("#jqxsalincGrid").jqxGrid('addrow', null, {});
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
	   }
	   
	   function funsalClear(){
		   
			$("#jqxsalincGrid").jqxGrid('clear'); 
			$("#jqxsalincGrid").jqxGrid('addrow', null, {});
		   document.getElementById("txtsalman").value="";
		   document.getElementById("salid").value="0";
		   $("#txtsalman").attr("placeholder", "press F3 for Search");
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
		
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
	 <tr><td width="27%"  align="right" ><label class="branch">From Date</label></td><td width="73%" align="left"><div id='frmdate' name='frmdate' value='<s:property value="frmdate"/>'></div>
                    </td></tr>
                    
	  <tr><td width="27%"  align="right" ><label class="branch">To Date</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
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
	      <td align="right"><label class="branch">Sales Man</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsalman" id="txtsalman" value='<s:property value="txtsalman"/>' onKeyDown=" getsalesAgent(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="salid" name="salid" value='<s:property value="salid"/>'>
      <button type="button" class="bicon" id="clear" title="clear" onclick="funsalClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
	      </tr>
	    <%-- <tr>
	<td colspan="2" ><div id="serCountgrid"><jsp:include page="serCountgrid.jsp"></jsp:include>
	</div></td>
	</tr>  --%>
	 <tr><td align="right"><label class="branch">Contr.Type</label></td>
<td ><select id="cmbreftype" name="cmbreftype" style="width:75%;"  value='<s:property value="cmbreftype"/>'>
      <option value=""></option>
      <option value="AMC">AMC</option>
      <option value="SJOB">SJOB</option>
      </select></td></tr>
 <tr>
       <td align="right"><input type="radio" id="rpddetail" name="rdo" value="rpddetail"></td>
       <td align="left"><label for="lbldetail" id="lbldetail" class="branch">Detail</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" id="rpdsummary" name="rdo" value="rpdsummary"><label for="lblsummary" id="lblsummary" class="branch">
       Summary</label>
       <input type="hidden" id="radval" name="radval" value='<s:property value="radval"/>'></td>
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
	<!-- </fieldset>
	<fieldset style="background: #ECF8E0;"> -->
	</fieldset>

</td>
<td width="40">
	<table width="100%">
		<tr><div id="saldiv">
				<jsp:include page="salesIncentiveDetails.jsp"></jsp:include> 
			</div></tr>
	
	</table>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 
<div id="Salesagentinfowindow">
   <div ></div>
   </div>
</div>
</body>
</html>