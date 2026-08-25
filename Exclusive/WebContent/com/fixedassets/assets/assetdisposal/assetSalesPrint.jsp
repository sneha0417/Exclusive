
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
   <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style media="print">
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
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}
table tr td{
	page-break-inside:avoid;
}

 table.print-friendly tr td, table.print-friendly tr th {
        page-break-inside: avoid;
    }
#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
table{
border-collapse:collapse;
/* border:1px solid #000; */
border-radius:20px;
}
td{
cell-padding:0;
cell-spacing:0;
}
body{
background-color:#fff !important;

}
.bordertop{
	border-top:1px solid #000;
}
.borderbottom{
	border-bottom:1px solid #000;
}
.borderleft{
	border-left:1px solid #000;
}
.borderright{
	border-right:1px solid #000;
}
</style> 
<script>
$(document).ready(function () {

});
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmSaleInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" style="background-color:white;">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmSaleInvoicePrint" action="printSaleInvoice" autocomplete="off" target="_blank">
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
 <s:set name="counter" value="0"></s:set>
 <input type="hidden" name="jvsize" id="jvsize" value='<s:property value="jvsize"/>'/>
 <s:set name="jvcounter" value="jvsize"></s:set>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" ></td>
    <td colspan="3"> <label name="lblclientcode" id="lblclientcode" ><%-- <s:property value="lblclientcode"/> --%></label>&nbsp;&nbsp;&nbsp;&nbsp;
    <label name="lblclientname" id="lblclientname" ><%-- <s:property value="lblclientname"/> --%></label>
    </td>
    <td width="8%">&nbsp;</td>
    <td width="8%">Doc No</td>
    <td width="11%">: <label name="lbldocno" id="lbldocno" ><s:property value="lbldocno"/></label></td>
  </tr>
  <tr>
    <td>Description</td>
    <td width="52%">: <label name="lbldesc" id="lbldesc" ><s:property value="lbldesc"/></label></td>
    <td width="6%">Type</td>
    <td width="8%">: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></td>
    <td>&nbsp;</td>
    <td>Date</td>
    <td>:<label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label> </td>
  </tr>
</table>
</fieldset>
<br>
<hr>
<table width="100%">
 <tr>
    <td align="left"><b>SI No</b></td>
    <td align="left"><b>Asset ID</b></td>
    <td align="left"><b>Asset Name</b></td>
    <td align="left"><b>Dep Posted</b></td>
    <!-- <td align="right"><b>Sales Price</b></td> -->
    <td align="right"><b>Pur Value</b></td>
    <td align="right"><b>Acc Dep</b></td>
    <td align="right"><b>Cur Dep</b></td>
    <td align="right"><b>Net Book</b></td>
    <td align="right"><b>Net P/(L)</b></td>
  </tr>
  
  
  </tr>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
	
		<s:iterator status="arr" value="#stat1" var="stat">
        	<tr>   
				
     				<s:iterator status="arr" value="#stat.split('::')" var="des">
    					<s:if test="#arr.index<=3">
    						<td align="left">
  						</s:if>
  						<s:else>
  							<td  align="right">
  						</s:else>
								<s:property value="#des"/>
							</td>
   					
 					</s:iterator>
			</tr>
		</s:iterator>
	
</s:iterator>

</table>
<%-- <hr>
<table width="100%" class="print-friendly">
	<tr >
    	<td  align="left" class="borderleft bordertop borderbottom borderright">Sr No</th>
      	<td  align="left" class="bordertop borderbottom borderright">Type</th>
      	<td  align="left" class="bordertop borderbottom borderright">Account</th>
      	<td  align="left" class="bordertop borderbottom borderright">Account Name</th>
      	<td  align="right" class="bordertop borderbottom borderright">Debit</th>
      	<td  align="right" class="bordertop borderbottom borderright">Credit</th>
      	<td  align="right" class="bordertop borderbottom borderright">Base Amt</th>
      	<td  align="left" class="bordertop borderbottom borderright">Description</th>
	</tr>
    <s:iterator var="statsalik" status="arr" value='#request.JVPRINT' >
      						
								<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
									<s:set name="counter" value="%{#counter+1}" />
									<tr style="page-break-inside: avoid;">
									
 										<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
 											
											<s:if test="#arr.index<=3">
												<s:if test="#arr.index==0">
													<s:if test="#counter == #jvcounter">
    													<td align="left" style="page-break-inside: avoid;" class="borderleft borderright borderbottom">
    												</s:if>
													<s:else>
														<td align="left" style="page-break-inside: avoid;" class="borderleft borderright">
													</s:else>
												</s:if>
												<s:else>
													<s:if test="#counter == #jvcounter">
														<td align="left" style="page-break-inside: avoid;" class="borderright borderbottom">
													</s:if>
													<s:else>
														<td align="left" style="page-break-inside: avoid;" class="borderright ">
													</s:else>
												</s:else>
												
											</s:if>
											<s:elseif test="#arr.index==7">
												
												<s:if test="#counter == #jvcounter">
													<td align="left" style="page-break-inside: avoid;" class="borderright borderbottom">
												</s:if>
												<s:else>
													<td align="left" style="page-break-inside: avoid;" class="borderright">
												</s:else>
												
											</s:elseif>
											<s:else>
												
												<s:if test="#counter == #jvcounter">
													<td align="right" style="page-break-inside: avoid;" class="borderright borderbottom">
												</s:if>
												<s:else>
													<td align="right" style="page-break-inside: avoid;" class="borderright">
												</s:else>
											</s:else>
  											<s:property value="#dessalik"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							
  						</s:iterator>
</table>
<table width="100%" border="0">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="9%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="23%">&nbsp;</td>
    <td width="13%">&nbsp;</td>
    <td width="12%"><b>Debit Total</b></td>
    <td width="12%"><label id="lbldebittotal" name="lbldebittotal">
      <s:property value="lbldebittotal"/>
    </label></td>
    <td width="12%"><b>Credit Total</b></td>
    <td width="11%"><label id="lblcredittotal" name="lblcredittotal">
      <s:property value="lblcredittotal"/>
    </label></td>
  </tr>
</table> --%>
<%-- <div style="page-break-after:always;"></div>
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Client Name </td>
    <td colspan="3">: <label name="lblclientname" id="lblclientname" ><s:property value="lblclientname"/></label></td>
    <td width="18%" align="left">Doc No </td>
    <td width="20%"> : <label name="lbldocno" id="lbldocno" ><s:property value="lbldocno"/></label></td>
  </tr>
  <tr>
    <td align="left">Client Code </td>
    <td width="18%">: <label name="lblclientcode" id="lblclientcode" ><s:property value="lblclientcode"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="left">Mobile </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td align="left">Phone</td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">Type </td>
    <td>: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td colspan="5">: <label name="lbldesc" id="lbldesc" ><s:property value="lbldesc"/></label></td>
    </tr>
  
</table>
</fieldset>
<br>
<hr>
<table width="100%">
 <tr>
    <td align="left" width="10%"><b>SI No</b></td>
    <td align="left" width="10%"><b>Fleet No</b></td>
    <td align="left" width="10%"><b>Reg No</b></td>
    <td align="left" width="25%"><b>Chassis No</b></td>
    <td align="left" width="35%"><b>Fleet Name</b></td>
    <!-- <td align="left"><b>Dep Posted</b></td> -->
    <td align="right" width="20%"><b>Sales Price</b></td>
    <!-- <td align="right"><b>Pur Value</b></td>
    <td align="right"><b>Acc Dep</b></td>
    <td align="right"><b>Cur Dep</b></td>
    <td align="right"><b>Net Book</b></td>
    <td align="right"><b>Net P/(L)</b></td> -->
  </tr>
  
  
  </tr>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT2}" >
	
		<s:iterator status="arr" value="#stat1" var="stat" >
        	<tr>   
				
     				<s:iterator status="arr" value="#stat.split('::')" var="des" begin="0" end="5">
     				
    					<s:if test="#arr.index<=4">  
  							<td  align="left">
  						</s:if>
  						<s:else>
  							<td  align="right">
  						</s:else>
  						
								<s:property value="#des"/>
						
							</td>
   					
 					</s:iterator>
			</tr>
		</s:iterator>
	
</s:iterator>

</table>


<hr>
<table width="100%" >
  <tr>
    <td width="197" align="left"><b>Total :</b></td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
 --%>
<hr>
<br><br>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

</div>
</form>
</div>
</body>
</html>
