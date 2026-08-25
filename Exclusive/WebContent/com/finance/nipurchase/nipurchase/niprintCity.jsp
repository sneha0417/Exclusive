<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
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
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }
#watermark{
    position:absolute;
    z-index:0;
    background:none;
    display:block;
    min-height:60%; 
    min-width:50%;
    align: center;
    padding-left: 100px;
    opacity:0.1;
}


#watermark-text
{
    color:lightgrey;
    font-size:180px;
    transform:rotate(300deg);
    -webkit-transform:rotate(300deg);
}
</style> 
  <%-- <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style>  --%>
<script>
function hidedraft()
{

	var second=document.getElementById("watermarks").value;
	
	if(parseInt(second)==3) 
		{
		   $("#watermark").hide();
		}
	else
		{
		$("#watermark").show();
		}
	
	



}
</script>
</head>
<body style="font-size:10px;" bgcolor="white" onload="hidedraft();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeaderCity.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
 <div id="watermark">
  <p id="watermark-text">DRAFT</p>
	</div>
<table width="100%"  > 
  <tr>
    <td width="10%" align="left"><font size="2">Date</font></td> 
    <td width="45%"><font size="2">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></font></td> 
    
    <td align="left"  width="2%"><font size="2">Type</font> </td>
    <td width="16%"><font size="2">: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></font></td>

   
    <td align="left"  width="7%"><font size="2">Doc No</font></td>
    <td><font size="2">: <label name="docvals" id="docvals" ><s:property value="docvals"/></label></font></td>
  </tr>
  
   <tr>
    <td width="10%" align="left"><font size="2">Vendor</font></td>
    <td colspan="1"><font size="2">: <label id="lblacno" name="lblacno"><s:property value="lblacno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;<label id="lblacnoname" name="lblacnoname"><s:property value="lblacnoname"/></label></font></td> 
   

   
      <td align="left"  width="7%"><font size="2">Inv No</font></td> 
    <td><font size="2">: <label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></font></td>
   <td align="left"  width="7%"><font size="2">Inv Date</font></td>
    <td><font size="2">: <label id="lblinvdate" name="lblinvdate"><s:property value="lblinvdate"/></label></font> </td>
   
    </tr>
    <tr> <td align="left"  width="7%"><font size="2">Address</font></td> 
    <td  colspan="4"><font size="2">: <label name="venaddress" id="venaddress" ><s:property value="venaddress"/></label></font></td>
    
      
</tr>
<tr> <td align="left"  width="7%"><font size="2">Phone No.</font></td> 
    <td  colspan="4"><font size="2">: <label name="venphon" id="venphon" ><s:property value="venphon"/></label></font></td>
    
      
</tr>
<tr> <td align="left"  width="7%"><font size="2">TRN No.</font></td> 
    <td  colspan="4"><font size="2">: <label name="ventrno" id="ventrno" ><s:property value="ventrno"/></label></font></td>
    
      
</tr>
<tr> <td align="left"  width="7%"><font size="2">Landline No.</font></td> 
    <td  colspan="4"><font size="2">: <label name="venland" id="venland" ><s:property value="venland"/></label></font></td>
    
      
</tr>
    <tr>
    <td width="10%" align="left"><font size="2">Del Date</font></td>
    <td width="20%"><font size="2">: <label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></font></td>
        <td align="left"  width="10%">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
    </tr>
    
     <tr>
    <td width="10%" align="left"><font size="2">Del Terms</font></td>
    <td colspan="5"><font size="2">: <label name="lbldddtm" id="lbldddtm" ><s:property value="lbldddtm"/></label></label></font></td> 
    </tr>
    
  <tr>
    <td width="10%" align="left"><font size="2">Pay Terms</font></td>
    <td colspan="5"><font size="2">: <label id="lblpatms" name="lblpatms"><s:property value="lblpatms"/></label></font></td> 
    </tr>
  <tr>
    <td width="10%" align="left"><font size="2">Description</font></td>
    <td colspan="5"><font size="2">: <label id="lbldsc" name="lbldsc"><s:property value="lbldsc"/></label></font></td> 
    </tr>
     
</table>


</fieldset>
<br>
<fieldset>
<table style="border:1px solid black; " width="100%" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;font-size:10px;">
     <td align="left" ><b>Sl No</b></td>
    <td align="left" ><b>Description</b></td>
    <td align="left" ><b>Qty</b></td>
    <td align="right" ><b>Unit Price</b></td>
    <td align="right" ><b>Total</b></td>
    <td align="right" ><b>Discount</b></td>
    <td align="right" ><b>Tax Amount</b></td>
    <td align="right" ><b>Net Total</b></td>
    <td align="center"><b>Type</b></td>
    <td align="left" ><b>Account</b></td>
    <td align="left" ><b>Account Name</b></td>
    <td align="left" ><b>Cost Type</b></td>
    <td align="left" ><b>Cost Code</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if((i==3)||(i==4)||(i==5)||(i==6)) {%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
 
   <%}
   else if(i==7) {%>
    
  <td  align="center" >
  <s:property value="#des"/>
  </td>
  
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 <tr style="border-collapse: collapse;">
   <td align="left" style="border-collapse: collapse;">&nbsp;</td>
     <td align="left" style="border-collapse: collapse;"></td>
    <td align="left" style="border-collapse: collapse;">
   
    
    &nbsp;
    </td>
    
    </tr>
    </table>
</fieldset>

<table align="right">

 
     <td align="right" style="border-collapse: collapse;" colspan="7"> <b>Total Amount&nbsp;&nbsp;</b><label id="lbltotals" name="lbltotals"><s:property value="lbltotals"/></label> &nbsp; &nbsp; &nbsp;
    &nbsp;&nbsp;
    <b>Roundof</b>&nbsp;&nbsp;<label id="lblroundof" name="lblroundof"><s:property value="lblroundof"/>&nbsp;</label> </td>
    <td align="right" style="border-collapse: collapse;"><b>Net Total</b>&nbsp;&nbsp;<label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></label></td>

    
 
  </tr>
   <tr style="border-collapse: collapse;">
     <td align="right" style="border-collapse: collapse;" colspan="7"> <b>Amount In Words</b></td>
    <td align="left" style="border-collapse: collapse;" colspan="7">&nbsp;&nbsp;&nbsp;<label id="amountinwords" name="amountinwords"><s:property value="amountinwords"/></label></td>
    <td align="left" style="border-collapse: collapse;">&nbsp;</td>
    <td align="left" style="border-collapse: collapse;">&nbsp;</td>
      <td align="left" style="border-collapse: collapse;">&nbsp;</td>
 
  </tr>
</table>

<br>
<table>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
<tr><td>&nbsp;
</td></tr>
</table>
<table id="preparedby" width="100%" class="tablereceipt">
  <tr>
    <td width="32%" height="25" class="tablereceipt">&nbsp;</td>
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Prepared By</b></td>
    <td width="55%">:&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    </tr>
    </table>
    </td>
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Verified By</b></td>
    <td width="55%">:&nbsp;<label name="lblverifiedby" id="lblverifiedby" ><s:property value="lblverifiedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblverifiedon" id="lblverifiedon" ><s:property value="lblverifiedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblverifiedat" id="lblverifiedat" ><s:property value="lblverifiedat"/></label></td>
    </tr>
    </table>
    </td>
    
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Approved By</b></td>
    <td width="55%">:&nbsp;<label name="lblapprovedby" id="lblapprovedby" ><s:property value="lblapprovedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblapprovedon" id="lblapprovedon" ><s:property value="lblapprovedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblapprovedat" id="lblapprovedat" ><s:property value="lblapprovedat"/></label></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td align="left" class="tablereceipt">
      <table width="100%">
       <tr><td align="left"><font style="font-size: 8px;"><b>This is a system generated document and signature is not required.</b></font></td></tr>
       <tr><td  align="left"><font style="font-size: 8px;"><b>This document is processed through ERP system by the authorised persons mention on the right side.</b></font></td></tr>
      </table>
    </td>
  </tr>
</table>
<%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include> --%>
<!-- <div class="divFooter"  >
<table width="100%" >
  <tr>
   <td width="40%">&nbsp;</td> <td width="80%" style="color: #D8D8D8;" align="left"><b>  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Powered by GATEWAY ERP
 &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
  </tr>
</table>
</div>  -->

<input type="hidden" name="watermarks" id="watermarks" value='<s:property value="watermarks"/>'>
</div>
</form>
<div style="position:absolute; bottom:0;">
<footer>
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printFooterCity.jsp"></jsp:include></td>
    
  </tr>
</table>
</footer>
</div>
</div>
</body>
</html>
