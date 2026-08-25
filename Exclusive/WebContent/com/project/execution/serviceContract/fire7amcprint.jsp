<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
 <%@ page pageEncoding="utf-8" %>
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
  .firstcol {
    border-right: 1px solid #000;
  }
  .lastcol {
    border-left: 1px solid #000;
  }
   .table {
    border: 1px solid black;
}
  
  th {
    border: 1px solid black;
}
.tablereceipt {

    border: 1px solid #ffebcd;
    border-collapse: collapse;
}

#ita {
     font-style: "italic";
    color:#6495ed;
}

 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
 hr { 
   border-top: 1px solid #e1e2df  ;
   
 
   
    } 
table.ex1 {
   width: auto;
}


p{
	font-size: 10px;
	font-family: Times new roman;
	align: justify;
}
  H2 {page-break-before: always}
</style>

<script type="text/javascript">
/* window.onload= function fun1()
{

window.open("quotprint.pdf", "_self");
 
} */
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
		} 
	
	
	
 */
 
 }
</script>
</head>
<body bgcolor="white" style="font: 12px Tahoma " onload="hidedata();">
<!-- <div id="mainBG" class="homeContent" data-type="background"> -->
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

   <%--  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td> --%>
    
  </tr>
</table>
<%-- <fieldset>

<table width="100%" > 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td width="61%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="8%" align="left">Doc No</td>
    <td  width="16%">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
        <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
    
     <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
   </table>
</fieldset> --%>
<br>

  <div id="firstdiv" hidden="true" >
<!-- <fieldset> -->
<%-- <table style="border-collapse: collapse;" width="100%" class="table"> 
<!-- temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("cdw")+"::"+rsdetail.getString("pai")+"::"+rsdetail.getString("gps")+"::"+rsdetail.getString("babyseater")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("total"); -->
 <tr height="25" style="background-color: #ffebcd;border-collapse: collapse;" >
   <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Sl No</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Brand</b> </th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Model</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>YOM</b></th>
     <!-- <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Color</b></th> -->
     <th align="left"  class="firstcol"style="border-collapse: collapse;"><b>Rent Type</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Tariff</b></th>
      <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Unit</b></th>
      <th align="left" class="firstcol"style="border-collapse: collapse;"><b>CDW</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>PAI</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>GPS</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>BABYSEATER</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Group</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>TOTAL</b></th>
 
  </tr>
 
<s:iterator var="stat" value='#request.details' >
<tr >   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" class="lastcol">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" class="firstcol" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
<% for(int i=0;i<3;i++) 
{
	%>

<tr  >
    <td align="left"  class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left"class="firstcol">&nbsp;</td>
	<td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td> 
  </tr>
  <%} %>


</table> --%>
<br>
<%-- <table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr>
<td width="1%">&nbsp;</td><td colspan="2" width="99%"><u><b><label name="terms1" id="terms1"><s:property value="terms1"/></label></b></u> </td> 

</tr>
<tr>
<td width="1%"></td><td width="99%"><label name="generalterms" id="generalterms" ><s:property value="generalterms"/></label> </td>

</tr>
</table> --%>
<br>
<%-- <table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr>
<td width="1%">&nbsp;</td><td width="99%"><u><b><label name="terms2" id="terms2" ><s:property value="terms2"/></label></b></u> </td>
</tr>
<tr>
<s:iterator var="stat" value='#request.desc' >
<tr >   

<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    
    if(i==0){%>
    
  <td  align="left"  >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" width="99%"  >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>

</tr>
</table>
 --%>

<!-- </fieldset> -->
</div>

<br><br><br><br><br><br><br><br>

<table width="100%">
<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:30px;">ANNUAL MAINTENANCE CONTRACT</td></tr>

<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>

<tr><td align="center" style="font-size:15px;">This agreement is made on <label name="contractdate" id="contractdate" ><s:property value="contractdate"/></label> between,</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;"><b>FIRE 7 L.L.C.</</b></td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">P.O. Box: 20260, Dubai, U.A.E.</td></tr>


<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">(Being the First party and herein after called FIRE7)</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">AND</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;"><label name="companyname" id="companyname" ><s:property value="companyname"/></label></td></tr>

<tr ><td align="center" style="height:10px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;"><label name="partyname" id="partyname" ><s:property value="partyname"/></label></td></tr>
<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">(Being the second party and herein after called CLIENT)</td></tr>


<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">SUBJECT:  Annual Maintenance of Fire Protection Systems</td></tr>

<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">SITE:<label name="sitename" id="sitename" ><s:property value="firstsite"/></label></td></tr>


<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>
<tr><td align="center" style="font-size:15px;">FIRE 7 Maintenance Contract Ref no: F7Q<label name="contractrefno" id="contractrefno" ><s:property value="contractrefno"/></label>/<label name="contractdocno" id="contractdocno" ><s:property value="contractdocno"/></label> </td></tr>
</table>

<div style="page-break-after:always;"></div>
<br><br><br><br><br><br><br><br>


<table >
<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>1. The following systems will be maintained:</u></b></td></tr>


<tr>
<td>	


 	<s:if test="%{getSerlist().size()>0}">
 <!-- <table width="100%" style="border-collapse:collapse;" class="tablereceipt"> -->
 <table  width="100%">

 <%-- <tr Style="background-color:#d8d8d8" >
    <td align="left" style="width:5%;"><strong>SI No</strong></td>
    <td align="left" style="width:95%;"><strong> Services</strong></td>
   
  </tr>
  --%>
 <s:iterator var="stat1" status="arr" value='#request.SERLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
	   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0">
   		<%-- <td align="left" >
   		<s:property value="#des"/>
   		</td> --%>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<td align="left" >&nbsp;*&nbsp;
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>


</s:if>
</td>
</tr>



<tr><td><b>FIRE 7</b> agrees to carry out periodic maintenance of the fire detection/ protection systems as per attached schedule. The equipment is owned by the client and already installed in the premises. The maintenance contract is subject to the following terms and conditions:-</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>2. PERIODIC VISITS:</u></b></td></tr>

<tr><td><b>FIRE 7</b> Engineers will visit the above site and check the below mentioned devices and equipment’s:</td></tr>





<tr>
<td>	


 	<s:if test="%{getSerlist().size()>0}">
 <!-- <table width="100%" style="border-collapse:collapse;" class="tablereceipt"> -->
 <table  width="100%">

 <%-- <tr Style="background-color:#d8d8d8" >
    <td align="left" style="width:5%;"><strong>SI No</strong></td>
    <td align="left" style="width:95%;"><strong> Services</strong></td>
   
  </tr>
  --%>
 <s:iterator var="stat1" status="arr" value='#request.SERLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
	   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0">
   		<%-- <td align="left" >
   		<s:property value="#des"/>
   		</td> --%>
   		</s:if>
   		<s:elseif test="#arr.index==7">
   		<td align="left" >&nbsp;*&nbsp;
   		<s:property value="#des"/>&nbsp;
   		</td>
   		</s:elseif>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>


</s:if>
</td>
</tr>


<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>3. COMMENCEMENT OF CONTRACT</u></b></td></tr>

<tr><td>This contract shall commence on the date of signing by both parties and signed copies are exchanged against acknowledgment and will continue for a period of one year unless terminated or renewed under clause 10.</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>4. SPECIAL VISITS (CALL OUT)</u></b></td></tr>

<tr><td>When notified by the Client of a defect in the equipment/system, FIRE 7 will arrange for the visit of technical team to investigate and remedy such defect.</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>5. RESPONSE TIME:</u></b></td></tr>

<tr><td>The call outs will be attended within a maximum period of 4 hours in working days from Saturday to Thursday. On Fridays and holidays the callouts will be attended at the earliest. All emergency calls will be attended 24 hours at telephone number <b>050-7001184</b></td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>6. NOTIFICATION TO CLIENT:</u></b></td></tr>

<tr><td><b>FIRE 7</b> shall notify the Client the date and time of their visit to the site to enable the Client representative to be present in the site during the visit.  </td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
</table>
 <div style="page-break-after:always;"></div> 
<br><br><br><br><br><br><br><br><br><br>

<table>
<tr><td><b><u>7. MAINTENANCE CHARGES</u></b></td></tr>

<tr><td>Total charges for the One year maintenance services for Fire Protection Systems without spare will be <b>AED &nbsp;<label name="maintnchrg" id="maintnchrg" ><s:property value="maintnchrg"/></label>&nbsp;( AED <label name="maintnchrginword" id="maintnchrginword" ><s:property value="maintnchrginword"/></label>)</b></td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>8. TERMS OF PAYMENT</u> </b></td></tr>

<tr><td>

  <s:if test="%{getPaylist().size()>0}">	
  
 <table width="100%" >
<%-- 
 <tr Style="background-color:#d8d8d8" class="tablereceipt">
    <td align="center" style="width:5%;"><strong>Sr.no</strong></td>
    <td align="center" style="width:15%;"><strong>Due Date</strong></td>
    <td align="right" style="width:30%;"><strong>Amount</strong></td>
    <td align="center" style="width:50%;"><strong>Description</strong></td>
   
  </tr> --%>
 
 <s:iterator var="stat1" status="arr" value='#request.PAYLIST' >
	<s:iterator status="arr" value="#stat1" var="stat"> 
	
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0">
   		<%-- <td align="center" >
   		<s:property value="#des"/>
   		</td> --%>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<%-- <td align="center" >
   		<s:property value="#des"/>
   		</td> --%>
   		</s:elseif>
   		<s:elseif test="#arr.index==2">
   		<%-- <td align="right" >
   		<s:property value="#des"/> --%>
   		</td>
   		</s:elseif>
   		<s:elseif test="#arr.index==3">
   		<td align="left" >&nbsp;*&nbsp;
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
</table>

</s:if>
</td></tr>



<tr><td>*	If any part of the work is cancelled or withdrawn or if any scope of work could not be achieved by the contractor due to reasons attributable to the client, 50% of the value of the work so cancelled or withdrawn will be charged to the client towards administration and service charges.</td></tr>
<!--</table>
 <div style="page-break-after:always;"></div> 
<br><br><br><br><br><br><br><br>

<table>-->


<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>9. MATERIALS & SPARES</u></b>-</td></tr>

<tr><td>If any examination reveals the need for new supply or replacement of any parts to the systems except those needed to perform the maintenance, the parts involved will be subject to a separate quotation at a current standard prices and would only be supplied upon receipt of an instruction and payment from the Client.</td></tr>
<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>10. TERMS</u></b></td></tr>

<tr><td>This agreement shall remain in force for a period of 12 months from the date of commencement and shall be renewed every year for a period of one year on mutually accepted terms unless terminated by either party by giving 30 days prior notice to the expiry of the original period or extension thereto.
Either party shall have the right to terminate this agreement for breach of the terms, if breach is not remedied within 15 days of receipt of the notice by the breaching party. Nonpayment of service charge or approved rectification charges will be deemed to be a breach. <br>
Termination of this agreement, however, caused shall be without prejudice to the rights and liabilities available under this agreement to both parties as on the date of termination.
</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>11. LIMITATION OF LIABILITY </u></b></td></tr>

<tr><td>Both parties agree that the total liability in the aggregate of Fire 7 , its employees, agents, and subcontractors   to the Client and anyone claiming under the Client for any claims, losses, costs, or damages whatsoever arising out of, resulting from or in any way related to this Project/job  or Agreement from any cause or causes, including but not limited to negligence, professional errors and omissions, strict liability, breach of contract, or breach of warranty, shall not exceed the total compensation received by Fire 7 under this contract.</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
<tr><td><b><u>12. EXCLUSION OF LIABILITY</u></b></td></tr>

<tr><td><b>FIRE 7</b> shall have no liability whatsoever to the client or to any third party for injury, damage or loss to persons or property including but not limited to claims in respect of accidental operation resulting directly from the operation or failure of the equipment during any survey/ service unless the accident occurred, due to a fault caused by the negligence and/or default of the Fire7 workers.</td></tr>

<tr ><td align="center" style="height:30px;">&nbsp;</td></tr>
</table>
 <div style="page-break-after:always;"></div> 
<br><br><br><br><br><br><br><br><br><br>

<table>
<tr><td><b><u>13. AGREEMENT</u></b></td></tr>

<tr><td>Any fire incidents resulting from non-approval of mandatory rectification which leaves the site unprotected will not be the liability or responsibility of Fire 7.
<br>
The contract price is not inclusive of Value Added Tax chargeable in respect of the services undertaken by the Contractor and the same shall be charged from the date of its enforcement, in addition to the service charges agreed to be paid by the client under this contract.

</td></tr>
<tr><td><label name="agreement" id="agreement" ><s:property value="agreement"/></label></td></tr>
<tr><td>This agreement shall be subject to, with respect to the enforcement in interpretation thereof; the laws of the United Arab Emirates and in case of disputes shall be settled before Dubai Courts.</td></tr>


<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>
<tr>

<table width="100%">
<tr>
<td align="center" style="font-size:15px;" width="50%">Accepted on Behalf of:</td> 
<td align="center" style="font-size:15px;" width="50%">Accepted on Behalf of:	</td></tr>

<tr>
<td align="center" style="font-size:15px;" width="50%">FIRE7 LLC</td> 
<td align="center" style="font-size:15px;" width="50%"><label name="companyname" id="companyname" ><s:property value="companyname"/></label> </td></tr>

<tr>
<td align="center" style="font-size:15px;" width="50%">DUBAI, U.A.E.</td> 
<td align="center" style="font-size:15px;" width="50%"><label name="partyname" id="partyname" ><s:property value="partyname"/></label> </td></tr>


<tr ><td align="center" style="height:50px;">&nbsp;</td></tr>

<tr>
<td align="center" style="font-size:15px;" width="50%">--------------------</td> 
<td align="center" style="font-size:15px;" width="50%">--------------------</td></tr>

<tr>
<td align="center" style="font-size:15px;" width="50%">Signature & Stamp</td> 
<td align="center" style="font-size:15px;" width="50%">Signature & Stamp</td></tr>
</table>
</tr>

</table>


<%-- <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'> --%>  

</div>
</form>
<!-- </div> -->
</body>
</html>