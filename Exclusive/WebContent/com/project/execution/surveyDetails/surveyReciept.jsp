
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
<style media="all">
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

.tablereceipt {
    border: 1px solid #7E7D7D;
    border-collapse: collapse;
}       
      
</style> 
<script>

function getPrint(){
	 document.getElementById("mode").value="print";
	document.getElementById("frmprintSurvey").submit(); 
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


<form id="frmprintSurvey" action="printSurvey" autocomplete="off" target="_blank" >

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
    <td width="18%" align="left">Doc No </td>
    <td width="20%"> : <label name="docno" id="docno" ><s:property value="docno"/></label></td>
  </tr>
  <tr>
    <td align="left">Address</td>
    <td width="18%">: <label id="txtclientdet" name="txtclientdet" ><s:property value="txtclientdet"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="date" id="date" ><s:property value="date"/></label></td>
  </tr>
  <tr>
    <td align="left">E-Mail</td>
    <td colspan="3">: <label name="txtemail" id="txtemail" ><s:property value="txtemail"/></label></td>
    <td align="left">Mobile No </td>
    <td>: <label name="txtmob" id="txtmob" ><s:property value="txtmob"/></label></td>
  </tr>
  <tr>

    <td align="left">Surveyed by</td>
    <td>: <label name="surveyedby" id="surveyedby" ><s:property value="surveyedby"/></label></td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td>Existing Contractor</td>
    <td align="left"><label name="txtcontractr" id="txtcontractr" ><s:property value="txtcontractr"/></td>
    <td></td>
  </tr>
   
</table>
</fieldset>
<br>
<hr>
<table width="100%">
<tr>
<td width="50%">
  <s:if test="%{getSitelist().size()>0}">
  <fieldset><legend>Site Details</legend>
  <table width="100%"  >
 <s:iterator var="stat1" status="arr" value='#request.SITELIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
   <tr>
     <s:iterator status="arr" value="#stat.split('::')" var="des">
<tr  height="20">   		
 <td width="10%" align="left">
  <s:property value="#des"/>
</td>
</tr>  
 </s:iterator>
 </tr>
</s:iterator>
</s:iterator>  
</table>
</fieldset>
</s:if>
</td>
<td width="50%">
  <s:if test="%{getSerlist().size()>0}">
  <fieldset><legend>Service Details</legend>
  <table width="100%"  >
 <s:iterator var="stat1" status="arr" value='#request.SERLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
   <tr>
     <s:iterator status="arr" value="#stat.split('::')" var="des">
<tr  height="20">   		
 <td   align="left">
  <s:property value="#des"/>
</td>
</tr>  
 </s:iterator>
 </tr>
</s:iterator>
</s:iterator>  
</table>
</fieldset>
</s:if>
</td>
</tr>
</table>
<table>
<tr>
 <td align="left"><strong>Remarks/Comments</strong></td>
    <td>: <label name="txtdesc" id="txtdesc" ><s:property value="txtdesc"/></label></td>
</tr>
</table>
<hr>
<fieldset><legend>Survey Details</legend>

<table width="100%"  >
 
 <s:iterator var="stat1" status="arr" value='#request.LIST' >
 
	<s:iterator status="arr" value="#stat1" var="stat">    
<%int i=0; %> 
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   
      <s:if test="#des!=''">
   		<s:if test="#arr.index==0">
   		<tr ><td  align="left"  >
   		 <b><s:property value="#des"/></b>
   		 </td>
   		 </tr>
   		</s:if>
   		
   
   	<%if(i==0){%>
   	<tr class="tablereceipt" Style="background-color:#d8d8d8" >
   	 <td colspan="2">
   	<table width="100%" class="tablereceipt"><tr class="tablereceipt" Style="background-color:#d8d8d8"> 
    <td align="center"  class="tablereceipt" style="width:30%;background-color:#d8d8d8" ><strong>Specification</strong></td>
    <td align="center" class="tablereceipt" style="width:30%;background-color:#d8d8d8" ><strong></strong></td>
    <td align="center" class="tablereceipt" style="width:30%;background-color:#d8d8d8" ><strong>Description</strong></td>
    </tr>
    </table>
    </td>
   </tr>
   
    <% } else {%>

   <s:elseif test="#arr.index==1">
   		<table width="100%" class="tablereceipt">
   		<tr ><td style="width:30%;" class="tablereceipt"><s:property value="#des"/>
   		</td>
   		</s:elseif>
   <s:elseif test="#arr.index==2">
   		 <td  style="width:30%;">
   		 <s:property value="#des"/>
   		 </td>
  </s:elseif>
  <s:elseif test="#arr.index==3">
   		 <td  style="width:30%;" class="tablereceipt">
   		 <s:property value="#des"/>
   		 </td></tr>
   		 </table>
  </s:elseif>
   	
  <%}%>
   
 </s:if>
 <%i++;
 %>
 </s:iterator>
 
</s:iterator>

</s:iterator>
 
</table>

</fieldset>

<%--
<br>
<hr>

 <table width="100%" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
  <tr>
    <td width="197" align="left">Tax :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttaxamt" name="txttaxamt"><s:property value="txttaxamt"/></label></b></td>
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
</table>
 --%>
 <div id="terms" hidden="true">
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
</div>
<hr>
<div id="bottompage" >
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
