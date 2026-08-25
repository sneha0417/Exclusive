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
<body style="font-size:10px;"  bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<table width="100%" >
  <tr>
    <td width="4%"   align="right">Date</td>
    <td width="11%"> : <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref No</td>
    <td width="29%"> : <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
    <td width="6%" align="right">Doc No</td>
    <td width="19%"> : <label id="lbldocno" name="lbldocno"><s:property value="lbldocno"/></label>
  </tr>
</table>
<table width="100%" >
<tr>
<td width="50%">
<fieldset>
<legend><b>Inventory Transfer From</b></legend>  
<table width="100%"  >
<tr>
    <td width="10%" align="right">Type</td>
    <td width="27%"> : <label id="lblreftype" name="lblreftype"><s:property value="lblreftype"/></label></td>
  </tr>
  <tr>
    <td width="21%"><div align="right">Branch</div></td>
    <td width="79%">  : <label id="lblbranchfrom" name="lblbranchfrom"><s:property value="lblbranchfrom"/></label></td>
  </tr>
  <tr>
    <td><div align="right">Location</div></td>
    <td> : <label id="lbllocationfrom" name="lbllocationfrom"><s:property value="lbllocationfrom"/></label></td>
  </tr>
  
</table>

</fieldset>
</td>

<td width="50%">
<fieldset>
<legend><b>Inventory Transfer To</b></legend>
<table width="100%" >
  <tr>
    <td width="21%"><div align="right">Branch</div></td>
    <td width="79%"> : <label id="lblbranchto" name="lblbranchto"><s:property value="lblbranchto"/></label></td>
  </tr>
  <tr>
    <td><div align="right">Location</div></td> 
    <td> : <label id="lbllocationto" name="lbllocationto"><s:property value="lbllocationto"/></label></td>
  </tr>
  <tr>
    <td width="10%" align="right">Remarks</td>
    <td width="27%"> : <label id="lblremarks" name="lblremarks"><s:property value="lblremarks"/></label></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<br>  


 <fieldset>  
<table style="border-collapse: collapse;" width="100%"  >   

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Quantity</b></td>
 

 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" >
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

</table>
 </fieldset> 
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


</div>
</form>
</div>
</body>
</html>
