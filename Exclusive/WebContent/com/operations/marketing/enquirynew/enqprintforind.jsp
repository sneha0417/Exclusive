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
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <%-- <td><jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include></td> --%>
    
  </tr>
</table>
<fieldset>
<%-- <table width="100%">
<tr>
<td width="60%">



  
<table width="100%" > 
  <tr>
    <td width="25%" align="left">Customer Name </td>
    <td colspan="2">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
  </tr>
 
     
</table>
</td>

<td width="40%">
<table width="100%" >
  <tr>
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
  </tr>
  <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
   <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
     
</table>


</td>
</tr>


</table> --%>
<table width="100%" > 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td width="61%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="8%" align="left">Doc No</td>
    <td  width="16%">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
        <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
   </table>
</fieldset>
<br>
<%-- <fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  
  </table>
</fieldset> --%>

 <fieldset> 
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Brand</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Model</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Specification</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Color</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Rent Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>From Date</b></td>
    <td align="left" style="border-collapse: collapse;"><b>To Date</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
 
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
<%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include> --%>


</div>
</form>
</div>
</body>
</html>
