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
 
 
 <script type="text/javascript">


</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata();hidedraft();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>
<br><br><br><br><br><br><br><br><br><br>
<br>
<br>

  <%-- <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td> --%>
    
  </tr>
</table>

	<table width="100%">
	<tr>
		<td align="center" ><b><font size="5">ESTIMATION</font></b>
		</td>
		
	</tr>
	</table>
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
  
<table width="100%"  > 
  <tr>
  <td width="12%" align="left">Customer</td>
    <td align="left" colspan="2">: <label id="customer" name="customer"><s:property value="customer"/></label> </td>
    <td width="9%"   align="left">Ref No</td>
    <td width="13%"   align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
  
     
        <%-- <td width="5%" align="right">Type</td>
    <td width="17%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
      --%>
      <td width="6%" align="right">Date</td> 
    <td width="21%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    </tr>
    <tr>
    <td width="12%" align="left">Address</td>
    <td colspan="2" >: <label id="customeraddress" name="customeraddress"><s:property value="customeraddress"/></label>
     <td   align="left">Total Amount</td>
    <td   align="left">: <label id="totalamount" name="totalamount"><s:property value="totalamount"/></label></td>
  
    </td> 
    
    
    </tr>
   <tr>
    <td  align="left">Type</td>
    <td colspan="2" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
    
       
    <td width="9%"   align="left">Doc No</td>
    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
        <td  align="left">Revision No</td>
    <td width="20%" align="left">: <label id="revisionno" name="revisionno"><s:property value="revisionno"/></label></td> 
     
     <td width="19%"></td>
     <td></td>
     </tr>
    
  </table>

</fieldset>
<br> 


<div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;" width="15%"><b>Site</b></td>
    <td align="left" style="border-collapse: collapse;"width="9%"><b>Service Type</b></td>
    <td align="left" style="border-collapse: collapse;" width="12%"><b>Description</b></td>
     <td align="center" style="border-collapse: collapse;" width="15%"><b>Product</b></td>
    <td align="right" style="border-collapse: collapse;" width="4%"><b>Unit</b></td>
    <td align="right" style="border-collapse: collapse;" width="4%"><b>Qty</b></td>
     <td align="right" style="border-collapse: collapse;" width="6%"><b>Amount</b></td>
     <td align="right" style="border-collapse: collapse;" width="6%"><b>Total</b></td>
 <td align="right" style="border-collapse: collapse;" width="6%"><b>Margin</b></td>
     <td align="right" style="border-collapse: collapse;" width="9%"><b>Net Total</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>4){%>
    
  <td  align="right" >&nbsp;
  <s:property value="#des"/>
  </td>
  <%} else if(i==4){ %>
    
  <td  align="center" >&nbsp;
  <s:property value="#des"/>
  </td>
   
  
   <%} else{ %>
    
  <td  align="left" >&nbsp;
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 <tr >
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td  >&nbsp;</td>
     <td  >&nbsp;</td>
 <td  >&nbsp;</td>
 <td  >&nbsp;</td>
  </tr>
 <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td> 
    <td ><b></b></td>
    <td ><b></b></td>
     <td ><b></b></td>
    <td align="right" ><b>Total</b></td>
     <td align="right" ><label id="lbltotal"><s:property value="totalamount"/></label></td>

 
  </tr>
</table>
 </fieldset> 
 </div>
 <h2>Site Wise Details</h2>
 <div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    
    <td align="left" style="border-collapse: collapse;" width="15%"><b>Site</b></td>
    <td align="left" style="border-collapse: collapse;" width="6%"><b>Total</b></td>
    <td align="left" style="border-collapse: collapse;" width="6%"><b>Margin</b></td>
    <td align="left" style="border-collapse: collapse;" width="9%"><b>Net Total</b></td>
 
  </tr>

<s:iterator var="site" value='#request.sitedetails' >
<tr>   
 <%int i=0; %> 
    <s:iterator status="arr" value="#site.split('::')" var="des1">   
     <%if(i>4){%> 
    
  <td  align="right" >&nbsp;
  <s:property value="#des1"/>
  </td>
   <%} else if(i==4){ %> 
    
  <td  align="center" >&nbsp;
  <s:property value="#des1"/>
  </td>
   
  
    <%} else{ %> 
    
  <td  align="left" >&nbsp;
  <s:property value="#des1"/>
  </td> <% } i++;  %> 
  
 </s:iterator>
</tr>
</s:iterator>
 <tr >
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    
  </tr>
 
</table>
 </fieldset> 
 </div>
 

 <br>
 
          
   <br>
    <input type="hidden" name="secndtarray" id="secndtarray" value='<s:property value="secndtarray"/>'>
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
 