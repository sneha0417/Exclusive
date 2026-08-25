<%@page pageEncoding="utf-8" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
<style media="all">
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 /* fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 } */
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}

.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

.verticalLine {
    border-left: 1px solid black;
}


#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       
      
</style> 
<script>

function getPrint(){
	 document.getElementById("mode").value="print";
	document.getElementById("frmprintQuotation").submit(); 
}
function hidedata(){

	var header=document.getElementById("txtheader").value;
	
	if(parseInt(header)==1){
	
		 $("#headerdiv").show();
		 $("#withoutHeaderDiv").hide();
	}
	else{
		 $("#headerdiv").hide();
		 $("#withoutHeaderDiv").show();
	}
	
}
</script>
</head>
<body style="background-color:#fff !important;" bgcolor="white"  style="font-size:12px" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">


<form id="frmprintQuotation" action="printQuotation" autocomplete="off" target="_blank" >

 <div id="headerdiv" style="background-color:white;" >
  <%-- <jsp:include page="../../../common/printHeader.jsp"></jsp:include> --%> 
  <form>
 <div style="background-color:white;"> 
<table width="100%" class="normaltable">
  <tr>
    <td width="18%" rowspan="7"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label>
    					<br>النخيل لتركيب معدات الأمن والسلامة
    				</font></td>
  </tr>
  <tr>
  <tr>
  	
  	<td></td>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b><br></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
  	<td></td>
    <td></td>
    <td align="left"><b>TRN :&nbsp;<label id="lblbranchtrno" name="lblbranchtrno" ><s:property value="lblbranchtrno"/></label></b></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table></div>

</form>  
 </div>
 <div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="txtclient" name="txtclient"><s:property value="txtclient"/></label></td>
    <td width="18%" align="left">Doc No </td>
    <td width="20%"> : <label name="docno" id="docno" ><s:property value="docno"/></label></td>
  </tr>
  <tr>
    <td align="left">TR NO </td>
    <td width="18%">: <label id="lblcltrnno" name="lblcltrnno" ><s:property value="lblcltrnno"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%">&nbsp;</td>
    <td align="left">&nbsp; </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="left">Ref No </td>
    <td width="18%">: <label id="refno" name="refno" ><s:property value="refno"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Job Ref No </td>
    <td>: <label name="txtjobrefno" id="txtjobrefno" ><s:property value="txtjobrefno"/></label></td>
  </tr>
  <tr>
    <td align="left">Telephone No </td>
    <td width="18%">: <label id="cltelno" name="cltelno" ><s:property value="cltelno"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="date" id="date" ><s:property value="date"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3">: <label name="txtclientdet" id="txtclientdet" ><s:property value="txtclientdet"/></label></td>
    <%-- <td align="left">Contact Person</td>
    <td>: <label name="txtcontact" id="txtcontact" ><s:property value="txtcontact"/></label></td> --%>
    
    <td align="left">E-Mail</td>
    <td>: <label name="txtemail" id="txtemail" ><s:property value="txtemail"/></label></td>
    <td align="left">&nbsp;</td>

  </tr>
  <%-- <tr>

    <td align="left">E-Mail</td>
    <td>: <label name="txtemail" id="txtemail" ><s:property value="txtemail"/></label></td>
    <td align="left">&nbsp;</td>
    
  </tr> --%>
  
  <tr>
  <s:if test="%{getSitelist().size()>0}">
  <table width="100%"  class="tablereceipt">
  
 <tr class="tablereceipt" height="25"> 
    <td align="left" style="width:20%;"><strong>Site Details</strong></td>
</tr>
  <s:set var="temp" value="1"></s:set>
  
 <s:iterator var="stat1" status="arr" value='#request.SITELIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
   <tr>
     <s:iterator status="arr" value="#stat.split('::')" var="des">
<tr class="tablereceipt" height="20">   		
 <td  align="left" class="tablereceipt">
  <s:property value="#des"/>
</td>
</tr>  
 </s:iterator>
 </tr>
</s:iterator>
</s:iterator>
  
</table>
</s:if>
  </tr>
  
  
</table>
</fieldset>
<br>
<hr>

<table width="100%"  class="tablereceipt">

 <tr height="25" style="background-color: #D8D8D8;" class="tablereceipt">
    <td align="center" class="tablereceipt" style="width:10%;"><strong>SI No</strong></td>
    <td align="left" class="tablereceipt" style="width:60%;"><strong>&nbsp;Description</strong></td>
    <td align="right" class="tablereceipt" style="width:15%;"><strong>Amount&nbsp;</strong></td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  <%int i=0; %>
 <s:iterator var="stat1" status="arr" value='#request.seremirateslist' >
 <%i=i+1;%>
 <% if(i>5){%> 
<%} else{ %>
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr height="20" class="tablereceipt"> 
  
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<td align="center" class="tablereceipt">
   		  <% if(i==3 || i==4 || i==5){%>
          <strong><s:property value="#des"/></strong>
          <%} else if(i<3){ %>
          <s:property value="#des"/>
          <% } %> 
   		</s:if>
   		<s:elseif test="#arr.index==2">
   		<td align="left" class="tablereceipt">
   		  <% if(i==3 || i==4 || i==5){%>
          <strong><s:property value="#des"/></strong>
          <%}  else if(i<3){ %>
          <s:property value="#des"/>
          <% } %> 
   		</s:elseif>
   		<s:elseif test="#arr.index==3">
   		<td  align="right" class="tablereceipt">
   		 <% if(i==3 || i==4 || i==5){%>
          <strong><s:property value="#des"/></strong>
          <%}  else if(i<3){ %>
          <s:property value="#des"/>
          <% } %> 
   		</s:elseif>
   		
  
 </s:iterator> 
</tr>
</s:iterator>
 <% } %>
</s:iterator>
 
</table>
<br>
<hr>
 <table width="100%" >
<tr>

<td width="48%">
<fieldset><legend>Contract payment Terms</legend>
<table width="100%" class="tablereceipt" >
<tr height="25" style="background-color: #D8D8D8;" class="tablereceipt">
    <td align="center" class="tablereceipt" style="width:50%;"><strong>Due Date</strong></td>
    <td align="right" class="tablereceipt" style="width:50%;"><strong>&nbsp;Amount</strong></td>
 </tr>

 <%int j=0; %>
<s:iterator var="stat1" status="arr" value='#request.paygrid' >
<%j=j+1;%>
<% if(j>=3){%> 
<%} else{ %>
	<s:iterator status="arr" value="#stat1" var="stat">    

<tr height="20" class="tablereceipt"> 
 
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		 <s:if test="#des!=''"> 
   			<s:if test="#arr.index==0"> 
   		<td align="center" width="20%" class="tablereceipt">
   		  
          <s:property value="#des"/>
          
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		
   		<td align="right" width="40%" class="tablereceipt">
   		
          <div style="padding-left:20px;"><s:property value="#des"/></div>
        
   		</s:elseif>
   		<%-- <s:elseif test="#arr.index==3">
   		
   		<td  align="right" width="40%" class="tablereceipt" >
   		  <s:property value="#des"/>
         
   		</s:elseif>
   		 --%>
	</s:if> 
  
 </s:iterator>
 
</tr>

</s:iterator>
 <% } %> 
</s:iterator>

</table>
</fieldset>
</td>
<td  width="48%">
<fieldset><legend>Contract Invoicing  Details</legend>
<table width="100%" class="tablereceipt" >
<%int k=0; %>
<s:iterator var="stat1" status="arr" value='#request.PAYLIST' >
<%k=k+1;%>
	<s:iterator status="arr" value="#stat1" var="stat">    
		    
  <tr>
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   
   		<s:if test="#des!=''">
   			<s:if test="#arr.index==0">
   			<% if(k==1){%> 
   		 <tr><td align="center" colspan="7" class="tablereceipt">
          <s:property value="#des"/></td> </tr>
           <% } else{ %> 
           <td align="center" width="60%" class="tablereceipt">
          <s:property value="#des"/></td>
           <% } %>
   		</s:if>
   		
   		<s:elseif test="#arr.index==1">
   		<td  align="right" width="40%" class="tablereceipt" >
   		  <s:property value="#des"/>
         
   		</s:elseif>
   		
   		</s:if>
   		

 </s:iterator>
 </tr>
</s:iterator>

</s:iterator>

</table>
</fieldset>
</td>

</table>
 


<br>
<hr>

<%-- <table width="100%" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
  <tr>
    <td width="197" align="left">Discount :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txtdisamt" name="txtdisamt"><s:property value="txtdisamt"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="txtnettotal" name="txtnettotal"><s:property value="txtnettotal"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="amountwords" name="amountwords"><s:property value="amountwords"/></label></b></td>
    </tr>
</table> --%>
<table width="100%" >
  <tr>
    <td width="8%" align="left"><strong>Note:</strong></td>
    <td width="92%"><strong>1) If paid by cheque, should be drawn in favour of <label id="lblcompname" name="lblcompname"><s:property value="lblcompname"/></label></strong></td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  	<td><strong>2) if paid in cash please insist for our official receipt.</strong><br><strong>&nbsp;&nbsp;&nbsp;*we are not responsible for any payment without our official receipt.</strong></td>
  </tr>
  </table>
  <br>
<hr>
  <div id="termsdiv" hidden="true">
<fieldset>
<table width="100%">
 <tr>
    <td align="left" style="width:20%;"><strong>Terms & Conditions</strong></td>
    
    <td align="center" style="width:70%;"><strong>Conditions</strong></td>  
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.TERMLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr>   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<th width="10%" align="left" >
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		<td>
   		</s:elseif>
   		<s:else>
  <td  align="left"> 		
   		</s:else>
  
  
  <s:property value="#des"/>

  </td>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>
</fieldset>

<hr>
</div>



<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Recieved By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>
</form>

 <s:set name="counter" value="%{#counter+1}" />

</div>
</body>
</html>
