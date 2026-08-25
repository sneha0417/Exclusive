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
  border: 5px solid rgb(139,136,120);

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
	
	if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} 
	
	
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
  
<table width="100%" > 
  <tr>
  <td width="8%" align="left">Vendor</td>
    <td width="21%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td>
     <td width="9%"  align="left">Date</td> 
    <td width="21%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    
     <td width="25%"  align="right">Type</td>
     <td width="18%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
     </tr>
     <tr>
    <td width="8%" align="left">Tel No/Fax</td> 
    <td width="19%" align="left">: <label id="lbltelno" name="lbltelno"><s:property value="lbltelno"/></label></td> 
    
     <td width="9%"   align="left">RFQ NO</td>
    <td width="21%"   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
  
       <%-- <td width="25%"  align="right">Project Name</td>
      <td  width="18%" align="left">: <label id="lblproname" name="lblproname"><s:property value="lblproname"/></label></td> --%>
      
       
    </tr>
     <tr>
     
      <td width="8%"  align="left">Ref No</td>
      <td colspan="3"  align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
      <%-- <td width="25%"  align="right">Location</td>
      <td width="18%"  align="right">: <label id="lblloc" name="lblloc"><s:property value="lblloc"/></label></td> --%>
     </tr>
     <tr>
      <td width="8%"  align="left">ATTN</td>
      <td  width="19%" align="left">: <label id="lblattn" name="lblattn"><s:property value="lblattn"/></label></td>
      </tr>
      <tr>
    <td width="8%" align="left">Description</td>
    <td width="19%" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    </tr>
    <tr>
     <td width="8%" align="left">Email Id</td>
    <td  width="19%" align="left">: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
    </tr>
  
  
    
    
    
   
    
       
  
       
    
    
     
  </table>
</fieldset>
<br> 
<h4>Subject:We Invite you to submit your best offer for the following items BY RETURN EMAIL along with delivery date </h4>
<div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse; border:1px solid black;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;border:1px solid black;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;border:1px solid black;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;border:1px solid black;"><b>Product Name</b></td>
    <td align="left" style="border-collapse: collapse;border:1px solid black;"><b>Unit</b></td>
     <td align="center" style="border-collapse: collapse;border:1px solid black;" width="6%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;border:1px solid black;" width="10%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;border:1px solid black;" width="8%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;border:1px solid black;" width="8%"><b>Discount%</b></td>
     <td align="right" style="border-collapse: collapse;border:1px solid black;" width="8%"><b>Discount</b></td>
     <td align="right" style="border-collapse: collapse;border:1px solid black;" width="11%"><b>Net Amount</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>4){%>
    
  <td  align="right" style=" border:1px solid black;">
  <s:property value="#des"/>
  </td>
  <%} else if(i==4){ %>
    
  <td  align="center" style=" border:1px solid black;" >
  <s:property value="#des"/>
  </td>
   
  
   <%} else{ %>
    
  <td  align="left" style=" border:1px solid black;" >
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
     <td align="right" ><label id="lbltotal"><s:property value="lbltotal"/></label></td>

 
  </tr>
</table>
 </fieldset> 
 </div>


 <br>
 
          
    <div id="secdiv">  
  <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;" width="43%" ><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;" width="8%"><b>Quantity</b></td>
    <td align="right" style="border-collapse: collapse;" width="10%"><b>Unit Price</b></td>
     <td align="right" style="border-collapse: collapse;" width="10%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;"  width="12%"><b>Discount</b></td>
      <td align="right" style="border-collapse: collapse;" width="12%" ><b>Net Amount</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.subdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>2){%>
    
  <td  align="right" >
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
  </tr>
 <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td> 
     
 <td ><b></b></td>
    <td align="right" ><b>Total</b></td>
     <td align="right" ><label id="lblsubtotal"><s:property value="lblsubtotal"/></label></td>

 
  </tr>
</table>
 </fieldset> 
 
 </div>   
 
 <br>
 
 <table width="100%">
 <tr>
 <td align="right" width="100%"  colspan="2"><b>Order Value :</b>     <label id="lblordervaluewords"><s:property value="lblordervaluewords"/></label> &nbsp;&nbsp;&nbsp;&nbsp;
       <label id="lblordervalue"><s:property value="lblordervalue"/></label>&nbsp;&nbsp;  </td>
       </tr>
       
 <h4>For any queries don't hesitate to contact Mr.Jaison Jose(mobile:055 8607396)</h4>
 <!-- <h4>Scope of Work</h4> -->
<tr>
<!-- <th width="5%" align="left">Terms and conditions</th> -->
 </tr>
 <s:iterator var="purquoteprint" value='#request.quoteprint' >
<tr>
<%int i=1;%>
 <s:iterator status="arr" value="#purquoteprint.split('::')" var="pqprint"> 
<%if(i==1){%>
 <td  style="text-align: left;" width="5%">
  <s:property value="#pqprint"/><!-- <p>hdshjfbhdbf</p> -->
  </td>
 <%}else{%>
 	<td  style="text-align: left;" width="95%">
  <s:property value="#pqprint"/><!-- <p>hdshjfbhdbf</p> -->
  </td>
  <%} i++;%>
 
 </s:iterator>
 </tr>
</s:iterator>

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
