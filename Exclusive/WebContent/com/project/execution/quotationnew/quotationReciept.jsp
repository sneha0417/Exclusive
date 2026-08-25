
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
<style media="print">
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
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
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
	
	if(document.getElementById("taxamnt").value==0)
		{
		document.getElementById("taxid").style.display = "none";   
		}
	if(document.getElementById("dicountamnt").value==0)
	{
	document.getElementById("discountid").style.display = "none";   
	}
	if(document.getElementById("taxtype").value==0)
	{
	document.getElementById("taxigst").style.display = "none";   
	}
	if(document.getElementById("taxtype").value==1)
	{
	document.getElementById("taxcgst").style.display = "none";
	document.getElementById("taxsgst").style.display = "none"; 
	}
	 	
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
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
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
    <td width="18%" align="left">Qot No </td>
    <td width="20%"> : <label name="docno" id="docno" ><s:property value="docno"/></label></td>
  </tr>
  <tr>
    <td align="left">Contract Type </td>
    <td width="18%">: <label id="contrtype" name="contrtype" ><s:property value="contrtype"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="date" id="date" ><s:property value="date"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3">: <label name="txtclientdet" id="txtclientdet" ><s:property value="txtclientdet"/></label></td>
    <td align="left">Mobile No </td>
    <td>: <label name="txtmob" id="txtmob" ><s:property value="txtmob"/></label></td>
  </tr>
  <tr>

    <td align="left">E-Mail</td>
    <td>: <label name="txtemail" id="txtemail" ><s:property value="txtemail"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">Contact Person</td>
    <td>: <label name="txtcontact" id="txtcontact" ><s:property value="txtcontact"/></label></td>
  </tr>
   
</table>
</fieldset>
<br>
<hr>
<table>
<tr>

    <td align="left"><strong>Subject</strong></td>
    <td>: <label name="txtsubject" id="txtsubject" ><s:property value="txtsubject"/></label></td>
    
  </tr>
  <tr>

    <td align="left"><strong>Description</strong></td>
    <td>: <label name="txtdesc1" id="txtdesc1" ><s:property value="txtdesc1"/></label></td>
    
  </tr>
  </table>
<hr>
<fieldset>

<table width="100%" style="border-collapse:collapse;">

 <tr Style="background-color:#d8d8d8">
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
    <%-- <td align="center" style="width:15%;"><strong> Site</strong></td> --%>
    <td align="center" style="width:25%;"><strong>Service Type</strong></td>
    <td align="center" style="width:25%;"><strong>Description</strong></td>
     <td align="center" style="width:5%;"><strong>Unit</strong></td>
    <td align="right" style="width:5%;"><strong>Qty</strong></td> 
    <td align="right" style="width:10%;"><strong>Amount</strong></td> 
    <td align="right" style="width:10%;"><strong>NetTotal</strong></td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.QOTLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr>   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<th  align="left" colspan="7" Style="background-color:#ffebeb;text-transform:uppercase;letter-spacing:1px;">
   		<s:property value="#des"/></th>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		
   		<td align="left"><s:property value="#des"/></td>
   		</s:elseif>
   		 <s:elseif test="#arr.index==2">
   		 <td  align="left"><s:property value="#des"/></td>
   		</s:elseif>
   		<s:elseif test="#arr.index==3">
   		<td  align="center"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <s:elseif test="#arr.index==4"> 
   		<td  align="center"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <s:elseif test="#arr.index==5"> 
   		<td  align=center><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==6"> 
   		<td  align="right"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==7"> 
   		<td  align="right"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:else>
  <%-- <td  align="right"><s:property value="#des"/></t --%>		
   		</s:else>
  
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>

</fieldset>

<br>
<hr>

<table width="100%" >
  <tr>
    <td width="137" align="left"><b>Total</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
  <%-- <tr id="taxid">
    <td width="137" align="left"><b>Tax @ <s:property value="txttaxper"/>%</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txttaxamt" name="txttaxamt"><s:property value="txttaxamt"/></label></b></td>
  </tr> --%>
  
  <tr id="taxigst">
    <td width="137" align="left"><b>Tax(IGST)  @ <s:property value="txttaxperigst"/>%</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txttaxamtigst" name="txttaxamtigst"><s:property value="txttaxamtigst"/></label></b></td>
  </tr>
  <tr id="taxcgst">
    <td width="137" align="left"><b>Tax(CGST) @ <s:property value="txttaxpercgst"/>%</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txttaxamtcgst" name="txttaxamtcgst"><s:property value="txttaxamtcgst"/></label></b></td>
  </tr>
  <tr id="taxsgst">
    <td width="137" align="left"><b>Tax(SGST) @ <s:property value="txttaxpersgst"/>%</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txttaxamtsgst" name="txttaxamtsgst"><s:property value="txttaxamtsgst"/></label></b></td>
  </tr>
  
  <tr id="discountid">
    <td width="137" align="left"><b>Discount @ <s:property value="txtdisper"/>%</b></td>
    <td width="352" align="left">&nbsp;:</td>
    <td width="163">&nbsp;</td>
    <td width="546" align="right"><b><label id="txtdisamt" name="txtdisamt"><s:property value="txtdisamt"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount</b></td>
    <td>&nbsp;:</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="txtnettotal" name="txtnettotal"><s:property value="txtnettotal"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words</b></td>
     <td>&nbsp;:</td>
    <td colspan="2" align="right"><b><label id="amountwords" name="amountwords"><s:property value="amountwords"/></label></b></td>
    </tr>
</table>
 <s:if test="%{getTermlist().size()>0}">
<fieldset>
<table width="100%">
 <tr>
    <td align="left" style="width:20%;"><strong>Terms & Conditions</strong></td>
    <%-- <td align="center" style="width:25%;"><strong>Terms</strong></td>
    <td align="center" style="width:70%;"><strong>Conditions</strong></td>  --%>
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
</s:if>
<hr>
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
<input type="hidden" id="taxtype" name="taxtype" value='<s:property value="taxtype"/>'>
<input type="hidden" id="taxamnt" name="taxamnt" value='<s:property value="txttaxamt"/>'>
<input type="hidden" id="dicountamnt" name="dicountamnt" value='<s:property value="txtdisamt"/>'>
</div>
</form>

 <s:set name="counter" value="%{#counter+1}" />

</div>
</body>
</html>
