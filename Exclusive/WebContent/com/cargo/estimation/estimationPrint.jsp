<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<%--    <jsp:include page="../../../includes.jsp"></jsp:include>   --%>
<style media="print">
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 0px;
  -moz-border-radius: 0px;
  border-radius: 0px;
  border: 1px solid rgb(139,136,120);

 }
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}



#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       table td{
      	cellspacing:0;
      	cellpadding:0;
      	border-collapse:collapse;
      	padding:0;
      }
      
</style> 
<style media="all">
      table{
   /*    	cellpadding:0; */
      	cellspacing:0;
      	border-collapse:collapse;
      	border-spacing:0px;
      }
/*       table td{
      	cellspacing:0;
      	cellpadding:0;
      	border-collapse:collapse;
      	padding:0;
      }
 */
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }

</style>
<script>
$(document).ready(function () {
	//document.getElementById("salikdiv").style.display="none";
	//alert(document.getElementById("lblsalikcount").value);
	/* if(document.getElementById("lblsalikcount").value=="0"){
		document.getElementById("salikdiv").style.display="none";
	}
	else{
		document.getElementById("salikdiv").style.display="block";
	} */
});
/* function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmLeaseCalcPrintNormal").submit(); 
} */
</script>
</head>
<body onload="" bgcolor="white"  style="font-size:10px;background-color:#fff;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEstimationPrint" action="printEstimation" autocomplete="off" target="_blank">

 <div style="background-color:white;">
 <jsp:include page="../../../com/common/printHeader.jsp"></jsp:include> 
 	<s:set name="reqcounter" value="1" />
  	<s:set name="reqsrno" value="0" />
  	<s:set name="srno" value="0" />
  	<s:set name="rdocno" value="0" />
  	<s:set name="savestatus" value="0" />
  	<fieldset>
  	<br/>
<table style="width:100%;">
  <tr>
  	<td width="10%" align="right"><b>Doc No</b>&nbsp;</td>
    <td width="20%" align="left">:&nbsp;<label id="lbldocno"><s:property value="lbldocno"/></label></td>
    <td width="12%" align="right"><b>Date</b>&nbsp;</td>
    <td width="23%" align="left">:&nbsp;<label id="lbldate"><s:property value="lbldate"/></label></td>
    <td width="15%" align="right"><b>Enquiry No</b></td>
    <td width="20%" align="left">:&nbsp;<label id="lblenquiryno"><s:property value="lblenquiryno"/></label></td>
  </tr>

  <tr>
    <td align="right"><b>Client Name</b>&nbsp;</td>
    <td align="left">:&nbsp;<label id="lblclientname"><s:property value="lblclientname"/></label></td>
    <td align="right"><b>Client Address</b></td>
    <td align="left">:&nbsp;<label id="lbladdress"><s:property value="lbladdress"/></label></td>
    <td align="right"><b>Client Mob</b>&nbsp;</td>
    <td align="left">:&nbsp;<label id="lblmobile"><s:property value="lblmobile"/></label></td>
  </tr>
 
</table>
  </fieldset>
  <br>
  
  <s:iterator var="stat1" status="arr" value="%{#request.ENQDATA}" >
  <fieldset>
  	<table style="width:100%;">
  		<tr>
			<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width:2%">Sr No.</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Mode</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Sub Mode</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" >Shipment</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Terms</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Origin</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width:7%">PoL</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width:7%">PoD</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Commodity</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Weight</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">No of Packs</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width:4%">Dimension</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width:4%">Volume</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Remarks</td>
	  		<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; border-right:1px solid black;">Qty</td>
	  	</tr>
	  	<s:iterator status="arr" value="#stat1" var="stat">
			<s:iterator status="arr" value="#stat.split('::')" var="des">
				<s:if test="#reqcounter==1">
					<tr height="20px;">
					<s:set name="reqcounter" value="%{#reqcounter+1}" />
				</s:if>
				<s:if test="#arr.index<=15">
					<s:if test="#arr.index==0">
						<s:set name="enqno" value="%{#des}" />
  					</s:if>
  					<s:if test="#arr.index>0"><td><s:property value="#des"/></td></s:if>
  					<s:if test="#arr.index>15">
						</tr>
						<s:set name="reqcounter" value="%{#reqcounter+1}" />
						<tr><td colspan="15">&nbsp;</td></tr>
  					</s:if>
				</s:if>
			</s:iterator>
			<tr><td colspan="15"><hr></tr>
			<s:set name="estm" value="0" />
			<table>
			<s:iterator var="stat3" status="arr" value="%{#request.ESTMDATA}" >
  				
  				<s:iterator status="arr" value="#stat3" var="stat4">
  					
  					<s:if test="#stat4.split('::')[0]==#enqno">
  					
  					<s:if test="#estm==0">
  					<tr style="border: none;">
				<td  style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black; width: 2%">Sr No.</td>
				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Service Type</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Vendor</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">Currency</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" align="right">Rate</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" align="right">Price</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" align="right">Qty</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" align="right">Total</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;" align="right">Base Total</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">UOM</td>
  				<td style="background-color:#DADADF;padding:0;cellspacing:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;border-right:1px solid black;">Billing</td>
				</tr>
				</s:if>
				<s:set name="estm" value="%{#estm+1}" />
				
  					
  						<tr height="20px;" style="border: none;">
  							<s:iterator status="arr" value="#stat4.split('::')" var="des1">
  								<s:if test="#arr.index==0">
  									<s:set name="enqdocno" value="%{#des1}"></s:set>
  								</s:if>
  								<s:if test="#enqdocno==#enqno">
	  								<s:if test="#arr.index>0">
	  									<s:if test="(#arr.index>=5&&#arr.index<=9)">
	  										<td align="right" width="5%"><s:property value="#des1"/></td>
	  									</s:if>
	  									 <s:elseif test="#arr.index==1||#arr.index==4">
	  										<td  style="width: 2%"><s:property value="#des1"/></td>
	  									</s:elseif>
	  									<s:elseif test="#arr.index==3">
	  										<td  style="width: 15%"><s:property value="#des1"/></td>
	  									</s:elseif>
	  									<s:else>
											<td  width="8%"><s:property value="#des1"/></td>
										</s:else>						
	  								</s:if>
  								</s:if>
  							</s:iterator>
  						</tr>	
  					</s:if>
  					
  				</s:iterator>
  			</s:iterator>
  			</table>
  			
   		</s:iterator>
  	</table>
  </fieldset>
  </s:iterator>
</form>
</div>
</body>
</html>