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
<body style="font-size:15px;" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/KprintHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>

<table width="100%"  > 
  <tr>
    <td width="10%" align="left">Date</td> 
    <td width="45%">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    
    <td align="left"  width="2%">Type </td>
    <td width="16%">: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></td>

   
    <td align="left"  width="7%">Doc No</td>
    <td>: <label name="docvals" id="docvals" ><s:property value="docvals"/></label></td>
  </tr>
  
   <tr>
    <td width="10%" align="left">Vendor</td>
    <td colspan="1">: <label id="lblacno" name="lblacno"><s:property value="lblacno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;<label id="lblacnoname" name="lblacnoname"><s:property value="lblacnoname"/></label></td> 
   

   
      <td align="left"  width="7%">Inv No</td> 
    <td>: <label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label>  </td>
   <td align="left"  width="7%">Inv Date</td>
    <td>: <label id="lblinvdate" name="lblinvdate"><s:property value="lblinvdate"/></label> </td>
   
    </tr>
    
    <tr>
    <td width="10%" align="left">TRN No.</td>
    <td colspan="1">: <label id="lbltrno" name="lbltrno"><s:property value="lbltrno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;</td> 
  
    </tr>
    
    <tr>
    <td width="10%" align="left">Del Date</td>
    <td width="20%">: <label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></td>
        <td align="left"  width="10%">Del Terms	</td>
    <td colspan="3">: <label name="lbldddtm" id="lbldddtm" ><s:property value="lbldddtm"/></label></td>
    </tr>
  <tr>
    <td width="10%" align="left">Pay Terms</td>
    <td colspan="5">: <label id="lblpatms" name="lblpatms"><s:property value="lblpatms"/></label></td> 
    </tr>
  <tr>
    <td width="10%" align="left">Description</td>
    <td colspan="5">: <label id="lbldsc" name="lbldsc"><s:property value="lbldsc"/></label></td> 
    </tr>
     
</table>


</fieldset>
<br>
<fieldset>
<table style="border-collapse: collapse;" width="100%" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
     <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse; width:25%"><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Unit Price</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Discount</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Tax %</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Tax Amount</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Net Total</b></td>
    <td align="center" style="border-collapse: collapse;"><b>Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Account</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Account Name</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Reg No</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if((i==3)||(i==4)||(i==5)||(i==6)||(i==7)||(i==8)) {%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
 
   <%}
   else if(i==9) {%>
    
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
</table>
<br>
<table width="100%" border="0">
  <tr>
    <td width="64%">&nbsp;</td>
    <td width="10%"><b>Total</b></td>
    <td width="26%">: <label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><b>Discount</b></td>
    <td>: <label id="lbldiscount" name="lbldiscount"><s:property value="lbldiscount"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><b>Tax Amount</b></td>
    <td>: <label id="lbltaxtot" name="lbltaxtot"><s:property value="lbltaxtot"/></td>
  </tr>
  <tr>
    <td align="right" colspan="2"><b>Net Total</b> : <label id="lbltotinword" name="lbltotinword"><s:property value="lbltotinword"/>&nbsp;&nbsp;</td>
    <td>: <label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></td>
  </tr>

</table>
</fieldset>
<br>
<table width="100%" style="margin-top:60%">
 
 <tr>
     <td width="1039" colspan="3" >
<!--      <fieldset> -->
     <table width="960" >
     <tr>
     <td width="279" align="center"><b>Operations Officer</b></td>
     <td width="289" align="center"><b>Accounts Officer</b></td>
     <td width="220" align="center"><b>Internal Auditor</b></td>
     <td width="233" align="center"><b>Managing Partner</b></td>
     </tr>
     </table><br/><br/><br/>
<!--      </fieldset> -->
     </td>
</tr>
</table>

<jsp:include page="../../../common/KprintFooter.jsp"></jsp:include>
<!-- <div class="divFooter"  >
<table width="100%" >
  <tr>
   <td width="40%">&nbsp;</td> <td width="80%" style="color: #D8D8D8;" align="left"><b>  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Powered by GATEWAY ERP
 &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
  </tr>
</table>
</div>  -->


</div>
</form>
</div>
</body>
</html>
