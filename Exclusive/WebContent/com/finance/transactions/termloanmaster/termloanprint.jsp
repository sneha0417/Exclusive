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
 
<%--  
 <style> --%>

<STYLE TYPE="text/css">
     H2 {page-break-before: always}
</STYLE>

<!-- @media print {
    footer {page-break-after: always;}
} -->
<%-- </style> --%>
 
<script>



function hidedata()
{
	 
	var first=document.getElementById("firstarray").value;


	if(parseInt(first)==1)
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		$("#firstdiv").prop("hidden", true);
		}
	
	
	
	
	}

</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata();">
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
 
<table width="100%" > 
  <tr>
    <td width="10%" align="left">Date </td>
    <td width="15%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
 
<td width="15%" align="right">Loan Entry Date	</td>
    <td width="10%" align="left">: <label id="lblpurchaseDate" name="lblpurchaseDate"><s:property value="lblpurchaseDate"/></label></td> 
    <td width="20%" align="right">Doc No</td>
    <td   width="20%"  align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    
    
    <tr>
 
    <td align="left">Description</td>
    <td colspan="5" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
  </tr>

 
   </table>

</fieldset>
<br>  





 
 
 
 <div id="firstdiv">
 
   <fieldset>
 <legend>Finance Details</legend>
 
 <table width="100%"  >
  <tr>
   <%--  <td width="16%" align="left">Down Payment</td>
    <td width="34%" align="left">: <label id="lbldownpayment" name="lbldownpayment"><s:property value="lbldownpayment"/></label></td>   --%>
  <td width="16%" align="left">Loan Amount</td>
    <td width="34%" align="left">: <label id="lblloanamt" name="lblloanamt"><s:property value="lblloanamt"/></label> 
     <td width="16%" align="left">&nbsp;</td>
    <td width="34%" align="left">&nbsp; 
    </td> 
    
    </tr>
    <tr>
   <td width="16%" align="left">Start Date</td>
    <td   align="left" width="34%">: <label id="lblstartdate" name="lblstartdate"><s:property value="lblstartdate"/></label></td> 
     <td width="16%" align="left">% Of Interest</td>
    <td align="left" width="34%">: <label id="lblperinterst" name="lblperinterst"><s:property value="lblperinterst"/></label></td>
    <tr>
 
    
    
    <td width="16%" align="left">Number Of Inst</td>
    <td   align="left" width="34%">: <label id="lblnoofinst" name="lblnoofinst"><s:property value="lblnoofinst"/></label></td>  
    <td width="16%" align="left">Total Interest</td>
    <td align="left" width="34%">: <label id="lbltotalint" name="lbltotalint"><s:property value="lbltotalint"/></label></td>
    
    
    </tr>
    <tr>
     <td width="16%" align="left">Calculation Method</td>
    <td   align="left" width="34%">: <label id="lblcalcumethod" name="lblcalcumethod"><s:property value="lblcalcumethod"/></label></td>
    </tr>
  <tr>

 
    <td width="16%" align="left">Recipient A/C</td>
    <td width="34%" align="left">: <label id="lblfinacc" name="lblfinacc"><s:property value="lblfinacc"/></label> 
    &nbsp; <label id="lblfinaccName" name="lblfinaccName"><s:property value="lblfinaccName"/></label>
    </td> 
    
        <td width="11%" align="left">Bank A/C</td>
    <td width="34%" align="left">: <label id="lblbankacc" name="lblbankacc"><s:property value="lblbankacc"/></label> 
    &nbsp; <label id="lblbankaccName" name="lblbankaccName"><s:property value="lblbankaccName"/></label>
    </td> 
    
 </tr>
 
   <tr>    
 
 
    <td width="16%" align="left">Interest A/C</td>
    <td width="34%" align="left">: <label id="lblintacc" name="lblintacc"><s:property value="lblintacc"/></label> 
    &nbsp; <label id="lblintaccName" name="lblintaccName"><s:property value="lblintaccName"/></label>
    </td> 
    
        <td width="16%" align="left">Loan A/C</td>
    <td width="34%" align="left">: <label id="lblloanacc" name="lblloanacc"><s:property value="lblloanacc"/></label> 
    &nbsp; <label id="lblloanaccName" name="lblloanaccName"><s:property value="lblloanaccName"/></label>
    </td> 
    
 </tr>
 
 


 


  <tr>
    <td width="16%" align="left">Security Cheque NO</td>
    <td width="14%" align="left">: <label id="lblsecucqNo" name="lblsecucqNo"><s:property value="lblsecucqNo"/></label></td> 
 
     <td width="16%" align="left">Amount</td>
    <td width="34%" align="left">: <label id="lblanamt" name="lblanamt"><s:property value="lblanamt"/></label> 
    </td> 
    </tr>
    <tr>
    <td width="16%" align="left">Return Date</td>
    <td   align="left" width="34%">: <label id="lbluptodate" name="lbluptodate"><s:property value="lbluptodate"/></label></td>
    <td width="16%" align="left">Payment Method</td>
    <td   align="left" width="34%" >: <label id="lblpayval" name="lblpayval"><s:property value="lblpayval"/></label></td>
    </tr>
    <tr>
    <td width="16%" align="left">Name In Cheque</td>
    <td align="left" colspan="7">: <label id="lblnameinchq" name="lblnameinchq"><s:property value="lblnameinchq"/></label></td>

    </tr>
    <tr>
    <td width="16%" align="left">Description</td>
    <td align="left" colspan="7">: <label id="lblDesc" name="lblDesc"><s:property value="lblDesc"/></label></td>
    </tr>
 
 
 </table>
 </fieldset>
 
 
 <br>
 <br>
    <H2></H2>
  <table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>



<fieldset>
 
  
<table width="100%"  > 
  <tr>
    <td width="10%" align="left">Date </td>
    <td width="15%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
 
<td width="15%" align="right">Loan Entry Date	</td>
    <td width="10%" align="left">: <label id="lblpurchaseDate" name="lblpurchaseDate"><s:property value="lblpurchaseDate"/></label></td> 
    <td width="20%" align="right">Doc No</td>
    <td   width="20%"  align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    
    
    <tr>
 
    <td align="left">Description</td>
    <td colspan="5" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
  </tr>

 
   </table>

</fieldset>


 
 <table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sr No</b></td>
    <td align="left" style="border-collapse: collapse;" ><b>Date</b></td>
    <td align="left" style="border-collapse: collapse;"  ><b>Cheque No</b></td>
    <td align="right" style="border-collapse: collapse;"  ><b>Principal Amount</b></td>
    <td align="right" style="border-collapse: collapse;"  ><b>Interest</b></td>
    <td align="right" style="border-collapse: collapse;"  ><b>Amount</b></td>
    <td align="center" style="border-collapse: collapse;" ><b>Bpv No</b></td>
 
 
  </tr>

<s:iterator var="stat" value='#request.detailsarr' >
<tr>   
<%int i=0; %>
    <s:iterator status="arrdet" value="#stat.split('::')" var="des">   
    
    
    <%
  
    
    if(i==6){%>
    
  <td  align="center" >
  <s:property value="#des"/>
  </td>
   <%} 
    else if(i>2){
    
    	 
    %>
  
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
      <td >&nbsp;</td>
     <td >&nbsp;</td>
      <td align="right"> <label id="lblpricitotalamount" name="lblpricitotalamount"><s:property value="lblpricitotalamount"/></label></td>
       <td align="right"><label id="lblinttotalamount" name="lblinttotalamount"><s:property value="lblinttotalamount"/></label> </td>
     <td align="right"><label id="lbltotalgridamount" name="lbltotalgridamount"><s:property value="lbltotalgridamount"/></label> </td>
    <td >&nbsp;</td>
 
 
  </tr>

  
</table>
 
 
 
 </div>
 <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  

  <div class="divFooter">
  


  </div>
   
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br>


</div>
</form>
</div>
</body>
</html>
