<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

	$(document).ready(function () {
		
		   $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			
				   // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }})
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	});
	
	
	
	
	
	function disable(){
		
		$("#boqsubGrid").jqxGrid('clear');
		 $("#boqsubGrid").jqxGrid({ disabled: true});
		 
	}
	
	
	function funreload(event){
		disable();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
			
		 $("#overlay, #PleaseWait").show();  
		 $("#boqpriceFolDiv").load("boqpriceFollowupGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+"&check=1");
	}
	
	
	
	
		function funExportBtn(){
	    

		//JSONToCSVCon(amcrenewalexcel, 'AMC Renewal Followup', true);
		   }
		function setaddcost()
		   {
			   var stdcost = document.getElementById("txtstdcost").value;
			   var margin = document.getElementById("txtmargin").value;
			   if(stdcost=="")
				   {
				   stdcost=0.00;
				   }
			   if(margin=="")
			   {
				   margin=0.00;
			   }
			
			   document.getElementById("txtsellprice").value=parseFloat(stdcost)+parseFloat(margin);
				  
		   }
		
		function btnUpdate(btnclick){
			 var stdcost = document.getElementById("txtstdcost").value;
			   var sellprice = document.getElementById("txtsellprice").value;
			   var estamt = document.getElementById("txtamount").value;
			   var rowno= document.getElementById("rowno").value;
			   var psrno= document.getElementById("psrno").value;
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
		     			
					var items=x.responseText;
					if(parseInt(items)=="1")  
					{	
					if(btnclick==1)
						{
						document.getElementById("txtstdcost").value="";
						document.getElementById("txtmargin").value="";
						   document.getElementById("txtsellprice").value="";
						}
					else if(btnclick==2)
					{
						document.getElementById("txtamount").value="";
					}
					$.messager.alert('Message', '  Record Successfully Updated ');
					$("#jqxBOQGrid").jqxGrid('clear');
					disable();
					
					}
					else
					{
					$.messager.alert('Message', '  Not Updated  ');
					}
					}
			}
	    x.open("GET","saveData.jsp?btnclick="+btnclick+"&stdcost="+stdcost+"&sellprice="+sellprice+"&estamt="+estamt+"&rowno="+rowno+"&psrno="+psrno,true);			
		x.send();
				
		}
		
</script>
</head>
<body onload="getBranch();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2"></td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>   
                    <tr><td colspan="2">
                    <tr><td colspan="2">
                    <tr><td colspan="2">&nbsp;</td></tr>
	                 <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Product Value</label></b></legend>
	   <table width="100%">
        <tr>
	      <td align="right"><label class="branch">Standard Cost</label></td>
	      <td colspan="2" ><input style="height:19px;" type="text" name="txtstdcost" id="txtstdcost" onBlur="setaddcost();" value='<s:property value="txtstdcost"/>'> 
     </td>
       </tr>
        <tr>
	      <td align="right"><label class="branch">Margin</label></td>
	      <td colspan="2" ><input style="height:19px;" type="text" name="txtmargin" id="txtmargin" onBlur="setaddcost();" value='<s:property value="txtmargin"/>'>
     </td>
       </tr>
       <tr>
	      <td align="right"><label class="branch">Selling Price</label></td>
	      <td colspan="2" ><input style="height:19px;" type="text" name="txtsellprice" readonly="readonly" id="txtsellprice" value='<s:property value="txtsellprice"/>'>
     </td>
       </tr>
       <td colspan="2" align="center"><button class="myButton" type="button" id="btnPrdUpdate" name="btnPrdUpdate" onclick="btnUpdate(1);">Update</button></td>
       </tr>
       </table>
	  </fieldset>
	   <tr><td colspan="2">
                    <tr><td colspan="2">&nbsp;</td></tr>
	                 <tr><td colspan="2">
	   <fieldset><legend><b><label class="branch">Estimated Value</label></b></legend>
	   <table width="100%">
       <tr>
	      <td align="right"><label class="branch">Estimation Amount</label></td>
	      <td colspan="2" ><input style="height:19px;" type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'>
     </td>
       </tr>
       <tr>
       <td colspan="2" align="center"><button class="myButton" type="button" id="btnEstUpdate" name="btnEstUpdate" onclick="btnUpdate(2);">Update</button></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>               
	 

	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td ><input type="hidden" name="rowno" id="rowno" value='<s:property value="rowno"/>' ></td></tr>
	 <tr><td ><input type="hidden" name="psrno" id="psrno" value='<s:property value="psrno"/>' ></td></tr>
	 
	 <tr><td colspan="2">
	
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%" style=" vertical-align: top;">
		<tr><td><div id="boqpriceFolDiv"><jsp:include page="boqpriceFollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="boqpriceFollowupSubGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>

</div> 
</body>
</html>