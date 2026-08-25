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
 <table>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 </table>

 <table  width="100%"  >
 <tr>
 <td colspan="1" width="50%">
 <table >
 
 </table>
 </td>
 <td >
 <table width="80%" border="1"  cellpadding="3" cellspacing="0">
 
 <tr><td><h1><i>Purchase Order</i></h1>
 </td></tr>
 </table></td>
 </tr>
 </table>
 <table width="90%"  align="center">
 <tr>
 <td>
<table width="100%"  cellpadding="3" cellspacing="0" >
 <%--  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr> --%>
  <tr><td>&nbsp;</td></tr>
  <tr><td>
  <table  colspan="4"   width="80%" >
 <tr>
 
 <td width="90%" align="left">The following number must appear on all related correspondence, shipping papers, and invoices:
 
 </td>
 
 </tr>
 <tr>
 <td>&nbsp;</td>
 
 </tr>
 <tr>
 <td width="52%" align="left"><b>P.O NUMBER </b>:
 <label id="lblpono" name="lblpono"><s:property value="lblpono"/></label>
 </td></tr>
	
 </table>
 </td></tr>
</table>

<table width="100%" >
<tr>
 <td width="12%" align="left"><b>Contact: Mr. </b>&nbsp;&nbsp;
 <td width="25%" align="left">: <label id="lblcontact" name="lblcontact"><s:property value="LblvendoeaccName"/></label>
</td>
 <td width="8%" align="left"><b>Ship To </b>
 <td width="60%" align="left">: <b>A One Technology Fire Safty & Security System LLC</b></td>
</tr>
 <tr>

 <td width="10%" align="left"><b>Address </b>
 <td width="35%" align="left">: <label id="lbladdrs" name="lbladdrs"><s:property value="lbladdrs"/></label>
</td>
</tr>

<tr>
 <td width="12%" align="left"><b>city </b>
  <td width="30%" align="left">:  Abu Dhabi
</td>
 <td width="8%" align="left"><b>Address </b>
 <td width="30%" align="left">:  P.O.Box:25963
</tr>

<tr>
 <td width="12%" align="left"><b>Country </b>
  <td width="30%" align="left">: UAE
</td>
 <td width="10%" align="left"><b>city </b>
 <td width="30%" align="left">: Abu Dhabi
</tr>

<tr>
 <td width="8%" align="left"><b>Phone - Fax </b>
 <td width="25%" align="left">:<label id="lblphoneno" name="lblphoneno"><s:property value="lblphoneno"/></label>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 <label id="lblfaxx" name="lblfaxx"><s:property value="lblfaxx"/></label>
</td>

 <td width="10%" align="left"><b>Country </b>
 <td width="30%" align="left">: Abu Dhabi
</tr>

<tr>

 <td width="12%" align="left"><b>Email </b>
 <td width="33%" align="left">:<label id="lblemaill" name="lblemaill"><s:property value="lblemaill"/></label>
</td>

</td>

 <td width="15%" align="left"><b>Phone&nbsp; - Fax&nbsp;</b>
 <td width="30%" align="left">:&nbsp;025525447 &nbsp;- &nbsp;025575090
</tr>

<tr>
<td width="7%"></td>
 <td width="12%" align="left"></td>
 <td width="15%" align="left"><b>Email </b> 
  <td width="15%" align="left">: aonetech@eim.a 
</tr>
</table>


<br> 


       
<table  border="1" width="100%" cellpadding="3" cellspacing="0" >
<tr><th>P.O DATE</th><th> REQUISITIONER</th><th>F.O.B. POINT</th><th>TERMS</th></tr>
<tr><td width="25%" align="center"><label id="lblpodate" name="lblpodate"><s:property value="lblpodate"/></label>
</td>
<td align="center" width="25%">A One Technology LLC</td>
<td align="center" width="25%">Abu Dhabi</td>
<td align="center" width="25%">25% Advance,75% Against material delivery</td>
</tr>

</table>



 <br>
 
          
    <div id="thirddiv">
 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="center" style="border-collapse: collapse;" width="15%"><b>QTY</b></td>
    <td align="center" style="border-collapse: collapse;" width="15%"><b>UNIT</b></td>
    <td align="center" style="border-collapse: collapse;" width="40%"><b>DESCRIPTION</b></td>
    <td align="center" style="border-collapse: collapse;" width="15%"><b>UNIT PRICE</b></td>
    <td align="center" style="border-collapse: collapse;" width="15%"><b>TOTAL</b></td>
  </tr>
   

<s:iterator var="stat" value='#request.prntdetails' >
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
    
  <td  align="center" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>

 <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td> 
    <td ><b></b></td>
    <td ><b></b></td>
     <td ><b></b></td>
    

 
  </tr>
</table>
 </fieldset> 
 
  
  <table>
   <tr>  
 
    <td align="left" width="100%" ><b>Order Value :</b>     <label id="lblordervaluewords"><s:property value="lblordervaluewords"/></label> &nbsp;&nbsp;&nbsp;&nbsp;
         </td>
    <td align="right" ><b></b></td>
    <td align="right" ><b></b></td>
     <td align="right" >Total:<label id="lblsubtotal"><s:property value="lblsubtotal"/></label></td>

 
  </tr>
</table>
 
 
 </div>
 
 <br>
   
 
 <table  width="100%">
 
 <tr width="100%">
 <td width="2%">&nbsp;&nbsp;<b><u>Terms & Conditions</u></b></td>
 <td width="98%">
 
 </td>
 </tr>
 <tr width="100%">
 <td width="50%">
 <table border="1" width="100%" height="100" cellpadding="3" cellspacing="0" >
 <tr><td style="vertical-align: top;text-align: left;">Delivery Period:<label id="lblperiod"><s:property value="lblperiod"/></label>
 </tr>
 
 </table>
 </td>
 <td>
 <table>
 <tr ><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td width="45%" height="25" align="left"><b>Prepared By</b></td>
    <td width="55%">:&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    </tr>
   
    <tr>
    <td>&nbsp;</td>
    <td width="45%" height="25" align="left"><b>Approved By</b></td>
    <td width="55%">:&nbsp;<label name="lblapprovedby" id="lblapprovedby" ><s:property value="lblapprovedby"/></label></td>
    </tr>
 </table>
 </td>
 
 </table>
 </tr>
 
    
      <table width="100%" >
       <tr>
       <td width="5%"></td>
       <td align="left" width="95%"><font style="font-size: 8px;"><b>Note: Please sign & stamp in the purchase order and send it back to us for our record.</b></font></td></tr>
       
      </table>
   
 

</table>
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
 