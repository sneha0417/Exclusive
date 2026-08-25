
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
 
 
 
 
<script>

 
 
</script>
</head>
<body style="font-size:10px;"  bgcolor="white"  ">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeaderCity.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
<table width="100%" > 
  <tr>
  <td width="8%" align="right">Vendor</td>
    <td width="35%" align="left"  >: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td> 
<%--         <td width="5%" align="right">Type</td>
    <td width="17%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td>  --%>
       <td width="12%"  align="right">Ref No</td>
    <td  width="15%"  align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
  
     <td width="15%"align="right">Date</td> 
    <td  width="15%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    </tr>
   <tr>
     <td   align="right">Delivery</td>
   
     <td  align="left"  >: <label name="expdeldate" id="expdeldate" ><s:property value="expdeldate"/></label></td>
             <td  align="right">Location</td>
     
    <td   align="left">: <label id="lblloc" name="lblloc"><s:property value="lblloc"/></label></td> 
        
 
     
       
    <td   align="right">Doc No</td>
    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
       
     </tr>
     
     <tr>
    
    
    <td align="right">Del Terms</td>
    <td colspan="7" align="left">: <label name="lbldelterms" id="lbldelterms" ><s:property value="lbldelterms"/></label></td>
     </tr>
     
     
     <tr>
    
    
    <td align="right">Pay Terms</td>
    <td colspan="7" align="left">: <label name="lblpaytems" id="lblpaytems" ><s:property value="lblpaytems"/></label></td>
     </tr>
     <tr>
    <td align="right">Description</td>
    <td colspan="7" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    
  </tr>
  </table>
</fieldset>
<br>  


 <br> 

<div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td width="7%" align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td width="10%" align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
    <td width="5%" align="left" style="border-collapse: collapse;"><b>Unit</b></td>
     <td align="center" style="border-collapse: collapse;" width="6%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;" width="7%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;" width="9%"><b>Discount%</b></td>
     <td align="right" style="border-collapse: collapse;" width="7%"><b>Discount</b></td>
     <td align="right" style="border-collapse: collapse;" width="10%"><b>Net Amount</b></td>
     <td align="right" style="border-collapse: collapse;" width="7%"><b>Tax%</b></td>
     <td align="right" style="border-collapse: collapse;" width="7%"><b>Tax</b></td>
     <td align="right" style="border-collapse: collapse;" width="12%"><b>Total Amount</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>4){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
  <%} else if(i==4){ %>
    
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
 <td  >&nbsp;</td>
 <td  >&nbsp;</td>
 <td  >&nbsp;</td>
  </tr>
 <tr >
    <td colspan="2" align="right" ><b></b><b>Amount In Words</b></td>
    <td colspan="9" ><b>: <label id="lblordervaluewords"><s:property value="lblordervaluewords"/></label></b></td>
    <td align="right" ><b>Total</b></td>
     <td align="right" ><label id="lbltotal"><s:property value="lbltotal"/></label></td>

 
  </tr>
</table>
 </fieldset> 
 </div>

      
    
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>

 
 

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
