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
#watermark{
    position:absolute;
    z-index:0;
    background:none;
    display:block;
    min-height:60%; 
    min-width:50%;
    align: center;
    padding-left: 100px;
    opacity:0.1;
}


#watermark-text
{
    color:lightgrey;
    font-size:180px;
    transform:rotate(300deg);
    -webkit-transform:rotate(300deg);
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

	function hidedraft()
	{
	
		var second=document.getElementById("watermarks").value;
		
		if(parseInt(second)==3) 
			{
			   $("#watermark").hide();
			}
		else
			{
			$("#watermark").show();
			}
		
		} 
 
 

</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata();hidedraft();">
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
  <div id="watermark">
  <p id="watermark-text">DRAFT</p>
	</div>
	
<table width="100%"> 
  <tr>
  <td width="6%" align="left">Vendor</td>
    <td width="40%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td>
    <td   align="left">Doc No</td>
    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td> 
      
    </tr>
    <tr>
    <td width="6%" align="left">Addrss</td>
    <td width="60%" align="left">: <label id="lbladdress" name="lbladdress"><s:property value="lbladdress"/></label> 
   
    </td>
    <td width="5%" align="left">Date</td> 
    <td width="25%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    <tr>
    <td width="6%" align="left">Phone / fax</td>
    <td width="30%" align="left">: <label id="lblphone" name="lblphone"><s:property value="lblphone"/>/</label> 
   &nbsp; <label id="lblfax" name="lblfax"><s:property value="lblfax"/></label>
    </td> 
      <td width="5%" align="left">Type</td>
    <td width="15%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
      
    </tr>
   <tr>
     <td   align="leftt">Delivery</td>
   
     <td  align="left"  >: <label name="expdeldate" id="expdeldate" ><s:property value="expdeldate"/></label></td>
     
      <td   align="left">Ref No</td>
    <td   align="left">: <label id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></td>
  
     
       
    
    </tr>
    <tr>
       
     </tr>
     
     <tr>
    
    
    <td align="leftt">Del Terms</td>
    <td colspan="7" align="left">: <label name="lbldelterms" id="lbldelterms" ><s:property value="lbldelterms"/></label></td>
     </tr>
     
     
     <tr>
    
    
    <td align="leftt">Pay Terms</td>
    <td colspan="7" align="left">: <label name="lblpaytems" id="lblpaytems" ><s:property value="lblpaytems"/></label></td>
     </tr>
     <tr>
    <td align="left">Description</td>
    <td colspan="7" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
    
  </tr>
  </table>

</fieldset>
<br> 

<div id="firstdiv">
 <fieldset>        
<table style="border-collapse: collapse;"  width="100%"  border="1" >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
     <td align="right" style="border-collapse: collapse;" width="6%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;" width="10%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount%</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount</b></td>
     <td align="right" style="border-collapse: collapse;" width="11%"><b>Net Amount</b></td>
     <td align="right" style="border-collapse: collapse;" width="11%"><b>Tax</b></td>
     <td align="right" style="border-collapse: collapse;" width="11%"><b>total Amount</b></td>
     
     
 
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
     <td  >&nbsp;</td>
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
<table style="border-collapse: collapse;" width="100%" border="1" >

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
<td align="right" width="100%" ><b>Discount :</b>      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <label id="lbldiscountvalue"><s:property value="lbldiscountvalue"/></label>&nbsp;&nbsp;  </td>
 
 </tr>
 
 <tr>
<td align="right" width="100%" ><b>Order Value :</b>     <label id="lblordervaluewords"><s:property value="lblordervaluewords"/></label> &nbsp;&nbsp;&nbsp;&nbsp;
       <label id="lblordervalue"><s:property value="lblordervalue"/></label>&nbsp;&nbsp;  </td>
 
 </tr>
 
  </table>
 
  <fieldset> 
<table  width="100%" >  
<tr><td align="right" width="14%">Name :</td><td colspan="3"><label id="lblshipto"><s:property value="lblshipto"/></label></td></tr>
<tr><td align="right">Shipping Address :</td><td colspan="3"><label id="lblshipaddress"><s:property value="lblshipaddress"/></label></td></tr>
<tr><td align="right">Contact Person :</td><td colspan="3"><label id="lblcontactperson"><s:property value="lblcontactperson"/></label></td></tr>
<tr><td align="right">Telephone :</td><td width="35%"><label id="lblshiptelephone"><s:property value="lblshiptelephone"/></label> </td>
<td width="6%" align="right">MOB :</td><td width="53%"> <label id="lblshipmob"><s:property value="lblshipmob"/></label> </td></tr>
<tr><td align="right">Email :</td><td>  <label id="lblshipemail"><s:property value="lblshipemail"/></label> </td>
<td align="right">FAX :</td><td>  <label id="lblshipfax"><s:property value="lblshipfax"/></label></td>
</tr>
</table>
 </fieldset>
 
 <br>
   <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

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
 </fieldset> 
 
 <table id="preparedby" width="100%" class="tablereceipt">
  <tr>
    <td width="32%" height="25" class="tablereceipt">&nbsp;</td>
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Prepared By</b></td>
    <td width="55%">:&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    </tr>
    </table>
    </td>
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Verified By</b></td>
    <td width="55%">:&nbsp;<label name="lblverifiedby" id="lblverifiedby" ><s:property value="lblverifiedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblverifiedon" id="lblverifiedon" ><s:property value="lblverifiedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblverifiedat" id="lblverifiedat" ><s:property value="lblverifiedat"/></label></td>
    </tr>
    </table>
    </td>
    
    <td colspan="2" rowspan="2" class="tablereceipt">
    <table width="100%">
    <tr>
    <td width="45%" height="25" align="left"><b>Approved By</b></td>
    <td width="55%">:&nbsp;<label name="lblapprovedby" id="lblapprovedby" ><s:property value="lblapprovedby"/></label></td>
    </tr>
    <tr>
    <td><b>Date</b></td>
    <td>:&nbsp;<label name="lblapprovedon" id="lblapprovedon" ><s:property value="lblapprovedon"/></label></td>
    </tr>
    <tr>
    <td><b>Time</b></td>
    <td>:&nbsp;<label name="lblapprovedat" id="lblapprovedat" ><s:property value="lblapprovedat"/></label></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td align="left" class="tablereceipt">
      <table width="100%">
       <tr><td align="left"><font style="font-size: 8px;"><b>This is a system generated document and signature is not required.</b></font></td></tr>
       <tr><td  align="left"><font style="font-size: 8px;"><b>This document is processed through ERP system by the authorised persons mention on the right side.</b></font></td></tr>
      </table>
    </td>
  </tr>
</table> 
<input type="hidden" name="watermarks" id="watermarks" value='<s:property value="watermarks"/>'>
<input type="hidden" name="secndtarray" id="secndtarray" value='<s:property value="secndtarray"/>'>
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
 