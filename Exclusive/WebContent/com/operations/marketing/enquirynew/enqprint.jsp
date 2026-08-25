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
<body style="font-size:15px;background-color:#fff;"  bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<jsp:include page="../../../common/printHeaderAAA.jsp"></jsp:include>
  <PRE>


</PRE>
<h1 ALIGN="center"><u>ENQUIRY</u></h1>
<br>
<table align="center" width="85%" border="1" cellpadding="5" style="border-collapse: collapse;" > 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td width="53%"> <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="11%" align="left">Document No</td>
    <td  width="21%"> <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Site Name </td>
    <td > <label name="lblsite" id="lblsite" ><s:property value="lblsite"/></label></td>
    <td align="left">Date </td>
    <td > <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
<!--     <td align="left">MOB </td> -->
<%--     <td> <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td> --%>
        <td align="left">Address </td>
    <td > <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
        <td align="left">Contract Type</td>
    <td> <label name="hidradio" id="hidradio" ><s:property value="hidradio"/></label></td>
        
<!--         <td align="left">Type</td> -->
<%--     <td> <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td> --%>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td> <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">Salesman</td>
    <td> <label name="lblsalesman" id="lblsalesman" ><s:property value="lblsalesman"/></label></td>
  </tr>
 
   </table>

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
<br><br><br><br>
<table  id="client" width="85%" border="1" class="tablereceipt" align="center">
<thead>
  <tr height="28" style="background-color: #FDEDEC;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="8%" align="center">Sl No</th>
    <th class="tablereceipt" width="33%" align="left">Site</th> 
    <th class="tablereceipt" width="29%" align="left">Area</th>
    <th class="tablereceipt" width="30%" align="left">Remarks</th>
  	<th class="tablereceipt" width="30%" align="left">Survey type</th>
   </tr>
   
   </thead>
   <s:iterator var="stats" value='#request.sdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arrr" value="#stats.split('::')" var="sdes">   
    <%
    if(i>1){%>
    
  <td  align="center" >
  <s:property value="#sdes"/>
  </td>
   <%} else{ %>
    
  <td  align="center" >
  <s:property value="#sdes"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
   </table>
<br><br><br><br>
<table  id="client" width="85%" border="1" class="tablereceipt" align="center">
<thead>
  <tr height="28" style="background-color: #FDEDEC  ;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="8%" align="center">Sl No</th>
    <th class="tablereceipt" width="33%" align="left">Description</th> 
    <th class="tablereceipt" width="29%" align="left">Qty</th>
    <th class="tablereceipt" width="30%" align="left">Remarks</th>
  
   </tr>
   
   </thead>
   <s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="center" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="center" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
   
</table>

<br><br><br><br><br><br><br><br><br><br><br><br><br>
<table  id="client" width="85%" class="tablereceipt" align="center" style="margin-top: 18%;">
<thead>
  <tr height="28" style="background-color: #FDEDEC  ;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="23%" align="left">Prepared by</th>
    <th class="tablereceipt" width="28%" align="left">Verified by </th> 
    <th class="tablereceipt" width="27%" align="left">Received By</th>
    <th class="tablereceipt" width="22%" align="left">Approved by</th>
  
   </tr>
   <tr style="padding-top:3%;">
   <td class="tablereceipt" width="23%" height="20%" align="left"><br>Name................<br><br>Signature..............<br><br></td>
   <td  class="tablereceipt" width="28%" height="20%" align="left"><br>Name................<br><br>Signature..............<br><br></td>
   <td class="tablereceipt" width="27%" height="20%" align="left"><br>Name................<br><br>Date....................<br><br>Signature..............<br><br></td>
   <td class="tablereceipt" width="22%" height="20%" align="left">&nbsp;</td>
   </tr>
  </thead>
  </table>
  <br><br><br><br><br><br><br><br>
 <jsp:include page="../../../common/printFooterAAA.jsp"></jsp:include>


</div>
</form>
</div>
</body>
</html>
