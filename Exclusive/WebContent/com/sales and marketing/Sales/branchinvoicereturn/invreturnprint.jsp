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

function hidedata()
{

	var first=document.getElementById("firstarray").value;
	var sec=document.getElementById("secarray").value;

	if(parseInt(first)==1) 
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		$("#firstdiv").prop("hidden", true);
		}
	
	/* if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} */ 
	
	
	}
 
 

</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata()">
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
  
<table width="100%"  > 
  <tr>
  <td width="10%" align="right">Customer</td>
    <td width="30%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td> 
        <td width="8%" align="right">Type</td>
    <td width="15%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
     <td width="8%" align="right">Date</td> 
    <td width="12%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    </tr>
   <tr>
     <td   align="right">Sales Person</td>
     <td  align="left"  >: <label name="lblsalesPerson" id="lblsalesPerson" ><s:property value="lblsalesPerson"/></label></td>
     
      <td   align="right">Ref No</td>
    <td   align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
  
     
       
    <td   align="right">Doc No</td>
    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
       
     </tr>
       <tr>
    <td   align="right">Payment Due on</td>
    <td   align="left">: <label id="lblduedate" name="lblduedate"><s:property value="lblduedate"/></label></td>
    
    <td align="right" >Del Terms</td>
    <td colspan="5" align="left">: <label name="lbldelterms" id="lbldelterms" ><s:property value="lbldelterms"/></label></td>
     </tr>
     <tr>
     
    <td align="right">Payment Terms</td>
    <td colspan="7" align="left">: <label name="lblpaytems" id="lblpaytems" ><s:property value="lblpaytems"/></label></td>
     </tr>
     <tr>
    <td align="right">Description</td>
    <td colspan="7" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    
  </tr>
  </table>

</fieldset>
<br> 

<div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
     <td align="center" style="border-collapse: collapse;" width="6%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;" width="10%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount%</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount</b></td>
     <td align="right" style="border-collapse: collapse;" width="11%"><b>Net Amount</b></td>
 
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
<%--  <tr >
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
     <td align="right" ><label id="lbltotal"><s:property value="lbltotal"/></label></td>

 
  </tr> --%>
</table>
 </fieldset> 
 </div>


 <br>
 
          
    <div id="secdiv">  
 
 
 </div>   
 
 <br>
 
 <table width="100%">
 <tr>
<td align="right" width="100%" ><b>Order Value :</b>     <label id="lblordervaluewords"><s:property value="lblordervaluewords"/></label> &nbsp;&nbsp;&nbsp;&nbsp;
       <label id="lblordervalue"><s:property value="lblordervalue"/></label>&nbsp;&nbsp;  </td>
 
 </tr>
 
 
  </table>
 
 
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include> 
 
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
