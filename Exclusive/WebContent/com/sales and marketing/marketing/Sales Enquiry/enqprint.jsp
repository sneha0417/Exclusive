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
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
<%-- <table width="100%" > 
  <tr>
    <td width="10%" align="left">Date </td>
    <td width="10%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
     <td width="25%" align="right">Ref No </td>
    <td width="10%" align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td> 
 
    <td width="30%" align="right">Doc No</td>
    <td  width="15%"  align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
   
    <td align="left">Description</td>
    <td colspan="5" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
  </tr>

 
   </table> --%>
   
   
  
<table width="100%" > 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td   width="60%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td> 
    <td   align="right" width="10%">Doc No</td>
    <td  width="15%">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
  
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
     <td align="right">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
    <td align="right">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>
 
     
</table>
 
<table width="100%" >
  <%-- <tr>
    <td width="20%" align="left">Doc No</td>
    <td colspan="2">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>--%>
   <tr>
    
    <td align="left" width="15%">Del Terms</td>
    <td   align="left">: <label name="lbldelterms" id="lbldelterms" ><s:property value="lbldelterms"/></label></td> 
  </tr>
      <tr>
   
    <td align="left">Pay Terms</td>
    <td align="left">: <label name="lblpaytrems" id="lblpaytrems" ><s:property value="lblpaytrems"/></label></td>
  </tr>
       <tr>
   
    <td align="left">Description</td>
    <td   align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
  </tr>
     
</table>
   

</fieldset>
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
