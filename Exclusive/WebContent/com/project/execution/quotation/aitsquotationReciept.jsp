
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
 <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
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

.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
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
	var contrtype=document.getElementById("contrtype").value;
	
	if(contrtype=='AMC'){
		
		 $("#amc").show();
		 $("#sjob1").hide();
		 $("#sjob2").hide();
		 $("#amcid").show();
		 $("#sjobamt").hide();
		 $("#amcamt").show();
	}
	
	if(contrtype=='SJOB'){
		
		var id=document.getElementById("id").value;
		
		if(id==1){
			 $("#sjob1").show();
			 $("#sjob2").hide();
		}
		else if(id==2){
			 $("#sjob2").show();
			 $("#sjob1").hide();
		}
		
		 $("#sjobamt").show();
		 $("#amcamt").hide();
		 $("#amcid").hide();
		 $("#amc").hide();
		
		
	}
		
	var header=document.getElementById("txtheader").value;
	
	if(parseInt(header)==1){
	
		 $("#headerdiv").show();
		 //$("#withoutHeaderDiv").hide();
	}
	else{
		 $("#headerdiv").hide();
		// $("#withoutHeaderDiv").show();
	}
	
}
</script>
</head>
<body style="background-color:#fff !important;" bgcolor="white"  style="font-size:9px" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmprintQuotation" action="printQuotation" autocomplete="off" target="_blank" >

 <div id="headerdiv" style="background-color:white;" >
 </br></br></br></br></br></br></br>
    <%-- <jsp:include page="../../../common/printHeaderaits.jsp"></jsp:include>   --%>
 </div>
 <div id="withoutHeaderDiv"  style="height: 50px;" >
<br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>
<fieldset>
<table width="100%" >
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="txtclient" name="txtclient"><s:property value="txtclient"/></label></td>
    <td width="8%" align="left">Doc No </td>
    <td width="20%"> : <label name="docno" id="docno" ><s:property value="docno"/></label></td>
  </tr>
  <tr>
    <td align="left">ATTN</td>
    <td colspan="2">: <label name="txtcontact" id="txtcontact" ><s:property value="txtcontact"/></label></td>
    <!-- <td width="12%" align="left">&nbsp;</td> -->
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="date" id="date" ><s:property value="date"/></label></td>
  </tr>
  <tr>
   <td align="left">TelePhone No/Fax </td>
    <td width="18%">: <label name="txtmob" id="txtmob" ><s:property value="txtmob"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Refno </td>
    <td>: <label name="txtrefno" id="txtrefno" ><s:property value="txtrefno"/></label></td>
   </tr>
  <tr>
    <td align="left">E-Mail</td>
    <td colspan="2">: <label name="txtemail" id="txtemail" ><s:property value="txtemail"/></label></td>
    
    <td></td>
    <td align="left">Sales Agent</td>
    <td>: <label name="txtsalman" id="txtsalman" ><s:property value="txtsalman"/></label></td>
  </tr>
  <tr>
   <%-- <td align="left">Address </td>
    <td colspan="3">: <label name="txtclientdet" id="txtclientdet" ><s:property value="txtclientdet"/></label></td> --%>
    <%-- <td align="left">LegalFee </td>
    <td>: <label name="txtdcdamount" id="txtdcdamount" ><s:property value="txtdcdamount"/></label></td> --%>
  </tr>
   
</table>
</fieldset>
<br>
<hr>

<tr>

    <td align="left"><strong>Subject</strong></td>
    <td>: <label name="txtsubject" id="txtsubject" ><s:property value="txtsubject"/></label></td>
    
  </tr>
<hr>
<s:if test="%{getList().size()>0}">
<fieldset>

<table width="100%" style="border-collapse:collapse;" id="amc" border="1" >

 <tr Style="background-color:#d8d8d8" >
    <td align="center" style="width:10%;"><strong>SI No</strong></td>
    <%-- <td align="center" style="width:15%;"><strong> Site</strong></td> --%>
    <%-- <td align="center" style="width:25%;"><strong>Service Type</strong></td> --%>
    <td align="left" style="width:25%;"><strong>Description</strong></td>
    <%-- <td align="center" style="width:5%;"><strong>Unit</strong></td>
    <td align="right" style="width:5%;"><strong>Qty</strong></td> 
    <td align="right" style="width:10%;"><strong>Amount</strong></td>  --%>
    <td align="right" style="width:5%;"><strong>Rate</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.QOTLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
	<%int i=0; %>	   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0">
   		<th  align="left" colspan="7" Style="background-color:#ffebeb;text-transform:uppercase;letter-spacing:1px;">
   		<s:property value="#des"/></th>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		
   		<td align=center style="width:10%;"><s:property value="#des"/></td>
   		</s:elseif>
   		<%--  <s:elseif test="#arr.index==2">
   		 <td  align="center"><s:property value="#des"/></td>
   		</s:elseif> --%>
   		<s:elseif test="#arr.index==3">
   		<td  align="left" style="width:5%;"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <%-- <s:elseif test="#arr.index==4"> 
   		<td  align="center"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <s:elseif test="#arr.index==5"> 
   		<td  align=center><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==6"> 
   		<td  align="right"><s:property value="#des"/></td>
   		</s:elseif>  --%>
   		<s:elseif test="#arr.index==7"> 
   		<td  align="right" style="width:2%;"><s:property value="#des"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   		</s:elseif> 
   		<s:else>
  <%-- <td  align="right"><s:property value="#des"/></t --%>		
   		</s:else>
  
  
 </s:iterator>
</tr>
<%i++; %>
</s:iterator>
</s:iterator>
 
</table>

<table width="100%" style="border-collapse:collapse;" id="sjob1" border="1">

 <tr Style="background-color:#d8d8d8" >
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
    <%-- <td align="center" style="width:15%;"><strong> Site</strong></td>  --%>
   <%--  <td align="center" style="width:25%;"><strong>Service Type</strong></td> --%>
    <td align="left" style="width:25%;"><strong>Description</strong></td>
     <td align="center" style="width:5%;"><strong>Unit</strong></td>
    <td align="right" style="width:5%;"><strong>Qty</strong></td> 
    <td align="right" style="width:10%;"><strong>Unit Price</strong></td>  
    <td align="right" style="width:10%;"><strong>Rate</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.QOTLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<th  align="left" colspan="7" Style="background-color:#ffebeb;text-transform:uppercase;letter-spacing:1px;">
   		<s:property value="#des"/></th>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		
   		<td align="center" style="width:5%;"><s:property value="#des"/></td>
   		</s:elseif>
   		<%--  <s:elseif test="#arr.index==2">
   		 <td  align="center"><s:property value="#des"/></td>
   		</s:elseif> --%>
   		<s:elseif test="#arr.index==3">
   		<td  align="left" style="width:25%;"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==4"> 
   		<td  align="center"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <s:elseif test="#arr.index==5"> 
   		<td  align=right><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==6"> 
   		<td  align="right"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==7"> 
   		<td  align="right" style="width:10%;"><s:property value="#des"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   		</s:elseif> 
   		<s:else>
  <%-- <td  align="right"><s:property value="#des"/></t --%>		
   		</s:else>
  
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>


<table width="100%" style="border-collapse:collapse;" id="sjob2" border="1">

 <tr Style="background-color:#d8d8d8" >
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
    <%-- <td align="center" style="width:15%;"><strong> Site</strong></td>  --%>
   <%--  <td align="center" style="width:25%;"><strong>Service Type</strong></td> --%>
    <td align="left" style="width:25%;"><strong>Description</strong></td>
     <td align="center" style="width:5%;"><strong>Unit</strong></td>
    <td align="right" style="width:5%;"><strong>Qty</strong></td> 
    <%-- <td align="right" style="width:10%;"><strong>Unit Price</strong></td>   --%>
    <%-- <td align="right" style="width:10%;"><strong>Rate</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> --%>
  </tr>
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.QOTLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<th  align="left" colspan="7" Style="background-color:#ffebeb;text-transform:uppercase;letter-spacing:1px;">
   		<s:property value="#des"/></th>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		
   		<td align="center" style="width:5%;"><s:property value="#des"/></td>
   		</s:elseif>
   		<%--  <s:elseif test="#arr.index==2">
   		 <td  align="center"><s:property value="#des"/></td>
   		</s:elseif> --%>
   		<s:elseif test="#arr.index==3">
   		<td  align="left" style="width:25%;"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==4"> 
   		<td  align="center"><s:property value="#des"/></td>
   		</s:elseif> 
   		 <s:elseif test="#arr.index==5"> 
   		<td  align=right><s:property value="#des"/></td>
   		</s:elseif> 
   		<%-- <s:elseif test="#arr.index==6"> 
   		<td  align="right"><s:property value="#des"/></td>
   		</s:elseif> --%> 
   		<%-- <s:elseif test="#arr.index==7"> 
   		<td  align="right" style="width:10%;"><s:property value="#des"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   		</s:elseif>  --%>
   		<s:else>
  <%-- <td  align="right"><s:property value="#des"/></t --%>		
   		</s:else>
  
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>

</fieldset>
</s:if>
<br>


<table width="100%" id="sjobamt" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
  <%-- <tr>
    <td width="197" align="left">Tax :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttaxamt" name="txttaxamt"><s:property value="txttaxamt"/></label></b></td>
  </tr> --%>
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


<table width="100%"  id="amcamt">
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
  <%-- <tr>
    <td width="197" align="left">Tax :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttaxamt" name="txttaxamt"><s:property value="txttaxamt"/></label></b></td>
  </tr> --%>
  <%-- <tr>
    <td width="197" align="left">Discount :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txtdisamt" name="txtdisamt"><s:property value="txtdisamt"/></label></b></td>
  </tr>
  <tr> --%>
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


<br>

<table width="100%" style="border-collapse:collapse;border-radius:25px;" id="amcid" border="1">
 <tr><td colspan="4"><p>PPM Frequency for Fire Alarm System & Firefighting System</p></td></tr>
 <tr Style="background-color:#d8d8d8" >
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
     <td align="left" style="width:25%;"><strong>System</strong></td> 
    <td align="center" style="width:25%;"><strong>Maintanance Frequency </strong></td>
    <td align="center" style="width:10%;"><strong>Yearly Visits</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr> 
 <s:iterator var="stat1" status="arr" value='#request.AMCLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr >   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		 <td  align="center" style="width:5%;"><s:property value="#des"/></td>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<td align="left" style="width:25%;"><s:property value="#des"/></td>
   		</s:elseif>
   		 <s:elseif test="#arr.index==2">
   		 <td  align="center" style="width:25%;"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:elseif test="#arr.index==3">
   		<td  align="center" style="width:10%;"><s:property value="#des"/></td>
   		</s:elseif> 
   		<s:else>	
   		</s:else>
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>
<br>

<s:if test="%{getTermlist().size()>0}">
<br>
<!-- <fieldset> -->
<table width="100%">
 <tr>
  <%--   <td align="left" style="width:20%;"><strong>Terms & Conditions</strong></td>
   --%>
  <s:set var="temp" value="1"></s:set>
  

 
 <s:iterator var="stat1" status="arr" value='#request.TERMLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr>   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<th width="10%" align="left" ><s:property value="#des"/></th>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		<td align="left"><s:property value="#des"/></td>
   		</s:elseif>
   		<s:else>
  <td  align="left"><s:property value="#des"/></td> 		
   		</s:else>
  
  
  <%-- <s:property value="#des"/>

  </td> --%>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>

</table>
<!-- </fieldset> -->
</s:if>
<br>
<!-- <fieldset> -->
<table>
<tr>
 <td><br>For further technical feel free to contact our Assistant Manager Mr.Nayana Ravi (Mobile: 971 55 22 36308)</td></tr>
  <tr><td><p>We trust that the above prices are reasonable and awaiting for your kind confirmation </p> </td></tr>
   <tr><td><p>Thanking You,</td></tr>
  <tr><td><b><label name="lblcompname" id="lblcompname" ><s:property value="lblcompname"/></label></b></td></tr>
<tr><td><p><label name="txtsalman" id="txtsalman" ><s:property value="txtsalman"/></label>&nbsp;&nbsp;&nbsp;(<label name="txtsalmob" id="txtsalmob" ><s:property value="txtsalmob"/></label>)<%--</p>Business Development Manager</td></tr> --%>

</table>
<!-- </fieldset> -->


<div id="bottompage">
<table width="100%" >
  <%-- <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Recieved By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="13%"></td>
    <td width="29%"></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr> --%>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/>
<div class="divFooter">
 
<table width="100%">
 <!-- <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr> -->
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
<table width="100%" class="normaltable" >
  <tr>
    <%-- <td  rowspan="6"><img src="<%=contextPath%>/icons/printfooter.jpg" width="777" height="91"  alt=""/></td> --%>
    </tr>
    </table></div>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
<input type="hidden" id="contrtype" name="contrtype" value='<s:property value="contrtype"/>'>
<input type="hidden" id="id" name="id" value='<s:property value="id"/>'>

</div>
</form>

 <s:set name="counter" value="%{#counter+1}" />

</div>
</body>
</html>
