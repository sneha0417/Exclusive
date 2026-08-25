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
	
	

	 $("#watermark").hide();

}
</script>
</head>
<body style="font-size:10px;" bgcolor="white" onload="hidedraft();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color: white; font-weight: normal;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
 <div id="watermark">
  <p id="watermark-text">DRAFT</p>
	</div>
<table width="100%"  > 
  <tr>
    <td width="8%" align="left">Date</td> 
    <td width="38%">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    
    <td align="left"  width="8%">  </td>
    <td width="13%">&nbsp;</td>

   
    <td align="left"  width="6%">Doc No</td>
    <td>: <label name="docvals" id="docvals" ><s:property value="docvals"/></label></td>
  </tr>
  
   <tr>
    <td width="8%" align="left">Client</td>
    <td colspan="1">: <label id="lblacno" name="lblacno"><s:property value="lblacno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;<label id="lblacnoname" name="lblacnoname"><s:property value="lblacnoname"/></label></td> 

   <td align="left"  width="8%">  </td>
    <td width="13%">&nbsp;</td>
        <td>Inv No</td>
    <td width="11%">: <label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label>  </td>

   </tr>

    <tr> <td align="left"  width="8%">Address</td> 
    <td  colspan="3">: <label name="lblvenaddress" id="lblvenaddress" ><s:property value="lblvenaddress"/></label></td>
    <td align="left"  width="6%">Inv Date</td>
    <td>: <label id="lblinvdate" name="lblinvdate"><s:property value="lblinvdate"/></label> </td>
      
</tr>

</tr>
    <tr> <td align="left"  width="8%">Client TRN</td> 
    <td  colspan="4">: <label name="lblcltrnno" id="lblcltrnno" ><s:property value="lblcltrnno"/></label></td>
    
      
</tr>

<tr> <td align="left"  width="8%">Phone No.</td> 
    <td  colspan="4">: <label name="lblvenphon" id="lblvenphon" ><s:property value="lblvenphon"/></label></td>
    
      
</tr>
<tr> <td align="left"  width="8%">Landline No.</td> 
    <td  colspan="4">: <label name="lblvenland" id="lblvenland" ><s:property value="lblvenland"/></label></td>
    
      
</tr>
    <tr>
    <td width="8%" align="left">Del Date</td>
    <td width="38%">: <label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></td>
        <td align="left"  width="8%">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
    </tr>
    
     <tr>
    <td width="8%" align="left">Del Terms	</td>
    <td colspan="5">: <label name="lbldddtm" id="lbldddtm" ><s:property value="lbldddtm"/></label></label></td> 
    </tr>
    
  <tr>
    <td width="8%" align="left">Pay Terms</td>
    <td colspan="5">: <label id="lblpatms" name="lblpatms"><s:property value="lblpatms"/></label></td> 
    </tr>
  <tr>
    <td width="8%" align="left">Description</td>
    <td colspan="5">: <label id="lbldsc" name="lbldsc"><s:property value="lbldsc"/></label></td> 
    </tr>
     
</table>


</fieldset>
<br>
<table width="100%"><tr><td>
<hr>
<table style="border-collapse: collapse;" width="100%" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
     <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Unit Price</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Discount</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Net Total</b></td>
    <td align="center" style="border-collapse: collapse;"><b>Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Account</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Account Name</b></td>
 
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
</s:iterator></table>
<br/><hr></td></tr>
<tr><td>
<table width="100%">
 <tr style="border-collapse: collapse;">
     <td align="left" style="border-collapse: collapse;" colspan="7"> <b>Total</b></td>
    <td width="3%" align="left" style="border-collapse: collapse;">:&nbsp;</td>
    <td width="81%" align="right" style="border-collapse: collapse;"><label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></label></td>
 </tr>
<tr style="border-collapse: collapse;">
     <td align="left" style="border-collapse: collapse;" colspan="7"> <b>VAT</b></td>
    <td align="left" style="border-collapse: collapse;">:&nbsp;</td>
    <td align="right" style="border-collapse: collapse;"><label id="lbltaxamount" name="lbltaxamount"><s:property value="lbltaxamount"/></label></td>
</tr>
<tr style="border-collapse: collapse;">
     <td align="left" style="border-collapse: collapse;" colspan="7"> <b>Net Total</b></td>
    <td align="left" style="border-collapse: collapse;">:&nbsp;</td>
    <td align="right" style="border-collapse: collapse;"><label id="lblnettaxamount" name="lblnettaxamount"><s:property value="lblnettaxamount"/></label></td>
</tr>
    
<tr style="border-collapse: collapse;">
   <td align="left" style="border-collapse: collapse;" colspan="7"> <b>Amount In Words</b></td>
   <td align="left" style="border-collapse: collapse;">:&nbsp;</td>
   <td align="right" style="border-collapse: collapse;"><label id="lblamountinwords" name="lblamountinwords"><s:property value="lblamountinwords"/></label></td>
</tr>
</table>
<br><hr>
</td></tr></table>

<br>
<input type="hidden" name="watermarks" id="watermarks" value='<s:property value="watermarks"/>'>
</div>
</form>
</div>
</body>


</html>
