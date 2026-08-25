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
  
<table width="100%" > 
  <tr>
  <td width="8%" align="right">Vendor</td>
    <td width="35%" align="left" colspan="3">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td> 
        <td width="5%" align="right">Type</td>
    <td width="17%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
       <td   align="right">Ref No</td>
    <td   align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
  
     <td width="10%" align="right">Date</td> 
    <td width="12%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    </tr>
   <tr>
     <td   align="right">Delivery</td>
   
     <td  align="left"  >: <label name="expdeldate" id="expdeldate" ><s:property value="expdeldate"/></label></td>
             <td  align="right">Location</td>
    <td align="left">: <label id="lblloc" name="lblloc"><s:property value="lblloc"/></label></td> 
          <td   align="right">Inv No</td>
    <td   align="left">: <label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></td> 
       <td   align="right">Inv Date</td>
    <td   align="left">: <label id="lblinvdate" name="lblinvdate"><s:property value="lblinvdate"/></label></td>
  
     
       
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
