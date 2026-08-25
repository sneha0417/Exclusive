<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
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
#maintbl th{
 background-color: #ffece5;
} 
#hddiv{
background-color: #ffece5;
}

#tabeltotal{
	font-size: 12px;
}   

</style> 
  
<script>

$(document).ready(function () {
	
	/* document.getElementById("image").style.display = "none"; */
	/*  */
	
	
});

function load(){
	
	var logss=document.getElementById("logo").value;
	/* alert(logss); */
	if(logss==1){
		$('#image').show();
	}
	else{
		$('#image').hide();
		document.getElementById("cmpnme").style.display = "none";
		document.getElementById("lblcompaddress").style.display = "none";
		document.getElementById("tel").style.display = "none";
		document.getElementById("fax").style.display = "none";
	}
}

</script>
</head>

<body style="font-size:10px; font-family:arial;"  bgcolor="white" onload="load();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;" >
 
 
<table width="100%" class="normaltable"  >
	
  <tr >
    <td width="30%" rowspan="6">   <div id="image"><img  src="<%=contextPath%>/icons/epic.jpg" width="100%" height="91"  alt=""/></div> </td>
    <td width="38%" rowspan="2">&nbsp;</td>
    <td width="32%" ><font style="font-size: 15.5px;" id="cmpnme"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font>&nbsp;</td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center" style="vertical-align: bottom;"><b><font size="5"><label id="lblprintname" name="lblprintname">  </label></font></b></td>
    <td align="left"><font id="tel"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></font>&nbsp;</td>
  </tr>
  <tr>
    <td align="left"><font id="fax"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></font>&nbsp;</td>
  </tr>
   <tr>
    <td rowspan="2" align="center"><b><font size="5"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/>TAX INVOICE</label></font></b></td>
    <td align="left" style="font-size: 14px;"><b>TRN NO :&nbsp;<label id="lbltrnno" name="lbltrnno" ><s:property value="lbltrnno"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><%-- <b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label> --%></td>
  </tr> 
  
    <tr>
    
       <td  >&nbsp;</td>
          <td  >&nbsp;</td>
    
    <td align="left" >&nbsp;</td>
  </tr>
  
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td> 
  </tr>
   <tr>
    <td colspan="3"></td></tr>
    
    <%-- <b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label> 
    
    --%>
    </table>
    
    
 

 
 
<div style="width:60%; float:left; height:130px; padding-top:10px; " >
<fieldset>
  <table width="100%"   cellpadding="2" >
    <tr>
      <td width="15%" align="left" style="font-size: 14px;"><strong>Buyer</strong></td>
      <td colspan="3" style="font-size: 14px;">: <label id="lblBuye" name="lblBuye"><s:property value="lblBuye"/></td>
    </tr> 
      <tr>
      <td width="15%" align="left"><strong>TRNNO</strong></td>
      <td colspan="3">: <label id="lblcltrno" name="lblcltrno"><s:property value="lblcltrno"/></td>
    </tr>
   <tr>
    <td  > &nbsp;</td>  <td  align="left" colspan="3"> : <label id="lbladdresscl" name="lbladdresscl"><s:property value="lbladdresscl"/></td>
    </tr> 
    <tr>
      <td align="left"><strong>Tel</strong></td>
      <td width="37%">: <label id="lblTel" name="lblTel"><s:property value="lblTel"/></td>
      <td width="11%" align="right"><strong>Fax</strong></td>
      <td width="30%">: <label id="lblFax" name="lblFax"><s:property value="lblFax"/></td>
    </tr>
    <tr>
      <td align="left"><strong>Remarks</strong></td>
      <td colspan="3">: <label id="lblRemarks" name="lblRemarks"><s:property value="lblRemarks"/></td>
    </tr>
    <%-- <tr>
      <td align="left"><strong>Project</strong></td>
      <td colspan="3">: <label id="lblProject" name="lblProject"><s:property value="lblProject"/></td>
    </tr> --%>
  
  </table>
  <br>
</fieldset>  
</div>
<div style="width:40%; float:left; height:130px; padding-top:10px;">
<fieldset>  
  <table width="100%" border="0" cellpadding="3">
    <tr>
      <td width="35%" align="left" style="font-size: 14px;"><strong>Invoice No</strong></td> 
      <td width="65%" style="font-size: 14px;">: <label id="lbldocNO" name="lbldocNO"><s:property value="lbldocNO"/></td>
    </tr>
    <tr>
      <td align="left"><strong>Date</strong></td>
      <td >: <label id="lblDate" name="lblDate"><s:property value="lblDate"/></td>
    </tr>
    <tr>
      <td align="left"><strong>PO.NO</strong></td>
      <td>: <label id="lblPoNo" name="lblPoNo"><s:property value="lblPoNo"/></td>
    </tr>
    <tr>
     <td width="30%" align="left"><strong>DN NO</strong></td> 
      <td width="70%">: <label id="lblOrderNO" name="lblOrderNO"><s:property value="lblOrderNO"/></td>
      <%-- <td align="left"><strong>Salseman</strong></td>
      <td>: <label id="lblSalseman" name="lblSalseman"><s:property value="lblSalseman"/></td> --%>
    </tr>
    <tr>
      <td align="left"><strong>Delivery Date</strong></td>
      <td>: <label id="lblDeliveryDate" name="lblDeliveryDate"><s:property value="lblDeliveryDate"/></td>
    </tr>
    
    <%-- <tr>
      <td align="left"><strong>Fixing Date</strong></td>
      <td>: <label id="lblFixingDate" name="lblFixingDate"><s:property value="lblFixingDate"/></td>
    </tr> --%>
  </table>
</fieldset>  
</div>
<div>
	<table id="maintbl" width="100%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="left">Sr No</th>
    <th  align="left">Description</th>
    <th width="5%" align="left">Temp</th>
    <th width="18%" align="left">Width(MM) x Height(MM)</th>
    <th width="6%" align="left">Qty</th>
    <th width="15%" align="right">Unit Price</th>
    <th width="15%" align="right">Amount</th>
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
 <table width="100%" id="tabeltotal">  
 <tr>
<td align="left" width="70%" style="font-size: 18px;"><b><label id="lblamountvaluewords"><s:property value="lblamountvaluewords"/></label> </b></td>
     <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Amount Total :&nbsp;&nbsp;</b> </td><td><b><label id="lbltotalamount"><s:property value="lbltotalamount"/></label></b> </td>
    </tr>
    
    <tr>   
    <td align="left" width="70%" ></td>
       <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Charge &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;</b> </td><td align="right"><b> <label id="lblcharge"><s:property value="lblcharge"/></label></b></td>
     </tr>
    
    <tr> 
    <td align="left" width="70%" ></td>  
       <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Discount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;</b> </td><td align="right"> <b> <label id="lbldiscount"><s:property value="lbldiscount"/></label></b></td>
     </tr>
    <tr>  
    <td align="left" width="70%" ></td> 
       <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Net Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;</b> </td><td align="right"><b>  <label id="lblnettotal"><s:property value="lblnettotal"/></label></b></td>
     </tr>
     <tr>  
     <td align="left" width="70%" ></td>
       <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Tax Amount&nbsp; &nbsp;&nbsp;:&nbsp;&nbsp;</b> </td><td align="right"><b>  <label id="lbltotaltax"><s:property value="lbltotaltax"/></label></b></td>
          </tr>
          <tr>
          <td align="left" width="70%" ></td>
               <td align="right" width="30%" >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Invoice Value :&nbsp;&nbsp;</b> </td><td align="right"><b> <label id="lblinvvalue"><s:property value="lblinvvalue"/></label></b></td>
          
 
 </tr>
  
   
   <input type="hidden" id="typeprints" name="typeprints"><s:property value="typeprints"/>
  
    
    <input type="hidden" id="logo" name="logo"  value='<s:property value="logo"/>'>
   
  </table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<table width="100%" border="1" style="border-collapse: collapse;" cellpadding="5">
  <tr>
    <td width="46%" height="90" style="vertical-align:top; font-size:12px"><b>Prepared By :<%=session.getAttribute("USERNAME")%></b></td>
    <td colspan="2" style="vertical-align:top; font-size:13px" align="center">We have received items mentioned as per our order in good condition . Report any descrepancies with in seven (7) days.</td>
  </tr>
  <tr style="border-top: hidden;">
    <td style="color: #D8D8D8;font-size: 10px;" align="center">System Generated Document Signature & Stamp Not Required.</td>
    <td width="27%" style="border-right: hidden;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Name</b> </td>
    <td width="27%" align="right"><b>Signature</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
<%-- <jsp:include page="../../common/printFooter.jsp"></jsp:include> --%>
</div>

</form>
</div>
</body>
</html>
