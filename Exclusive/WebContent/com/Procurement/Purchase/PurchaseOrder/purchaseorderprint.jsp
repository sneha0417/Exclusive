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
  border-radius: 3px;
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
<%-- <table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table> --%>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  <div id="watermark">
  <p id="watermark-text">DRAFT</p>
	</div>
	<jsp:include page="../../../common/printHeader.jsp"></jsp:include><br/>
	<hr>
<table width="90%" align="center"> 
<tr>
<td width="8%" align="left"></td>
    <td width="60%" align="left">&nbsp; </td>
  <td align="left" colspan="2">&nbsp;</td>
  </tr>
  
  <tr>
  <td width="8%" align="left">Vendor</td>
    <td width="60%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td>
    <td   align="left">Location</td>
    <td   align="left">: <label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td> 
      
    </tr>
    
    
      <tr>
  		<td width="8%" align="left">TRNO</td>
	    <td width="60%" align="left">: <label id="lblclienttrno" name="lblclienttrno"><s:property value="lblclienttrno"/></label></td>
	    <td   align="left">LPO No.</td>
	    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td> 
      
    </tr>
    
    <tr>
    <td width="8%" align="left">Addrss</td>
    <td width="60%" align="left">: <label id="lbladdress" name="lbladdress"><s:property value="lbladdress"/></label> 
   
    </td>
    <td width="7%" align="left">Date</td> 
    <td width="25%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
    <tr>
    <td width="8%" align="left">Phone / fax</td>
    <td width="60%" align="left">: <label id="lblphone" name="lblphone"><s:property value="lblphone"/>/</label> 
   &nbsp; <label id="lblfax" name="lblfax"><s:property value="lblfax"/></label>
    </td> 
      <td width="7%" align="left">Type</td>
    <td width="25%" align="left">: <label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td> 
      
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


<br> 

<div id="firstdiv">
        
<table style="border-collapse: collapse;"  width="90%"  border="1" align="center">

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
     <td align="right" style="border-collapse: collapse;" width="5%"><b>Qty</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Unit price</b></td>
    <td align="right" style="border-collapse: collapse;" width="7%"><b>Total</b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount%</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Discount</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Net Amount</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Tax</b></td>
     <td align="right" style="border-collapse: collapse;" width="8%"><b>Total Amount</b></td>
     
     
 
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
  
 </div>


 <br>
 
          
    <div id="secdiv">  
          
<table style="border-collapse: collapse;" width="90%" border="1" align="center" >

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
 
 </div>   
 
 <br>
 
<table width="100%">
   <tr>
   		<td width="50%" rowspan="3" align="left" >
   		<fieldset><legend style="font-size: small;">Shipping Details</legend>
        <table  width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >  
<tr>
<td width="26%" align="right" style="font-size: x-small">Name :</td>
<td colspan="3"><label id="lblshipto" style="font-size: x-small"><s:property value="lblshipto"/></label></td>
</tr>
<tr>
<td align="right" style="font-size: x-small">Shipping Address :</td>
<td colspan="3"><label id="lblshipaddress" style="font-size: x-small"><s:property value="lblshipaddress"/></label></td>
</tr>
<tr>
<td align="right" style="font-size: x-small">Contact Person :</td>
<td colspan="3"><label id="lblcontactperson" style="font-size: x-small"><s:property value="lblcontactperson"/></label></td></tr>
<tr>
<td align="right" style="font-size: x-small">Telephone :</td>
<td width="74%"><label id="lblshiptelephone" style="font-size: x-small"><s:property value="lblshiptelephone"/></label> </td>
</tr>
<tr><td align="right" style="font-size: x-small">Email :</td>
<td>  <label id="lblshipemail" style="font-size: x-small"><s:property value="lblshipemail"/></label> </td>
</tr>
<tr>
<td width="26%" align="right" style="font-size: x-small">Mob :</td>
<td width="74%"> <label id="lblshipmob" style="font-size: x-small"><s:property value="lblshipmob"/></label> </td>
</tr>
<tr>
<td align="right" style="font-size: x-small">Fax :</td>
<td>  <label id="lblshipfax" style="font-size: x-small"><s:property value="lblshipfax"/></label></td>
</tr>
</table>
</fieldset>
</td>
   
<td><br/>
<fieldset>
<table width="100%" border="0" cellspacing="1">
  <tr>
    <td width="29%"><b>Total Amount :</b></td>
    <td width="71%" align="right"><label id="lblTotalAmounnt"><s:property value="lblTotalAmounnt"/></label></td>
  </tr>
  <tr>
    <td><b>Discount :</b></td>
    <td align="right"><label id="lbldiscountvalue"><s:property value="lbldiscountvalue"/></label></td>
  </tr>
  <tr>
    <td><b>Net Tax :</b></td>
    <td align="right"><label id="lblnettax">
        <s:property value="lblnettax"/>
      </label></td>
  </tr>
  <tr>
    <td><b>Order Value :</b></td>
    <td align="right" valign="bottom"><label id="lblordervalue"><s:property value="lblordervalue"/></label></td>
  </tr>
  <tr>
    <td height="31" colspan="2" align="right" valign="top"><label id="lblordervaluewords" style="font-size:x-small;"><s:property value="lblordervaluewords"/></label>
      </td>
  </tr>
</table>
</fieldset></td>

</tr>
</table>
 
<%-- 
 <br>
           
<table style="border-collapse: collapse;" width="90%" align="center"  >

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
  

 
</table>  --%>
 
 <table id="preparedby" width="90%" class="tablereceipt" align="center">
  <tr>
    <td height="25" colspan="2" class="tablereceipt">
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
    <td colspan="2" class="tablereceipt">
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
    
    <td colspan="2" class="tablereceipt">
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
</table> 

<table width="90%" align="center" >
<tr><td>&nbsp;</td></tr>
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
 