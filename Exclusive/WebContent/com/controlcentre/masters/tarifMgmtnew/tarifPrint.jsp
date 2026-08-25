<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> -->

 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
   fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 } 

/*  .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
} */
/* 
} */
/*  table thead{

page-break-before: always;
 } */
 @media print {
  .breakclass{
  page-break-after:always;
  }
  }

</style> 
<script>
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmTarifPrint").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTarifPrint" action="tarifPrint" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
 <div style="background-color:white;">
<fieldset><table width="100%">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="7%" align="left">:<label name="lbldocno" id="lbldocno"><s:property value="lbldocno"/></label></td>
    <td width="9%" align="right">Tarif Type</td>
    <td width="11%" align="left">:<label name="lbltariftype" id="lbltariftype"><s:property value="lbltariftype"/></label></td>
    <td width="5%" align="right">Client</td>
    <td width="21%" align="left">:<label name="lblclient" id="lblclient" ><s:property value="lblclient"/></label></td>
    <td width="10%" align="right">Validity From</td>
    <td width="11%" align="left">:<label name="lblfromdate" id="lblfromdate"><s:property value="lblfromdate"/></label></td>
    <td width="8%" align="right">Validity To</td>
    <td width="11%" align="left">:<label name="lbltodate" id="lbltodate" ><s:property value="lbltodate"/></label></td>
  </tr>
</table></fieldset>

<br><!-- class="tablereceipt table1" -->
<table  class="print">
<thead>
<!-- height="25" style="background-color: #D8D8D8;"  width="9%" -->
			<tr>
				<th align="right"  >
					<b >Group</b>
				</th>
				<th align="right"  >
					<b>Rental Type</b>
				</th>
				<th align="right">
					<b>Rate</b>
				</th>
				<th align="right" >
					<b>CDW</b>
				</th>
					<th align="right"  >
					<b>SCDW</b>
				</th>
					<th align="right">
					<b>GPS</b>
				</th>
					<th align="right" >
					<b>Child<br>seat</b>
				</th>
					<th align="right" >
				<b>Cooler</b>
				</th>
					<th align="right" >
				<b>KM Rest</b>
				</th>
				<th align="right" >
				<b>KM Rate</b>
				</th>
					<th align="right" >
					<b>Insur Chg</b>
				</th>
					<th align="right" >
					<b>Ex.Hr Chg</b>
				</th>
					<th align="right" >
					<b>Chauf</b>
				</th>
					<th align="right" >
					<b>Chauf Ext</b>
				</th>
					
				
			</tr>
		</thead> 
		<!-- <tfoot>
<tr>
<td align="center">
<label style="color: #D8D8D8;"><b>Powered by GATEWAY ERP</b></label>
</td>
</tr>
</tfoot> -->
<tbody>

  <s:set var="grouptemp" value="0" />
 <s:set var="counter" value="0"/>
 <s:set var="temp" value="0"/>
<s:iterator var="stat" value='#request.NORMALPRINT' >
<s:set var="counter" value="%{#counter+1}"/>
<tr>   

    <s:iterator status="arr" value="#stat.split('::')" var="des"> 
  

		<s:if test="#arr.index==0 && #des.equals('')">
			 <td  align="right"  width="9.5%" rowspan="2">
			 <img alt="Pic" src="../../../../icons/car.jpg" height="20px" width="50px">
		</s:if>
		<s:else>
			<s:if test="#arr.index==0">
			<td  align="right"  width="9.5%">
			
			</s:if>
		<s:elseif test="#arr.index==1">
			 <td  align="right"  width="7.5%">
			 </s:elseif>
			 <s:elseif test="#arr.index==8">
			 <td  align="right"  width="6%">
			 </s:elseif>
			  <s:elseif test="#arr.index==9">
			 <td  align="right"  width="6%">
			 </s:elseif>
			 <s:elseif test="#arr.index==11">
			 <td  align="right"  width="6%">
			 </s:elseif> 
			 <s:else>
			 <td  align="right"  width="7%">
			 </s:else>
			

		<s:property value="#des"/>
		 
		</s:else>
 
		
 
  	</td>

 </s:iterator>
	
</tr>
 <%--  <s:if test="{#counter==33}">
	
		<s:property value='AAAAAAAAAAAA'/>
		<div class='breakclass'></div>
		</s:if>  --%>
</s:iterator>
</tbody>

</table>


<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
</div>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
</form>
</div>
</body>
</html>

  <jsp:include page="../../../../css/printtable.css"></jsp:include> 
 <jsp:include page="../../../../js/printTable.js"></jsp:include> 
