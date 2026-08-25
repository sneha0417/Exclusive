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
.special div {
    border: 0px solid #f00;
    margin: -2px;
}

.first {border-bottom:1px solid #FFF;}

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
	
	
	var trd=document.getElementById("thirdarray").value;

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
	
	
	if(parseInt(trd)==3) 
	{
	   $("#trddiv").prop("hidden", false);
	}
else
	{
	$("#trddiv").prop("hidden", true);
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

  <td><jsp:include page="../../../common/printMainHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
 
 
  
<%-- <table width="100%"  > 
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
  </table> --%>
  
 <table width="100%"  >
  <tr>
  <td width="50%">
     <fieldset>
  <legend><b>BILL TO</b></legend>
  <table width="100%">
  <tr>  <td width="20%" align="right"> ID :</td> <td width="80%"><label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/> </label> </td> </tr>
  <tr>  <td width="20%"  align="right"> Name :</td> <td width="80%"><label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label> </td>  </tr>
   <tr>  <td width="20%"  align="right"> TRN NO :</td> <td width="80%"><label id="lbltrnno" name="lbltrnno"><s:property value="lbltrnno"/></label> </td>  </tr>
  <tr>  <td width="20%" height="35"  align="right"> Address :</td>  <td width="80%"><label id="lblclientaddress" name="lblclientaddress"><s:property value="lblclientaddress"/></label> </td> </tr>
  <tr>  <td width="20%"  align="right"> City,ST ZIP :</td> <td width="80%"><label id="lblclientcity" name="lblclientcity"><s:property value="lblclientcity"/></label>  </td>  </tr>
  <tr>  <td width="20%"  align="right"> Country :</td> <td width="80%"><label id="lblclientcountry" name="lblclientcountry"><s:property value="lblclientcountry"/></label>  </td> </tr>
  <tr>  <td width="20%"  align="right"> Phone :</td> <td width="80%"><label id="lblclientmob" name="lblclientmob"><s:property value="lblclientmob"/></label>  </td>  </tr>
<tr><td>&nbsp;<td></tr>
  </table> 
    </fieldset>
    </td>
    <td width="50%">  &nbsp;
<%--          <fieldset>
  <legend><b>SHIP TO</b></legend>
  <table width="100%">
  <tr>  <td width="28%"  align="right">Name :</td> <td width="72%"><label id="lblshipto" name="lblshipto"><s:property value="lblshipto"/></label>  </td> </tr>
  <tr>  <td width="28%"  height="35" align="right">Shipping Address :</td> <td width="72%"><label id="lblshipaddress" name="lblshipaddress"><s:property value="lblshipaddress"/></label>  </td>  </tr>
  <tr>  <td width="28%"  align="right">Contact Person :</td>  <td width="72%"><label id="lblcontactperson" name="lblcontactperson"><s:property value="lblcontactperson"/></label>  </td>    </tr>
  <tr>  <td width="28%"  align="right">Telephone :</td> <td width="72%"><label id="lblshiptelephone" name="lblshiptelephone"><s:property value="lblshiptelephone"/></label>  </td>  </tr>
  <tr>  <td width="28%"  align="right">MOB :</td> <td width="72%"><label id="lblshipmob" name="lblshipmob"><s:property value="lblshipmob"/></label></td> </tr>
  <tr>  <td width="28%"  align="right">Email :</td> <td width="72%"><label id="lblshipemail" name="lblshipemail"><s:property value="lblshipemail"/></label></td>  </tr>
   <tr>  <td width="28%"  align="right">FAX :</td> <td width="72%"><label id="lblshipfax" name="lblshipfax"><s:property value="lblshipfax"/></label></td>  </tr>
<tr>  <td width="20%"  align="right">&nbsp;</td> <td width="80%">&nbsp; </td>  </tr>
  </table>
    </fieldset> --%>
    
    </td>
    
    
    
  </table>



<br> 

<div id="firstdiv">
       
<table style="border-collapse: collapse;" width="99.5%"  border="1" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
 
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
 
     <td align="left" style="border-collapse: collapse;" width="6%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;" width="10%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Total</b></td>

     <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount</b></td>
     
          <td align="right" style="border-collapse: collapse;" width="8%"><b>Net Total</b></td>
                <td align="right" style="border-collapse: collapse;" width="8%"><b>Tax %</b></td>
         <td align="right" style="border-collapse: collapse;" width="8%"><b>Tax Amount</b></td>
     <td align="right" style="border-collapse: collapse;" width="11%"><b>Total Amount</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>2){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
  <%} else if(i<2){ %>
    
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
 
 </div>


 <br>
 
          
    <div id="secdiv">  
       
<table style="border-collapse: collapse;" width="99.5%" border="1"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
 
    <td align="left" style="border-collapse: collapse;" width="43%" ><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;" width="8%"><b>Quantity</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Tax %</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Tax Amount</b></td>
    <td align="right" style="border-collapse: collapse;" width="12%" ><b>Net Amount</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.subdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
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
  
 
  </table>
  </div>  
            <div id="trddiv">  
<table style="border-collapse: collapse;"width="99.5%"  border="1" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="60%"><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;" width="20%" ><b>RefNo</b></td>
    <td align="left" style="border-collapse: collapse;" width="20%"><b>Date</b></td>
 
 
  </tr>

<s:iterator var="stat" value='#request.shipdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>2){%>
    
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
 
</div>
  
 <table width="100%"   >
  <tr>
    <td width="69%" align="left"><u>NOTES </u> :-</td>
    <td width="16%" height="20" align="right">Sub Total&nbsp;</td>
    <td width="15%" rowspan="5">
    <table width="100%" style="border-collapse: collapse;" width="100%" border="1" >
      <tr >
        <td height="25" align="right"><label id="lbltotal"><s:property value="lbltotal"/></label>  </td>
      </tr>
       <tr>
        <td height="25"  align="right"> <label id="lblround"><s:property value="lblround"/></label></td>
      </tr>
      
      <tr>
        <td height="25"  align="right"> <label id="lblsubtotal"><s:property value="lblsubtotal"/></label></td>
      </tr>
       
           <tr>
        <td height="25"  align="right"> <label id="lblvattotal"><s:property value="lblvattotal"/></label></td>
      </tr>
      <tr>
        <td height="25"  align="right">  <label id="lblordervalue"><s:property value="lblordervalue"/></label></td>
      </tr>
    </table></td>
  </tr>
     <tr>
  <td >&nbsp;</td>
    <td align="right">Round of&nbsp;</td>
   
  </tr>
  <tr>
   <td >&nbsp;</td>
    <td align="right">Fixing And Other Charges&nbsp;</td>
   
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td  align="right"> VAT &nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td   align="right"><b>TOTAL</b>&nbsp;</td>
  </tr>
</table>
 
 <table width="100%" >
 <tr>
  <td align="right"  width="10%">Del Terms</td>
    <td width="80%" align="left">: <label name="lbldelterms" id="lbldelterms" ><s:property value="lbldelterms"/></label></td>
     </tr>
     <tr>
     
    <td align="right"  width="10%">Payment Terms</td>
    <td  width="80%" align="left">: <label name="lblpaytems" id="lblpaytems" ><s:property value="lblpaytems"/></label></td>
     </tr>
     <tr>
    <td align="right"  width="10%">Description</td>
    <td width="80%" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    
  </tr>
  </table>
 
 
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include> 
 
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>


<input type="hidden" name="thirdarray" id="thirdarray"  value='<s:property value="thirdarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
 